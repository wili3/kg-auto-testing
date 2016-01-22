Feature: Logout
  As a iOS user
  I want to logout
  So that I can gtfo from here

Scenario: Logout
  Given I have the App running with appium
  When click logout button
  Then I should navigate to the landing