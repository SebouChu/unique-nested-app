# == Schema Information
#
# Table name: programs
#
#  id         :uuid             not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Program < ApplicationRecord
  has_rich_text :description

  def to_s
    "#{title}"
  end
end
