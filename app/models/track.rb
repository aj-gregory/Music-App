class Track < ActiveRecord::Base
  attr_accessible :album_id, :lyrics, :name, :status

  validates :album_id, :lyrics, :name, :status, :presence => true

  belongs_to :album

  has_many :notes,
    :dependent => :destroy
end
