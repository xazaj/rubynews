#encoding=UTF-8
require 'spec_helper'

describe "Static Pages" do
    subject { page }
    
    describe "Home page" do
        before { visit root_path }

    	it { should have_selector('h1', :text => 'RubyNews') }
    	it { should have_selector('title', :text => full_title('')) }
    	it { should_not have_selector('title', :text => '| 首页') }
    end

    describe "Help Page" do
        before { visit help_path }

    	it { should have_selector('h1', :text => '帮助') }
    	it { should have_selector('title', :text => full_title('帮助')) }
    end

    describe "About Pages" do
        before { visit about_path }

    	it { should have_selector('h1', :text => '关于') }
    	it { have_selector('title', :text => full_title('关于')) }
    end

    describe "Contact pages" do
        before { visit contact_path }

    	it { should have_selector('h1', :text => '联系我们') }
    	it { should have_selector('title', :text => full_title('联系我们')) }
    end
end
