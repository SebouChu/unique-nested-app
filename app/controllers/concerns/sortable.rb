module Sortable
  extend ActiveSupport::Concern

  def sort
    ids = params[:ids] || []
    first_object = model.find_by(id: ids.first)
    ids.each_with_index do |id, index|
      model.find_by(id: id)&.update_column(:position, index + 1)
    end
  end

  protected

  def model
    self.class.to_s.remove('Controller').singularize.safe_constantize
  end
end
