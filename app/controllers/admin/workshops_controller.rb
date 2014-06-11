class Admin::WorkshopsController < Admin::ApplicationController
  include  Admin::SponsorConcerns

  def new
    @workshop = Sessions.new
  end

  def create
    @workshop = Sessions.new(workshop_params)
    if @workshop.save
      flash[:notice] =  @workshop.errors.full_messages
      redirect_to admin_workshop_path(@workshop)
    else
      render 'new'
    end

  end

  def show
    @workshop = Sessions.find(params[:id])
  end

  private

  def workshop_params
    params.require(:sessions).permit(:date_and_time, :time, :chapter_id, :invitable, :seats, sponsor_ids: [])
  end

  def sponsor_id
    workshop_params[:sponsor_ids][1]
  end
end
