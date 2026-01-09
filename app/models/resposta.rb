class Resposta
  include Mongoid::Document
  include Mongoid::Timestamps

  field :codigo, type: String
  field :respostas, type: Array
  field :comentario_final, type: String

  validates :codigo, presence: true, uniqueness: true
  validates :respostas, presence: true
  validates :comentario_final, length: { maximum: 250 }, allow_blank: true

  validate :respostas_validas
  
  PERGUNTAS_TOTAL = 45

  private

  def respostas_validas
    if respostas.length != PERGUNTAS_TOTAL
      errors.add(:respostas, "quantidade inválida de respostas")
    end

    unless  respostas.all? { |r| (1..4).include?(r) }
      errors.add(:respostas, "respostas devem ser entre 1 e 4")
    end

    unless respostas.is_a?(Array) && respostas.all? { |r| r.is_a?(Integer) }
      errors.add(:respostas, "deve ser um array de inteiros")
    end
  end
end
