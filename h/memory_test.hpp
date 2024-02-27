//
// Created by os on 6/22/23.
//

#ifndef PROJECT_BASE_MEMORY_TEST_HPP
#define PROJECT_BASE_MEMORY_TEST_HPP


#include "memoryAllocator.hpp"
#include "../lib/hw.h"
#include "printing.hpp"

int memory_test() {
    //MemoryAllocator::getInstance();
    //Allocate some memory
    void* ptr1 = MemoryAllocator::getInstance().mem_alloc(100);
    printString( "ALLOCATED 100 BYTES AT ADDRESS [ptr1]: ");
    printInt((size_t)ptr1);
    printString( "\n");
    void* ptr2 = MemoryAllocator::getInstance().mem_alloc(120);
    printString( "ALLOCATED 120 BYTES AT ADDRESS [ptr2]: ");
    printInt((size_t)ptr2);
    printString( "\n");
    void* ptr3 = MemoryAllocator::getInstance().mem_alloc(48);
    printString( "ALLOCATED 48 BYTES AT ADDRESS [ptr3]: ");
    printInt((size_t)ptr3);
    printString( "\n");

    //TEST 1

    // Deallocate the first block
    MemoryAllocator::getInstance().mem_free(ptr1);
    printString( "Deallocated 100 bytes at address");
    printInt((uint64)ptr1);
    printString( "\n");

    //Allocate a smaller or equal block
    void* ptr4 = MemoryAllocator::getInstance().mem_alloc(40);
    printString( "Allocated 40 bytes at address ");
    printInt((uint64)ptr4);
    printString( "\n");
    if(ptr1==ptr4){
        printString("SUCCESS\n");
    }else{
        printString("ERROR\n");
    }

    //Deallocate that block and try inserting a bigger block that the on as a FreeMem head
    MemoryAllocator::getInstance().mem_free(ptr4);
    printString( "Deallocated 40 bytes at address ");
    printInt((uint64)ptr4);
    printString( "\n");

    void* ptr5 = MemoryAllocator::getInstance().mem_alloc(240);
    printString( "Allocated 240 bytes at address ");
    printInt((uint64)ptr5);
    printString( "\n");
    if(ptr1!=ptr5){
        printString("SUCCESS\n");
    }else{
        printString("ERROR\n");
    }

    //TEST 2

    // Deallocate the second block
//    MemoryAllocator::getInstance().mem_free(ptr2);
//    printString( "Deallocated 120 bytes at address ");
//    printInt((uint64)ptr2);
//    printString( "\n");
//
//    //Allocate a smaller or equal block
//    void* ptr4 = MemoryAllocator::getInstance().mem_alloc(40);
//    printString( "Allocated 40 bytes at address ");
//    printInt((uint64)ptr4);
//    printString( "\n");
//    if(ptr2==ptr4){
//        printString("SUCCESS\n");
//    }else{
//        printString("ERROR\n");
//    }
//
//    //Deallocate that block and try inserting a bigger block that the on as a FreeMem head
//    MemoryAllocator::getInstance().mem_free(ptr4);
//    printString( "Deallocated 40 bytes at address ");
//    printInt((uint64)ptr4);
//    printString( "\n");
//
//    void* ptr5 = MemoryAllocator::getInstance().mem_alloc(240);
//    printString( "Allocated 240 bytes at address ");
//    printInt((uint64)ptr5);
//    printString( "\n");
//    if(ptr2!=ptr5){
//        printString("SUCCESS\n");
//    }else{
//        printString("ERROR\n");
//    }

    //TEST 3

    // Deallocate the last block
//    MemoryAllocator::getInstance().mem_free(ptr3);
//    printString( "DEALLOCATED 48 BYTES AT ADDRESS [ptr3]: ");
//    printInt((uint64)ptr3);
//    printString( "\n");
//
//    //Allocate a way bigger block to see if deallocate() merges blocks correctly
//    void* ptr4 = MemoryAllocator::getInstance().mem_alloc(1100);
//    printString( "ALLOCATED 1100 BYTES AT ADDRESS [ptr4]: ");
//    printInt((uint64)ptr4);
//    printString( "\n");
//    if(ptr3==ptr4){
//        printString("SUCCESS\n");
//    }else{
//        printString("ERROR\n");
//    }
//
//
//    // Allocate memory again
//    ptr1 = MemoryAllocator::getInstance().mem_alloc(150);
//    printString( "ALLOCATED 150 BYTES AT ADDRESS [ptr1]: ");
//    printString( "\n");
//    printInt((uint64)ptr1);
//    printString( "\n");
//    ptr2 = MemoryAllocator::getInstance().mem_alloc(50);
//    printString( "ALLOCATED 50 BYTES AT ADDRESS [ptr2]: ");
//    printString( "\n");
//    printInt((uint64)ptr2);
//    printString( "\n");

    return 0;
}

#endif //PROJECT_BASE_MEMORY_TEST_HPP
