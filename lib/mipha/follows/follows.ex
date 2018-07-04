defmodule Mipha.Follows do
  @moduledoc """
  The Follows context.
  """

  import Ecto.Query, warn: false
  alias Mipha.Repo

  alias Mipha.Follows.Follow

  @doc """
  Returns the list of follows.

  ## Examples

      iex> list_follows()
      [%Follow{}, ...]

  """
  def list_follows do
    Repo.all(Follow)
  end

  @doc """
  Gets a single follow.

  Raises `Ecto.NoResultsError` if the Follow does not exist.

  ## Examples

      iex> get_follow!(123)
      %Follow{}

      iex> get_follow!(456)
      ** (Ecto.NoResultsError)

  """
  def get_follow!(id), do: Repo.get!(Follow, id)

  @doc """
  Creates a follow.

  ## Examples

      iex> create_follow(%{field: value})
      {:ok, %Follow{}}

      iex> create_follow(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_follow(attrs \\ %{}) do
    %Follow{}
    |> Follow.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a follow.

  ## Examples

      iex> update_follow(follow, %{field: new_value})
      {:ok, %Follow{}}

      iex> update_follow(follow, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_follow(%Follow{} = follow, attrs) do
    follow
    |> Follow.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Follow.

  ## Examples

      iex> delete_follow(follow)
      {:ok, %Follow{}}

      iex> delete_follow(follow)
      {:error, %Ecto.Changeset{}}

  """
  def delete_follow(%Follow{} = follow) do
    Repo.delete(follow)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking follow changes.

  ## Examples

      iex> change_follow(follow)
      %Ecto.Changeset{source: %Follow{}}

  """
  def change_follow(%Follow{} = follow) do
    Follow.changeset(follow, %{})
  end

  @doc """
  Filter the list of topics.

  ## Examples

      iex> cond_follows()
      Ecto.Query.t()

      iex> cond_follows(user: %User{})
      Ecto.Query.t()

      iex> cond_follows(follower: %User{})
      Ecto.Query.t()

  """
  @spec cond_follows(Keyword.t()) :: Ecto.Query.t()
  def cond_follows(opts \\ []) do
    opts
    |> filter_from_clauses
    |> preload([:user, :follower])
  end

  defp filter_from_clauses(opts) do
    cond do
      Keyword.has_key?(opts, :follower) -> opts |> Keyword.get(:follower) |> Follow.by_follower
      Keyword.has_key?(opts, :user) -> opts |> Keyword.get(:user) |> Follow.by_user
      true -> Follow
    end
  end
end
