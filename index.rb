class Mapping
end

class Layer
end

class Keyboard
end

KEYBOARD = Keyboard.new

def keyboard(&block)
  KEYBOARD.instance_eval(&block)
end

require './config'

DEFAULT_PATH = '~/.config/karabiner/assets/complex_modifications/custom.json'

File.open(ARGS[0] | DEFAULT_PATH, 'w') do |f|
  f.puts KEYBOARD.build.to_json
end