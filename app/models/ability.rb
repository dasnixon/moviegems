class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.director?
      can :read, :all
    else
      can :read, :all
    end
  end
end
