#---------------------------------------------------------------------------------
.SUFFIXES:
#---------------------------------------------------------------------------------
ifeq ($(strip $(DEVKITARM)),)
$(error "Please set DEVKITARM in your environment. export DEVKITARM=<path to>devkitARM")
endif

export TARGET	:=	dfc
export TOPDIR	:=	$(CURDIR)

# specify a directory which contains the nitro filesystem
# this is relative to the Makefile
NITRO_FILES	:=

# These set the information text in the nds file
GAME_TITLE		:= Dummy File Creator
GAME_SUBTITLE1	:= Pk11

GAME_ICON		:= icon.bmp

include $(DEVKITARM)/ds_rules

.PHONY: checkarm9 clean libslim

#---------------------------------------------------------------------------------
# main targets
#---------------------------------------------------------------------------------
all: libslim checkarm9 $(TARGET).nds

#---------------------------------------------------------------------------------
checkarm9:
	$(MAKE) -C arm9

#---------------------------------------------------------------------------------
$(TARGET).nds	: $(NITRO_FILES) arm9/$(TARGET).elf
	ndstool	-c $(TARGET).nds -9 arm9/$(TARGET).elf \
			-b $(GAME_ICON) "$(GAME_TITLE);$(GAME_SUBTITLE1)" \
			$(_ADDFILES)

#---------------------------------------------------------------------------------
arm9/$(TARGET).elf:
	$(MAKE) -C arm9

#---------------------------------------------------------------------------------
clean:
	$(MAKE) -C arm9 clean
	$(MAKE) -C libs/libslim/libslim clean
	rm -f $(TARGET).nds

libslim:
	$(MAKE) -C libs/libslim/libslim

cppcheck:
	$(MAKE) -C arm9 cppcheck

format:
	$(MAKE) -C arm9 format
