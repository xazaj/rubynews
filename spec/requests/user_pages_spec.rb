#encoding=UTF-8
require 'spec_helper'

describe "UserPages" do
	
	subject { page }

	describe "signup page" do
		before { visit signup_path }

		it { should have_selector('h1', text: '注册') }
		it { should have_selector('title', text: full_title('注册')) }
	end 
end
