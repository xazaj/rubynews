namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		admin = User.create!(name: "admin",
			email: "admin@rubynews.com",
			password: "qinqin10",
			password_confirmation: "qinqin10")
		admin.toggle!(:admin)
		User.create!(name: "xazaj",
			email: "xazaj@rubynews.com",
			password: "qinqin10",
			password_confirmation: "qinqin10")

		99.times do |n|
			name = Faker::Name.name
			email = "xazaj-#{n+1}@rubynews.com"
			password = "qinqin10"
			User.create!(name: name,
						email: email,
						password: password,
						password_confirmation: password)
		end
	end
end