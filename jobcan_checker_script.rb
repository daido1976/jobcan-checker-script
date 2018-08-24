require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

Capybara.default_driver = :selenium_chrome
Capybara.app_host = ENV['BASE_URL']

module Crawler
  class Jobcan
    include Capybara::DSL

    def login
      visit '/users/sign_in'
      fill_in 'user_email', with: ENV['MY_EMAIL']
      fill_in 'user_password', with: ENV['MY_PASSWORD']
      click_on 'ログイン'
    end
  end
end

crawler = Crawler::Jobcan.new
crawler.login
