# == Schema Information
#
# Table name: roles
#
#  id          :uuid             not null, primary key
#  description :text
#  position    :integer
#  target_type :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  target_id   :uuid
#
# Indexes
#
#  index_roles_on_target  (target_type,target_id)
#
class Role < ApplicationRecord
  include WithPosition

  belongs_to :target, polymorphic: true, optional: true
  has_many :involvements, as: :target, inverse_of: :target

  accepts_nested_attributes_for :involvements, reject_if: :all_blank, allow_destroy: true

  scope :targetless, -> { where(target: nil) }

  def to_s
    "#{description}"
  end
end
