class UpdateHistories < ActiveRecord::Migration[7.0]
  def change
    add_reference :histories, :user, index: true
    add_foreign_key :histories, :users
  end
end
