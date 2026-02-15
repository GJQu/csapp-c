CC := clang
CFLAGS := -std=c11 -O0 -g3 -Wall -Wextra -Wpedantic -Werror \
          -fno-omit-frame-pointer
SAN := -fsanitize=address,undefined

SRC := $(wildcard src/*.c drills/*.c)
BIN_DIR := build

.PHONY: all clean

all: $(BIN_DIR)
	@echo "Build with: make <target> (see 'make -n' or list files)"

$(BIN_DIR):
	@mkdir -p $(BIN_DIR)

# ex: make run-drill NAME=drills/ptr_basics.c
.PHONY: run
run: $(BIN_DIR)
	@if [ -z "$(NAME)" ]; then echo "Usage: make run NAME=drills/foo.c"; exit 1; fi
	$(CC) $(CFLAGS) $(SAN) $(NAME) -o $(BIN_DIR)/a.out
	ASAN_OPTIONS=abort_on_error=1 $(BIN_DIR)/a.out

clean:
	rm -rf $(BIN_DIR)
