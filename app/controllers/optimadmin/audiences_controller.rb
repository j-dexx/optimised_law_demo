module Optimadmin
  class AudiencesController < Optimadmin::ApplicationController
    before_action :set_audience, only: [:show, :edit, :update, :destroy]

    def index
      @audiences = Optimadmin::BaseCollectionPresenter.new(collection: Audience.positioned.where('name LIKE ?', "%#{params[:search]}%").page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: Optimadmin::AudiencePresenter)
    end

    def show
    end

    def new
      @audience = Audience.new
    end

    def edit
    end

    def create
      @audience = Audience.new(audience_params)
      if @audience.save
        redirect_to audiences_url, notice: 'Audience was successfully created.'
      else
        render :new
      end
    end

    def update
      if @audience.update(audience_params)
        redirect_to audiences_url, notice: 'Audience was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @audience.destroy
      redirect_to audiences_url, notice: 'Audience was successfully destroyed.'
    end

  private


    def set_audience
      @audience = Audience.friendly.find(params[:id])
    end

    def audience_params
      params.require(:audience).permit(:name, :colour, :sub_heading, :image, :remote_image_url, :image_cache, :summary, :content, :layout, :display, :suggested_url)
    end
  end
end
