module InvolvementsHelper
  def available_people_for_involvement(involvement)
    target_involvements_without_self = Involvement.where(target: involvement.target)
                                                  .where.not(id: involvement.id)
    Person.where.not(id: target_involvements_without_self.pluck(:person_id))
  end
end
