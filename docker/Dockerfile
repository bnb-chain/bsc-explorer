FROM bitwalker/alpine-elixir-phoenix:1.9.4

RUN apk --no-cache --update add alpine-sdk gmp-dev automake libtool inotify-tools autoconf python

EXPOSE 4000

ENV PORT=4000 \
    MIX_ENV="prod" \
    ECTO_USE_SSL="false" \
    ETHEREUM_JSONRPC_VARIANT="geth" \
    COIN="BNB" \
    EMISSION_FORMAT="GETH" \
    NETWORK="BNB Smart Chain" \
    WEB_NETWORK_PATH="/smart-testnet" \
    STATIC_NETWORK_PATH="/smart-testnet" \
    API_PATH="/smart-testnet" \
    SOCKET_ROOT="/smart-testnet" \
    BLOCKSCOUT_HOST="explorer.bnbchain.org/"


# Cache elixir deps
ADD mix.exs mix.lock ./
ADD apps/block_scout_web/mix.exs ./apps/block_scout_web/
ADD apps/explorer/mix.exs ./apps/explorer/
ADD apps/ethereum_jsonrpc/mix.exs ./apps/ethereum_jsonrpc/
ADD apps/indexer/mix.exs ./apps/indexer/

RUN mix do deps.get, local.rebar --force, deps.compile

ADD . .

ARG COIN
RUN if [ "$COIN" != "" ]; then sed -i s/"POA"/"${COIN}"/g apps/block_scout_web/priv/gettext/en/LC_MESSAGES/default.po; fi

# Run forderground build and phoenix digest
RUN mix compile

# Add blockscout npm deps
RUN cd apps/block_scout_web/assets/ && \
    npm install && \
    npm run deploy && \
    cd -

RUN cd apps/explorer/ && \
    npm install && \
    apk update && apk del --force-broken-world alpine-sdk gmp-dev automake libtool inotify-tools autoconf python

# RUN mix do ecto.drop --force, ecto.create, ecto.migrate

RUN mix phx.digest

# USER default

# CMD ["mix", "phx.server"]
CMD ["sh","-c","mix do ecto.migrate && mix phx.server"]