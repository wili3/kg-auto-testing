require 'rubygems'
require 'appium_lib'
require 'selenium/webdriver'
require 'pry'
require 'rspec'
require 'net/http'
require 'touch_action'
require 'testrail'

testrail_credentials = File.readlines("creds")

$testrail_username = testrail_credentials.first
$testrail_username = $testrail_username.split("\n").first
$testrail_username = $testrail_username.split(":").last

$testrail_password = testrail_credentials.last
$testrail_password = $testrail_password.split("\n").first
$testrail_password = $testrail_password.split(":").last

APP_PATH = '~/goldenmanager-ios/build/GoldenManager.app'
ANDROID_APP_PATH = '/Users/joanmaesosimo/Projects/goldenmanager-android/app/GM-pre-release-br_develop-v.1.8.11-time-13-05-06-04-2016.apk'

$user = 'guillem_dstdlxg_user@tfbnw.net'
$passwd = '1234'
$state_numeric = false

$real_devices =['iPad de Guillem','ZY2222MK2P']
$has_season = false
$user_already_created = false

# changed result=result.with_appended_backtrace(test_step.source.last) if test_step.respond_to?(:source) for result = result since the '.last' method is missing for the param sent to this class every last step of the test
# in : /Users/guillemsannicolas/.gem/ruby/2.1.1/gems/cucumber-core-1.2.0/lib/cucumber/core/test/runner.rb
#
#opts = $default_d_caps imho its because of the gets.chomp, because when starting a test with arguments, the gets.chomp doesn't work 
# in : /Users/guillemsannicolas/.gem/ruby/2.1.2/gems/appium_lib-7.0.0/lib/appium_lib/driver.rb:296
def desired_caps_real_device
	desired_caps = {
	  caps: {
	    platformName: 		'iOS',
	    versionNumber: 		'9.0',
	    deviceName:   		'iPad de Guillem',
      newCommandTimeout: 1000,  
	    udid:         		'52257b7d0ae102e2d79f02448b5486aca8c6e715',
	    autoAcceptAlerts: true,
      bundleId:         'com.kg.GoldenManager',
      #newCommandTimeout:          10,
	    #app:	  					APP_PATH, 	
      fullReset:        false,
      fastReset:        true
	  }
	}
end

def desired_caps_simulator
  desired_caps = {
    caps: {
      platformName:     'iOS',
      versionNumber:    '8.4',
      deviceName:       'iPhone 6',
      newCommandTimeout: 1000,  
      #udid:             'b2ff805e53b8333cdaceb10fca1d3d1f6a6900d2',
      autoAcceptAlerts: true,
      app:              APP_PATH,
      fullReset:        true
    }
  }
end

def desired_caps_android
  desired_caps = {
    caps: {
      platformName:     'Android',
      #versionNumber:    '5.0',
      deviceName:       'ZY2222MK2P',
      newCommandTimeout: 1000,  
      #udid:             'b2ff805e53b8333cdaceb10fca1d3d1f6a6900d2',
      bundleId:         'com.keradgames.goldenmanager.pre',
      #autoAcceptAlerts: true,
      app:              ANDROID_APP_PATH,
      fullReset:        false,
      fastReset:        false,
      noSign:           true
    }
  }
end

$default_d_caps = desired_caps_android

def is_real_device(used_caps)
  $real_devices.include? used_caps[:caps][:deviceName]
end

def close_menu
  action = Appium::TouchAction.new
  action.swipe(:start_x => 350, :start_y => 600, :end_x => 1, :end_y => 600, :duration => 750).perform
end

def check_something_went_wrong
  begin
    wait({timeout:10,interval:1})do
      text('Something went wrong.')
      #if text('WELCOME MANAGER!').enabled?
       # return nil
      #end 
    end
    puts 'SOMETHING WENT WRONG'
    driver_quit
    Cucumber.wants_to_quit = true
  rescue
    puts 'LOGIN succeded'
  end
end

def report_to_testrail(id, status)
  id = id.to_i if !id.is_a? Integer
  status = status.to_i if !status.is_a? Integer
  message = ""
  message = error_message if status == 5
  message = success_message if status == 1
  %x(curl -H "Content-Type: application/json" -u "#{$testrail_username}:#{$testrail_password}" -d '{"status_id":#{status},"comment":"#{message}"}' "https://marynakeradgames.testrail.net//index.php?/api/v2/add_result/#{id}")
end

def error_message
  "Something went wrong while testing this"
end

def success_message
  "Test succeded"
end

#guarrada

puts 'What do you want to use? a = android , i =  ios real device , is = ios simulator'
res = gets.chomp

puts 'Do you want full reset ? y/n'
res_yn = gets.chomp

$d_caps = desired_caps_simulator if res == 'is'
$d_caps = desired_caps_real_device if res == 'i'
$d_caps = desired_caps_android if res == 'a'

$d_caps[:caps][:fullReset] = true if res_yn == 'y'
$d_caps[:caps][:fullReset] = false if res_yn == 'n'

$d_caps = desired_caps_android

$driver_instance =Appium::Driver.new($d_caps).start_driver
$driver_instance.manage.timeouts.implicit_wait = 0
Appium.promote_appium_methods self.class

puts 'test succeded!'