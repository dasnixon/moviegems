class User < ActiveRecord::Base
  include Email

  after_create :send_welcome_email
  before_destroy :cancel_subscription
  before_save :update_stripe

  has_one :subscription
  has_many :moviegems, conditions: proc { 'state = 2' }

  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  state_machine initial: :basic_user do
    state :basic_user, value: 0
    state :pending_director, value: 1
    state :director, value: 2
    state :admin, value: 3
    state :declined_director, value: 4

    after_transition to: :director do |user, transition|
      user.add_role :director
      user.send_director_welcome_email
    end

    after_transition to: :admin do |user, transition|
      user.add_role :admin
    end

    after_transition to: [:basic_user, :declined_director] do |user, transition|
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

    event :decline_user_for_director do
      transition any => :declined_director
    end
  end

  def basic_user?
    self.state.zero?
  end

  private

  def cancel_subscription
    self.subscription.cancel_subscription
  end

  def update_stripe
    self.subscription.update_stripe
  end
end
