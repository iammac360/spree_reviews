class Spree::Admin::ReviewSettingsController < Spree::Admin::BaseController
  def update
    # workaround for unset checkbox behaviour
    params[:preferences][:include_unapproved_reviews] = false if params[:preferences][:include_unapproved_reviews].blank?
    params[:preferences][:feedback_rating] = false            if params[:preferences][:feedback_rating].blank?
    params[:preferences][:feedback_quality_rating] = false            if params[:preferences][:feedback_quality_rating].blank?
    params[:preferences][:feedback_appearance_rating] = false            if params[:preferences][:feedback_appearance_rating].blank?
    params[:preferences][:feedback_price_rating] = false            if params[:preferences][:feedback_price_rating].blank?
    params[:preferences][:show_email] = false                 if params[:preferences][:show_email].blank?
    params[:preferences][:require_login] = false              if params[:preferences][:require_login].blank?
    params[:preferences][:track_locale] = false               if params[:preferences][:track_locale].blank?
    Spree::Reviews::Config.set(params[:preferences])

    respond_to do |format|
      format.html do
        redirect_to admin_review_settings_path
      end
    end
  end
end
