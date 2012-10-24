class MediabaseResource < ActiveResource::Base
  self.site = 'http://mediabase.drupal.shanti.virginia.edu'
  self.timeout = 100
  self.format = :xml
end