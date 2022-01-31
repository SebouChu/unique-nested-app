class Person < ApplicationRecord
  has_rich_text :biography

  def to_s
    full_name
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
