class Album < ActiveRecord::Base
  attr_accessible :band_id, :name, :recording_environment

  validates :band_id, :name, :recording_environment, :presence => true

  has_many :tracks,
    :dependent => :destroy

  belongs_to :band
end
