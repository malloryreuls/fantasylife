require "bcrypt"
class User
  include Mongoid::Document
  include Mongoid::Paperclip

   def self.after_commit(*args, &block)
     args.each do |arg|
     case arg[:on]
       when :destroy
         after_destroy &block
       end
     end
   end

  has_mongoid_attached_file :picture,
   :styles => {
      :thumb => "100x100#",   # Centrally cropped
      :small  => "150x150>"}  # Only squish if it's larger than this

  field :name, type: String
  field :email, type: String
  field :password_digest, type: String

  def password
  	@password
  end

  def password=(new_password)
  	@password = new_password
  	self.password_digest = BCrypt::Password.create(new_password)
  end

  def authenticate(test_password)
  	if BCrypt::Password.new(self.password_digest) == test_password
  		self
  	else
  		false
  	end
  end

   has_many :selections

   validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

end
