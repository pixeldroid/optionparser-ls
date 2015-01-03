
LIB_NAME = 'OptionParser'
LIB_VERSION_FILE = File.join('lib', 'src', 'pixeldroid', 'cli', 'OptionParser.ls')

begin
  load(File.join(ENV['HOME'], '.loom', 'tasks', 'loomlib.rake'))
rescue LoadError
  abort([
    'please install loomtasks before running this Rakefile:',
    'https://github.com/pixeldroid/loomtasks',
  ].join("\n"))
end
