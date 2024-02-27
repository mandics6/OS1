//
// Created by os on 2/5/24.
//
#include "../h/resource.hpp"

Resource::Resource(int n){
    cnt = n;
    mutex = new Semaphore(1);
    sem = new Semaphore(0);
    waiting = 0;
}

void Resource::take(int num){
    mutex->wait();
    if(num > cnt){
        mutex->signal();
        waiting++;
        sem->wait();
        mutex->wait();
        cnt -= num;
        mutex->signal();
    } else {
        cnt -= num;
        mutex->signal();
    }
}

int Resource::give_back(int num){
    mutex->wait();
    cnt+= num;
    while(waiting > 0){
        waiting--;
        sem->signal();
    }
    mutex->signal();
    return 0;
}