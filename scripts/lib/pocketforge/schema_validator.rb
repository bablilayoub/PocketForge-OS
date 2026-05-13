# frozen_string_literal: true

require "set"

module PocketForge
  module SchemaValidator
    module_function

    def validate(value, schema, path = "$", errors = [])
      expected_type = schema["type"]
      errors << "#{path}: expected #{expected_type}" if expected_type && !type_valid?(value, expected_type)
      return errors if expected_type && !type_valid?(value, expected_type)

      if schema["enum"] && !schema["enum"].include?(value)
        errors << "#{path}: expected one of #{schema["enum"].join(", ")}"
      end

      validate_string(value, schema, path, errors) if value.is_a?(String)
      validate_integer(value, schema, path, errors) if value.is_a?(Integer)
      validate_array(value, schema, path, errors) if value.is_a?(Array)
      validate_object(value, schema, path, errors) if value.is_a?(Hash)
      errors
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

    def validate_string(value, schema, path, errors)
      errors << "#{path}: must not be empty" if schema["minLength"] && value.length < schema["minLength"]
      return unless schema["pattern"] && !value.match?(Regexp.new(schema["pattern"]))

      errors << "#{path}: does not match #{schema["pattern"]}"
    end

    def validate_integer(value, schema, path, errors)
      return unless schema["minimum"] && value < schema["minimum"]

      errors << "#{path}: must be >= #{schema["minimum"]}"
    end

    def validate_array(value, schema, path, errors)
      min_items = schema["minItems"]
      errors << "#{path}: must contain at least #{min_items} item(s)" if min_items && value.length < min_items
      errors << "#{path}: must contain unique items" if schema["uniqueItems"] && value.length != value.to_set.length
      value.each_with_index { |item, index| validate(item, schema["items"], "#{path}[#{index}]", errors) } if schema["items"]
    end

    def validate_object(value, schema, path, errors)
      schema.fetch("required", []).each do |key|
        errors << "#{path}.#{key}: is required" unless value.key?(key)
      end

      min_properties = schema["minProperties"]
      errors << "#{path}: must contain at least #{min_properties} properties" if min_properties && value.length < min_properties

      properties = schema.fetch("properties", {})
      additional = schema.fetch("additionalProperties", true)

      value.each do |key, child|
        child_path = path == "$" ? "$.#{key}" : "#{path}.#{key}"
        if properties.key?(key)
          validate(child, properties[key], child_path, errors)
        elsif additional.is_a?(Hash)
          validate(child, additional, child_path, errors)
        elsif additional == false
          errors << "#{child_path}: unknown property"
        end
      end
    end
  end
end
