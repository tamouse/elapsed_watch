# -*- mode: ruby -*-
guard 'cucumber', :cli => '--color --format pretty' do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})          { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
  watch('bin/elapsed_watch') { 'features' }
end

guard :rspec, :cmd => 'bundle exec rspec --color --format documentation', all_on_start: true do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end


guard 'bundler' do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end


