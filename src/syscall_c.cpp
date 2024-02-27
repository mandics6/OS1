//
// Created by os on 8/15/23.
//
#include "../h/syscall_c.hpp"
#include "../h/riscv.hpp"

void* mem_alloc(size_t size){
    Riscv::w_a1(size);
    Riscv::w_a0(0x01);
    __asm__ volatile ("ecall");

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    return (void*)a0;
}

int mem_free(void* ptr){
    Riscv::w_a1((uint64)ptr);
    Riscv::w_a0(0x02);
    __asm__ volatile ("ecall");

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    return a0;
}

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg){
    void* stack;
    if(start_routine == nullptr) stack = nullptr;
    else {
        stack = mem_alloc(DEFAULT_STACK_SIZE * sizeof(uint64));
        if(stack == nullptr) return -1;
    }

    Riscv::w_a7((uint64)stack);
    Riscv::w_a6((uint64)arg);           //ne koristi a3 i a4, ni a5 - CPU ih koristi...
    Riscv::w_a2((uint64)start_routine);
    Riscv::w_a1((uint64)handle);
    Riscv::w_a0(0x11);
    __asm__ volatile ("ecall");

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r" (a0));
    return a0;
}

int _thread_create(thread_t* handle, void(*start_routine)(void*), void* arg){
    void* stack;
    if(start_routine == nullptr) stack = nullptr;
    else {
        stack = mem_alloc(DEFAULT_STACK_SIZE * sizeof(uint64));
        if(stack == nullptr) return -1;
    }

    Riscv::w_a7((uint64)stack);
    Riscv::w_a6((uint64)arg);
    Riscv::w_a2((uint64)start_routine);
    Riscv::w_a1((uint64)handle);
    Riscv::w_a0(0x16);
    __asm__ volatile ("ecall");

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r" (a0));
    return a0;
}

int thread_exit(){
    Riscv::w_a0(0x12);
    __asm__ volatile("ecall");

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    return a0;
}

void thread_dispatch(){
    Riscv::w_a0(0x13);
    __asm__ volatile("ecall");
}

void thread_join(thread_t handle){
    Riscv::w_a1((uint64)handle);
    Riscv::w_a0(0x14);
    __asm__ volatile("ecall");
}

int thread_start(thread_t handle){
    Riscv::w_a1((uint64)handle);
    Riscv::w_a0(0x15);
    __asm__ volatile ("ecall");

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    return a0;
}

void ping(thread_t handle){
    Riscv::w_a1((uint64)handle);
    Riscv::w_a0(0x17);
    __asm__ volatile ("ecall");
}

int get_thread_id(){
    Riscv::w_a0(0x50);
    __asm__ volatile ("ecall");

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    return a0;
}

int sem_open(sem_t* handle, unsigned init){
    Riscv::w_a2((uint64)init);
    Riscv::w_a1((uint64)handle);
    Riscv::w_a0(0x21);
    __asm__ volatile("ecall");

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    return a0;
}

int sem_close(sem_t handle){
    Riscv::w_a1((uint64)handle);
    Riscv::w_a0(0x22);
    __asm__ volatile("ecall");

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    return a0;
}

int sem_wait(sem_t id){
    Riscv::w_a1((uint64)id);
    Riscv::w_a0(0x23);
    __asm__ volatile("ecall");

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    return a0;
}

int sem_signal(sem_t id){
    Riscv::w_a1((uint64)id);
    Riscv::w_a0(0x24);
    __asm__ volatile("ecall");

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    return a0;
}

int time_sleep(time_t t){
    return 0;
}

char getc(){
    Riscv::w_a0(0x41);
    __asm__ volatile ("ecall");

    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    return (char)a0;
}

void putc(char c){
    Riscv::w_a1((uint64)c);
    Riscv::w_a0(0x42);
    __asm__ volatile ("ecall");
}

void changeUser() {
    Riscv::w_a0(0x25);
    __asm__ volatile("ecall");
    return;
}

