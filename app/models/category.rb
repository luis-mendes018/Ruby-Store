class Category < ApplicationRecord
  has_many :products

  validates :name,
  presence: { message: "Nome da categoria é obrigatório" },
  length: { maximum: 50, message: "O nome da categoria deve ter no máximo 50 caracteres!"  }
end
