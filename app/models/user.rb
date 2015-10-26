class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
				 :omniauthable, :omniauth_providers => [:facebook]

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid.to_s).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
				user.name = auth.info.name
				user.gender = auth.extra.raw_info.gender
				user.cover = auth.extra.raw_info.cover.source
        user.email = auth.info.email
				user.image = auth.info.image
				user.real = true 
        user.password = Devise.friendly_token[0,20]
      end
	end

has_many :user_events
has_many :events, through: :user_events
end
