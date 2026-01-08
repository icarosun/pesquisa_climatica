class Codigo
  include Mongoid::Document
  include Mongoid::Timestamps
  field :codigo, type: String
  field :utilizado, type: Mongoid::Boolean, default: false

  index({ codigo: 1}, unique: true)

  validates :codigo, presence: true, uniqueness: true

  def self.gerar(qtd = 1)
    docs = []

    qtd.times do
      docs << {
        codigo: SecureRandom.alphanumeric(6),
        utilizado: false,
        created_at: Time.now,
        updated_at: Time.now,
      }
    end

    collection.insert_many(docs)
  end
end
