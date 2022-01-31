class CreateInvolvements < ActiveRecord::Migration[6.1]
  def change
    create_table :involvements, id: :uuid do |t|
      t.text :description
      t.integer :kind
      t.integer :position
      t.references :person, null: false, foreign_key: true, type: :uuid
      t.references :target, null: false, polymorphic: true, type: :uuid

      t.timestamps
    end
  end
end
