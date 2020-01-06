class CreateDatafiles < ActiveRecord::Migration[6.0]
  def change
    create_table :datafiles do |t|
      t.references :dataset
      t.string :filename
      t.string :content_type
      t.bigint :byte_size
      t.text :metadata
      t.string :checksum

      t.timestamps
    end
  end
end
