class Address < ApplicationRecord
  belongs_to :user, optional: true

  validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
  validates :phone_number, numericality: { only_integer: true}
  validates :prefecture, :city, :block_number, presence: true
end
