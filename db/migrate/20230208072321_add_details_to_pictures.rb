class AddDetailsToPictures < ActiveRecord::Migration[6.1]
  def change
    add_column :pictures, :title, :text
    add_column :pictures, :content, :text
  end
end
