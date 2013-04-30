require 'spec_helper'

describe Spree::Review do
  before(:each) do
    @review = FactoryGirl.create :review
  end

  context "relationships" do
    it { should belong_to(:product) }
    it { should belong_to(:user) }
    it { should have_many(:feedback_reviews) }
  end

  context "creating a new review" do
    it "is valid with valid attributes" do
      @review.should be_valid
    end

    it "is not valid without a rating" do
      @review.rating = nil
      @review.should_not be_valid
    end

    it "is not valid without a quality rating" do
      @review.quality_rating = nil
      @review.should_not be_valid
    end

    it "is not valid without a appearance rating" do
      @review.appearance_rating = nil
      @review.should_not be_valid
    end

    it "is not valid without a price rating" do
      @review.price_rating = nil
      @review.should_not be_valid
    end

    it "is not valid unless the rating is an integer" do
      @review.rating = 2.0
      @review.quality_rating = 2.0
      @review.appearance_rating = 2.0
      @review.price_rating = 2.0
      @review.should_not be_valid
    end

    it "is not valid without a review body" do
      @review.review = nil
      @review.should_not be_valid
    end
  end

  context "#recalculate_product_rating" do
    let(:product) { FactoryGirl.create(:product) }
    before { product.reviews << @review }

    it "if approved" do
      @review.should_receive(:recalculate_product_rating)
      @review.approved = true
      @review.save!
    end

    it "if not approved" do
      @review.should_not_receive(:recalculate_product_rating)
      @review.save!
    end

    it "updates the product average rating" do
      @review.approved = true
      @review.save!
      @review.product.reload.avg_rating.should == @review.rating
      @review.product.reload.avg_rating_quality.should == @review.quality_rating
      @review.product.reload.avg_rating_appearance.should == @review.appearance_rating
      @review.product.reload.avg_rating_price.should == @review.price_rating

      @review.destroy
      product.reload.avg_rating.should == 0
      product.reload.avg_rating_quality.should == 0
      product.reload.avg_rating_appearance.should == 0
      product.reload.avg_rating_price.should == 0
    end
  end

  context "feedback_stars" do
    before(:each) do
      @review.save
      3.times do |i|
        f = Spree::FeedbackReview.new
        f.review = @review
        f.rating = (i+1)
        f.quality_rating = (i+1)
        f.appearance_rating = (i+1)
        f.price_rating = (i+1)
        f.save
      end
    end

    context "#feedback_stars" do
      it "should return the average rating from feedback reviews" do
        @review.feedback_stars.should == 2
      end
    end

    context "#feedback_quality_stars" do
      it "should return the average quality rating from feedback reviews" do
        @review.feedback_quality_stars.should == 2
      end
    end

    context "#feedback_appearance_stars" do
      it "should return the average appearance rating from feedback reviews" do
        @review.feedback_appearance_stars.should == 2
      end
    end

    context "#feedback_price_stars" do
      it "should return the average price rating from feedback reviews" do
        @review.feedback_price_stars.should == 2
      end
    end
  end

end
