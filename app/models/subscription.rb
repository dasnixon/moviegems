class Subscription < ActiveRecord::Base
  attr_accessor :stripe_token, :coupon
  belongs_to :user

  def single_payment

  end

  def update_stripe
    return if self.user.email.include?(ENV['ADMIN_EMAIL'])
    return if self.user.email.include?('@example.com') and not Rails.env.production?
    if customer_id.nil?
      if !stripe_token.present?
        raise "Stripe token not present. Can't create account."
      end
      if coupon.blank?
        customer = Stripe::Customer.create(
          :email => self.user.email,
          :description => self.user.name,
          :card => stripe_token,
          :plan => self.user.roles.first.name
        )
      else
        customer = Stripe::Customer.create(
          :email => self.user.email,
          :description => self.user.name,
          :card => stripe_token,
          :plan => self.user.roles.first.name,
          :coupon => coupon
        )
      end
    else
      customer = Stripe::Customer.retrieve(customer_id)
      if stripe_token.present?
        customer.card = stripe_token
      end
      customer.email = email
      customer.description = name
      customer.save
    end
    self.last_4_digits = customer.active_card.last4
    self.customer_id = customer.id
    self.stripe_token = nil
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "#{e.message}."
    self.stripe_token = nil
    false
  end

  def cancel_subscription
    unless customer_id.nil?
      customer = Stripe::Customer.retrieve(customer_id)
      unless customer.nil? or customer.respond_to?('deleted')
        if customer.subscription.status == 'active'
          customer.cancel_subscription
        end
      end
    end
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to cancel your subscription. #{e.message}."
    false
  end
end
