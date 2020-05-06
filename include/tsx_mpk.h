#define _GNU_SOURCE
#include <stdlib.h>
#include <stdio.h>

#include <string.h>
#include <sys/mman.h>
#include <pthread.h>

struct __tsx_mpk__shared_memory_struct {
    void *start;
    size_t len;
    int pkey;
    pthread_mutex_t mutex_lock;
};

void exit_error(char *msg);
struct __tsx_mpk__shared_memory_struct *__tsx_mpk_unsafe__init_shared_memory_struct(size_t len);
void __tsx_mpk__set_shared_memory_struct(struct __tsx_mpk__shared_memory_struct *sms);
struct __tsx_mpk__shared_memory_struct *__tsx_mpk__get_shared_memory_struct(void *start, size_t len);
void *__tsx_mpk__read(void *start, size_t len);
int __tsx_mpk_unsafe__write(void *start, size_t len, void *data);
