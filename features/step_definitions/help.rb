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
  wait{text('7').click} if device_is_android?
  wait{button('CERRAR SESIÓN').click} if device_is_android?
  wait{find_element(:xpath => "//android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.RelativeLayout[1]/android.widget.TextView[5]").click} if device_is_android?

  open_sidemenu if !device_is_android?
  find_element(:name => '7').click if !device_is_android?
  button('CERRAR SESIÓN').click if !device_is_android?
  button('CERRAR SESIÓN').click if !device_is_android?
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

def open_sidemenu
  begin 
    button_exact("€0").click
  rescue
    puts "Can't open sidemenu"
  end
end

def close_sidemenu
  begin

  rescue

  end
end

def go_initial_sidemenu
  text_exact('y').click
end


#######################
#  General Navigation
#######################

When(/^the dashboard is loaded$/) do

end

Then(/^I should navigate to each section which is in the sidemenu$/) do
  
end

Then(/^to the line up$/) do
  open_sidemenu
  text_exact('K').click
  text_exact('1').click
  button_exact("€1").click
end

Then(/^I should go back to stats$/) do
  text_exact('I').click
  button_exact("€I").click
  go_initial_sidemenu
end

Then(/^I should go to trainings$/) do
  text_exact('Entrenamientos').click
  button_exact('€2').click
end

Then(/^I should go to the market$/) do
  text_exact('Mercado').click
  begin
    wait({timeout:15,interval:1}) do
      txt = text('Toca para continuar')
      if txt.displayed?
        sleep (2)
        txt.click 
        sleep (2)
      end
    end 
    begin 
      wait({timeout:15,interval:1}) do
      txt = text('Toca para continuar')
        if txt.displayed?
          sleep (2)
          txt.click 
          sleep (2)
        end
      end 
    rescue
      puts 'only one market ingame tutorial'
    end
  rescue
    puts 'no Market ingame tutorial'
  end
  button_exact('€3').click
end

Then(/^I should go to the world tour overview$/) do
  text_exact("Gira mundial").click
  button_exact('€à').click
end

Then(/^I should go to each competitions section$/) do
  text_exact("Competiciones").click
  text_exact("Próximos partidos").click
  button_exact("€A").click
  text_exact("Liga").click
  button_exact("€!").click
  text_exact("Copa GM").click
  button_exact("€\"").click
  text_exact("Champions League").click
  button_exact("€#").click
  go_initial_sidemenu
end

Then(/^finally I should get into each Club section$/) do
  text_exact("Club").click
  text_exact("Precio entradas").click
  button_exact("€g").click
  text_exact("Patrocinadores").click
  button_exact("€<").click
  begin
    find_element(:xpath => '//UIAApplication[1]/UIAWindow[2]/UIAButton[3]').click
  rescue
    puts 'already signed sponsors'
  end
  text_exact("Informe financiero").click
  button_exact("€;").click
  text_exact("Equipaciones").click
  button_exact("€ì").click
  text_exact("Sala de trofeos").click
  button_exact("€(").click
  text_exact("Perfil del club").click
  button("Aceptar").click
  button_exact("€:").click
  go_initial_sidemenu
end
