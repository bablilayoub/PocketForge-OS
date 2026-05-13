#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "set"
require "yaml"

ROOT = File.expand_path("..", __dir__)

def load_schema(path)
  JSON.parse(File.read(path))
end

def load_yaml(path)
  YAML.safe_load(File.read(path), permitted_classes: [], aliases: false)
end

def type_valid?(value, type)
  case type
  when "object" then value.is_a?(Hash)
  when "array" then value.is_a?(Array)
  when "string" then value.is_a?(String)
  when "integer" then value.is_a?(Integer)
  when "boolean" then value == true || value == false
  else true
  end
end

def validate_value(value, schema, path, errors)
  expected_type = schema["type"]
  errors << "#{path}: expected #{expected_type}" if expected_type && !type_valid?(value, expected_type)
  return errors if expected_type && !type_valid?(value, expected_type)

  if schema["enum"] && !schema["enum"].include?(value)
    errors << "#{path}: expected one of #{schema["enum"].join(", ")}"
  end

  if value.is_a?(String)
    errors << "#{path}: must not be empty" if schema["minLength"] && value.length < schema["minLength"]
    errors << "#{path}: does not match #{schema["pattern"]}" if schema["pattern"] && !value.match?(Regexp.new(schema["pattern"]))
  end

  if value.is_a?(Integer) && schema["minimum"] && value < schema["minimum"]
    errors << "#{path}: must be >= #{schema["minimum"]}"
  end

  if value.is_a?(Array)
    errors << "#{path}: must contain at least #{schema["minItems"]} item(s)" if schema["minItems"] && value.length < schema["minItems"]
    errors << "#{path}: must contain unique items" if schema["uniqueItems"] && value.length != value.to_set.length
    value.each_with_index { |item, index| validate_value(item, schema["items"], "#{path}[#{index}]", errors) } if schema["items"]
  end

  validate_object(value, schema, path, errors) if value.is_a?(Hash)
  errors
end

def validate_object(value, schema, path, errors)
  required = schema.fetch("required", [])
  required.each do |key|
    errors << "#{path}.#{key}: is required" unless value.key?(key)
  end

  min_properties = schema["minProperties"]
  errors << "#{path}: must contain at least #{min_properties} properties" if min_properties && value.length < min_properties

  properties = schema.fetch("properties", {})
  additional = schema.fetch("additionalProperties", true)

  value.each do |key, child|
    child_path = path == "$" ? "$.#{key}" : "#{path}.#{key}"
    if properties.key?(key)
      validate_value(child, properties[key], child_path, errors)
    elsif additional.is_a?(Hash)
      validate_value(child, additional, child_path, errors)
    elsif additional == false
      errors << "#{child_path}: unknown property"
    end
  end
end

def validate_profiles(kind, directory)
  schema_path = File.join(ROOT, "shared", directory, "schema.json")
  schema = load_schema(schema_path)
  files = Dir.glob(File.join(ROOT, "shared", directory, "*.yml")).sort

  raise "#{kind}: no profile files found" if files.empty?

  ids = Set.new
  failures = []

  files.each do |file|
    data = load_yaml(file)
    errors = validate_value(data, schema, "$", [])
    profile_id = data.is_a?(Hash) ? data["id"] : nil

    if profile_id && ids.include?(profile_id)
      errors << "$.id: duplicate profile id #{profile_id}"
    end
    ids << profile_id if profile_id

    if errors.empty?
      puts "OK: #{file.delete_prefix("#{ROOT}/")}"
    else
      failures << [file, errors]
    end
  rescue Psych::Exception, JSON::ParserError => e
    failures << [file, [e.message]]
  end

  return if failures.empty?

  failures.each do |file, errors|
    warn "FAILED: #{file.delete_prefix("#{ROOT}/")}"
    errors.each { |error| warn "  - #{error}" }
  end
  raise "#{kind}: validation failed"
end

validate_profiles("device profiles", "device-profiles")
validate_profiles("performance profiles", "performance-profiles")
