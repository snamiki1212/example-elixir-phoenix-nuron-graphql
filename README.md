# elixir-phoenix-nuron-github

- elixir: language
- Phoenix: Web Framework
- nuron: GraphQL client

## Flow

![flow](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/snamiki1212/example-elixir-phoenix-nuron-graphql/main/docs/flow.plantuml)

## Getting started

```zsh
## set up env file
cp config/dev.sercret.example.exs config/dev.sercret.exs
open config/dev.sercret.exs  # update to use user github api token

## set up server
mix deps.get
mix server
# or
iex -S mix phx.server # for IEx.pry
```

## Routing

```zsh
$ curl http://localhost:4000/users | jq
# => get your github username

$ curl http://localhost:4000/repositories | jq
# => get your watching repositories
```

## LICENSE

MIT
