class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  has_many :worker_professions, inverse_of: :user
  has_many :professions, through: :worker_professions

  validates_presence_of :first_name, :last_name, :profile_type
  validates :email, presence: true, length: {in: 6..150}, uniqueness: {case_sensitive: false},
            format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates_inclusion_of :profile_type, in: ['customer','worker']

  before_create :set_password

  scope :workers,   -> { where(profile_type: 'worker') }
  scope :customers, -> { where(profile_type: 'customer') }

  scope :search_by_profession,-> (profession_ids) do
    workers
    .joins(:worker_professions)
    .where(worker_professions: {profession_id: profession_ids})
    .distinct
  end

  def customer?
    profile_type == 'customer'
  end

  def worker?
    profile_type == 'worker'
  end

  def name
    "#{first_name} #{last_name}"
  end

  private

  def set_password
    self.password = 'password'
  end

  def password_required?
    false
  end

end
