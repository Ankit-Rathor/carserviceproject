class Car < ApplicationRecord
  #Assosiation
  belongs_to :user
  has_many :bookings
end
