//
// Created by os on 6/20/23.
//

#ifndef PROJECT_BASE_MEMORYALLOCATOR_HPP
#define PROJECT_BASE_MEMORYALLOCATOR_HPP

#include "../lib/hw.h"

struct MemBlock {
    size_t size;
    MemBlock* next;
};

class MemoryAllocator {
public:
    static void* mem_alloc(size_t size);
    static int mem_free(void* addr);

    static void tryToJoin();
    static void init();
    static bool init_memory;

    static MemoryAllocator& getInstance();
private:
    static MemBlock* freeMemHead;
    static MemBlock* allocMemHead;
};

#endif //PROJECT_BASE_MEMORYALLOCATOR_HPP
