#define _GNU_SOURCE
#include <unistd.h>
#include <sys/syscall.h>
#include <stdio.h>
#include <sys/mman.h>
#include <assert.h>

#include <pthread.h>

struct pkeys_struct {
        int pkey1;
        int pkey2;
};

void *thread_func(void *arg) {
        void *ptr;

        int val;

        struct pkeys_struct pkeys;

        pkeys = *(struct pkeys_struct *)arg;
        int pkey1 = pkeys.pkey1;
        int pkey2 = pkeys.pkey2;

        val = pkey_get(pkey1);
        printf("[Child Thread] pkey %d: Value %d\n", pkey1, val);

        val = pkey_get(pkey2);
        printf("[Child Thread] pkey %d: Value %d\n", pkey2, val);

        int res = pkey_set(pkey2, 0);
        assert(res == 0);
        val = pkey_get(pkey2);
        printf("[Child Thread] Set pkey %d: Value: %d\n", pkey2, val);

        return ptr;
}

void test_PKRU_inheritance() {
        int val;

        char *mem = (char *)mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        assert(mem != MAP_FAILED);

        int pkey1 = pkey_alloc(0, 0);
        assert(pkey1 != -1);

        val = pkey_get(pkey1);
        printf("[Main Thread] Allocated key: %d, Value %d\n", pkey1, val);

        int pkey2 = pkey_alloc(0, PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE);
        assert(pkey2 != -1);

        val = pkey_get(pkey2);
        printf("[Main Thread] Allocated key: %d, Value %d\n", pkey2, val);

        struct pkeys_struct pkeys;
        pkeys.pkey1 = pkey1;
        pkeys.pkey2 = pkey2;

        printf("[Main Thread] --- Entering pthread ---\n");

        pthread_t tid;
        int res = pthread_create(&tid, NULL, &thread_func, &pkeys);
        assert(res == 0);

        pthread_join(tid, NULL);

        printf("[Main Thread] --- Returned from pthread ---\n");

        val = pkey_get(pkey1);
        printf("[Main Thread] pkey %d: Value %d\n", pkey1, val);

        val = pkey_get(pkey2);
        printf("[Main Thread] pkey %d: Value %d\n", pkey2, val);
}

int main() {
        test_PKRU_inheritance();
        return 0;
}
