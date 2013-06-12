class Ability
  include CanCan::Ability

  def initialize(user, controller_namespace)
    can :manage, :all if user.has_role? 'admin'
    case controller_namespace
      when 'Admin'
        can :manage, :all if user.has_role? 'admin'
      when 'Director'
        can :manage, :all if user.has_role?('admin') || user.has_role?('director')
      else
        can :read, :all
    end
  end
end
