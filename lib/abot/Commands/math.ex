defmodule Abot.Commands.Math do
  def handle_calcular(msg) do
    dados = msg.content |> String.trim() |> String.split(" ")

    case dados do
      ["!calcular"] -> "Use o comando completo, colocando a expressão após !calcular. Ex: !calcular 2+3"
      ["!calcular" | expressao] ->
        expressao = Enum.join(expressao, "")
        get_calcular(expressao)
      _ -> "Comando inválido."
    end
  end

  defp get_calcular(expressao) do
    expressao = String.replace(expressao, "+", "%2B")

    {:ok, response} = HTTPoison.get("https://api.mathjs.org/v4/?expr=#{expressao}")

    cond do
      String.contains?(response.body, "erro") -> "Erro no cálculo. Verifique a sintaxe."
      true ->
        "Resultado: #{response.body}"
    end
  end
end
