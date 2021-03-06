class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
				 :omniauthable, :omniauth_providers => [:facebook]

  acts_as_messageable 

  before_update do
  	if self.interested_in == "Male" || self.interested_in == "Female"
  		self.interested_in = self.interested_in.downcase
  	end
  	if self.gender == 'Male' || self.gender == 'Female'
  		self.gender = self.gender.downcase
  	end
  end

  def mailboxer_name
    self.name
  end

  def mailboxer_email(object)
    self.email
  end 

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid.to_s).first_or_create do |user|
	    user.provider = auth.provider
			user.uid = auth.uid
			user.name = auth.info.name
			user.gender = auth.extra.raw_info.gender
			#user.cover = auth.extra.raw_info.cover.source
			#user.email = auth.info.email
			user.image = auth.info.image
			user.real = true 
	    user.password = Devise.friendly_token[0,20]
      end
	end

	 def matched_user_events
		matched_users = []
		Event.all.each  do |event|
			result = self.find_match(event)
			if result[0]
				matched_users << [result[0],event]
			end	
		end
		matched_users
	end

	# this is a sequel query which will eliminate the users who have liked you, and you have also liked.
  	# it will then filter out the same gender as you (should be changed to reflect your sexual preference)
  	# and will only find the users who have pinned this event.
	def find_match(event)
		sequel = %Q(
	    	select * from users where users.id in (select user_events.shown_user_id from user_events inner join user_events as shown_user_events on user_events.user_id = #{self.id} and shown_user_events.shown_user_id = #{self.id} and user_events.shown_user_id = shown_user_events.user_id where user_events.event_id = #{event.id} AND shown_user_events.event_id = #{event.id} and user_events.liked = 'yes' AND shown_user_events.liked = 'yes')
    	)
		User.find_by_sql(sequel)   
	end

	# this query will filter out any user you have liked or disliked, is of opposite gender, and pinned this event.
	def eliminate_swiped_users(event)
		sequel = %Q(
    		SELECT * FROM users WHERE users.id NOT IN
    		(SELECT user_events.shown_user_id FROM user_events 
      		WHERE user_events.user_id = #{self.id} AND liked != 'nil' AND user_events.event_id = #{event.id})
      		AND users.id IN (SELECT users.id FROM users WHERE users.gender = '#{self.interested_in}') AND users.id != #{self.id} AND users.id IN (SELECT user_events.user_id FROM user_events 
     		WHERE user_events.event_id = #{event.id})
   		)
		User.find_by_sql(sequel)
	end

	def get_user(event)
		@match = find_match(event)
		@swiped = eliminate_swiped_users(event)
		if @match.length > 0
			[@match.first, true]
		elsif  @swiped.length > 0
			[@swiped.sample, false]
		else
			nil
		end
	end

	def user_image
		if self.real
        self.image + "?type=large"
      else
        self.image
      end
  end

	
	has_many :user_events
has_many :events, through: :user_events
end
