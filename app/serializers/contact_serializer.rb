# Para criar esse serializer: rails g serializer contact
# Quando o active model serializer está ativo para um determinado model, ele irá sobreescrever a renderização json existente no controller
class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate, :author
  # :author == Atributo extra que podemos informar junto aos demais atributos

  belongs_to :kind, optional: true
  has_many :phones
  has_one :address

  def author
    "Atributo extra"
  end
end
