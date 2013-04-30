class Spree::FeedbackReviewsController < Spree::StoreController
  helper Spree::BaseHelper

  def create
    params[:feedback_review][:rating].sub!(/\s*[^0-9]*$/,'') unless params[:feedback_review][:rating].blank?
    params[:feedback_review][:quality_rating].sub!(/\s*[^0-9]*$/,'') unless params[:feedback_review][:quality_rating].blank?
    params[:feedback_review][:appearance_rating].sub!(/\s*[^0-9]*$/,'') unless params[:feedback_review][:appearance_rating].blank?
    params[:feedback_review][:price_rating].sub!(/\s*[^0-9]*$/,'') unless params[:feedback_review][:price_rating].blank?

    @review = Spree::Review.find_by_id(params[:review_id])
    if @review && @feedback_review = @review.feedback_reviews.new(params[:feedback_review])
      @feedback_review.locale = I18n.locale.to_s if Spree::Reviews::Config[:track_locale]
      authorize! :create, @feedback_review
      @feedback_review.save
    end

    respond_to do |format|
      format.html { redirect_to :back  }
      format.js   { render :action => :create }
    end

  end
end

