class DuoClientService
  def self.client
    @client ||= DuoUniversalRuby::Client.new(
      client_id:     Rails.configuration.duo_config["client_id"],
      client_secret: Rails.configuration.duo_config["client_secret"],
      api_host:      Rails.configuration.duo_config["api_host"],
      redirect_uri:  Rails.configuration.duo_config["redirect_uri"],
      duo_certs:     Rails.configuration.duo_config["duo_certs"],
      http_proxy:    Rails.configuration.duo_config["http_proxy"]
    )
  end
end
