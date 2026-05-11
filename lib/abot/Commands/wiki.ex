defmodule Abot.Commands.Wiki do
  def handle_wiki(msg) do
    dados = msg.content |> String.trim() |> String.split(" ")

    case dados do
      ["!wiki"] -> "Use o comando completo, colocando o nome do assunto após a chamada. Dessa forma: !wiki matemática. Obs: Escreva o nome do conteúdo corretamente, com assentos "
      ["!wiki", tema] -> get_wiki(tema)
      _ -> "Comando inválido."

    end

  end
  defp get_wiki(tema) do
    {:ok, response} = HTTPoison.get("https://pt.wikipedia.org/api/rest_v1/page/summary/#{tema}")
    cond do
    String.contains?(response.body, "erro") -> "Tema não encontrado. Verifique a sintaxe e tente novamente. Caso o erro continue, talvez não exista paginas relacionadas a esse tema na Wiki"
    true ->
      {:ok, json} = Jason.decode(response.body)
      resumo = json["extract"]
      "Resumo do tema solicitado: #{resumo}"

    end
  end
end
