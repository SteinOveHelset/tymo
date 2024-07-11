class ChangeFieldsNotNullInModels < ActiveRecord::Migration[7.1]
  def change
    change_column_null :clients, :title, false
    change_column_null :clients, :description, false
    change_column_null :projects, :title, false
    change_column_null :clients, :description, false
    change_column_null :teams, :title, false
    change_column_null :entries, :description, false
    change_column_null :entries, :start_time, false
    change_column_null :entries, :end_time, false
    change_column_null :users, :email, false
    change_column_null :users, :password_digest, false
  end
end
