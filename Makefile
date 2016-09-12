# Makefile
#
# ============================================================================
# Copyright (c) Soochow University. 2013
#
# Use of this software is controlled by the terms and conditions found in the
# license agreement under which this software has been supplied or provided.
# ============================================================================

# Comment this out if you want to see full compiler and linker output.
VERBOSE = @
#
TARGET = $(notdir $(CURDIR))

CROSS_PREFIX = arm-none-linux-gnueabi-

RM = rm

C_FLAGS += -g -O2 -Wall -fPIC -DPIC -I$(KERNEL_HDR_DIR) 

LD_FLAGS += -shared -Wl,-lpthread

COMPILE.c = $(VERBOSE) $(CROSS_PREFIX)gcc $(C_FLAGS) $(CPP_FLAGS) -c
LINK.c = $(VERBOSE) $(CROSS_PREFIX)gcc $(LD_FLAGS)

SOURCES = $(wildcard *.c) $(wildcard ../*.c)
HEADERS = $(wildcard *.h) $(wildcard ../*.h)

OBJFILES = $(SOURCES:%.c=%.o)

.PHONY: clean

all:	$(TARGET)

$(TARGET):	$(OBJFILES)
	@echo
	@echo Linking $@ from $^..
	$(LINK.c) -o $@ $^

$(OBJFILES):	%.o: %.c $(HEADERS)
	@echo Compiling $@ from $<..
	$(COMPILE.c) -o $@ $<

clean:
	@echo Removing generated files..
	$(VERBOSE) -$(RM) -rf $(OBJFILES) $(TARGET) *~ *.d .dep
