namespace :radiant do
  namespace :extensions do
    namespace :gorillafy do
      
      desc "Runs the migration of the Gorillafy extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          GorillafyExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          GorillafyExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Gorillafy extension to the instance public/ directory."
      task :install => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[GorillafyExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(GorillafyExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end

namespace 'views' do
  desc 'Renames all your rhtml views to erb'
  task 'rename' do
    Dir.glob('**/views/**/*.rhtml').each do |file|
      puts `git mv #{file} #{file.gsub(/\.rhtml$/, '.html.erb')}`
    end
  end
end

# so not working yet
namespace :gorilla do
  namespace :setup do
    desc "loads Gorilla db template"
    task :db => :environment do
      # load_database_template()
      puts "Loading Gorilla db template ..."
      YAML.load_file("#{GorillafyExtension.root}/db/templates/gorilla.yml")
    end
    desc "loads Gorilla multilang db template"
    task :ml_db => :environment do
      #...
    end
  end
end