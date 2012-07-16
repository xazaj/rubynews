#encoding=UTF-8
require 'spec_helper'

describe "UserPages" do
	
	subject { page }

	describe "index" do
		
		let(:user) { FactoryGirl.create(:user) }

		before(:all) { 30.times {FactoryGirl.create(:user) } }
		after(:all) { 	User.delete_all }

		before(:each) do
			sign_in user
			visit users_path
		end

		it { should have_selector('title', text: '所有用户') }
		it { should have_selector('h1', text: '所有用户') }

		describe "pagination" do

			it { should have_selector('div.pagination') }

			it "should list each user" do
				User.paginate(page: 1).each do |user|
					page.should have_selector('li', text: user.name)
				end
			end
		end

		describe "delete links" do

			it { should_not have_link('delete') }

			describe "as an admin user" do
				let(:admin) {FactoryGirl.create(:admin) }
				before do
					sign_in admin
					visit users_path
				end

				it { should have_link('delete', href: user_path(User.first)) }
				it "should be able to delete another user" do
					expect { click_link('delete') }.to change(User, :count).by(-1)
				end
				it { should_not have_link('delete', href: user_path(admin)) }
			end
		end
	end

	describe "signup page" do
		before { visit signup_path }

		it { should have_selector('h1', text: '注册') }
		it { should have_selector('title', text: full_title('注册')) }
	end 

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }

		it { should have_selector('h1', text: user.name) }
	end

	describe "signup" do

		before { visit signup_path }

		let(:submit) { "注册" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "Name", with: "xazaj"
				fill_in "Email", with: "xazaj@163.com"
				fill_in "Password", with:"qinqin10"
				fill_in "Confirmation", with: "qinqin10"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end
		end
	end

	describe "edit" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit edit_user_path(user) 
		end

		it { should have_selector('h1', text: "更新") }
		it { should have_selector('title', text: "编辑用户") }
		it { should have_link('修改头像', href: 'http://gravatar.com/emails') }

		describe "with invalid information" do
			before { click_button "保存" }

			it { should have_content('error') }
		end

		describe "with valid information" do
			let(:new_name) { "New Name" }
			let(:new_email) { "new@example.com" }
			before do
				fill_in "Name", with: new_name
				fill_in "Email", with: new_email
				fill_in "Password", with: user.password
				fill_in "Confirm Password", with: user.password
				click_button "保存"
			end

			it { should have_selector('title', text:new_name) }
			it { should have_selector('div.alert.alert-success') }
			it { should have_link('登出', href: signout_path) }
			specify { user.reload.name.should == new_name }
			specify { user.reload.email.should == new_email }
		end
	end
end
