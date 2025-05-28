# app/services/eventbrite_service.rb
class EventbriteService
  include HTTParty
  base_uri "https://www.eventbriteapi.com/v3"

  def initialize
    @token = ENV["EVENTBRITE_TOKEN"]
  end

  def fetch_events
    response = self.class.get("/users/me/events", headers: headers)
    if response.success?
      response.parsed_response["events"]
    else
      Rails.logger.error("Eventbrite API error: #{response.body}")
      []
    end
  end

  def fetch_event(event_id)
    response = self.class.get("/events/#{event_id}/", headers: headers)
    response.parsed_response
  end

  private

  def headers
    { "Authorization" => "Bearer #{@token}" }
  end
end