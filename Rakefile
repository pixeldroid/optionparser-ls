
LIB_NAME = 'OptionParser'
LIB_VERSION_FILE = File.join('lib', 'src', 'pixeldroid', 'cli', 'OptionParser.ls')

begin
  load(File.join(ENV['HOME'], '.loom', 'tasks', 'loomlib.rake'))
  load(File.join(ENV['HOME'], '.loom', 'tasks', 'loomlib_demo.rake'))
rescue LoadError
  abort([
    'error: missing loomlib.rake',
    '  please install loomtasks before running this Rakefile:',
    '  https://github.com/pixeldroid/loomtasks/',
  ].join("\n"))
end

Rake::Task['demo:gui'].clear # no gui demo for this project
