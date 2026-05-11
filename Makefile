PREFIX ?= /usr
BUILD_TYPE ?= Release
BUILD_DIR = build
JOBS = $(shell nproc)

all: build

clean:
	@rm -rf $(BUILD_DIR) .cache
	@find docs -mindepth 1 ! -name 'CNAME' -exec rm -rf {} + 2>/dev/null || true

build:
	cmake -B $(BUILD_DIR) -DCMAKE_BUILD_TYPE=$(BUILD_TYPE) -DCMAKE_INSTALL_PREFIX=$(PREFIX)
	cmake --build $(BUILD_DIR) -j$(JOBS)

install: build
	sudo cmake --install $(BUILD_DIR)

uninstall:
	@if [ -f $(BUILD_DIR)/install_manifest.txt ]; then \
		sudo xargs rm -f < $(BUILD_DIR)/install_manifest.txt; \
	else \
		sudo rm -f $(PREFIX)/lib/hyprland/plugins/libhyprlua.so; \
		sudo rm -rf $(PREFIX)/share/hyprlua; \
	fi

load:
	@hyprctl plugin list | grep -q 'Plugin Hyprlua' && hyprctl plugin unload $(PREFIX)/lib/hyprland/plugins/libhyprlua.so || true
	hyprctl plugin load $(PREFIX)/lib/hyprland/plugins/libhyprlua.so

unload:
	hyprctl plugin unload $(PREFIX)/lib/hyprland/plugins/libhyprlua.so

reload: unload load

dev-load: build
	@hyprctl plugin list | grep -q 'Plugin Hyprlua' && hyprctl plugin unload $(CURDIR)/build/libhyprlua.so || true
	HYPRLUA_MODULES_PATH=$(CURDIR)/runtime/modules hyprctl plugin load $(CURDIR)/build/libhyprlua.so

dev-unload:
	hyprctl plugin unload $(CURDIR)/build/libhyprlua.so

dev-reload: dev-unload dev-load

test: ## Run Lua unit tests
	cd tests && lua5.4 run_all_tests.lua -v

BLOG_DIR ?= ../blog-cacarico

docs: docs-cpp docs-lua

docs-cpp:
	doxygen Doxyfile

docs-lua:
	ldoc .

format: format-cpp lint-lua

format-cpp:
	@find src/ -name "*.cpp" -o -name "*.hpp" | xargs clang-format -i

lint: lint-lua-chec

lint-lua:
	@find . -name "*.lua" -not -path "./tests/lib/*" -type f -exec stylua {} \;

lint-lua-check:
	luacheck . --no-color

check: lint test

bump-version:
	@[ -n "$(V)" ] || (echo "Usage: make bump-version V=X.Y.Z"; exit 1)
	@./scripts/bump-version.sh $(V)

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: all build clean install uninstall load unload reload dev-load dev-unload dev-reload test docs docs-cpp docs-lua docs-publish format format-cpp lint lint-lua lint-lua-check check bump-version help
.DEFAULT_GOAL := help
