
package pixeldroid.cli
{

    public class Option
    {

        private var _shortName:String;
        private var _longName:String;
        private var _defaultValue:Vector.<String>;
        private var _value:Vector.<String>;


        public function Option(shortName:String, longName:String, defaultValue:Vector.<String> = ['true'])
        {
            _shortName = shortName;
            _longName = longName;
            _defaultValue = defaultValue;
            _value = defaultValue;
        }

        public function get shortName():String
        {
            return isValidName(_shortName) ? _shortName : '?';
        }

        public function get longName():String
        {
            return isValidName(_longName) ? _longName : '?';
        }

        public function get defaultValue():Vector.<String>
        {
            return _defaultValue;
        }

        public function get isSet():Boolean
        {
            return hasValue && (_value[0] == 'true');
        }

        public function get hasValue():Boolean
        {
            return _value && _value.length > 0;
        }

        public function get value():Vector.<String>
        {
            return _value;
        }

        public function set value(v:Vector.<String>):void
        {
            _value = v;
        }

        public function toString():String
        {
            var s:String = '';
            s += '-' +shortName;
            s += ', ';
            s += '--' +longName;
            s += ' (' +value.join(',') +')';

            return s;
        }


        private function isValidName(n:String):Boolean
        {
            return (n && n.length > 0);
        }
    }
}
