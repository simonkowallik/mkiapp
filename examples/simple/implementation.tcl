iapp::template start

iapp::conf create ltm rule $::main__irule_name [tmsh::expand_macro -vars [list "code" $::main__status_code]]

iapp::template stop