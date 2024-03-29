keyboard title: "Custom mappings with layers" do
  layer desc: "Basic typing and most punctuation" do
    mapping do
      from keys: ["s", "d", "f"]
      to layer: 1
    end

    mapping do
      from keys: ["w", "e", "r"]
      to layer: [1, :once]
    end

    mapping do
      from keys: ["j", "k", "l"]
      to layer: 2
    end

    mapping do
      from keys: ["u", "i", "o"]
      to layer: [2, :once]
    end

    mapping do
      from keys: ["z", "x"]
      to key: "d"
    end
  end

  layer desc: "Numbers and some additional punctutation" do
    mapping do
      from keys: ["s", "d", "f"]
      to layer: 0
    end

    [
      ["q", "1"],
      ["w", "2"],
      ["e", "3"],
      ["r", "4"],
      ["t", "5"],
      ["y", "6"],
      ["u", "7"],
      ["i", "8"],
      ["o", "9"],
      ["p", "0"],
      ["a", "grave_accent_and_tilde"],
      ["s", "vk_none"],
      ["d", "vk_none"],
      ["f", "vk_none"],
      ["g", "vk_none"],
      ["h", "left_arrow"],
      ["j", "down_arrow"],
      ["k", "up_arrow"],
      ["l", "right_arrow"],
      ["z", "vk_none"],
      ["x", "vk_none"],
      ["c", "vk_none"],
      ["v", "vk_none"],
      ["b", "vk_none"],
      ["n", "vk_none"],
      ["m", "vk_none"],
      ["open_bracket", "hyphen"],
      ["close_bracket", "equal_sign"],
      ["semicolon", "backslash"],
      ["quote", "delete_or_backspace"],
      ["spacebar", "escape"],
    ].each do |pair|
      mapping do
        from key: pair[0]
        to key: pair[1]
      end
    end
  end

  layer desc: "Utilities like changing desktop, etc." do
    mapping do
      from keys: ["j", "k", "l"]
      to layer: 0
    end

    [
      ["q", ["left_control", "1"]],
      ["w", ["left_control", "2"]],
      ["e", ["left_control", "3"]],
      ["r", ["left_control", "4"]],
      ["t", ["left_control", "5"]],
      ["y", ["left_control", "6"]],
      ["u", ["left_control", "7"]],
      ["i", ["left_control", "8"]],
      ["o", ["left_control", "9"]],
      ["p", ["left_control", "0"]],
      ["a", "mission_control"],
      ["s", "f11"],
      ["d", "mute"],
      ["f", "volume_decrement"],
      ["g", "volume_increment"],
      ["h", "vk_none"],
      ["j", "vk_none"],
      ["k", "vk_none"],
      ["l", "vk_none"],
      ["z", ["left_control", "left_arrow"]],
      ["x", ["left_control", "right_arrow"]],
      ["c", "vk_none"],
      ["v", "vk_none"],
      ["b", "vk_none"],
      ["n", "vk_none"],
      ["m", "vk_none"],
    ].each do |pair|
      mapping do
        from key: pair[0]
        to key: pair[1]
      end
    end
  end
end
