class GithubStatus < ActiveRecord::Base
  validates :code, :last_updated_at,
    presence: true

  def self.most_recent
    order(last_updated_at: :desc).first
  end

end
