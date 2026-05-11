defmodule Abot.Store do

  @file_path "perguntas.json"

  def load() do
    case File.read(@file_path) do
      {:ok, content} -> content |> Jason.decode!()
        |> Enum.map(fn t -> %{categoria: t["category"], question: t["question"], correct_answer: t["correct_answer"], incorrect_answers: t["incorrect_answers"], difficulty: t["difficulty"]} end)
      {:error, _} -> []
    end

  end

  def save(questions) do
    questions |> Jason.encode!(pretty: true) |> then(&File.write!(@file_path, &1))
  end

end
