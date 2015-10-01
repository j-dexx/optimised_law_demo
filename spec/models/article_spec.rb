require 'rails_helper'

RSpec.describe Article, type: :model do

  describe "validations", :validation do
    subject(:article) { build(:article) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:article_category_id) }
    it { should validate_uniqueness_of(:suggested_url).allow_blank.case_insensitive }
  end

  describe "associations", :association do
    it { should belong_to(:article_category) }
    it { should belong_to(:team_member) }
  end

  describe "friendly_id" do
    subject(:article) { build(:article) }

    it "creates a slug if title changed" do
      article.title = "My new title"
      expect(article.should_generate_new_friendly_id?).to be true
    end

    it "creates a slug if suggested_url changed" do
      article.suggested_url = "my-new-titled-article"
      expect(article.should_generate_new_friendly_id?).to be true
    end

    it "does not create slug when other attributes changed" do
      article = create(:article)
      article.content = "Gobbledegook"
      expect(article.should_generate_new_friendly_id?).to be false
    end
  end

end
