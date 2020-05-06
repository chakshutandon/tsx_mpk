#define _GNU_SOURCE

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <sys/mman.h>

void __tsx_mpk_unsafe__lib() {
    uint32_t pkru = 1, ecx = 0, edx = 0;

    // LEGAL
    pkey_set(2, PKEY_DISABLE_WRITE);
    // LEGAL
    pkey_free(2);
    // LEGAL
    pkey_mprotect(NULL, 4096, PROT_READ | PROT_WRITE, -1);
    // LEGAL
    pkey_mprotect(NULL, 4096, PROT_READ | PROT_WRITE, 2);
    // LEGAL
    asm volatile(".byte 0x0f,0x01,0xef"::"a"(pkru),"c"(ecx),"d"(edx));
    // LEGAL
    asm volatile(".byte 0x0f,0x01,0xef\n\t"::"a"(pkru),"c"(ecx),"d"(edx));
    // LEGAL
    asm volatile("WRPKRU");
    // LEGAL
    asm volatile("wrpkru");
}

int main() {
    uint32_t pkru = 1, ecx = 0, edx = 0;

    // ILLEGAL
    pkey_set(2, PKEY_DISABLE_WRITE);
    // ILLEGAL
    pkey_free(2);
    // LEGAL
    pkey_mprotect(NULL, 4096, PROT_READ | PROT_WRITE, -1);
    // ILLEGAL
    pkey_mprotect(NULL, 4096, PROT_READ | PROT_WRITE, 2);
    // ILLEGAL
    asm volatile(".byte 0x0f,0x01,0xef"::"a"(pkru),"c"(ecx),"d"(edx));
    // ILLEGAL
    asm volatile(".byte 0x0f,0x01,0xef\n\t"::"a"(pkru),"c"(ecx),"d"(edx));
    // ILLEGAL
    asm volatile("WRPKRU");
    // ILLEGAL
    asm volatile("wrpkru");

    return 0;
}