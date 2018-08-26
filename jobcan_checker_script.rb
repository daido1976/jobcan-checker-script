require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'pry'

Capybara.default_driver = :selenium_chrome_headless
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

    def visit_attendance_page
      click_on '勤怠'
      switch_to_window { title == "JOBCAN MyPage: #{ENV['MY_NAME']}" }
      click_on '出勤簿'
    end

    def current_difference
       worked_hours - (worked_days * 8).to_f
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

if ARGV.first == 'current_difference'
  puts crawler.current_difference.to_time
else
  puts '今日も頑張ろうな'
end
