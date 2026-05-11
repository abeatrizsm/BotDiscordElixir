defmodule Abot.Commands.Translate do

  def handle_translate(msg) do
    dados = msg.content |> String.trim() |> String.split(" ")

    case dados do
      ["!traduzir"] -> "Use o comando completo, colocando o texto após o !traduzir. Ex: !traduzir eu adoro estudar."
      ["!traduzir" | texto] ->
        texto = Enum.join(texto, " ")
        get_translate(texto)

      _ -> "Comando inválido, use !traduzir frase"

      end
  end

  defp get_translate(texto) do
    {:ok, response} = HTTPoison.get("https://api.mymemory.translated.net/get?q=#{URI.encode(texto)}&langpair=pt|en")

    cond do
      String.contains?(response.body, "erro") -> "Tradução deu erro, verifique a sintaxe."
      true ->
      {:ok, json} = Jason.decode(response.body)
      "Tradução: #{json["responseData"]["translatedText"]}"
    end
  end
end
