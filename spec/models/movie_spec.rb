require 'spec_helper'

describe Movie do
  describe "All rating for movies" do
    it "return all valid ratings" do
      Movie.all_ratings.should == ["G", "PG", "PG-13", "NC-17", "R"]
    end
  end
end
