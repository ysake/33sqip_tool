require 'yaml'

yaml = YAML.load_file(ARGV[0])

yaml.each do |e|
  puts "#{e["screen"]["name"]}"
end
