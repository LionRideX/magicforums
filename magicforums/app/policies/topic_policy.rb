class TopicPolicy < ApplicationPolicy

  def new?
    user.present? && user.admin?
  end

  def create?
    new?
  endat

  def edit?
    new?
  end

  def update?
    new?
  end

  def destroy?
    new?
  end
end
end
