defmodule Abot.Commands.Convert do

  def headers do
    [{"X-Api-Key", System.get_env("API_NINJAS_KEY")}]
  end

  def handle_convert(msg) do
    dados = msg.content |> String.trim() |> String.split(" ")
    case dados do
      ["!converter"] -> "Use o comando completo, colocando o valor unidade_origem unidade_destino. Ex: !converter 10 kilometer meter"
      ["!converter", valor, unidade_atual, unidade_destino] -> get_convert(valor,unidade_atual, unidade_destino)
      _ -> "Comando inválido, use !converter valor unidade_origem unidade_destino"

    end


  end
  def get_convert(valor, unidade_atual, unidade_destino) do
    {:ok, response} = HTTPoison.get("https://api.api-ninjas.com/v1/unitconversion?amount=#{valor}&unit=#{unidade_atual}", headers())

    cond do
      response.status_code != 200 ->"O resultado deu erro, verifique a sintaxe e tente novamente."
      true ->
        IO.inspect(response.body)
        {:ok, json} = Jason.decode(response.body)
        "Convesão da unidade: #{json["conversions"][unidade_destino]} #{unidade_destino}"
    end
  end
end
