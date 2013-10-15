class User < ActiveRecord::Base
  attr_accessible :email, :password, :session_token, :activated, :activation_token, :admin
  attr_reader :password, :active, :admin

  before_validation on: :create do
    self.class.generate_session_token if session_token.nil?
    activated = false if activated.nil?
    self.class.generate_activation_token if activation_token.nil?
  end

  validates :email, :password_digest, :session_token, presence: true
  validates :activation_token, presence: true, on: :create
  validates :password, :length => {:minimum => 6}, :on => :create
  validates :email, :uniqueness => true

  has_many :notes,
    :dependent => :destroy

  def self.generate_session_token
    session_token = SecureRandom.urlsafe_base64
  end

  def self.generate_activation_token
    activation_token = SecureRandom.urlsafe_base64
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
    return true if BCrypt::Password.new(self.password_digest).is_password?(password)
    false
  end

end
