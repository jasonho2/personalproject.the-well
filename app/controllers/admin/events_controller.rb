class Admin::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def sync
    service = EventbriteService.new
    events_data = service.fetch_events

    events_data.each do |data|
      event = Event.find_or_initialize_by(eventbrite_id: data["id"])
      event.update(
        name: data["name"]["text"],
        description: data["description"]["text"],
        start_time: data["start"]["local"],
        end_time: data["end"]["local"],
        url: data["url"],
        location: data.dig("venue", "address", "localized_address_display") || "TBD"
      )
    end

    redirect_to admin_dashboard_path, notice: "Events synced from Eventbrite!"
  end
end