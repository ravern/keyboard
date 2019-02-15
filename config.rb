keyboard title: "Custom mappings with layers" do
  layer desc: "Basic typing and most punctuation" do
    mapping do
      from keys: ["a", "s"]
      to mode: 1
    end

    mapping do
      from keys: ["d", "f"]
      to mode: [1, :once]
    end
  end

  layer desc: "Numbers and some additional punctutation" do
    mapping do
      from keys: ["a", "s"]
      to mode: 0
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
      ["o", "8"],
      ["p", "0"],
    ].each do |pair|
      mapping do
        from key: pair[0]
        to key: pair[1]
      end
    end
  end
end
