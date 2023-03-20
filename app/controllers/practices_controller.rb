class PracticesController < ApplicationController
  before_action :params_method, only: %i[create update]
  before_action :find_para, only: %i[show update destroy]
  
  def index
    @pra = Practice.all
    render json: @pra, status: 200
  end

  def show
    if @pra
      render json: @pra, status: 200
    else
      render json: {error: 'Not found'}
    end
  end

  def create
    @pra =Practice.new(params_method)
    if @pra.save
      render json: @pra, status: 200
    else
      render json: {error: 'Not created'}
    end
  end

  def update
    if @pra.update(params_method)
      render json: @pra, states: 200
    else
      render json: {error: 'Not updated'}
    end
  end
   
  def destroy
    if @pra.destroy
      render json: @pra, status: 200
    else 
      render json: {error: 'Not destroyed'}
    end
  end

  private

  def params_method
    params.require(:practice).permit(:name, :age)
  end

  def find_para
    @pra = Practice.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: {error: e}
  end

end
