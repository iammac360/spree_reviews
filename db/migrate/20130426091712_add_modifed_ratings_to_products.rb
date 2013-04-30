class AddModifedRatingsToProducts < ActiveRecord::Migration
  def self.up
    if table_exists?('products')
      add_column :products, :avg_rating_quality, :decimal, :default => 0.0, :null => false, :precision => 7, :scale => 5
      add_column :products, :avg_rating_appearance, :decimal, :default => 0.0, :null => false, :precision => 7, :scale => 5
      add_column :products, :avg_rating_price, :decimal, :default => 0.0, :null => false, :precision => 7, :scale => 5
    elsif table_exists?('spree_products')
      add_column :spree_products, :avg_rating_quality, :decimal, :default => 0.0, :null => false, :precision => 7, :scale => 5
      add_column :spree_products, :avg_rating_appearance, :decimal, :default => 0.0, :null => false, :precision => 7, :scale => 5
      add_column :spree_products, :avg_rating_price, :decimal, :default => 0.0, :null => false, :precision => 7, :scale => 5
    end
  end

  def self.down
    if table_exists?('products')
      remove_column :products, :avg_rating_quality
      remove_column :products, :avg_rating_appearance
      remove_column :products, :avg_rating_price
    elsif table_exists?('spree_products')
      remove_column :spree_products, :avg_rating_quality
      remove_column :spree_products, :avg_rating_appearance
      remove_column :spree_products, :avg_rating_priceavg_rating
    end
  end
end
