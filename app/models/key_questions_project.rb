class KeyQuestionsProject < ApplicationRecord
  include SharedParanoiaMethods

  acts_as_paranoid column: :active, sentinel_value: true
  has_paper_trail

  belongs_to :extraction_forms_project, inverse_of: :key_questions_projects, optional: true
  belongs_to :key_question, inverse_of: :key_questions_projects
  belongs_to :project, inverse_of: :key_questions_projects, touch: true

  accepts_nested_attributes_for :key_question, reject_if: :key_question_name_exists?

  private

  def key_question_name_exists?(attributes)
    return true if attributes[:name].blank?
    begin
      self.key_question = KeyQuestion.where(name: attributes[:name]).first_or_create!
    rescue ActiveRecord::RecordNotUnique
      retry
    end
  end
end
