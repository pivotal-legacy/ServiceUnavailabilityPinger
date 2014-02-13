class GithubStatusUpdater

  def grab_and_create
    GithubStatus.create!(
      code: json_response["status"],
      last_updated_at: json_response["last_updated"]
    )
  end

  private

  def json_response
    @json_response ||= JSON.parse(call_uri)
  end

  def call_uri
    uri = URI("https://status.github.com/api/status.json")

    Net::HTTP.start(uri.host, uri.port,
      use_ssl: uri.scheme == "https") do |http|
      request = Net::HTTP::Get.new uri
      request.content_type = "application/json;charset=UTF-8"
      response = http.request request
      response.body
    end
  end
end
