# == Schema Information
#
# Table name: entries
#
#  id         :bigint(8)        not null, primary key
#  dissonant  :boolean          default(FALSE)
#  state      :string
#  tone       :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)
#
# Indexes
#
#  index_entries_on_tone     (tone) USING gin
#  index_entries_on_user_id  (user_id)
#

class Entry < ApplicationRecord

  belongs_to :user, optional: true
  has_many :prompts

  state_machine :state, initial: :incomplete do
    event :finish do
      transition :incomplete => :complete
    end
  end

  def mood
    prompts.first.answers.first.body
  end

end
