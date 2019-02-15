class Mapping
  attr_accessor :desc
end

class Layer
  attr_accessor :name
  attr_accessor :title

  def initialize
    @mappings = []
  end

  def mapping(desc: nil, &block)
    mapping = Mapping.new
    mapping.desc = desc
    mapping.instance_eval(&block)

    @mappings << mapping

    mapping
  end

  def build
    {
      title: @title,
      rules: @mappings.map { |mapping| mapping.build(self) },
    }
  end
end

class Keyboard
  def initialize
    @layers = []
  end

  def layer(name, title: nil, &block)
    layer = Layer.new
    layer.name = name.to_s
    layer.title = title || name.to_s
    layer.instance_eval(&block)

    @layers << layer

    layer
  end

  def build
    @layers.map do |layer|
      layer.build
    end
  end
end

KEYBOARD = Keyboard.new

def keyboard(&block)
  KEYBOARD.instance_eval(&block)
end

require './config'

DEFAULT_PATH = '~/.config/karabiner/assets/complex_modifications/'

KEYBOARD.build.each do |layer|
  path = (ARGS[0] || DEFAULT_PATH) + layer.title
  File.open(path, 'w') do |f|
    f.puts layer.to_json
  end
end
