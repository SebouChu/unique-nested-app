# == Schema Information
#
# Table name: involvements
#
#  id          :uuid             not null, primary key
#  description :text
#  kind        :integer
#  position    :integer
#  target_type :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  person_id   :uuid             not null
#  target_id   :uuid             not null
#
# Indexes
#
#  index_involvements_on_person_id  (person_id)
#  index_involvements_on_target     (target_type,target_id)
#
# Foreign Keys
#
#  fk_rails_...  (person_id => people.id)
#
class Involvement < ApplicationRecord
  include WithPosition

  enum kind: { administrator: 10, teacher: 20 }

  belongs_to :person
  belongs_to :target, polymorphic: true

  validates :kind, presence: true
  validates :person_id, uniqueness: { scope: [:target_type, :target_id] }

  before_validation :set_kind, on: :create

  def to_s
    "#{person}"
  end

  protected

  def set_kind
    case target_type
    when "Program"
      self.kind = :teacher
    else
      self.kind = :administrator
    end
  end
end
