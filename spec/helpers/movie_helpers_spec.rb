require 'spec_helper'

describe MoviesHelper do
  describe 'Odd numbers' do
    it 'should return odd for 3' do
      oddness(3).should == 'odd'
    end
    it 'should return even for 4' do
      oddness(4).should == 'even'
    end
  end
end
