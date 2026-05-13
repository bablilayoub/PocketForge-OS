#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "set"
require "yaml"

ROOT = File.expand_path("..", __dir__)
$LOAD_PATH.unshift(File.join(ROOT, "scripts", "lib"))

require "pocketforge/schema_validator"

def load_schema(path)
  JSON.parse(File.read(path))
end

def load_yaml(path)
  YAML.safe_load(File.read(path), permitted_classes: [], aliases: false)
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
    errors = PocketForge::SchemaValidator.validate(data, schema)
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
