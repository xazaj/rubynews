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
			before { sign_in user }

			it { should have_selector('title', text: user.name) }

			it { should have_link('用户', href: users_path) }
			it { should have_link('个人信息', href: user_path(user)) }
			it { should have_link('设置', href: edit_user_path(user)) }
			it { should have_link('登出', href: signout_path) }

			it { should_not have_link('登录', href: signin_path) }

			describe "followed by signout" do
				before { click_link "登出" }
				it { should have_link('登录') }
			end
		end
	end

	describe "authentication" do

		describe "for non-signed-in users" do
			let(:user) { FactoryGirl.create(:user) }

			describe "when attempting to visit a protected page" do
				before do
					visit edit_user_path(user)
					fill_in "Email", with: user.email
					fill_in "Password", with: user.password
					click_button "登录"
				end

				describe "after signing in" do

					it "should render the desired protected page" do
						page.should have_selector('title', text: full_title('编辑用户'))
					end
				end
			end

			describe "in the users controller" do

				describe "visiting the edit page" do
					before { visit edit_user_path(user) }
					it { should have_selector('title', text: '登录') }
				end


				describe "submitting to the update action" do
					before { put user_path(user) }
					specify { response.should redirect_to(signin_path) }
				end

				describe "visiting the user index" do
					before { visit users_path }
					it { should have_selector('title', text: '登录') }
				end
			end
		end

		describe "as wrong user" do
			let(:user) { FactoryGirl.create(:user) }
			let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }

			before { sign_in user }

			describe "visiting User#edit page" do
				before { visit edit_user_path(wrong_user) }
				it { should_not have_selector('title', text: full_title('编辑用户')) }
			end

			describe "submitting a PUT request to the Users@update action" do
				before { put user_path(wrong_user) }
				specify { response.should redirect_to(root_path) }
			end
		end

		describe "as non-admin user" do
			let(:user) { FactoryGirl.create(:user) }
			let(:non_admin) { FactoryGirl.create(:user) }

			before { sign_in non_admin }

			describe "submitting a DELETE request to the Users#destroy action" do
				before { delete user_path(user) }
				specify { response.should redirect_to(root_path) }
			end
		end
	end
end
