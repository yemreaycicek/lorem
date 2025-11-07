# Compiler and flags
CC = gcc
CFLAGS = -Wall -Werror -Wextra -std=c99 -pedantic -I$(INCLUDE_DIR)
LDFLAGS = 

# Project structure
TARGET = lorem
BIN_DIR = bin
BUILD_DIR = build
SRC_DIR = src
INCLUDE_DIR = include
MAN_DIR = man

# Installation directories (GNU standard)
PREFIX = /usr/local
EXEC_PREFIX = $(PREFIX)
BINDIR = $(EXEC_PREFIX)/bin
MANDIR = $(PREFIX)/share/man
MAN1DIR = $(MANDIR)/man1

# Installation tool
INSTALL = install
INSTALL_PROGRAM = $(INSTALL)
INSTALL_DATA = $(INSTALL) -m 644

# Source and object files
SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(SRCS))

# Target path
TARGET_PATH = $(BIN_DIR)/$(TARGET)

# Default target
all: $(TARGET_PATH)

# Link object files to create executable
$(TARGET_PATH): $(OBJS)
	@mkdir -p $(BIN_DIR)
	$(CC) $(LDFLAGS) $(OBJS) -o $(TARGET_PATH)
	@echo "Build complete: $(TARGET_PATH)"

# Compile source files to object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Install the program (requires root privileges)
install: $(TARGET_PATH)
	@echo "Installing $(TARGET) to $(DESTDIR)$(BINDIR)..."
	$(INSTALL) -d $(DESTDIR)$(BINDIR)
	$(INSTALL_PROGRAM) $(TARGET_PATH) $(DESTDIR)$(BINDIR)/$(TARGET)
	@if [ -f $(MAN_DIR)/$(TARGET).1 ]; then \
		echo "Installing man page to $(DESTDIR)$(MAN1DIR)..."; \
		$(INSTALL) -d $(DESTDIR)$(MAN1DIR); \
		$(INSTALL_DATA) $(MAN_DIR)/$(TARGET).1 $(DESTDIR)$(MAN1DIR)/$(TARGET).1; \
	fi
	@echo "Installation complete."

# Uninstall the program (requires root privileges)
uninstall:
	@echo "Uninstalling $(TARGET) from $(DESTDIR)$(BINDIR)..."
	rm -f $(DESTDIR)$(BINDIR)/$(TARGET)
	rm -f $(DESTDIR)$(MAN1DIR)/$(TARGET).1
	@echo "Uninstall complete."

# Install to local user directory (no root needed)
install-user: $(TARGET_PATH)
	@echo "Installing $(TARGET) to ~/.local/bin..."
	@mkdir -p ~/.local/bin
	$(INSTALL_PROGRAM) $(TARGET_PATH) ~/.local/bin/$(TARGET)
	@if [ -f $(MAN_DIR)/$(TARGET).1 ]; then \
		echo "Installing man page to ~/.local/share/man/man1..."; \
		mkdir -p ~/.local/share/man/man1; \
		$(INSTALL_DATA) $(MAN_DIR)/$(TARGET).1 ~/.local/share/man/man1/$(TARGET).1; \
	fi
	@echo "User installation complete. Make sure ~/.local/bin is in your PATH."

# Uninstall from local user directory
uninstall-user:
	@echo "Uninstalling $(TARGET) from ~/.local/bin..."
	rm -f ~/.local/bin/$(TARGET)
	rm -f ~/.local/share/man/man1/$(TARGET).1
	@echo "User uninstall complete."

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	rm -rf $(BUILD_DIR)/*.o
	rm -rf $(BIN_DIR)/$(TARGET)
	@echo "Clean complete."

# Remove all generated files
distclean: clean
	rm -rf $(BUILD_DIR)
	rm -rf $(BIN_DIR)
	@echo "Distribution clean complete."

# Rebuild everything
rebuild: clean all

# Show build information
info:
	@echo "Project: $(TARGET)"
	@echo "Compiler: $(CC)"
	@echo "Flags: $(CFLAGS)"
	@echo "Sources: $(SRCS)"
	@echo "Objects: $(OBJS)"
	@echo "Target: $(TARGET_PATH)"
	@echo "Install prefix: $(PREFIX)"

# Help message
help:
	@echo "Available targets:"
	@echo "  all            - Build the project (default)"
	@echo "  clean          - Remove build artifacts"
	@echo "  distclean      - Remove all generated files"
	@echo "  rebuild        - Clean and rebuild"
	@echo "  install        - Install to $(PREFIX) (requires root)"
	@echo "  uninstall      - Uninstall from $(PREFIX) (requires root)"
	@echo "  install-user   - Install to ~/.local (no root needed)"
	@echo "  uninstall-user - Uninstall from ~/.local"
	@echo "  info           - Show build information"
	@echo "  help           - Show this help message"
.PHONY: all clean distclean rebuild install uninstall install-user uninstall-user info help
