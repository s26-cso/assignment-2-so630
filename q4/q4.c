#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dlfcn.h>

typedef int (*fptr)(int, int);

int main()
{
    char op[10];
    int a,b;

    while (scanf("%s %d %d", op, &a, &b) == 3)
    {
        char libname[20];
        sprintf(libname, "./lib%s.so", op);

        void* handle = dlopen(libname, RTLD_LAZY);
        if (!handle) {
            fprintf(stderr, "Error loading %s\n", libname);
            continue;
        }

        fptr func = (fptr)dlsym(handle, op);
        if (!func) {
            fprintf(stderr, "Error finding function %s\n%s\n", op, dlerror());
            dlclose(handle);
            continue;
        }

        int result = func(a, b);
        printf("%d\n", result);

        dlclose(handle);
    }

    return 0;
}