Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  p1 = /#{e1}/ =~ page.body ; flunk %Q{"#{e1}" not found} if p1.nil?
  p2 = /#{e2}/ =~ page.body ; flunk %Q{"#{e2}" not found} if p2.nil?
  flunk %Q{"#{e1}" appears after "#{e2}"} if p1 > p2
  #regexp = Regexp.new ".*#{e1}.*#{e2}"
  #page.body.should =~ regexp
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

Given /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(',').each do |rating|
    step %Q{I #{uncheck ? "uncheck" : "check"} "ratings_#{rating.strip}"}
  end
end

Then /I should see all of the movies/ do
  movies_db = Movie.count
  movies_page = page.all('table#movies tbody tr').count
  flunk "Movies in db (#{movies_db}) != Movies in page (#{movies_page})" if movies_db != movies_page
end

Then /I should see ([0-9]+) movies?/ do |movies|
  movies_page = page.all('table#movies tbody tr').count
  flunk "Movies in page: #{movies_page}" if movies.to_i != movies_page
end
