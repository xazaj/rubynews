#encoding=UTF-8
require 'spec_helper'

describe "AuthenticationPages" do

	subject { page }

	describe "signin page" do
		before { visit signin_path }

		it { should have_selector('h1', text: '登录') }
		it { should have_selector('title', text: '登录') }
	end

	describe "signin" do
		before { visit signin_path }

		describe "with invalid information" do
			before { click_button "登录" }

			it { should have_selector('title', text: '登录') }
			it { should have_selector('div.alert.alert-error', text: '错误') }

			describe "after visiting another page" do
				before { click_link "首页" }
				it { should_not have_selector ('div.alert.alert-error') }
			end
		end

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				fill_in "Email", with: user.email
				fill_in "Password", with: user.password
				click_button "登录"
			end

			it { should have_selector('title', text: user.name) }
			it { should have_link('个人信息', href: user_path(user)) }
			it { should have_link('登出', href: signout_path) }
			it { should_not have_link('登录', href: signin_path) }

			describe "followed by signout" do
				before { click_link "登出" }
				it { should have_link('登录') }
			end
		end
	end
end
