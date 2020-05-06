#include "tsx_mpk.h"

void exit_error(char *msg) {
    perror(msg);
    exit(EXIT_FAILURE);
}

// TODO: remove
struct __tsx_mpk__shared_memory_struct *_sms;

struct __tsx_mpk__shared_memory_struct *__tsx_mpk_unsafe__init_shared_memory_struct(size_t len) {
    void *mem = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (mem == MAP_FAILED) exit_error("mmap");

    int pkey = pkey_alloc(0, PKEY_DISABLE_WRITE);
    if (pkey == -1) exit_error("pkey_alloc");

    int res = pkey_mprotect(mem, len, PROT_READ | PROT_WRITE, pkey);
    if (res == -1) exit_error("pkey_mprotect");

    struct __tsx_mpk__shared_memory_struct *sms = (struct __tsx_mpk__shared_memory_struct *)
        malloc(sizeof(struct __tsx_mpk__shared_memory_struct));
    sms->start = mem;
    sms->len = len;
    sms->pkey = pkey;

    return sms;
}

// TODO: remove
void __tsx_mpk__set_shared_memory_struct(struct __tsx_mpk__shared_memory_struct *sms) {
    _sms = sms;
}

struct __tsx_mpk__shared_memory_struct *__tsx_mpk__get_shared_memory_struct(void *start, size_t len) {
    // get shared_memory_struct containing virtual address start if len is in bounds

    // TODO: fix
    return _sms;
}

void *__tsx_mpk__read(void *start, size_t len) {
    struct __tsx_mpk__shared_memory_struct *sms = __tsx_mpk__get_shared_memory_struct(start, len);

    pthread_mutex_t *mutex_lock = &(sms->mutex_lock);

    void *value = (void *)malloc(len);
    pthread_mutex_lock(mutex_lock);
    memcpy(value, start, len);
    pthread_mutex_unlock(mutex_lock);
    return value;
}

int __tsx_mpk_unsafe__write(void *start, size_t len, void *data) {
    struct __tsx_mpk__shared_memory_struct *sms = __tsx_mpk__get_shared_memory_struct(start, len);

    pthread_mutex_t *mutex_lock = &(sms->mutex_lock);
    int pkey = sms->pkey;

    pthread_mutex_lock(mutex_lock);
    pkey_set(pkey, 0);
    memcpy(start, data, len);
    pkey_set(pkey, PKEY_DISABLE_WRITE);
    pthread_mutex_unlock(mutex_lock);
    return 0;
}

void __tsx_mpk_unsafe__do_critical_section(void *start, size_t len, void (*f)(void *, void *), void *data) {
    struct __tsx_mpk__shared_memory_struct *sms = __tsx_mpk__get_shared_memory_struct(start, len);
    pthread_mutex_t *mutex_lock = &(sms->mutex_lock);
    int pkey = sms->pkey;

    pthread_mutex_lock(mutex_lock);
    pkey_set(pkey, PKEY_ENABLE_WRITE);
    (*f)(sms->start, data);
    pkey_set(pkey, PKEY_DISABLE_WRITE);
    pthread_mutex_unlock(mutex_lock);
}