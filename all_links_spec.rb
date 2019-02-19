require 'rspec'
require 'selenium-webdriver'
require 'active_support'
require 'active_support/rails'

LIST_OF_LEFT_MENU_LINKS =
    "Appearence",
    "Catalog",
    "Countries",
    "Currencies",
    "Customers",
    "Geo Zones",
    "Languages",
    "Modules",
    "Orders",
    "Pages",
    "Reports",
    "Settings",
    "Slides",
    "Tax",
    "Translations",
    "Users",
    "vQmods"

LIST_OF_HEADERS =
        'Template',
        'Logotype',
        'Catalog',
        'Product Groups',
        'Option Groups',
        'Manufacturers',
        'Suppliers',
        'Delivery Statuses',
        'Sold Out Statuses',
        'Quantity Units',
        'CSV Import/Export',
        'Customers',
        'CSV Import/Export',
        'Newsletter',
        'Languages',
        'Storage Encoding',
        'Job Modules',
        'Customer Modules',
        'Shipping Modules',
        'Payment Modules',
        'Order Total Modules',
        'Order Success Modules',
        'Order Action Modules',
        'Orders',
        'Order Statuses',
        'Monthly Sales',
        'Most Sold Products',
        'Most Shopping Customers',
        'Settings',
        'Tax Classes',
        'Tax Rates',
        'Search Translations',
        'Scan Files For Translations',
        'CSV Import/Export',
        'vQmods'



describe 'Left admin menu' do

    before(:each) do

      # Preparing setup for testing
      @driver = Selenium::WebDriver.for :chrome
      @wait = Selenium::WebDriver::Wait.new(timeout: 10)
      @driver.get('http://localhost:8080/litecart/admin')

      # Login and password
      @user_name = @driver.find_element(name: 'username').send_keys('admin')
      @password = @driver.find_element(name: 'password').send_keys('admin')
      @driver.find_element(name: 'login').click()

      @driver.manage.timeouts.implicit_wait = 3
    end

    it 'are present and match list of menu links' do
      @main_links_text = []
      @main_links_list = @driver.find_elements(css: "span[class='name']")
      @main_links_list.each {|link| @main_links_text << link.text}
      expect(LIST_OF_LEFT_MENU_LINKS).to match_array(@main_links_text)
    end

    it 'links are not broken' do
      @hrefs = []

      # Checking main left menu links
      @main_links = @driver.find_elements(css: "#box-apps-menu a")
      @main_links.each do |link|
        @hrefs << link.attribute("href")
      end

      @hrefs.each do |href|
        @inner_links = []
        @links = []
        @driver.execute_script( "window.open()" )
        @driver.switch_to.window( @driver.window_handles.last )
        @driver.get(href)

        # Checking inner menu links
        @inner_links = @driver.find_elements(css: ".docs li  a")
        @inner_links.each do |link|
          @links << link.attribute("href")
        end

        #Checking headers h1
        @links.each do |result|
          @driver.execute_script( "window.open()" )
          @driver.switch_to.window( @driver.window_handles.last )
          @driver.get(result)
          @header = @driver.find_element(css: "h1").text
          if LIST_OF_HEADERS.include? @header
            puts "Test passed"
          end
          @driver.switch_to.window( @driver.window_handles.first )
        end
      end
    end
end
