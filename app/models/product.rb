class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  has_rich_text :description

  validates :name,
  presence: { message: "Nome do produto é obrigatório" },
  length: { maximum: 100, message: "O nome deve ter no máximo 100 caracteres." }

  validates :price, numericality: { greater_than: 0, message: "O preço deve ser maior que 0" },
  presence: { message: "O preço é obrigatório" }
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }
end
