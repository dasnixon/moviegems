module Email
  extend ActiveSupport::Concern

  def send_director_welcome_email
    #Sidekiq job to send email to director
  end

  private

  def send_welcome_email
    #Sidekiq job to send email to user signing up
  end
end
