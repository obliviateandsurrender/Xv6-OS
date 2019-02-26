#include "types.h"
#include "user.h"
#define inv 32

void invert(char s[]) {
    for (int i = 0; s[i] != '\0';)
    {
        if (s[i] - 'a' >= 0 && s[i] - 'z' <= 0)
        {
            s[i] -= inv;
        }
        else if (s[i] - 'A' >= 0 && s[i] - 'Z' <= 0)
        {
            s[i] += inv;
        }
        i++;
    }
    printf(1, "%s ", s);
}

int main(int argc, char *argv[]) {
    int i = 1;
    if (argc == 1) {
        printf(2, "Usage: invertcase [STRING]...\n");
        exit();
    }
    else {
        for (; i < argc;) {
            invert(argv[i++]);
        }
        printf(1, "\n");
    }
    exit();
}
