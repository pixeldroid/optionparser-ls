optionparser-ls
===============

a simple option parser for [Loom][loom-sdk] commandline apps

- [installation](#installation)
- [usage](#usage)
- [building](#building)
- [contributing](#contributing)


## installation

Download the library into its matching sdk folder:

    $ curl -L -o ~/.loom/sdks/sprint34/libs/OptionParser.loomlib \
        https://github.com/pixeldroid/optionparser-ls/releases/download/v2.1.1/OptionParser-sprint34.loomlib

To uninstall, simply delete the file:

    $ rm ~/.loom/sdks/sprint34/libs/OptionParser.loomlib


## usage

0. declare a reference to the OptionParser loomlib in your `.build` file:
    ```ls
    "references": [
        "System",
        "OptionParser"
    ],
    ```
0. import `pixeldroid.cli.OptionParser`
0. instantiate a new `pixeldroid.cli.OptionParser` and call the `parse()` method on it
0. retrieve `pixeldroid.cli.Option` items via the `getOption()` method of OptionParser

### OptionParserDemo

see an example of using the OptionParser here:

* [OptionParserDemoCLI.build][OptionParserDemoCLI.build]
* [OptionParserDemoCLI.ls][OptionParserDemoCLI.ls]

you can compile and run the demo from the command line:

    $ cd test
    $ ~/.loom/sdks/sprint34/bin/osx-x64/tools/lsc OptionParserDemoCLI.build
    $ mv bin/OptionParserDemoCLI.loom bin/Main.loom
    $ ~/.loom/sdks/sprint34/bin/osx-x64/tools/loomexec // --help
    $ ~/.loom/sdks/sprint34/bin/osx-x64/tools/loomexec // --optionA arg1 arg2 -b

or use Rake:

    $ rake cli['--optionA arg1 arg2 -b']


## building

first, install [loomtasks][loomtasks] and the [spec-ls library][spec-ls]

### compiling from source

    $ rake lib:install

this will build the OptionParser library and install it in the currently configured sdk

### running tests

    $ rake test

this will build the OptionParser library, install it in the currently configured sdk, build the test app, and run the test app.


## contributing

Pull requests are welcome!

[loom-sdk]: https://github.com/LoomSDK/LoomSDK "a native mobile app and game framework"
[loomtasks]: https://github.com/pixeldroid/loomtasks "Rake tasks for working with loomlibs"
[OptionParserDemoCLI.build]: ./cli/src/OptionParserDemoCLI.build "build file for the demo"
[OptionParserDemoCLI.ls]: ./cli/src/demo/OptionParserDemoCLI.ls "source file for the demo"
[spec-ls]: https://github.com/pixeldroid/spec-ls "a simple spec framework for Loom"
