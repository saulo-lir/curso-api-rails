require 'rails_helper'

# Define a classe que iremos testar
describe V1::ContactsController, type: :controller do
    # Testando uma requisição get para a index, e esperando que o retorno do status seja igual a 200
    it 'request index and return 200 OK' do # Aqui descrevemos livremente qual teste estamos fazendo
        get :index
        expect(response.status).to eql(200)
        # Ou expect(response.status).to have_http_status(200)
        # Ou podemos usar o símbolo referente ao status. Ex.: :ok 
    end
end