//
// Created by os on 7/31/23.
//

#include "../h/printing.hpp"
#include "../h/pcb.hpp"
#include "../h/riscv.hpp"
#include "../h/syscall_cpp.hpp"

extern void userMain();

int main() {
    Riscv::w_stvec((uint64) &Riscv::supervisorTrap | 0b01);
    Riscv::ms_sstatus(Riscv::SSTATUS_SIE);

    PCB::running = PCB::createThread(nullptr, nullptr, nullptr);
    printString("MAIN\n");

    thread_t user;
    thread_create(&user, reinterpret_cast<void (*)(void *)>(userMain), nullptr);

    thread_join(user);

    printString("Main finished\n");
    return 0;
}