defmodule ExMon.Trainer.Pokemon.Update do
  alias ExMon.{Repo, Trainer.Pokemon}
  alias Ecto.UUID

  def call(%{"id" => uuid} = params) do
    case UUID.cast(uuid) do
      :error -> {:error, "Invalid UUID format bro"}
      {:ok, _uuid} -> update(params)
    end
  end

  defp update(%{"id" => uuid} = params) do
    case Repo.get(Pokemon, uuid) do
      :nil -> {:error, "Pokemon not found!!"}
      trainer -> update_pokemon(trainer, params)
    end
  end

  defp update_pokemon(pokemon, params) do
    pokemon
    |> Pokemon.update_changeset(params)
    |> Repo.update()
  end
end
