class User < ActiveRecord::Base
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  state_machine initial: :basic_user do
    state :basic_user, value: 0
    state :pending_director, value: 1
    state :director, value: 2
    state :admin, value: 3

    after_transition to: :director do |user, transition|
      user.add_role :director
    end

    after_transition to: :admin do |user, transition|
      user.add_role :admin
    end

    after_transition to: :basic_user do |user, transition|
      user.revoke :admin
      user.revoke :director
    end

    event :set_pending do
      transition basic_user: :pending_director
    end

    event :upgrade_to_director do
      transition pending_director: :director
    end

    event :downgrade_to_basic do
      transition any => :basic_user
    end

    event :set_admin do
      transition any => :admin
    end
  end
end
