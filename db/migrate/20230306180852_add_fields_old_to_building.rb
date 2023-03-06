class AddFieldsOldToBuilding < ActiveRecord::Migration[7.0]
  def change
    add_column :buildings, :old_manager_name, :text, array: true, default: []
  end
end
