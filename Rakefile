ENV['RACK_ENV'] = 'production'
require './app'

def build_assets output_dir
  puts 'Resolving assets...'
  assets = App.new.helpers.get_assets
  assets_dir = File.join output_dir , App.assets_prefix
  assets.each do |asset|
    path = File.join assets_dir, asset.logical_path
    puts "Building '#{path}'"
    asset.write_to path
  end

  puts 'Copying Resources'
  FileUtils.cp_r File.join(App.res_path,'.'), assets_dir #TODO Get the resources path from configuration

end

def build_file output_dir,file_name, file_content
  output = File.join output_dir, file_name
  puts "Building '#{output}'"
  File.write output, file_content
end

def build_index output_dir
  build_file output_dir, 'index.html', App.new.helpers.index
end

def build_changelog output_dir
  build_file output_dir, 'changelog.html', App.new.helpers.changelog
end

task :build_assets, [:output_dir] do |task, args|
  output_dir = args[:output_dir] || 'build'
  puts "Building assets application in '#{output_dir}'"
  assets_dir = File.join output_dir, App.assets_prefix
  FileUtils.rm_r assets_dir, :force => true
  build_assets output_dir
end

desc 'Builds the application to serve in a static web server.'
task :build, [:output_dir] do |task, args|
  output_dir = args[:output_dir] || 'build'
  puts "Building static application in '#{output_dir}'"

  FileUtils.rm_r    output_dir, :force => true
  FileUtils.mkdir_p output_dir
  build_assets      output_dir
  build_index       output_dir
  build_changelog   output_dir
end
#
#task :build_android, [:output_dir] do |task, args|
#  output_dir = args[:output_dir] || 'build'
#  puts "Building static application in '#{output_dir}'"
#
#  FileUtils.rm_r    output_dir, :force => true
#  FileUtils.mkdir_p output_dir
#  build_assets      output_dir
#  build_index       output_dir
#  puts "Running bash script: ./mobile-app/make android "
#  puts %x[cd ./mobile-app && ./make android && cd ..]
#
#end