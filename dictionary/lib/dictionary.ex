defmodule Dictionary do

  @word_list "assets/words.txt"
    |> File.read!()
    |> String.split(~r/\n/, trim: true)

  def random_word do
    @word_list
    |> Enum.random()
  end

  def len([]),       do: 0
  def len([_h | t]), do: 1 + len(t)

  def sum([]),        do: 0
  def sum([ h | t ]), do: h + sum(t)

  def sum_pairs([]), do: []
  def sum_pairs([h1 | []]), do: [h1]
  def sum_pairs([h1, h2 | tail]), do: [h1 + h2 | sum_pairs(tail)]

  def even_length?([]), do: true
  def even_length?([_h | []]), do: false
  def even_length?([_h1, _h2 | tail]), do: even_length?(tail)
end
