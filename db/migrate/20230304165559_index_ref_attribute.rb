class IndexRefAttribute < ActiveRecord::Migration[7.0]
  def change
    add_index :people, :reference
    add_index :buildings, :reference
  end
end
