#include <stdio.h>

// Function to greet a person
void greet(char *name) {
    printf("Hello, %s\n", name);
}

int main() {
    // Intentional error: misspelled function name (gret instead of greet)
    gret("world");

    // Intentional warning: unused variable
    int unused_variable = 42;

    // Intentional warning: division by zero
    int result = 10 / 0;

    return 0;
}
