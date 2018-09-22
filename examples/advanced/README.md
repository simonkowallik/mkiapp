# Advanced Example

In this more advanced example we are going to create an iApp Template based on the following files:
- impl.tcl  (The iApp Implementation Section)
- presentation.apl.txt  (The iApp Presentation Section)
- irule_macro.tcl  (The iApp Macro Section)

As you can see the names of the files have changed from the simple example and no HTML help file is present.

The iApp will create the same iRule (responds to all HTTP requests) as in the simple example but this time we will include a custom HTML file in the HTTP response instead.
For that we define the placeholder `<MKIAPP_FILE_HTMLRESPONSE>` and specify the custom HTML file in the environment variable `MKIAPP_FILE_HTMLRESPONSE`.

The custom HTML file is: htmlresponse.html

We will also add a custom version string which we will use to create the iRule.
The placeholder will be `<MKIAPP_ENV_PRESENTATION_VERSION>` and the environment variable `MKIAPP_ENV_PRESENTATION_VERSION`.

The placeholder is used in the presentation section in a choice field with a single entry. This allows us to use the standard variable in the implementation section and also presents the version to the user on creation of the Application Service.

We also add the placeholder to the custom HTML file so the version is included in the HTTP response.

## Step 1: mkiapp init

run `mkiapp init` in the directory to initialize your iApp project.

    > mkiapp init
    initialized mkiapp in current directory, review .mkiapp_config and update as needed.

## Step 2: review and update config

Now let's review the most important settings in the config file:

    > head .mkiapp_config
    # iapp template name
    export MKIAPP_IAPP_TEMPLATE_NAME=advanced
    
    # required iapp section files
    export MKIAPP_SECTIONFILE_PRESENTATION=presentation.apl.txt
    export MKIAPP_SECTIONFILE_IMPLEMENTATION=implementation.tcl
    
    # optional iapp section files
    export MKIAPP_SECTIONFILE_HELP=help.html
    export MKIAPP_SECTIONFILE_MACRO=macro.tcl

mkiapp did not detect the correct implementation section file, nor the macro file as they don't match the pattern defined in mkiapp.
We need to correct that manually.

Also we don't have a HTML Help file, but we can leave it in place at it is no problem if it is missing.

Let's correct the settings and change the iApp Template Name as well:

    > sed -i 's/MKIAPP_SECTIONFILE_IMPLEMENTATION=.*/MKIAPP_SECTIONFILE_IMPLEMENTATION=impl.tcl/' .mkiapp_config
    > sed -i 's/MKIAPP_SECTIONFILE_MACRO=.*/MKIAPP_SECTIONFILE_MACRO=irule_macro.tcl/' .mkiapp_config
    > sed -i 's/MKIAPP_IAPP_TEMPLATE_NAME=.*/MKIAPP_IAPP_TEMPLATE_NAME=myAdvancediApp/' .mkiapp_config


## Step 3: generate iApp Template

Let's create the iApp from the files and save it to an file.

    > MKIAPP_ENV_PRESENTATION_VERSION=v01 MKIAPP_FILE_HTMLRESPONSE=./htmlresponse.html mkiapp > myAdvancediApp.tmpl

That's it. You can import the iApp Template to your BIG-IP and use it!

:-)