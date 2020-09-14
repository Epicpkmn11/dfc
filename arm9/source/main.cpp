#include <dirent.h>
#include <nds.h>
#include <slim.h>
#include <stdio.h>

int main(int argc, char **argv) {
	consoleDemoInit();

	if(!fatInitDefault()) {
		printf("fatInitDefault failed!\n");
		while(1)
			swiWaitForVBlank();
	}

	// Remove old dummy file if it exists
	if(access("sd:/hiya/dummy.bin", F_OK) == 0) {
		printf("Removing old dummy file... ");
		remove("sd:/hiya/dummy.bin");
		printf("Done!\n");
	}

	// Check the free space
	struct statvfs st;
	if(statvfs("sd:/", &st) != 0) {
		printf("statvfs failed!\n");
		while(1)
			swiWaitForVBlank();
	}

	u32 freeSpace = st.f_bsize * st.f_bfree;

	// If the free space is bigger than 2GiB (using a u32 so always 0 - 4GiB)
	if(freeSpace > (2u << 30)) {
		mkdir("sd:/hiya", 0777);
		FILE *file = fopen("sd:/hiya/dummy.bin", "wb");
		if(file) {
			// Free space - 2GB + 10MB
			printf("Making new dummy file...   ");
			fseek(file, (freeSpace - (2 << 30)) + 10000000, SEEK_SET);
			fputc('\0', file);
			fclose(file);
			printf("Done!\n");
		} else {
			printf("Failed to open file!\n");
		}
	} else {
		printf("Dummy file not needed!\n");
	}

	printf("\n\nPress START to exit\n");

	while(!(keysDown() & KEY_START)) {
		swiWaitForVBlank();
		scanKeys();
	}

	return 0;
}
