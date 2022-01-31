module WithPosition
  extend ActiveSupport::Concern

  included do
    before_create :set_position
    scope :ordered, -> { order(position: :asc) }
  end

  protected

  def set_position
    self.position = last_ordered_record.nil? ? 1 : last_ordered_record.position + 1
  end

  def last_ordered_record
    self.class.unscoped.ordered.last
  end
end
