Given(/^I have the App running with appium$/) do
  begin
    $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[4]/UIAAlert[1]/UIACollectionView[1]/UIACollectionCell[1]')).click()
  rescue
    puts 'rescued'
  end
end

When(/^click help button$/) do
  begin 
    wait{ find_element(:xpath => '//UIAApplication[1]/UIAWindow[2]/UIANavigationBar[1]/UIAButton[1]').click} if !is_real_device($d_caps)
    puts 'dont wait'
    wait{ $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIAButton[3]')).click()}
  rescue
    wait{ $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIAButton[3]')).click()}
  end
end

Then(/^I should see a popup with the title "([^"]*)" ont the top of the pop up$/) do |arg1|
  puts 'It matches!(Y)' if arg1 == $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIAStaticText[2]')).value
end

Then(/^clicking the close button I should not see this popup anymore$/) do
  $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIAButton[4]')).click()
end

#LOGIN

Then(/^I should log\-in$/) do
  begin
    $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIAButton[6]')).click #this shoulñd be checked
  rescue
    begin
      $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIAButton[6]')).click 
    rescue
      puts 'No GM News'
    end
  end
  $driver_instance.manage.timeouts.implicit_wait = 0
end

Then(/^I should be in the dashboard$/) do
  $driver_instance.manage.timeouts.implicit_wait = 10
  puts 'Dashboard loaded successfully' if $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIANavigationBar[2]/UIAImage[2]')).enabled? && $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIANavigationBar[2]/UIAImage[3]')).enabled?
  $driver_instance.manage.timeouts.implicit_wait = 0
  begin
    execute_script('mobile: tap', {:x => 300, :y => 300}) if !is_real_device($d_caps)
    text("Next Match")
  rescue
    puts 'has no season'
    $has_season = false
  end
end

#LOGOUT

When(/^click logout button$/) do
  $driver_instance.manage.timeouts.implicit_wait = 0
  $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIANavigationBar[2]/UIAButton[1]')).click
  $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIANavigationBar[2]/UIAButton[3]')).click
  $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIAScrollView[2]/UIAButton[2]')).click
  $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIAButton[9]')).click
end

Then(/^I should logout$/) do
  wait{ $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIAButton[3]'))}
  #driver_quit
end

#LOGIN WITHOUT FACEBOOK APP

When(/^click play fbbutton$/) do
  facebook_app_installed = app_installed? 'com.facebook'
  puts 'gone through good path' if facebook_app_installed

  #wait{ find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[2]/UIANavigationBar[1]/UIAButton[1]')).click} if !is_real_device($d_caps)

  if !facebook_app_installed
    wait{ $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIAButton[2]')).click}
    $driver_instance.manage.timeouts.implicit_wait = 5

    begin
      web_element = wait{ find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAScrollView[1]/UIAWebView[1]/UIAButton[1]'))}
      $driver_instance.manage.timeouts.implicit_wait = 0
      raise if web_element.name == 'Cancelar'
      user_cell_element = find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAScrollView[1]/UIAWebView[1]/UIATextField[1]'))
      execute_script('mobile: tap', {:x => user_cell_element.location.x, :y => user_cell_element.location.y})
      # execute_script('mobile: tap', {:x => user_cell_element.location.x, :y => user_cell_element.location.y})
      
      # editing_menu = find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[5]/UIAEditingMenu[1]/UIAElement[4]'))
      # execute_script('mobile: tap', {:x => editing_menu.location.x, :y => editing_menu.location.y})
      type($user)

      passwd_cell_element = find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAScrollView[1]/UIAWebView[1]/UIASecureTextField[1]'))
      execute_script('mobile: tap', {:x => passwd_cell_element.location.x, :y => passwd_cell_element.location.y})
      # execute_script('mobile: tap', {:x => passwd_cell_element.location.x, :y => passwd_cell_element.location.y})

      # editing_menu = find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[5]/UIAEditingMenu[1]/UIAElement[3]'))
      # execute_script('mobile: tap', {:x => editing_menu.location.x, :y => editing_menu.location.y})
      type($passwd)

      execute_script('mobile: tap', {:x => web_element.location.x, :y => web_element.location.y})

      wait{button('Aceptar')}
      web_element = button('Aceptar')
      execute_script 'mobile: tap', :x => web_element.location.x, :y => web_element.location.y
      check_something_went_wrong
    rescue
      puts 'rescued'
      web_element = button('Aceptar')
      execute_script 'mobile: tap', :x => web_element.location.x, :y => web_element.location.y
      check_something_went_wrong
    end
  else
    wait{ $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIAButton[2]')).click}
    begin
      $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[4]/UIAAlert[1]/UIACollectionView[1]/UIACollectionCell[1]')).click()
      $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIAButton[2]')).click()
      $driver_instance.manage.timeouts.implicit_wait = 10
    rescue
      puts 'rescued'
      $driver_instance.manage.timeouts.implicit_wait = 10
    end
  end
end

When(/^click play fbbutton with user "([^"]*)" and password "([^"]*)"$/) do |arg1, arg2|
  facebook_app_installed = app_installed? 'com.facebook'
  puts 'gone through good path' if facebook_app_installed
  $real_user = $user
  $user = arg1 # in order to be able to verify the name in the menu

  #wait{ find_element(:xpath => '//UIAApplication[1]/UIAWindow[2]/UIANavigationBar[1]/UIAButton[1]').click} if !is_real_device($d_caps)

  if !facebook_app_installed
    wait{ $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIAButton[2]')).click}
    $driver_instance.manage.timeouts.implicit_wait = 5

    begin
      web_element = wait{ find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAScrollView[1]/UIAWebView[1]/UIAButton[1]'))}
      $driver_instance.manage.timeouts.implicit_wait = 0
      raise if web_element.name == 'Cancelar'
      user_cell_element = find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAScrollView[1]/UIAWebView[1]/UIATextField[1]'))
      execute_script('mobile: tap', {:x => user_cell_element.location.x, :y => user_cell_element.location.y})
      # execute_script('mobile: tap', {:x => user_cell_element.location.x, :y => user_cell_element.location.y})
      if ENV["AVOID_WRITTING"] == nil
        # editing_menu = find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[5]/UIAEditingMenu[1]/UIAElement[4]'))
        # execute_script('mobile: tap', {:x => editing_menu.location.x, :y => editing_menu.location.y})
        type(arg1)

        passwd_cell_element = find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAScrollView[1]/UIAWebView[1]/UIASecureTextField[1]'))
        execute_script('mobile: tap', {:x => passwd_cell_element.location.x, :y => passwd_cell_element.location.y})
        # execute_script('mobile: tap', {:x => passwd_cell_element.location.x, :y => passwd_cell_element.location.y})

        # editing_menu = find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[5]/UIAEditingMenu[1]/UIAElement[3]'))
        # execute_script('mobile: tap', {:x => editing_menu.location.x, :y => editing_menu.location.y})
        type(arg2)

        execute_script('mobile: tap', {:x => web_element.location.x, :y => web_element.location.y})
      end
      wait{button('Aceptar')}
      web_element = button('Aceptar')
      execute_script 'mobile: tap', :x => web_element.location.x, :y => web_element.location.y
      #we should check the something went wrong error message after tap the 'Accept' button
      check_something_went_wrong

      begin
        wait_with_timeout(5,text("WELCOME MANAGER!")) if !Cucumber.wants_to_quit
      rescue
        puts 'user already created' if !Cucumber.wants_to_quit
        $user_already_created = true if !Cucumber.wants_to_quit
      end
      puts 'waiting....1' if !Cucumber.wants_to_quit
    rescue
      puts 'rescued'

      web_element = button('Aceptar')
      execute_script 'mobile: tap', :x => web_element.location.x, :y => web_element.location.y
      check_something_went_wrong
      begin
        wait{text("WELCOME MANAGER!")} if !Cucumber.wants_to_quit
      rescue
        puts 'user already created' if !Cucumber.wants_to_quit
        $user_already_created = true if !Cucumber.wants_to_quit
      end
      puts 'waiting....2'

      #we should check the something went wrong error message after tap the 'Accept' button
    end
  else
    wait{ $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIAButton[2]')).click}
    begin
      $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[4]/UIAAlert[1]/UIACollectionView[1]/UIACollectionCell[1]')).click()
      $driver.find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIAButton[2]')).click()
    rescue
      puts 'rescued'
    end
  end
end

Then(/^I should complete the signup process$/) do
  wait(opts = {timeout:5})do
    find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIAImage[2]')) 
  end
  find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIAImage[2]')).click
  #passes first step
  wait{find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIAScrollView[1]/UIAImage[3]')).click} #opens pics clipboard
  wait{find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIACollectionView[1]/UIACollectionCell[8]/UIAImage[1]')).click}
  #clicks a pic
  action = Appium::TouchAction.new
  element = find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIAScrollView[1]/UIAStaticText[8]'))
  action.swipe(:start_x => 150, :start_y => 600, :end_x => 350, :end_y => 600, :duration => 500).perform #not working on ipad because of hardcoded values
  #sign up step 2 sipe action
  wait{text('BUDGET')}
  find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIAImage[2]')).click
  #tap suitcase
  wait{text('PREPARE EVERY MATCH!')}
  wait{find_element(:xpath => delegate_xpath('//UIAApplication[1]/UIAWindow[1]/UIAImage[4]')).click}
  #tap blackboard
  wait{text("LET’S MAKE HISTORY!")}
  wait{button('START PLAYING!').click}
  #complete lst step
  wait{text($user.split('_').first.concat("'s Club"))}
  $user = $real_user
  close_menu
  # Write code here that turns the phrase above into concrete actions
end


#touch_action = Appium::TouchAction.new
#element  = find_element :name, 'Buttons, Various uses of UIButton'
#touch_action.press(element: element, x: 10, y: 10).perform => it works for web elements and seems that this is the good way