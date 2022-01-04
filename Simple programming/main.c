#include <stdio.h>
#include <stdlib.h>

// run this program, pass it path to data, it will output result

int main(int argc, char *argv[]) {
    char c;
    int count, curr0, curr1;
    count = curr0 = curr1 = 0;

    // path not passed
    if (argc != 2)
        return EXIT_FAILURE;

    FILE *f = fopen(argv[1], "r");

    // read file
    while ((c = getc(f)) != EOF) {
        if (c == '\n') {
            // clear counters on new line
            if (curr0 % 3 == 0 || curr1 % 2 == 0)
                ++count;
            curr0 = curr1 = 0;
        }
        else if (c == '1') // counting 1's
            ++curr1;
        else if (c == '0') // counting 0's
            ++curr0;
    }

    fclose(f);

    printf("Number of lines in %s satisfying the property: %d", argv[1], count);
    return EXIT_SUCCESS;
}