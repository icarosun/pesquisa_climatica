class User 
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :login, type: String
  field :password_digest, type: String
  field :admin, type: Boolean, default: false

  has_secure_password

  validates :login, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: :password_digest_changed?
end
