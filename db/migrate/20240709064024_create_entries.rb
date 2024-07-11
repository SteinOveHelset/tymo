class CreateEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :entries do |t|
      t.references :team, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.integer :minutes

      t.timestamps
    end
  end
end
