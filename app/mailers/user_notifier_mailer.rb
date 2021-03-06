class UserNotifierMailer < ApplicationMailer
  default :from => 'aquenzitech@gmail.com'

  require 'sendgrid-ruby'
  include SendGrid
  require 'json'

  # send a reset link to the user, pass in the user object that contains the user's email address
  def forgot_pass(user, token)
    @token = token    
    @user = user
    @url  = "https://sushme.netlify.app/reset-pass/#{@token}"
    mail(to: @user.email, subject: 'Reset Password')
  end

  # send a welcome email to the user, pass in the user object that contains the user's email address
  def welcome(user) 
    @user = user
    @url  = 'https://sushme.netlify.app/'
    mail(to: @user.email, subject: 'Welcome to SushMe')
  end

  # send a signup email to the user, pass in the user object that contains the user's email address
  def receipt_email(customer, receipt, order)
    @customer = customer
    @receipt = receipt
    @order = order
    @url  = 'https://sushme.netlify.app/'
    mail( :to => @customer.email,
    :subject => 'Thanks for shopping at our amazing app' )
  end
 
end
