class User < ApplicationRecord
  validates :user_name, presence: true, uniqueness: true 
  validates :session_token, presence: true, uniqueness: true 
  validates :password, length: {minimum: 6, allow_nil: true } 

  after_initialize :ensure_session_token

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    if user && user.is_password?(password)
      user
    else 
      return nil 
    end
  end

  attr_reader :password
  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

end

 
