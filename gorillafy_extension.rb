# Uncomment this if you reference any of your controllers in activate
require_dependency 'application_controller'

class GorillafyExtensionError < StandardError; end

class GorillafyExtension < Radiant::Extension
  version "1.1"
  description "Describe your extension here"
  url "http://www.gorilla-webdesign.be"
  
  # define_routes do |map|
  #   map.connect 'admin/gorillafy/:action', :controller => 'admin/gorillafy'
  # end
  
  def activate
    admin.page.edit.add :main, 'string_js_include', :before => 'edit_header'
  end
  
  def deactivate
    # admin.tabs.remove "Gorillafy"
  end
  
end