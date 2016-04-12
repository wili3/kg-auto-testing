Feature: Navigation Line up
  As a Android user
  I want to line up my players
  So that I can make the best strategy

Scenario: Team
  Given I have the App running with appium
  Then I should navigate to the line up
  And perform a sustitution
  Then I should navigate to the stats section
  And finally I should come back to the dashboard