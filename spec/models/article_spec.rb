require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '#validations' do
    let(:article) { FactoryBot.build(:article) }

    it 'tests if article is valid' do
      expect(article).to be_valid
    end

    it 'has an invalid title' do
      article.title = ''
      expect(article).not_to be_valid
      expect(article.errors[:title]).to include("can't be blank")
    end

    it 'should has a has valid content' do
      article.content = ''
      expect(article).not_to be_valid
      expect(article.errors[:content]).to include("can't be blank")
    end

    it 'should has a has valid slug' do
      article.slug = ''
      expect(article).not_to be_valid
      expect(article.errors[:slug]).to include("can't be blank")
    end

  end

  describe '.recent' do
    it 'returns articles in the correct order' do
      recent_article = create(:article)
      older_article = create(:article, created_at: 1.hour.ago)
      expect(described_class.recent).to eq(
                                          [recent_article,older_article]
                                        )
    end
  end

end
