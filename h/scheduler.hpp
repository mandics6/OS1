//
// Created by os on 8/14/23.
//

#ifndef PROJECT_BASE_SCHEDULER_HPP
#define PROJECT_BASE_SCHEDULER_HPP

#include "list.hpp"

class PCB;

class Scheduler
{
private:
    static List<PCB> readyCoroutineQueue;
public:
    static PCB *get();
    static void put(PCB *pcb);
};

#endif //PROJECT_BASE_SCHEDULER_HPP
