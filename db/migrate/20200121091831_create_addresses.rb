class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :postal_code , default: ""
      t.integer :prefecture , default: 0
      t.string :city , default: ""
      t.string :block_number , default: ""
      t.string :building , default: ""
      t.reference :user , forign_key: true
      t.timestamps
    end
  end
end
