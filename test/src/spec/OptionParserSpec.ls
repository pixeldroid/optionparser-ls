package
{
    import pixeldroid.bdd.Spec;
    import pixeldroid.bdd.Thing;

    import pixeldroid.cli.OptionParser;


    public static class OptionParserSpec
    {
        private static const it:Thing = Spec.describe('OptionParser');
        private static const args:Vector.<String> = ['--option-one', 'v1', 'v2', 'v3', '-b', '-c', 'value for c', '--option-four'];
        private static const argProvider1 = new ArgProviderMock(args);
        private static const argProvider2 = new ArgProviderMock(['not-an-option']);


        public static function describe():void
        {
            var options:OptionParser = new OptionParser(argProvider1);
            options.parse();

            it.should('be versioned', be_versioned);
            it.should('find all the valid options, arguments, and flags', find_valid_input);
            it.should('ignore leading arguments that do not start with a hyphen', ignore_leading_args);
            it.should('parse short-form options', parse_short_form);
            it.should('parse long-form options', parse_long_form);
            it.should('assume options with no values are flags set true', assume_flags_true);
            it.should('parse the option value as a tuple when multiple args are provided', create_tuples_many_args);
            it.should('parse the option value as a tuple when just a single arg is provided', create_tuples_one_arg);
            it.should('parse the option value as a tuple when no args are provided', create_tuples_no_args);
            it.should('return a default option when a user provided one cannot be retrieved', return_defaults);
            it.should('give access to the first of a multi-value option', access_first_value);
            it.should('give access to the last of a multi-value option', access_last_value);
            it.should('provide a summary string of all options parsed', provide_summary_string);
        }

        private static function be_versioned():void
        {
            it.expects(OptionParser.version).toPatternMatch('(%d+).(%d+).(%d+)', 3);
        }

        private static function find_valid_input():void
        {
            var options:OptionParser = new OptionParser(argProvider1);
            options.parse();

            it.expects(options.argCount).toEqual(args.length);
        }

        private static function ignore_leading_args():void
        {
            var noOptions:OptionParser = new OptionParser(argProvider2);
            noOptions.parse();

            it.expects(noOptions.hasOption('not-an-option')).toBeFalsey();
            it.expects(noOptions.toString()).toBeEmpty();
        }

        private static function parse_short_form():void
        {
            var options:OptionParser = new OptionParser(argProvider1);
            options.parse();

            it.expects(options.getOption('b').hasValue).toBeTruthy();
            it.expects(options.getOption('c').hasValue).toBeTruthy();
        }

        private static function parse_long_form():void
        {
            var options:OptionParser = new OptionParser(argProvider1);
            options.parse();

            it.expects(options.getOption('option-one').hasValue).toBeTruthy();
            it.expects(options.getOption('option-four').hasValue).toBeTruthy();
        }

        private static function assume_flags_true():void
        {
            var options:OptionParser = new OptionParser(argProvider1);
            options.parse();

            it.expects(options.getOption('b').isSet).toBeTruthy();
            it.expects(options.getOption('option-four').isSet).toBeTruthy();
        }

        private static function create_tuples_many_args():void
        {
            var options:OptionParser = new OptionParser(argProvider1);
            options.parse();

            it.expects(options.getOption('option-one').value).toBeA(Vector);
            it.expects(options.getOption('option-one').value.length).toEqual(3);
        }

        private static function create_tuples_one_arg():void
        {
            var options:OptionParser = new OptionParser(argProvider1);
            options.parse();

            it.expects(options.getOption('c').value).toBeA(Vector);
            it.expects(options.getOption('c').value.length).toEqual(1);
        }

        private static function create_tuples_no_args():void
        {
            var options:OptionParser = new OptionParser(argProvider1);
            options.parse();

            it.expects(options.getOption('b').value).toBeA(Vector);
            it.expects(options.getOption('b').value.length).toEqual(1);
            it.expects(options.getOption('option-four').value).toBeA(Vector);
            it.expects(options.getOption('option-four').value.length).toEqual(1);
        }

        private static function return_defaults():void
        {
            var xDefault:Vector.<String> = ['x-default'];
            var options:OptionParser = new OptionParser(argProvider1);
            options.parse();

            it.expects(options.getOption('x', '', xDefault).value).toEqual(xDefault);
        }

        private static function access_first_value():void
        {
            var options:OptionParser = new OptionParser(argProvider1);
            options.parse();

            it.expects(options.getOption('option-one').firstValue).toEqual('v1');
        }

        private static function access_last_value():void
        {
            var options:OptionParser = new OptionParser(argProvider1);
            options.parse();

            it.expects(options.getOption('option-one').lastValue).toEqual('v3');
        }

        private static function provide_summary_string():void
        {
            var options:OptionParser = new OptionParser(argProvider1);
            options.parse();

            it.expects(options.toString()).toEqual('-b (true)\n--option-one (v1,v2,v3)\n-c (value for c)\n--option-four (true)\n');
        }
    }

    class ArgProviderMock
    {
        private var args:Vector.<String>;

        public function ArgProviderMock(args:Vector.<String>)
        {
            this.args = args;
        }

        public function getArg(i:Number):String { return args[i]; }
        public function getArgCount():Number { return args.length; }
    }
}
