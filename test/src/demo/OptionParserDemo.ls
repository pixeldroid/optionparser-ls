package
{
    import system.application.ConsoleApplication;
    import pixeldroid.cli.OptionParser;

    public class OptionParserDemo extends ConsoleApplication
    {
        override public function run():void
        {
            var opts:OptionParser = new OptionParser();
            opts.parse();

            opts.getOption('h', 'help').isSet ? showUsage() : runApp(opts);
        }

        private function showUsage():void
        {
            trace('usage: [-h|--help]');
            trace('       <option> [args]');
        }

        private function runApp(opts:OptionParser):void
        {
            // your app code here
            trace('[runApp] the following options were supplied:');
            trace(opts);
        }
    }
}
