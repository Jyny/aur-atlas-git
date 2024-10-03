BINARY := atlas
VERSION_FILE := VERSION
VERSION := $(shell cat $(VERSION_FILE))
FILE := $(BINARY)-$(VERSION).tar.gz
URL := https://github.com/ariga/$(BINARY)/archive/v$(VERSION).tar.gz

.PHONY: all
all: download checksums update_pkgbuild test_makepkg update_srcinfo clean

.PHONY: download
download:
	@if [ ! -f $(FILE) ]; then \
		echo "Downloading $(FILE)..."; \
		curl -fL -o $(FILE) $(URL); \
	else \
		echo "$(FILE) already exists, skipping download."; \
	fi

.PHONY: checksums
checksums:
	$(eval NEW_SHA256SUM := $(shell sha256sum $(FILE) | awk '{ print $$1 }'))
	$(eval NEW_B2SUM := $(shell b2sum $(FILE) | awk '{ print $$1 }'))

.PHONY: update_pkgbuild
update_pkgbuild:
	@sed -i "s/^pkgver=.*/pkgver=$(VERSION)/" PKGBUILD
	@echo "Updated pkgver to $(VERSION)"
	@sed -i "s/^sha256sums=('.*')/sha256sums=('$(NEW_SHA256SUM)')/" PKGBUILD
	@echo "Updated sha256sums to $(NEW_SHA256SUM)"
	@sed -i "s/^b2sums=('.*')/b2sums=('$(NEW_B2SUM)')/" PKGBUILD
	@echo "Updated b2sums to $(NEW_B2SUM)"

.PHONY: test_makepkg
test_makepkg:
	@echo "Testing PKGBUILD..."
	@makepkg --syncdeps --cleanbuild
	@echo "PKGBUILD test completed successfully."

.PHONY: update_srcinfo
update_srcinfo:
	@makepkg --printsrcinfo > .SRCINFO
	@echo "Updated .SRCINFO file."

.PHONY: clean
clean:
	@git clean -fdx
	@echo "Cleanup complete."
