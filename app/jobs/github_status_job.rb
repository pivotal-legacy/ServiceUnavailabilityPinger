class GithubStatusJob
  include Sneakers::Worker
  from_queue "github_status_#{Rails.env}".to_sym

  def self.enqueue
    Sneakers.publish('', to_queue: :github_status)
  end

  def work(msg)
    github_status_updater.grab_and_create
    ack!
  end

  private

  def github_status_updater
    @github_status_updater ||= GithubStatusUpdater.new
  end
end
