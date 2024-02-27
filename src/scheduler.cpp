//
// Created by os on 8/15/23.
//

#include "../h/scheduler.hpp"

List<PCB> Scheduler::readyCoroutineQueue;

PCB *Scheduler::get()
{
    return readyCoroutineQueue.removeFirst();
}

void Scheduler::put(PCB *pcb)
{
    readyCoroutineQueue.addLast(pcb);
}