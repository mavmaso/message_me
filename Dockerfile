
FROM ruby:2.6.3
LABEL maintainer="Marcos Soares"

RUN apt-get update -qq && apt-get install -y build-essential

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -qqy libxml2-dev libxslt1-dev

# for capybara-webkit
RUN apt-get install g++ qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x -y

# for a JS runtime
RUN apt-get install -qqy nodejs

ENV APP_HOME /fonte
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# COPY Gemfile Gemfile
# COPY Gemfile.lock Gemfile.lock
ADD Gemfile* $APP_HOME/

RUN echo "gem: --no-ri --no-rdoc" >> ~/.gemrc
RUN bundle install

ADD . $APP_HOME
# RUN RAILS_ENV=production rake assets:precompile