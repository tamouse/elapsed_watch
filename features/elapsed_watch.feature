Feature: My bootstrapped app kinda works
  In order to get going on coding my awesome app
  I want to have aruba and cucumber setup
  So I don't have to do it myself

  @announce
  Scenario: App just runs
    When I get help for "elapsed_watch"
    Then the exit status should be 0
    And the banner should be present
    And the banner should document that this app takes options
    And the following options should be documented:
      |--version|
    And the banner should document that this app's arguments are:
      |event_file|

  @announce
  Scenario: Events are shown
    Given a file named "my_events" with:
    """
Event One: <%= (Time.now-(10*24*60*60)).strftime "%Y-%m-%d %H:%M:%S" %>
Event Two: <%= (Time.now+(10*24*60*60)).strftime "%Y-%m-%d %H:%M:%S" %>
    """
    When I run `elapsed_watch my_events`
    Then the exit status should be 0
    And the output should contain "Event One"
    And the output should contain "Event Two in "
  
