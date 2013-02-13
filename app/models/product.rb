class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :image, :image_cache
  mount_uploader :image, ProductImageUploader

  validates_presence_of :name, :description, :price
  validates_uniqueness_of :name
  validates_numericality_of :price, :only_integer => true

  validate :price_must_be_amultiple_of_hundreds 

  private
  def price_must_be_amultiple_of_hundreds
    if price.present?
      unless price % 100 == 0
        errors.add :price, "must be a multiple of hundreds"
      end
    end
  end
end
