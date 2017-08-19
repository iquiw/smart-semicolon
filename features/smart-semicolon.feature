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
