//
// Created by os on 6/20/23.
//

#include "../h/memoryAllocator.hpp"
#include "../h/printing.hpp"
#include "../h/pcb.hpp"

MemBlock* MemoryAllocator::freeMemHead = nullptr;
MemBlock* MemoryAllocator::allocMemHead = nullptr;
bool MemoryAllocator::init_memory = false;

MemoryAllocator& MemoryAllocator::getInstance(){
    static MemoryAllocator singleton;
    return singleton;
}

void MemoryAllocator::init(){
    freeMemHead = (MemBlock*)((char*)HEAP_START_ADDR);
    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR - sizeof(MemBlock);
    freeMemHead->next = nullptr;
    allocMemHead = nullptr;
}

void* MemoryAllocator::mem_alloc(size_t size){
    size *= MEM_BLOCK_SIZE;
    if(size <= 0) return nullptr;

    if(!init_memory){
        init_memory = true;
        init();
    }
    if(PCB::running){
        PCB::running->incrementMemory(size/MEM_BLOCK_SIZE);
    }
    MemBlock *current = freeMemHead, *prev = nullptr;
    while(current){
        if(current->size >= size){
            if(current->size == size){
                if(prev)
                    prev->next = current->next;
                else
                    freeMemHead = current->next;
            } else {
                MemBlock* freeSegment = (MemBlock*)((char*)current + size + sizeof(MemBlock));
                freeSegment->size = current->size - size - sizeof(MemBlock);
                freeSegment->next = current->next;
                current->size = size;
                if(current == freeMemHead)
                    freeMemHead = freeSegment;
                else
                    prev->next = freeSegment;
            }
            if(allocMemHead == nullptr) {
                allocMemHead = current;
                current->next = nullptr;
                return (char*)current + sizeof(MemBlock);
            }

            MemBlock *allocCurrent = allocMemHead, *prevCurrent = nullptr;
            while(allocCurrent){
                if((char*)allocCurrent > (char*)current){
                    if(prevCurrent)
                        prevCurrent->next = current;
                    else
                        allocMemHead = current;
                    current->next = allocCurrent;
                    break;
                }
                prevCurrent = allocCurrent;
                allocCurrent = allocCurrent->next;
            }
            if(allocCurrent == nullptr && prevCurrent != nullptr){
                current->next = nullptr;
                prevCurrent->next = current;
            }

            return (char*)current + sizeof(MemBlock);
        }
        prev = current;
        current = current->next;
    }
    return nullptr;
}

int MemoryAllocator::mem_free(void* addr){
    if(addr == nullptr) return -1;
    if(allocMemHead == nullptr) return -2;
    if(addr < HEAP_START_ADDR) return -3;
    if(addr > HEAP_END_ADDR) return -4;

    MemBlock *current = allocMemHead, *prev = nullptr;
    while(current){
        if((char*)current == (char*)addr - sizeof(MemBlock)){
            if(prev)
                prev->next = current->next;
            else
                allocMemHead = current->next;

            MemBlock* freeBlock = (MemBlock*)((char*)addr - sizeof(MemBlock));

            MemBlock *freeCurrent = freeMemHead, *prevCurrent = nullptr;
            if(freeCurrent == nullptr) {
                freeMemHead = freeBlock;
                freeBlock->next = nullptr;
            }
            else {
                while(freeCurrent){
                    if((char*)freeCurrent > (char*)freeBlock){
                        if(prevCurrent)
                            prevCurrent->next = freeBlock;
                        else
                            freeMemHead = freeBlock;
                        freeBlock->next = freeCurrent;
                        break;
                    }
                    prevCurrent = freeCurrent;
                    freeCurrent = freeCurrent->next;
                }
                if(freeCurrent == nullptr && prevCurrent != nullptr){
                    freeBlock->next = nullptr;
                    prevCurrent->next = freeBlock;
                }
                // try to merge blocks
                tryToJoin();
            }
            return 0;
        }
        prev = current;
        current = current->next;
    }
    return -1;
}

void MemoryAllocator::tryToJoin(){
    MemBlock* current = freeMemHead;

    while (current && current->next) {
        char* currentEndAddr = (char*)(current) + current->size + sizeof(MemBlock);
        if (currentEndAddr == (char*)(current->next)) {
            // Merge the current block with the next block
            current->size += current->next->size + sizeof(MemBlock);
            current->next = current->next->next;
        } else {
            current = current->next;
        }
    }
}