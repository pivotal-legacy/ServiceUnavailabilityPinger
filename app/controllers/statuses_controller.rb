class StatusesController < ApplicationController

  def index
    @most_recent_github_status = GithubStatus.most_recent
  end

  def create
    GithubStatusJob.enqueue
    redirect_to statuses_path
  end
end
