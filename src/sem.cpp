//
// Created by os on 8/30/23.
//
#include "../h/sem.hpp"

Sem::Sem(unsigned  value){
    this->value = value;
    this->finished = false;
}

Sem::~Sem(){
    this->finished = true;
    while(blocked.peekFirst()){
        PCB* handle = blocked.removeFirst();
        handle->state = PCB::READY;
        Scheduler::put(handle);
    }
}

int Sem::wait(){
    if(finished) return -1;
    if(--value < 0) {
        PCB::running->state = PCB::BLOCKED;
        this->blocked.addLast(PCB::running);
        PCB::dispatch();
        //thread_dispatch();
    }
    if (!finished) return 0;
    return -1;
}

int Sem::signal(){
    if(finished) return -1;
    if(++value <= 0){
        PCB* pcb = blocked.removeFirst();
        pcb->state = PCB::READY;
        Scheduler::put(pcb);
    }
    return 0;
}