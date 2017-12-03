require 'yaml'

yaml = YAML.load_file(ARGV[0])

yaml.each do |e|
  p e["screen"]["name"]
end
