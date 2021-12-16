class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  mount_uploader :movie, MovieUploader
  mount_uploader :image_id, ImagesUploader
  
  validates :movie, presence: true
  validates :image_id, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :email, presence: true
  validates :encrypted_password, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true
  
  # def active_for_authentication?
  #   super && (self.is_active == false)
  # # end
  has_many :reservations
  
  
  
  def full_name
    last_name + first_name
  end

  def full_name_kana
    last_name_kana + first_name_kana
  end

  def full_address
    '〒' + postal_code + ' ' + address + ' ' + full_name
  end

end
