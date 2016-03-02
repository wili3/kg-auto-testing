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
  driver_quit
end


#######################
#  Login with GC 
#######################

When(/^click login with GC button$/) do
  wait{button_exact('Jugar con Game Center').click}
end

#######################
#  General navigation
#######################

When(/^the dashboard is loaded$/) do
  
end

Then(/^I should navigate to each section which is in the sidemenu$/) do
  begin
      find_element(:id => $d_caps[:caps][:bundleId] + ':id/img_actionbar_offers').click
      find_element(:id => $d_caps[:caps][:bundleId] + ':id/txt_offers_close').click
  rescue
      puts 'NO OFFERS AVAILABLE'
  end
#   binding.pry
end

Then(/^to the line up$/) do
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/menu_position_2').click
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/submenu_line_up').click
  begin
    wait({timeout:10,interval:1}) do
      txt = text('TRATAR')
      if txt.displayed?
        sleep (3)
        txt.click 
        sleep(3)
      end
    end
    find_element(:id => 'android:id/up').click
  rescue
    puts ' No injured players '
  end
end

Then(/^I should go back to stats$/) do
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/submenu_team_stats').click
end

Then(/^I should go to trainings$/) do
  click_side_menu
  sidemenu_go_to_initial

  find_element(:id => $d_caps[:caps][:bundleId] + ':id/menu_position_3').click
end

Then(/^I should go to the market$/) do
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/menu_position_4').click
  begin
    wait({timeout:15,interval:1}) do
      txt = text('Toca para continuar')
      if txt.displayed?
        sleep (3)
        txt.click 
        sleep(3)
      end
    end
    wait({timeout:15,interval:1}) do
      txt = text('Toca para continuar')
      if txt.displayed?
        sleep (3)
        txt.click 
        sleep(3)
      end
    end
  rescue  
    puts 'NO MARKET INGAME TUTORIAL'
  end   
end

Then(/^I should go to the world tour overview$/) do
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/menu_position_5').click
end

Then(/^I should go to each competitions section$/) do
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/menu_position_6').click
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/submenu_forthcoming').click
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/submenu_league').click
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/submenu_gmcup').click
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/submenu_champions').click
end

Then(/^finally I should get into each Club section$/) do
  click_side_menu
  sidemenu_go_to_initial
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/menu_position_7').click
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/submenu_ticket_prices').click
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/submenu_sponsors').click
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/submenu_financial_report').click
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/submenu_kits').click
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/submenu_trophy_room').click
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/submenu_profile').click
  begin
    wait({timeout:15,interval:1}) do
      txt = text('ACEPTAR')
      if txt.displayed?
        sleep (3)
        txt.click 
        sleep(3)
      end
    end
  rescue 
    puts 'no popup'
  end
  click_side_menu
  sidemenu_go_to_initial
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/menu_position_0').click
end

def click_side_menu
  begin
    find_element(:id => $d_caps[:caps][:bundleId] + ':id/actionbar_title').click
  rescue
    puts "Can't deploy side menu"
  end
end

def sidemenu_go_to_initial
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/menu_back').click
end


#######################
#  Navigation issues check
#######################

Then(/^I should check if the navigation trainings line up works well$/) do
  sleep 10
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/menu_position_3').click
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/menu_position_2').click
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/submenu_line_up').click
  begin
    wait({timeout:10,interval:1}) do
      txt = text('TRATAR')
      if txt.displayed?
        sleep (3)
        txt.click 
        sleep(3)
      end
    end
    find_element(:id => 'android:id/up').click
  rescue
    puts ' No injured players '
  end
  back
end

Then(/^I should check if trainings navigation to market works well$/) do
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/menu_position_3').click
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/menu_position_4').click
  back
end

Then(/^I should check if trainings visiting a specific section works well$/) do
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/menu_position_3').click
  sleep 10
  begin
    find_element(:id => $d_caps[:caps][:bundleId] + ':id/attack_training_view').click
    sleep 10
    back
  rescue
    puts 'pre season or pre match'
  end
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/menu_position_0').click
end

Then(/^I should check if competitions league and then go back works well$/) do
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/menu_position_6').click
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/submenu_league').click
  back
end

Then(/^I should check if market purchases with videos works well$/) do
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/menu_position_4').click
  sleep 20
  touch_action = Appium::TouchAction.new
  touch_action.press(x: 150, y: 510).perform
  touch_action.release(x: 150, y: 510).perform
  sleep 5
  begin
    text('ENTRAR').click
  rescue
    text_exact('1').click
  end
  begin 
    wait({timeout:15,interval:1}) do
      txt = text('Toca para continuar')
      if txt.displayed?
        sleep (3)
        txt.click 
        sleep(3)
      end
    end
  rescue
    puts 'no ingame tutorial'
  end
  back
  back
end

Then(/^I should check if market direct purchases works well$/) do
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/menu_position_4').click
  sleep 10
  text('FICHAJE').click
  sleep 10
  touch_action = Appium::TouchAction.new
  touch_action.press(x: 150, y: 310).perform
  touch_action.release(x: 150, y: 310).perform
  sleep 10
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/golden_button_title').click
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/txt_btn_bottom').click
  begin
    wait({timeout:30,interval:1}) do
      find_element(:id => $d_caps[:caps][:bundleId] + ':id/txt_emotional_call_to_action').click
    end
    begin
      wait({timeout:10,interval:1}) do
        txt = text('TRATAR')
        if txt.displayed?
          sleep (3)
          txt.click 
          sleep(3)
        end
      end
      find_element(:id => 'android:id/up').click
    rescue
      puts ' No injured players '
    end
  rescue
    puts 'no emotional received :('
    back
  end
  back
end

Then(/^I should check if perform a substitution works well$/) do
  click_side_menu
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/menu_position_2').click
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/submenu_line_up').click
  begin
    wait({timeout:10,interval:1}) do
      txt = text('TRATAR')
      if txt.displayed?
        sleep (3)
        txt.click 
        sleep(3)
      end
    end
    find_element(:id => 'android:id/up').click
  rescue
    puts ' No injured players '
  end
  sleep 5
  touch_action = Appium::TouchAction.new
  $element_1 = find_element(:id => $d_caps[:caps][:bundleId] + ':id/cb1')
  element_2 = find_element(:id => $d_caps[:caps][:bundleId] + ':id/cb3')
  touch_action.swipe(:start_x => $element_1.location.x, :start_y => $element_1.location.y, :duration => 2000, :end_x => element_2.location.x, :end_y => element_2.location.y).perform
end

Then(/^I should check if perform a player sale works well$/) do
  $element_1.click
  back
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/img_left_drawer_indicator').click
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/player_view').click
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/btn_sell').click
  find_element(:id => $d_caps[:caps][:bundleId] + ':id/btn_action').click
  back
end