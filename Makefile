AS := nasm
LD := ld

OBJ_DIR := obj
OUT_DIR := out
SRC_DIR := srcs

ARCH := elf64

.PHONY: all re clean directories first_prog hello

# the use of the `all` directive in this project is unnecessary.
all: directories first_prog hello
re: clean all

# The + symbol is used with the -exec flag in the find command to enable
# operations on multiple files at once.
clean:
	@rm -rf $(OBJ_DIR)
	@rm -rf $(OUT_DIR)
#	@find $(OBJ_DIR) -name '*.o' -exec rm -f {} +
#	@find $(OUT_DIR) -type f -exec rm -f {} +

directories:
	@mkdir -p $(OBJ_DIR) $(OUT_DIR)

first_prog: directories
	$(AS) -f $(ARCH) $(SRC_DIR)/$@.asm -o $(OBJ_DIR)/$@.o
	$(LD) $(OBJ_DIR)/$@.o -o $(OUT_DIR)/$@

hello: directories
	$(AS) -f $(ARCH) $(SRC_DIR)/$@.asm -o $(OBJ_DIR)/$@.o
	$(LD) $(OBJ_DIR)/$@.o -o $(OUT_DIR)/$@
