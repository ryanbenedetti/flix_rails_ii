class Genre < ActiveRecord::Base

# add validations to ensure that a genre always has a non-blank and unique name
	validates :name, presence: true, uniqueness: true
end
