class DatasetsController < ApplicationController
  def index
    @datasets = Dataset.all
  end

  def show
    @dataset = Dataset.find(params[:id])
  end

  def new
    @dataset = Dataset.new
  end

  def create
    @dataset = Dataset.new(dataset_params)

    if @dataset.save
      redirect_to datasets_path
    else
      render :new
    end
  end

  private

  def dataset_params
    params.require(:dataset).permit(:name, :datafile)
  end
end
