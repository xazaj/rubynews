#coding=UTF-8
include ApplicationHelper

def full_title(page_title)
	base_title = "RubyNews" 
	if page_title.empty?
		base_title
	else
		"#{base_title} | #{page_title}" 
	end
end

def valid_signin(user)
	fill_in "Email", with: user.email 
	fill_in "Password", with: user.password 
	click_button "Sign in"
end

RSpec::Matchers.define :have_error_message do |message| 
	match do |page|
		page.should have_selector('div.alert.alert-error', text: message) 
	end
end

def sign_in(user)
	visit signin_path
	fill_in "Email", with: user.email
	fill_in "Password", with: user.password
	click_button "登录"
	cookies[:remember_token] = user.remember_token
end