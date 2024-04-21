defmodule Hangman do

  alias Hangman.Impl.Game # Can have a 'as, Game' but Elixir automagically takes the last part of the module name if we leave it off.

  @opaque game :: Game.t # makes the type "private" that only allows this module to use this type

  @spec new_game() :: game
  defdelegate new_game, to: Game # instead of writing out a function here this pulls it from a different module

  @spec make_move(Game.t, String.t) :: Game.t
  defdelegate make_move(game, guess), to: Game

  @spec tally(game) :: Type.tally
  defdelegate tally(game), to: Game
end
