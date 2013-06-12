class Ability
  include CanCan::Ability

  def initialize(user, controller_namespace)
    can :manage, :all if user.has_role? 'admin'
    case controller_namespace
      when 'Admin'
        can :manage, :all if user.has_role? 'admin'
      else
        can :read, :all
    end
  end
end
