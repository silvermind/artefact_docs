FROM ruby:2.5.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

# Install Node.js 6.x repository
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
# Install Node.js and npm
RUN apt-get install -y nodejs

# yard for webpacker
#RUN npm install -g yarn
#RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
#RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
#RUN apt-get update && apt-get install yarn

ENV APP_HOME /myapp

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile $APP_HOME/Gemfile
ADD Gemfile.lock $APP_HOME/Gemfile.lock

RUN gem update bundler
RUN bundle install --verbose

ADD . $APP_HOME

#RUN yarn install --verbose


# build assets with key for devise error
# uses tmp/cache/assets # used by sprockets for assets
ENV DATABASE_URL postgres://user:pw@db-host:5432/db
RUN DOMAIN_NAME=docker-tmp.example.com SECRET_KEY_BASE=67a7856582f44a5e876be86b45ada947b810c449207be72db3c09c0f40a9efedb07850ba9d7598cf6471a2d952f7b75d812a8c41a189099fbba388eeadc10c4e RAILS_ENV=production bundle exec rake assets:precompile --trace

EXPOSE 3000

CMD ["rails","server","-p","3000", "-b","0.0.0.0"]