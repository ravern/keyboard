keyboard do
  layer :normal, desc: "Basic typing and most punctuation" do
    mapping do
      from key: ['a', 's']
      to mode: :numbers
    end
    
    mapping do
      from key: ['d', 'f']
      to mode: [:numbers, :once]
    end
  end

  layer :numbers, desc: "Numbers and some additional punctutation" do
    mapping do
      from key: ['a', 's']
      to mode: :normal
    end

    [
      ['q', '1'],
      ['w', '2'],
      ['e', '3'],
      ['r', '4'],
      ['t', '5'],
      ['y', '6'],
      ['u', '7'],
      ['i', '8'],
      ['o', '8'],
      ['p', '0'],
    ].each do |pair|
      mapping do
        from key: pair[0]
        to key: pair[1]
      end
    end
  end
end
