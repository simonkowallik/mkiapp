BUSER ?= root
BIGIP ?= 192.168.0.245

all:
	mkiapp > iapp.tmpl

build: all

upload:
	scp iapp.tmpl $(BUSER)@$(BIGIP):/tmp/

verify: upload
	ssh $(BUSER)@$(BIGIP) 'tmsh load sys config merge verify file /tmp/iapp.tmpl'

deploy: verify
	ssh $(BUSER)@$(BIGIP) 'tmsh load sys config merge file /tmp/iapp.tmpl'

install: deploy