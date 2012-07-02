#encoding=UTF-8
require 'spec_helper'

describe "Static Pages" do

	let(:base_title) { "RubyNews" }
    
    describe "Home page" do

    	it "should have the h1 'RubyNews'" do
    		visit '/static_pages/home'
    		page.should have_selector('h1', :text => "#{base_title}")
    	end

    	it "should have the title '首页'" do
    		visit '/static_pages/home'
    		page.should have_selector('title', :text => "#{base_title}")
    	end

    	it "should not have the custom page title" do
    		visit '/static_pages/home'
    		page.should_not have_selector('title', :text => '| 首页')
    	end
    end

    describe "Help Page" do

    	it "should have the h1 '帮助'" do
    		visit '/static_pages/help'
    		page.should have_selector('h1', :text => "#{base_title}")
    	end

    	it "should have the title '帮助'" do
    		visit '/static_pages/help'
    		page.should have_selector('title', :text => "#{base_title} | 帮助")
    	end	
    end

    describe "About Pages" do

    	it "should have the h1 'RubyNews'" do
    		visit '/static_pages/about'
    		page.should have_selector('h1', :text => "#{base_title}")
    	end

    	it "should have the title '关于'" do
    		visit '/static_pages/about'
    		page.should have_selector('title', :text => "#{base_title} | 关于")
    	end
    end

    describe "Contact pages" do

    	it "should have the h1 'RubyNews'" do
    		visit '/static_pages/contact'
    		page.should have_selector('h1', :text => "#{base_title}")
    	end

    	it "should have title '联系我们'" do
    		visit '/static_pages/contact'
    		page.should have_selector('title', :text => "#{base_title} | 联系我们")
    	end
    end
end
