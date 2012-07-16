FactoryGirl.define do
	factory :user do
		sequence(:name) { |n| "Person #{n}"}
		sequence(:email) { |n| "person_#{n}@rubynews.com"}
		password "qinqin10"
		password_confirmation "qinqin10"

		factory :admin do
			admin true
		end
	end	
end