class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  validates_presence_of :first_name, :last_name, :profile_type
  validates :email, presence: true, length: {in: 6..150}, uniqueness: {case_sensitive: false},
            format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates_inclusion_of :profile_type, in: ['customer','worker']


  scope :workers,   -> { where(profile_type: workers) }
  scope :customers, -> { where(profile_type: workers) }

  def customer?
    profile_type == 'customer'
  end

  def worker?
    profile_type == 'worker'
  end
end
