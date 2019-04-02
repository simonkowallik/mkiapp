# Makefile
This Makefile provides you with an example for mkiapp using GNU make.

It allows to build the iapp by typing `make` or `make build`.
`make verify` uploads the iapp template to your test BIG-IP using scp and runs `tmsh load /sys config merge verify`.
`make deploy` does the same as `make verify` plus it actually merges it.
*Note:* that this will overwrite any exsting iapp template with the same name!

To configure your target BIGIP set it in the Makefile or use the environment variable `BIGIP` to overwrite the configured value in the Makefile. Do the same for `BUSER`.

Example:
```sh
# make
mkiapp > iapp.tmpl

# make verify
scp iapp.tmpl simon@192.168.0.245:/tmp/
ssh simon@192.168.0.245 tmsh load sys config merge verify file /tmp/iapp.tmpl

# BUSER=admin BIGIP=192.0.2.1 make deploy
scp iapp.tmpl admin@192.0.2.1:/tmp/
ssh admin@192.0.2.1 tmsh load sys config merge verify file /tmp/iapp.tmpl
ssh admin@192.0.2.1 tmsh load sys config merge file /tmp/iapp.tmpl
```

# simple
A simple mkiapp demo, see directory for more details.

# advanced
A more advanced mkiapp demo, see directory for more details.