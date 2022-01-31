class CreateRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :roles, id: :uuid do |t|
      t.text :description
      t.integer :position
      t.references :target, polymorphic: true, type: :uuid

      t.timestamps
    end
  end
end
