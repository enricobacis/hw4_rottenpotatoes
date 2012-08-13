Feature: Manage Movies (Create / Delete)

  As a movie buff
  So that I can edit the information in the database
  I want to be able to create and delete movies

Scenario: create a movie
  Given I am on the new movie page
  When I fill in "Title" with "Brand New Movie"
  And I press "Save Changes"
  Then I should be on the home page
  And I should see "Brand New Movie was successfully created"

Scenario: delete a movie
  Given the following movies exist:
  | title           | rating | director     | release_date |
  | Brand New Movie | G      | Me           |   1989-10-08 |
  Given I am on the details page for "Brand New Movie"
  When I press "Delete"
  Then I should be on the home page
  And I should see "Movie 'Brand New Movie' deleted" 
