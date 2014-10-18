class Lista < ActiveRecord::Base
  belongs_to :usuario
  has_many :destinatarios, through: :lista_destinatarios
end
