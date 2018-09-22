# Intro
mkiapp simplifies the process of "putting the pieces together" when writing iApps.
It combines separate files for presentation, implementation, macro and help section ("section files") into a iApp Template file, which can be loaded via the WebUI or tmsh.

`mkiapp` itself relies `bash`, `awk` and `cat` - common tools available on all platforms nowadays.

# Demo
Watch the [Youtube Demo](https://youtu.be/eBpsP71XFl8).

[![Youtube Demo Video](https://img.youtube.com/vi/eBpsP71XFl8/0.jpg)](https://youtu.be/eBpsP71XFl8)

# Details
To generate the iApp Template mkiapp either uses a builtin template or a custom template. The builtin template will be fine for most use-cases.

This template describes all attributes of the generated iApp Template and contains placeholders which are either replaced by the content of the section files or specific values of environment variables.

mkiapp uses a configuration file (`.mkiapp_config`) which contains various variables.
The section filenames and location is defined in the configuration file, as well as various variables (target iApp Template Name, minimum/maximum TMOS version and required modules).

# Usage
`mkiapp --help` will provide you with help.

`mkiapp init` will create the `.mkiapp_config` config file in the current directory for you. It will try to guess the section file names based on the content of the directory and use the current directory name as the iApp Template Name. You should check and modify settings afterwards.

`mkiapp init-section-files` creates all section files for you - these are skeletons and do not contain any content. It will not modify or delete any file content in case files exist.

Once you have you files ready and updated with content, you can create you iApp Template.
Running `mkiapp` will print the generated iApp Template on the console (STDOUT), you probably want to redirect the output to a file `mkiapp > myiAppTemplate.tmpl`.

To use a custom template, specify it as an argument: `mkiapp /iapp_templates/template.tmpl > myiAppTemplate.tmpl`.

*Note:* You have to run mkiapp in the directory of the section files.

# Examples
Check out the examples folder to learn how to use mkiapp.

# Extensibility and customization
The mkiapp functionality can be further extended.

Additional `MKIAPP_VAR_` variables can be used in iApp template attributes.

### Example

Add the following line to `.mkiapp_config`:

`export MKIAPP_VAR_DESCRIPTION="\"This is my iApp template\""`

Replace `description none` with `description <MKIAPP_VAR_DESCRIPTION>` in your custom iApp Template file to replace set the description attribute in the generated iApp Template.

You can use runtime environment variables on your shell as well. Make sure they exist and contains a value that is compatible with the iApp syntax rules.

## Advanced customization

Furthermore `MKIAPP_ENV_` variables allow content replacement within the generated iApp Template code.
This allows you to dynamically change content within section files during the mkiapp process.

### Example

Add `<MKIAPP_ENV_PRESENTATION_GITHASH>` placeholder to a section in the presentation definition:

    message githash "<MKIAPP_ENV_PRESENTATION_GITHASH>"

Specify the environment variable when running mkiapp:

    bash_prompt:> MKIAPP_ENV_PRESENTATION_GITHASH=\$(git log -1 --pretty=%h) \\
                    mkiapp > myiAppTemplate.tmpl

This would replace ''<MKIAPP_ENV_PRESENTATION_GITHASH>'' with the output of the command `git log -1 --pretty=%h` in the iApp Presentation Section.

You could also add this variable to the `.mkiapp_config` file to automatically set it whenever you run mkiapp:

    export MKIAPP_ENV_PRESENTATION_GITHASH=\$(git log -1 --pretty=%h)

In addition, `MKIAPP_FILE_`/`<MKIAPP_FILE_>` variables/placeholders allow to include file contents instead of a single variable. This can be helpful, for example to include additional script code in the implementation section.

> *Important:* All information on the line containing the placeholder `<MKIAPP_FILE_>` will be replaced! Make sure the placeholder is the *only* entry in the line.

`<MKIAPP_ENV_>` placeholders can be used in files which are included by `<MKIAPP_FILE_>` placeholders.

# building your own template

The builtin template can be listed with `mkiapp showbuiltin`:

    #TMSH-VERSION: <MKIAPP_VAR_TMSH_VERSION>
    cli admin-partitions {
        update-partition Common
    }
    sys application template /Common/<MKIAPP_IAPP_TEMPLATE_NAME> {
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
        requires-modules { <MKIAPP_VAR_MODULES> }
        signing-key none
        tmpl-checksum none
        tmpl-signature none
    }

> *Important:* Please note that the the whole line of section file placeholders `<MKIAPP_SECTIONFILE_>` will be replaced! Make sure the placeholder is the *only* entry in the line, as shown above.
