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
require "test_helper"

class RoleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
