class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def registration_email(user)
    @user = user
    @url = "http://localhost:3000/users/activate?activation_token=#{user.activation_token}"
    mail(:to => user.email, :subject => "Account Activation Email")
  end

end
