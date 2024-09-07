AS := nasm
LD := ld
AR := ar

OBJ_DIR := obj
OUT_DIR := out
SRC_DIR := srcs
LIB_DIR := lib

ARCH := -f elf64
CLIBLOC = /usr/lib/ld-linux-x86-64.so.2

.PHONY: all re clean directories first_prog hello

# the use of the `all` directive in this project is unnecessary.
all: directories first_prog hello two_sum libstatic
re: clean all

# The + symbol is used with the -exec flag in the find command to enable
# operations on multiple files at once.
clean:
	@rm -rf $(OBJ_DIR)
	@rm -rf $(OUT_DIR)
	@rm -rf $(LIB_DIR)
#	@find $(OBJ_DIR) -name '*.o' -exec rm -f {} +
#	@find $(OUT_DIR) -type f -exec rm -f {} +

directories:
	@mkdir -p $(OBJ_DIR) $(OUT_DIR) $(LIB_DIR)

first_prog: directories
	@$(AS) $(ARCH) $(SRC_DIR)/$@.asm -o $(OBJ_DIR)/$@.o
	@$(LD) $(OBJ_DIR)/$@.o -o $(OUT_DIR)/$@

hello: directories
	$(AS) $(ARCH) $(SRC_DIR)/$@.asm -o $(OBJ_DIR)/$@.o
	$(LD) $(OBJ_DIR)/$@.o -o $(OUT_DIR)/$@

# linking with lib C (which is a dynamic library)
two_sum: directories
	$(AS) $(ARCH) $(SRC_DIR)/$@.asm -o $(OBJ_DIR)/$@.o
	$(LD) $(OBJ_DIR)/$@.o -lc -dynamic-linker $(CLIBLOC) -o $(OUT_DIR)/$@

libstatic: directories
	$(AS) $(ARCH) $(SRC_DIR)/staticlib/$@.asm -o $(OBJ_DIR)/$@.o
	$(AR) rcs $(LIB_DIR)/$@.a $(OBJ_DIR)/$@.o

# -e : entry point of program
linkstatic: libstatic
	$(AS) $(ARCH) $(SRC_DIR)/$@.asm -o $(OBJ_DIR)/$@.o
	$(LD) $(OBJ_DIR)/$@.o -o $(OUT_DIR)/$@ -L$(LIB_DIR) -lstatic -e _start
