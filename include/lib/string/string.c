#include "../string.h"

u32 strlen(s8 *str) {
    // Iterate through null terminated string and find length
    u32 i = 0;
    while(str[i] != '\0') {
        i++;
    }
    return i;
}

s8 strcpy(s8 *str, const s8 *copy) {
    s8 *start = str;
    while((*str++ = *copy++) != '\0')
    ;
    return *(s8*)start;
}

s8 strcat(s8 *str, const s8 *add) {
    s8 *start = str;
    while(*str != '\0') {
        str++;
    }
    while((*str++ = *add++) != '\0')
    ;
    return *(s8*)start;
}

void memset(void *voidPointer, u32 item, u64 length) {
    // Fill memory
    unsigned char *pointer = (unsigned char*) voidPointer;
    while(length--) {
        *pointer++ = item;
    }
}