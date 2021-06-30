namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do

    puts "Cadastrando os Contatos..."

    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between_except(from: 20.year.ago, to: 1.year.from_now, excepted: Date.today)
      )
    end

    puts "Contatos cadastrados!"
  end

end
