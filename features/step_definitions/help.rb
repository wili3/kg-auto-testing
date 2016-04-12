#######################
#  Touch help button
#######################

Given(/^I have the App running with appium$/) do
 # wait{button('Deny').click} if $d_caps[:caps][:platformName] == "Android"
 # wait{button('Cancel').click} if $d_caps[:caps][:platformName] == "Android"
 # wait{button('Cancel').click} if !is_real_device($d_caps)
  sleep(10)
  $window_width = Appium::Common.window_size.width
  $window_height = Appium::Common.window_size.height

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


#############################
# Navigation to the line up #
#############################

Then(/^I should navigate to the line up$/) do
  go_to_menu
  go_to_team
  go_to_lineup
  #binding.pry
end

Then(/^perform a sustitution$/) do
  player1 = find_element(:id => $d_caps[:caps][:bundleId] + ":id/cb1")
  player2 = find_element(:id => $d_caps[:caps][:bundleId] + ':id/cb3')

  drag_and_drop(player1, player2)
  click_button(":id/actionbar_custom_action") #Click aceptar y guardar
end

Then(/^I should navigate to the stats section$/) do
  go_to_menu
  go_to_stats
end

Then(/^finally I should come back to the dashboard$/) do
  go_to_menu
  go_back
  go_dashboard
  binding.pry
  action = Appium::TouchAction.new
  action.swipe({:start_x => (($window_width / 3) * 2), :start_y => (($window_height / 7) * 7), :end_x => (($window_width / 3) * 1), :end_y => (($window_height / 7) * 7), :duration => 100}).perform
  binding.pry
end


###########################
# Navigation to trainings #
###########################

Then(/^I should navigate to the trainings$/) do
  go_to_menu
  go_to_trainings
end

Then(/^perform trainings$/) do
  #pending # Write code here that turns the phrase above into concrete actions
  binding.pry
  drop_spot = find_element(:id => $d_caps[:caps][:bundleId] + ":id/lyt_center_view")

  x1 = ($window_width / 3) * 2
  y1 = ($window_height / 4) * 3
  x2 = $window_width / 3
  y2 = y1
  duration = 100
  do_swipe(x1, y1, x2, y2, duration)
  binding.pry
  driver_quit
  # dropper :id/lyt_center_view
end




















