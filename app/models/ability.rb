class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role? 'admin'
      can :manage, :all
    elsif user.has_role? 'director'
      can :manage, Moviegem
    else
    end
  end
end
