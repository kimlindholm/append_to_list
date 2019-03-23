defmodule Example do
  @moduledoc """
  Example of `Enum.reduce/3` vs. list comprehensions when pushing
  maps to a list.
  """

  @doc """
  Build given number of activities.

  ## Examples

      iex> Example.build_activities(3)
      [%{state: :ok}, %{state: :ok}, %{state: :ok}]

      iex> Example.build_activities(0)
      []

  """
  def build_activities(count) when count < 1, do: []

  def build_activities(count) do
    activities = []

    for _i <- 1..count do
      activities ++ build_success_activity()
    end
  end

  defp build_success_activity do
    %{state: :ok}
  end
end
