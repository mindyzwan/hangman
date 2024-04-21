defmodule TextClient.Impl.Player do

  @type game :: Hangman.game
  @type tally :: Hangman.tally
  @type state :: { game, tally }

  @spec start() :: :ok
  def start() do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    interact({ game, tally })
  end

  @spec interact(state) :: :ok
  def interact({_game, _tally = %{ game_state: :won }}) do
    IO.puts "Congratulations, you won!"
  end

  def interact({_game, tally = %{ game_state: :won }}) do
    IO.puts "Sorry, you lost! The word was #{tally.letters |> Enum.join}"
  end

  def interact({ game, tally }) do
    IO.puts feedback_for(tally)
    IO.puts current_word(tally)
    Hangman.make_move(game, get_guess())
    |> interact()
  end

  @spec feedback_for(tally) :: String.t
  def feedback_for(tally = %{ game_state: :initializing }) do
    "Welcome! I'm thinking of a #{tally.letters |> length} letter word."
  end

  def feedback_for(_tally = %{ game_state: :good_guess }), do: "Good guess!"

  def feedback_for(_tally = %{ game_state: :bad_guess }), do: "Woops, try again!"

  def feedback_for(_tally = %{ game_state: :already_used }), do: "You've already guessed that one!"

  def feedback_for(_tally = %{ game_state: :invalid_guess }), do: "Invalid guess! Your guess must be a single, lowercase letter character."

  def current_word(tally) do
    [
        "Word so far: ", tally.letters |> Enum.join(" "),
      "    turns left: ", tally.turns_left |> to_string,
      "    used so far: ", tally.used |> Enum.join(", ")
    ]
  end

  def get_guess() do
    IO.gets("Next guess: ")
    |> String.trim()
    |> String.downcase()
  end
end
