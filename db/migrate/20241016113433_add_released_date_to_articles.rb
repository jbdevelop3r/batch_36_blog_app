class AddReleasedDateToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :released_date, :string
  end
end
