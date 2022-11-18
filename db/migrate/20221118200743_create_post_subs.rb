class CreatePostSubs < ActiveRecord::Migration[7.0]
  def change
    create_table :post_subs do |t|
      t.references :post, foreign_key: true, null: false, index: false
      t.references :sub, foreign_key: true, null: false
      t.index [:post_id, :sub_id], unique: true
      t.timestamps
    end
  end
end
