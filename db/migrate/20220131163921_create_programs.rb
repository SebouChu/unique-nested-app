class CreatePrograms < ActiveRecord::Migration[6.1]
  def change
    create_table :programs, id: :uuid do |t|
      t.string :title

      t.timestamps
    end
  end
end
