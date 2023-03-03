class BuildingController < ApplicationController
  def import
    file = params[:file]
    #return redirect_to person_path, notice: 'Only CSV please' unless file.content_type == 'text/csv'
    Building.import(file)
    # add notice when the import is suceed.
  rescue => e
    #return redirect_to person_path, notice: 'A error has occured'
    raise e
  end
end