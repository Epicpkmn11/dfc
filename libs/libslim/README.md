# libslim

A revival of libELM for use with the Nintendo DS, based off modern FatFS.

libslim aims to be a lightweight drop-in compatible with libfat in the common modern use case and provides only 2 stdio devices instead of libfat

  * `fat:` for the SLOT-1 flashcart device
  * `sd:` for the TWL-mode SD card

It provides a restricted subset of libfat's API for the common use case. 

```c
/**
 * Initializes SD card in sd:/ and SLOT-1 flashcart device in fat:/ with the default
 * DISC_INTERFACE, then sets the default directory to sd:/ if available, or 
 * fat:/ otherwise, and then changes directory according to argv if setArgvMagic 
 * is true.
 * 
 * This method differs significantly from its equivalent libfat API.
 * 
 * Returns true if either sd:/ or fat:/ is successfully mounted, and false otherwise.
 */
bool fatInit(bool setArgvMagic);

/**
 * Initializes SD card in sd:/ and SLOT-1 flashcart device in fat:/ with the default
 * DISC_INTERFACE, then sets the default directory to sd:/ if available, or 
 * fat:/ otherwise, and then changes directory according to argv.
 * 
 * Returns true if either sd:/ or fat:/ is successfully mounted, and false otherwise.
 */
bool fatInitDefault(void);

/**
 * Initializes the given mount point with the provided DISC_INTERFACE
 * 
 * - `mount` must be either "sd:" or "fat:". Unlike libfat, this function does not
 * support other mount points.
 */
bool fatMountSimple(const char* mount, const DISC_INTERFACE* interface);

/**
 * Unmounts the given mount point, attempting to flush any open files.
 * 
 * Unlike libfat, this function returns true on success.
 */
bool fatUnmount(const char* mount);

/**
 * Gets the volume label of the given mount point.
 * 
 * - `mount` must be either "sd:" or "fat:". Unlike libfat, this function does not
 * support other mount points.
 */
void fatGetVolumeLabel(const char* mount, char *label);

/**
 * Gets the given FAT attributes for the file.
 */
int FAT_getAttr(const char *file);

/**
 * Sets the FAT attributes
 */
int FAT_setAttr(const char *file, uint8_t attr);
```

# Usage

libslim is not compatible with libfat.

1. In your Makefile, link against `lslim` instead of `lfat`. This must come before `lnds9`.
2. Include `<slim.h>` instead of `<fat.h>`.

# Third Party Licenses

This work is an amalgamation of works by multiple people over several years. Unless otherwise indicated, 
this work is licensed under a 3-clause BSD license as provided in LICENSE. 

Licenses of component works are provided below.

## libELM by yellowoodgoblin
```
Copyright (c) 2009-2011, yellow wood goblin
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the yellow wood goblin nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL YELLOW WOOD GOBLIN BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```

## FatFs by ChaN
```
/*----------------------------------------------------------------------------/
/  FatFs - FAT file system module  R0.14                     (C)ChaN, 2019
/-----------------------------------------------------------------------------/
/ FatFs module is a generic FAT file system module for small embedded systems.
/ This is a free software that opened for education, research and commercial
/ developments under license policy of following trems.
/
/  Copyright (C) 2019, ChaN, all right reserved.
/
/ * The FatFs module is a free software and there is NO WARRANTY.
/ * No restriction on use. You can use, modify and redistribute it for
/   personal, non-profit or commercial products UNDER YOUR RESPONSIBILITY.
/ * Redistributions of source code must retain the above copyright notice.
/
/-----------------------------------------------------------------------------/
```