#! /usr/bin/env bash
. ~/.bashrc

git pull

mix deps.get --only prod
MIX_ENV=prod mix compile

npm run deploy --prefix ./assets

MIX_ENV=prod mix do ecto.create, ecto.migrate
# cd assets && npm install && npm run deploy & cd ..
mix phx.digest
mix compile
MIX_ENV=prod mix release --overwrite

_build/prod/rel/inform/bin/inform stop
_build/prod/rel/inform/bin/inform daemon_iex