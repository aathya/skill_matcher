class CreateWorkerProfessions < ActiveRecord::Migration[5.1]
  def change
    create_table :worker_professions do |t|
      t.references :profession, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Rake::Task['create:professions'].execute
        Rake::Task['create:workers'].execute
        Rake::Task['create:customers'].execute
      end
    end
  end
end
