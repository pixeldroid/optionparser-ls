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


## working from source

first install [loomtasks][loomtasks]

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
