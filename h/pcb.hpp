//
// Created by os on 8/14/23.
//

#ifndef PROJECT_BASE_PCB_HPP
#define PROJECT_BASE_PCB_HPP

#include "../lib/hw.h"
#include "scheduler.hpp"
#include "memoryAllocator.hpp"
#include "../lib/mem.h"
#include "printing.hpp"

// Process Control Block
class PCB
{
public:
    enum State {NEW, READY, RUNNING, BLOCKED, FINISHED};
    ~PCB(){ delete[] stack;}

    bool isFinished() const { return finished;}
    void setFinished(bool value) {
        state = FINISHED;
        finished = value;
    }
    static int getThreadID() {return running->id;}
    void incrementTime() {this->runTime++;}
    int getRunTime(){return runTime;}

    void incrementMemory(int inc){this->allocatedBlocks+=inc;}
    int getAllocatedBlocks(){return this->allocatedBlocks;}

    void* operator new(size_t size){
        if(size % MEM_BLOCK_SIZE > 0){
            size/=MEM_BLOCK_SIZE;
            ++size;
        } else {
            size/=MEM_BLOCK_SIZE;
        }
        return MemoryAllocator::mem_alloc(size);
    }
    void* operator new[](size_t size){
        if(size % MEM_BLOCK_SIZE > 0){
            size/=MEM_BLOCK_SIZE;
            ++size;
        } else {
            size/=MEM_BLOCK_SIZE;
        }
        return MemoryAllocator::mem_alloc(size);
    }
    void operator delete(void* ptr){
        MemoryAllocator::mem_free(ptr);
    }
    void operator delete[](void* ptr){
        MemoryAllocator::mem_free(ptr);
    }

    using Body = void (*)(void*);

    static PCB* createThread(Body body, void* arg, uint64* stack);
    static PCB* _createThread(Body body, void* arg, uint64* stack);
    static PCB* initialize(Body body, void* arg, uint64* stack);
    static void join(PCB* handle);

    int start();
    static int exit();
    static void dispatch();
    static PCB *running;
    static int ID;

    static bool readyToPrintA;
    static bool readyToPrintB;
    static bool readyToPrintC;
    static int timeSliceCounter;

private:
    explicit PCB(Body body, void* arg, uint64* stack) :
            body(body),
            arg(arg),
            stack(body != nullptr ? stack : nullptr),
            context({(uint64) &threadWrapper,
                     stack != nullptr ? (uint64) &stack[STACK_SIZE] : 0
                    }),
            finished(false)
    {
        id = ID++;
        allocatedBlocks = 0;
        runTime = 0;
        state = NEW;
        if(body == nullptr)
            isMainThread = true;
        else
            isMainThread = false;
    }

    struct Context
    {
        uint64 ra;
        uint64 sp;
    };

    Body body;
    void* arg;
    uint64 *stack;
    Context context;
    State state;
    bool finished;
    bool isMainThread;
    int id;
    int runTime;
    int allocatedBlocks;

    friend class Riscv;
    friend class Sem;

    static void threadWrapper();
    static void contextSwitch(Context *oldContext, Context *runningContext);

    static uint64 constexpr STACK_SIZE = 1024;
};

#endif //PROJECT_BASE_PCB_HPP
