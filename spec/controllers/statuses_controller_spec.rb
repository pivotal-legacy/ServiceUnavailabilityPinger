require 'spec_helper'

describe StatusesController do

  describe "#index" do
    let(:most_recent_github_status) { double(:most_recent_github_status) }

    def make_request
      get :index
    end

    before do
      GithubStatus.stub(:most_recent) { most_recent_github_status }
      make_request
    end

    it "renders the template" do
      expect(response).to render_template :index
    end

    it "assigns @most_recent_github_status" do
      expect(assigns(:most_recent_github_status)).to eq most_recent_github_status
    end
  end

  describe "#create" do

    def make_request
      post :create
    end

    before do
      GithubStatusJob.stub(:enqueue)
      make_request
    end

    it "enqueues the poling job" do
      expect(GithubStatusJob).to have_received(:enqueue)
    end

    it "redirects to index" do
      expect(response).to redirect_to statuses_path
    end
  end
end
