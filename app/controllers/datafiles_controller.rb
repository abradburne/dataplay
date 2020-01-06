class DatafilesController < ApplicationController
  def new
    @dataset = Dataset.find(params[:dataset_id])
    @datafile = @dataset.build_datafile
  end

  def create
    @dataset = Dataset.find(params[:dataset_id])
    @datafile = @dataset.build_datafile(datafile_params)

    if @datafile.save
      redirect_to dataset_datafile_path(@dataset, @datafile)
    else
      render :new
    end
  end

  private

  def datafile_params
    params.require(:datafile).permit(:filename, :attachment)
  end
end
