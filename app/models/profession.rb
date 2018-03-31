class Profession < ApplicationRecord

  has_many :worker_professions, inverse_of: :profession
  has_many :users, through: :worker_professions

  validates :name, presence: true, uniqueness: true

  def self.search_by_name(name)
    find_by('LOWER(professions.name) = ?', name.downcase)
  end

end
