defmodule Abot.Commands.Quote do

  def handle_quote(msg) do
    dados = msg.content |> String.trim() |> String.split(" ")

    case dados do
      ["!frase"] -> get_quote()
      _ -> "Comando inválido."
    end
  end

  defp get_quote() do
    {:ok, response} = HTTPoison.get("https://zenquotes.io/api/random")

    cond do
      String.contains?(response.body, "erro") -> "Erro ao buscar frase."
      true ->
        {:ok, json} = Jason.decode(response.body)

        frase = Enum.at(json, 0)["q"]
        autor = Enum.at(json, 0)["a"]

        "Frase em ingles: #{frase} - #{autor} \n#{traduzir(frase, autor)}"
    end
  end

  defp traduzir(frase, autor) do
    {:ok, response} = HTTPoison.get("https://api.mymemory.translated.net/get?q=#{URI.encode(frase)}&langpair=en|pt")

    cond do
      String.contains?(response.body, "erro") -> "Erro ao traduzir frase."
      true ->
        {:ok, json} = Jason.decode(response.body)
        "Frase em portugues: #{json["responseData"]["translatedText"]} - #{autor}"
    end
  end
end
