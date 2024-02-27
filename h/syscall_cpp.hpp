//
// Created by os on 7/6/23.
//

#ifndef PROJECT_BASE_SYSCALL_CPP_HPP
#define PROJECT_BASE_SYSCALL_CPP_HPP

#include "syscall_c.hpp"
#include "list.hpp"

void* operator new(size_t size);
void* operator new[](size_t size);

void operator delete(void* ptr);
void operator delete[](void* ptr);

class Thread {
public:
    Thread(void (*body)(void*), void* arg);
    virtual ~Thread();

    int start();
    void join();
    void pingThread(){ ping(this->myHandle);}

    static void setRunning(Thread *thread);
    static void dispatch();
    static int sleep (time_t);
    static void SetMaximumThreads(int num_of_threads = 5);

    static int maxThreads;
    static int cntThreads;
    static List<PCB> waiting;
    static int cntWaiting;
protected:
    Thread();
    virtual void run(){}

private:
    thread_t myHandle;
    void (*body)(void*);
    void* arg;
    static void startWrapper(void* handle);
    //friend class PCB;
};

class Semaphore {
public:
    Semaphore(unsigned init = 1);
    virtual ~Semaphore();

    int wait();
    int signal();
private:
    sem_t myHandle;
};

class Console {
public:
    static char getc();
    static void putc(char c);
};

#endif //PROJECT_BASE_SYSCALL_CPP_HPP
