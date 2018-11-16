class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_field

  def home
    # All events for a club - dashboard
    @upcoming_events = []
    @fields.each do |f|
      if f.events #Check if a field has events
        f.events.each do |e|
          @upcoming_events << e if e.start_date > DateTime.now
          @next_event = @upcoming_events.first
        end
      end
    end
    # total revenue for a club
    @total = 0
    @upcoming_events.each do |e|
      field = Field.find(e.field_id)
      @total += ((e.end_date.to_i - e.start_date.to_i) / 3600) * field.price.to_i
    end
    # end total revenue for club
  end

  private

  def set_field
    if user_signed_in?
      @player = current_user.player.nil? ? Player.new : current_user.player
      @player.user = current_user
    end
    if current_user.club.name != nil
      @club = current_user.club
      @fields = @club.fields
    end
  end

end
