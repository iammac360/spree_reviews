# Add access to reviews/ratings to the product model
Spree::Product.class_eval do
  has_many :reviews

  attr_accessible :avg_rating, :avg_rating_quality, :avg_rating_appearance, :avg_rating_price, :reviews_count

  def stars
    avg_rating.round
  end

  def quality_stars
    avg_rating_quality.round
  end

  def appearance_stars
    avg_rating_appearance.round
  end

  def price_stars
    avg_rating_price.round
  end
end
