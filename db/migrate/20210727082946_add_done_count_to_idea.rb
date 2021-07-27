class AddDoneCountToIdea < ActiveRecord::Migration[5.1]
  def change
    add_column :ideas, :done_count, :integer
  end
end
