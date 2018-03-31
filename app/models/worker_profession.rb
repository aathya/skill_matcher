class WorkerProfession < ApplicationRecord

  belongs_to :profession, inverse_of: :worker_professions
  belongs_to :user, inverse_of: :worker_professions

  validates_uniqueness_of :profession_id, scope: [:user_id]

end
