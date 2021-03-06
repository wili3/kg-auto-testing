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

When(/^click help button$/) do
  pending
end

Then(/^I should see a popup with the title "([^"]*)" ont the top of the pop up$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^clicking the close button I should not see this popup anymore$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

#######################
#  Login with G+
#######################

When(/^click login with G\+ button$/) do
  wait{text("Jugar con Google+").click} 
  begin
    wait{text("Jugar con Google+").click} 
  rescue
    puts 'no need to tap twice'
  end
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


#######################
#  Logout 
#######################

When(/^click logout button$/) do
  wait{text_exact('0').click} if device_is_android?
  wait{button_exact('€+').click} if !device_is_android?
  wait{text('7').click} if device_is_android?
  wait{button_exact('7').click} if !device_is_android?
  wait{button('CERRAR SESIÓN').click}
  wait{find_element(:xpath => "//android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.RelativeLayout[1]/android.widget.TextView[5]").click} if device_is_android?
  wait{button('CERRAR SESIÓN').click} if !device_is_android?
end

Then(/^I should navigate to the landing$/) do
  wait{text("Jugar con Facebook")} if device_is_android?
  wait{button_exact("Jugar con Facebook")} if !device_is_android?
end


#######################
#  Login with GC 
#######################

When(/^click login with GC button$/) do
  wait{button_exact('Jugar con Game Center').click}
end