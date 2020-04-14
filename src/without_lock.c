#include <tsx_mpk.h>

int main() {
    struct __tsx_mpk__shared_memory_struct *sms = __tsx_mpk_unsafe__init_shared_memory_struct(4096);
    __tsx_mpk__set_shared_memory_struct(sms);

    int data = 0xDEADBEEF;
    size_t len = sizeof(data);
    
    // attempt to access without proper lock semantics
    pkey_set(sms->pkey, 0);
    memcpy(sms->start, &data, len);

    int *res = (int *)__tsx_mpk__read(sms->start, len);
    printf("Value of shared memory: 0x%x\n", *res);

    return 0;
}