TARGETS:=
TARGETS+=void-x86_64

default: $(TARGETS)

runner.sh.base64:
	bash ../../tool/template.sh --partials . runner.sh | base64 > $@

install.sh: runner.sh.base64
	bash ../../tool/template.sh --partials . main.sh > install.sh
	chmod +x install.sh

.PHONY: $(TARGETS)
$(TARGETS):
	if [ ! -d src/target/$@ ]; then echo "No such target: $@" ; exit 2; fi
	rm -rf target/$@
	mkdir -p build/$@
	cp -r src/common/*    build/$@/
	cp -r src/target/$@/* build/$@/
	cp Makefile build/$@/
	$(MAKE) --directory=build/$@ install.sh
	mkdir -p target/$@
	cp build/$@/install.sh target/$@

.PHONY: clean
clean:
	rm -rf build
