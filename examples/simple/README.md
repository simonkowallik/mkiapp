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
    Initialized mkiapp in current working directory with settings:
    
    mkiapp config MKIAPP_IAPP_NAME "simple"
    mkiapp config MKIAPP_IAPP_SKELETON "builtin"
    mkiapp config MKIAPP_SECTIONFILE_PRESENTATION "presentation.tcl"
    mkiapp config MKIAPP_SECTIONFILE_IMPLEMENTATION "implementation.tcl"
    mkiapp config MKIAPP_SECTIONFILE_HELP "help.html"
    mkiapp config MKIAPP_SECTIONFILE_MACRO "macro.tcl"
    mkiapp config MKIAPP_VAR_TMSH_VERSION "11.6.0"
    mkiapp config MKIAPP_VAR_MINVERSION "none"
    mkiapp config MKIAPP_VAR_MAXVERSION "none"
    mkiapp config MKIAPP_VAR_REQUIRED_MODULES ""
    
    Please review and modify as needed.

## Step 2: review and update config

All settings above are fine, all files have been detected successfully.
Let's change the Name of the iApp though:

    > mkiapp config MKIAPP_IAPP_NAME "myFirstiApp"

We have just changed it to `myFirstiApp`.

## Step 3: generate iApp Template

Let's create the iApp from the files and save it to an file.

    > mkiapp > myFirstiApp.tmpl

That's it. You can import the iApp Template to your BIG-IP and use it!

:-)