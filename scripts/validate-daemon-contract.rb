#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "open3"

ROOT = File.expand_path("..", __dir__)
$LOAD_PATH.unshift(File.join(ROOT, "scripts", "lib"))

require "pocketforge/schema_validator"

schema = JSON.parse(File.read(File.join(ROOT, "shared", "api", "daemon-inventory.schema.json")))

env = {
  "POCKETFORGE_DEVICE_PROFILE_DIR" => File.join(ROOT, "shared", "device-profiles"),
  "POCKETFORGE_PERFORMANCE_PROFILE_DIR" => File.join(ROOT, "shared", "performance-profiles")
}

stdout, stderr, status = Open3.capture3(env, File.join(ROOT, "scripts", "pocketforge-daemon"), "--json")

unless status.success?
  warn stderr
  raise "pocketforge-daemon --json failed"
end

inventory = JSON.parse(stdout)
errors = PocketForge::SchemaValidator.validate(inventory, schema)

if errors.empty?
  puts "OK: pocketforge-daemon --json matches shared/api/daemon-inventory.schema.json"
else
  warn "FAILED: pocketforge-daemon --json contract"
  errors.each { |error| warn "  - #{error}" }
  exit 1
end
