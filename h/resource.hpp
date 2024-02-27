//
// Created by os on 2/5/24.
//

#ifndef PROJECT_BASE_SA_KOMENTARIMA_I_TESTOVIMA_RESOURCE_HPP
#define PROJECT_BASE_SA_KOMENTARIMA_I_TESTOVIMA_RESOURCE_HPP

#include "../h/syscall_cpp.hpp"
#include "list.hpp"
#include "pcb.hpp"

class Resource
{
public:
    Resource(int n);
    void take(int num);
    int give_back(int num);
private:
    int cnt;
    Semaphore *mutex, *sem;
    int waiting;
};

#endif //PROJECT_BASE_SA_KOMENTARIMA_I_TESTOVIMA_RESOURCE_HPP
