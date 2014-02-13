class CreateGithubStatuses < ActiveRecord::Migration
  def change
    create_table :github_statuses do |t|
      t.string :code
      t.datetime :last_updated_at

      t.timestamps
    end

    add_index :github_statuses, :last_updated_at
  end
end
