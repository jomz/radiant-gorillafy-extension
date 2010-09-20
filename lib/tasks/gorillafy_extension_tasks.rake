namespace :radiant do
  namespace :assets do
    desc "Groups all javascript and css files into 1 'main'"
    task :group do
      Javascripts = %w(jquery application).map { |js| File.join(RAILS_ROOT, 'public/javascripts', "#{js}.js") }

      cache_file = File.open(File.join(RAILS_ROOT, 'public', 'javascripts', 'all.js'), 'w')
      Javascripts.each do |js|
        cache_file << File.read(js)
        cache_file << "\n\n"
      end
      cache_file.close
    end
  end
  
  
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
      task :update => :environment do
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
