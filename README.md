# ABot – Bot de Estudos em Elixir

> Bot desenvolvido em Elixir para auxiliar nos estudos através de comandos no Discord.

O **ABot** é um bot criado utilizando Elixir com foco em aprendizado da linguagem e integração com APIs externas.  

---

# Pré-requisitos

Antes de executar o projeto, é necessário ter instalado:

- Elixir
- Erlang
- Git
- VSCode (ou outro editor)
- Conta no site https://api-ninjas.com/

Verifique se o Elixir está instalado:

```bash
elixir -v
```

Verifique se o Mix está instalado:

```bash
mix -v
```

---

# Instalação do Projeto

## 1. Clonar o repositório

Abra o terminal e execute:

```bash
git clone https://github.com/abeatrizsm/BotDiscordElixir.git
```

Entre na pasta do projeto:

```bash
cd abot
```

---

## 2. Instalar dependências

Execute:

```bash
mix deps.get
```

---

## 3. Configurar variáveis de ambiente

O projeto utiliza variáveis de ambiente para proteger tokens e chaves da API.

### Windows (PowerShell)

Configure o token do bot:

```powershell
setx DISCORD_TOKEN "SEU_TOKEN"
```

Você precisará criar uma conta no site https://api-ninjas.com/ e pegar sua chave de api. 

Para configurar a chave da API:

```powershell
setx API_NINJAS_KEY "SUA_CHAVE"
```

Depois:
- feche o terminal
- abra novamente

---

## 4. Executar o projeto

Inicie o bot com:

```bash
mix run --no-halt
```

Se tudo estiver correto, o bot ficará online no Discord.

---
