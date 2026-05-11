defmodule Abot.Commands.Quiz do

  def handle_quiz(msg) do
    dados = msg.content |> String.trim() |> String.split(" ")
    questions = Abot.Store.load()

    case dados do
      ["!quiz"] -> get_quiz(questions)
      ["!quiz", "feitos"] -> show(questions)

      _ -> "Comando inválido."
    end
  end

  defp get_quiz(questions) do
    {:ok, response} = HTTPoison.get("https://opentdb.com/api.php?amount=1&type=boolean")

    cond do
      String.contains?(response.body, "erro") -> "Erro ao pegar pergunta."
      true ->
        {:ok, json} = Jason.decode(response.body)
        pergunta = json["results"] |> List.first()

        question = %{
          categoria: pergunta["category"],
          question: pergunta["question"],
          correct_answer: pergunta["correct_answer"],
          difficulty: pergunta["difficulty"]
        }

        Abot.Store.save(questions ++ [question])
        """
          Categoria: #{question.categoria}

          #{question.question}

          True
          False

          Dificuldade: #{question.difficulty}
          Resposta: #{question.correct_answer}

          Para ver as perguntas ja feitas digite o comando !quiz feitos.
        """
    end
  end

  defp show(questions) do
    if Enum.empty?(questions) do
      "Nenhuma questão salva"
    else
      questions
      |> Enum.map(fn q -> "Questão: #{q.question} \nDificuldade: #{q.difficulty} \nResposta: #{q.correct_answer}"  end)
      |> Enum.join("\n-----------------\n")
    end
  end
end
