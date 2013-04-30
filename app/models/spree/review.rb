class Spree::Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user, :class_name => Spree.user_class.to_s
  has_many   :feedback_reviews

  after_save :recalculate_product_rating, :if => :approved?
  after_destroy :recalculate_product_rating

  validates_presence_of     :name, :review
  #validates_numericality_of :rating, :only_integer => true
  validates_numericality_of :quality_rating, :only_integer => true
  validates_numericality_of :appearance_rating, :only_integer => true
  validates_numericality_of :price_rating, :only_integer => true


  default_scope order("spree_reviews.created_at DESC")
  
  scope :localized, lambda { |lc| where('spree_reviews.locale = ?', lc) }

  attr_protected :user_id, :product_id, :ip_address, :approved

  class << self
    def approved
      where(:approved => true)
    end

    def not_approved
      where(:approved => false)
    end

    def approval_filter
      where(["(? = ?) or (approved = ?)", Spree::Reviews::Config[:include_unapproved_reviews], true, true])
    end

    def oldest_first
      order("created_at asc")
    end

    def preview
      limit(Spree::Reviews::Config[:preview_size]).oldest_first
    end
  end

  def feedback_stars
    return 0 if feedback_reviews.size <= 0
    ((feedback_reviews.sum(:rating) / feedback_reviews.size) + 0.5).floor
  end

  def feedback_quality_stars
    return 0 if feedback_reviews.size <= 0
    ((feedback_reviews.sum(:quality_rating) / feedback_reviews.size) + 0.5).floor
  end

  def feedback_appearance_stars
    return 0 if feedback_reviews.size <= 0
    ((feedback_reviews.sum(:appearance_rating) / feedback_reviews.size) + 0.5).floor
  end

  def feedback_price_stars
    return 0 if feedback_reviews.size <= 0
    ((feedback_reviews.sum(:price_rating) / feedback_reviews.size) + 0.5).floor
  end

  def recalculate_product_rating
    reviews_count = product.reviews.reload.approved.count

    if reviews_count > 0
      product.avg_rating = product.reviews.approved.sum(:rating).to_f / reviews_count
      product.avg_rating_quality = product.reviews.approved.sum(:quality_rating).to_f / reviews_count
      product.avg_rating_appearance = product.reviews.approved.sum(:appearance_rating).to_f / reviews_count
      product.avg_rating_price = product.reviews.approved.sum(:price_rating).to_f / reviews_count
      product.reviews_count = reviews_count
      product.save
    else
      product.update_attribute(:avg_rating, 0)
    end
  end
end
