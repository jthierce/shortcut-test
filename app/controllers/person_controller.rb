class PersonController < ApplicationController
    def import
        file = params[:file]
        # add some errors in the view mode if the file is not csv or valid
        Person.import(file)
        # add notice when the import is suceed.
    end
end
