require 'spec_helper'

describe GithubStatusUpdater do

  describe "#grab_and_create" do

    def grab_and_create
      GithubStatusUpdater.new.grab_and_create
    end

    before do
      stub_request(:get, "https://status.github.com/api/status.json").to_return(
        headers: {
          "Content-Type" => "application/json"
        },
        body: {
          status: "good",
          last_updated: "2014-02-13T16:11:05Z"
        }.to_json
      )
    end

    it "creates a new github status" do
      expect { grab_and_create }.to change(GithubStatus, :count).by 1

      new_github_status = GithubStatus.last
      expect(new_github_status.code).to eq 'good'
      expect(new_github_status.last_updated_at).to eq DateTime.new(2014, 2, 13, 16, 11, 05).utc
    end
  end
end
