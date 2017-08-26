Feature: Insert semicolon smartly
  In order to write program fast
  As a user
  I want to insert semicolon smartly

  Scenario: semicolon should be inserted at eol
    Given the buffer is empty
    When I insert:
    """
    printf("Hello, world")
    """
    And I go to cell (1, 20)
    And I type ";"
    Then I should see:
    """
    printf("Hello, world");
    """
    And the cursor should be at cell (1, 23)

  Scenario: semicolon should be inserted at the current point if there is already at eol
    Given the buffer is empty
    When I insert:
    """
    printf("Hello, world");
    """
    And I go to cell (1, 20)
    And I type ";"
    Then I should see:
    """
    printf("Hello, world;");
    """
    And the cursor should be at cell (1, 21)

  Scenario: semicolon should be inserted at the current point if smart-semicolon-mode is disabled
    Given the buffer is empty
    When I insert:
    """
    printf("Hello, world")
    """
    And I turn off minor mode smart-semicolon-mode
    And I go to cell (1, 20)
    And I type ";"
    Then I should see:
    """
    printf("Hello, world;")
    """
    And the cursor should be at cell (1, 21)

  Scenario: semicolon should be inserted at the current point if it is nestable comment
    Given the buffer is empty
    And I turn on c-mode
    And I turn on smart-semicolon-mode
    When I insert:
    """
    /* this is a comment */

    // this is also a comment */
    """
    And I go to cell (1, 5)
    And I type ";"
    Then I should see "th;is"
    And the cursor should be at cell (1, 6)

    When I go to cell (3, 13)
    And I type ";"
    Then I should see "al;so"
    And the cursor should be at cell (3, 14)
