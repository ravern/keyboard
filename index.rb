class Mapping
  def from(from = {})
    @from = from
  end

  def to(to = {})
    @to = to
  end

  def build(layer, once)
    {
      type: "basic",
      from: build_from,
      conditions: build_conditions(layer, once),
      to: build_to + if once == 1
        [
          {
            set_variable: {
              name: "layer",
              value: 0,
            },
          },
          {
            set_variable: {
              name: "once",
              value: 0,
            },
          },
        ]
      else
        []
      end,
    }
  end

  private

  def build_from
    if @from[:key]
      build_from_key(@from[:key])
    elsif @from[:keys]
      { simultaneous: @from[:keys].map { |key| build_from_key(key) } }
    end
  end

  def build_from_key(key)
    if key.kind_of?(Array)
      {
        key_code: key[1],
        modifiers: { mandatory: build_from_key_mods(key[0]) },
      }
    else
      {
        key_code: key,
        modifiers: { optional: ["any"] },
      }
    end
  end

  def build_from_key_mods(mods)
    if mods.kind_of?(Array)
      mods
    else
      [mods]
    end
  end

  def build_conditions(layer, once)
    [
      {
        type: "variable_if",
        name: "layer",
        value: layer,
      },
      {
        type: "variable_if",
        name: "once",
        value: once,
      },
    ]
  end

  def build_to
    if @to[:key]
      [build_to_key(@to[:key])]
    elsif @to[:keys]
      @to[:keys].map { |key| build_to_key(key) }
    elsif @to[:layer]
      build_to_layer(@to[:layer])
    end
  end

  def build_to_key(key)
    if key.kind_of?(Array)
      {
        key_code: key[1],
        modifiers: build_to_key_mods(key[0]),
      }
    else
      {
        key_code: key,
        modifiers: [],
      }
    end
  end

  def build_to_key_mods(mods)
    if mods.kind_of?(Array)
      mods
    else
      [mods]
    end
  end

  def build_to_layer(layer)
    if layer.kind_of?(Array)
      if layer[1] == :once
        [
          {
            set_variable: {
              name: "layer",
              value: layer[0],
            },
          },
          {
            set_variable: {
              name: "once",
              value: 1,
            },
          },
        ]
      else
        raise ArgumentError()
      end
    else
      [{
        set_variable: {
          name: "layer",
          value: layer,
        },
      }]
    end
  end
end

class Layer
  attr_accessor :desc

  def initialize
    @mappings = []
  end

  def mapping(desc: nil, &block)
    mapping = Mapping.new
    mapping.instance_eval(&block)

    @mappings << mapping

    mapping
  end

  def build(layer)
    {
      description: @desc,
      manipulators: @mappings.map do |mapping|
        [mapping.build(layer, 0), mapping.build(layer, 1)]
      end.flatten,
    }
  end
end

class Keyboard
  attr_accessor :title

  def initialize
    @layers = []
  end

  def layer(desc: nil, &block)
    layer = Layer.new
    layer.desc = desc || "Custom layer"
    layer.instance_eval(&block)

    @layers << layer

    layer
  end

  def build
    {
      title: @title,
      rules: @layers.each_with_index.map do |layer, i|
        layer.build(i)
      end + [RESET_LAYER],
    }
  end
end

KEYBOARD = Keyboard.new

RESET_LAYER = {
  description: "Reset to normal",
  manipulators: [
    {
      type: "basic",
      from: {
        key_code: "r",
        modifiers: {
          mandatory: [
            "left_command",
            "left_option",
          ],
        },
      },
      to: [
        {
          set_variable: {
            name: "layer",
            value: 0,
          },
        },
        {
          set_variable: {
            name: "once",
            value: 0,
          },
        },
      ],
    },
  ],
}

def keyboard(title: nil, &block)
  KEYBOARD.title = title || "Custom rules"
  KEYBOARD.instance_eval(&block)
end

require "./config"
require "json"

DEFAULT_PATH = ENV["HOME"] + "/.config/karabiner/assets/complex_modifications/custom.json"

path = ARGV[0] || DEFAULT_PATH
File.open(path, "w") do |f|
  f.puts KEYBOARD.build.to_json
end
