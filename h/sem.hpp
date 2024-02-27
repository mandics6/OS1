//
// Created by os on 8/30/23.
//

#ifndef PROJECT_BASE_SEM_HPP
#define PROJECT_BASE_SEM_HPP

#include "../h/list.hpp"
#include "../h/syscall_c.hpp"
#include "../h/pcb.hpp"

class Sem{
private:
    int value;
    List<PCB> blocked;
    bool finished;

    void* operator new(size_t size){
        //return __mem_alloc(size);
        if(size % MEM_BLOCK_SIZE > 0){
            size/=MEM_BLOCK_SIZE;
            ++size;
        } else {
            size/=MEM_BLOCK_SIZE;
        }
        return MemoryAllocator::mem_alloc(size);
    }
    void* operator new[](size_t size){
        //return __mem_alloc(size);
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

    friend class Riscv;
public:
    Sem(unsigned  value = 1);
    ~Sem();

    int wait();
    int signal();
};

#endif //PROJECT_BASE_SEM_HPP
