namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do

    puts "Cadastrando Tipos de Contatos..."

    kinds = %w(Amigo Comercial Conhecido)

    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end

    puts "Tipos Contatos cadastrados!"

    puts "Cadastrando os Contatos..."

    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between_except(from: 20.year.ago, to: 1.year.from_now, excepted: Date.today),
        kind: Kind.all.sample
      )
    end

    puts "Contatos cadastrados!"

    puts "Cadastrando os Telefones..."

    Contact.all.each do |contact|
      Random.rand(5).times do |i|
        phone = Phone.create!(number: Faker::PhoneNumber.cell_phone)
        contact.phones << phone
      end
    end

    puts "Telefones cadastrados!"
  end

end
