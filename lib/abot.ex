defmodule Abot do

  use Nostrum.Consumer

  alias Nostrum.Api.Message
  alias Abot.Commands

  def handle_event({:MESSAGE_CREATE, msg, _ws}) do
    cond do
      String.starts_with?(msg.content, "!oii") -> Message.create(msg.channel_id, "Oii, tudo bem? Vamos começar os estudos? ")

      String.starts_with?(msg.content, "!wiki") -> Message.create(msg.channel_id, Commands.Wiki.handle_wiki(msg))
      String.starts_with?(msg.content, "!calcular") -> Message.create(msg.channel_id, Commands.Math.handle_calcular(msg))

      String.starts_with?(msg.content, "!converter") -> Message.create(msg.channel_id, Commands.Convert.handle_convert(msg))
      String.starts_with?(msg.content, "!traduzir") -> Message.create(msg.channel_id, Commands.Translate.handle_translate(msg))

      String.starts_with?(msg.content, "!quiz") -> Message.create(msg.channel_id, Commands.Quiz.handle_quiz(msg))

      String.starts_with?(msg.content, "!frase") -> Message.create(msg.channel_id, Commands.Quote.handle_quote(msg))

      true -> :ignore
    end

  end
end
