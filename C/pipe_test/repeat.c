#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv) {
        char input;
	int buffer = 255;

	while((input = getchar()) != EOF) {
		putchar(input);
	}
	
	return 0;
}
