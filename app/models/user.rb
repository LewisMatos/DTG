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
			#user.cover = auth.extra.raw_info.cover.source
			#user.email = auth.info.email
			user.image = auth.info.image
			user.real = true 
	        user.password = Devise.friendly_token[0,20]
        end
	end

	# this is a sequel query which will eliminate the users who have liked you, and you have also liked.
  	# it will then filter out the same gender as you (should be change to reflect your sexual preference)
  	# and will only find the users who have pinned this event.
	def find_match(event)
		sequel = %Q(
	    	SELECT * FROM users WHERE users.id IN 
	    	(SELECT also_likes_me.user_id FROM user_events INNER JOIN user_events AS also_likes_me
	      	ON user_events.user_id = also_likes_me.shown_user_id 
	      	AND also_likes_me.liked = 'yes' AND also_likes_me.event_id = #{event.id} AND user_events.event_id = #{event.id}
	      	WHERE user_events.user_id = #{self.id} AND user_events.liked = 'yes' AND user_events.event_id = #{event.id}) AND users.gender != "#{self.gender}" AND users.id IN (SELECT user_events.user_id FROM user_events 
	     	WHERE user_events.event_id = #{event.id})
    	)
		User.find_by_sql(sequel)
	end

	# this query will filter out any user you have liked or disliked, and is opposite gender and pinned this event.
	def eliminate_swiped_users(event)
		sequel = %Q(
    		SELECT * FROM users WHERE users.id NOT IN
    		(SELECT user_events.shown_user_id FROM user_events 
      		WHERE user_events.user_id = #{self.id} AND liked != 'nil' AND user_events.event_id = #{event.id})
      		AND users.id IN (SELECT users.id FROM users WHERE users.gender != "#{self.gender}") AND users.id IN (SELECT user_events.user_id FROM user_events 
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
			[@swiped.first, false]
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
