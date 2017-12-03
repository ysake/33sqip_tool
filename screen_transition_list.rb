require 'yaml'

yaml = YAML.load_file(ARGV[0])

yaml.each do |e|
  screen = e["screen"]
  screen["ui_parts"].each do |uip_e|
    if next_transition = uip_e["next"] then
      puts "#{screen["name"]} => #{next_transition}"
    end
    if actions = uip_e["actions"] then
      actions.each do |acts_e|
        if next_transition = acts_e["next"] then
          puts "#{screen["name"]} => #{next_transition}"
        end
      end
    end
  end
end
