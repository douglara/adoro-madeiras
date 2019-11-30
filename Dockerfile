FROM ruby:2.6.5

# Install linux dependences
RUN apt-get update -qq \
    && apt-get install -y \
        build-essential libpq-dev libnss3-dev nodejs \
        postgresql postgresql-client \
        graphviz \
        netcat \
        imagemagick

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs && npm install --global yarn
RUN npm config get registry prints: https://registry.npmjs.org

# Configure app
RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem install bundler --version '= 1.15.2'
RUN bundle install

COPY . /app

# Install and build javascript dependences
RUN yarn install


EXPOSE 3000

CMD bundle exec rails s -p 3000 -b '0.0.0.0'
