optionparser-ls
===============

a simple option parser for Loom commandline apps


## installation

Download the library into its matching sdk folder:

```bash
$ curl -L -o ~/.loom/sdks/sprint33/libs/OptionParser.loomlib \
    https://github.com/pixeldroid/optionparser-ls/releases/download/v1.0.0/OptionParser-sprint33.loomlib
```

To uninstall, simply delete the file:

```bash
$ rm ~/.loom/sdks/sprint33/libs/OptionParser.loomlib
```


## usage

0. declare a reference to the OptionParser loomlib in your `.build` file:
    * 
    ```
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

* [OptionParserDemo.build][OptionParserDemo.build]
* [OptionParserDemo.ls][OptionParserDemo.ls]

```bash
$ cd test
$ ~/.loom/sdks/sprint33/tools/lsc OptionParserTest.build
$ ~/.loom/sdks/sprint33/tools/loomexec bin/OptionParserTest.loom --help
```

## working from source

> first install [loomtasks][loomtasks]

### compiling

```bash
$ rake lib:install
```

this will build the OptionParser library and install it in the currently configured sdk

### running tests

```bash
$ rake test:run
```

this will build the OptionParser library, install it in the currently configured sdk, build the test app, and run the test app.


## contributing

Pull requests are welcome!


[loomtasks]: https://github.com/pixeldroid/loomtasks "loomtasks"
[OptionParserDemo.build]: ./test/src/OptionParserDemo.build "build file for the demo"
[OptionParserDemo.ls]: ./test/src/OptionParserDemo.ls "source file for the demo"
