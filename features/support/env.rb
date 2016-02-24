require 'rubygems'
require 'appium_lib'
require 'selenium/webdriver'
require 'pry'
require 'rspec'
require 'net/http'
require 'touch_action'
require 'testrail'

#%x(cd /Users/guillemsannicolas/goldenmanager.com/; bundle exec cap staging dev:erase STAGE=staging4 USER=26)

testrail_credentials = File.readlines("creds")

$testrail_username = testrail_credentials.first
$testrail_username = $testrail_username.split("\n").first
$testrail_username = $testrail_username.split(":").last

$testrail_password = testrail_credentials.last
$testrail_password = $testrail_password.split("\n").first
$testrail_password = $testrail_password.split(":").last

APP_PATH = '~/goldenmanager-ios/build/GoldenManager.app'
ANDROID_APP_PATH = '/Users/guillemsannicolas/goldenmanager-android/app/GM-pre-release-br_develop-v.1.8.5-time-12-13-01-02-2016.apk'

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

def type(user_name)
  user_name.chars.each do|c| 
  	begin
  	  Integer(c).class
  	  change_numeric if !$state_numeric
  	  click_key(c) 
		rescue
  	  change_numeric if $state_numeric
  	  click_key(c)
  	end
  end
end

def change_numeric
  find_element(:xpath => numeric_xpath).click
  $state_numeric = !$state_numeric
end

def numeric_xpath
  return '//UIAApplication[1]/UIAWindow[3]/UIAKeyboard[1]/UIAKey[31]' if is_real_device($d_caps)
  return '//UIAApplication[1]/UIAWindow[3]/UIAKeyboard[1]/UIAKey[28]' if !$state_numeric
  return '//UIAApplication[1]/UIAWindow[3]/UIAKeyboard[1]/UIAKey[24]' if $state_numeric
end 

def click_key(key)
  find_element(:xpath => binder(key)).click
  change_numeric if key == '_' && !is_real_device($d_caps)
end

def binder(bind_value)
  case bind_value
  when 'q' 
    xpath_maker(1)  
  when '1' 
    xpath_maker(1)
  when 'w'
    xpath_maker(2)
  when '2'
  	xpath_maker(2)
  when 'e'
    xpath_maker(3)
  when '3'
  	xpath_maker(3)
  when 'r'
    xpath_maker(4)
  when '4'
  	xpath_maker(4)
  when 't'
    xpath_maker(5)
  when '5'
  	xpath_maker(5)
  when 'y'
    xpath_maker(6)
  when '6'
  	xpath_maker(6)
  when 'u'
    xpath_maker(7)
  when '7'
  	xpath_maker(7)
  when 'i'
    xpath_maker(8)
  when '8'
  	xpath_maker(8)
  when 'o'
    xpath_maker(9)
  when '9'
  	xpath_maker(9)
  when 'p'
    xpath_maker(10)
  when 'a'
    return xpath_maker(12) if is_real_device($d_caps)
    xpath_maker(11)
  when 's'
    return xpath_maker(13) if is_real_device($d_caps)
    xpath_maker(12)
  when 'd'
    return xpath_maker(14) if is_real_device($d_caps)
    xpath_maker(13)
  when 'f'
    return xpath_maker(15) if is_real_device($d_caps)
    xpath_maker(14)
  when 'g'
    return xpath_maker(16) if is_real_device($d_caps)
    xpath_maker(15)
  when 'h'
    return xpath_maker(17) if is_real_device($d_caps)
    xpath_maker(16)
  when 'j'
    return xpath_maker(18) if is_real_device($d_caps)
    xpath_maker(17)
  when 'k'
    return xpath_maker(19) if is_real_device($d_caps)
    xpath_maker(18)
  when 'l'
    return xpath_maker(20) if is_real_device($d_caps)
    xpath_maker(19)
  when 'z'
    return xpath_maker(22) if is_real_device($d_caps)
    xpath_maker(20)
  when 'x'
    return xpath_maker(23) if is_real_device($d_caps)
    xpath_maker(21)
  when 'c'
    return xpath_maker(24) if is_real_device($d_caps)
    xpath_maker(22)
  when 'v'
    return xpath_maker(25) if is_real_device($d_caps)
    xpath_maker(23)
  when 'b'
    return xpath_maker(26) if is_real_device($d_caps)
    xpath_maker(24)
  when 'n'
    return xpath_maker(27) if is_real_device($d_caps)
    xpath_maker(25)
  when 'm'
    return xpath_maker(28) if is_real_device($d_caps)
    xpath_maker(26)
  when '@'
    return xpath_maker(29) if is_real_device($d_caps)
    xpath_maker(30)
  when '_'
  	return xpath_maker(33) if is_real_device($d_caps)
    change_numeric
    xpath_maker(20)
  when '.'
  	return xpath_maker(30) if is_real_device($d_caps)
    xpath_maker(31)
  end
end

def xpath_maker(xpath_index)
  default_xpath = '//UIAApplication[1]/UIAWindow[3]/UIAKeyboard[1]/UIAKey[1]'
  default_xpath[default_xpath.length - 2] = xpath_index.to_s
  return default_xpath
end

def delegate_xpath(xpath_to_delegate)
  return xpath_to_delegate unless !is_real_device($d_caps)
  xpath_to_simulator(xpath_to_delegate)
end

def xpath_to_simulator(rd_xpath)
  xpath_to_return = "/"
  xpath_converter(rd_xpath).each do |x|
    xpath_to_return = xpath_to_return + "/" + x if x != ""
  end
  return xpath_to_return
end

def xpath_converter(xpath)
  xpath.split('/').each do |x|
    if (x =~/UIAWebView(.*)/) == 0
      return xpath.split('/')
    end
  end
  xpath.split('/').each do |x|
    if (x =~/UIAWindow(.*)/) == 0
      x[x.length-2] = (Integer(x[x.length-2]) + 1).to_s
    end
  end
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