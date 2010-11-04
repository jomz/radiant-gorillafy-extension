module Gorillafy::PagePartExtension
  
  def first_paragraph
    content[/<p(.*?)?>(.+?)<\/p>/,2]
  end
end