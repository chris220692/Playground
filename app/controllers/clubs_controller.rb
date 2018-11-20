class ClubsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @clubs = Club.all
    # @club = Club.find(params[:id])
    @fields = Field.all
    find_field

    if params[:name].present?
      @clubs = @clubs.where("name ILIKE ?", "%#{params[:name]}%")
    end

    if params[:city].present?
      @clubs = @clubs.where("city ILIKE ?", "%#{params[:city]}%")
    end

    @markers = @clubs.map do |club|
      {
        lng: club.longitude,
        lat: club.latitude
      }
    end
    policy_scope(Player)
  end

  def new
    @club = Club.new
    authorize @club
  end

  def show
    @club = Club.find(params[:id])
    @review = Review.new

    @markers =
      [{
        lng: @club.longitude,
        lat: @club.latitude
      }]
    authorize @club
  end

  def edit
    @club = Club.find(params[:id])
    authorize @club
  end

  def create
    @club = Club.new(club_params)
    authorize @club
    @club.user = current_user
    if @club.save
      redirect_to club_path(@club)
    else
      render :show
    end
  end

  def update
    @club = Club.find(params[:id])
    authorize @club
    @club.update(club_params)
    redirect_to club_path(@club)
  end

  def destroy
    @club = Club.find(params[:id])
    authorize @club
    @club.destroy
    redirect_to root_path
  end

  private

  def club_params
    params.require(:club).permit(:name, :address, :city, :photo, :club_id)
  end

  def find_field
    if params[:field_type].present?
    @fields = @fields.where(field_type: params[:field_type])
    end

    if params[:club_city].present?

    end

    if params[:start_date]

    end

    if params[:end_date]

    end
  end
end
