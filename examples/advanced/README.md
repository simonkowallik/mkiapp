# Advanced Example

In this more advanced example we are going to create an iApp Template based on the following files:
- impl.tcl  (The iApp Implementation Section)
- presentation.apl.txt  (The iApp Presentation Section)
- irule_macro.tcl  (The iApp Macro Section)

As you can see the names of the files have changed from the simple example and no HTML help file is present.

The iApp will create the same iRule (responds to all HTTP requests) as in the simple example but this time we will include a custom HTML file in the HTTP response instead.
For that we define the placeholder `<MKIAPP_FILE_HTMLRESPONSE>` and specify the custom HTML file in the environment variable `$MKIAPP_FILE_HTMLRESPONSE`.

The custom HTML file is: htmlresponse.html

We will also add a custom version string which we will use to create the iRule.
The placeholder will be `<MKIAPP_ENV_PRESENTATION_VERSION>` and the environment variable `$MKIAPP_ENV_PRESENTATION_VERSION`.

The placeholder is used in the presentation section in a choice field with a single entry. This allows us to use the standard variable in the implementation section and also presents the version to the user on creation of the Application Service.

We also add the placeholder to the custom HTML file so the version is included in the HTTP response.

## Step 1: mkiapp init

run `mkiapp init` in the directory to initialize your iApp project.

    > mkiapp init
    Initialized mkiapp in current working directory with settings:
    
    mkiapp config MKIAPP_IAPP_NAME "advanced"
    mkiapp config MKIAPP_IAPP_SKELETON "builtin"
    mkiapp config MKIAPP_SECTIONFILE_PRESENTATION "presentation.apl.txt"
    mkiapp config MKIAPP_SECTIONFILE_IMPLEMENTATION "implementation.tcl"
    mkiapp config MKIAPP_SECTIONFILE_HELP "help.html"
    mkiapp config MKIAPP_SECTIONFILE_MACRO "macro.tcl"
    mkiapp config MKIAPP_VAR_TMSH_VERSION "11.6.0"
    mkiapp config MKIAPP_VAR_MINVERSION "none"
    mkiapp config MKIAPP_VAR_MAXVERSION "none"
    mkiapp config MKIAPP_VAR_REQUIRED_MODULES ""
    
    Please review and modify as needed.

## Step 2: review and update config

Looking at the output of the previous step, `mkiapp init` did not detect all files correctly.
Hence we need to correct the configuration:

    > mkiapp config MKIAPP_SECTIONFILE_IMPLEMENTATION impl.tcl
    > mkiapp config MKIAPP_SECTIONFILE_MACRO irule_macro.tcl

Also we don't have a HTML Help file, but we can leave it in place at it is no problem if it is missing.

Let's change iApp Name as well:

    > mkiapp config MKIAPP_IAPP_NAME myAdvancediApp


## Step 3: generate iApp

Let's create the iApp and save it to an file.

    > MKIAPP_ENV_PRESENTATION_VERSION=v01 MKIAPP_FILE_HTMLRESPONSE=./htmlresponse.html mkiapp > myAdvancediApp.tmpl

That's it. You can import the iApp to your BIG-IP and use it!

:-)