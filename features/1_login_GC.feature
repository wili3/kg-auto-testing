Feature: Login
  As a iOS user
  I want to login into GoldenManager app by GC provider
  So that I can sign amazing real soccer players

Scenario: Login with GC
  Given I have the App running with appium
  When click login with GC button
  Then I should navigate to the dashboard