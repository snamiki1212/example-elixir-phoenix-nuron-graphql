# elixir-phoenix-nuron-github

- elixir: language
- Phoenix: Web Framework
- nuron: GraphQL client

## Getting started

```zsh
## set up env file
cp config/dev.sercret.example.exs config/dev.sercret.exs
open config/dev.sercret.exs  # update to use user github api token

## set up server
mix deps.get
mix server
curl http://localhost:4000/users/1
# => get your github username
```

## LICENSE

MIT
