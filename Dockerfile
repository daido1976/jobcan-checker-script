FROM ruby:2.5-slim

LABEL Name=jobcan-checker-script Version=0.0.1
EXPOSE 3000

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app
COPY . /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

CMD ["ruby", "jobcan-checker-script.rb"]
    