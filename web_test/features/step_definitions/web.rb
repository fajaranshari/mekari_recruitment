require 'selenium-webdriver'
require 'rubygems'
require 'rspec'

driver = Selenium::WebDriver.for:chrome


Given("User at amazon.com page") do
  driver.get 'https://www.amazon.com/'
  wait = Selenium::WebDriver::Wait.new(:timeout => 3)
end

When("User click sign up button") do
  el = driver.find_element(:id, "nav-link-accountList")
  driver.action.move_to(el).perform
  driver.find_element(:css, ".nav_pop_new_cust>a").click
end

Then("User at sign up page") do
  el = driver.find_element(:css, ".a-spacing-extra-large .a-spacing-small").text
  expect(el).to eq("Create account")
end

When("User fill all mandatory field") do
  driver.find_element(:id, "ap_customer_name").send_keys 'Jony Yespapa'
  driver.find_element(:id, "ap_email").send_keys 'someCoolEmailz11@gmail.com'
  driver.find_element(:id, "ap_password").send_keys '999Okedeh'
  driver.find_element(:id, "ap_password_check").send_keys '999Okedeh'
end

When("User click Create your amazon button") do
  Selenium::WebDriver::Wait.new(:timeout => 3)
  driver.find_element(:id, "continue").click
end

Then("User redirect to verify email address page") do
  el = driver.find_element(:css, ".a-row.a-spacing-small h1").text
  expect(el).to eq("Verify email address")
end

When("User fill all field but mismatch the password") do
  driver.find_element(:id, "ap_customer_name").send_keys 'Jony Yespapa'
  driver.find_element(:id, "ap_email").send_keys 'someCoolEmailz11@gmail.com'
  driver.find_element(:id, "ap_password").send_keys '123nothingmuch'
  driver.find_element(:id, "ap_password_check").send_keys '124nothingmuch'
end

Then("User see password not match alert") do
  el = driver.find_element(:css, "#auth-password-mismatch-alert .a-alert-content").text
  expect(el).to eq("Passwords must match");
end

#sign in step definition

When("User click sign in link") do
  el = driver.find_element(:id, "nav-link-accountList")
  driver.action.move_to(el).perform
  driver.find_element(:css, "#nav-flyout-ya-signin>a").click
end

Then("User at signin page") do
  Selenium::WebDriver::Wait.new(:timeout => 3)
  el = driver.find_element(:css, ".auth-validate-form .a-spacing-small").text
  expect(el).to eq("Sign-In")
end

When("User enter {string} on email address") do |username|
  driver.find_element(:id, "ap_email").send_keys username
end

When("User click Continue button") do
  driver.find_element(:css, "#continue.a-button").click
end

Then("User will be prompted by {string} alert") do |alert|
  el = driver.find_element(:css, ".a-alert-content .a-list-item").text
  expect(el).to eq(alert)
end

When("User enter {string} as password") do |password|
  driver.find_element(:id, "ap_password").send_keys password
end

When("User click Sign-in button") do
  driver.find_element(:id, "signInSubmit").click
end

Then("User will be redirect to OTP verification page") do
  el = driver.find_element(:css, ".a-row.a-spacing-small").text
  expect(el).to eq("Authentication required")
end