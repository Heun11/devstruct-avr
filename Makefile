# basic info about AVR board
MCU = atmega8
F_CPU = 1000000UL   # default internal clock (1 MHz)
PROGRAMMER = usbasp # change to your programmer (usbasp, avrisp, ...)
PORT = usb          # or /dev/ttyUSB0 for serial programmers
BAUD = 19200

TARGET = main
BUILDDIR = ./build
SRCDIR = ./source
SRC := $(wildcard $(SRCDIR)/*.c)
OBJ := $(patsubst $(SRCDIR)/%.c,$(BUILDDIR)/%.o,$(SRC))

CC = avr-gcc
OBJCOPY = avr-objcopy
CFLAGS = -Wall -g -I$(SRCDIR) -DF_CPU=$(F_CPU) -mmcu=$(MCU) -Os 

# Ensure build directory exists
$(shell mkdir -p $(BUILDDIR))

all: $(BUILDDIR)/$(TARGET).hex
	@echo "\033[1;33m ~> Compiling to .hex file\033[0m"

# Compile object files into build folder
$(BUILDDIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# Link all object files into ELF in build folder
$(BUILDDIR)/$(TARGET).elf: $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

# Convert ELF to HEX in build folder
$(BUILDDIR)/$(TARGET).hex: $(BUILDDIR)/$(TARGET).elf
	$(OBJCOPY) -O ihex -R .eeprom $< $@

# Flash from build folder
flash: $(BUILDDIR)/$(TARGET).hex
	avrdude -c $(PROGRAMMER) -p $(MCU) -P $(PORT) -b $(BAUD) -U flash:w:$<

clean:
	@echo "\033[1;31m ~> Cleaning build files\033[0m"
	-rm -rf $(BUILDDIR)/*

git: clean
	@echo "\033[1;33m ~> Adding to git\033[0m"
	git add .
	@echo "\033[1;32m ~> Making commit to git\033[0m"
	git commit
	@echo "\033[1;34m ~> Pushing to github\033[0m"
	git push
