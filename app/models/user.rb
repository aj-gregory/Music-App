class User < ActiveRecord::Base
  attr_accessible :email, :password, :session_token
  attr_reader :password
  # attr_accessor :session_token

  before_validation on: :create do
    self.class.generate_session_token if session_token.nil?
  end

  validates :email, :password_digest, :session_token, presence: true
  validates :password, :length => {:minimum => 6}, :on => :create
  validates :email, :uniqueness => true

  def self.generate_session_token
    session_token = SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    return nil if user.nil?

    return user if user.is_password?(password)
    nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    p "HERE"
    return true if BCrypt::Password.new(self.password_digest).is_password?(password)
    false
  end

end
