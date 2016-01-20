Feature: Navigation
  As a Android user
  I want to navigate into GoldenManager app 
  So that I can sign amazing real soccer players

Scenario: Navigate
  Given I have the App running with appium
  When the dashboard is loaded
  Then I should navigate to each section which is in the sidemenu
  Then to the line up
  Then I should go back to stats
  Then I should go to trainings
  Then I should go to the market
  Then I should go to the world tour overview
  Then I should go to each competitions section
  And finally I should get into each Club section 
