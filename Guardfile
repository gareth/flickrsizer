guard 'rspec', :version => 2 do
  watch('app.rb')
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec')       { "spec" }
  watch('spec/spec_helper.rb')  { "spec" }
end

guard :bundler do
  watch('Gemfile')
end