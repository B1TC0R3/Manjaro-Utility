#include <stdio.h>
#include <stdlib.h>

// kind of handles pipes i guess?
// only got it to work with en echo pipe so far, 
// find does not work.
int main(int argc, char** argv) {
        char input;
	int buffer = 255;

	while((input = getchar()) != EOF) {
		putchar(input);
	}
	
	return 0;
}
