FROM elixir:1.13.1-alpine

# create workdir
WORKDIR /app

# Install Hex + Rebar + other deps
RUN mix do local.hex --force, local.rebar --force

# Copy mix file for install deps & Copy configs
COPY config/ /app/config/
COPY mix.exs /app/
COPY mix.* /app/

# Install deps
RUN mix do deps.get, deps.compile

# Final copy
COPY . /app/

# Final compile and migrate DB
WORKDIR /app
RUN mix compile
RUN mix ecto.setup

EXPOSE 4000

CMD ["mix", "phx.server"]
