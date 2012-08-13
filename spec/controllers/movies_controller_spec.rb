require 'spec_helper'
 
describe MoviesController do
  describe 'find similar movies' do
    before :each do
      @fake_results = mock('movie', :id => 1, :title => 'Title', :director => 'me')
    end
    it 'should call the model method that finds movies with the same director' do
      Movie.should_receive(:find).and_return(@fake_results)
      get :similar, {:id => 1}
    end
    describe 'after valid search' do
      before :each do
        Movie.stub(:find).and_return(@fake_results)
        get :similar, {:id => 1}
      end
      it 'should select the Similar Movies view for rendering' do
        response.should render_template(:similar)
      end
      it 'should make the Similar Director results available to that template' do
        movie = Movie.create!(:title => 'RSpec', :rating => 'R', :director => 'me')
        get :similar, { :id => movie.id }
        assigns(:movies).should eq [movie]
      end
    end
    describe 'after not valid search' do
      before :each do
        Movie.stub(:find).and_return(nil)
        get :similar, {:id => 1}
      end
      it 'should redirect to homepage if no director' do
        response.should redirect_to movies_path
      end
    end
  end
end
