require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'

Rake::Task[:lint].clear
PuppetLint::RakeTask.new :lint do |config|
  config.pattern = ['manifests/*.pp', 'manifests/**/*.pp']
  config.disable_checks = [ '80chars', 'selector_inside_resource', 'documentation' ]
  config.with_filename = true
  config.with_context = true
  config.fail_on_warnings = true
end

Rake::Task[:spec_standalone].clear
RSpec::Core::RakeTask.new(:spec_standalone) do |t|
  t.rspec_opts = ['--color']
  t.exclude_pattern = 'spec/fixtures/**/*'
  t.pattern = 'spec/**/*_spec.rb'
end

PuppetSyntax.exclude_paths = ["vendor/**/*", "gemfiles/vendor/**/*", "spec/fixtures/modules/**/*"]
