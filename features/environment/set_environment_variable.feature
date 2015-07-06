@wip
Feature: Set environment variable via "cucumber"-step

  It is quite handy to modify the environment of a process. To make this
  possible, `aruba` provides several steps. One of these is
  `I set the environment variables to:`-step. Using this step sets the values of a
  non-existing variables and overwrites an existing values. Each variable name
  and each value is converted to a string. Otherwise `ruby` would complain
  about an invalid argument.

  Background:
    Given I use the fixture "cli-app"

  Scenario: Set environment variable by using a step
    Given a file named "bin/cli" with:
    """
    #!/usr/bin/env sh

    echo $LONG_LONG_VARIABLE
    """
    And a file named "features/home_variable.feature" with:
    """
    Feature: Environment Variable
      Scenario: Run command
        Given I set the environment variables to:
          | variable           | value      |
          | LONG_LONG_VARIABLE | long_value |
        When I run `cli`
        Then the output should contain:
        \"\"\"
        long_value
        \"\"\"
    """
    When I run `cucumber`
    Then the features should all pass
