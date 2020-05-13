require 'eyes_selenium'

visual_grid_runner = Applitools::Selenium::VisualGridRunner.new(10)
eyes = Applitools::Selenium::Eyes.new(runner: visual_grid_runner)

web_driver = Selenium::WebDriver.for :chrome

eyes.batch = Applitools::BatchInfo.new("Ultrafast Batch")

eyes.configure do |conf|
  conf.app_name = 'Demo App'
  conf.test_name = 'Ultrafast grid demo'
  # conf.proxy = Applitools::Connectivity::Proxy.new('http://your.proxy.com')
  conf.viewport_size = Applitools::RectangleSize.new(800, 600)
  conf.add_browser(800, 600, BrowserTypes::CHROME)
      .add_browser(700, 500, BrowserTypes::FIREFOX)
      .add_browser(800,600, BrowserTypes::SAFARI)
      .add_browser(1600,1200, BrowserTypes::IE_11)
      .add_browser(1024,768, BrowserTypes::EDGE_CHROMIUM)
      .add_device_emulation(Devices::IPhoneX, Orientations::PORTRAIT)
      .add_device_emulation(Devices::Pixel2, Orientations::PORTRAIT)
end

begin
  # Call Open on eyes to initialize a test session
  driver = eyes.open(driver: web_driver)

  # Navigate to the url we want to test
  driver.get('https://demo.applitools.com/index.html')

  # Note to see visual bugs, run the test using the above URL for the 1st run.
  # but then change the above URL to https://demo.applitools.com/index_v2.html (for the 2nd run)

  # check the login page
  eyes.check('Login page', Applitools::Selenium::Target.window.fully)

  # Click the 'Log In' button
  driver.find_element(:id, 'log-in').click

  # Check the app page
  eyes.check('App Page', Applitools::Selenium::Target.window.fully)

  eyes.close_async
rescue => e
  puts e.message
  # If the test was aborted before eyes.close / eyes.close_async was called, ends the test as aborted.
  eyes.abort_async
ensure
  # Close the browser
  driver.quit
  results = visual_grid_runner.get_all_test_results
  puts results
end


