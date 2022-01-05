#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

char decChar(char a, char b);
void decText(char code[], char key[]);

int main(void) {
    char buffer[51], key[21];

    printf("Give codetext (1-50ch.) and key (1-20ch.):\n");
    if (scanf("%50s %20s", buffer, key) != 2) {
        printf("Incorrect input!\n");
        return EXIT_FAILURE;
    }

    decText(buffer, key);

    printf("Decrypted:\n%s\n", buffer);

    return EXIT_SUCCESS;
}

char decChar(char a, char b) {
    int offset;

    if (a <= 'Z' && a >= 'A') {
        offset = 'A';
        b = toupper(b);
    }
    else if (a <= 'z' && a >= 'a') {
        offset = 'a';
        b = tolower(b);
    }
    else
        return a;

    a -= offset;
    b -= offset;

    a = (a - b + 26) % 26;
    a += offset;

    return a;
}

void decText(char code[], char key[]) {
    int codelen = strlen(code);
    int keylen = strlen(key);
    int nalph = 0; // number of non alphabetic characters

    for (int i = 0; i < codelen; ++i)
        if (!isalpha(code[i]))
            ++nalph;
        else
            code[i] = decChar(code[i], key[(i - nalph) % keylen]);
}
