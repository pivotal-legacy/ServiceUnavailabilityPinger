require 'spec_helper'

describe GithubStatus do
  describe "Validations" do
    it "validates presence of code" do
      subject.valid?
      expect(subject.errors[:code]).to include "can't be blank"
    end

    it "validates presence of last_updated_at" do
      subject.valid?
      expect(subject.errors[:last_updated_at]).to include "can't be blank"
    end
  end

  describe ".most_recent" do
    subject { GithubStatus.most_recent }

    context "when there are statuses" do
      let!(:github_status_1) { GithubStatus.create!(code: 'good', last_updated_at: 1.day.ago) }
      let!(:github_status_2) { GithubStatus.create!(code: 'wut', last_updated_at: 1.hour.ago) }
      let!(:github_status_3) { GithubStatus.create!(code: 'bad', last_updated_at: 2.days.ago) }

      it { should == github_status_2 }
    end

    context "when there are no statuses" do
      it { should be_nil }
    end
  end
end
