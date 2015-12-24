Feature: Login
  As a Android user
  I want to login into GoldenManager app by g+ provider
  So that I can sign amazing real soccer players

Scenario: Login with G+
  Given I have the App running with appium
  When click login with G+ button
  Then I should navigate to the dashboard