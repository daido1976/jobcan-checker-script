require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'pry'

Capybara.app_host = ENV['BASE_URL']
Capybara.default_driver = :selenium_chrome_headless
# see https://stackoverflow.com/questions/53073411/selenium-webdriverexceptionchrome-failed-to-start-crashed-as-google-chrome-is
chrome_options = { args: %w[headless disable-gpu --no-sandbox] }

Capybara.register_driver :selenium_chrome_headless do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(chrome_options: chrome_options),
    )
end

module Crawler
  class Jobcan
    include Capybara::DSL

    def login
      visit '/users/sign_in'
      fill_in 'user_email', with: ENV['MY_EMAIL']
      fill_in 'user_password', with: ENV['MY_PASSWORD']
      click_on 'ログイン'
    end

    def visit_attendance_page
      click_on '勤怠'
      switch_to_window { title == "JOBCAN MyPage: #{ENV['MY_NAME']}" }
      click_on '出勤簿'
    end

    # 出勤日当日の午後以降に確認する用
    def current_difference
       worked_hours - (worked_days * 8).to_f
    end

    # 出勤日当日の朝や休日などに確認する用
    def difference
      worked_hours - ((worked_days - 1) * 8).to_f
    end

    private

    # return [Float]
    def worked_hours
      worked_time = first(:xpath, "//th[contains(text(),'実労働時間')]/following-sibling::*").text
      hours, minutes = worked_time.split(':')
      hours.to_f + (minutes.to_f / 60)
    end

    # return [Integer]
    def worked_days
      worked_days = first(:xpath, "//th[contains(text(),'実働日数')]/following-sibling::*").text
      worked_days.to_i
    end
  end
end

class Float
  def to_time
    "#{self.to_i} 時間 #{((self - self.to_i) * 60).round} 分"
  end
end

crawler = Crawler::Jobcan.new
crawler.login
crawler.visit_attendance_page

if ARGV.first == 'cd' || ENV['ARGV'] == 'cd'
  puts crawler.current_difference.to_time
else
  puts crawler.difference.to_time
end
