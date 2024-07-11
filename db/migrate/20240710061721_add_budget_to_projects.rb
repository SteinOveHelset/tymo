class AddBudgetToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :budget, :integer
  end
end
