class Codigo
  include Mongoid::Document
  include Mongoid::Timestamps
  field :codigo, type: String
  field :utilizado, type: Mongoid::Boolean, default: false

  index({ codigo: 1}, unique: true)

  validates :codigo, presence: true, uniqueness: true
end
