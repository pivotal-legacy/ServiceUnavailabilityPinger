require 'spec_helper'

describe "statuses/index.html.haml" do
  before { assign(:most_recent_github_status, most_recent_github_status) }

  context "when there is a github most recent status" do
    let(:last_updated_at) { 2.minutes.ago }
    let(:created_at) { 1.minute.ago }
    let(:most_recent_github_status) do
      double(:most_recent_github_status, code: 'good', last_updated_at: last_updated_at, created_at: created_at)
    end

    before { render }

    it "displays status info" do
      expect(rendered).to include 'good'
      expect(rendered).to include last_updated_at.to_s
      expect(rendered).to include created_at.to_s
    end
  end

  context "when there is no github most recent status" do
    let(:most_recent_github_status) { nil }

    it "displays" do
      expect { render }.not_to raise_error
    end
  end
end
