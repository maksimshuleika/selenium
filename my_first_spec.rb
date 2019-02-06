require 'rspec'
require 'selenium-webdriver'

describe 'Testing site' do
  before(:all) do
    @driver = Selenium::WebDriver.for :chrome
    @wait = Selenium::WebDriver::Wait.new(timeout: 10)
    @driver.get('http://www.seleniumframework.com/practiceform/')
  end

  it 'should be opened and all links grabbed' do
    @all_links = @wait.until { @driver.find_elements(tag_name: "a") }
  end

  after(:each) do
    @driver.quit()
  end
end
