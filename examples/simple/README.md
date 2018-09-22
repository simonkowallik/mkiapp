# Simple Example

We are going to create an iApp Template based on the following files:
- implementation.tcl
- presentation.tcl
- macro.tcl
- help.html

The iApp will create an iRule which responds to all HTTP requests with a simple sorry text.

## Step 1: mkiapp init

run `mkiapp init` in the directory to initialize your iApp project.

    > mkiapp init
    initialized mkiapp in current directory, review .mkiapp_config and update as needed.

## Step 2: review and update config

Now let's review the most important settings in the config file:

    > head .mkiapp_config
    # iapp template name
    export MKIAPP_IAPP_TEMPLATE_NAME=simple

    # required iapp section files
    export MKIAPP_SECTIONFILE_PRESENTATION=presentation.tcl
    export MKIAPP_SECTIONFILE_IMPLEMENTATION=implementation.tcl

    # optional iapp section files
    export MKIAPP_SECTIONFILE_HELP=help.html
    export MKIAPP_SECTIONFILE_MACRO=macro.tcl

As you can see, the directory name has been set as the template name.
In this case this is not the best name, so let's change it.

    > sed -i 's/MKIAPP_IAPP_TEMPLATE_NAME=.*/MKIAPP_IAPP_TEMPLATE_NAME=myFirstiApp/' .mkiapp_config

We have just changed it to `myFirstiApp`.

The rest of the settings are fine, as mkiapp init successfully detected all our files.

## Step 3: generate iApp Template

Let's create the iApp from the files and save it to an file.

    > mkiapp > myFirstiApp.tmpl

That's it. You can import the iApp Template to your BIG-IP and use it!

:-)