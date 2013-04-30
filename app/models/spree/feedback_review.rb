class Spree::FeedbackReview < ActiveRecord::Base
  belongs_to :review
  belongs_to :user, :class_name => Spree.user_class.to_s

  validates_presence_of :review_id
  #validates :rating, :numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5, :message => I18n.t('you_must_enter_value_for_rating') }
  validates :quality_rating, :numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5, :message => I18n.t('you_must_enter_value_for_rating') }
  validates :appearance_rating, :numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5, :message => I18n.t('you_must_enter_value_for_rating') }
  validates :price_rating, :numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5, :message => I18n.t('you_must_enter_value_for_rating') }

  default_scope order("spree_feedback_reviews.created_at DESC")

  scope :localized, lambda { |lc| where('spree_reviews.locale = ?', lc) }

end
