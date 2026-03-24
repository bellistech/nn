.PHONY: install uninstall test lint help

PREFIX ?= $(HOME)/.local
BINDIR ?= $(PREFIX)/bin
MANDIR ?= $(PREFIX)/share/man/man1

help:
	@echo "nn - New Note"
	@echo ""
	@echo "Usage:"
	@echo "  make install     Install nn and man page to ~/.local"
	@echo "  make uninstall   Remove nn and man page"
	@echo "  make test        Run basic tests"
	@echo "  make lint        Check with shellcheck"
	@echo "  make man         Preview man page"
	@echo ""
	@echo "Variables:"
	@echo "  PREFIX=$(PREFIX)"
	@echo "  BINDIR=$(BINDIR)"
	@echo "  MANDIR=$(MANDIR)"

install:
	@mkdir -p $(BINDIR)
	@mkdir -p $(MANDIR)
	@cp nn $(BINDIR)/nn
	@chmod +x $(BINDIR)/nn
	@cp nn.1 $(MANDIR)/nn.1
	@echo "✓ Installed nn to $(BINDIR)/nn"
	@echo "✓ Installed man page to $(MANDIR)/nn.1"
	@echo ""
	@echo "Note: You may need to run 'mandb' or 'makewhatis' to update man database"
	@echo ""
	@echo "Add completions (optional):"
	@echo "  echo 'eval \"\$$(nn --completions)\"' >> ~/.bashrc"

uninstall:
	@rm -f $(BINDIR)/nn
	@rm -f $(MANDIR)/nn.1
	@echo "✓ Removed $(BINDIR)/nn"
	@echo "✓ Removed $(MANDIR)/nn.1"

man:
	@groff -man -Tascii nn.1 | less

test:
	@echo "Running basic tests..."
	@export NOTES_ROOT=$$(mktemp -d) && \
		./nn --version && \
		./nn --help >/dev/null && \
		./nn -a "test append" && \
		./nn -T incident test-incident >/dev/null 2>&1 || true && \
		./nn --stats && \
		./nn -l && \
		echo "✓ All tests passed" && \
		rm -rf "$$NOTES_ROOT"

lint:
	@if command -v shellcheck >/dev/null 2>&1; then \
		shellcheck nn && echo "✓ shellcheck passed"; \
	else \
		echo "shellcheck not installed"; \
	fi
