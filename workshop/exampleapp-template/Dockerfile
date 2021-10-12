FROM ruby:2.6.2

RUN apt-get update && \
    apt-get install -y net-tools

# Install gems
ENV APP_HOME /app
ENV HOME /root
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN bundle install

# Upload source
COPY config.ru $APP_HOME
RUN mkdir $APP_HOME/lib
COPY lib/* $APP_HOME/lib

# # Install Vault
# RUN wget https://releases.hashicorp.com/vault/1.8.2/vault_1.8.2_linux_amd64.zip --output-document /tmp/vault_release.zip
# RUN unzip /tmp/vault_release.zip -d /usr/local/bin

# RUN apt-get install -y jq

# Start server
ENV VAULT_ADDR http://host.docker.internal
ENV PORT 8080
EXPOSE 8080
CMD ["rackup", "--port", "8080", "--env", "production" ]
