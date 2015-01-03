
LIB_NAME = 'OptionParser'
LIB_VERSION_FILE = File.join('lib', 'src', 'pixeldroid', 'cli', 'OptionParser.ls')

begin
  load(File.join(ENV['HOME'], '.loom', 'tasks', 'loomlib.rake'))
rescue LoadError
  abort([
    'error: missing loomlib.rake',
    '  please install loomtasks before running this Rakefile:',
    '  https://github.com/pixeldroid/loomtasks',
  ].join("\n"))
end


DEMO = "test/bin/#{const_lib_name}Demo.loom"

FileList['test/src/**/*.ls'].each do |src|
  file DEMO => src
end

file DEMO => LIBRARY do |t, args|
  puts "[file] creating #{t.name}..."

  sdk_version = test_config['sdk_version']
  file_installed = "#{sdk_root}/#{sdk_version}/libs/#{const_lib_name}.loomlib"

  Rake::Task['lib:install'].invoke unless FileUtils.uptodate?(file_installed, [LIBRARY])

  Dir.chdir('test') do
    Dir.mkdir('bin') unless Dir.exists?('bin')
    cmd = "#{sdk_root}/#{sdk_version}/tools/lsc #{const_lib_name}Demo.build"
    try(cmd, "failed to compile .loom")
  end

  puts ''
end

namespace :demo do

  desc "builds #{const_lib_name}Demo.loom with the SDK specified in test/loom.config"
  task :build => DEMO do |t, args|
    puts "[#{t.name}] task completed, find .loom in test/bin/"
    puts ''
  end

  desc "runs #{const_lib_name}Demo.loom"
  task :run, [:options] => DEMO do |t, args|
    args.with_defaults(:options => '--help')
    options = args.options

    puts "[#{t.name}] running #{t.prerequisites[0]}..."

    sdk_version = test_config['sdk_version']
    cmd = "#{sdk_root}/#{sdk_version}/tools/loomexec test/bin/#{const_lib_name}Demo.loom #{options}"
    try(cmd, "failed to run .loom")

    puts ''
  end

end
