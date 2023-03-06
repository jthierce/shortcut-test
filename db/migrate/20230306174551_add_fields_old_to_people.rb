class AddFieldsOldToPeople < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :old_email, :text, array: true, default: []
    add_column :people, :old_mobile_phone_number, :text, array: true, default: []
    add_column :people, :old_home_phone_number, :text, array: true, default: []
    add_column :people, :old_address, :text, array: true, default: []
  end
end
