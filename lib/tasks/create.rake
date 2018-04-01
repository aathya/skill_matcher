namespace :create do
  task professions: :environment do
    100.times do
      Profession.create(name: Faker::Job.field)
    end
  end

  task workers: :environment do
    professions = Profession.all.ids
    100.times do |i|
      user = User.create(first_name: Faker::Name.first_name,
                         last_name: Faker::Name.last_name,
                         email: "user#{i}@email.com",
                         profile_type: 'worker')
      if user.persisted?
        user.worker_professions.create(profession_id: professions.sample)
      end
    end
  end

  task customers: :environment do
    1000.times do
      name = Faker::Name.first_name
      User.create(first_name: name,
                         last_name: Faker::Name.last_name,
                         email: "#{name.downcase}@email.com")
    end
  end
end