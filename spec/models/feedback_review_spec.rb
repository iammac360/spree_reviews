require 'spec_helper'


describe Spree::FeedbackReview do

  context "validations" do
    it { should validate_presence_of(:review_id)  }
    #it { should validate_numericality_of(:rating) }
    #it { should validate_numericality_of(:quality_rating) }
    #it { should validate_numericality_of(:appearance_rating) }
    #it { should validate_numericality_of(:price_rating) }
  end

  context "relationships" do
    it { should belong_to(:review) }
    it { should belong_to(:user) }
  end
end