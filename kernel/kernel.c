#include "kernel.h"
#include "./cpu/bzc.idt.h"
#include <cze/print.h>

void main(void) {
    clear();
    initIDT();
}
