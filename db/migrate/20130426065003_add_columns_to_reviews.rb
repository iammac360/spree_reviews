class AddColumnsToReviews < ActiveRecord::Migration
  def up
    add_column :spree_reviews, :quality_rating, :integer, :default => 0
    add_column :spree_reviews, :appearance_rating, :integer, :default => 0
    add_column :spree_reviews, :price_rating, :integer, :default => 0
  end

  def down
    remove_column :spree_reviews, :quality_rating
    remove_column :spree_reviews, :appearance_rating
    remove_column :spree_reviews, :price_rating
  end
end
