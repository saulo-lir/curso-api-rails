class Contact < ApplicationRecord
    belongs_to :kind

    def author
        "Gandalf"
    end

    def as_json(options={})
        super(methods: :author, root:true)
    end
end
