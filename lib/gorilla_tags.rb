module GorillaTags
  include Radiant::Taggable
  include ActionView::Helpers::TagHelper # to pass html attributes through tags
  require "digest" # for r:gravatar

  class TagError < StandardError; end
  
  desc %{
    Gets the first paragraph of the given part, without the surrounding <p>'s.
    tag.attr['part'] defaults to "body"
  }
  tag "first_p" do |tag|
    part = tag.attr['part'] || 'body'
    page = tag.locals.page
    return page.part(part).content[/<p(.*?)?>(.+?)<\/p>/,2] unless page.part(part).nil?
  end
  
  tag "linkify" do |tag|
    # http://www.est1985.nl/design/2-design/96-linkify-urls-in-ruby-on-rails
    tag.expand.gsub!(/\b((https?:\/\/|ftps?:\/\/|mailto:|www\.)([A-Za-z0-9\-_=%&@\?\.\/]+))\b/) {
      match = $1
      tail  = $3
      case match
      when /^www/     then  "<a href=\"http://#{match}\">#{match}</a>"
      when /^mailto/  then  "<a href=\"#{match}\">#{tail}</a>"
      else                  "<a href=\"#{match}\">#{match}</a>"
      end
    }
  end
  
  tag "fix_external_link" do |tag|
    link = tag.expand.strip
    link["http://"] ? link : "http://#{link}"
  end
  
  tag "time_ago_in_words" do |tag|
    ActionView::Base.new.time_ago_in_words(tag.locals.page.published_at || tag.locals.page.created_at)
  end
  
  tag 'rfc3339_date' do |tag|
    page = tag.locals.page
    if date = page.published_at || page.created_at
      date.to_time.xmlschema
    end
  end
  
  tag 'fix_links_for_syndication' do |tag|
    fix_for_syndication(tag.expand, "#{tag.globals.page.request.protocol}#{tag.globals.page.request.host_with_port}")
  end

  tag "gravatar" do |tag|
    email = tag.expand
    raise TagError, "Gravatar tag requires an email attribute" if email.blank?
    # include MD5 gem, should be part of standard ruby install
    hash = Digest::MD5.hexdigest(email.downcase)

    if tag.attr
      html_options = tag.attr.stringify_keys
      tag_options = tag_options(html_options)
    else
      tag_options = nil
    end

    "<img src=\"http://www.gravatar.com/avatar/#{hash}\" #{tag_options}/>"
  end
  
  def fix_for_syndication(text, host)
    text.gsub(/href=('|")([^(http:|mailto:)].*?)('|")/, 'href="' + host + '\2"').gsub(/src=('|")([^http:].*?)('|")/, 'src="' + host + '\2"')
  end
end