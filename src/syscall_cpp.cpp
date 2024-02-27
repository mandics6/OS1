//
// Created by os on 8/20/23.
//
#include "../h/syscall_cpp.hpp"
#include "../h/scheduler.hpp"
#include "../h/pcb.hpp"

int Thread::maxThreads = 0;
int Thread::cntThreads = 0;
int Thread::cntWaiting = 0;
List<PCB> Thread::waiting;

void* operator new(size_t size){
    if(size % MEM_BLOCK_SIZE > 0){
        size/=MEM_BLOCK_SIZE;
        ++size;
    } else {
        size/=MEM_BLOCK_SIZE;
    }
    return mem_alloc(size);
}

void* operator new[](size_t size){
    if(size % MEM_BLOCK_SIZE > 0){
        size/=MEM_BLOCK_SIZE;
        ++size;
    } else {
        size/=MEM_BLOCK_SIZE;
    }
    return mem_alloc(size);
}
void operator delete(void* ptr){
    mem_free(ptr);
}
void operator delete[](void* ptr){
    mem_free(ptr);
}

Thread::Thread(void (*body)(void*), void* arg){
    thread_create(&myHandle, body, arg);
}

Thread::~Thread(){
}

int Thread::start(){
    Scheduler::put((PCB*)myHandle);
    return 0;
}

void Thread::join(){
    thread_join(myHandle);
}

void Thread::dispatch(){
    thread_dispatch();
}

int Thread::sleep(time_t t){
    return time_sleep(t);
}

void Thread::setRunning(Thread *thread) {
    PCB::running = thread->myHandle;
}

Thread::Thread(){
    _thread_create(&myHandle, startWrapper, this);
}

void Thread::startWrapper(void* handle){
    ((Thread*)handle)->run();
}

void Thread::SetMaximumThreads(int num_of_threads) {
    maxThreads = num_of_threads;
}

//
// ##############################################################################
//

Semaphore::Semaphore(unsigned init){
    sem_open(&myHandle, init);
}

Semaphore::~Semaphore(){
    sem_close(myHandle);
}

int Semaphore::wait(){
    return sem_wait(myHandle);
}

int Semaphore::signal(){
    return sem_signal(myHandle);
}

//
// ##############################################################################
//

char Console::getc() {
    return ::getc();
}

void Console::putc(char c) {
    ::putc(c);
}