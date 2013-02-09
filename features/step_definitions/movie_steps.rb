Given /the following movies exist/ do |movies_table|
  @all_ratings = []
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    @all_ratings << movie[:rating]
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  pending
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  ratings = rating_list.split(", ")
  if uncheck.nil?
    ratings.each { |rating| check("ratings_" + rating) }
  else
    ratings.each { |rating| uncheck("ratings_" + rating) }
  end
end

Then /I should( not)? have: (.*) in the rating column/ do |not_given, ratings|
  rating_list = ratings.split(", ")
  rating_elems = page.all('#movies tbody tr td[2]')
  returned = rating_elems.map { |elem| elem.text }

  if not_given.nil?
    rating_list.each { |rating| assert returned.include?(rating) }
  else
    rating_list.each { |rating| assert (not returned.include?(rating)) }
  end
end

When /^I check all the ratings$/ do
  @checked_ratings = @all_ratings
end

Then /^I should see all ratings in the rating column$/ do
  rating_elems = page.all('#movies tbody tr td[2]')
  returned = rating_elems.map { |elem| elem.text }

  @checked_ratings.each { |rating| assert returned.include?(rating) }
end



# Add a declarative step here for populating the DB with movies.

  # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.

    # Make sure that one string (regexp) occurs before or after another one
#   on the same page

#  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #flunk "Unimplemented"

  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
# HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb

  # Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"