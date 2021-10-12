require "sinatra"
require "faraday"
require "logger"
require "yaml"

$stdout.sync = true

class ExampleApp < Sinatra::Base

  set :port, ENV['PORT'] || "8080"
  set :secrets_file, ENV['SECRETS_FILE'] || "/application/keys.yaml"

  configure :development do
    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG
    set :raise_errors, true
    set :logger, logger
  end

  configure :production do
    logger = Logger.new(STDOUT)
    logger.level = Logger::INFO
  end

  # GET "/"
  get "/" do
    logger.info "Received Request"

    # Set up an undefined state and set the vault server and secrets path
    secrets = { "username" => "undefined", "password" => "undefined" }

    logger.debug "Reading secrets from #{settings.secrets_file}"

    # Parse the YAML
    secrets = YAML.load(File.read(settings.secrets_file))

    # Return secret
    "#{secrets.to_s}\n"
  end
end