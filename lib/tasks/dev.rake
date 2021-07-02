namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    # Executar comando no terminal
    puts "Resetando o banco de dados..."
    %x(rails db:drop db:create db:migrate)

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

    puts "Cadastrando os Endereços..."

    Contact.all.each do |contact|
      Address.create!(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        contact: contact
      )
    end

    puts "Endereços cadastrados!"
  end

end
