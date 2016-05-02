#include <cpuid.h>
#include <stdlib.h>
#include <stdio.h>

void printbits(int input) {
    printf("val: ");
    for (int i = 31; i >= 0; i--) {
        printf(" %d ", (input >> i) & 0x1);
    }
    printf("\npos: ");
    for (int i = 31; i >= 0; i--) {
        printf("%02d ", i);
    }
    printf("\n");
}

int main() {
    unsigned int eax, ebx, ecx, edx, eax_in, ecx_in;
    // see for info:
    // https://en.wikipedia.org/wiki/CPUID#EAX.3D0:_Highest_Function_Parameter

    // eax_in and eax are different because of 
    // input operand handling. see:
    // 6.44.2.5 Input Operands
    // in: https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html

    eax_in = 0x7;
    ecx_in = 0;
    
    printf("eax input: %x\n", eax_in);
    printf("ecx input: %x\n", ecx_in);

    eax = 0;
    ecx = 0;
    ebx = 0;
    edx = 0;

    __cpuid_count(eax_in, ecx_in, eax, ebx, ecx, edx);

    printf("eax:\n");
    printbits(eax);
    printf("ebx:\n");
    printbits(ebx);
    printf("ecx:\n");
    printbits(ebx);
    printf("edx:\n");
    printbits(ebx);
}
