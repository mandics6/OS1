//
// Created by os on 8/14/23.
//

#include "../h/riscv.hpp"
#include "../h/pcb.hpp"
#include "../lib/console.h"
#include "../h/printing.hpp"
#include "../h/sem.hpp"

void Riscv::popSppSpie()
{
    __asm__ volatile ("csrw sepc, ra");
    __asm__ volatile ("sret");
}

void Riscv::handleSupervisorInterrupt() {
    uint64 a1 = r_a1();
    uint64 a2 = r_a2();
    uint64 a6 = r_a6();
    uint64 a7 = r_a7();
    long a0 = r_a0();
    uint64 scause = r_scause();

    if (scause == 0x0000000000000008UL || scause == 0x0000000000000009UL) {
        // interrupt -> call ecall from user/system mode
        uint64 sepc = r_sepc() + 4;
        uint64 sstatus = r_sstatus(); // save value of status register

        if(a0 == 0x01) { // mem_alloc
            size_t size = (size_t)a1;
            void* ptr = MemoryAllocator::mem_alloc(size);
            w_a0_stack((long)ptr);
        }
        else if(a0 == 0x02) { // mem_free
            a0 = MemoryAllocator::mem_free((void *)a1);
            w_a0_stack(a0);
        }
        else if(a0 == 0x11) { //thread_create
            PCB *handle = PCB::createThread((void (*)(void*))(a2), (void*)a6, (uint64*)a7);

            if(!handle) w_a0_stack(-1);
            else {
                PCB** h = (PCB**)a1;
                *(h) = handle;
                w_a0_stack(0);
            }
        }
        else if(a0 == 0x12) { // thread_exit
            a0 = PCB::exit();
            w_a0_stack(a0);
        }
        else if(a0 == 0x13) { // thread_dispatch
            PCB::dispatch();
        }
        else if(a0 == 0x14) { //thread_join
            PCB* volatile handle = (PCB*)a1;
            PCB::join(handle);
        }
        else if(a0 == 0x15){ //thread_start
            thread_t thread = (thread_t)a1;
            thread->start();
        } else if(a0 == 0x16){ //thread_create bez start-a
            PCB *handle = PCB::_createThread((void (*)(void*))(a2), (void*)a6, (uint64*)a7);

            if(!handle) w_a0_stack(-1);
            else {
                PCB** h = (PCB**)a1;
                *(h) = handle;
                w_a0_stack(0);
            }
        }
        else if(a0 == 0x21) { // sem_open
            Sem* handle = new Sem((unsigned)a2);
            Sem** h = (Sem**)a1;
            *(h) = handle;
            w_a0_stack(0);
        }
        else if(a0 == 0x22) { // sem_close
            Sem* sem = (Sem*)a1;

            if(!sem) w_a0_stack(-1);
            else {
                delete sem;
                w_a0_stack(0);
            }
        }
        else if(a0 == 0x23) { // sem_wait
            Sem* sem = (Sem*)a1;
            sem->wait();
        }
        else if(a0 == 0x24) { // sem_signal
            Sem* sem = (Sem*)a1;
            sem->signal();
        }
        else if(a0 == 0x25) { // change to user mode
            w_sstatus(sstatus);
            mc_sstatus(1<<8);
            __asm__ volatile("csrw sepc, %0" : : "r" (sepc));
            mc_sip(SIP_SSIP);
            return;
        }
        else if(a0 == 0x41) { // getc
            char c = __getc();
            w_a0_stack((long)c);
        }
        else if(a0 == 0x42) { // putc
            __putc((char)a1);
        }
        else if(a0 == 0x50){ // getThreadId
            a0 = PCB::getThreadID();
            w_a0_stack(a0);

            PCB::dispatch();
        }

        w_sstatus(sstatus);
        w_sepc(sepc);
    }
    else {
        // unexpected trap cause
        printString("Trap cause\n");
        printInt(scause);
        printString("\n");
        printInt(r_sepc());
        printString("\n");
    }
}

void Riscv::handleConsoleInterrupt(){
    //extern hardware interrupt
    console_handler();
}

void Riscv::handleTimerInterrupt() {
    //timer interrupt
    mc_sip(SIP_SSIP);
    if(PCB::timeSliceCounter++ >= 10 && !(PCB::readyToPrintA || PCB::readyToPrintB || PCB::readyToPrintC)){
        PCB::readyToPrintB = true;
        PCB::readyToPrintA = true;
        PCB::readyToPrintC = true;
        PCB::timeSliceCounter = 0;
    }
}