#
# This file is part of the Rufus project.
#
# Copyright (c) 2011 Pete Batard <pbatard@akeo.ie>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of
# the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/>.
#

OBJECTS   = fat12.o fat16.o fat32.o br.o file.o msdos.o format.o stdio.o stdlg.o rufus.o  
TARGET    = rufus

CC        = gcc
RC        = windres
STRIP     = strip
CFLAGS    = -DWINVER=0x501 -D_WIN32_IE=0x501 -I./inc -std=gnu99 -Wall -Wundef -Wunused -Wstrict-prototypes -Werror-implicit-function-declaration -Wno-pointer-sign -Wshadow
LDFLAGS   = -O2 -Wall -Wl,--subsystem,windows
LIBS      = -lsetupapi -lole32 -lgdi32

.PHONY: all clean 

all: $(TARGET)

$(TARGET): $(OBJECTS) $(TARGET)_rc.o
	@echo "[CCLD]  $@"
	@$(CC) $(LDFLAGS) -o $@ $(OBJECTS) $(TARGET)_rc.o $(LIBS)
	@$(STRIP) $(TARGET).exe

%.o: %.c
	@echo "[CC]    $@"
	@$(CC) -c -o $*.o $(CFLAGS) $<

%_rc.o: %.rc
	@echo "[RC]    $@"
	@$(RC) -i $< -o $@

clean:
	rm -f *.exe *.o
