@javascript @stripe

Feature: Add dish to order
  As a buying User,
  In order to purchase a dish
  I need to be able to first add the dish to my order list

  Background:
    Given the following dishes exists
      | name      | description                                               | price | ready_time | portions |    lat        |     lng       |
      | meatballs | homecooked with love, including mashed potatoes and sauce |   4   | 18:00      | 10       | 35.5332005    |  -79.179632   |
      | taco      | really spicy authentic mexican tacos                      |   5   | 16:00      | 10       | 35.5332005    |  -79.179632   |
    And that there is a session with data lng and lat
    And that there is a user logged in with an email of "emaile@random.com"
    And I am on the "landing" page

  Scenario: Successfully add dish to order
    When I click the "Add dish" button for "taco"
    Then I should see "Successfully added to order"
    And "taco" should be added to the last order

  Scenario: Successfully adds two dishes to order
    When I click the "Add dish" button for "taco"
    And I click the "Add dish" button for "meatballs"
    Then there should be "2" items on the last order


  Scenario: Portions should drop upon purchase
    When I click the "Add dish" button for "taco"
    And I click the "Add dish" button for "meatballs"
    And I go to the "Checkout" page
    And I click the stripe button
    And I fill in my card details on the stripe form
    And I submit the stripe form
    And I should see "Thanks, you paid $9.00!" on the order confirmation page
    And I go to the "landing" page
    Then I should see "9 portions left" for "taco"
    And I should see "9 portions left" for "meatballs"

