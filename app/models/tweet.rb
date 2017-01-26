class Tweet
  include Mongoid::Document
  include Mongoid::Geospatial

  field :tweet, type: String
  field :location, type: Point
  field :hashtags, type: Array

  spatial_index :location # 2d
end
