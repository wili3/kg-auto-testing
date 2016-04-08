#######################
#  Touch help button
#######################

Given(/^I have the App running with appium$/) do
 # wait{button('Deny').click} if $d_caps[:caps][:platformName] == "Android"
 # wait{button('Cancel').click} if $d_caps[:caps][:platformName] == "Android"
 # wait{button('Cancel').click} if !is_real_device($d_caps)
  sleep(10)
  puts 'PASSED!'
end

#######################
#  Login with G+
#######################

When(/^click login with G\+ button$/) do
  no_report = true
  begin
    wait{text("Jugar con Google+").click} 
    begin
      wait{text("Jugar con Google+").click} 
    rescue
      puts 'no need to tap twice'
      no_report = false
    end
    report_to_testrail(405,1)
  rescue
    no_report = false
  end
  report_to_testrail(405,5) if no_report
end

Then(/^I should navigate to the dashboard$/) do
  begin
    wait({timeout:30,interval:1}) do
      txt = text('Toca para continuar')
      if txt.displayed?
        sleep (5)
        txt.click 
        sleep(5)
      end
    end   
    wait({timeout:10,interval:1}) do
      txt = text('p')
      if txt.displayed? && txt.text == "p"
        txt.click
        puts 'text was displayed' + txt.displayed?.to_s
        if !device_is_android?
          button('p').click if button('p').text == 'p'
        end
      end
    end
  rescue
    puts 'no Ingame tutorial'
    begin
      wait({timeout:10,interval:1}) do
        if device_is_android?
          text('p').click if text('p').text == "p"
        end
        if !device_is_android?
          button('p').click if button('p').text == 'p'
        end
      end
    rescue
      puts 'no GM News'
    end
  end 
  
end