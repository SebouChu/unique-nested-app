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
require "test_helper"

class InvolvementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
