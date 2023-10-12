class Car < ApplicationRecord
  #Assosiation
  belongs_to :user
  has_many :bookings, dependent: :destroy

  #validation
  validates :number, uniqueness: true
end
