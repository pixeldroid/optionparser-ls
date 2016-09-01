package
{
    import pixeldroid.bdd.Spec;
    import pixeldroid.bdd.Thing;

    import pixeldroid.cli.OptionParser;

    public static class OptionParserSpec
    {
        public static function describe():void
        {
            var it:Thing = Spec.describe('OptionParser');

            var args:Vector.<String> = ['--option-one', 'v1', 'v2', 'v3', '-b', '-c', 'value for c', '--option-four'];
            var argProvider1 = new ArgProviderMock(args);
            var argProvider2 = new ArgProviderMock(['not-an-option']);

            var options:OptionParser = new OptionParser(argProvider1);
            options.parse();

            it.should('be versioned', function() {
                it.expects(OptionParser.version).toPatternMatch('(%d+).(%d+).(%d+)', 3);
            });

            it.should('find all the valid options, arguments, and flags', function() {
                it.expects(options.argCount).toEqual(args.length);
            });

            it.should('ignore leading options that do not start with a hyphen', function() {
                var noOptions:OptionParser = new OptionParser(argProvider2);
                noOptions.parse();
                it.expects(noOptions.hasOption('not-an-option')).toBeFalsey();
                it.expects(noOptions.toString()).toBeEmpty();
            });

            it.should('parse short-form options', function() {
                it.expects(options.getOption('b').hasValue).toBeTruthy();
                it.expects(options.getOption('c').hasValue).toBeTruthy();
            });

            it.should('parse long-form options', function() {
                it.expects(options.getOption('option-one').hasValue).toBeTruthy();
                it.expects(options.getOption('option-four').hasValue).toBeTruthy();
            });

            it.should('assume options with no values are flags set true', function() {
                it.expects(options.getOption('b').isSet).toBeTruthy();
                it.expects(options.getOption('option-four').isSet).toBeTruthy();
            });

            it.should('parse the option value as a tuple when multiple args are provided', function() {
                it.expects(options.getOption('option-one').value).toBeA(Vector);
                it.expects(options.getOption('option-one').value.length).toEqual(3);
            });

            it.should('parse the option value as a tuple when just a single arg is provided', function() {
                it.expects(options.getOption('c').value).toBeA(Vector);
                it.expects(options.getOption('c').value.length).toEqual(1);
            });

            it.should('parse the option value as a tuple when no args are provided', function() {
                it.expects(options.getOption('b').value).toBeA(Vector);
                it.expects(options.getOption('b').value.length).toEqual(1);
                it.expects(options.getOption('option-four').value).toBeA(Vector);
                it.expects(options.getOption('option-four').value.length).toEqual(1);
            });

            it.should('return a default option when a user provided one cannot be retrieved', function() {
                var xDefault:Vector.<String> = ['x-default'];
                it.expects(options.getOption('x', '', xDefault).value).toEqual(xDefault);
            });

            it.should('provide a summary string of all options parsed', function() {
                it.expects(options.toString()).toEqual('-b (true)\n--option-one (v1,v2,v3)\n-c (value for c)\n--option-four (true)\n');
            });
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
