class Recipe < ActiveRecord::Base
# =>association - notice singular for one chev 1:M many recipes
  belongs_to :chef
  has_many :likes
  validates :chef_id, presence: true
  validates :name, presence: true, length: { minimum: 5, maximum: 100 }
  validates :summary, presence: true, length: { minimum: 10, maximum: 150 }
  validates :description, presence: true, length: { minimum: 20, maximum: 500 }

# code for the thumbs up/down - used from show.html.erb
  def thumbs_up_total
    self.likes.where(like: true).size  # no clue on this line?
  end
  
  def thumbs_down_total
    self.likes.where(like: false).size
  end

# =>picture and private method  
  mount_uploader :picture, PictureUploader
  validate :picture_size
  
  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end