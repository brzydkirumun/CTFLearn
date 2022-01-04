#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    char c;
    int count, curr0, curr1;
    count = curr0 = curr1 = 0;

    if (argc != 2)
        return EXIT_FAILURE;

    FILE *f = fopen(argv[1], "r");

    while ((c = getc(f)) != EOF) {
        if (c == '\n') {
            if (curr0 % 3 == 0 || curr1 % 2 == 0)
                ++count;
            curr0 = curr1 = 0;
        }
        else if (c == '1')
            ++curr1;
        else if (c == '0')
            ++curr0;
    }
    fclose(f);

    printf("Number of lines in %s satisfying the property: %d", argv[1], count);
    return EXIT_SUCCESS;
}