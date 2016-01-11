class Genre < ActiveRecord::Base

	# a has_many association with characterizations
	has_many :characterizations, dependent: :destroy

	# a has_many association with movies that goes through the characterizations association.
	has_many :movies, through: :characterizations

	# add validations to ensure that a genre always has a non-blank and unique name
	validates :name, presence: true, uniqueness: true
end
