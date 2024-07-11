class AddColorToClients < ActiveRecord::Migration[7.1]
  def change
    add_column :clients, :color, :string
  end
end
