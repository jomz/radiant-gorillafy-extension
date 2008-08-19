# Uncomment this if you reference any of your controllers in activate
require_dependency 'application'

class GorillafyExtension < Radiant::Extension
  version "1.1"
  description "Describe your extension here"
  url "http://www.gorilla-webdesign.be"
  
  # define_routes do |map|
  #   map.connect 'admin/gorillafy/:action', :controller => 'admin/gorillafy'
  # end
  
  def activate
    # admin.tabs.add "Gorillafy", "/admin/gorillafy", :after => "Layouts", :visibility => [:all]
    ApplicationController.class_eval do
      prepend_before_filter :customize_admin_css
      def customize_admin_css
        @stylesheets ||=[]
        include_stylesheet ('admin/gorilla')
      end
    end
    
    filename = File.join(GorillafyExtension.root, 'config', 'gorillafy.yml')
    raise GorillafyExtensionError.new("Gorilla'ize error: configuration file does not exist, see the README") unless File.exists?(filename)
    configurations = YAML::load_file(filename)
    configurations.each do |key, value|
      Radiant::Config["#{key}"] = value
    end
    
  end
  
  def deactivate
    # admin.tabs.remove "Gorillafy"
  end
  
end