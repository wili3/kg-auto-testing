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

When(/^click login with G\+ button$/) do          #PENDING TO SOLVE AND REVISE
  begin
    wait{text("Jugar con Google+").click} 
    begin
      wait{text("Jugar con Google+").click} 
    rescue
      puts 'no need to tap twice'
    end
    wait{text_exact("joan.maeso@keradgames.com").click}
  rescue
  end

  begin 
    find_element(:id => $d_caps[:caps][:bundleId] + ':id/actionbar_title')
    report_to_testrail(405,1)
  rescue
    report_to_testrail(405,5)
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


#############
# Navigation to the line up
#############

Then(/^I should navigate to the line up$/) do
  go_to_menu
  go_to_team
  go_to_lineup
  #binding.pry
end

Then(/^perform a sustitution$/) do
  #pending # Write code here that turns the phrase above into concrete actions
  player1 = find_element(:id => $d_caps[:caps][:bundleId] + ":id/cb1")
  player2 = find_element(:id => $d_caps[:caps][:bundleId] + ':id/cb3')

  drag_and_drop(player1, player2)
  click_button(":id/actionbar_custom_action")
end

Then(/^I should navigate to the stats section$/) do
  go_to_menu
  go_to_stats
end

Then(/^finally I should come back to the dashboard$/) do
  go_to_menu
  go_back
  go_dashboard
  driver_quit
end
























