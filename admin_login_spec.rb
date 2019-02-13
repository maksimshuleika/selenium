require 'rspec'
require 'selenium-webdriver'
require 'active_support'

describe 'Admin' do
  before(:all) do
    @driver = Selenium::WebDriver.for :chrome
    @wait = Selenium::WebDriver::Wait.new(timeout: 10)
    @driver.get('http://localhost:8080/litecart/admin')
  end

  it 'should be able to log in' do
    @wait.until {@user_name = @driver.find_element(name: 'username')}.send_keys('admin')
    @wait.until {@password = @driver.find_element(name: 'password')}.send_keys('admin')

    @driver.find_element(name: 'login').click()

    @success_message = @driver.find_element(css: "div[class='notice success']").text
      if @success_message == "You are now logged in as admin"
        puts "Test passed"
      else
        puts "Test failed"
      end
  end

  after(:each) do
    @driver.quit()
  end
end
