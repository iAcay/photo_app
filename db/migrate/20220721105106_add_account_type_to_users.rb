class AddAccountTypeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :account_type, :integer, default: 0, null: false
  end
end
