#define _GNU_SOURCE

#include <tsx_mpk.h>

#include<stdlib.h>
#include <unistd.h>
#include<stdio.h>
#include <sys/mman.h>

#include <pthread.h>

#define PKRU_ENABLE_WRITE 0x0
#define PKRU_DISABLE_WRITE 0x2

void *allocate_shared_memory(size_t len) {
    struct __tsx_mpk__shared_memory_struct *sms = __tsx_mpk_unsafe__init_shared_memory_struct(len);
    __tsx_mpk__set_shared_memory_struct(sms);
    return sms->start;
}

void do_critical_section(void *start, void (*critical_section)(void *, void *), void *data) {
    __tsx_mpk_unsafe__do_critical_section(start, -1, critical_section, data);
}

void get_balance(void *mem, void *data) {
    int balance = *(int *)mem;
    *(int *)data = balance;
}

void set_balance(void *mem, void *data) {
    int amount = *(int *)data;
    *(int *)mem = amount;
}

void withdraw(void *mem, void *data) {
    int balance = *(int *)mem;
    int amount = *(int *)data;
    if (balance >= amount) {
        *(int *)mem = balance - amount;
    }
}

void withdraw_sleep(void *mem, void *data) {
    int balance = *(int *)mem;
    int amount = *(int *)data;
    sleep(1);
    if (balance >= amount) {
        *(int *)mem = balance - amount;
    }    
}

void *thread_1(void *args) {
    // thread_1 follows the proper lock semantics
    void *mem = args;
    int withdraw_amount = 50;

    // acquire_lock()
    // PKRU_ENABLE_WRITE
    do_critical_section(mem, &withdraw_sleep, &withdraw_amount);
    // PKRU_DISABLE_WRITE
    // release_lock()

    return NULL;
}

void *thread_2(void *args) {
    // thread_2 ** DOES NOT ** follow the proper lock semantics
    void *mem = args;
    int withdraw_amount = 100;

    pkey_set(1, PKRU_ENABLE_WRITE); // PKRU_ENABLE_WRITE
    withdraw(mem, &withdraw_amount);
    pkey_set(1, PKRU_DISABLE_WRITE); // PKRU_DISABLE_WRITE

    return NULL;
}

int main() {
    size_t len = 4096;
    // allocate shared memory to hold account balance
    void *mem = allocate_shared_memory(len);

    // initialize account balance
    int initial_balance = 100;
    do_critical_section(mem, &set_balance, &initial_balance);

    // create two threads which withdraw from the account
    pthread_t thread_id[2];
    pthread_create(&thread_id[0], NULL, thread_1, mem);
    pthread_create(&thread_id[1], NULL, thread_2, mem);

    // wait for threads to finish
    pthread_join(thread_id[0], NULL);
    pthread_join(thread_id[1], NULL);

    // get final balance
    int final_balance;
    do_critical_section(mem, &get_balance, &final_balance);

    printf("The balance is: %d\n", final_balance);
    
    return 0;
}