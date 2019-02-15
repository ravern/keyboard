keyboard title: "Custom mappings with layers" do
  layer desc: "Basic typing and most punctuation" do
    mapping do
      from keys: ["a", "s"]
      to layer: 1
    end

    mapping do
      from keys: ["d", "f"]
      to layer: [1, :once]
    end

    # Temporary to learn backspace.
    mapping do
      from key: ["left_control", "h"]
      to layer: 0
    end
  end

  layer desc: "Numbers and some additional punctutation" do
    mapping do
      from keys: ["a", "s"]
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
      ["open_bracket", "hyphen"],
      ["close_bracket", "equal_sign"],
      ["h", "left_arrow"],
      ["j", "down_arrow"],
      ["k", "up_arrow"],
      ["l", "right_arrow"],
      ["semicolon", "backslash"],
      ["quote", "delete_or_backspace"],
    ].each do |pair|
      mapping do
        from key: pair[0]
        to key: pair[1]
      end
    end

    # Temporary to learn backspace.
    mapping do
      from key: ["left_control", "h"]
      to layer: 1
    end
  end
end
