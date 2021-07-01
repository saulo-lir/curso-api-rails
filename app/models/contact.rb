class Contact < ApplicationRecord
    belongs_to :kind, optional: true # Por padrão é obrigatório enviarmos o valor do relacionamento quando ocorrer algum cadastro. O optional: true tira essa obrigatoriedade.
    has_many :phones
=begin
    def author
        "Gandalf"
    end

    def kind_description
        self.kind.description
    end

    def as_json(options={})
        super(
            root:true,
            methods: [:author, :kind_description],
            include: :kind # Incluindo o tipo (kind) do contato na query. Caso fosse um relacionamento 1 * N (has_many), então seria :kinds.
        )


        1- Para incluir itens específicos do kind:

            include: { kind: {only: :description} }

        2- Para incluir o kind como um item de contact e não como um subitem, ou seja, ao invés do resultado ser:

            "contact": {
                "id": 1,
                "name": "Becki Rolfson",
                "email": "kai@cartwright-marquardt.biz",
                "birthdate": "2017-04-01",
                "created_at": "2021-06-30T17:14:51.824Z",
                "updated_at": "2021-06-30T17:14:51.824Z",
                "kind_id": 1,
                "author": "Gandalf",
                "kind": {
                    "id": 1,
                    "description": "Amigo",
                    "created_at": "2021-06-30T17:14:48.418Z",
                    "updated_at": "2021-06-30T17:14:48.418Z"
                }
            }

        mas sim:

        "contact": {
            "id": 1,
            "name": "Becki Rolfson",
            "email": "kai@cartwright-marquardt.biz",
            "birthdate": "2017-04-01",
            "created_at": "2021-06-30T17:14:51.824Z",
            "updated_at": "2021-06-30T17:14:51.824Z",
            "kind_id": 1,
            "author": "Gandalf",
            "kind_description": "Amigo",
        }

        então podemos incluir no method:

        def kind_description
            self.kind.description
        end

        super(
            root:true,
            methods: [:author, :kind_description],
            include: :kind
        )


    end
=end
end
