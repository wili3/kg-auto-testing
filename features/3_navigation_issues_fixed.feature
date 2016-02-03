Feature: Navigation Fixes
  As a Android user
  I want to navigate into GoldenManager app 
  So that I can sign amazing real soccer players without errors

Scenario: Navigate
  Given I have the App running with appium
  When the dashboard is loaded
  Then I should check if the navigation trainings line up works well
  Then I should check if trainings navigation to market works well
  Then I should check if trainings visiting a specific section works well
  Then I should check if competitions league and then go back works well
  Then I should check if market purchases with videos works well
  Then I should check if market direct purchases works well
  Then I should check if perform a substitution works well
  Then I should check if perform a player sale works well