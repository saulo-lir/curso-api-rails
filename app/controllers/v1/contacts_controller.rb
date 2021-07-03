# Para separar a api em versões, é necessário colocarmos o controller dentro de um module
module V1
  class ContactsController < ApplicationController
    before_action :set_contact, only: %i[ show edit update destroy ]
    skip_before_action :verify_authenticity_token

    # GET /contacts or /contacts.json
    def index
      @contacts = Contact.all
      #render json: @contacts, root:true
      #render json: @contacts, only: [:name, :email]
      #render json: @contacts.map {|contact| contact.attributes.merge({author: "Gandalf"})}

      #render json: @contacts, root:true, include: [:kind, :phones, :address]
      render json: @contacts
=begin
      1- Acessar a rota /contacts.json é equivalente a:

        render json: @contacts

        Quando fazemos isso, siginifica que por baixo dos panos o rails está fazendo:

          @contacts.as_json.to_json (as_json converte pra hash, to_json converte hash pra string json)

      2- Quando adicionamos a opção root:true
      
        render json: @contacts, root:true

        Então será inserido antes de cada conjunto de elementos, o índice dele:

        {
            "contact": {
                "id": 1,
                "name": "Cortez Ryan",
                "email": "fran.haag@hansen-marvin.name",
                "birthdate": "2002-01-09",
                "created_at": "2021-06-30T11:55:11.093Z",
                "updated_at": "2021-06-30T11:55:11.093Z"
            }
        },

        Ou seja, root:true == "contact"

      3- Para exibirmos valores específicos, usamos a opção only ou except

          render json: @contacts, only: [:name, :email]
        Ou
          render json: @contacts, only: %i[ name email]

          render json: @contacts, except: [:birthdate]

      4- Mesclar novos elementos ao objeto / json original:

        Forma tradicional:
          render json: @contacts.map {|contact| contact.attributes.merge({author: "Gandalf"})} 

        Forma mais elegante:

          render json: @contacts, methods: :author

          O método author é definido no model contact

        2º forma mais elegante:

          Sobreescrever no model contact o método as_json, passando o parâmetro methods: :author e qualquer outro que queiramos deixar como default em todas as actions

          def as_json(options={})
            super(methods: :author, root:true)
          end
=end
    end

    # GET /contacts/1 or /contacts/1.json
    def show
      # Renderizando por default no formato json e mesclando o contato com o autor
      # render json: @contact.attributes.merge({author: "Morgoth"})
      render json: @contact
    end

    # GET /contacts/new
    def new
      @contact = Contact.new
    end

    # GET /contacts/1/edit
    def edit
    end

    # POST /contacts or /contacts.json
    def create
      @contact = Contact.new(contact_params)

      respond_to do |format|
        if @contact.save
          format.html { redirect_to @contact, notice: "Contact was successfully created." }
          format.json { render :show, status: :created, location: @contact }

          # status: :created == Representa o status http da requisição. O Rails possui um símbolo para cada status. Nessa request, o símbolo é o :created
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @contact.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /contacts/1 or /contacts/1.json
    def update
      respond_to do |format|
        if @contact.update(contact_params)
          format.html { redirect_to @contact, notice: "Contact was successfully updated." }
          format.json { render :show, status: :ok, location: @contact }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @contact.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /contacts/1 or /contacts/1.json
    def destroy
      @contact.destroy
      respond_to do |format|
        format.html { redirect_to contacts_url, notice: "Contact was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_contact
        @contact = Contact.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def contact_params
        # É necessário incluirmos o kind_id nas permissões (Strong Parameters), bem como qualquer atributo novo que venha a ser adicionado, inclusive os nested_attributes
        params.require("contact").permit(
          :name, :email, :birthdate, :kind_id, 
          phones_attributes: [:id, :number, :_destroy],
          address_attributes: [:id, :street, :city]
        )
      end
  end
end