class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string :title
      t.text :description
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
