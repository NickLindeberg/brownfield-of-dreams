class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.references :tutorial, foreign_key: true
      t.references :video, foreign_key: true
    end
  end
end
