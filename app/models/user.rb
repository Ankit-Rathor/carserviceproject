class User < ApplicationRecord
  #Authentication
  has_secure_password

 # validation password & email
  validates :email, uniqueness: true
  validates_format_of :password, with: /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$/, multiline: true, message: "must include at least one uppercase letter, one lowecase letter, one digit, and one special character"
  validates_length_of :password, in: 8..10

  #Association
  has_many :cars, dependent:   :destroy
  has_many :bookings, dependent: :destroy
  has_one  :address, dependent: :destroy
  accepts_nested_attributes_for :address
  
  # Enum define role
  enum :role,{customer:0 , admin:1, mechanic:2}
end

