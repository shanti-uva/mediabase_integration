require 'rexml/document'

class MediabaseCategoryCount
  SITE = "#{MediabaseResource.site.to_s}/service/media/count/by_kmap_id/"
  ELEMENT_NAME = 'count'
  
  def self.find(category_id)
    d = self.get(category_id)
    element = d.elements["//#{ELEMENT_NAME}"]
    return nil if element.nil?
    h = Hash.new
    element.elements.each{|e| h[e.name.to_sym] = e.text}
    return h
  end
  
  private
  
  def self.get(category_id)
    begin
      doc = REXML::Document.new(open("#{SITE}#{category_id}/xml").read)
      yield doc if block_given?
      return doc
    rescue Errno::EHOSTUNREACH
      "Can't connect to #{url}"
    rescue Errno::ETIMEDOUT
      "Can't connect to #{url}"
    rescue SocketError
      "Can't connect to #{url}"      
    end
    return nil
  end  
end