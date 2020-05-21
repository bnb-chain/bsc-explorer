cwd=$PWD
mix do deps.get, local.rebar --force, deps.compile
mix compile

cd apps/block_scout_web/assets/
npm install
npm run deploy
cd $cwd

cd apps/explorer
npm install
cd $cwd

cd apps/block_scout_web
mix phx.gen.cert blockscout blockscout.local
cd $cwd

mix phx.digest

mix phx.server
