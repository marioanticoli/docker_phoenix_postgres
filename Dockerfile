# Use an official Elixir runtime as a parent image.
FROM elixir:latest

RUN apt-get update && \
  apt-get install -y postgresql-client && \
  rm -rf /var/lib/apt/lists/*

# Create app directory and copy the Elixir projects into it.
RUN mkdir /app
COPY ./my_app /app
COPY ./entrypoint.sh /app
WORKDIR /app

# Install Hex package manager.
RUN mix local.hex --force

# Compile the project.
RUN mix do compile

CMD ["./entrypoint.sh"]
