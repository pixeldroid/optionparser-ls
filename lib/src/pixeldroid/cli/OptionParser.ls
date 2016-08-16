
package pixeldroid.cli
{
    import pixeldroid.cli.Option;


    public class OptionParser
    {
        public static const version:String = '1.0.1';

        private var options:Dictionary.<String, Option>;
        private var numArgs:Number;
        private var argProvider:Object;
        private var getArgMethod:MethodInfo;


        public function OptionParser(argProvider:Object = null)
        {
            options = {};
            this.argProvider = argProvider;

            var type:Type = (argProvider == null) ? CommandLine.getType() : argProvider.getType();
            getArgMethod = type.getMethodInfoByName('getArg');
            numArgs = type.getMethodInfoByName('getArgCount').invokeSingle(argProvider, null) as Number;
        }


        public function hasOption(shortName:String, longName:String=''):Boolean
        {
            if (options[shortName]) return true;
            if (options[longName]) return true;
            return false;
        }

        public function getOption(shortName:String, longName:String='', defaultValue:Vector.<String> = ['true']):Option
        {
            if (options[shortName]) return options[shortName];
            if (options[longName]) return options[longName];
            return getDefaultOption(shortName, longName, defaultValue);
        }

        public function parse():void
        {
            var arg:String;

            // arg 0 : path to host executable (i.e. '~/.loom/sdks/<sdk>/tools/loomexec')
            // arg 1 : path to binary being executed (i.e. 'bin/Something.loom')
            for (var i = 2; i < numArgs; i++)
            {
                arg = getArg(i);

                if (isOption(arg))
                {
                    i = readOption(arg, i);
                }
            }
        }

        public function toString():String
        {
            var s:String = '';
            for (var key:String in options)
            {
                s += options[key].toString() +'\n';
            }

            return s;
        }


        private function getDefaultOption(shortName:String='', longName:String='', defaultValue:Vector.<String> = ['true']):Option
        {
            return new Option(shortName, longName, defaultValue);
        }

        private function getCommandLineArg(i:Number):String
        {
            return getArgMethod.invokeSingle(argProvider, i) as String;
        }

        private function getArg(i:Number):String
        {
            return (i < numArgs) ? getCommandLineArg(i) : null;
        }

        private function nextArg(i:Number):String
        {
            var j = i + 1;
            return (j < numArgs) ? getCommandLineArg(j) : null;
        }

        private function isOption(arg:String):Boolean
        {
            return (arg && arg.charAt(0) == '-');
        }

        private function isValue(arg:String):Boolean
        {
            return (arg && arg.charAt(0) != '-');
        }

        private function addOption(key:String, option:Option):void
        {
            options[key] = option;
        }

        private function readOption(arg:String, index:Number):Number
        {
            var option:Option;
            var key:String;
            var shortName:String = '';
            var longName:String = '';
            var value:Vector.<String> = [];

            if (arg.charAt(1) == '-')
            {
                longName = arg.substring(2);
                key = longName;
            }
            else
            {
                shortName = arg.substring(1);
                key = shortName;
            }

            option = new Option(shortName, longName);

            while (isValue(nextArg(index)))
            {
                index++;
                arg = getCommandLineArg(index);
                value.push(arg);
            }
            if (value.length == 0) value.push('true'); // it's a flag
            option.value = value;

            addOption(key, option);

            return index;
        }

    }
}
