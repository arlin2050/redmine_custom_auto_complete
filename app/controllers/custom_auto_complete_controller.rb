class CustomAutoCompleteController < ApplicationController
  unloadable

  before_filter :find_project, :authorize

  def search
    custom_field = CustomField.find(params[:custom_field_id])
    @selected_values = []
    search = params[:term]
    for value in custom_field.possible_values
      if value.include?(search)
        @selected_values.push(value)
      end
    end
    render :layout => false
  rescue ActiveRecord::RecordNotFound
    render_404
  end

private
  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end 

end
