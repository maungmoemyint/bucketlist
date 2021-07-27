class AddPhotourlToIdea < ActiveRecord::Migration[5.1]
  def change
    add_column :ideas, :photo_url, :string
  end
end
