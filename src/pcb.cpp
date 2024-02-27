//
// Created by os on 8/15/23.
//

#include "../h/pcb.hpp"
#include "../h/riscv.hpp"
#include "../h/syscall_c.hpp"
#include "../h/printing.hpp"
#include "../h/syscall_cpp.hpp"

PCB* PCB::running = nullptr;
int PCB::ID = 0;

bool PCB::readyToPrintA = false;
bool PCB::readyToPrintB = false;
bool PCB::readyToPrintC = false;
int PCB::timeSliceCounter = 0;

PCB* PCB::createThread(Body body, void* arg, uint64* stack) {
    PCB *pcb = initialize(body, arg, stack);
    pcb->start();
    return pcb;
}

PCB* PCB::_createThread(Body body, void* arg, uint64* stack){
    PCB* pcb = initialize(body, arg, stack);
    return pcb;
}

PCB* PCB::initialize(Body body, void* arg, uint64* stack){
    return new PCB(body, arg, stack);
}

void PCB::dispatch()
{
    PCB *old = running;
    if (!old->isFinished() && old->state != BLOCKED) {
        old->state = READY;
        Scheduler::put(old);
    }
    running = Scheduler::get();
    running->state = RUNNING;

    if (PCB::running->isMainThread) {
        Riscv::ms_sstatus(Riscv::SSTATUS_SPP);
    } else {
        Riscv::mc_sstatus(Riscv::SSTATUS_SPP);
    }

    PCB::contextSwitch(&old->context, &running->context);
}

int PCB::exit() {
    if(running->state == RUNNING){
        running->setFinished(true);
        running->state = FINISHED;
        if(Thread::cntWaiting > 0){
            Thread::cntWaiting--;
            Thread::cntThreads++;
            PCB* pcb = Thread::waiting.removeFirst();
            printString("Odblokirana nit!\n");
            pcb->start();
        } else {
            Thread::cntThreads--;
        }
        dispatch();
        return 0;
    }
    return -1;
}

void PCB::join(PCB* handle){
    while(!handle->isFinished()) {
        dispatch();
    }
}

int PCB::start(){
    state = READY;
    if(!isMainThread){
        Scheduler::put(this);
    }
    return 0;
}

void PCB::threadWrapper()
{
    Riscv::popSppSpie();
    running->body(running->arg);
    running->setFinished(true);
    running->state = FINISHED;
    thread_dispatch();
}