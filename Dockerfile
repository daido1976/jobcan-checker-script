FROM ruby:2.5
ENV LANG C.UTF-8
# version 75 から w3c: true がデフォルトになってしまっていて、不具合が発生するので固定する
# see https://chromedriver.storage.googleapis.com/75.0.3770.8/notes.txt
# see https://stackoverflow.com/questions/56111529/cannot-call-non-w3c-standard-command-while-in-w3c-mode-seleniumwebdrivererr
ENV CHROMEDRIVER_VERSION 74.0.3729.6

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app
SHELL ["/bin/bash", "-c"]

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
    unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    rm /tmp/chromedriver_linux64.zip && \
    chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver && \
    ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get install -y google-chrome-stable

CMD ["bundle", "exec", "ruby", "./jobcan_checker_script.rb"]
