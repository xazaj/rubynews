#encoding=UTF-8
require 'spec_helper'

describe "Static Pages" do
    subject { page }

    it "should have the right links" do
        visit root_path
        click_link "关于"
        page.should have_selector 'title', text: full_title('关于')
        click_link "帮助"
        page.should have_selector 'title', text: full_title('帮助')
        click_link "联系我们"
        page.should have_selector 'title', text: full_title('联系我们')
        click_link "RubyNews"
        page.should have_selector 'title', text: full_title('')
        click_link "首页"
        click_link "现在注册！"
        page.should have_selector 'title', text: full_title('注册')       
    end
    
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
