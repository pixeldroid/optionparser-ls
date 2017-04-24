package
{
    import system.application.ConsoleApplication;
    import system.Process;

    import pixeldroid.bdd.SpecExecutor;

    import OptionParserSpec;


    public class OptionParserTest extends ConsoleApplication
    {
        override public function run():void
        {
            SpecExecutor.parseArgs();

            var returnCode:Number = SpecExecutor.exec([
                OptionParserSpec
            ]);

            Process.exit(returnCode);
        }
    }

}
