# mkiapp
[![Travis Build Status](https://img.shields.io/travis/com/simonkowallik/mkiapp/master.svg?label=travis%20build)](https://travis-ci.com/simonkowallik/mkiapp)
[![Releases](https://img.shields.io/github/release/simonkowallik/mkiapp.svg)](https://github.com/simonkowallik/mkiapp/releases)
[![Latest Release Date](https://img.shields.io/github/release-date/simonkowallik/mkiapp.svg?color=blue)](https://github.com/simonkowallik/mkiapp/releases/latest)
[![Commits since latest release](https://img.shields.io/github/commits-since/simonkowallik/mkiapp/latest.svg)](https://github.com/simonkowallik/mkiapp/commits)
## Intro
`mkiapp` simplifies the process of "putting the pieces together" when developing iApps.
When developing larger iApps you most likely want to split the separate sections into files and not use the WebUI to develop it either.
`mkiapp` combines separate files for presentation, implementation, macro and help section into a target iApp, which can be loaded via the WebUI or tmsh. It provides advanced features to generate iApps and dynamically replace data within it.

`mkiapp` itself relies on `bash`, `awk` and other common command line tools - available on most platforms.


## Not convinced? Watch this demo!
<p align="center">
    <img src="https://simonkowallik.github.io/mkiapp/examples/demo.svg">
</p>


## Installation

### Manual
 Copy the `mkiapp` file to any place in your `$PATH`. You can also fetch a [release](https://github.com/simonkowallik/mkiapp/releases) .zip or .tar.gz instead.

### Homebrew / Linuxbrew
You can install `mkiapp` via homebrew and linuxbrew.

    brew install simonkowallik/f5/mkiapp

If you want to receive updates when running `brew update` add my tap with `brew tap simonkowallik/f5`.

> ***Info for fish users:*** If you have trouble running `mkiapp` with fish, either create an alias (`alias mkiapp (which mkiapp)`) or execute `mkiapp` with it's full path (eg. `/usr/local/bin/mkiapp`).

## Details
To generate the target iApp, which can be used on an F5 BIG-IP device, `mkiapp` uses a so called `iApp Skeleton Template`.
The `iApp Skeleton Template` can be loaded from a file or the `builtin iApp Skeleton Template` is used, which should be sufficient for most use-cases.
`mkiapp` reads its settings from the `.mkiapp configuration file` in the current working directory (similar to `git`).

### The iApp Skeleton Template
The `iApp Skeleton Template` contains the general structure of a target iApp. `<placeholders>` are used within the `iApp Skeleton Template` to include `Section Skeleton Files` and `iApp Skeleton Template Variables`.

You can create your own `iApp Skeleton Template`, see further below if required.

### The Section Skeleton Files
The `Section Skeleton Files` reference to a file on the filesystem. This file content is included into the `iApp Skeleton Template` to fill four iApp Sections:
- presentation (required)
- implementation (required)
- macro (optional / depends on use-case)
- html-help (optional)

`Section Skeleton Files` are technically represented by a shell variable, the variable content is the file on the filesystem.

### The Skeleton Template Variables
`Skeleton Template Variables` define a single value within the `iApp Skeleton Template`, for example `Skeleton Template Variables` are used to define:
- iApp Name
- Minimum BIG-IP Version
- Minimum BIG-IP Version
- Required Modules (e.g. LTM, AFM)

Technically `Skeleton Template Variables` are shell variables.

You can define additional `Skeleton Template Variables` for use in custom `iApp Skeleton Templates` if needed.

### < placeholders >
`Section Skeleton Files` and `Skeleton Template Variables` have a corresponding `<placeholder>` within the `iApp Skeleton Template`.

The `<placeholder>` is replaced by the actual value of `Skeleton Template Variable` or content of the `Section Skeleton File`.

The following table maps the default `<placeholders>` to the `Skeleton Template Variables` and `Section Skeleton Files`.

| < placeholder >                   | shell variable name              |variable value    |
|-----------------------------------|----------------------------------|------------------|
|<MKIAPP_IAPP_NAME>                 |$MKIAPP_IAPP_NAME                 |MyHTTPSiApp       |
|<MKIAPP_VAR_MINVERSION>            |$MKIAPP_VAR_MINVERSION            |11.6.0            |
|<MKIAPP_VAR_MAXVERSION>            |$MKIAPP_VAR_MAXVERSION            |13.1.1            |
|<MKIAPP_VAR_REQUIRED_MODULES>      |$MKIAPP_VAR_REQUIRED_MODULES      |ltm               |
|<MKIAPP_VAR_TMSH_VERSION>          |$MKIAPP_VAR_TMSH_VERSION          |11.6.0            |
|<MKIAPP_SECTIONFILE_PRESENTATION>  |$MKIAPP_SECTIONFILE_PRESENTATION  |presentation.tcl  |
|<MKIAPP_SECTIONFILE_IMPLEMENTATION>|$MKIAPP_SECTIONFILE_IMPLEMENTATION|implementation.tcl|
|<MKIAPP_SECTIONFILE_MACRO>         |$MKIAPP_SECTIONFILE_MACRO         |macro.tcl         |
|<MKIAPP_SECTIONFILE_HELP>          |$MKIAPP_SECTIONFILE_HELP          |help.html         |

With exception to `<>` the `<placeholder>` names and `Skeleton Template Variable` names are the same.

The variables are defined and read from the `.mkiapp configuration file`. 

### .mkiapp configuration file
The `.mkiapp configuration file` can be created by running `mkiapp init` and contains the shell variables above.
It further allows to customise `mkiapp` behaviour.

When `mkiapp` runs, it first checks for `.mkiapp` in the current working directory and will complain if it doesn't exist.
Here is an example `.mkiapp` file, which can be printed by running `mkiapp config`:

    # initialized with version: 1.0
    # For documentation see: https://github.com/simonkowallik/mkiapp
    #
    # iApp Name (target iApp)
    export MKIAPP_IAPP_NAME=myiAppName
    
    # iApp Skeleton Template (default: builtin)
    export MKIAPP_IAPP_SKELETON=builtin
    
    # required Section Skeleton Files (filenames)
    export MKIAPP_SECTIONFILE_PRESENTATION=presentation.tcl
    export MKIAPP_SECTIONFILE_IMPLEMENTATION=implementation.tcl
    
    # optional Section Skeleton Files (filenames)
    export MKIAPP_SECTIONFILE_HELP=help.html
    export MKIAPP_SECTIONFILE_MACRO=macro.tcl
    
    # iApp Skeleton Template Variables
    export MKIAPP_VAR_TMSH_VERSION=11.6.0
    export MKIAPP_VAR_MINVERSION=none
    export MKIAPP_VAR_MAXVERSION=none
    export MKIAPP_VAR_REQUIRED_MODULES=

When you run `mkiapp init` it will try to guess the file names for all four `Section Skeleton Files`, otherwise it will use the default names (see above). Non-existing files are ignored when `mkiapp` generates an iApp.

`mkiapp config` lets you interact with the configuration easily, it allows to read specific variables as well as set new values for existing variables or add new ones.
`mkiapp config edit` opens `.mkiapp` in your `$EDITOR`.

Based on the configuration above, `mkiapp config MKIAPP_IAPP_NAME` would print `myiAppName` and `mkiapp config MKIAPP_IAPP_NAME myHTTPiApp` would set the variable value to `myHTTPiApp`.

Of course you can just use your favorite editor to modify the file.

## Usage
`mkiapp --help` will provide you with the following help.

    usage: mkiapp [init] [init-files [DIR]] [showbuiltin] [showmakefile] [config [edit] [<key>] [<key> <value>]] [-t|--template <file>] [--(no-)impl|--(no-)implementation] [--(no-)apl|--(no-)presentation] [--(no-)macro] [--(no-)html] [-h|--help] [-v|--version]
                   init:    initialize current working directory for mkiapp
             init-files:    create Section Skeleton Files in current working directory or [DIR]
            showbuiltin:    print builtin iApp Skeleton Template
           showmakefile:    print example Makefile
                 config:    no arguments: prints full configuration
                            edit: opens configuration in $EDITOR
                            <key>: prints its value
                            <key> <value>: sets <key> to <value>
          -t,--template:    use <file> as iApp Skeleton Template instead of 'builtin'
       --implementation:    only includes implementation Section Skeleton File in generated iApp
    --no-implementation:    explictly excludes implementation Section Skeleton File from generated iApp
         --presentation:    only includes presentation Section Skeleton File in generated iApp
      --no-presentation:    explictly excludes presentation Section Skeleton File from generated iApp
                --macro:    only includes macro Section Skeleton File in generated iApp
             --no-macro:    explictly excludes macro Section Skeleton File from generated iApp
                 --html:    only includes html-help Section Skeleton File in generated iApp
              --no-html:    only includes html-help Section Skeleton File from generated iApp
              -h,--help:    prints this help
           -v,--version:    prints version
    
    mkiapp simplifies the process of combining separate source files into an iApp Template.
    Start with 'mkiapp init' to initialize the current working directory. Executing 'mkiapp' will generate an iApp.

You start with `mkiapp init`, as outlined earlier. If you start a new project you can use `mkiapp init-files [DIR]` to create the `Section Skeleton Files` in the current working directory or `[DIR]` (don't worry, existing files will not be overwritten).

Once you have you files ready and updated with content, you can generate your own iApp.
Running `mkiapp` will use the `iApp Skeleton Template`, include all `Section Skeleton Files` and `Skeleton Template Variables` and output your own iApp Template on the console (`STDOUT`).
So you probably want to redirect the output to a file like this `mkiapp > myiAppTemplate.tmpl`.

If you use a custom `iApp Skeleton Template`, you can specify it with `-t | --template`: `mkiapp --template /iapp_templates/template.tmpl > myiAppTemplate.tmpl`.
You could also set it permanently with `mkiapp config MKIAPP_IAPP_SKELETON /iapp_templates/template.tmpl`, which would update the `.mkiapp configuration file`.

There are a couple of other options available to generate your iApp. `--implementation`, `--presentation`, `--macro` and `--html` allow you to specifically generate the iApp with the selected sections only, all unspecified sections would be empty. This can be very useful when troubleshooting syntax errors, for example when you are not sure which section(s) contains them.
`--no-implementation`, `--no-presentation`, `--no-macro` and `--no-html` on the other hand allow you specifically exclude the specified section. 

> ***Note:*** You always have to run `mkiapp` in the directory you "initialised" (contains the `.mkiapp configuration file`), similar to `git`.

### Deploy iApp template to an F5 BIG-IP
Various ways are available to deploy the iApp template on an F5 BIG-IP.
While detailing all possibilities is out of scope of this tool, here is a short quide using ssh/command line:

1. copy the iapp template to the BIG-IP /tmp directory (the directory matters for step 2+3!)
```sh
scp ./my_iapp_template.tmpl root@bigip:/tmp/my_iapp_template.tmpl
```

2. verify that the template has no syntax errors before merging it
```sh
ssh root@bigip 'tmsh load sys config merge verify file /tmp/my_iapp_template.tmpl'
```

3. merge iapp template into current configuration (note that this overwrites any existing template which has the same iapp name)
```sh
ssh root@bigip 'tmsh load sys config merge file /tmp/my_iapp_template.tmpl'
```

Best to use with ssh public-key authentication.

Also checkout the examples/Makefile, which provides a simple way to copy the built iapp to a BIG-IP.
If you like it `mkiapp showmakefile > ./Makefile` will build it for you!

## Examples
Two examples are located in the examples folder of this repository to demonstrate the use of `mkiapp`.

## Extensibility and customisation
The `mkiapp` functionality can be further extended. `mkiapp` uses the bash `source` command to include `.mkiapp`, which gives you a lot of power and control over `mkiapp`.

A simple use-case could be to add additional `MKIAPP_VAR_` variables when you need a custom `iApp Skeleton Template`.

#### Example
If you want to add the a description to the generated iApp Template you could come up with a new variable, let's say `MKIAPP_VAR_DESCRIPTION`. The corresponding placeholder would be `<MKIAPP_VAR_DESCRIPTION>`.

Let's first add the variable with a static value:
`mkiapp config MKIAPP_VAR_DESCRIPTION "This is my iApp template description"`

Replace `description none` with `description <MKIAPP_VAR_DESCRIPTION>` in your custom`iApp Skeleton Template` file and you are done.

If you need a more dynamic description you could set `MKIAPP_VAR_DESCRIPTION` to another variable name, like so:
`mkiapp config MKIAPP_VAR_DESCRIPTION "\$env_iapp_desc"`.
`mkiapp` would then rely on the existence of `$env_iapp_desc` when it generates the iApp to fill the description field.

Another option would be to not configure `MKIAPP_VAR_DESCRIPTION` in the `.mkiapp configuration file` and instead always provide it when running `mkiapp`.

> ***Important:*** No matter which technique you decide on using, make sure the resulting value in the iApp template follows the iApp syntax.

### More advanced customisation
Furthermore `$MKIAPP_ENV_` variables allow content replacement within the generated iApp. This allows you to dynamically change content which is included form the `Section Skeleton Files` during the `mkiapp` iApp generation process.

#### Example

Add `<MKIAPP_ENV_PRESENTATION_GITHASH>` placeholder to a section in the presentation `Section Skeleton File`:

    message githash "<MKIAPP_ENV_PRESENTATION_GITHASH>"

Use one of the techniques outlined above to set the corresponding variable. For example:

    MKIAPP_ENV_PRESENTATION_GITHASH=$(git log -1 --pretty=%h) \
                    mkiapp > myiAppTemplate.tmpl

This would replace '`<MKIAPP_ENV_PRESENTATION_GITHASH>` with the short version of the latest git hash (command: `git log -1 --pretty=%h`) in the generated iApp Presentation Section.

You could also add this variable to the `.mkiapp` file to automatically set it whenever you run `mkiapp`:

    mkiapp config MKIAPP_ENV_PRESENTATION_GITHASH "\$(git log -1 --pretty=%h)"

*Not enough?*

Using `$MKIAPP_FILE_` variables allow to include file contents instead of a single value. This can be helpful, for example to include additional script code in the implementation section.
For example the placeholder `<MKIAPP_FILE_BASH_SCRIPT>` could be used to include a bash script in a variable within the implementation section.

    set bash_script {
    <MKIAPP_FILE_BASH_SCRIPT>
    }

 `$MKIAPP_FILE_BASH_SCRIPT` would then need to point a file. The file content would be included in the `set bash_script { }` tcl code within the implementation section.

> ***Important:*** You might have noticed that the placeholder `<MKIAPP_FILE_BASH_SCRIPT>` is placed on a separate line. The reason is that information on the line will be replaced! Therefore make sure the placeholder is the *only* entry in the line, as in the example above.

*Still not enough?*

`<MKIAPP_ENV_>` placeholders can be used in files included by `<MKIAPP_FILE_>` as well. :-)

### Creating your own iApp Skeleton Template
If you need a custom `iApp Skeleton Template`, you can start off by using the `builtin` one.
The builtin template can be listed with `mkiapp showbuiltin`:

    #TMSH-VERSION: <MKIAPP_VAR_TMSH_VERSION>
    
    cli admin-partitions {
        update-partition Common
    }
    sys application template /Common/<MKIAPP_IAPP_NAME> {
        actions {
            definition {
                html-help {
    <MKIAPP_SECTIONFILE_HELP>
                }
                implementation {
    <MKIAPP_SECTIONFILE_IMPLEMENTATION>
                }
                macro {
    <MKIAPP_SECTIONFILE_MACRO>
                }
                presentation {
    <MKIAPP_SECTIONFILE_PRESENTATION>
                }
                role-acl none
                run-as none
            }
        }
        description none
        ignore-verification false
        requires-bigip-version-max <MKIAPP_VAR_MINVERSION>
        requires-bigip-version-min <MKIAPP_VAR_MAXVERSION>
        requires-modules { <MKIAPP_VAR_REQUIRED_MODULES> }
        signing-key none
        tmpl-checksum none
        tmpl-signature none
    }

Add your own `<placeholders>` as required.

> ***Important:*** Please note that the the whole line of `Section Skeleton File` placeholders (`<MKIAPP_SECTIONFILE_>` ) will be replaced! Make sure the placeholder is the *only* entry in the line, as shown above.
