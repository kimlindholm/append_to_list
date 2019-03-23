defmodule Example do
  @moduledoc """
  Example of `Enum.reduce/3` vs. list comprehensions when pushing
  maps to a list.
  """

  @doc """
  Build given number of activities and append to a list.

  ## Examples

      iex> Example.build_activities([], 2)
      [%{state: :ok}, %{state: :ok}]

      iex> Example.build_activities([%{state: :error}], 2)
      [%{state: :error}, %{state: :ok}, %{state: :ok}]

      iex> Example.build_activities([], 0)
      []

  """
  @spec build_activities(list(map), 0) :: list(map)
  @spec build_activities(list(map), neg_integer()) :: list(map)
  def build_activities(activities, count) when count < 1, do: activities

  @spec build_activities(list(map), pos_integer()) :: [map, ...]
  def build_activities(activities, count) do
    Enum.reduce(1..count, activities, fn _, acc ->
      acc ++ [build_success_activity()]
    end)
  end

  @doc """
  Build given number of activities.

  ## Examples

      iex> Example.build_activities(3)
      [%{state: :ok}, %{state: :ok}, %{state: :ok}]

      iex> Example.build_activities(0)
      []

  """
  @spec build_activities(0) :: []
  @spec build_activities(neg_integer()) :: []
  def build_activities(count) when count < 1, do: []

  @spec build_activities(pos_integer()) :: [map, ...]
  def build_activities(count) do
    activities = []

    for _i <- 1..count do
      activities ++ build_success_activity()
    end
  end

  @doc """
  Version of `build_activities/2` that didn't quite work.

  ## Here's Why

      iex> activities = []
      iex> for _i <- 1..2, do: activities ++ %{state: :ok}
      [%{state: :ok}, %{state: :ok}]

      iex> activities = [%{state: :error}]
      iex> for _i <- 1..2, do: activities ++ %{state: :ok}
      [[%{state: :error} | %{state: :ok}], [%{state: :error} | %{state: :ok}]]

      iex> activities = [%{state: :error}]
      iex> for _i <- 1..2, do: activities ++ [%{state: :ok}]
      [[%{state: :error}, %{state: :ok}], [%{state: :error}, %{state: :ok}]]

  ## Examples

      # Works with an empty list:
      iex> Example.failing_build_activities([], 2)
      [%{state: :ok}, %{state: :ok}]

      # Doesn't work with a prefilled list:
      iex> Example.failing_build_activities([%{state: :error}], 2)
      [[%{state: :error} | %{state: :ok}], [%{state: :error} | %{state: :ok}]]

  """
  def failing_build_activities(activities, count) do
    for _i <- 1..count do
      activities ++ build_success_activity()
    end
  end

  defp build_success_activity do
    %{state: :ok}
  end
end
