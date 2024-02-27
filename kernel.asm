
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000b117          	auipc	sp,0xb
    80000004:	71013103          	ld	sp,1808(sp) # 8000b710 <_GLOBAL_OFFSET_TABLE_+0x38>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	46c060ef          	jal	ra,80006488 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001004:	00b29a63          	bne	t0,a1,80001018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000100c:	fe029ae3          	bnez	t0,80001000 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001010:	00000513          	li	a0,0
    jr ra                  # Return.
    80001014:	00008067          	ret

0000000080001018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001018:	00100513          	li	a0,1
    8000101c:	00008067          	ret

0000000080001020 <_ZN5Riscv14supervisorTrapEv>:

.global _ZN5Riscv14supervisorTrapEv
.type _ZN5Riscv14supervisorTrapEv, @function
.align 4
_ZN5Riscv14supervisorTrapEv:
    j ecallInterrupt
    80001020:	02c0006f          	j	8000104c <ecallInterrupt>
    j timerInterrupt
    80001024:	1380006f          	j	8000115c <timerInterrupt>
    nop
    80001028:	00000013          	nop
    nop
    8000102c:	00000013          	nop
    nop
    80001030:	00000013          	nop
    nop
    80001034:	00000013          	nop
    nop
    80001038:	00000013          	nop
    nop
    8000103c:	00000013          	nop
    nop
    80001040:	00000013          	nop
    j consoleInterrupt
    80001044:	2280006f          	j	8000126c <consoleInterrupt>
    sret
    80001048:	10200073          	sret

000000008000104c <ecallInterrupt>:

ecallInterrupt:
    addi sp, sp, -256
    8000104c:	f0010113          	addi	sp,sp,-256
    # push all registers to stack
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001050:	00013023          	sd	zero,0(sp)
    80001054:	00113423          	sd	ra,8(sp)
    80001058:	00213823          	sd	sp,16(sp)
    8000105c:	00313c23          	sd	gp,24(sp)
    80001060:	02413023          	sd	tp,32(sp)
    80001064:	02513423          	sd	t0,40(sp)
    80001068:	02613823          	sd	t1,48(sp)
    8000106c:	02713c23          	sd	t2,56(sp)
    80001070:	04813023          	sd	s0,64(sp)
    80001074:	04913423          	sd	s1,72(sp)
    80001078:	04a13823          	sd	a0,80(sp)
    8000107c:	04b13c23          	sd	a1,88(sp)
    80001080:	06c13023          	sd	a2,96(sp)
    80001084:	06d13423          	sd	a3,104(sp)
    80001088:	06e13823          	sd	a4,112(sp)
    8000108c:	06f13c23          	sd	a5,120(sp)
    80001090:	09013023          	sd	a6,128(sp)
    80001094:	09113423          	sd	a7,136(sp)
    80001098:	09213823          	sd	s2,144(sp)
    8000109c:	09313c23          	sd	s3,152(sp)
    800010a0:	0b413023          	sd	s4,160(sp)
    800010a4:	0b513423          	sd	s5,168(sp)
    800010a8:	0b613823          	sd	s6,176(sp)
    800010ac:	0b713c23          	sd	s7,184(sp)
    800010b0:	0d813023          	sd	s8,192(sp)
    800010b4:	0d913423          	sd	s9,200(sp)
    800010b8:	0da13823          	sd	s10,208(sp)
    800010bc:	0db13c23          	sd	s11,216(sp)
    800010c0:	0fc13023          	sd	t3,224(sp)
    800010c4:	0fd13423          	sd	t4,232(sp)
    800010c8:	0fe13823          	sd	t5,240(sp)
    800010cc:	0ff13c23          	sd	t6,248(sp)

    call _ZN5Riscv25handleSupervisorInterruptEv
    800010d0:	318040ef          	jal	ra,800053e8 <_ZN5Riscv25handleSupervisorInterruptEv>

    # pop all registers from stack
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    800010d4:	00013003          	ld	zero,0(sp)
    800010d8:	00813083          	ld	ra,8(sp)
    800010dc:	01013103          	ld	sp,16(sp)
    800010e0:	01813183          	ld	gp,24(sp)
    800010e4:	02013203          	ld	tp,32(sp)
    800010e8:	02813283          	ld	t0,40(sp)
    800010ec:	03013303          	ld	t1,48(sp)
    800010f0:	03813383          	ld	t2,56(sp)
    800010f4:	04013403          	ld	s0,64(sp)
    800010f8:	04813483          	ld	s1,72(sp)
    800010fc:	05013503          	ld	a0,80(sp)
    80001100:	05813583          	ld	a1,88(sp)
    80001104:	06013603          	ld	a2,96(sp)
    80001108:	06813683          	ld	a3,104(sp)
    8000110c:	07013703          	ld	a4,112(sp)
    80001110:	07813783          	ld	a5,120(sp)
    80001114:	08013803          	ld	a6,128(sp)
    80001118:	08813883          	ld	a7,136(sp)
    8000111c:	09013903          	ld	s2,144(sp)
    80001120:	09813983          	ld	s3,152(sp)
    80001124:	0a013a03          	ld	s4,160(sp)
    80001128:	0a813a83          	ld	s5,168(sp)
    8000112c:	0b013b03          	ld	s6,176(sp)
    80001130:	0b813b83          	ld	s7,184(sp)
    80001134:	0c013c03          	ld	s8,192(sp)
    80001138:	0c813c83          	ld	s9,200(sp)
    8000113c:	0d013d03          	ld	s10,208(sp)
    80001140:	0d813d83          	ld	s11,216(sp)
    80001144:	0e013e03          	ld	t3,224(sp)
    80001148:	0e813e83          	ld	t4,232(sp)
    8000114c:	0f013f03          	ld	t5,240(sp)
    80001150:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001154:	10010113          	addi	sp,sp,256
    sret
    80001158:	10200073          	sret

000000008000115c <timerInterrupt>:

timerInterrupt:
    addi sp, sp, -256
    8000115c:	f0010113          	addi	sp,sp,-256
    # push all registers to stack
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001160:	00013023          	sd	zero,0(sp)
    80001164:	00113423          	sd	ra,8(sp)
    80001168:	00213823          	sd	sp,16(sp)
    8000116c:	00313c23          	sd	gp,24(sp)
    80001170:	02413023          	sd	tp,32(sp)
    80001174:	02513423          	sd	t0,40(sp)
    80001178:	02613823          	sd	t1,48(sp)
    8000117c:	02713c23          	sd	t2,56(sp)
    80001180:	04813023          	sd	s0,64(sp)
    80001184:	04913423          	sd	s1,72(sp)
    80001188:	04a13823          	sd	a0,80(sp)
    8000118c:	04b13c23          	sd	a1,88(sp)
    80001190:	06c13023          	sd	a2,96(sp)
    80001194:	06d13423          	sd	a3,104(sp)
    80001198:	06e13823          	sd	a4,112(sp)
    8000119c:	06f13c23          	sd	a5,120(sp)
    800011a0:	09013023          	sd	a6,128(sp)
    800011a4:	09113423          	sd	a7,136(sp)
    800011a8:	09213823          	sd	s2,144(sp)
    800011ac:	09313c23          	sd	s3,152(sp)
    800011b0:	0b413023          	sd	s4,160(sp)
    800011b4:	0b513423          	sd	s5,168(sp)
    800011b8:	0b613823          	sd	s6,176(sp)
    800011bc:	0b713c23          	sd	s7,184(sp)
    800011c0:	0d813023          	sd	s8,192(sp)
    800011c4:	0d913423          	sd	s9,200(sp)
    800011c8:	0da13823          	sd	s10,208(sp)
    800011cc:	0db13c23          	sd	s11,216(sp)
    800011d0:	0fc13023          	sd	t3,224(sp)
    800011d4:	0fd13423          	sd	t4,232(sp)
    800011d8:	0fe13823          	sd	t5,240(sp)
    800011dc:	0ff13c23          	sd	t6,248(sp)

    call _ZN5Riscv20handleTimerInterruptEv
    800011e0:	5b0040ef          	jal	ra,80005790 <_ZN5Riscv20handleTimerInterruptEv>

    # pop all registers from stack
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    800011e4:	00013003          	ld	zero,0(sp)
    800011e8:	00813083          	ld	ra,8(sp)
    800011ec:	01013103          	ld	sp,16(sp)
    800011f0:	01813183          	ld	gp,24(sp)
    800011f4:	02013203          	ld	tp,32(sp)
    800011f8:	02813283          	ld	t0,40(sp)
    800011fc:	03013303          	ld	t1,48(sp)
    80001200:	03813383          	ld	t2,56(sp)
    80001204:	04013403          	ld	s0,64(sp)
    80001208:	04813483          	ld	s1,72(sp)
    8000120c:	05013503          	ld	a0,80(sp)
    80001210:	05813583          	ld	a1,88(sp)
    80001214:	06013603          	ld	a2,96(sp)
    80001218:	06813683          	ld	a3,104(sp)
    8000121c:	07013703          	ld	a4,112(sp)
    80001220:	07813783          	ld	a5,120(sp)
    80001224:	08013803          	ld	a6,128(sp)
    80001228:	08813883          	ld	a7,136(sp)
    8000122c:	09013903          	ld	s2,144(sp)
    80001230:	09813983          	ld	s3,152(sp)
    80001234:	0a013a03          	ld	s4,160(sp)
    80001238:	0a813a83          	ld	s5,168(sp)
    8000123c:	0b013b03          	ld	s6,176(sp)
    80001240:	0b813b83          	ld	s7,184(sp)
    80001244:	0c013c03          	ld	s8,192(sp)
    80001248:	0c813c83          	ld	s9,200(sp)
    8000124c:	0d013d03          	ld	s10,208(sp)
    80001250:	0d813d83          	ld	s11,216(sp)
    80001254:	0e013e03          	ld	t3,224(sp)
    80001258:	0e813e83          	ld	t4,232(sp)
    8000125c:	0f013f03          	ld	t5,240(sp)
    80001260:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001264:	10010113          	addi	sp,sp,256
    sret
    80001268:	10200073          	sret

000000008000126c <consoleInterrupt>:

consoleInterrupt:
    addi sp, sp, -256
    8000126c:	f0010113          	addi	sp,sp,-256
    # push all registers to stack
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001270:	00013023          	sd	zero,0(sp)
    80001274:	00113423          	sd	ra,8(sp)
    80001278:	00213823          	sd	sp,16(sp)
    8000127c:	00313c23          	sd	gp,24(sp)
    80001280:	02413023          	sd	tp,32(sp)
    80001284:	02513423          	sd	t0,40(sp)
    80001288:	02613823          	sd	t1,48(sp)
    8000128c:	02713c23          	sd	t2,56(sp)
    80001290:	04813023          	sd	s0,64(sp)
    80001294:	04913423          	sd	s1,72(sp)
    80001298:	04a13823          	sd	a0,80(sp)
    8000129c:	04b13c23          	sd	a1,88(sp)
    800012a0:	06c13023          	sd	a2,96(sp)
    800012a4:	06d13423          	sd	a3,104(sp)
    800012a8:	06e13823          	sd	a4,112(sp)
    800012ac:	06f13c23          	sd	a5,120(sp)
    800012b0:	09013023          	sd	a6,128(sp)
    800012b4:	09113423          	sd	a7,136(sp)
    800012b8:	09213823          	sd	s2,144(sp)
    800012bc:	09313c23          	sd	s3,152(sp)
    800012c0:	0b413023          	sd	s4,160(sp)
    800012c4:	0b513423          	sd	s5,168(sp)
    800012c8:	0b613823          	sd	s6,176(sp)
    800012cc:	0b713c23          	sd	s7,184(sp)
    800012d0:	0d813023          	sd	s8,192(sp)
    800012d4:	0d913423          	sd	s9,200(sp)
    800012d8:	0da13823          	sd	s10,208(sp)
    800012dc:	0db13c23          	sd	s11,216(sp)
    800012e0:	0fc13023          	sd	t3,224(sp)
    800012e4:	0fd13423          	sd	t4,232(sp)
    800012e8:	0fe13823          	sd	t5,240(sp)
    800012ec:	0ff13c23          	sd	t6,248(sp)

    call _ZN5Riscv22handleConsoleInterruptEv
    800012f0:	478040ef          	jal	ra,80005768 <_ZN5Riscv22handleConsoleInterruptEv>

    # pop all registers from stack
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    800012f4:	00013003          	ld	zero,0(sp)
    800012f8:	00813083          	ld	ra,8(sp)
    800012fc:	01013103          	ld	sp,16(sp)
    80001300:	01813183          	ld	gp,24(sp)
    80001304:	02013203          	ld	tp,32(sp)
    80001308:	02813283          	ld	t0,40(sp)
    8000130c:	03013303          	ld	t1,48(sp)
    80001310:	03813383          	ld	t2,56(sp)
    80001314:	04013403          	ld	s0,64(sp)
    80001318:	04813483          	ld	s1,72(sp)
    8000131c:	05013503          	ld	a0,80(sp)
    80001320:	05813583          	ld	a1,88(sp)
    80001324:	06013603          	ld	a2,96(sp)
    80001328:	06813683          	ld	a3,104(sp)
    8000132c:	07013703          	ld	a4,112(sp)
    80001330:	07813783          	ld	a5,120(sp)
    80001334:	08013803          	ld	a6,128(sp)
    80001338:	08813883          	ld	a7,136(sp)
    8000133c:	09013903          	ld	s2,144(sp)
    80001340:	09813983          	ld	s3,152(sp)
    80001344:	0a013a03          	ld	s4,160(sp)
    80001348:	0a813a83          	ld	s5,168(sp)
    8000134c:	0b013b03          	ld	s6,176(sp)
    80001350:	0b813b83          	ld	s7,184(sp)
    80001354:	0c013c03          	ld	s8,192(sp)
    80001358:	0c813c83          	ld	s9,200(sp)
    8000135c:	0d013d03          	ld	s10,208(sp)
    80001360:	0d813d83          	ld	s11,216(sp)
    80001364:	0e013e03          	ld	t3,224(sp)
    80001368:	0e813e83          	ld	t4,232(sp)
    8000136c:	0f013f03          	ld	t5,240(sp)
    80001370:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001374:	10010113          	addi	sp,sp,256
    80001378:	10200073          	sret
	...

0000000080001388 <_ZN3PCB13contextSwitchEPNS_7ContextES1_>:
.global _ZN3PCB13contextSwitchEPNS_7ContextES1_
.type _ZN3PCB13contextSwitchEPNS_7ContextES1_, @function
_ZN3PCB13contextSwitchEPNS_7ContextES1_:
    sd ra, 0 * 8(a0)
    80001388:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    8000138c:	00253423          	sd	sp,8(a0)

    ld ra, 0 * 8(a1)
    80001390:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    80001394:	0085b103          	ld	sp,8(a1)

    80001398:	00008067          	ret

000000008000139c <_Z9mem_allocm>:
// Created by os on 8/15/23.
//
#include "../h/syscall_c.hpp"
#include "../h/riscv.hpp"

void* mem_alloc(size_t size){
    8000139c:	fe010113          	addi	sp,sp,-32
    800013a0:	00813c23          	sd	s0,24(sp)
    800013a4:	02010413          	addi	s0,sp,32
    __asm__ volatile ("ld %0, 10*8(fp)" : "=r"(a0));
    return a0;
}

inline void Riscv::w_a1(uint64 a1) {
    __asm__ volatile ("mv a1, %0" : : "r"(a1));
    800013a8:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r"(a0));
    800013ac:	00100793          	li	a5,1
    800013b0:	00078513          	mv	a0,a5
    Riscv::w_a1(size);
    Riscv::w_a0(0x01);
    __asm__ volatile ("ecall");
    800013b4:	00000073          	ecall

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    800013b8:	00050793          	mv	a5,a0
    800013bc:	fef43423          	sd	a5,-24(s0)
    return (void*)a0;
    800013c0:	fe843503          	ld	a0,-24(s0)
}
    800013c4:	01813403          	ld	s0,24(sp)
    800013c8:	02010113          	addi	sp,sp,32
    800013cc:	00008067          	ret

00000000800013d0 <_Z8mem_freePv>:

int mem_free(void* ptr){
    800013d0:	fe010113          	addi	sp,sp,-32
    800013d4:	00813c23          	sd	s0,24(sp)
    800013d8:	02010413          	addi	s0,sp,32
    __asm__ volatile ("mv a1, %0" : : "r"(a1));
    800013dc:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r"(a0));
    800013e0:	00200793          	li	a5,2
    800013e4:	00078513          	mv	a0,a5
    Riscv::w_a1((uint64)ptr);
    Riscv::w_a0(0x02);
    __asm__ volatile ("ecall");
    800013e8:	00000073          	ecall

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    800013ec:	00050793          	mv	a5,a0
    800013f0:	fef43423          	sd	a5,-24(s0)
    return a0;
    800013f4:	fe843503          	ld	a0,-24(s0)
}
    800013f8:	0005051b          	sext.w	a0,a0
    800013fc:	01813403          	ld	s0,24(sp)
    80001400:	02010113          	addi	sp,sp,32
    80001404:	00008067          	ret

0000000080001408 <_Z13thread_createPP3PCBPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg){
    80001408:	fc010113          	addi	sp,sp,-64
    8000140c:	02113c23          	sd	ra,56(sp)
    80001410:	02813823          	sd	s0,48(sp)
    80001414:	02913423          	sd	s1,40(sp)
    80001418:	03213023          	sd	s2,32(sp)
    8000141c:	01313c23          	sd	s3,24(sp)
    80001420:	04010413          	addi	s0,sp,64
    80001424:	00050913          	mv	s2,a0
    80001428:	00058493          	mv	s1,a1
    8000142c:	00060993          	mv	s3,a2
    void* stack;
    if(start_routine == nullptr) stack = nullptr;
    80001430:	04058e63          	beqz	a1,8000148c <_Z13thread_createPP3PCBPFvPvES2_+0x84>
    else {
        stack = mem_alloc(DEFAULT_STACK_SIZE * sizeof(uint64));
    80001434:	00008537          	lui	a0,0x8
    80001438:	00000097          	auipc	ra,0x0
    8000143c:	f64080e7          	jalr	-156(ra) # 8000139c <_Z9mem_allocm>
        if(stack == nullptr) return -1;
    80001440:	04050a63          	beqz	a0,80001494 <_Z13thread_createPP3PCBPFvPvES2_+0x8c>
    __asm__ volatile ("ld %0, 16*8(fp)" : "=r"(a6));
    return a6;
}

inline void Riscv::w_a7(uint64 a7) {
    __asm__ volatile ("mv a7, %0" : : "r"(a7));
    80001444:	00050893          	mv	a7,a0
    __asm__ volatile ("mv a6, %0" : : "r"(a6));
    80001448:	00098813          	mv	a6,s3
    __asm__ volatile ("mv a2, %0" : : "r"(a2));
    8000144c:	00048613          	mv	a2,s1
    __asm__ volatile ("mv a1, %0" : : "r"(a1));
    80001450:	00090593          	mv	a1,s2
    __asm__ volatile ("mv a0, %0" : : "r"(a0));
    80001454:	01100793          	li	a5,17
    80001458:	00078513          	mv	a0,a5
    Riscv::w_a7((uint64)stack);
    Riscv::w_a6((uint64)arg);           //ne koristi a3 i a4, ni a5 - CPU ih koristi...
    Riscv::w_a2((uint64)start_routine);
    Riscv::w_a1((uint64)handle);
    Riscv::w_a0(0x11);
    __asm__ volatile ("ecall");
    8000145c:	00000073          	ecall

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r" (a0));
    80001460:	00050793          	mv	a5,a0
    80001464:	fcf43423          	sd	a5,-56(s0)
    return a0;
    80001468:	fc843503          	ld	a0,-56(s0)
    8000146c:	0005051b          	sext.w	a0,a0
}
    80001470:	03813083          	ld	ra,56(sp)
    80001474:	03013403          	ld	s0,48(sp)
    80001478:	02813483          	ld	s1,40(sp)
    8000147c:	02013903          	ld	s2,32(sp)
    80001480:	01813983          	ld	s3,24(sp)
    80001484:	04010113          	addi	sp,sp,64
    80001488:	00008067          	ret
    if(start_routine == nullptr) stack = nullptr;
    8000148c:	00000513          	li	a0,0
    80001490:	fb5ff06f          	j	80001444 <_Z13thread_createPP3PCBPFvPvES2_+0x3c>
        if(stack == nullptr) return -1;
    80001494:	fff00513          	li	a0,-1
    80001498:	fd9ff06f          	j	80001470 <_Z13thread_createPP3PCBPFvPvES2_+0x68>

000000008000149c <_Z14_thread_createPP3PCBPFvPvES2_>:

int _thread_create(thread_t* handle, void(*start_routine)(void*), void* arg){
    8000149c:	fc010113          	addi	sp,sp,-64
    800014a0:	02113c23          	sd	ra,56(sp)
    800014a4:	02813823          	sd	s0,48(sp)
    800014a8:	02913423          	sd	s1,40(sp)
    800014ac:	03213023          	sd	s2,32(sp)
    800014b0:	01313c23          	sd	s3,24(sp)
    800014b4:	04010413          	addi	s0,sp,64
    800014b8:	00050913          	mv	s2,a0
    800014bc:	00058493          	mv	s1,a1
    800014c0:	00060993          	mv	s3,a2
    void* stack;
    if(start_routine == nullptr) stack = nullptr;
    800014c4:	04058e63          	beqz	a1,80001520 <_Z14_thread_createPP3PCBPFvPvES2_+0x84>
    else {
        stack = mem_alloc(DEFAULT_STACK_SIZE * sizeof(uint64));
    800014c8:	00008537          	lui	a0,0x8
    800014cc:	00000097          	auipc	ra,0x0
    800014d0:	ed0080e7          	jalr	-304(ra) # 8000139c <_Z9mem_allocm>
        if(stack == nullptr) return -1;
    800014d4:	04050a63          	beqz	a0,80001528 <_Z14_thread_createPP3PCBPFvPvES2_+0x8c>
    __asm__ volatile ("mv a7, %0" : : "r"(a7));
    800014d8:	00050893          	mv	a7,a0
    __asm__ volatile ("mv a6, %0" : : "r"(a6));
    800014dc:	00098813          	mv	a6,s3
    __asm__ volatile ("mv a2, %0" : : "r"(a2));
    800014e0:	00048613          	mv	a2,s1
    __asm__ volatile ("mv a1, %0" : : "r"(a1));
    800014e4:	00090593          	mv	a1,s2
    __asm__ volatile ("mv a0, %0" : : "r"(a0));
    800014e8:	01600793          	li	a5,22
    800014ec:	00078513          	mv	a0,a5
    Riscv::w_a7((uint64)stack);
    Riscv::w_a6((uint64)arg);
    Riscv::w_a2((uint64)start_routine);
    Riscv::w_a1((uint64)handle);
    Riscv::w_a0(0x16);
    __asm__ volatile ("ecall");
    800014f0:	00000073          	ecall

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r" (a0));
    800014f4:	00050793          	mv	a5,a0
    800014f8:	fcf43423          	sd	a5,-56(s0)
    return a0;
    800014fc:	fc843503          	ld	a0,-56(s0)
    80001500:	0005051b          	sext.w	a0,a0
}
    80001504:	03813083          	ld	ra,56(sp)
    80001508:	03013403          	ld	s0,48(sp)
    8000150c:	02813483          	ld	s1,40(sp)
    80001510:	02013903          	ld	s2,32(sp)
    80001514:	01813983          	ld	s3,24(sp)
    80001518:	04010113          	addi	sp,sp,64
    8000151c:	00008067          	ret
    if(start_routine == nullptr) stack = nullptr;
    80001520:	00000513          	li	a0,0
    80001524:	fb5ff06f          	j	800014d8 <_Z14_thread_createPP3PCBPFvPvES2_+0x3c>
        if(stack == nullptr) return -1;
    80001528:	fff00513          	li	a0,-1
    8000152c:	fd9ff06f          	j	80001504 <_Z14_thread_createPP3PCBPFvPvES2_+0x68>

0000000080001530 <_Z11thread_exitv>:

int thread_exit(){
    80001530:	fe010113          	addi	sp,sp,-32
    80001534:	00813c23          	sd	s0,24(sp)
    80001538:	02010413          	addi	s0,sp,32
    8000153c:	01200793          	li	a5,18
    80001540:	00078513          	mv	a0,a5
    Riscv::w_a0(0x12);
    __asm__ volatile("ecall");
    80001544:	00000073          	ecall

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    80001548:	00050793          	mv	a5,a0
    8000154c:	fef43423          	sd	a5,-24(s0)
    return a0;
    80001550:	fe843503          	ld	a0,-24(s0)
}
    80001554:	0005051b          	sext.w	a0,a0
    80001558:	01813403          	ld	s0,24(sp)
    8000155c:	02010113          	addi	sp,sp,32
    80001560:	00008067          	ret

0000000080001564 <_Z15thread_dispatchv>:

void thread_dispatch(){
    80001564:	ff010113          	addi	sp,sp,-16
    80001568:	00813423          	sd	s0,8(sp)
    8000156c:	01010413          	addi	s0,sp,16
    80001570:	01300793          	li	a5,19
    80001574:	00078513          	mv	a0,a5
    Riscv::w_a0(0x13);
    __asm__ volatile("ecall");
    80001578:	00000073          	ecall
}
    8000157c:	00813403          	ld	s0,8(sp)
    80001580:	01010113          	addi	sp,sp,16
    80001584:	00008067          	ret

0000000080001588 <_Z11thread_joinP3PCB>:

void thread_join(thread_t handle){
    80001588:	ff010113          	addi	sp,sp,-16
    8000158c:	00813423          	sd	s0,8(sp)
    80001590:	01010413          	addi	s0,sp,16
    __asm__ volatile ("mv a1, %0" : : "r"(a1));
    80001594:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r"(a0));
    80001598:	01400793          	li	a5,20
    8000159c:	00078513          	mv	a0,a5
    Riscv::w_a1((uint64)handle);
    Riscv::w_a0(0x14);
    __asm__ volatile("ecall");
    800015a0:	00000073          	ecall
}
    800015a4:	00813403          	ld	s0,8(sp)
    800015a8:	01010113          	addi	sp,sp,16
    800015ac:	00008067          	ret

00000000800015b0 <_Z12thread_startP3PCB>:

int thread_start(thread_t handle){
    800015b0:	fe010113          	addi	sp,sp,-32
    800015b4:	00813c23          	sd	s0,24(sp)
    800015b8:	02010413          	addi	s0,sp,32
    __asm__ volatile ("mv a1, %0" : : "r"(a1));
    800015bc:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r"(a0));
    800015c0:	01500793          	li	a5,21
    800015c4:	00078513          	mv	a0,a5
    Riscv::w_a1((uint64)handle);
    Riscv::w_a0(0x15);
    __asm__ volatile ("ecall");
    800015c8:	00000073          	ecall

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    800015cc:	00050793          	mv	a5,a0
    800015d0:	fef43423          	sd	a5,-24(s0)
    return a0;
    800015d4:	fe843503          	ld	a0,-24(s0)
}
    800015d8:	0005051b          	sext.w	a0,a0
    800015dc:	01813403          	ld	s0,24(sp)
    800015e0:	02010113          	addi	sp,sp,32
    800015e4:	00008067          	ret

00000000800015e8 <_Z4pingP3PCB>:

void ping(thread_t handle){
    800015e8:	ff010113          	addi	sp,sp,-16
    800015ec:	00813423          	sd	s0,8(sp)
    800015f0:	01010413          	addi	s0,sp,16
    __asm__ volatile ("mv a1, %0" : : "r"(a1));
    800015f4:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r"(a0));
    800015f8:	01700793          	li	a5,23
    800015fc:	00078513          	mv	a0,a5
    Riscv::w_a1((uint64)handle);
    Riscv::w_a0(0x17);
    __asm__ volatile ("ecall");
    80001600:	00000073          	ecall
}
    80001604:	00813403          	ld	s0,8(sp)
    80001608:	01010113          	addi	sp,sp,16
    8000160c:	00008067          	ret

0000000080001610 <_Z13get_thread_idv>:

int get_thread_id(){
    80001610:	fe010113          	addi	sp,sp,-32
    80001614:	00813c23          	sd	s0,24(sp)
    80001618:	02010413          	addi	s0,sp,32
    8000161c:	05000793          	li	a5,80
    80001620:	00078513          	mv	a0,a5
    Riscv::w_a0(0x50);
    __asm__ volatile ("ecall");
    80001624:	00000073          	ecall

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    80001628:	00050793          	mv	a5,a0
    8000162c:	fef43423          	sd	a5,-24(s0)
    return a0;
    80001630:	fe843503          	ld	a0,-24(s0)
}
    80001634:	0005051b          	sext.w	a0,a0
    80001638:	01813403          	ld	s0,24(sp)
    8000163c:	02010113          	addi	sp,sp,32
    80001640:	00008067          	ret

0000000080001644 <_Z8sem_openPP3Semj>:

int sem_open(sem_t* handle, unsigned init){
    80001644:	fe010113          	addi	sp,sp,-32
    80001648:	00813c23          	sd	s0,24(sp)
    8000164c:	02010413          	addi	s0,sp,32
    Riscv::w_a2((uint64)init);
    80001650:	02059593          	slli	a1,a1,0x20
    80001654:	0205d593          	srli	a1,a1,0x20
    __asm__ volatile ("mv a2, %0" : : "r"(a2));
    80001658:	00058613          	mv	a2,a1
    __asm__ volatile ("mv a1, %0" : : "r"(a1));
    8000165c:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r"(a0));
    80001660:	02100793          	li	a5,33
    80001664:	00078513          	mv	a0,a5
    Riscv::w_a1((uint64)handle);
    Riscv::w_a0(0x21);
    __asm__ volatile("ecall");
    80001668:	00000073          	ecall

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    8000166c:	00050793          	mv	a5,a0
    80001670:	fef43423          	sd	a5,-24(s0)
    return a0;
    80001674:	fe843503          	ld	a0,-24(s0)
}
    80001678:	0005051b          	sext.w	a0,a0
    8000167c:	01813403          	ld	s0,24(sp)
    80001680:	02010113          	addi	sp,sp,32
    80001684:	00008067          	ret

0000000080001688 <_Z9sem_closeP3Sem>:

int sem_close(sem_t handle){
    80001688:	fe010113          	addi	sp,sp,-32
    8000168c:	00813c23          	sd	s0,24(sp)
    80001690:	02010413          	addi	s0,sp,32
    __asm__ volatile ("mv a1, %0" : : "r"(a1));
    80001694:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r"(a0));
    80001698:	02200793          	li	a5,34
    8000169c:	00078513          	mv	a0,a5
    Riscv::w_a1((uint64)handle);
    Riscv::w_a0(0x22);
    __asm__ volatile("ecall");
    800016a0:	00000073          	ecall

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    800016a4:	00050793          	mv	a5,a0
    800016a8:	fef43423          	sd	a5,-24(s0)
    return a0;
    800016ac:	fe843503          	ld	a0,-24(s0)
}
    800016b0:	0005051b          	sext.w	a0,a0
    800016b4:	01813403          	ld	s0,24(sp)
    800016b8:	02010113          	addi	sp,sp,32
    800016bc:	00008067          	ret

00000000800016c0 <_Z8sem_waitP3Sem>:

int sem_wait(sem_t id){
    800016c0:	fe010113          	addi	sp,sp,-32
    800016c4:	00813c23          	sd	s0,24(sp)
    800016c8:	02010413          	addi	s0,sp,32
    __asm__ volatile ("mv a1, %0" : : "r"(a1));
    800016cc:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r"(a0));
    800016d0:	02300793          	li	a5,35
    800016d4:	00078513          	mv	a0,a5
    Riscv::w_a1((uint64)id);
    Riscv::w_a0(0x23);
    __asm__ volatile("ecall");
    800016d8:	00000073          	ecall

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    800016dc:	00050793          	mv	a5,a0
    800016e0:	fef43423          	sd	a5,-24(s0)
    return a0;
    800016e4:	fe843503          	ld	a0,-24(s0)
}
    800016e8:	0005051b          	sext.w	a0,a0
    800016ec:	01813403          	ld	s0,24(sp)
    800016f0:	02010113          	addi	sp,sp,32
    800016f4:	00008067          	ret

00000000800016f8 <_Z10sem_signalP3Sem>:

int sem_signal(sem_t id){
    800016f8:	fe010113          	addi	sp,sp,-32
    800016fc:	00813c23          	sd	s0,24(sp)
    80001700:	02010413          	addi	s0,sp,32
    __asm__ volatile ("mv a1, %0" : : "r"(a1));
    80001704:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r"(a0));
    80001708:	02400793          	li	a5,36
    8000170c:	00078513          	mv	a0,a5
    Riscv::w_a1((uint64)id);
    Riscv::w_a0(0x24);
    __asm__ volatile("ecall");
    80001710:	00000073          	ecall

    volatile uint64 a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    80001714:	00050793          	mv	a5,a0
    80001718:	fef43423          	sd	a5,-24(s0)
    return a0;
    8000171c:	fe843503          	ld	a0,-24(s0)
}
    80001720:	0005051b          	sext.w	a0,a0
    80001724:	01813403          	ld	s0,24(sp)
    80001728:	02010113          	addi	sp,sp,32
    8000172c:	00008067          	ret

0000000080001730 <_Z10time_sleepm>:

int time_sleep(time_t t){
    80001730:	ff010113          	addi	sp,sp,-16
    80001734:	00813423          	sd	s0,8(sp)
    80001738:	01010413          	addi	s0,sp,16
    return 0;
}
    8000173c:	00000513          	li	a0,0
    80001740:	00813403          	ld	s0,8(sp)
    80001744:	01010113          	addi	sp,sp,16
    80001748:	00008067          	ret

000000008000174c <_Z4getcv>:

char getc(){
    8000174c:	fe010113          	addi	sp,sp,-32
    80001750:	00813c23          	sd	s0,24(sp)
    80001754:	02010413          	addi	s0,sp,32
    80001758:	04100793          	li	a5,65
    8000175c:	00078513          	mv	a0,a5
    Riscv::w_a0(0x41);
    __asm__ volatile ("ecall");
    80001760:	00000073          	ecall

    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    80001764:	00050793          	mv	a5,a0
    80001768:	fef43423          	sd	a5,-24(s0)
    return (char)a0;
    8000176c:	fe843503          	ld	a0,-24(s0)
}
    80001770:	0ff57513          	andi	a0,a0,255
    80001774:	01813403          	ld	s0,24(sp)
    80001778:	02010113          	addi	sp,sp,32
    8000177c:	00008067          	ret

0000000080001780 <_Z4putcc>:

void putc(char c){
    80001780:	ff010113          	addi	sp,sp,-16
    80001784:	00813423          	sd	s0,8(sp)
    80001788:	01010413          	addi	s0,sp,16
    __asm__ volatile ("mv a1, %0" : : "r"(a1));
    8000178c:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r"(a0));
    80001790:	04200793          	li	a5,66
    80001794:	00078513          	mv	a0,a5
    Riscv::w_a1((uint64)c);
    Riscv::w_a0(0x42);
    __asm__ volatile ("ecall");
    80001798:	00000073          	ecall
}
    8000179c:	00813403          	ld	s0,8(sp)
    800017a0:	01010113          	addi	sp,sp,16
    800017a4:	00008067          	ret

00000000800017a8 <_Z10changeUserv>:

void changeUser() {
    800017a8:	ff010113          	addi	sp,sp,-16
    800017ac:	00813423          	sd	s0,8(sp)
    800017b0:	01010413          	addi	s0,sp,16
    800017b4:	02500793          	li	a5,37
    800017b8:	00078513          	mv	a0,a5
    Riscv::w_a0(0x25);
    __asm__ volatile("ecall");
    800017bc:	00000073          	ecall
    return;
}
    800017c0:	00813403          	ld	s0,8(sp)
    800017c4:	01010113          	addi	sp,sp,16
    800017c8:	00008067          	ret

00000000800017cc <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    800017cc:	fe010113          	addi	sp,sp,-32
    800017d0:	00113c23          	sd	ra,24(sp)
    800017d4:	00813823          	sd	s0,16(sp)
    800017d8:	00913423          	sd	s1,8(sp)
    800017dc:	01213023          	sd	s2,0(sp)
    800017e0:	02010413          	addi	s0,sp,32
    800017e4:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    800017e8:	00000913          	li	s2,0
    800017ec:	00c0006f          	j	800017f8 <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    800017f0:	00000097          	auipc	ra,0x0
    800017f4:	d74080e7          	jalr	-652(ra) # 80001564 <_Z15thread_dispatchv>
    while ((key = getc()) != 0x1b) {
    800017f8:	00000097          	auipc	ra,0x0
    800017fc:	f54080e7          	jalr	-172(ra) # 8000174c <_Z4getcv>
    80001800:	0005059b          	sext.w	a1,a0
    80001804:	01b00793          	li	a5,27
    80001808:	02f58a63          	beq	a1,a5,8000183c <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    8000180c:	0084b503          	ld	a0,8(s1)
    80001810:	00005097          	auipc	ra,0x5
    80001814:	9f4080e7          	jalr	-1548(ra) # 80006204 <_ZN6Buffer3putEi>
        i++;
    80001818:	0019071b          	addiw	a4,s2,1
    8000181c:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80001820:	0004a683          	lw	a3,0(s1)
    80001824:	0026979b          	slliw	a5,a3,0x2
    80001828:	00d787bb          	addw	a5,a5,a3
    8000182c:	0017979b          	slliw	a5,a5,0x1
    80001830:	02f767bb          	remw	a5,a4,a5
    80001834:	fc0792e3          	bnez	a5,800017f8 <_ZL16producerKeyboardPv+0x2c>
    80001838:	fb9ff06f          	j	800017f0 <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    8000183c:	00100793          	li	a5,1
    80001840:	0000a717          	auipc	a4,0xa
    80001844:	f6f72023          	sw	a5,-160(a4) # 8000b7a0 <_ZL9threadEnd>
    data->buffer->put('!');
    80001848:	02100593          	li	a1,33
    8000184c:	0084b503          	ld	a0,8(s1)
    80001850:	00005097          	auipc	ra,0x5
    80001854:	9b4080e7          	jalr	-1612(ra) # 80006204 <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    80001858:	0104b503          	ld	a0,16(s1)
    8000185c:	00000097          	auipc	ra,0x0
    80001860:	e9c080e7          	jalr	-356(ra) # 800016f8 <_Z10sem_signalP3Sem>
}
    80001864:	01813083          	ld	ra,24(sp)
    80001868:	01013403          	ld	s0,16(sp)
    8000186c:	00813483          	ld	s1,8(sp)
    80001870:	00013903          	ld	s2,0(sp)
    80001874:	02010113          	addi	sp,sp,32
    80001878:	00008067          	ret

000000008000187c <_ZL8producerPv>:

static void producer(void *arg) {
    8000187c:	fe010113          	addi	sp,sp,-32
    80001880:	00113c23          	sd	ra,24(sp)
    80001884:	00813823          	sd	s0,16(sp)
    80001888:	00913423          	sd	s1,8(sp)
    8000188c:	01213023          	sd	s2,0(sp)
    80001890:	02010413          	addi	s0,sp,32
    80001894:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80001898:	00000913          	li	s2,0
    8000189c:	00c0006f          	j	800018a8 <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    800018a0:	00000097          	auipc	ra,0x0
    800018a4:	cc4080e7          	jalr	-828(ra) # 80001564 <_Z15thread_dispatchv>
    while (!threadEnd) {
    800018a8:	0000a797          	auipc	a5,0xa
    800018ac:	ef87a783          	lw	a5,-264(a5) # 8000b7a0 <_ZL9threadEnd>
    800018b0:	02079e63          	bnez	a5,800018ec <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    800018b4:	0004a583          	lw	a1,0(s1)
    800018b8:	0305859b          	addiw	a1,a1,48
    800018bc:	0084b503          	ld	a0,8(s1)
    800018c0:	00005097          	auipc	ra,0x5
    800018c4:	944080e7          	jalr	-1724(ra) # 80006204 <_ZN6Buffer3putEi>
        i++;
    800018c8:	0019071b          	addiw	a4,s2,1
    800018cc:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800018d0:	0004a683          	lw	a3,0(s1)
    800018d4:	0026979b          	slliw	a5,a3,0x2
    800018d8:	00d787bb          	addw	a5,a5,a3
    800018dc:	0017979b          	slliw	a5,a5,0x1
    800018e0:	02f767bb          	remw	a5,a4,a5
    800018e4:	fc0792e3          	bnez	a5,800018a8 <_ZL8producerPv+0x2c>
    800018e8:	fb9ff06f          	j	800018a0 <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    800018ec:	0104b503          	ld	a0,16(s1)
    800018f0:	00000097          	auipc	ra,0x0
    800018f4:	e08080e7          	jalr	-504(ra) # 800016f8 <_Z10sem_signalP3Sem>
}
    800018f8:	01813083          	ld	ra,24(sp)
    800018fc:	01013403          	ld	s0,16(sp)
    80001900:	00813483          	ld	s1,8(sp)
    80001904:	00013903          	ld	s2,0(sp)
    80001908:	02010113          	addi	sp,sp,32
    8000190c:	00008067          	ret

0000000080001910 <_ZL8consumerPv>:

static void consumer(void *arg) {
    80001910:	fd010113          	addi	sp,sp,-48
    80001914:	02113423          	sd	ra,40(sp)
    80001918:	02813023          	sd	s0,32(sp)
    8000191c:	00913c23          	sd	s1,24(sp)
    80001920:	01213823          	sd	s2,16(sp)
    80001924:	01313423          	sd	s3,8(sp)
    80001928:	03010413          	addi	s0,sp,48
    8000192c:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80001930:	00000993          	li	s3,0
    80001934:	01c0006f          	j	80001950 <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    80001938:	00000097          	auipc	ra,0x0
    8000193c:	c2c080e7          	jalr	-980(ra) # 80001564 <_Z15thread_dispatchv>
    80001940:	0500006f          	j	80001990 <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    80001944:	00a00513          	li	a0,10
    80001948:	00000097          	auipc	ra,0x0
    8000194c:	e38080e7          	jalr	-456(ra) # 80001780 <_Z4putcc>
    while (!threadEnd) {
    80001950:	0000a797          	auipc	a5,0xa
    80001954:	e507a783          	lw	a5,-432(a5) # 8000b7a0 <_ZL9threadEnd>
    80001958:	06079063          	bnez	a5,800019b8 <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    8000195c:	00893503          	ld	a0,8(s2)
    80001960:	00005097          	auipc	ra,0x5
    80001964:	934080e7          	jalr	-1740(ra) # 80006294 <_ZN6Buffer3getEv>
        i++;
    80001968:	0019849b          	addiw	s1,s3,1
    8000196c:	0004899b          	sext.w	s3,s1
        putc(key);
    80001970:	0ff57513          	andi	a0,a0,255
    80001974:	00000097          	auipc	ra,0x0
    80001978:	e0c080e7          	jalr	-500(ra) # 80001780 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    8000197c:	00092703          	lw	a4,0(s2)
    80001980:	0027179b          	slliw	a5,a4,0x2
    80001984:	00e787bb          	addw	a5,a5,a4
    80001988:	02f4e7bb          	remw	a5,s1,a5
    8000198c:	fa0786e3          	beqz	a5,80001938 <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    80001990:	05000793          	li	a5,80
    80001994:	02f4e4bb          	remw	s1,s1,a5
    80001998:	fa049ce3          	bnez	s1,80001950 <_ZL8consumerPv+0x40>
    8000199c:	fa9ff06f          	j	80001944 <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    800019a0:	00893503          	ld	a0,8(s2)
    800019a4:	00005097          	auipc	ra,0x5
    800019a8:	8f0080e7          	jalr	-1808(ra) # 80006294 <_ZN6Buffer3getEv>
        putc(key);
    800019ac:	0ff57513          	andi	a0,a0,255
    800019b0:	00000097          	auipc	ra,0x0
    800019b4:	dd0080e7          	jalr	-560(ra) # 80001780 <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    800019b8:	00893503          	ld	a0,8(s2)
    800019bc:	00005097          	auipc	ra,0x5
    800019c0:	964080e7          	jalr	-1692(ra) # 80006320 <_ZN6Buffer6getCntEv>
    800019c4:	fca04ee3          	bgtz	a0,800019a0 <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    800019c8:	01093503          	ld	a0,16(s2)
    800019cc:	00000097          	auipc	ra,0x0
    800019d0:	d2c080e7          	jalr	-724(ra) # 800016f8 <_Z10sem_signalP3Sem>
}
    800019d4:	02813083          	ld	ra,40(sp)
    800019d8:	02013403          	ld	s0,32(sp)
    800019dc:	01813483          	ld	s1,24(sp)
    800019e0:	01013903          	ld	s2,16(sp)
    800019e4:	00813983          	ld	s3,8(sp)
    800019e8:	03010113          	addi	sp,sp,48
    800019ec:	00008067          	ret

00000000800019f0 <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    800019f0:	f9010113          	addi	sp,sp,-112
    800019f4:	06113423          	sd	ra,104(sp)
    800019f8:	06813023          	sd	s0,96(sp)
    800019fc:	04913c23          	sd	s1,88(sp)
    80001a00:	05213823          	sd	s2,80(sp)
    80001a04:	05313423          	sd	s3,72(sp)
    80001a08:	05413023          	sd	s4,64(sp)
    80001a0c:	03513c23          	sd	s5,56(sp)
    80001a10:	03613823          	sd	s6,48(sp)
    80001a14:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    80001a18:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    80001a1c:	00007517          	auipc	a0,0x7
    80001a20:	60450513          	addi	a0,a0,1540 # 80009020 <CONSOLE_STATUS+0x10>
    80001a24:	00002097          	auipc	ra,0x2
    80001a28:	5e8080e7          	jalr	1512(ra) # 8000400c <_Z11printStringPKc>
    getString(input, 30);
    80001a2c:	01e00593          	li	a1,30
    80001a30:	fa040493          	addi	s1,s0,-96
    80001a34:	00048513          	mv	a0,s1
    80001a38:	00002097          	auipc	ra,0x2
    80001a3c:	65c080e7          	jalr	1628(ra) # 80004094 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80001a40:	00048513          	mv	a0,s1
    80001a44:	00002097          	auipc	ra,0x2
    80001a48:	728080e7          	jalr	1832(ra) # 8000416c <_Z11stringToIntPKc>
    80001a4c:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80001a50:	00007517          	auipc	a0,0x7
    80001a54:	5f050513          	addi	a0,a0,1520 # 80009040 <CONSOLE_STATUS+0x30>
    80001a58:	00002097          	auipc	ra,0x2
    80001a5c:	5b4080e7          	jalr	1460(ra) # 8000400c <_Z11printStringPKc>
    getString(input, 30);
    80001a60:	01e00593          	li	a1,30
    80001a64:	00048513          	mv	a0,s1
    80001a68:	00002097          	auipc	ra,0x2
    80001a6c:	62c080e7          	jalr	1580(ra) # 80004094 <_Z9getStringPci>
    n = stringToInt(input);
    80001a70:	00048513          	mv	a0,s1
    80001a74:	00002097          	auipc	ra,0x2
    80001a78:	6f8080e7          	jalr	1784(ra) # 8000416c <_Z11stringToIntPKc>
    80001a7c:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80001a80:	00007517          	auipc	a0,0x7
    80001a84:	5e050513          	addi	a0,a0,1504 # 80009060 <CONSOLE_STATUS+0x50>
    80001a88:	00002097          	auipc	ra,0x2
    80001a8c:	584080e7          	jalr	1412(ra) # 8000400c <_Z11printStringPKc>
    80001a90:	00000613          	li	a2,0
    80001a94:	00a00593          	li	a1,10
    80001a98:	00090513          	mv	a0,s2
    80001a9c:	00002097          	auipc	ra,0x2
    80001aa0:	720080e7          	jalr	1824(ra) # 800041bc <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80001aa4:	00007517          	auipc	a0,0x7
    80001aa8:	5d450513          	addi	a0,a0,1492 # 80009078 <CONSOLE_STATUS+0x68>
    80001aac:	00002097          	auipc	ra,0x2
    80001ab0:	560080e7          	jalr	1376(ra) # 8000400c <_Z11printStringPKc>
    80001ab4:	00000613          	li	a2,0
    80001ab8:	00a00593          	li	a1,10
    80001abc:	00048513          	mv	a0,s1
    80001ac0:	00002097          	auipc	ra,0x2
    80001ac4:	6fc080e7          	jalr	1788(ra) # 800041bc <_Z8printIntiii>
    printString(".\n");
    80001ac8:	00007517          	auipc	a0,0x7
    80001acc:	5c850513          	addi	a0,a0,1480 # 80009090 <CONSOLE_STATUS+0x80>
    80001ad0:	00002097          	auipc	ra,0x2
    80001ad4:	53c080e7          	jalr	1340(ra) # 8000400c <_Z11printStringPKc>
    if(threadNum > n) {
    80001ad8:	0324c463          	blt	s1,s2,80001b00 <_Z22producerConsumer_C_APIv+0x110>
    } else if (threadNum < 1) {
    80001adc:	03205c63          	blez	s2,80001b14 <_Z22producerConsumer_C_APIv+0x124>
    Buffer *buffer = new Buffer(n);
    80001ae0:	03800513          	li	a0,56
    80001ae4:	00003097          	auipc	ra,0x3
    80001ae8:	3e4080e7          	jalr	996(ra) # 80004ec8 <_Znwm>
    80001aec:	00050a13          	mv	s4,a0
    80001af0:	00048593          	mv	a1,s1
    80001af4:	00004097          	auipc	ra,0x4
    80001af8:	674080e7          	jalr	1652(ra) # 80006168 <_ZN6BufferC1Ei>
    80001afc:	0300006f          	j	80001b2c <_Z22producerConsumer_C_APIv+0x13c>
        printString("Broj proizvodjaca ne sme biti veci od velicine bafera!\n");
    80001b00:	00007517          	auipc	a0,0x7
    80001b04:	59850513          	addi	a0,a0,1432 # 80009098 <CONSOLE_STATUS+0x88>
    80001b08:	00002097          	auipc	ra,0x2
    80001b0c:	504080e7          	jalr	1284(ra) # 8000400c <_Z11printStringPKc>
        return;
    80001b10:	0140006f          	j	80001b24 <_Z22producerConsumer_C_APIv+0x134>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80001b14:	00007517          	auipc	a0,0x7
    80001b18:	5bc50513          	addi	a0,a0,1468 # 800090d0 <CONSOLE_STATUS+0xc0>
    80001b1c:	00002097          	auipc	ra,0x2
    80001b20:	4f0080e7          	jalr	1264(ra) # 8000400c <_Z11printStringPKc>
        return;
    80001b24:	000b0113          	mv	sp,s6
    80001b28:	1500006f          	j	80001c78 <_Z22producerConsumer_C_APIv+0x288>
    sem_open(&waitForAll, 0);
    80001b2c:	00000593          	li	a1,0
    80001b30:	0000a517          	auipc	a0,0xa
    80001b34:	c7850513          	addi	a0,a0,-904 # 8000b7a8 <_ZL10waitForAll>
    80001b38:	00000097          	auipc	ra,0x0
    80001b3c:	b0c080e7          	jalr	-1268(ra) # 80001644 <_Z8sem_openPP3Semj>
    thread_t threads[threadNum];
    80001b40:	00391793          	slli	a5,s2,0x3
    80001b44:	00f78793          	addi	a5,a5,15
    80001b48:	ff07f793          	andi	a5,a5,-16
    80001b4c:	40f10133          	sub	sp,sp,a5
    80001b50:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    80001b54:	0019071b          	addiw	a4,s2,1
    80001b58:	00171793          	slli	a5,a4,0x1
    80001b5c:	00e787b3          	add	a5,a5,a4
    80001b60:	00379793          	slli	a5,a5,0x3
    80001b64:	00f78793          	addi	a5,a5,15
    80001b68:	ff07f793          	andi	a5,a5,-16
    80001b6c:	40f10133          	sub	sp,sp,a5
    80001b70:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    80001b74:	00191613          	slli	a2,s2,0x1
    80001b78:	012607b3          	add	a5,a2,s2
    80001b7c:	00379793          	slli	a5,a5,0x3
    80001b80:	00f987b3          	add	a5,s3,a5
    80001b84:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80001b88:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    80001b8c:	0000a717          	auipc	a4,0xa
    80001b90:	c1c73703          	ld	a4,-996(a4) # 8000b7a8 <_ZL10waitForAll>
    80001b94:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    80001b98:	00078613          	mv	a2,a5
    80001b9c:	00000597          	auipc	a1,0x0
    80001ba0:	d7458593          	addi	a1,a1,-652 # 80001910 <_ZL8consumerPv>
    80001ba4:	f9840513          	addi	a0,s0,-104
    80001ba8:	00000097          	auipc	ra,0x0
    80001bac:	860080e7          	jalr	-1952(ra) # 80001408 <_Z13thread_createPP3PCBPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80001bb0:	00000493          	li	s1,0
    80001bb4:	0280006f          	j	80001bdc <_Z22producerConsumer_C_APIv+0x1ec>
        thread_create(threads + i,
    80001bb8:	00000597          	auipc	a1,0x0
    80001bbc:	c1458593          	addi	a1,a1,-1004 # 800017cc <_ZL16producerKeyboardPv>
                      data + i);
    80001bc0:	00179613          	slli	a2,a5,0x1
    80001bc4:	00f60633          	add	a2,a2,a5
    80001bc8:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    80001bcc:	00c98633          	add	a2,s3,a2
    80001bd0:	00000097          	auipc	ra,0x0
    80001bd4:	838080e7          	jalr	-1992(ra) # 80001408 <_Z13thread_createPP3PCBPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80001bd8:	0014849b          	addiw	s1,s1,1
    80001bdc:	0524d263          	bge	s1,s2,80001c20 <_Z22producerConsumer_C_APIv+0x230>
        data[i].id = i;
    80001be0:	00149793          	slli	a5,s1,0x1
    80001be4:	009787b3          	add	a5,a5,s1
    80001be8:	00379793          	slli	a5,a5,0x3
    80001bec:	00f987b3          	add	a5,s3,a5
    80001bf0:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80001bf4:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    80001bf8:	0000a717          	auipc	a4,0xa
    80001bfc:	bb073703          	ld	a4,-1104(a4) # 8000b7a8 <_ZL10waitForAll>
    80001c00:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    80001c04:	00048793          	mv	a5,s1
    80001c08:	00349513          	slli	a0,s1,0x3
    80001c0c:	00aa8533          	add	a0,s5,a0
    80001c10:	fa9054e3          	blez	s1,80001bb8 <_Z22producerConsumer_C_APIv+0x1c8>
    80001c14:	00000597          	auipc	a1,0x0
    80001c18:	c6858593          	addi	a1,a1,-920 # 8000187c <_ZL8producerPv>
    80001c1c:	fa5ff06f          	j	80001bc0 <_Z22producerConsumer_C_APIv+0x1d0>
    thread_dispatch();
    80001c20:	00000097          	auipc	ra,0x0
    80001c24:	944080e7          	jalr	-1724(ra) # 80001564 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80001c28:	00000493          	li	s1,0
    80001c2c:	00994e63          	blt	s2,s1,80001c48 <_Z22producerConsumer_C_APIv+0x258>
        sem_wait(waitForAll);
    80001c30:	0000a517          	auipc	a0,0xa
    80001c34:	b7853503          	ld	a0,-1160(a0) # 8000b7a8 <_ZL10waitForAll>
    80001c38:	00000097          	auipc	ra,0x0
    80001c3c:	a88080e7          	jalr	-1400(ra) # 800016c0 <_Z8sem_waitP3Sem>
    for (int i = 0; i <= threadNum; i++) {
    80001c40:	0014849b          	addiw	s1,s1,1
    80001c44:	fe9ff06f          	j	80001c2c <_Z22producerConsumer_C_APIv+0x23c>
    sem_close(waitForAll);
    80001c48:	0000a517          	auipc	a0,0xa
    80001c4c:	b6053503          	ld	a0,-1184(a0) # 8000b7a8 <_ZL10waitForAll>
    80001c50:	00000097          	auipc	ra,0x0
    80001c54:	a38080e7          	jalr	-1480(ra) # 80001688 <_Z9sem_closeP3Sem>
    delete buffer;
    80001c58:	000a0e63          	beqz	s4,80001c74 <_Z22producerConsumer_C_APIv+0x284>
    80001c5c:	000a0513          	mv	a0,s4
    80001c60:	00004097          	auipc	ra,0x4
    80001c64:	748080e7          	jalr	1864(ra) # 800063a8 <_ZN6BufferD1Ev>
    80001c68:	000a0513          	mv	a0,s4
    80001c6c:	00003097          	auipc	ra,0x3
    80001c70:	2dc080e7          	jalr	732(ra) # 80004f48 <_ZdlPv>
    80001c74:	000b0113          	mv	sp,s6

}
    80001c78:	f9040113          	addi	sp,s0,-112
    80001c7c:	06813083          	ld	ra,104(sp)
    80001c80:	06013403          	ld	s0,96(sp)
    80001c84:	05813483          	ld	s1,88(sp)
    80001c88:	05013903          	ld	s2,80(sp)
    80001c8c:	04813983          	ld	s3,72(sp)
    80001c90:	04013a03          	ld	s4,64(sp)
    80001c94:	03813a83          	ld	s5,56(sp)
    80001c98:	03013b03          	ld	s6,48(sp)
    80001c9c:	07010113          	addi	sp,sp,112
    80001ca0:	00008067          	ret
    80001ca4:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    80001ca8:	000a0513          	mv	a0,s4
    80001cac:	00003097          	auipc	ra,0x3
    80001cb0:	29c080e7          	jalr	668(ra) # 80004f48 <_ZdlPv>
    80001cb4:	00048513          	mv	a0,s1
    80001cb8:	0000b097          	auipc	ra,0xb
    80001cbc:	c70080e7          	jalr	-912(ra) # 8000c928 <_Unwind_Resume>

0000000080001cc0 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80001cc0:	fe010113          	addi	sp,sp,-32
    80001cc4:	00113c23          	sd	ra,24(sp)
    80001cc8:	00813823          	sd	s0,16(sp)
    80001ccc:	00913423          	sd	s1,8(sp)
    80001cd0:	01213023          	sd	s2,0(sp)
    80001cd4:	02010413          	addi	s0,sp,32
    80001cd8:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80001cdc:	00100793          	li	a5,1
    80001ce0:	02a7f863          	bgeu	a5,a0,80001d10 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80001ce4:	00a00793          	li	a5,10
    80001ce8:	02f577b3          	remu	a5,a0,a5
    80001cec:	02078e63          	beqz	a5,80001d28 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80001cf0:	fff48513          	addi	a0,s1,-1
    80001cf4:	00000097          	auipc	ra,0x0
    80001cf8:	fcc080e7          	jalr	-52(ra) # 80001cc0 <_ZL9fibonaccim>
    80001cfc:	00050913          	mv	s2,a0
    80001d00:	ffe48513          	addi	a0,s1,-2
    80001d04:	00000097          	auipc	ra,0x0
    80001d08:	fbc080e7          	jalr	-68(ra) # 80001cc0 <_ZL9fibonaccim>
    80001d0c:	00a90533          	add	a0,s2,a0
}
    80001d10:	01813083          	ld	ra,24(sp)
    80001d14:	01013403          	ld	s0,16(sp)
    80001d18:	00813483          	ld	s1,8(sp)
    80001d1c:	00013903          	ld	s2,0(sp)
    80001d20:	02010113          	addi	sp,sp,32
    80001d24:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80001d28:	00000097          	auipc	ra,0x0
    80001d2c:	83c080e7          	jalr	-1988(ra) # 80001564 <_Z15thread_dispatchv>
    80001d30:	fc1ff06f          	j	80001cf0 <_ZL9fibonaccim+0x30>

0000000080001d34 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80001d34:	fe010113          	addi	sp,sp,-32
    80001d38:	00113c23          	sd	ra,24(sp)
    80001d3c:	00813823          	sd	s0,16(sp)
    80001d40:	00913423          	sd	s1,8(sp)
    80001d44:	01213023          	sd	s2,0(sp)
    80001d48:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80001d4c:	00000913          	li	s2,0
    80001d50:	0380006f          	j	80001d88 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80001d54:	00000097          	auipc	ra,0x0
    80001d58:	810080e7          	jalr	-2032(ra) # 80001564 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80001d5c:	00148493          	addi	s1,s1,1
    80001d60:	000027b7          	lui	a5,0x2
    80001d64:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001d68:	0097ee63          	bltu	a5,s1,80001d84 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80001d6c:	00000713          	li	a4,0
    80001d70:	000077b7          	lui	a5,0x7
    80001d74:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001d78:	fce7eee3          	bltu	a5,a4,80001d54 <_ZN7WorkerA11workerBodyAEPv+0x20>
    80001d7c:	00170713          	addi	a4,a4,1
    80001d80:	ff1ff06f          	j	80001d70 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80001d84:	00190913          	addi	s2,s2,1
    80001d88:	00900793          	li	a5,9
    80001d8c:	0527e063          	bltu	a5,s2,80001dcc <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80001d90:	00007517          	auipc	a0,0x7
    80001d94:	37050513          	addi	a0,a0,880 # 80009100 <CONSOLE_STATUS+0xf0>
    80001d98:	00002097          	auipc	ra,0x2
    80001d9c:	274080e7          	jalr	628(ra) # 8000400c <_Z11printStringPKc>
    80001da0:	00000613          	li	a2,0
    80001da4:	00a00593          	li	a1,10
    80001da8:	0009051b          	sext.w	a0,s2
    80001dac:	00002097          	auipc	ra,0x2
    80001db0:	410080e7          	jalr	1040(ra) # 800041bc <_Z8printIntiii>
    80001db4:	00007517          	auipc	a0,0x7
    80001db8:	4a450513          	addi	a0,a0,1188 # 80009258 <CONSOLE_STATUS+0x248>
    80001dbc:	00002097          	auipc	ra,0x2
    80001dc0:	250080e7          	jalr	592(ra) # 8000400c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001dc4:	00000493          	li	s1,0
    80001dc8:	f99ff06f          	j	80001d60 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    80001dcc:	00007517          	auipc	a0,0x7
    80001dd0:	33c50513          	addi	a0,a0,828 # 80009108 <CONSOLE_STATUS+0xf8>
    80001dd4:	00002097          	auipc	ra,0x2
    80001dd8:	238080e7          	jalr	568(ra) # 8000400c <_Z11printStringPKc>
    finishedA = true;
    80001ddc:	00100793          	li	a5,1
    80001de0:	0000a717          	auipc	a4,0xa
    80001de4:	9cf70823          	sb	a5,-1584(a4) # 8000b7b0 <_ZL9finishedA>
}
    80001de8:	01813083          	ld	ra,24(sp)
    80001dec:	01013403          	ld	s0,16(sp)
    80001df0:	00813483          	ld	s1,8(sp)
    80001df4:	00013903          	ld	s2,0(sp)
    80001df8:	02010113          	addi	sp,sp,32
    80001dfc:	00008067          	ret

0000000080001e00 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80001e00:	fe010113          	addi	sp,sp,-32
    80001e04:	00113c23          	sd	ra,24(sp)
    80001e08:	00813823          	sd	s0,16(sp)
    80001e0c:	00913423          	sd	s1,8(sp)
    80001e10:	01213023          	sd	s2,0(sp)
    80001e14:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80001e18:	00000913          	li	s2,0
    80001e1c:	0380006f          	j	80001e54 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80001e20:	fffff097          	auipc	ra,0xfffff
    80001e24:	744080e7          	jalr	1860(ra) # 80001564 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80001e28:	00148493          	addi	s1,s1,1
    80001e2c:	000027b7          	lui	a5,0x2
    80001e30:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001e34:	0097ee63          	bltu	a5,s1,80001e50 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80001e38:	00000713          	li	a4,0
    80001e3c:	000077b7          	lui	a5,0x7
    80001e40:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001e44:	fce7eee3          	bltu	a5,a4,80001e20 <_ZN7WorkerB11workerBodyBEPv+0x20>
    80001e48:	00170713          	addi	a4,a4,1
    80001e4c:	ff1ff06f          	j	80001e3c <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80001e50:	00190913          	addi	s2,s2,1
    80001e54:	00f00793          	li	a5,15
    80001e58:	0527e063          	bltu	a5,s2,80001e98 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80001e5c:	00007517          	auipc	a0,0x7
    80001e60:	2bc50513          	addi	a0,a0,700 # 80009118 <CONSOLE_STATUS+0x108>
    80001e64:	00002097          	auipc	ra,0x2
    80001e68:	1a8080e7          	jalr	424(ra) # 8000400c <_Z11printStringPKc>
    80001e6c:	00000613          	li	a2,0
    80001e70:	00a00593          	li	a1,10
    80001e74:	0009051b          	sext.w	a0,s2
    80001e78:	00002097          	auipc	ra,0x2
    80001e7c:	344080e7          	jalr	836(ra) # 800041bc <_Z8printIntiii>
    80001e80:	00007517          	auipc	a0,0x7
    80001e84:	3d850513          	addi	a0,a0,984 # 80009258 <CONSOLE_STATUS+0x248>
    80001e88:	00002097          	auipc	ra,0x2
    80001e8c:	184080e7          	jalr	388(ra) # 8000400c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001e90:	00000493          	li	s1,0
    80001e94:	f99ff06f          	j	80001e2c <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80001e98:	00007517          	auipc	a0,0x7
    80001e9c:	28850513          	addi	a0,a0,648 # 80009120 <CONSOLE_STATUS+0x110>
    80001ea0:	00002097          	auipc	ra,0x2
    80001ea4:	16c080e7          	jalr	364(ra) # 8000400c <_Z11printStringPKc>
    finishedB = true;
    80001ea8:	00100793          	li	a5,1
    80001eac:	0000a717          	auipc	a4,0xa
    80001eb0:	90f702a3          	sb	a5,-1787(a4) # 8000b7b1 <_ZL9finishedB>
    thread_dispatch();
    80001eb4:	fffff097          	auipc	ra,0xfffff
    80001eb8:	6b0080e7          	jalr	1712(ra) # 80001564 <_Z15thread_dispatchv>
}
    80001ebc:	01813083          	ld	ra,24(sp)
    80001ec0:	01013403          	ld	s0,16(sp)
    80001ec4:	00813483          	ld	s1,8(sp)
    80001ec8:	00013903          	ld	s2,0(sp)
    80001ecc:	02010113          	addi	sp,sp,32
    80001ed0:	00008067          	ret

0000000080001ed4 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80001ed4:	fe010113          	addi	sp,sp,-32
    80001ed8:	00113c23          	sd	ra,24(sp)
    80001edc:	00813823          	sd	s0,16(sp)
    80001ee0:	00913423          	sd	s1,8(sp)
    80001ee4:	01213023          	sd	s2,0(sp)
    80001ee8:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80001eec:	00000493          	li	s1,0
    80001ef0:	0400006f          	j	80001f30 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80001ef4:	00007517          	auipc	a0,0x7
    80001ef8:	23c50513          	addi	a0,a0,572 # 80009130 <CONSOLE_STATUS+0x120>
    80001efc:	00002097          	auipc	ra,0x2
    80001f00:	110080e7          	jalr	272(ra) # 8000400c <_Z11printStringPKc>
    80001f04:	00000613          	li	a2,0
    80001f08:	00a00593          	li	a1,10
    80001f0c:	00048513          	mv	a0,s1
    80001f10:	00002097          	auipc	ra,0x2
    80001f14:	2ac080e7          	jalr	684(ra) # 800041bc <_Z8printIntiii>
    80001f18:	00007517          	auipc	a0,0x7
    80001f1c:	34050513          	addi	a0,a0,832 # 80009258 <CONSOLE_STATUS+0x248>
    80001f20:	00002097          	auipc	ra,0x2
    80001f24:	0ec080e7          	jalr	236(ra) # 8000400c <_Z11printStringPKc>
    for (; i < 3; i++) {
    80001f28:	0014849b          	addiw	s1,s1,1
    80001f2c:	0ff4f493          	andi	s1,s1,255
    80001f30:	00200793          	li	a5,2
    80001f34:	fc97f0e3          	bgeu	a5,s1,80001ef4 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80001f38:	00007517          	auipc	a0,0x7
    80001f3c:	20050513          	addi	a0,a0,512 # 80009138 <CONSOLE_STATUS+0x128>
    80001f40:	00002097          	auipc	ra,0x2
    80001f44:	0cc080e7          	jalr	204(ra) # 8000400c <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80001f48:	00700313          	li	t1,7
    thread_dispatch();
    80001f4c:	fffff097          	auipc	ra,0xfffff
    80001f50:	618080e7          	jalr	1560(ra) # 80001564 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80001f54:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80001f58:	00007517          	auipc	a0,0x7
    80001f5c:	1f050513          	addi	a0,a0,496 # 80009148 <CONSOLE_STATUS+0x138>
    80001f60:	00002097          	auipc	ra,0x2
    80001f64:	0ac080e7          	jalr	172(ra) # 8000400c <_Z11printStringPKc>
    80001f68:	00000613          	li	a2,0
    80001f6c:	00a00593          	li	a1,10
    80001f70:	0009051b          	sext.w	a0,s2
    80001f74:	00002097          	auipc	ra,0x2
    80001f78:	248080e7          	jalr	584(ra) # 800041bc <_Z8printIntiii>
    80001f7c:	00007517          	auipc	a0,0x7
    80001f80:	2dc50513          	addi	a0,a0,732 # 80009258 <CONSOLE_STATUS+0x248>
    80001f84:	00002097          	auipc	ra,0x2
    80001f88:	088080e7          	jalr	136(ra) # 8000400c <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80001f8c:	00c00513          	li	a0,12
    80001f90:	00000097          	auipc	ra,0x0
    80001f94:	d30080e7          	jalr	-720(ra) # 80001cc0 <_ZL9fibonaccim>
    80001f98:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80001f9c:	00007517          	auipc	a0,0x7
    80001fa0:	1b450513          	addi	a0,a0,436 # 80009150 <CONSOLE_STATUS+0x140>
    80001fa4:	00002097          	auipc	ra,0x2
    80001fa8:	068080e7          	jalr	104(ra) # 8000400c <_Z11printStringPKc>
    80001fac:	00000613          	li	a2,0
    80001fb0:	00a00593          	li	a1,10
    80001fb4:	0009051b          	sext.w	a0,s2
    80001fb8:	00002097          	auipc	ra,0x2
    80001fbc:	204080e7          	jalr	516(ra) # 800041bc <_Z8printIntiii>
    80001fc0:	00007517          	auipc	a0,0x7
    80001fc4:	29850513          	addi	a0,a0,664 # 80009258 <CONSOLE_STATUS+0x248>
    80001fc8:	00002097          	auipc	ra,0x2
    80001fcc:	044080e7          	jalr	68(ra) # 8000400c <_Z11printStringPKc>
    80001fd0:	0400006f          	j	80002010 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80001fd4:	00007517          	auipc	a0,0x7
    80001fd8:	15c50513          	addi	a0,a0,348 # 80009130 <CONSOLE_STATUS+0x120>
    80001fdc:	00002097          	auipc	ra,0x2
    80001fe0:	030080e7          	jalr	48(ra) # 8000400c <_Z11printStringPKc>
    80001fe4:	00000613          	li	a2,0
    80001fe8:	00a00593          	li	a1,10
    80001fec:	00048513          	mv	a0,s1
    80001ff0:	00002097          	auipc	ra,0x2
    80001ff4:	1cc080e7          	jalr	460(ra) # 800041bc <_Z8printIntiii>
    80001ff8:	00007517          	auipc	a0,0x7
    80001ffc:	26050513          	addi	a0,a0,608 # 80009258 <CONSOLE_STATUS+0x248>
    80002000:	00002097          	auipc	ra,0x2
    80002004:	00c080e7          	jalr	12(ra) # 8000400c <_Z11printStringPKc>
    for (; i < 6; i++) {
    80002008:	0014849b          	addiw	s1,s1,1
    8000200c:	0ff4f493          	andi	s1,s1,255
    80002010:	00500793          	li	a5,5
    80002014:	fc97f0e3          	bgeu	a5,s1,80001fd4 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    80002018:	00007517          	auipc	a0,0x7
    8000201c:	0f050513          	addi	a0,a0,240 # 80009108 <CONSOLE_STATUS+0xf8>
    80002020:	00002097          	auipc	ra,0x2
    80002024:	fec080e7          	jalr	-20(ra) # 8000400c <_Z11printStringPKc>
    finishedC = true;
    80002028:	00100793          	li	a5,1
    8000202c:	00009717          	auipc	a4,0x9
    80002030:	78f70323          	sb	a5,1926(a4) # 8000b7b2 <_ZL9finishedC>
    thread_dispatch();
    80002034:	fffff097          	auipc	ra,0xfffff
    80002038:	530080e7          	jalr	1328(ra) # 80001564 <_Z15thread_dispatchv>
}
    8000203c:	01813083          	ld	ra,24(sp)
    80002040:	01013403          	ld	s0,16(sp)
    80002044:	00813483          	ld	s1,8(sp)
    80002048:	00013903          	ld	s2,0(sp)
    8000204c:	02010113          	addi	sp,sp,32
    80002050:	00008067          	ret

0000000080002054 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80002054:	fe010113          	addi	sp,sp,-32
    80002058:	00113c23          	sd	ra,24(sp)
    8000205c:	00813823          	sd	s0,16(sp)
    80002060:	00913423          	sd	s1,8(sp)
    80002064:	01213023          	sd	s2,0(sp)
    80002068:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    8000206c:	00a00493          	li	s1,10
    80002070:	0400006f          	j	800020b0 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002074:	00007517          	auipc	a0,0x7
    80002078:	0ec50513          	addi	a0,a0,236 # 80009160 <CONSOLE_STATUS+0x150>
    8000207c:	00002097          	auipc	ra,0x2
    80002080:	f90080e7          	jalr	-112(ra) # 8000400c <_Z11printStringPKc>
    80002084:	00000613          	li	a2,0
    80002088:	00a00593          	li	a1,10
    8000208c:	00048513          	mv	a0,s1
    80002090:	00002097          	auipc	ra,0x2
    80002094:	12c080e7          	jalr	300(ra) # 800041bc <_Z8printIntiii>
    80002098:	00007517          	auipc	a0,0x7
    8000209c:	1c050513          	addi	a0,a0,448 # 80009258 <CONSOLE_STATUS+0x248>
    800020a0:	00002097          	auipc	ra,0x2
    800020a4:	f6c080e7          	jalr	-148(ra) # 8000400c <_Z11printStringPKc>
    for (; i < 13; i++) {
    800020a8:	0014849b          	addiw	s1,s1,1
    800020ac:	0ff4f493          	andi	s1,s1,255
    800020b0:	00c00793          	li	a5,12
    800020b4:	fc97f0e3          	bgeu	a5,s1,80002074 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    800020b8:	00007517          	auipc	a0,0x7
    800020bc:	0b050513          	addi	a0,a0,176 # 80009168 <CONSOLE_STATUS+0x158>
    800020c0:	00002097          	auipc	ra,0x2
    800020c4:	f4c080e7          	jalr	-180(ra) # 8000400c <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    800020c8:	00500313          	li	t1,5
    thread_dispatch();
    800020cc:	fffff097          	auipc	ra,0xfffff
    800020d0:	498080e7          	jalr	1176(ra) # 80001564 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    800020d4:	01000513          	li	a0,16
    800020d8:	00000097          	auipc	ra,0x0
    800020dc:	be8080e7          	jalr	-1048(ra) # 80001cc0 <_ZL9fibonaccim>
    800020e0:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800020e4:	00007517          	auipc	a0,0x7
    800020e8:	09450513          	addi	a0,a0,148 # 80009178 <CONSOLE_STATUS+0x168>
    800020ec:	00002097          	auipc	ra,0x2
    800020f0:	f20080e7          	jalr	-224(ra) # 8000400c <_Z11printStringPKc>
    800020f4:	00000613          	li	a2,0
    800020f8:	00a00593          	li	a1,10
    800020fc:	0009051b          	sext.w	a0,s2
    80002100:	00002097          	auipc	ra,0x2
    80002104:	0bc080e7          	jalr	188(ra) # 800041bc <_Z8printIntiii>
    80002108:	00007517          	auipc	a0,0x7
    8000210c:	15050513          	addi	a0,a0,336 # 80009258 <CONSOLE_STATUS+0x248>
    80002110:	00002097          	auipc	ra,0x2
    80002114:	efc080e7          	jalr	-260(ra) # 8000400c <_Z11printStringPKc>
    80002118:	0400006f          	j	80002158 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000211c:	00007517          	auipc	a0,0x7
    80002120:	04450513          	addi	a0,a0,68 # 80009160 <CONSOLE_STATUS+0x150>
    80002124:	00002097          	auipc	ra,0x2
    80002128:	ee8080e7          	jalr	-280(ra) # 8000400c <_Z11printStringPKc>
    8000212c:	00000613          	li	a2,0
    80002130:	00a00593          	li	a1,10
    80002134:	00048513          	mv	a0,s1
    80002138:	00002097          	auipc	ra,0x2
    8000213c:	084080e7          	jalr	132(ra) # 800041bc <_Z8printIntiii>
    80002140:	00007517          	auipc	a0,0x7
    80002144:	11850513          	addi	a0,a0,280 # 80009258 <CONSOLE_STATUS+0x248>
    80002148:	00002097          	auipc	ra,0x2
    8000214c:	ec4080e7          	jalr	-316(ra) # 8000400c <_Z11printStringPKc>
    for (; i < 16; i++) {
    80002150:	0014849b          	addiw	s1,s1,1
    80002154:	0ff4f493          	andi	s1,s1,255
    80002158:	00f00793          	li	a5,15
    8000215c:	fc97f0e3          	bgeu	a5,s1,8000211c <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    80002160:	00007517          	auipc	a0,0x7
    80002164:	02850513          	addi	a0,a0,40 # 80009188 <CONSOLE_STATUS+0x178>
    80002168:	00002097          	auipc	ra,0x2
    8000216c:	ea4080e7          	jalr	-348(ra) # 8000400c <_Z11printStringPKc>
    finishedD = true;
    80002170:	00100793          	li	a5,1
    80002174:	00009717          	auipc	a4,0x9
    80002178:	62f70fa3          	sb	a5,1599(a4) # 8000b7b3 <_ZL9finishedD>
    thread_dispatch();
    8000217c:	fffff097          	auipc	ra,0xfffff
    80002180:	3e8080e7          	jalr	1000(ra) # 80001564 <_Z15thread_dispatchv>
}
    80002184:	01813083          	ld	ra,24(sp)
    80002188:	01013403          	ld	s0,16(sp)
    8000218c:	00813483          	ld	s1,8(sp)
    80002190:	00013903          	ld	s2,0(sp)
    80002194:	02010113          	addi	sp,sp,32
    80002198:	00008067          	ret

000000008000219c <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    8000219c:	fc010113          	addi	sp,sp,-64
    800021a0:	02113c23          	sd	ra,56(sp)
    800021a4:	02813823          	sd	s0,48(sp)
    800021a8:	02913423          	sd	s1,40(sp)
    800021ac:	03213023          	sd	s2,32(sp)
    800021b0:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    800021b4:	02000513          	li	a0,32
    800021b8:	00003097          	auipc	ra,0x3
    800021bc:	d10080e7          	jalr	-752(ra) # 80004ec8 <_Znwm>
    800021c0:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    800021c4:	00003097          	auipc	ra,0x3
    800021c8:	f48080e7          	jalr	-184(ra) # 8000510c <_ZN6ThreadC1Ev>
    800021cc:	00009797          	auipc	a5,0x9
    800021d0:	32c78793          	addi	a5,a5,812 # 8000b4f8 <_ZTV7WorkerA+0x10>
    800021d4:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    800021d8:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    800021dc:	00007517          	auipc	a0,0x7
    800021e0:	fbc50513          	addi	a0,a0,-68 # 80009198 <CONSOLE_STATUS+0x188>
    800021e4:	00002097          	auipc	ra,0x2
    800021e8:	e28080e7          	jalr	-472(ra) # 8000400c <_Z11printStringPKc>

    threads[1] = new WorkerB();
    800021ec:	02000513          	li	a0,32
    800021f0:	00003097          	auipc	ra,0x3
    800021f4:	cd8080e7          	jalr	-808(ra) # 80004ec8 <_Znwm>
    800021f8:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    800021fc:	00003097          	auipc	ra,0x3
    80002200:	f10080e7          	jalr	-240(ra) # 8000510c <_ZN6ThreadC1Ev>
    80002204:	00009797          	auipc	a5,0x9
    80002208:	31c78793          	addi	a5,a5,796 # 8000b520 <_ZTV7WorkerB+0x10>
    8000220c:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    80002210:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    80002214:	00007517          	auipc	a0,0x7
    80002218:	f9c50513          	addi	a0,a0,-100 # 800091b0 <CONSOLE_STATUS+0x1a0>
    8000221c:	00002097          	auipc	ra,0x2
    80002220:	df0080e7          	jalr	-528(ra) # 8000400c <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80002224:	02000513          	li	a0,32
    80002228:	00003097          	auipc	ra,0x3
    8000222c:	ca0080e7          	jalr	-864(ra) # 80004ec8 <_Znwm>
    80002230:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    80002234:	00003097          	auipc	ra,0x3
    80002238:	ed8080e7          	jalr	-296(ra) # 8000510c <_ZN6ThreadC1Ev>
    8000223c:	00009797          	auipc	a5,0x9
    80002240:	30c78793          	addi	a5,a5,780 # 8000b548 <_ZTV7WorkerC+0x10>
    80002244:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    80002248:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    8000224c:	00007517          	auipc	a0,0x7
    80002250:	f7c50513          	addi	a0,a0,-132 # 800091c8 <CONSOLE_STATUS+0x1b8>
    80002254:	00002097          	auipc	ra,0x2
    80002258:	db8080e7          	jalr	-584(ra) # 8000400c <_Z11printStringPKc>

    threads[3] = new WorkerD();
    8000225c:	02000513          	li	a0,32
    80002260:	00003097          	auipc	ra,0x3
    80002264:	c68080e7          	jalr	-920(ra) # 80004ec8 <_Znwm>
    80002268:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    8000226c:	00003097          	auipc	ra,0x3
    80002270:	ea0080e7          	jalr	-352(ra) # 8000510c <_ZN6ThreadC1Ev>
    80002274:	00009797          	auipc	a5,0x9
    80002278:	2fc78793          	addi	a5,a5,764 # 8000b570 <_ZTV7WorkerD+0x10>
    8000227c:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    80002280:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    80002284:	00007517          	auipc	a0,0x7
    80002288:	f5c50513          	addi	a0,a0,-164 # 800091e0 <CONSOLE_STATUS+0x1d0>
    8000228c:	00002097          	auipc	ra,0x2
    80002290:	d80080e7          	jalr	-640(ra) # 8000400c <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80002294:	00000493          	li	s1,0
    80002298:	00300793          	li	a5,3
    8000229c:	0297c663          	blt	a5,s1,800022c8 <_Z20Threads_CPP_API_testv+0x12c>
        threads[i]->start();
    800022a0:	00349793          	slli	a5,s1,0x3
    800022a4:	fe040713          	addi	a4,s0,-32
    800022a8:	00f707b3          	add	a5,a4,a5
    800022ac:	fe07b503          	ld	a0,-32(a5)
    800022b0:	00003097          	auipc	ra,0x3
    800022b4:	d88080e7          	jalr	-632(ra) # 80005038 <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    800022b8:	0014849b          	addiw	s1,s1,1
    800022bc:	fddff06f          	j	80002298 <_Z20Threads_CPP_API_testv+0xfc>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    800022c0:	00003097          	auipc	ra,0x3
    800022c4:	dd4080e7          	jalr	-556(ra) # 80005094 <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800022c8:	00009797          	auipc	a5,0x9
    800022cc:	4e87c783          	lbu	a5,1256(a5) # 8000b7b0 <_ZL9finishedA>
    800022d0:	fe0788e3          	beqz	a5,800022c0 <_Z20Threads_CPP_API_testv+0x124>
    800022d4:	00009797          	auipc	a5,0x9
    800022d8:	4dd7c783          	lbu	a5,1245(a5) # 8000b7b1 <_ZL9finishedB>
    800022dc:	fe0782e3          	beqz	a5,800022c0 <_Z20Threads_CPP_API_testv+0x124>
    800022e0:	00009797          	auipc	a5,0x9
    800022e4:	4d27c783          	lbu	a5,1234(a5) # 8000b7b2 <_ZL9finishedC>
    800022e8:	fc078ce3          	beqz	a5,800022c0 <_Z20Threads_CPP_API_testv+0x124>
    800022ec:	00009797          	auipc	a5,0x9
    800022f0:	4c77c783          	lbu	a5,1223(a5) # 8000b7b3 <_ZL9finishedD>
    800022f4:	fc0786e3          	beqz	a5,800022c0 <_Z20Threads_CPP_API_testv+0x124>
    800022f8:	fc040493          	addi	s1,s0,-64
    800022fc:	0080006f          	j	80002304 <_Z20Threads_CPP_API_testv+0x168>
    }

    for (auto thread: threads) { delete thread; }
    80002300:	00848493          	addi	s1,s1,8
    80002304:	fe040793          	addi	a5,s0,-32
    80002308:	08f48663          	beq	s1,a5,80002394 <_Z20Threads_CPP_API_testv+0x1f8>
    8000230c:	0004b503          	ld	a0,0(s1)
    80002310:	fe0508e3          	beqz	a0,80002300 <_Z20Threads_CPP_API_testv+0x164>
    80002314:	00053783          	ld	a5,0(a0)
    80002318:	0087b783          	ld	a5,8(a5)
    8000231c:	000780e7          	jalr	a5
    80002320:	fe1ff06f          	j	80002300 <_Z20Threads_CPP_API_testv+0x164>
    80002324:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    80002328:	00048513          	mv	a0,s1
    8000232c:	00003097          	auipc	ra,0x3
    80002330:	c1c080e7          	jalr	-996(ra) # 80004f48 <_ZdlPv>
    80002334:	00090513          	mv	a0,s2
    80002338:	0000a097          	auipc	ra,0xa
    8000233c:	5f0080e7          	jalr	1520(ra) # 8000c928 <_Unwind_Resume>
    80002340:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    80002344:	00048513          	mv	a0,s1
    80002348:	00003097          	auipc	ra,0x3
    8000234c:	c00080e7          	jalr	-1024(ra) # 80004f48 <_ZdlPv>
    80002350:	00090513          	mv	a0,s2
    80002354:	0000a097          	auipc	ra,0xa
    80002358:	5d4080e7          	jalr	1492(ra) # 8000c928 <_Unwind_Resume>
    8000235c:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    80002360:	00048513          	mv	a0,s1
    80002364:	00003097          	auipc	ra,0x3
    80002368:	be4080e7          	jalr	-1052(ra) # 80004f48 <_ZdlPv>
    8000236c:	00090513          	mv	a0,s2
    80002370:	0000a097          	auipc	ra,0xa
    80002374:	5b8080e7          	jalr	1464(ra) # 8000c928 <_Unwind_Resume>
    80002378:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    8000237c:	00048513          	mv	a0,s1
    80002380:	00003097          	auipc	ra,0x3
    80002384:	bc8080e7          	jalr	-1080(ra) # 80004f48 <_ZdlPv>
    80002388:	00090513          	mv	a0,s2
    8000238c:	0000a097          	auipc	ra,0xa
    80002390:	59c080e7          	jalr	1436(ra) # 8000c928 <_Unwind_Resume>
}
    80002394:	03813083          	ld	ra,56(sp)
    80002398:	03013403          	ld	s0,48(sp)
    8000239c:	02813483          	ld	s1,40(sp)
    800023a0:	02013903          	ld	s2,32(sp)
    800023a4:	04010113          	addi	sp,sp,64
    800023a8:	00008067          	ret

00000000800023ac <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    800023ac:	ff010113          	addi	sp,sp,-16
    800023b0:	00113423          	sd	ra,8(sp)
    800023b4:	00813023          	sd	s0,0(sp)
    800023b8:	01010413          	addi	s0,sp,16
    800023bc:	00009797          	auipc	a5,0x9
    800023c0:	13c78793          	addi	a5,a5,316 # 8000b4f8 <_ZTV7WorkerA+0x10>
    800023c4:	00f53023          	sd	a5,0(a0)
    800023c8:	00003097          	auipc	ra,0x3
    800023cc:	a44080e7          	jalr	-1468(ra) # 80004e0c <_ZN6ThreadD1Ev>
    800023d0:	00813083          	ld	ra,8(sp)
    800023d4:	00013403          	ld	s0,0(sp)
    800023d8:	01010113          	addi	sp,sp,16
    800023dc:	00008067          	ret

00000000800023e0 <_ZN7WorkerAD0Ev>:
    800023e0:	fe010113          	addi	sp,sp,-32
    800023e4:	00113c23          	sd	ra,24(sp)
    800023e8:	00813823          	sd	s0,16(sp)
    800023ec:	00913423          	sd	s1,8(sp)
    800023f0:	02010413          	addi	s0,sp,32
    800023f4:	00050493          	mv	s1,a0
    800023f8:	00009797          	auipc	a5,0x9
    800023fc:	10078793          	addi	a5,a5,256 # 8000b4f8 <_ZTV7WorkerA+0x10>
    80002400:	00f53023          	sd	a5,0(a0)
    80002404:	00003097          	auipc	ra,0x3
    80002408:	a08080e7          	jalr	-1528(ra) # 80004e0c <_ZN6ThreadD1Ev>
    8000240c:	00048513          	mv	a0,s1
    80002410:	00003097          	auipc	ra,0x3
    80002414:	b38080e7          	jalr	-1224(ra) # 80004f48 <_ZdlPv>
    80002418:	01813083          	ld	ra,24(sp)
    8000241c:	01013403          	ld	s0,16(sp)
    80002420:	00813483          	ld	s1,8(sp)
    80002424:	02010113          	addi	sp,sp,32
    80002428:	00008067          	ret

000000008000242c <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    8000242c:	ff010113          	addi	sp,sp,-16
    80002430:	00113423          	sd	ra,8(sp)
    80002434:	00813023          	sd	s0,0(sp)
    80002438:	01010413          	addi	s0,sp,16
    8000243c:	00009797          	auipc	a5,0x9
    80002440:	0e478793          	addi	a5,a5,228 # 8000b520 <_ZTV7WorkerB+0x10>
    80002444:	00f53023          	sd	a5,0(a0)
    80002448:	00003097          	auipc	ra,0x3
    8000244c:	9c4080e7          	jalr	-1596(ra) # 80004e0c <_ZN6ThreadD1Ev>
    80002450:	00813083          	ld	ra,8(sp)
    80002454:	00013403          	ld	s0,0(sp)
    80002458:	01010113          	addi	sp,sp,16
    8000245c:	00008067          	ret

0000000080002460 <_ZN7WorkerBD0Ev>:
    80002460:	fe010113          	addi	sp,sp,-32
    80002464:	00113c23          	sd	ra,24(sp)
    80002468:	00813823          	sd	s0,16(sp)
    8000246c:	00913423          	sd	s1,8(sp)
    80002470:	02010413          	addi	s0,sp,32
    80002474:	00050493          	mv	s1,a0
    80002478:	00009797          	auipc	a5,0x9
    8000247c:	0a878793          	addi	a5,a5,168 # 8000b520 <_ZTV7WorkerB+0x10>
    80002480:	00f53023          	sd	a5,0(a0)
    80002484:	00003097          	auipc	ra,0x3
    80002488:	988080e7          	jalr	-1656(ra) # 80004e0c <_ZN6ThreadD1Ev>
    8000248c:	00048513          	mv	a0,s1
    80002490:	00003097          	auipc	ra,0x3
    80002494:	ab8080e7          	jalr	-1352(ra) # 80004f48 <_ZdlPv>
    80002498:	01813083          	ld	ra,24(sp)
    8000249c:	01013403          	ld	s0,16(sp)
    800024a0:	00813483          	ld	s1,8(sp)
    800024a4:	02010113          	addi	sp,sp,32
    800024a8:	00008067          	ret

00000000800024ac <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    800024ac:	ff010113          	addi	sp,sp,-16
    800024b0:	00113423          	sd	ra,8(sp)
    800024b4:	00813023          	sd	s0,0(sp)
    800024b8:	01010413          	addi	s0,sp,16
    800024bc:	00009797          	auipc	a5,0x9
    800024c0:	08c78793          	addi	a5,a5,140 # 8000b548 <_ZTV7WorkerC+0x10>
    800024c4:	00f53023          	sd	a5,0(a0)
    800024c8:	00003097          	auipc	ra,0x3
    800024cc:	944080e7          	jalr	-1724(ra) # 80004e0c <_ZN6ThreadD1Ev>
    800024d0:	00813083          	ld	ra,8(sp)
    800024d4:	00013403          	ld	s0,0(sp)
    800024d8:	01010113          	addi	sp,sp,16
    800024dc:	00008067          	ret

00000000800024e0 <_ZN7WorkerCD0Ev>:
    800024e0:	fe010113          	addi	sp,sp,-32
    800024e4:	00113c23          	sd	ra,24(sp)
    800024e8:	00813823          	sd	s0,16(sp)
    800024ec:	00913423          	sd	s1,8(sp)
    800024f0:	02010413          	addi	s0,sp,32
    800024f4:	00050493          	mv	s1,a0
    800024f8:	00009797          	auipc	a5,0x9
    800024fc:	05078793          	addi	a5,a5,80 # 8000b548 <_ZTV7WorkerC+0x10>
    80002500:	00f53023          	sd	a5,0(a0)
    80002504:	00003097          	auipc	ra,0x3
    80002508:	908080e7          	jalr	-1784(ra) # 80004e0c <_ZN6ThreadD1Ev>
    8000250c:	00048513          	mv	a0,s1
    80002510:	00003097          	auipc	ra,0x3
    80002514:	a38080e7          	jalr	-1480(ra) # 80004f48 <_ZdlPv>
    80002518:	01813083          	ld	ra,24(sp)
    8000251c:	01013403          	ld	s0,16(sp)
    80002520:	00813483          	ld	s1,8(sp)
    80002524:	02010113          	addi	sp,sp,32
    80002528:	00008067          	ret

000000008000252c <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    8000252c:	ff010113          	addi	sp,sp,-16
    80002530:	00113423          	sd	ra,8(sp)
    80002534:	00813023          	sd	s0,0(sp)
    80002538:	01010413          	addi	s0,sp,16
    8000253c:	00009797          	auipc	a5,0x9
    80002540:	03478793          	addi	a5,a5,52 # 8000b570 <_ZTV7WorkerD+0x10>
    80002544:	00f53023          	sd	a5,0(a0)
    80002548:	00003097          	auipc	ra,0x3
    8000254c:	8c4080e7          	jalr	-1852(ra) # 80004e0c <_ZN6ThreadD1Ev>
    80002550:	00813083          	ld	ra,8(sp)
    80002554:	00013403          	ld	s0,0(sp)
    80002558:	01010113          	addi	sp,sp,16
    8000255c:	00008067          	ret

0000000080002560 <_ZN7WorkerDD0Ev>:
    80002560:	fe010113          	addi	sp,sp,-32
    80002564:	00113c23          	sd	ra,24(sp)
    80002568:	00813823          	sd	s0,16(sp)
    8000256c:	00913423          	sd	s1,8(sp)
    80002570:	02010413          	addi	s0,sp,32
    80002574:	00050493          	mv	s1,a0
    80002578:	00009797          	auipc	a5,0x9
    8000257c:	ff878793          	addi	a5,a5,-8 # 8000b570 <_ZTV7WorkerD+0x10>
    80002580:	00f53023          	sd	a5,0(a0)
    80002584:	00003097          	auipc	ra,0x3
    80002588:	888080e7          	jalr	-1912(ra) # 80004e0c <_ZN6ThreadD1Ev>
    8000258c:	00048513          	mv	a0,s1
    80002590:	00003097          	auipc	ra,0x3
    80002594:	9b8080e7          	jalr	-1608(ra) # 80004f48 <_ZdlPv>
    80002598:	01813083          	ld	ra,24(sp)
    8000259c:	01013403          	ld	s0,16(sp)
    800025a0:	00813483          	ld	s1,8(sp)
    800025a4:	02010113          	addi	sp,sp,32
    800025a8:	00008067          	ret

00000000800025ac <_ZN7WorkerA3runEv>:
    void run() override {
    800025ac:	ff010113          	addi	sp,sp,-16
    800025b0:	00113423          	sd	ra,8(sp)
    800025b4:	00813023          	sd	s0,0(sp)
    800025b8:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    800025bc:	00000593          	li	a1,0
    800025c0:	fffff097          	auipc	ra,0xfffff
    800025c4:	774080e7          	jalr	1908(ra) # 80001d34 <_ZN7WorkerA11workerBodyAEPv>
    }
    800025c8:	00813083          	ld	ra,8(sp)
    800025cc:	00013403          	ld	s0,0(sp)
    800025d0:	01010113          	addi	sp,sp,16
    800025d4:	00008067          	ret

00000000800025d8 <_ZN7WorkerB3runEv>:
    void run() override {
    800025d8:	ff010113          	addi	sp,sp,-16
    800025dc:	00113423          	sd	ra,8(sp)
    800025e0:	00813023          	sd	s0,0(sp)
    800025e4:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    800025e8:	00000593          	li	a1,0
    800025ec:	00000097          	auipc	ra,0x0
    800025f0:	814080e7          	jalr	-2028(ra) # 80001e00 <_ZN7WorkerB11workerBodyBEPv>
    }
    800025f4:	00813083          	ld	ra,8(sp)
    800025f8:	00013403          	ld	s0,0(sp)
    800025fc:	01010113          	addi	sp,sp,16
    80002600:	00008067          	ret

0000000080002604 <_ZN7WorkerC3runEv>:
    void run() override {
    80002604:	ff010113          	addi	sp,sp,-16
    80002608:	00113423          	sd	ra,8(sp)
    8000260c:	00813023          	sd	s0,0(sp)
    80002610:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80002614:	00000593          	li	a1,0
    80002618:	00000097          	auipc	ra,0x0
    8000261c:	8bc080e7          	jalr	-1860(ra) # 80001ed4 <_ZN7WorkerC11workerBodyCEPv>
    }
    80002620:	00813083          	ld	ra,8(sp)
    80002624:	00013403          	ld	s0,0(sp)
    80002628:	01010113          	addi	sp,sp,16
    8000262c:	00008067          	ret

0000000080002630 <_ZN7WorkerD3runEv>:
    void run() override {
    80002630:	ff010113          	addi	sp,sp,-16
    80002634:	00113423          	sd	ra,8(sp)
    80002638:	00813023          	sd	s0,0(sp)
    8000263c:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    80002640:	00000593          	li	a1,0
    80002644:	00000097          	auipc	ra,0x0
    80002648:	a10080e7          	jalr	-1520(ra) # 80002054 <_ZN7WorkerD11workerBodyDEPv>
    }
    8000264c:	00813083          	ld	ra,8(sp)
    80002650:	00013403          	ld	s0,0(sp)
    80002654:	01010113          	addi	sp,sp,16
    80002658:	00008067          	ret

000000008000265c <_Z20testConsumerProducerv>:

        td->sem->signal();
    }
};

void testConsumerProducer() {
    8000265c:	f8010113          	addi	sp,sp,-128
    80002660:	06113c23          	sd	ra,120(sp)
    80002664:	06813823          	sd	s0,112(sp)
    80002668:	06913423          	sd	s1,104(sp)
    8000266c:	07213023          	sd	s2,96(sp)
    80002670:	05313c23          	sd	s3,88(sp)
    80002674:	05413823          	sd	s4,80(sp)
    80002678:	05513423          	sd	s5,72(sp)
    8000267c:	05613023          	sd	s6,64(sp)
    80002680:	03713c23          	sd	s7,56(sp)
    80002684:	03813823          	sd	s8,48(sp)
    80002688:	03913423          	sd	s9,40(sp)
    8000268c:	08010413          	addi	s0,sp,128
    delete waitForAll;
    for (int i = 0; i < threadNum; i++) {
        delete producers[i];
    }
    delete consumer;
    delete buffer;
    80002690:	00010c13          	mv	s8,sp
    printString("Unesite broj proizvodjaca?\n");
    80002694:	00007517          	auipc	a0,0x7
    80002698:	98c50513          	addi	a0,a0,-1652 # 80009020 <CONSOLE_STATUS+0x10>
    8000269c:	00002097          	auipc	ra,0x2
    800026a0:	970080e7          	jalr	-1680(ra) # 8000400c <_Z11printStringPKc>
    getString(input, 30);
    800026a4:	01e00593          	li	a1,30
    800026a8:	f8040493          	addi	s1,s0,-128
    800026ac:	00048513          	mv	a0,s1
    800026b0:	00002097          	auipc	ra,0x2
    800026b4:	9e4080e7          	jalr	-1564(ra) # 80004094 <_Z9getStringPci>
    threadNum = stringToInt(input);
    800026b8:	00048513          	mv	a0,s1
    800026bc:	00002097          	auipc	ra,0x2
    800026c0:	ab0080e7          	jalr	-1360(ra) # 8000416c <_Z11stringToIntPKc>
    800026c4:	00050993          	mv	s3,a0
    printString("Unesite velicinu bafera?\n");
    800026c8:	00007517          	auipc	a0,0x7
    800026cc:	97850513          	addi	a0,a0,-1672 # 80009040 <CONSOLE_STATUS+0x30>
    800026d0:	00002097          	auipc	ra,0x2
    800026d4:	93c080e7          	jalr	-1732(ra) # 8000400c <_Z11printStringPKc>
    getString(input, 30);
    800026d8:	01e00593          	li	a1,30
    800026dc:	00048513          	mv	a0,s1
    800026e0:	00002097          	auipc	ra,0x2
    800026e4:	9b4080e7          	jalr	-1612(ra) # 80004094 <_Z9getStringPci>
    n = stringToInt(input);
    800026e8:	00048513          	mv	a0,s1
    800026ec:	00002097          	auipc	ra,0x2
    800026f0:	a80080e7          	jalr	-1408(ra) # 8000416c <_Z11stringToIntPKc>
    800026f4:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca ");
    800026f8:	00007517          	auipc	a0,0x7
    800026fc:	96850513          	addi	a0,a0,-1688 # 80009060 <CONSOLE_STATUS+0x50>
    80002700:	00002097          	auipc	ra,0x2
    80002704:	90c080e7          	jalr	-1780(ra) # 8000400c <_Z11printStringPKc>
    printInt(threadNum);
    80002708:	00000613          	li	a2,0
    8000270c:	00a00593          	li	a1,10
    80002710:	00098513          	mv	a0,s3
    80002714:	00002097          	auipc	ra,0x2
    80002718:	aa8080e7          	jalr	-1368(ra) # 800041bc <_Z8printIntiii>
    printString(" i velicina bafera ");
    8000271c:	00007517          	auipc	a0,0x7
    80002720:	95c50513          	addi	a0,a0,-1700 # 80009078 <CONSOLE_STATUS+0x68>
    80002724:	00002097          	auipc	ra,0x2
    80002728:	8e8080e7          	jalr	-1816(ra) # 8000400c <_Z11printStringPKc>
    printInt(n);
    8000272c:	00000613          	li	a2,0
    80002730:	00a00593          	li	a1,10
    80002734:	00048513          	mv	a0,s1
    80002738:	00002097          	auipc	ra,0x2
    8000273c:	a84080e7          	jalr	-1404(ra) # 800041bc <_Z8printIntiii>
    printString(".\n");
    80002740:	00007517          	auipc	a0,0x7
    80002744:	95050513          	addi	a0,a0,-1712 # 80009090 <CONSOLE_STATUS+0x80>
    80002748:	00002097          	auipc	ra,0x2
    8000274c:	8c4080e7          	jalr	-1852(ra) # 8000400c <_Z11printStringPKc>
    if (threadNum > n) {
    80002750:	0334c463          	blt	s1,s3,80002778 <_Z20testConsumerProducerv+0x11c>
    } else if (threadNum < 1) {
    80002754:	03305c63          	blez	s3,8000278c <_Z20testConsumerProducerv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    80002758:	03800513          	li	a0,56
    8000275c:	00002097          	auipc	ra,0x2
    80002760:	76c080e7          	jalr	1900(ra) # 80004ec8 <_Znwm>
    80002764:	00050a93          	mv	s5,a0
    80002768:	00048593          	mv	a1,s1
    8000276c:	00002097          	auipc	ra,0x2
    80002770:	b70080e7          	jalr	-1168(ra) # 800042dc <_ZN9BufferCPPC1Ei>
    80002774:	0300006f          	j	800027a4 <_Z20testConsumerProducerv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80002778:	00007517          	auipc	a0,0x7
    8000277c:	a8050513          	addi	a0,a0,-1408 # 800091f8 <CONSOLE_STATUS+0x1e8>
    80002780:	00002097          	auipc	ra,0x2
    80002784:	88c080e7          	jalr	-1908(ra) # 8000400c <_Z11printStringPKc>
        return;
    80002788:	0140006f          	j	8000279c <_Z20testConsumerProducerv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    8000278c:	00007517          	auipc	a0,0x7
    80002790:	94450513          	addi	a0,a0,-1724 # 800090d0 <CONSOLE_STATUS+0xc0>
    80002794:	00002097          	auipc	ra,0x2
    80002798:	878080e7          	jalr	-1928(ra) # 8000400c <_Z11printStringPKc>
        return;
    8000279c:	000c0113          	mv	sp,s8
    800027a0:	2140006f          	j	800029b4 <_Z20testConsumerProducerv+0x358>
    waitForAll = new Semaphore(0);
    800027a4:	01000513          	li	a0,16
    800027a8:	00002097          	auipc	ra,0x2
    800027ac:	720080e7          	jalr	1824(ra) # 80004ec8 <_Znwm>
    800027b0:	00050913          	mv	s2,a0
    800027b4:	00000593          	li	a1,0
    800027b8:	00003097          	auipc	ra,0x3
    800027bc:	9b8080e7          	jalr	-1608(ra) # 80005170 <_ZN9SemaphoreC1Ej>
    800027c0:	00009797          	auipc	a5,0x9
    800027c4:	0127b023          	sd	s2,0(a5) # 8000b7c0 <_ZL10waitForAll>
    Thread *producers[threadNum];
    800027c8:	00399793          	slli	a5,s3,0x3
    800027cc:	00f78793          	addi	a5,a5,15
    800027d0:	ff07f793          	andi	a5,a5,-16
    800027d4:	40f10133          	sub	sp,sp,a5
    800027d8:	00010a13          	mv	s4,sp
    thread_data threadData[threadNum + 1];
    800027dc:	0019871b          	addiw	a4,s3,1
    800027e0:	00171793          	slli	a5,a4,0x1
    800027e4:	00e787b3          	add	a5,a5,a4
    800027e8:	00379793          	slli	a5,a5,0x3
    800027ec:	00f78793          	addi	a5,a5,15
    800027f0:	ff07f793          	andi	a5,a5,-16
    800027f4:	40f10133          	sub	sp,sp,a5
    800027f8:	00010b13          	mv	s6,sp
    threadData[threadNum].id = threadNum;
    800027fc:	00199493          	slli	s1,s3,0x1
    80002800:	013484b3          	add	s1,s1,s3
    80002804:	00349493          	slli	s1,s1,0x3
    80002808:	009b04b3          	add	s1,s6,s1
    8000280c:	0134a023          	sw	s3,0(s1)
    threadData[threadNum].buffer = buffer;
    80002810:	0154b423          	sd	s5,8(s1)
    threadData[threadNum].sem = waitForAll;
    80002814:	0124b823          	sd	s2,16(s1)
    Thread *consumer = new Consumer(&threadData[threadNum]);
    80002818:	02800513          	li	a0,40
    8000281c:	00002097          	auipc	ra,0x2
    80002820:	6ac080e7          	jalr	1708(ra) # 80004ec8 <_Znwm>
    80002824:	00050b93          	mv	s7,a0
    Consumer(thread_data *_td) : Thread(), td(_td) {}
    80002828:	00003097          	auipc	ra,0x3
    8000282c:	8e4080e7          	jalr	-1820(ra) # 8000510c <_ZN6ThreadC1Ev>
    80002830:	00009797          	auipc	a5,0x9
    80002834:	db878793          	addi	a5,a5,-584 # 8000b5e8 <_ZTV8Consumer+0x10>
    80002838:	00fbb023          	sd	a5,0(s7)
    8000283c:	029bb023          	sd	s1,32(s7)
    consumer->start();
    80002840:	000b8513          	mv	a0,s7
    80002844:	00002097          	auipc	ra,0x2
    80002848:	7f4080e7          	jalr	2036(ra) # 80005038 <_ZN6Thread5startEv>
    threadData[0].id = 0;
    8000284c:	000b2023          	sw	zero,0(s6)
    threadData[0].buffer = buffer;
    80002850:	015b3423          	sd	s5,8(s6)
    threadData[0].sem = waitForAll;
    80002854:	00009797          	auipc	a5,0x9
    80002858:	f6c7b783          	ld	a5,-148(a5) # 8000b7c0 <_ZL10waitForAll>
    8000285c:	00fb3823          	sd	a5,16(s6)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80002860:	02800513          	li	a0,40
    80002864:	00002097          	auipc	ra,0x2
    80002868:	664080e7          	jalr	1636(ra) # 80004ec8 <_Znwm>
    8000286c:	00050493          	mv	s1,a0
    ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80002870:	00003097          	auipc	ra,0x3
    80002874:	89c080e7          	jalr	-1892(ra) # 8000510c <_ZN6ThreadC1Ev>
    80002878:	00009797          	auipc	a5,0x9
    8000287c:	d2078793          	addi	a5,a5,-736 # 8000b598 <_ZTV16ProducerKeyborad+0x10>
    80002880:	00f4b023          	sd	a5,0(s1)
    80002884:	0364b023          	sd	s6,32(s1)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80002888:	009a3023          	sd	s1,0(s4)
    producers[0]->start();
    8000288c:	00048513          	mv	a0,s1
    80002890:	00002097          	auipc	ra,0x2
    80002894:	7a8080e7          	jalr	1960(ra) # 80005038 <_ZN6Thread5startEv>
    for (int i = 1; i < threadNum; i++) {
    80002898:	00100913          	li	s2,1
    8000289c:	0300006f          	j	800028cc <_Z20testConsumerProducerv+0x270>
    Producer(thread_data *_td) : Thread(), td(_td) {}
    800028a0:	00009797          	auipc	a5,0x9
    800028a4:	d2078793          	addi	a5,a5,-736 # 8000b5c0 <_ZTV8Producer+0x10>
    800028a8:	00fcb023          	sd	a5,0(s9)
    800028ac:	029cb023          	sd	s1,32(s9)
        producers[i] = new Producer(&threadData[i]);
    800028b0:	00391793          	slli	a5,s2,0x3
    800028b4:	00fa07b3          	add	a5,s4,a5
    800028b8:	0197b023          	sd	s9,0(a5)
        producers[i]->start();
    800028bc:	000c8513          	mv	a0,s9
    800028c0:	00002097          	auipc	ra,0x2
    800028c4:	778080e7          	jalr	1912(ra) # 80005038 <_ZN6Thread5startEv>
    for (int i = 1; i < threadNum; i++) {
    800028c8:	0019091b          	addiw	s2,s2,1
    800028cc:	05395263          	bge	s2,s3,80002910 <_Z20testConsumerProducerv+0x2b4>
        threadData[i].id = i;
    800028d0:	00191493          	slli	s1,s2,0x1
    800028d4:	012484b3          	add	s1,s1,s2
    800028d8:	00349493          	slli	s1,s1,0x3
    800028dc:	009b04b3          	add	s1,s6,s1
    800028e0:	0124a023          	sw	s2,0(s1)
        threadData[i].buffer = buffer;
    800028e4:	0154b423          	sd	s5,8(s1)
        threadData[i].sem = waitForAll;
    800028e8:	00009797          	auipc	a5,0x9
    800028ec:	ed87b783          	ld	a5,-296(a5) # 8000b7c0 <_ZL10waitForAll>
    800028f0:	00f4b823          	sd	a5,16(s1)
        producers[i] = new Producer(&threadData[i]);
    800028f4:	02800513          	li	a0,40
    800028f8:	00002097          	auipc	ra,0x2
    800028fc:	5d0080e7          	jalr	1488(ra) # 80004ec8 <_Znwm>
    80002900:	00050c93          	mv	s9,a0
    Producer(thread_data *_td) : Thread(), td(_td) {}
    80002904:	00003097          	auipc	ra,0x3
    80002908:	808080e7          	jalr	-2040(ra) # 8000510c <_ZN6ThreadC1Ev>
    8000290c:	f95ff06f          	j	800028a0 <_Z20testConsumerProducerv+0x244>
    Thread::dispatch();
    80002910:	00002097          	auipc	ra,0x2
    80002914:	784080e7          	jalr	1924(ra) # 80005094 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80002918:	00000493          	li	s1,0
    8000291c:	0099ce63          	blt	s3,s1,80002938 <_Z20testConsumerProducerv+0x2dc>
        waitForAll->wait();
    80002920:	00009517          	auipc	a0,0x9
    80002924:	ea053503          	ld	a0,-352(a0) # 8000b7c0 <_ZL10waitForAll>
    80002928:	00003097          	auipc	ra,0x3
    8000292c:	880080e7          	jalr	-1920(ra) # 800051a8 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    80002930:	0014849b          	addiw	s1,s1,1
    80002934:	fe9ff06f          	j	8000291c <_Z20testConsumerProducerv+0x2c0>
    delete waitForAll;
    80002938:	00009517          	auipc	a0,0x9
    8000293c:	e8853503          	ld	a0,-376(a0) # 8000b7c0 <_ZL10waitForAll>
    80002940:	00050863          	beqz	a0,80002950 <_Z20testConsumerProducerv+0x2f4>
    80002944:	00053783          	ld	a5,0(a0)
    80002948:	0087b783          	ld	a5,8(a5)
    8000294c:	000780e7          	jalr	a5
    for (int i = 0; i <= threadNum; i++) {
    80002950:	00000493          	li	s1,0
    80002954:	0080006f          	j	8000295c <_Z20testConsumerProducerv+0x300>
    for (int i = 0; i < threadNum; i++) {
    80002958:	0014849b          	addiw	s1,s1,1
    8000295c:	0334d263          	bge	s1,s3,80002980 <_Z20testConsumerProducerv+0x324>
        delete producers[i];
    80002960:	00349793          	slli	a5,s1,0x3
    80002964:	00fa07b3          	add	a5,s4,a5
    80002968:	0007b503          	ld	a0,0(a5)
    8000296c:	fe0506e3          	beqz	a0,80002958 <_Z20testConsumerProducerv+0x2fc>
    80002970:	00053783          	ld	a5,0(a0)
    80002974:	0087b783          	ld	a5,8(a5)
    80002978:	000780e7          	jalr	a5
    8000297c:	fddff06f          	j	80002958 <_Z20testConsumerProducerv+0x2fc>
    delete consumer;
    80002980:	000b8a63          	beqz	s7,80002994 <_Z20testConsumerProducerv+0x338>
    80002984:	000bb783          	ld	a5,0(s7)
    80002988:	0087b783          	ld	a5,8(a5)
    8000298c:	000b8513          	mv	a0,s7
    80002990:	000780e7          	jalr	a5
    delete buffer;
    80002994:	000a8e63          	beqz	s5,800029b0 <_Z20testConsumerProducerv+0x354>
    80002998:	000a8513          	mv	a0,s5
    8000299c:	00002097          	auipc	ra,0x2
    800029a0:	c38080e7          	jalr	-968(ra) # 800045d4 <_ZN9BufferCPPD1Ev>
    800029a4:	000a8513          	mv	a0,s5
    800029a8:	00002097          	auipc	ra,0x2
    800029ac:	5a0080e7          	jalr	1440(ra) # 80004f48 <_ZdlPv>
    800029b0:	000c0113          	mv	sp,s8
}
    800029b4:	f8040113          	addi	sp,s0,-128
    800029b8:	07813083          	ld	ra,120(sp)
    800029bc:	07013403          	ld	s0,112(sp)
    800029c0:	06813483          	ld	s1,104(sp)
    800029c4:	06013903          	ld	s2,96(sp)
    800029c8:	05813983          	ld	s3,88(sp)
    800029cc:	05013a03          	ld	s4,80(sp)
    800029d0:	04813a83          	ld	s5,72(sp)
    800029d4:	04013b03          	ld	s6,64(sp)
    800029d8:	03813b83          	ld	s7,56(sp)
    800029dc:	03013c03          	ld	s8,48(sp)
    800029e0:	02813c83          	ld	s9,40(sp)
    800029e4:	08010113          	addi	sp,sp,128
    800029e8:	00008067          	ret
    800029ec:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    800029f0:	000a8513          	mv	a0,s5
    800029f4:	00002097          	auipc	ra,0x2
    800029f8:	554080e7          	jalr	1364(ra) # 80004f48 <_ZdlPv>
    800029fc:	00048513          	mv	a0,s1
    80002a00:	0000a097          	auipc	ra,0xa
    80002a04:	f28080e7          	jalr	-216(ra) # 8000c928 <_Unwind_Resume>
    80002a08:	00050493          	mv	s1,a0
    waitForAll = new Semaphore(0);
    80002a0c:	00090513          	mv	a0,s2
    80002a10:	00002097          	auipc	ra,0x2
    80002a14:	538080e7          	jalr	1336(ra) # 80004f48 <_ZdlPv>
    80002a18:	00048513          	mv	a0,s1
    80002a1c:	0000a097          	auipc	ra,0xa
    80002a20:	f0c080e7          	jalr	-244(ra) # 8000c928 <_Unwind_Resume>
    80002a24:	00050493          	mv	s1,a0
    Thread *consumer = new Consumer(&threadData[threadNum]);
    80002a28:	000b8513          	mv	a0,s7
    80002a2c:	00002097          	auipc	ra,0x2
    80002a30:	51c080e7          	jalr	1308(ra) # 80004f48 <_ZdlPv>
    80002a34:	00048513          	mv	a0,s1
    80002a38:	0000a097          	auipc	ra,0xa
    80002a3c:	ef0080e7          	jalr	-272(ra) # 8000c928 <_Unwind_Resume>
    80002a40:	00050913          	mv	s2,a0
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80002a44:	00048513          	mv	a0,s1
    80002a48:	00002097          	auipc	ra,0x2
    80002a4c:	500080e7          	jalr	1280(ra) # 80004f48 <_ZdlPv>
    80002a50:	00090513          	mv	a0,s2
    80002a54:	0000a097          	auipc	ra,0xa
    80002a58:	ed4080e7          	jalr	-300(ra) # 8000c928 <_Unwind_Resume>
    80002a5c:	00050493          	mv	s1,a0
        producers[i] = new Producer(&threadData[i]);
    80002a60:	000c8513          	mv	a0,s9
    80002a64:	00002097          	auipc	ra,0x2
    80002a68:	4e4080e7          	jalr	1252(ra) # 80004f48 <_ZdlPv>
    80002a6c:	00048513          	mv	a0,s1
    80002a70:	0000a097          	auipc	ra,0xa
    80002a74:	eb8080e7          	jalr	-328(ra) # 8000c928 <_Unwind_Resume>

0000000080002a78 <_ZN8Consumer3runEv>:
    void run() override {
    80002a78:	fd010113          	addi	sp,sp,-48
    80002a7c:	02113423          	sd	ra,40(sp)
    80002a80:	02813023          	sd	s0,32(sp)
    80002a84:	00913c23          	sd	s1,24(sp)
    80002a88:	01213823          	sd	s2,16(sp)
    80002a8c:	01313423          	sd	s3,8(sp)
    80002a90:	03010413          	addi	s0,sp,48
    80002a94:	00050913          	mv	s2,a0
        int i = 0;
    80002a98:	00000993          	li	s3,0
    80002a9c:	0100006f          	j	80002aac <_ZN8Consumer3runEv+0x34>
                Console::putc('\n');
    80002aa0:	00a00513          	li	a0,10
    80002aa4:	00002097          	auipc	ra,0x2
    80002aa8:	784080e7          	jalr	1924(ra) # 80005228 <_ZN7Console4putcEc>
        while (!threadEnd) {
    80002aac:	00009797          	auipc	a5,0x9
    80002ab0:	d0c7a783          	lw	a5,-756(a5) # 8000b7b8 <_ZL9threadEnd>
    80002ab4:	04079a63          	bnez	a5,80002b08 <_ZN8Consumer3runEv+0x90>
            int key = td->buffer->get();
    80002ab8:	02093783          	ld	a5,32(s2)
    80002abc:	0087b503          	ld	a0,8(a5)
    80002ac0:	00002097          	auipc	ra,0x2
    80002ac4:	a00080e7          	jalr	-1536(ra) # 800044c0 <_ZN9BufferCPP3getEv>
            i++;
    80002ac8:	0019849b          	addiw	s1,s3,1
    80002acc:	0004899b          	sext.w	s3,s1
            Console::putc(key);
    80002ad0:	0ff57513          	andi	a0,a0,255
    80002ad4:	00002097          	auipc	ra,0x2
    80002ad8:	754080e7          	jalr	1876(ra) # 80005228 <_ZN7Console4putcEc>
            if (i % 80 == 0) {
    80002adc:	05000793          	li	a5,80
    80002ae0:	02f4e4bb          	remw	s1,s1,a5
    80002ae4:	fc0494e3          	bnez	s1,80002aac <_ZN8Consumer3runEv+0x34>
    80002ae8:	fb9ff06f          	j	80002aa0 <_ZN8Consumer3runEv+0x28>
            int key = td->buffer->get();
    80002aec:	02093783          	ld	a5,32(s2)
    80002af0:	0087b503          	ld	a0,8(a5)
    80002af4:	00002097          	auipc	ra,0x2
    80002af8:	9cc080e7          	jalr	-1588(ra) # 800044c0 <_ZN9BufferCPP3getEv>
            Console::putc(key);
    80002afc:	0ff57513          	andi	a0,a0,255
    80002b00:	00002097          	auipc	ra,0x2
    80002b04:	728080e7          	jalr	1832(ra) # 80005228 <_ZN7Console4putcEc>
        while (td->buffer->getCnt() > 0) {
    80002b08:	02093783          	ld	a5,32(s2)
    80002b0c:	0087b503          	ld	a0,8(a5)
    80002b10:	00002097          	auipc	ra,0x2
    80002b14:	a3c080e7          	jalr	-1476(ra) # 8000454c <_ZN9BufferCPP6getCntEv>
    80002b18:	fca04ae3          	bgtz	a0,80002aec <_ZN8Consumer3runEv+0x74>
        td->sem->signal();
    80002b1c:	02093783          	ld	a5,32(s2)
    80002b20:	0107b503          	ld	a0,16(a5)
    80002b24:	00002097          	auipc	ra,0x2
    80002b28:	6b0080e7          	jalr	1712(ra) # 800051d4 <_ZN9Semaphore6signalEv>
    }
    80002b2c:	02813083          	ld	ra,40(sp)
    80002b30:	02013403          	ld	s0,32(sp)
    80002b34:	01813483          	ld	s1,24(sp)
    80002b38:	01013903          	ld	s2,16(sp)
    80002b3c:	00813983          	ld	s3,8(sp)
    80002b40:	03010113          	addi	sp,sp,48
    80002b44:	00008067          	ret

0000000080002b48 <_ZN8ConsumerD1Ev>:
class Consumer : public Thread {
    80002b48:	ff010113          	addi	sp,sp,-16
    80002b4c:	00113423          	sd	ra,8(sp)
    80002b50:	00813023          	sd	s0,0(sp)
    80002b54:	01010413          	addi	s0,sp,16
    80002b58:	00009797          	auipc	a5,0x9
    80002b5c:	a9078793          	addi	a5,a5,-1392 # 8000b5e8 <_ZTV8Consumer+0x10>
    80002b60:	00f53023          	sd	a5,0(a0)
    80002b64:	00002097          	auipc	ra,0x2
    80002b68:	2a8080e7          	jalr	680(ra) # 80004e0c <_ZN6ThreadD1Ev>
    80002b6c:	00813083          	ld	ra,8(sp)
    80002b70:	00013403          	ld	s0,0(sp)
    80002b74:	01010113          	addi	sp,sp,16
    80002b78:	00008067          	ret

0000000080002b7c <_ZN8ConsumerD0Ev>:
    80002b7c:	fe010113          	addi	sp,sp,-32
    80002b80:	00113c23          	sd	ra,24(sp)
    80002b84:	00813823          	sd	s0,16(sp)
    80002b88:	00913423          	sd	s1,8(sp)
    80002b8c:	02010413          	addi	s0,sp,32
    80002b90:	00050493          	mv	s1,a0
    80002b94:	00009797          	auipc	a5,0x9
    80002b98:	a5478793          	addi	a5,a5,-1452 # 8000b5e8 <_ZTV8Consumer+0x10>
    80002b9c:	00f53023          	sd	a5,0(a0)
    80002ba0:	00002097          	auipc	ra,0x2
    80002ba4:	26c080e7          	jalr	620(ra) # 80004e0c <_ZN6ThreadD1Ev>
    80002ba8:	00048513          	mv	a0,s1
    80002bac:	00002097          	auipc	ra,0x2
    80002bb0:	39c080e7          	jalr	924(ra) # 80004f48 <_ZdlPv>
    80002bb4:	01813083          	ld	ra,24(sp)
    80002bb8:	01013403          	ld	s0,16(sp)
    80002bbc:	00813483          	ld	s1,8(sp)
    80002bc0:	02010113          	addi	sp,sp,32
    80002bc4:	00008067          	ret

0000000080002bc8 <_ZN16ProducerKeyboradD1Ev>:
class ProducerKeyborad : public Thread {
    80002bc8:	ff010113          	addi	sp,sp,-16
    80002bcc:	00113423          	sd	ra,8(sp)
    80002bd0:	00813023          	sd	s0,0(sp)
    80002bd4:	01010413          	addi	s0,sp,16
    80002bd8:	00009797          	auipc	a5,0x9
    80002bdc:	9c078793          	addi	a5,a5,-1600 # 8000b598 <_ZTV16ProducerKeyborad+0x10>
    80002be0:	00f53023          	sd	a5,0(a0)
    80002be4:	00002097          	auipc	ra,0x2
    80002be8:	228080e7          	jalr	552(ra) # 80004e0c <_ZN6ThreadD1Ev>
    80002bec:	00813083          	ld	ra,8(sp)
    80002bf0:	00013403          	ld	s0,0(sp)
    80002bf4:	01010113          	addi	sp,sp,16
    80002bf8:	00008067          	ret

0000000080002bfc <_ZN16ProducerKeyboradD0Ev>:
    80002bfc:	fe010113          	addi	sp,sp,-32
    80002c00:	00113c23          	sd	ra,24(sp)
    80002c04:	00813823          	sd	s0,16(sp)
    80002c08:	00913423          	sd	s1,8(sp)
    80002c0c:	02010413          	addi	s0,sp,32
    80002c10:	00050493          	mv	s1,a0
    80002c14:	00009797          	auipc	a5,0x9
    80002c18:	98478793          	addi	a5,a5,-1660 # 8000b598 <_ZTV16ProducerKeyborad+0x10>
    80002c1c:	00f53023          	sd	a5,0(a0)
    80002c20:	00002097          	auipc	ra,0x2
    80002c24:	1ec080e7          	jalr	492(ra) # 80004e0c <_ZN6ThreadD1Ev>
    80002c28:	00048513          	mv	a0,s1
    80002c2c:	00002097          	auipc	ra,0x2
    80002c30:	31c080e7          	jalr	796(ra) # 80004f48 <_ZdlPv>
    80002c34:	01813083          	ld	ra,24(sp)
    80002c38:	01013403          	ld	s0,16(sp)
    80002c3c:	00813483          	ld	s1,8(sp)
    80002c40:	02010113          	addi	sp,sp,32
    80002c44:	00008067          	ret

0000000080002c48 <_ZN8ProducerD1Ev>:
class Producer : public Thread {
    80002c48:	ff010113          	addi	sp,sp,-16
    80002c4c:	00113423          	sd	ra,8(sp)
    80002c50:	00813023          	sd	s0,0(sp)
    80002c54:	01010413          	addi	s0,sp,16
    80002c58:	00009797          	auipc	a5,0x9
    80002c5c:	96878793          	addi	a5,a5,-1688 # 8000b5c0 <_ZTV8Producer+0x10>
    80002c60:	00f53023          	sd	a5,0(a0)
    80002c64:	00002097          	auipc	ra,0x2
    80002c68:	1a8080e7          	jalr	424(ra) # 80004e0c <_ZN6ThreadD1Ev>
    80002c6c:	00813083          	ld	ra,8(sp)
    80002c70:	00013403          	ld	s0,0(sp)
    80002c74:	01010113          	addi	sp,sp,16
    80002c78:	00008067          	ret

0000000080002c7c <_ZN8ProducerD0Ev>:
    80002c7c:	fe010113          	addi	sp,sp,-32
    80002c80:	00113c23          	sd	ra,24(sp)
    80002c84:	00813823          	sd	s0,16(sp)
    80002c88:	00913423          	sd	s1,8(sp)
    80002c8c:	02010413          	addi	s0,sp,32
    80002c90:	00050493          	mv	s1,a0
    80002c94:	00009797          	auipc	a5,0x9
    80002c98:	92c78793          	addi	a5,a5,-1748 # 8000b5c0 <_ZTV8Producer+0x10>
    80002c9c:	00f53023          	sd	a5,0(a0)
    80002ca0:	00002097          	auipc	ra,0x2
    80002ca4:	16c080e7          	jalr	364(ra) # 80004e0c <_ZN6ThreadD1Ev>
    80002ca8:	00048513          	mv	a0,s1
    80002cac:	00002097          	auipc	ra,0x2
    80002cb0:	29c080e7          	jalr	668(ra) # 80004f48 <_ZdlPv>
    80002cb4:	01813083          	ld	ra,24(sp)
    80002cb8:	01013403          	ld	s0,16(sp)
    80002cbc:	00813483          	ld	s1,8(sp)
    80002cc0:	02010113          	addi	sp,sp,32
    80002cc4:	00008067          	ret

0000000080002cc8 <_ZN16ProducerKeyborad3runEv>:
    void run() override {
    80002cc8:	fe010113          	addi	sp,sp,-32
    80002ccc:	00113c23          	sd	ra,24(sp)
    80002cd0:	00813823          	sd	s0,16(sp)
    80002cd4:	00913423          	sd	s1,8(sp)
    80002cd8:	02010413          	addi	s0,sp,32
    80002cdc:	00050493          	mv	s1,a0
        while ((key = getc()) != 0x1b) {
    80002ce0:	fffff097          	auipc	ra,0xfffff
    80002ce4:	a6c080e7          	jalr	-1428(ra) # 8000174c <_Z4getcv>
    80002ce8:	0005059b          	sext.w	a1,a0
    80002cec:	01b00793          	li	a5,27
    80002cf0:	00f58c63          	beq	a1,a5,80002d08 <_ZN16ProducerKeyborad3runEv+0x40>
            td->buffer->put(key);
    80002cf4:	0204b783          	ld	a5,32(s1)
    80002cf8:	0087b503          	ld	a0,8(a5)
    80002cfc:	00001097          	auipc	ra,0x1
    80002d00:	734080e7          	jalr	1844(ra) # 80004430 <_ZN9BufferCPP3putEi>
        while ((key = getc()) != 0x1b) {
    80002d04:	fddff06f          	j	80002ce0 <_ZN16ProducerKeyborad3runEv+0x18>
        threadEnd = 1;
    80002d08:	00100793          	li	a5,1
    80002d0c:	00009717          	auipc	a4,0x9
    80002d10:	aaf72623          	sw	a5,-1364(a4) # 8000b7b8 <_ZL9threadEnd>
        td->buffer->put('!');
    80002d14:	0204b783          	ld	a5,32(s1)
    80002d18:	02100593          	li	a1,33
    80002d1c:	0087b503          	ld	a0,8(a5)
    80002d20:	00001097          	auipc	ra,0x1
    80002d24:	710080e7          	jalr	1808(ra) # 80004430 <_ZN9BufferCPP3putEi>
        td->sem->signal();
    80002d28:	0204b783          	ld	a5,32(s1)
    80002d2c:	0107b503          	ld	a0,16(a5)
    80002d30:	00002097          	auipc	ra,0x2
    80002d34:	4a4080e7          	jalr	1188(ra) # 800051d4 <_ZN9Semaphore6signalEv>
    }
    80002d38:	01813083          	ld	ra,24(sp)
    80002d3c:	01013403          	ld	s0,16(sp)
    80002d40:	00813483          	ld	s1,8(sp)
    80002d44:	02010113          	addi	sp,sp,32
    80002d48:	00008067          	ret

0000000080002d4c <_ZN8Producer3runEv>:
    void run() override {
    80002d4c:	fe010113          	addi	sp,sp,-32
    80002d50:	00113c23          	sd	ra,24(sp)
    80002d54:	00813823          	sd	s0,16(sp)
    80002d58:	00913423          	sd	s1,8(sp)
    80002d5c:	01213023          	sd	s2,0(sp)
    80002d60:	02010413          	addi	s0,sp,32
    80002d64:	00050493          	mv	s1,a0
        int i = 0;
    80002d68:	00000913          	li	s2,0
        while (!threadEnd) {
    80002d6c:	00009797          	auipc	a5,0x9
    80002d70:	a4c7a783          	lw	a5,-1460(a5) # 8000b7b8 <_ZL9threadEnd>
    80002d74:	04079263          	bnez	a5,80002db8 <_ZN8Producer3runEv+0x6c>
            td->buffer->put(td->id + '0');
    80002d78:	0204b783          	ld	a5,32(s1)
    80002d7c:	0007a583          	lw	a1,0(a5)
    80002d80:	0305859b          	addiw	a1,a1,48
    80002d84:	0087b503          	ld	a0,8(a5)
    80002d88:	00001097          	auipc	ra,0x1
    80002d8c:	6a8080e7          	jalr	1704(ra) # 80004430 <_ZN9BufferCPP3putEi>
            i++;
    80002d90:	0019071b          	addiw	a4,s2,1
    80002d94:	0007091b          	sext.w	s2,a4
            Thread::sleep((i + td->id) % 5);
    80002d98:	0204b783          	ld	a5,32(s1)
    80002d9c:	0007a783          	lw	a5,0(a5)
    80002da0:	00e787bb          	addw	a5,a5,a4
    80002da4:	00500513          	li	a0,5
    80002da8:	02a7e53b          	remw	a0,a5,a0
    80002dac:	00002097          	auipc	ra,0x2
    80002db0:	310080e7          	jalr	784(ra) # 800050bc <_ZN6Thread5sleepEm>
        while (!threadEnd) {
    80002db4:	fb9ff06f          	j	80002d6c <_ZN8Producer3runEv+0x20>
        td->sem->signal();
    80002db8:	0204b783          	ld	a5,32(s1)
    80002dbc:	0107b503          	ld	a0,16(a5)
    80002dc0:	00002097          	auipc	ra,0x2
    80002dc4:	414080e7          	jalr	1044(ra) # 800051d4 <_ZN9Semaphore6signalEv>
    }
    80002dc8:	01813083          	ld	ra,24(sp)
    80002dcc:	01013403          	ld	s0,16(sp)
    80002dd0:	00813483          	ld	s1,8(sp)
    80002dd4:	00013903          	ld	s2,0(sp)
    80002dd8:	02010113          	addi	sp,sp,32
    80002ddc:	00008067          	ret

0000000080002de0 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80002de0:	fe010113          	addi	sp,sp,-32
    80002de4:	00113c23          	sd	ra,24(sp)
    80002de8:	00813823          	sd	s0,16(sp)
    80002dec:	00913423          	sd	s1,8(sp)
    80002df0:	01213023          	sd	s2,0(sp)
    80002df4:	02010413          	addi	s0,sp,32
    80002df8:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80002dfc:	00100793          	li	a5,1
    80002e00:	02a7f863          	bgeu	a5,a0,80002e30 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80002e04:	00a00793          	li	a5,10
    80002e08:	02f577b3          	remu	a5,a0,a5
    80002e0c:	02078e63          	beqz	a5,80002e48 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80002e10:	fff48513          	addi	a0,s1,-1
    80002e14:	00000097          	auipc	ra,0x0
    80002e18:	fcc080e7          	jalr	-52(ra) # 80002de0 <_ZL9fibonaccim>
    80002e1c:	00050913          	mv	s2,a0
    80002e20:	ffe48513          	addi	a0,s1,-2
    80002e24:	00000097          	auipc	ra,0x0
    80002e28:	fbc080e7          	jalr	-68(ra) # 80002de0 <_ZL9fibonaccim>
    80002e2c:	00a90533          	add	a0,s2,a0
}
    80002e30:	01813083          	ld	ra,24(sp)
    80002e34:	01013403          	ld	s0,16(sp)
    80002e38:	00813483          	ld	s1,8(sp)
    80002e3c:	00013903          	ld	s2,0(sp)
    80002e40:	02010113          	addi	sp,sp,32
    80002e44:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80002e48:	ffffe097          	auipc	ra,0xffffe
    80002e4c:	71c080e7          	jalr	1820(ra) # 80001564 <_Z15thread_dispatchv>
    80002e50:	fc1ff06f          	j	80002e10 <_ZL9fibonaccim+0x30>

0000000080002e54 <_ZL11workerBodyDPv>:
    printString("C finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80002e54:	fe010113          	addi	sp,sp,-32
    80002e58:	00113c23          	sd	ra,24(sp)
    80002e5c:	00813823          	sd	s0,16(sp)
    80002e60:	00913423          	sd	s1,8(sp)
    80002e64:	01213023          	sd	s2,0(sp)
    80002e68:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80002e6c:	00a00493          	li	s1,10
    80002e70:	0400006f          	j	80002eb0 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002e74:	00006517          	auipc	a0,0x6
    80002e78:	2ec50513          	addi	a0,a0,748 # 80009160 <CONSOLE_STATUS+0x150>
    80002e7c:	00001097          	auipc	ra,0x1
    80002e80:	190080e7          	jalr	400(ra) # 8000400c <_Z11printStringPKc>
    80002e84:	00000613          	li	a2,0
    80002e88:	00a00593          	li	a1,10
    80002e8c:	00048513          	mv	a0,s1
    80002e90:	00001097          	auipc	ra,0x1
    80002e94:	32c080e7          	jalr	812(ra) # 800041bc <_Z8printIntiii>
    80002e98:	00006517          	auipc	a0,0x6
    80002e9c:	3c050513          	addi	a0,a0,960 # 80009258 <CONSOLE_STATUS+0x248>
    80002ea0:	00001097          	auipc	ra,0x1
    80002ea4:	16c080e7          	jalr	364(ra) # 8000400c <_Z11printStringPKc>
    for (; i < 13; i++) {
    80002ea8:	0014849b          	addiw	s1,s1,1
    80002eac:	0ff4f493          	andi	s1,s1,255
    80002eb0:	00c00793          	li	a5,12
    80002eb4:	fc97f0e3          	bgeu	a5,s1,80002e74 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80002eb8:	00006517          	auipc	a0,0x6
    80002ebc:	2b050513          	addi	a0,a0,688 # 80009168 <CONSOLE_STATUS+0x158>
    80002ec0:	00001097          	auipc	ra,0x1
    80002ec4:	14c080e7          	jalr	332(ra) # 8000400c <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80002ec8:	00500313          	li	t1,5
    thread_dispatch();
    80002ecc:	ffffe097          	auipc	ra,0xffffe
    80002ed0:	698080e7          	jalr	1688(ra) # 80001564 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80002ed4:	01000513          	li	a0,16
    80002ed8:	00000097          	auipc	ra,0x0
    80002edc:	f08080e7          	jalr	-248(ra) # 80002de0 <_ZL9fibonaccim>
    80002ee0:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80002ee4:	00006517          	auipc	a0,0x6
    80002ee8:	29450513          	addi	a0,a0,660 # 80009178 <CONSOLE_STATUS+0x168>
    80002eec:	00001097          	auipc	ra,0x1
    80002ef0:	120080e7          	jalr	288(ra) # 8000400c <_Z11printStringPKc>
    80002ef4:	00000613          	li	a2,0
    80002ef8:	00a00593          	li	a1,10
    80002efc:	0009051b          	sext.w	a0,s2
    80002f00:	00001097          	auipc	ra,0x1
    80002f04:	2bc080e7          	jalr	700(ra) # 800041bc <_Z8printIntiii>
    80002f08:	00006517          	auipc	a0,0x6
    80002f0c:	35050513          	addi	a0,a0,848 # 80009258 <CONSOLE_STATUS+0x248>
    80002f10:	00001097          	auipc	ra,0x1
    80002f14:	0fc080e7          	jalr	252(ra) # 8000400c <_Z11printStringPKc>
    80002f18:	0400006f          	j	80002f58 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002f1c:	00006517          	auipc	a0,0x6
    80002f20:	24450513          	addi	a0,a0,580 # 80009160 <CONSOLE_STATUS+0x150>
    80002f24:	00001097          	auipc	ra,0x1
    80002f28:	0e8080e7          	jalr	232(ra) # 8000400c <_Z11printStringPKc>
    80002f2c:	00000613          	li	a2,0
    80002f30:	00a00593          	li	a1,10
    80002f34:	00048513          	mv	a0,s1
    80002f38:	00001097          	auipc	ra,0x1
    80002f3c:	284080e7          	jalr	644(ra) # 800041bc <_Z8printIntiii>
    80002f40:	00006517          	auipc	a0,0x6
    80002f44:	31850513          	addi	a0,a0,792 # 80009258 <CONSOLE_STATUS+0x248>
    80002f48:	00001097          	auipc	ra,0x1
    80002f4c:	0c4080e7          	jalr	196(ra) # 8000400c <_Z11printStringPKc>
    for (; i < 16; i++) {
    80002f50:	0014849b          	addiw	s1,s1,1
    80002f54:	0ff4f493          	andi	s1,s1,255
    80002f58:	00f00793          	li	a5,15
    80002f5c:	fc97f0e3          	bgeu	a5,s1,80002f1c <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80002f60:	00006517          	auipc	a0,0x6
    80002f64:	22850513          	addi	a0,a0,552 # 80009188 <CONSOLE_STATUS+0x178>
    80002f68:	00001097          	auipc	ra,0x1
    80002f6c:	0a4080e7          	jalr	164(ra) # 8000400c <_Z11printStringPKc>
    finishedD = true;
    80002f70:	00100793          	li	a5,1
    80002f74:	00009717          	auipc	a4,0x9
    80002f78:	84f70a23          	sb	a5,-1964(a4) # 8000b7c8 <_ZL9finishedD>
    thread_dispatch();
    80002f7c:	ffffe097          	auipc	ra,0xffffe
    80002f80:	5e8080e7          	jalr	1512(ra) # 80001564 <_Z15thread_dispatchv>
}
    80002f84:	01813083          	ld	ra,24(sp)
    80002f88:	01013403          	ld	s0,16(sp)
    80002f8c:	00813483          	ld	s1,8(sp)
    80002f90:	00013903          	ld	s2,0(sp)
    80002f94:	02010113          	addi	sp,sp,32
    80002f98:	00008067          	ret

0000000080002f9c <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80002f9c:	fe010113          	addi	sp,sp,-32
    80002fa0:	00113c23          	sd	ra,24(sp)
    80002fa4:	00813823          	sd	s0,16(sp)
    80002fa8:	00913423          	sd	s1,8(sp)
    80002fac:	01213023          	sd	s2,0(sp)
    80002fb0:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80002fb4:	00000493          	li	s1,0
    80002fb8:	0400006f          	j	80002ff8 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80002fbc:	00006517          	auipc	a0,0x6
    80002fc0:	17450513          	addi	a0,a0,372 # 80009130 <CONSOLE_STATUS+0x120>
    80002fc4:	00001097          	auipc	ra,0x1
    80002fc8:	048080e7          	jalr	72(ra) # 8000400c <_Z11printStringPKc>
    80002fcc:	00000613          	li	a2,0
    80002fd0:	00a00593          	li	a1,10
    80002fd4:	00048513          	mv	a0,s1
    80002fd8:	00001097          	auipc	ra,0x1
    80002fdc:	1e4080e7          	jalr	484(ra) # 800041bc <_Z8printIntiii>
    80002fe0:	00006517          	auipc	a0,0x6
    80002fe4:	27850513          	addi	a0,a0,632 # 80009258 <CONSOLE_STATUS+0x248>
    80002fe8:	00001097          	auipc	ra,0x1
    80002fec:	024080e7          	jalr	36(ra) # 8000400c <_Z11printStringPKc>
    for (; i < 3; i++) {
    80002ff0:	0014849b          	addiw	s1,s1,1
    80002ff4:	0ff4f493          	andi	s1,s1,255
    80002ff8:	00200793          	li	a5,2
    80002ffc:	fc97f0e3          	bgeu	a5,s1,80002fbc <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80003000:	00006517          	auipc	a0,0x6
    80003004:	13850513          	addi	a0,a0,312 # 80009138 <CONSOLE_STATUS+0x128>
    80003008:	00001097          	auipc	ra,0x1
    8000300c:	004080e7          	jalr	4(ra) # 8000400c <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80003010:	00700313          	li	t1,7
    thread_dispatch();
    80003014:	ffffe097          	auipc	ra,0xffffe
    80003018:	550080e7          	jalr	1360(ra) # 80001564 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    8000301c:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80003020:	00006517          	auipc	a0,0x6
    80003024:	12850513          	addi	a0,a0,296 # 80009148 <CONSOLE_STATUS+0x138>
    80003028:	00001097          	auipc	ra,0x1
    8000302c:	fe4080e7          	jalr	-28(ra) # 8000400c <_Z11printStringPKc>
    80003030:	00000613          	li	a2,0
    80003034:	00a00593          	li	a1,10
    80003038:	0009051b          	sext.w	a0,s2
    8000303c:	00001097          	auipc	ra,0x1
    80003040:	180080e7          	jalr	384(ra) # 800041bc <_Z8printIntiii>
    80003044:	00006517          	auipc	a0,0x6
    80003048:	21450513          	addi	a0,a0,532 # 80009258 <CONSOLE_STATUS+0x248>
    8000304c:	00001097          	auipc	ra,0x1
    80003050:	fc0080e7          	jalr	-64(ra) # 8000400c <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80003054:	00c00513          	li	a0,12
    80003058:	00000097          	auipc	ra,0x0
    8000305c:	d88080e7          	jalr	-632(ra) # 80002de0 <_ZL9fibonaccim>
    80003060:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80003064:	00006517          	auipc	a0,0x6
    80003068:	0ec50513          	addi	a0,a0,236 # 80009150 <CONSOLE_STATUS+0x140>
    8000306c:	00001097          	auipc	ra,0x1
    80003070:	fa0080e7          	jalr	-96(ra) # 8000400c <_Z11printStringPKc>
    80003074:	00000613          	li	a2,0
    80003078:	00a00593          	li	a1,10
    8000307c:	0009051b          	sext.w	a0,s2
    80003080:	00001097          	auipc	ra,0x1
    80003084:	13c080e7          	jalr	316(ra) # 800041bc <_Z8printIntiii>
    80003088:	00006517          	auipc	a0,0x6
    8000308c:	1d050513          	addi	a0,a0,464 # 80009258 <CONSOLE_STATUS+0x248>
    80003090:	00001097          	auipc	ra,0x1
    80003094:	f7c080e7          	jalr	-132(ra) # 8000400c <_Z11printStringPKc>
    80003098:	0400006f          	j	800030d8 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    8000309c:	00006517          	auipc	a0,0x6
    800030a0:	09450513          	addi	a0,a0,148 # 80009130 <CONSOLE_STATUS+0x120>
    800030a4:	00001097          	auipc	ra,0x1
    800030a8:	f68080e7          	jalr	-152(ra) # 8000400c <_Z11printStringPKc>
    800030ac:	00000613          	li	a2,0
    800030b0:	00a00593          	li	a1,10
    800030b4:	00048513          	mv	a0,s1
    800030b8:	00001097          	auipc	ra,0x1
    800030bc:	104080e7          	jalr	260(ra) # 800041bc <_Z8printIntiii>
    800030c0:	00006517          	auipc	a0,0x6
    800030c4:	19850513          	addi	a0,a0,408 # 80009258 <CONSOLE_STATUS+0x248>
    800030c8:	00001097          	auipc	ra,0x1
    800030cc:	f44080e7          	jalr	-188(ra) # 8000400c <_Z11printStringPKc>
    for (; i < 6; i++) {
    800030d0:	0014849b          	addiw	s1,s1,1
    800030d4:	0ff4f493          	andi	s1,s1,255
    800030d8:	00500793          	li	a5,5
    800030dc:	fc97f0e3          	bgeu	a5,s1,8000309c <_ZL11workerBodyCPv+0x100>
    printString("C finished!\n");
    800030e0:	00006517          	auipc	a0,0x6
    800030e4:	15850513          	addi	a0,a0,344 # 80009238 <CONSOLE_STATUS+0x228>
    800030e8:	00001097          	auipc	ra,0x1
    800030ec:	f24080e7          	jalr	-220(ra) # 8000400c <_Z11printStringPKc>
    finishedC = true;
    800030f0:	00100793          	li	a5,1
    800030f4:	00008717          	auipc	a4,0x8
    800030f8:	6cf70aa3          	sb	a5,1749(a4) # 8000b7c9 <_ZL9finishedC>
    thread_dispatch();
    800030fc:	ffffe097          	auipc	ra,0xffffe
    80003100:	468080e7          	jalr	1128(ra) # 80001564 <_Z15thread_dispatchv>
}
    80003104:	01813083          	ld	ra,24(sp)
    80003108:	01013403          	ld	s0,16(sp)
    8000310c:	00813483          	ld	s1,8(sp)
    80003110:	00013903          	ld	s2,0(sp)
    80003114:	02010113          	addi	sp,sp,32
    80003118:	00008067          	ret

000000008000311c <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    8000311c:	fe010113          	addi	sp,sp,-32
    80003120:	00113c23          	sd	ra,24(sp)
    80003124:	00813823          	sd	s0,16(sp)
    80003128:	00913423          	sd	s1,8(sp)
    8000312c:	01213023          	sd	s2,0(sp)
    80003130:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80003134:	00000913          	li	s2,0
    80003138:	0380006f          	j	80003170 <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    8000313c:	ffffe097          	auipc	ra,0xffffe
    80003140:	428080e7          	jalr	1064(ra) # 80001564 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003144:	00148493          	addi	s1,s1,1
    80003148:	000027b7          	lui	a5,0x2
    8000314c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003150:	0097ee63          	bltu	a5,s1,8000316c <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003154:	00000713          	li	a4,0
    80003158:	000077b7          	lui	a5,0x7
    8000315c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003160:	fce7eee3          	bltu	a5,a4,8000313c <_ZL11workerBodyBPv+0x20>
    80003164:	00170713          	addi	a4,a4,1
    80003168:	ff1ff06f          	j	80003158 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    8000316c:	00190913          	addi	s2,s2,1
    80003170:	00f00793          	li	a5,15
    80003174:	0527e063          	bltu	a5,s2,800031b4 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80003178:	00006517          	auipc	a0,0x6
    8000317c:	fa050513          	addi	a0,a0,-96 # 80009118 <CONSOLE_STATUS+0x108>
    80003180:	00001097          	auipc	ra,0x1
    80003184:	e8c080e7          	jalr	-372(ra) # 8000400c <_Z11printStringPKc>
    80003188:	00000613          	li	a2,0
    8000318c:	00a00593          	li	a1,10
    80003190:	0009051b          	sext.w	a0,s2
    80003194:	00001097          	auipc	ra,0x1
    80003198:	028080e7          	jalr	40(ra) # 800041bc <_Z8printIntiii>
    8000319c:	00006517          	auipc	a0,0x6
    800031a0:	0bc50513          	addi	a0,a0,188 # 80009258 <CONSOLE_STATUS+0x248>
    800031a4:	00001097          	auipc	ra,0x1
    800031a8:	e68080e7          	jalr	-408(ra) # 8000400c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800031ac:	00000493          	li	s1,0
    800031b0:	f99ff06f          	j	80003148 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    800031b4:	00006517          	auipc	a0,0x6
    800031b8:	f6c50513          	addi	a0,a0,-148 # 80009120 <CONSOLE_STATUS+0x110>
    800031bc:	00001097          	auipc	ra,0x1
    800031c0:	e50080e7          	jalr	-432(ra) # 8000400c <_Z11printStringPKc>
    finishedB = true;
    800031c4:	00100793          	li	a5,1
    800031c8:	00008717          	auipc	a4,0x8
    800031cc:	60f70123          	sb	a5,1538(a4) # 8000b7ca <_ZL9finishedB>
    thread_dispatch();
    800031d0:	ffffe097          	auipc	ra,0xffffe
    800031d4:	394080e7          	jalr	916(ra) # 80001564 <_Z15thread_dispatchv>
}
    800031d8:	01813083          	ld	ra,24(sp)
    800031dc:	01013403          	ld	s0,16(sp)
    800031e0:	00813483          	ld	s1,8(sp)
    800031e4:	00013903          	ld	s2,0(sp)
    800031e8:	02010113          	addi	sp,sp,32
    800031ec:	00008067          	ret

00000000800031f0 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    800031f0:	fe010113          	addi	sp,sp,-32
    800031f4:	00113c23          	sd	ra,24(sp)
    800031f8:	00813823          	sd	s0,16(sp)
    800031fc:	00913423          	sd	s1,8(sp)
    80003200:	01213023          	sd	s2,0(sp)
    80003204:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80003208:	00000913          	li	s2,0
    8000320c:	0380006f          	j	80003244 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80003210:	ffffe097          	auipc	ra,0xffffe
    80003214:	354080e7          	jalr	852(ra) # 80001564 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003218:	00148493          	addi	s1,s1,1
    8000321c:	000027b7          	lui	a5,0x2
    80003220:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003224:	0097ee63          	bltu	a5,s1,80003240 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003228:	00000713          	li	a4,0
    8000322c:	000077b7          	lui	a5,0x7
    80003230:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003234:	fce7eee3          	bltu	a5,a4,80003210 <_ZL11workerBodyAPv+0x20>
    80003238:	00170713          	addi	a4,a4,1
    8000323c:	ff1ff06f          	j	8000322c <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80003240:	00190913          	addi	s2,s2,1
    80003244:	00900793          	li	a5,9
    80003248:	0527e063          	bltu	a5,s2,80003288 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    8000324c:	00006517          	auipc	a0,0x6
    80003250:	eb450513          	addi	a0,a0,-332 # 80009100 <CONSOLE_STATUS+0xf0>
    80003254:	00001097          	auipc	ra,0x1
    80003258:	db8080e7          	jalr	-584(ra) # 8000400c <_Z11printStringPKc>
    8000325c:	00000613          	li	a2,0
    80003260:	00a00593          	li	a1,10
    80003264:	0009051b          	sext.w	a0,s2
    80003268:	00001097          	auipc	ra,0x1
    8000326c:	f54080e7          	jalr	-172(ra) # 800041bc <_Z8printIntiii>
    80003270:	00006517          	auipc	a0,0x6
    80003274:	fe850513          	addi	a0,a0,-24 # 80009258 <CONSOLE_STATUS+0x248>
    80003278:	00001097          	auipc	ra,0x1
    8000327c:	d94080e7          	jalr	-620(ra) # 8000400c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80003280:	00000493          	li	s1,0
    80003284:	f99ff06f          	j	8000321c <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80003288:	00006517          	auipc	a0,0x6
    8000328c:	e8050513          	addi	a0,a0,-384 # 80009108 <CONSOLE_STATUS+0xf8>
    80003290:	00001097          	auipc	ra,0x1
    80003294:	d7c080e7          	jalr	-644(ra) # 8000400c <_Z11printStringPKc>
    finishedA = true;
    80003298:	00100793          	li	a5,1
    8000329c:	00008717          	auipc	a4,0x8
    800032a0:	52f707a3          	sb	a5,1327(a4) # 8000b7cb <_ZL9finishedA>
}
    800032a4:	01813083          	ld	ra,24(sp)
    800032a8:	01013403          	ld	s0,16(sp)
    800032ac:	00813483          	ld	s1,8(sp)
    800032b0:	00013903          	ld	s2,0(sp)
    800032b4:	02010113          	addi	sp,sp,32
    800032b8:	00008067          	ret

00000000800032bc <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    800032bc:	fd010113          	addi	sp,sp,-48
    800032c0:	02113423          	sd	ra,40(sp)
    800032c4:	02813023          	sd	s0,32(sp)
    800032c8:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    800032cc:	00000613          	li	a2,0
    800032d0:	00000597          	auipc	a1,0x0
    800032d4:	f2058593          	addi	a1,a1,-224 # 800031f0 <_ZL11workerBodyAPv>
    800032d8:	fd040513          	addi	a0,s0,-48
    800032dc:	ffffe097          	auipc	ra,0xffffe
    800032e0:	12c080e7          	jalr	300(ra) # 80001408 <_Z13thread_createPP3PCBPFvPvES2_>
    printString("ThreadA created\n");
    800032e4:	00006517          	auipc	a0,0x6
    800032e8:	eb450513          	addi	a0,a0,-332 # 80009198 <CONSOLE_STATUS+0x188>
    800032ec:	00001097          	auipc	ra,0x1
    800032f0:	d20080e7          	jalr	-736(ra) # 8000400c <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    800032f4:	00000613          	li	a2,0
    800032f8:	00000597          	auipc	a1,0x0
    800032fc:	e2458593          	addi	a1,a1,-476 # 8000311c <_ZL11workerBodyBPv>
    80003300:	fd840513          	addi	a0,s0,-40
    80003304:	ffffe097          	auipc	ra,0xffffe
    80003308:	104080e7          	jalr	260(ra) # 80001408 <_Z13thread_createPP3PCBPFvPvES2_>
    printString("ThreadB created\n");
    8000330c:	00006517          	auipc	a0,0x6
    80003310:	ea450513          	addi	a0,a0,-348 # 800091b0 <CONSOLE_STATUS+0x1a0>
    80003314:	00001097          	auipc	ra,0x1
    80003318:	cf8080e7          	jalr	-776(ra) # 8000400c <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    8000331c:	00000613          	li	a2,0
    80003320:	00000597          	auipc	a1,0x0
    80003324:	c7c58593          	addi	a1,a1,-900 # 80002f9c <_ZL11workerBodyCPv>
    80003328:	fe040513          	addi	a0,s0,-32
    8000332c:	ffffe097          	auipc	ra,0xffffe
    80003330:	0dc080e7          	jalr	220(ra) # 80001408 <_Z13thread_createPP3PCBPFvPvES2_>
    printString("ThreadC created\n");
    80003334:	00006517          	auipc	a0,0x6
    80003338:	e9450513          	addi	a0,a0,-364 # 800091c8 <CONSOLE_STATUS+0x1b8>
    8000333c:	00001097          	auipc	ra,0x1
    80003340:	cd0080e7          	jalr	-816(ra) # 8000400c <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80003344:	00000613          	li	a2,0
    80003348:	00000597          	auipc	a1,0x0
    8000334c:	b0c58593          	addi	a1,a1,-1268 # 80002e54 <_ZL11workerBodyDPv>
    80003350:	fe840513          	addi	a0,s0,-24
    80003354:	ffffe097          	auipc	ra,0xffffe
    80003358:	0b4080e7          	jalr	180(ra) # 80001408 <_Z13thread_createPP3PCBPFvPvES2_>
    printString("ThreadD created\n");
    8000335c:	00006517          	auipc	a0,0x6
    80003360:	e8450513          	addi	a0,a0,-380 # 800091e0 <CONSOLE_STATUS+0x1d0>
    80003364:	00001097          	auipc	ra,0x1
    80003368:	ca8080e7          	jalr	-856(ra) # 8000400c <_Z11printStringPKc>
    8000336c:	00c0006f          	j	80003378 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80003370:	ffffe097          	auipc	ra,0xffffe
    80003374:	1f4080e7          	jalr	500(ra) # 80001564 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80003378:	00008797          	auipc	a5,0x8
    8000337c:	4537c783          	lbu	a5,1107(a5) # 8000b7cb <_ZL9finishedA>
    80003380:	fe0788e3          	beqz	a5,80003370 <_Z18Threads_C_API_testv+0xb4>
    80003384:	00008797          	auipc	a5,0x8
    80003388:	4467c783          	lbu	a5,1094(a5) # 8000b7ca <_ZL9finishedB>
    8000338c:	fe0782e3          	beqz	a5,80003370 <_Z18Threads_C_API_testv+0xb4>
    80003390:	00008797          	auipc	a5,0x8
    80003394:	4397c783          	lbu	a5,1081(a5) # 8000b7c9 <_ZL9finishedC>
    80003398:	fc078ce3          	beqz	a5,80003370 <_Z18Threads_C_API_testv+0xb4>
    8000339c:	00008797          	auipc	a5,0x8
    800033a0:	42c7c783          	lbu	a5,1068(a5) # 8000b7c8 <_ZL9finishedD>
    800033a4:	fc0786e3          	beqz	a5,80003370 <_Z18Threads_C_API_testv+0xb4>
    }

}
    800033a8:	02813083          	ld	ra,40(sp)
    800033ac:	02013403          	ld	s0,32(sp)
    800033b0:	03010113          	addi	sp,sp,48
    800033b4:	00008067          	ret

00000000800033b8 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    800033b8:	fd010113          	addi	sp,sp,-48
    800033bc:	02113423          	sd	ra,40(sp)
    800033c0:	02813023          	sd	s0,32(sp)
    800033c4:	00913c23          	sd	s1,24(sp)
    800033c8:	01213823          	sd	s2,16(sp)
    800033cc:	01313423          	sd	s3,8(sp)
    800033d0:	03010413          	addi	s0,sp,48
    800033d4:	00050993          	mv	s3,a0
    800033d8:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    800033dc:	00000913          	li	s2,0
    800033e0:	00c0006f          	j	800033ec <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    800033e4:	00002097          	auipc	ra,0x2
    800033e8:	cb0080e7          	jalr	-848(ra) # 80005094 <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 0x1b) {
    800033ec:	ffffe097          	auipc	ra,0xffffe
    800033f0:	360080e7          	jalr	864(ra) # 8000174c <_Z4getcv>
    800033f4:	0005059b          	sext.w	a1,a0
    800033f8:	01b00793          	li	a5,27
    800033fc:	02f58a63          	beq	a1,a5,80003430 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    80003400:	0084b503          	ld	a0,8(s1)
    80003404:	00001097          	auipc	ra,0x1
    80003408:	02c080e7          	jalr	44(ra) # 80004430 <_ZN9BufferCPP3putEi>
        i++;
    8000340c:	0019071b          	addiw	a4,s2,1
    80003410:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80003414:	0004a683          	lw	a3,0(s1)
    80003418:	0026979b          	slliw	a5,a3,0x2
    8000341c:	00d787bb          	addw	a5,a5,a3
    80003420:	0017979b          	slliw	a5,a5,0x1
    80003424:	02f767bb          	remw	a5,a4,a5
    80003428:	fc0792e3          	bnez	a5,800033ec <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    8000342c:	fb9ff06f          	j	800033e4 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    80003430:	00100793          	li	a5,1
    80003434:	00008717          	auipc	a4,0x8
    80003438:	38f72e23          	sw	a5,924(a4) # 8000b7d0 <_ZL9threadEnd>
    td->buffer->put('!');
    8000343c:	0209b783          	ld	a5,32(s3)
    80003440:	02100593          	li	a1,33
    80003444:	0087b503          	ld	a0,8(a5)
    80003448:	00001097          	auipc	ra,0x1
    8000344c:	fe8080e7          	jalr	-24(ra) # 80004430 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    80003450:	0104b503          	ld	a0,16(s1)
    80003454:	00002097          	auipc	ra,0x2
    80003458:	d80080e7          	jalr	-640(ra) # 800051d4 <_ZN9Semaphore6signalEv>
}
    8000345c:	02813083          	ld	ra,40(sp)
    80003460:	02013403          	ld	s0,32(sp)
    80003464:	01813483          	ld	s1,24(sp)
    80003468:	01013903          	ld	s2,16(sp)
    8000346c:	00813983          	ld	s3,8(sp)
    80003470:	03010113          	addi	sp,sp,48
    80003474:	00008067          	ret

0000000080003478 <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    80003478:	fe010113          	addi	sp,sp,-32
    8000347c:	00113c23          	sd	ra,24(sp)
    80003480:	00813823          	sd	s0,16(sp)
    80003484:	00913423          	sd	s1,8(sp)
    80003488:	01213023          	sd	s2,0(sp)
    8000348c:	02010413          	addi	s0,sp,32
    80003490:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80003494:	00000913          	li	s2,0
    80003498:	00c0006f          	j	800034a4 <_ZN12ProducerSync8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    8000349c:	00002097          	auipc	ra,0x2
    800034a0:	bf8080e7          	jalr	-1032(ra) # 80005094 <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    800034a4:	00008797          	auipc	a5,0x8
    800034a8:	32c7a783          	lw	a5,812(a5) # 8000b7d0 <_ZL9threadEnd>
    800034ac:	02079e63          	bnez	a5,800034e8 <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    800034b0:	0004a583          	lw	a1,0(s1)
    800034b4:	0305859b          	addiw	a1,a1,48
    800034b8:	0084b503          	ld	a0,8(s1)
    800034bc:	00001097          	auipc	ra,0x1
    800034c0:	f74080e7          	jalr	-140(ra) # 80004430 <_ZN9BufferCPP3putEi>
        i++;
    800034c4:	0019071b          	addiw	a4,s2,1
    800034c8:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800034cc:	0004a683          	lw	a3,0(s1)
    800034d0:	0026979b          	slliw	a5,a3,0x2
    800034d4:	00d787bb          	addw	a5,a5,a3
    800034d8:	0017979b          	slliw	a5,a5,0x1
    800034dc:	02f767bb          	remw	a5,a4,a5
    800034e0:	fc0792e3          	bnez	a5,800034a4 <_ZN12ProducerSync8producerEPv+0x2c>
    800034e4:	fb9ff06f          	j	8000349c <_ZN12ProducerSync8producerEPv+0x24>
        }
    }

    data->wait->signal();
    800034e8:	0104b503          	ld	a0,16(s1)
    800034ec:	00002097          	auipc	ra,0x2
    800034f0:	ce8080e7          	jalr	-792(ra) # 800051d4 <_ZN9Semaphore6signalEv>
}
    800034f4:	01813083          	ld	ra,24(sp)
    800034f8:	01013403          	ld	s0,16(sp)
    800034fc:	00813483          	ld	s1,8(sp)
    80003500:	00013903          	ld	s2,0(sp)
    80003504:	02010113          	addi	sp,sp,32
    80003508:	00008067          	ret

000000008000350c <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    8000350c:	fd010113          	addi	sp,sp,-48
    80003510:	02113423          	sd	ra,40(sp)
    80003514:	02813023          	sd	s0,32(sp)
    80003518:	00913c23          	sd	s1,24(sp)
    8000351c:	01213823          	sd	s2,16(sp)
    80003520:	01313423          	sd	s3,8(sp)
    80003524:	01413023          	sd	s4,0(sp)
    80003528:	03010413          	addi	s0,sp,48
    8000352c:	00050993          	mv	s3,a0
    80003530:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80003534:	00000a13          	li	s4,0
    80003538:	01c0006f          	j	80003554 <_ZN12ConsumerSync8consumerEPv+0x48>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    8000353c:	00002097          	auipc	ra,0x2
    80003540:	b58080e7          	jalr	-1192(ra) # 80005094 <_ZN6Thread8dispatchEv>
    80003544:	0500006f          	j	80003594 <_ZN12ConsumerSync8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    80003548:	00a00513          	li	a0,10
    8000354c:	ffffe097          	auipc	ra,0xffffe
    80003550:	234080e7          	jalr	564(ra) # 80001780 <_Z4putcc>
    while (!threadEnd) {
    80003554:	00008797          	auipc	a5,0x8
    80003558:	27c7a783          	lw	a5,636(a5) # 8000b7d0 <_ZL9threadEnd>
    8000355c:	06079263          	bnez	a5,800035c0 <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    80003560:	00893503          	ld	a0,8(s2)
    80003564:	00001097          	auipc	ra,0x1
    80003568:	f5c080e7          	jalr	-164(ra) # 800044c0 <_ZN9BufferCPP3getEv>
        i++;
    8000356c:	001a049b          	addiw	s1,s4,1
    80003570:	00048a1b          	sext.w	s4,s1
        putc(key);
    80003574:	0ff57513          	andi	a0,a0,255
    80003578:	ffffe097          	auipc	ra,0xffffe
    8000357c:	208080e7          	jalr	520(ra) # 80001780 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80003580:	00092703          	lw	a4,0(s2)
    80003584:	0027179b          	slliw	a5,a4,0x2
    80003588:	00e787bb          	addw	a5,a5,a4
    8000358c:	02f4e7bb          	remw	a5,s1,a5
    80003590:	fa0786e3          	beqz	a5,8000353c <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    80003594:	05000793          	li	a5,80
    80003598:	02f4e4bb          	remw	s1,s1,a5
    8000359c:	fa049ce3          	bnez	s1,80003554 <_ZN12ConsumerSync8consumerEPv+0x48>
    800035a0:	fa9ff06f          	j	80003548 <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    800035a4:	0209b783          	ld	a5,32(s3)
    800035a8:	0087b503          	ld	a0,8(a5)
    800035ac:	00001097          	auipc	ra,0x1
    800035b0:	f14080e7          	jalr	-236(ra) # 800044c0 <_ZN9BufferCPP3getEv>
        Console::putc(key);
    800035b4:	0ff57513          	andi	a0,a0,255
    800035b8:	00002097          	auipc	ra,0x2
    800035bc:	c70080e7          	jalr	-912(ra) # 80005228 <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    800035c0:	0209b783          	ld	a5,32(s3)
    800035c4:	0087b503          	ld	a0,8(a5)
    800035c8:	00001097          	auipc	ra,0x1
    800035cc:	f84080e7          	jalr	-124(ra) # 8000454c <_ZN9BufferCPP6getCntEv>
    800035d0:	fca04ae3          	bgtz	a0,800035a4 <_ZN12ConsumerSync8consumerEPv+0x98>
    }

    data->wait->signal();
    800035d4:	01093503          	ld	a0,16(s2)
    800035d8:	00002097          	auipc	ra,0x2
    800035dc:	bfc080e7          	jalr	-1028(ra) # 800051d4 <_ZN9Semaphore6signalEv>
}
    800035e0:	02813083          	ld	ra,40(sp)
    800035e4:	02013403          	ld	s0,32(sp)
    800035e8:	01813483          	ld	s1,24(sp)
    800035ec:	01013903          	ld	s2,16(sp)
    800035f0:	00813983          	ld	s3,8(sp)
    800035f4:	00013a03          	ld	s4,0(sp)
    800035f8:	03010113          	addi	sp,sp,48
    800035fc:	00008067          	ret

0000000080003600 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    80003600:	f8010113          	addi	sp,sp,-128
    80003604:	06113c23          	sd	ra,120(sp)
    80003608:	06813823          	sd	s0,112(sp)
    8000360c:	06913423          	sd	s1,104(sp)
    80003610:	07213023          	sd	s2,96(sp)
    80003614:	05313c23          	sd	s3,88(sp)
    80003618:	05413823          	sd	s4,80(sp)
    8000361c:	05513423          	sd	s5,72(sp)
    80003620:	05613023          	sd	s6,64(sp)
    80003624:	03713c23          	sd	s7,56(sp)
    80003628:	03813823          	sd	s8,48(sp)
    8000362c:	03913423          	sd	s9,40(sp)
    80003630:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    80003634:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    80003638:	00006517          	auipc	a0,0x6
    8000363c:	9e850513          	addi	a0,a0,-1560 # 80009020 <CONSOLE_STATUS+0x10>
    80003640:	00001097          	auipc	ra,0x1
    80003644:	9cc080e7          	jalr	-1588(ra) # 8000400c <_Z11printStringPKc>
    getString(input, 30);
    80003648:	01e00593          	li	a1,30
    8000364c:	f8040493          	addi	s1,s0,-128
    80003650:	00048513          	mv	a0,s1
    80003654:	00001097          	auipc	ra,0x1
    80003658:	a40080e7          	jalr	-1472(ra) # 80004094 <_Z9getStringPci>
    threadNum = stringToInt(input);
    8000365c:	00048513          	mv	a0,s1
    80003660:	00001097          	auipc	ra,0x1
    80003664:	b0c080e7          	jalr	-1268(ra) # 8000416c <_Z11stringToIntPKc>
    80003668:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    8000366c:	00006517          	auipc	a0,0x6
    80003670:	9d450513          	addi	a0,a0,-1580 # 80009040 <CONSOLE_STATUS+0x30>
    80003674:	00001097          	auipc	ra,0x1
    80003678:	998080e7          	jalr	-1640(ra) # 8000400c <_Z11printStringPKc>
    getString(input, 30);
    8000367c:	01e00593          	li	a1,30
    80003680:	00048513          	mv	a0,s1
    80003684:	00001097          	auipc	ra,0x1
    80003688:	a10080e7          	jalr	-1520(ra) # 80004094 <_Z9getStringPci>
    n = stringToInt(input);
    8000368c:	00048513          	mv	a0,s1
    80003690:	00001097          	auipc	ra,0x1
    80003694:	adc080e7          	jalr	-1316(ra) # 8000416c <_Z11stringToIntPKc>
    80003698:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    8000369c:	00006517          	auipc	a0,0x6
    800036a0:	9c450513          	addi	a0,a0,-1596 # 80009060 <CONSOLE_STATUS+0x50>
    800036a4:	00001097          	auipc	ra,0x1
    800036a8:	968080e7          	jalr	-1688(ra) # 8000400c <_Z11printStringPKc>
    800036ac:	00000613          	li	a2,0
    800036b0:	00a00593          	li	a1,10
    800036b4:	00090513          	mv	a0,s2
    800036b8:	00001097          	auipc	ra,0x1
    800036bc:	b04080e7          	jalr	-1276(ra) # 800041bc <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    800036c0:	00006517          	auipc	a0,0x6
    800036c4:	9b850513          	addi	a0,a0,-1608 # 80009078 <CONSOLE_STATUS+0x68>
    800036c8:	00001097          	auipc	ra,0x1
    800036cc:	944080e7          	jalr	-1724(ra) # 8000400c <_Z11printStringPKc>
    800036d0:	00000613          	li	a2,0
    800036d4:	00a00593          	li	a1,10
    800036d8:	00048513          	mv	a0,s1
    800036dc:	00001097          	auipc	ra,0x1
    800036e0:	ae0080e7          	jalr	-1312(ra) # 800041bc <_Z8printIntiii>
    printString(".\n");
    800036e4:	00006517          	auipc	a0,0x6
    800036e8:	9ac50513          	addi	a0,a0,-1620 # 80009090 <CONSOLE_STATUS+0x80>
    800036ec:	00001097          	auipc	ra,0x1
    800036f0:	920080e7          	jalr	-1760(ra) # 8000400c <_Z11printStringPKc>
    if(threadNum > n) {
    800036f4:	0324c463          	blt	s1,s2,8000371c <_Z29producerConsumer_CPP_Sync_APIv+0x11c>
    } else if (threadNum < 1) {
    800036f8:	03205c63          	blez	s2,80003730 <_Z29producerConsumer_CPP_Sync_APIv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    800036fc:	03800513          	li	a0,56
    80003700:	00001097          	auipc	ra,0x1
    80003704:	7c8080e7          	jalr	1992(ra) # 80004ec8 <_Znwm>
    80003708:	00050a93          	mv	s5,a0
    8000370c:	00048593          	mv	a1,s1
    80003710:	00001097          	auipc	ra,0x1
    80003714:	bcc080e7          	jalr	-1076(ra) # 800042dc <_ZN9BufferCPPC1Ei>
    80003718:	0300006f          	j	80003748 <_Z29producerConsumer_CPP_Sync_APIv+0x148>
        printString("Broj proizvodjaca ne sme biti veci od velicine bafera!\n");
    8000371c:	00006517          	auipc	a0,0x6
    80003720:	97c50513          	addi	a0,a0,-1668 # 80009098 <CONSOLE_STATUS+0x88>
    80003724:	00001097          	auipc	ra,0x1
    80003728:	8e8080e7          	jalr	-1816(ra) # 8000400c <_Z11printStringPKc>
        return;
    8000372c:	0140006f          	j	80003740 <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80003730:	00006517          	auipc	a0,0x6
    80003734:	9a050513          	addi	a0,a0,-1632 # 800090d0 <CONSOLE_STATUS+0xc0>
    80003738:	00001097          	auipc	ra,0x1
    8000373c:	8d4080e7          	jalr	-1836(ra) # 8000400c <_Z11printStringPKc>
        return;
    80003740:	000b8113          	mv	sp,s7
    80003744:	2380006f          	j	8000397c <_Z29producerConsumer_CPP_Sync_APIv+0x37c>
    waitForAll = new Semaphore(0);
    80003748:	01000513          	li	a0,16
    8000374c:	00001097          	auipc	ra,0x1
    80003750:	77c080e7          	jalr	1916(ra) # 80004ec8 <_Znwm>
    80003754:	00050493          	mv	s1,a0
    80003758:	00000593          	li	a1,0
    8000375c:	00002097          	auipc	ra,0x2
    80003760:	a14080e7          	jalr	-1516(ra) # 80005170 <_ZN9SemaphoreC1Ej>
    80003764:	00008797          	auipc	a5,0x8
    80003768:	0697ba23          	sd	s1,116(a5) # 8000b7d8 <_ZL10waitForAll>
    Thread* threads[threadNum];
    8000376c:	00391793          	slli	a5,s2,0x3
    80003770:	00f78793          	addi	a5,a5,15
    80003774:	ff07f793          	andi	a5,a5,-16
    80003778:	40f10133          	sub	sp,sp,a5
    8000377c:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    80003780:	0019071b          	addiw	a4,s2,1
    80003784:	00171793          	slli	a5,a4,0x1
    80003788:	00e787b3          	add	a5,a5,a4
    8000378c:	00379793          	slli	a5,a5,0x3
    80003790:	00f78793          	addi	a5,a5,15
    80003794:	ff07f793          	andi	a5,a5,-16
    80003798:	40f10133          	sub	sp,sp,a5
    8000379c:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    800037a0:	00191c13          	slli	s8,s2,0x1
    800037a4:	012c07b3          	add	a5,s8,s2
    800037a8:	00379793          	slli	a5,a5,0x3
    800037ac:	00fa07b3          	add	a5,s4,a5
    800037b0:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    800037b4:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    800037b8:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    800037bc:	02800513          	li	a0,40
    800037c0:	00001097          	auipc	ra,0x1
    800037c4:	708080e7          	jalr	1800(ra) # 80004ec8 <_Znwm>
    800037c8:	00050b13          	mv	s6,a0
    800037cc:	012c0c33          	add	s8,s8,s2
    800037d0:	003c1c13          	slli	s8,s8,0x3
    800037d4:	018a0c33          	add	s8,s4,s8
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    800037d8:	00002097          	auipc	ra,0x2
    800037dc:	934080e7          	jalr	-1740(ra) # 8000510c <_ZN6ThreadC1Ev>
    800037e0:	00008797          	auipc	a5,0x8
    800037e4:	e8078793          	addi	a5,a5,-384 # 8000b660 <_ZTV12ConsumerSync+0x10>
    800037e8:	00fb3023          	sd	a5,0(s6)
    800037ec:	038b3023          	sd	s8,32(s6)
    consumerThread->start();
    800037f0:	000b0513          	mv	a0,s6
    800037f4:	00002097          	auipc	ra,0x2
    800037f8:	844080e7          	jalr	-1980(ra) # 80005038 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    800037fc:	00000493          	li	s1,0
    80003800:	0380006f          	j	80003838 <_Z29producerConsumer_CPP_Sync_APIv+0x238>
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80003804:	00008797          	auipc	a5,0x8
    80003808:	e3478793          	addi	a5,a5,-460 # 8000b638 <_ZTV12ProducerSync+0x10>
    8000380c:	00fcb023          	sd	a5,0(s9)
    80003810:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerSync(data+i);
    80003814:	00349793          	slli	a5,s1,0x3
    80003818:	00f987b3          	add	a5,s3,a5
    8000381c:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    80003820:	00349793          	slli	a5,s1,0x3
    80003824:	00f987b3          	add	a5,s3,a5
    80003828:	0007b503          	ld	a0,0(a5)
    8000382c:	00002097          	auipc	ra,0x2
    80003830:	80c080e7          	jalr	-2036(ra) # 80005038 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80003834:	0014849b          	addiw	s1,s1,1
    80003838:	0b24d063          	bge	s1,s2,800038d8 <_Z29producerConsumer_CPP_Sync_APIv+0x2d8>
        data[i].id = i;
    8000383c:	00149793          	slli	a5,s1,0x1
    80003840:	009787b3          	add	a5,a5,s1
    80003844:	00379793          	slli	a5,a5,0x3
    80003848:	00fa07b3          	add	a5,s4,a5
    8000384c:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80003850:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    80003854:	00008717          	auipc	a4,0x8
    80003858:	f8473703          	ld	a4,-124(a4) # 8000b7d8 <_ZL10waitForAll>
    8000385c:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    80003860:	02905863          	blez	s1,80003890 <_Z29producerConsumer_CPP_Sync_APIv+0x290>
            threads[i] = new ProducerSync(data+i);
    80003864:	02800513          	li	a0,40
    80003868:	00001097          	auipc	ra,0x1
    8000386c:	660080e7          	jalr	1632(ra) # 80004ec8 <_Znwm>
    80003870:	00050c93          	mv	s9,a0
    80003874:	00149c13          	slli	s8,s1,0x1
    80003878:	009c0c33          	add	s8,s8,s1
    8000387c:	003c1c13          	slli	s8,s8,0x3
    80003880:	018a0c33          	add	s8,s4,s8
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80003884:	00002097          	auipc	ra,0x2
    80003888:	888080e7          	jalr	-1912(ra) # 8000510c <_ZN6ThreadC1Ev>
    8000388c:	f79ff06f          	j	80003804 <_Z29producerConsumer_CPP_Sync_APIv+0x204>
            threads[i] = new ProducerKeyboard(data+i);
    80003890:	02800513          	li	a0,40
    80003894:	00001097          	auipc	ra,0x1
    80003898:	634080e7          	jalr	1588(ra) # 80004ec8 <_Znwm>
    8000389c:	00050c93          	mv	s9,a0
    800038a0:	00149c13          	slli	s8,s1,0x1
    800038a4:	009c0c33          	add	s8,s8,s1
    800038a8:	003c1c13          	slli	s8,s8,0x3
    800038ac:	018a0c33          	add	s8,s4,s8
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    800038b0:	00002097          	auipc	ra,0x2
    800038b4:	85c080e7          	jalr	-1956(ra) # 8000510c <_ZN6ThreadC1Ev>
    800038b8:	00008797          	auipc	a5,0x8
    800038bc:	d5878793          	addi	a5,a5,-680 # 8000b610 <_ZTV16ProducerKeyboard+0x10>
    800038c0:	00fcb023          	sd	a5,0(s9)
    800038c4:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerKeyboard(data+i);
    800038c8:	00349793          	slli	a5,s1,0x3
    800038cc:	00f987b3          	add	a5,s3,a5
    800038d0:	0197b023          	sd	s9,0(a5)
    800038d4:	f4dff06f          	j	80003820 <_Z29producerConsumer_CPP_Sync_APIv+0x220>
    Thread::dispatch();
    800038d8:	00001097          	auipc	ra,0x1
    800038dc:	7bc080e7          	jalr	1980(ra) # 80005094 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    800038e0:	00000493          	li	s1,0
    800038e4:	00994e63          	blt	s2,s1,80003900 <_Z29producerConsumer_CPP_Sync_APIv+0x300>
        waitForAll->wait();
    800038e8:	00008517          	auipc	a0,0x8
    800038ec:	ef053503          	ld	a0,-272(a0) # 8000b7d8 <_ZL10waitForAll>
    800038f0:	00002097          	auipc	ra,0x2
    800038f4:	8b8080e7          	jalr	-1864(ra) # 800051a8 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    800038f8:	0014849b          	addiw	s1,s1,1
    800038fc:	fe9ff06f          	j	800038e4 <_Z29producerConsumer_CPP_Sync_APIv+0x2e4>
    for (int i = 0; i < threadNum; i++) {
    80003900:	00000493          	li	s1,0
    80003904:	0080006f          	j	8000390c <_Z29producerConsumer_CPP_Sync_APIv+0x30c>
    80003908:	0014849b          	addiw	s1,s1,1
    8000390c:	0324d263          	bge	s1,s2,80003930 <_Z29producerConsumer_CPP_Sync_APIv+0x330>
        delete threads[i];
    80003910:	00349793          	slli	a5,s1,0x3
    80003914:	00f987b3          	add	a5,s3,a5
    80003918:	0007b503          	ld	a0,0(a5)
    8000391c:	fe0506e3          	beqz	a0,80003908 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    80003920:	00053783          	ld	a5,0(a0)
    80003924:	0087b783          	ld	a5,8(a5)
    80003928:	000780e7          	jalr	a5
    8000392c:	fddff06f          	j	80003908 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    delete consumerThread;
    80003930:	000b0a63          	beqz	s6,80003944 <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    80003934:	000b3783          	ld	a5,0(s6)
    80003938:	0087b783          	ld	a5,8(a5)
    8000393c:	000b0513          	mv	a0,s6
    80003940:	000780e7          	jalr	a5
    delete waitForAll;
    80003944:	00008517          	auipc	a0,0x8
    80003948:	e9453503          	ld	a0,-364(a0) # 8000b7d8 <_ZL10waitForAll>
    8000394c:	00050863          	beqz	a0,8000395c <_Z29producerConsumer_CPP_Sync_APIv+0x35c>
    80003950:	00053783          	ld	a5,0(a0)
    80003954:	0087b783          	ld	a5,8(a5)
    80003958:	000780e7          	jalr	a5
    delete buffer;
    8000395c:	000a8e63          	beqz	s5,80003978 <_Z29producerConsumer_CPP_Sync_APIv+0x378>
    80003960:	000a8513          	mv	a0,s5
    80003964:	00001097          	auipc	ra,0x1
    80003968:	c70080e7          	jalr	-912(ra) # 800045d4 <_ZN9BufferCPPD1Ev>
    8000396c:	000a8513          	mv	a0,s5
    80003970:	00001097          	auipc	ra,0x1
    80003974:	5d8080e7          	jalr	1496(ra) # 80004f48 <_ZdlPv>
    80003978:	000b8113          	mv	sp,s7

}
    8000397c:	f8040113          	addi	sp,s0,-128
    80003980:	07813083          	ld	ra,120(sp)
    80003984:	07013403          	ld	s0,112(sp)
    80003988:	06813483          	ld	s1,104(sp)
    8000398c:	06013903          	ld	s2,96(sp)
    80003990:	05813983          	ld	s3,88(sp)
    80003994:	05013a03          	ld	s4,80(sp)
    80003998:	04813a83          	ld	s5,72(sp)
    8000399c:	04013b03          	ld	s6,64(sp)
    800039a0:	03813b83          	ld	s7,56(sp)
    800039a4:	03013c03          	ld	s8,48(sp)
    800039a8:	02813c83          	ld	s9,40(sp)
    800039ac:	08010113          	addi	sp,sp,128
    800039b0:	00008067          	ret
    800039b4:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    800039b8:	000a8513          	mv	a0,s5
    800039bc:	00001097          	auipc	ra,0x1
    800039c0:	58c080e7          	jalr	1420(ra) # 80004f48 <_ZdlPv>
    800039c4:	00048513          	mv	a0,s1
    800039c8:	00009097          	auipc	ra,0x9
    800039cc:	f60080e7          	jalr	-160(ra) # 8000c928 <_Unwind_Resume>
    800039d0:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    800039d4:	00048513          	mv	a0,s1
    800039d8:	00001097          	auipc	ra,0x1
    800039dc:	570080e7          	jalr	1392(ra) # 80004f48 <_ZdlPv>
    800039e0:	00090513          	mv	a0,s2
    800039e4:	00009097          	auipc	ra,0x9
    800039e8:	f44080e7          	jalr	-188(ra) # 8000c928 <_Unwind_Resume>
    800039ec:	00050493          	mv	s1,a0
    consumerThread = new ConsumerSync(data+threadNum);
    800039f0:	000b0513          	mv	a0,s6
    800039f4:	00001097          	auipc	ra,0x1
    800039f8:	554080e7          	jalr	1364(ra) # 80004f48 <_ZdlPv>
    800039fc:	00048513          	mv	a0,s1
    80003a00:	00009097          	auipc	ra,0x9
    80003a04:	f28080e7          	jalr	-216(ra) # 8000c928 <_Unwind_Resume>
    80003a08:	00050493          	mv	s1,a0
            threads[i] = new ProducerSync(data+i);
    80003a0c:	000c8513          	mv	a0,s9
    80003a10:	00001097          	auipc	ra,0x1
    80003a14:	538080e7          	jalr	1336(ra) # 80004f48 <_ZdlPv>
    80003a18:	00048513          	mv	a0,s1
    80003a1c:	00009097          	auipc	ra,0x9
    80003a20:	f0c080e7          	jalr	-244(ra) # 8000c928 <_Unwind_Resume>
    80003a24:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    80003a28:	000c8513          	mv	a0,s9
    80003a2c:	00001097          	auipc	ra,0x1
    80003a30:	51c080e7          	jalr	1308(ra) # 80004f48 <_ZdlPv>
    80003a34:	00048513          	mv	a0,s1
    80003a38:	00009097          	auipc	ra,0x9
    80003a3c:	ef0080e7          	jalr	-272(ra) # 8000c928 <_Unwind_Resume>

0000000080003a40 <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    80003a40:	ff010113          	addi	sp,sp,-16
    80003a44:	00113423          	sd	ra,8(sp)
    80003a48:	00813023          	sd	s0,0(sp)
    80003a4c:	01010413          	addi	s0,sp,16
    80003a50:	00008797          	auipc	a5,0x8
    80003a54:	c1078793          	addi	a5,a5,-1008 # 8000b660 <_ZTV12ConsumerSync+0x10>
    80003a58:	00f53023          	sd	a5,0(a0)
    80003a5c:	00001097          	auipc	ra,0x1
    80003a60:	3b0080e7          	jalr	944(ra) # 80004e0c <_ZN6ThreadD1Ev>
    80003a64:	00813083          	ld	ra,8(sp)
    80003a68:	00013403          	ld	s0,0(sp)
    80003a6c:	01010113          	addi	sp,sp,16
    80003a70:	00008067          	ret

0000000080003a74 <_ZN12ConsumerSyncD0Ev>:
    80003a74:	fe010113          	addi	sp,sp,-32
    80003a78:	00113c23          	sd	ra,24(sp)
    80003a7c:	00813823          	sd	s0,16(sp)
    80003a80:	00913423          	sd	s1,8(sp)
    80003a84:	02010413          	addi	s0,sp,32
    80003a88:	00050493          	mv	s1,a0
    80003a8c:	00008797          	auipc	a5,0x8
    80003a90:	bd478793          	addi	a5,a5,-1068 # 8000b660 <_ZTV12ConsumerSync+0x10>
    80003a94:	00f53023          	sd	a5,0(a0)
    80003a98:	00001097          	auipc	ra,0x1
    80003a9c:	374080e7          	jalr	884(ra) # 80004e0c <_ZN6ThreadD1Ev>
    80003aa0:	00048513          	mv	a0,s1
    80003aa4:	00001097          	auipc	ra,0x1
    80003aa8:	4a4080e7          	jalr	1188(ra) # 80004f48 <_ZdlPv>
    80003aac:	01813083          	ld	ra,24(sp)
    80003ab0:	01013403          	ld	s0,16(sp)
    80003ab4:	00813483          	ld	s1,8(sp)
    80003ab8:	02010113          	addi	sp,sp,32
    80003abc:	00008067          	ret

0000000080003ac0 <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    80003ac0:	ff010113          	addi	sp,sp,-16
    80003ac4:	00113423          	sd	ra,8(sp)
    80003ac8:	00813023          	sd	s0,0(sp)
    80003acc:	01010413          	addi	s0,sp,16
    80003ad0:	00008797          	auipc	a5,0x8
    80003ad4:	b6878793          	addi	a5,a5,-1176 # 8000b638 <_ZTV12ProducerSync+0x10>
    80003ad8:	00f53023          	sd	a5,0(a0)
    80003adc:	00001097          	auipc	ra,0x1
    80003ae0:	330080e7          	jalr	816(ra) # 80004e0c <_ZN6ThreadD1Ev>
    80003ae4:	00813083          	ld	ra,8(sp)
    80003ae8:	00013403          	ld	s0,0(sp)
    80003aec:	01010113          	addi	sp,sp,16
    80003af0:	00008067          	ret

0000000080003af4 <_ZN12ProducerSyncD0Ev>:
    80003af4:	fe010113          	addi	sp,sp,-32
    80003af8:	00113c23          	sd	ra,24(sp)
    80003afc:	00813823          	sd	s0,16(sp)
    80003b00:	00913423          	sd	s1,8(sp)
    80003b04:	02010413          	addi	s0,sp,32
    80003b08:	00050493          	mv	s1,a0
    80003b0c:	00008797          	auipc	a5,0x8
    80003b10:	b2c78793          	addi	a5,a5,-1236 # 8000b638 <_ZTV12ProducerSync+0x10>
    80003b14:	00f53023          	sd	a5,0(a0)
    80003b18:	00001097          	auipc	ra,0x1
    80003b1c:	2f4080e7          	jalr	756(ra) # 80004e0c <_ZN6ThreadD1Ev>
    80003b20:	00048513          	mv	a0,s1
    80003b24:	00001097          	auipc	ra,0x1
    80003b28:	424080e7          	jalr	1060(ra) # 80004f48 <_ZdlPv>
    80003b2c:	01813083          	ld	ra,24(sp)
    80003b30:	01013403          	ld	s0,16(sp)
    80003b34:	00813483          	ld	s1,8(sp)
    80003b38:	02010113          	addi	sp,sp,32
    80003b3c:	00008067          	ret

0000000080003b40 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    80003b40:	ff010113          	addi	sp,sp,-16
    80003b44:	00113423          	sd	ra,8(sp)
    80003b48:	00813023          	sd	s0,0(sp)
    80003b4c:	01010413          	addi	s0,sp,16
    80003b50:	00008797          	auipc	a5,0x8
    80003b54:	ac078793          	addi	a5,a5,-1344 # 8000b610 <_ZTV16ProducerKeyboard+0x10>
    80003b58:	00f53023          	sd	a5,0(a0)
    80003b5c:	00001097          	auipc	ra,0x1
    80003b60:	2b0080e7          	jalr	688(ra) # 80004e0c <_ZN6ThreadD1Ev>
    80003b64:	00813083          	ld	ra,8(sp)
    80003b68:	00013403          	ld	s0,0(sp)
    80003b6c:	01010113          	addi	sp,sp,16
    80003b70:	00008067          	ret

0000000080003b74 <_ZN16ProducerKeyboardD0Ev>:
    80003b74:	fe010113          	addi	sp,sp,-32
    80003b78:	00113c23          	sd	ra,24(sp)
    80003b7c:	00813823          	sd	s0,16(sp)
    80003b80:	00913423          	sd	s1,8(sp)
    80003b84:	02010413          	addi	s0,sp,32
    80003b88:	00050493          	mv	s1,a0
    80003b8c:	00008797          	auipc	a5,0x8
    80003b90:	a8478793          	addi	a5,a5,-1404 # 8000b610 <_ZTV16ProducerKeyboard+0x10>
    80003b94:	00f53023          	sd	a5,0(a0)
    80003b98:	00001097          	auipc	ra,0x1
    80003b9c:	274080e7          	jalr	628(ra) # 80004e0c <_ZN6ThreadD1Ev>
    80003ba0:	00048513          	mv	a0,s1
    80003ba4:	00001097          	auipc	ra,0x1
    80003ba8:	3a4080e7          	jalr	932(ra) # 80004f48 <_ZdlPv>
    80003bac:	01813083          	ld	ra,24(sp)
    80003bb0:	01013403          	ld	s0,16(sp)
    80003bb4:	00813483          	ld	s1,8(sp)
    80003bb8:	02010113          	addi	sp,sp,32
    80003bbc:	00008067          	ret

0000000080003bc0 <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80003bc0:	ff010113          	addi	sp,sp,-16
    80003bc4:	00113423          	sd	ra,8(sp)
    80003bc8:	00813023          	sd	s0,0(sp)
    80003bcc:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80003bd0:	02053583          	ld	a1,32(a0)
    80003bd4:	fffff097          	auipc	ra,0xfffff
    80003bd8:	7e4080e7          	jalr	2020(ra) # 800033b8 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80003bdc:	00813083          	ld	ra,8(sp)
    80003be0:	00013403          	ld	s0,0(sp)
    80003be4:	01010113          	addi	sp,sp,16
    80003be8:	00008067          	ret

0000000080003bec <_ZN12ProducerSync3runEv>:
    void run() override {
    80003bec:	ff010113          	addi	sp,sp,-16
    80003bf0:	00113423          	sd	ra,8(sp)
    80003bf4:	00813023          	sd	s0,0(sp)
    80003bf8:	01010413          	addi	s0,sp,16
        producer(td);
    80003bfc:	02053583          	ld	a1,32(a0)
    80003c00:	00000097          	auipc	ra,0x0
    80003c04:	878080e7          	jalr	-1928(ra) # 80003478 <_ZN12ProducerSync8producerEPv>
    }
    80003c08:	00813083          	ld	ra,8(sp)
    80003c0c:	00013403          	ld	s0,0(sp)
    80003c10:	01010113          	addi	sp,sp,16
    80003c14:	00008067          	ret

0000000080003c18 <_ZN12ConsumerSync3runEv>:
    void run() override {
    80003c18:	ff010113          	addi	sp,sp,-16
    80003c1c:	00113423          	sd	ra,8(sp)
    80003c20:	00813023          	sd	s0,0(sp)
    80003c24:	01010413          	addi	s0,sp,16
        consumer(td);
    80003c28:	02053583          	ld	a1,32(a0)
    80003c2c:	00000097          	auipc	ra,0x0
    80003c30:	8e0080e7          	jalr	-1824(ra) # 8000350c <_ZN12ConsumerSync8consumerEPv>
    }
    80003c34:	00813083          	ld	ra,8(sp)
    80003c38:	00013403          	ld	s0,0(sp)
    80003c3c:	01010113          	addi	sp,sp,16
    80003c40:	00008067          	ret

0000000080003c44 <_ZN3PCB13threadWrapperEv>:
    }
    return 0;
}

void PCB::threadWrapper()
{
    80003c44:	fe010113          	addi	sp,sp,-32
    80003c48:	00113c23          	sd	ra,24(sp)
    80003c4c:	00813823          	sd	s0,16(sp)
    80003c50:	00913423          	sd	s1,8(sp)
    80003c54:	02010413          	addi	s0,sp,32
    Riscv::popSppSpie();
    80003c58:	00001097          	auipc	ra,0x1
    80003c5c:	770080e7          	jalr	1904(ra) # 800053c8 <_ZN5Riscv10popSppSpieEv>
    running->body(running->arg);
    80003c60:	00008497          	auipc	s1,0x8
    80003c64:	b8048493          	addi	s1,s1,-1152 # 8000b7e0 <_ZN3PCB7runningE>
    80003c68:	0004b783          	ld	a5,0(s1)
    80003c6c:	0007b703          	ld	a4,0(a5)
    80003c70:	0087b503          	ld	a0,8(a5)
    80003c74:	000700e7          	jalr	a4
    running->setFinished(true);
    80003c78:	0004b783          	ld	a5,0(s1)
    enum State {NEW, READY, RUNNING, BLOCKED, FINISHED};
    ~PCB(){ delete[] stack;}

    bool isFinished() const { return finished;}
    void setFinished(bool value) {
        state = FINISHED;
    80003c7c:	00400713          	li	a4,4
    80003c80:	02e7a423          	sw	a4,40(a5)
        finished = value;
    80003c84:	00100713          	li	a4,1
    80003c88:	02e78623          	sb	a4,44(a5)
    running->state = FINISHED;
    thread_dispatch();
    80003c8c:	ffffe097          	auipc	ra,0xffffe
    80003c90:	8d8080e7          	jalr	-1832(ra) # 80001564 <_Z15thread_dispatchv>
    80003c94:	01813083          	ld	ra,24(sp)
    80003c98:	01013403          	ld	s0,16(sp)
    80003c9c:	00813483          	ld	s1,8(sp)
    80003ca0:	02010113          	addi	sp,sp,32
    80003ca4:	00008067          	ret

0000000080003ca8 <_ZN3PCB10initializeEPFvPvES0_Pm>:
PCB* PCB::initialize(Body body, void* arg, uint64* stack){
    80003ca8:	fd010113          	addi	sp,sp,-48
    80003cac:	02113423          	sd	ra,40(sp)
    80003cb0:	02813023          	sd	s0,32(sp)
    80003cb4:	00913c23          	sd	s1,24(sp)
    80003cb8:	01213823          	sd	s2,16(sp)
    80003cbc:	01313423          	sd	s3,8(sp)
    80003cc0:	03010413          	addi	s0,sp,48
    80003cc4:	00050913          	mv	s2,a0
    80003cc8:	00058993          	mv	s3,a1
    80003ccc:	00060493          	mv	s1,a2
            size/=MEM_BLOCK_SIZE;
            ++size;
        } else {
            size/=MEM_BLOCK_SIZE;
        }
        return MemoryAllocator::mem_alloc(size);
    80003cd0:	00100513          	li	a0,1
    80003cd4:	00001097          	auipc	ra,0x1
    80003cd8:	e3c080e7          	jalr	-452(ra) # 80004b10 <_ZN15MemoryAllocator9mem_allocEm>
            arg(arg),
            stack(body != nullptr ? stack : nullptr),
            context({(uint64) &threadWrapper,
                     stack != nullptr ? (uint64) &stack[STACK_SIZE] : 0
                    }),
            finished(false)
    80003cdc:	01253023          	sd	s2,0(a0)
    80003ce0:	01353423          	sd	s3,8(a0)
            stack(body != nullptr ? stack : nullptr),
    80003ce4:	06090c63          	beqz	s2,80003d5c <_ZN3PCB10initializeEPFvPvES0_Pm+0xb4>
    80003ce8:	00048793          	mv	a5,s1
            finished(false)
    80003cec:	00f53823          	sd	a5,16(a0)
    80003cf0:	00000797          	auipc	a5,0x0
    80003cf4:	f5478793          	addi	a5,a5,-172 # 80003c44 <_ZN3PCB13threadWrapperEv>
    80003cf8:	00f53c23          	sd	a5,24(a0)
                     stack != nullptr ? (uint64) &stack[STACK_SIZE] : 0
    80003cfc:	06048463          	beqz	s1,80003d64 <_ZN3PCB10initializeEPFvPvES0_Pm+0xbc>
    80003d00:	00002637          	lui	a2,0x2
    80003d04:	00c484b3          	add	s1,s1,a2
            finished(false)
    80003d08:	02953023          	sd	s1,32(a0)
    80003d0c:	02050623          	sb	zero,44(a0)
    {
        id = ID++;
    80003d10:	00008717          	auipc	a4,0x8
    80003d14:	ad070713          	addi	a4,a4,-1328 # 8000b7e0 <_ZN3PCB7runningE>
    80003d18:	00872783          	lw	a5,8(a4)
    80003d1c:	0017869b          	addiw	a3,a5,1
    80003d20:	00d72423          	sw	a3,8(a4)
    80003d24:	02f52823          	sw	a5,48(a0)
        pinged = false;
    80003d28:	02050a23          	sb	zero,52(a0)
        allocatedBlocks = 0;
    80003d2c:	02052e23          	sw	zero,60(a0)
        runTime = 0;
    80003d30:	02052c23          	sw	zero,56(a0)
        state = NEW;
    80003d34:	02052423          	sw	zero,40(a0)
        if(body == nullptr)
    80003d38:	02090a63          	beqz	s2,80003d6c <_ZN3PCB10initializeEPFvPvES0_Pm+0xc4>
            isMainThread = true;
        else
            isMainThread = false;
    80003d3c:	020506a3          	sb	zero,45(a0)
}
    80003d40:	02813083          	ld	ra,40(sp)
    80003d44:	02013403          	ld	s0,32(sp)
    80003d48:	01813483          	ld	s1,24(sp)
    80003d4c:	01013903          	ld	s2,16(sp)
    80003d50:	00813983          	ld	s3,8(sp)
    80003d54:	03010113          	addi	sp,sp,48
    80003d58:	00008067          	ret
            stack(body != nullptr ? stack : nullptr),
    80003d5c:	00000793          	li	a5,0
    80003d60:	f8dff06f          	j	80003cec <_ZN3PCB10initializeEPFvPvES0_Pm+0x44>
                     stack != nullptr ? (uint64) &stack[STACK_SIZE] : 0
    80003d64:	00000493          	li	s1,0
    80003d68:	fa1ff06f          	j	80003d08 <_ZN3PCB10initializeEPFvPvES0_Pm+0x60>
            isMainThread = true;
    80003d6c:	00100793          	li	a5,1
    80003d70:	02f506a3          	sb	a5,45(a0)
    80003d74:	fcdff06f          	j	80003d40 <_ZN3PCB10initializeEPFvPvES0_Pm+0x98>

0000000080003d78 <_ZN3PCB13_createThreadEPFvPvES0_Pm>:
PCB* PCB::_createThread(Body body, void* arg, uint64* stack){
    80003d78:	ff010113          	addi	sp,sp,-16
    80003d7c:	00113423          	sd	ra,8(sp)
    80003d80:	00813023          	sd	s0,0(sp)
    80003d84:	01010413          	addi	s0,sp,16
    PCB* pcb = initialize(body, arg, stack);
    80003d88:	00000097          	auipc	ra,0x0
    80003d8c:	f20080e7          	jalr	-224(ra) # 80003ca8 <_ZN3PCB10initializeEPFvPvES0_Pm>
}
    80003d90:	00813083          	ld	ra,8(sp)
    80003d94:	00013403          	ld	s0,0(sp)
    80003d98:	01010113          	addi	sp,sp,16
    80003d9c:	00008067          	ret

0000000080003da0 <_ZN3PCB8dispatchEv>:
{
    80003da0:	fe010113          	addi	sp,sp,-32
    80003da4:	00113c23          	sd	ra,24(sp)
    80003da8:	00813823          	sd	s0,16(sp)
    80003dac:	00913423          	sd	s1,8(sp)
    80003db0:	02010413          	addi	s0,sp,32
    PCB *old = running;
    80003db4:	00008497          	auipc	s1,0x8
    80003db8:	a2c4b483          	ld	s1,-1492(s1) # 8000b7e0 <_ZN3PCB7runningE>
    bool isFinished() const { return finished;}
    80003dbc:	02c4c783          	lbu	a5,44(s1)
    if (!old->isFinished() && old->state != BLOCKED) {
    80003dc0:	00079863          	bnez	a5,80003dd0 <_ZN3PCB8dispatchEv+0x30>
    80003dc4:	0284a703          	lw	a4,40(s1)
    80003dc8:	00300793          	li	a5,3
    80003dcc:	04f71863          	bne	a4,a5,80003e1c <_ZN3PCB8dispatchEv+0x7c>
    running = Scheduler::get();
    80003dd0:	00002097          	auipc	ra,0x2
    80003dd4:	ca8080e7          	jalr	-856(ra) # 80005a78 <_ZN9Scheduler3getEv>
    80003dd8:	00008797          	auipc	a5,0x8
    80003ddc:	a0a7b423          	sd	a0,-1528(a5) # 8000b7e0 <_ZN3PCB7runningE>
    running->state = RUNNING;
    80003de0:	00200793          	li	a5,2
    80003de4:	02f52423          	sw	a5,40(a0)
    if (PCB::running->isMainThread) {
    80003de8:	02d54783          	lbu	a5,45(a0)
    80003dec:	04078463          	beqz	a5,80003e34 <_ZN3PCB8dispatchEv+0x94>
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80003df0:	10000793          	li	a5,256
    80003df4:	1007a073          	csrs	sstatus,a5
    PCB::contextSwitch(&old->context, &running->context);
    80003df8:	01850593          	addi	a1,a0,24
    80003dfc:	01848513          	addi	a0,s1,24
    80003e00:	ffffd097          	auipc	ra,0xffffd
    80003e04:	588080e7          	jalr	1416(ra) # 80001388 <_ZN3PCB13contextSwitchEPNS_7ContextES1_>
}
    80003e08:	01813083          	ld	ra,24(sp)
    80003e0c:	01013403          	ld	s0,16(sp)
    80003e10:	00813483          	ld	s1,8(sp)
    80003e14:	02010113          	addi	sp,sp,32
    80003e18:	00008067          	ret
        old->state = READY;
    80003e1c:	00100793          	li	a5,1
    80003e20:	02f4a423          	sw	a5,40(s1)
        Scheduler::put(old);
    80003e24:	00048513          	mv	a0,s1
    80003e28:	00002097          	auipc	ra,0x2
    80003e2c:	cb8080e7          	jalr	-840(ra) # 80005ae0 <_ZN9Scheduler3putEP3PCB>
    80003e30:	fa1ff06f          	j	80003dd0 <_ZN3PCB8dispatchEv+0x30>
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80003e34:	10000793          	li	a5,256
    80003e38:	1007b073          	csrc	sstatus,a5
}
    80003e3c:	fbdff06f          	j	80003df8 <_ZN3PCB8dispatchEv+0x58>

0000000080003e40 <_ZN3PCB4joinEPS_>:
void PCB::join(PCB* handle){
    80003e40:	fe010113          	addi	sp,sp,-32
    80003e44:	00113c23          	sd	ra,24(sp)
    80003e48:	00813823          	sd	s0,16(sp)
    80003e4c:	00913423          	sd	s1,8(sp)
    80003e50:	02010413          	addi	s0,sp,32
    80003e54:	00050493          	mv	s1,a0
    80003e58:	02c4c783          	lbu	a5,44(s1)
    while(!handle->isFinished()) {
    80003e5c:	00079863          	bnez	a5,80003e6c <_ZN3PCB4joinEPS_+0x2c>
        dispatch();
    80003e60:	00000097          	auipc	ra,0x0
    80003e64:	f40080e7          	jalr	-192(ra) # 80003da0 <_ZN3PCB8dispatchEv>
    while(!handle->isFinished()) {
    80003e68:	ff1ff06f          	j	80003e58 <_ZN3PCB4joinEPS_+0x18>
}
    80003e6c:	01813083          	ld	ra,24(sp)
    80003e70:	01013403          	ld	s0,16(sp)
    80003e74:	00813483          	ld	s1,8(sp)
    80003e78:	02010113          	addi	sp,sp,32
    80003e7c:	00008067          	ret

0000000080003e80 <_ZN3PCB5startEv>:
    state = READY;
    80003e80:	00100793          	li	a5,1
    80003e84:	02f52423          	sw	a5,40(a0)
    if(!isMainThread){
    80003e88:	02d54783          	lbu	a5,45(a0)
    80003e8c:	00078663          	beqz	a5,80003e98 <_ZN3PCB5startEv+0x18>
}
    80003e90:	00000513          	li	a0,0
    80003e94:	00008067          	ret
int PCB::start(){
    80003e98:	ff010113          	addi	sp,sp,-16
    80003e9c:	00113423          	sd	ra,8(sp)
    80003ea0:	00813023          	sd	s0,0(sp)
    80003ea4:	01010413          	addi	s0,sp,16
        Scheduler::put(this);
    80003ea8:	00002097          	auipc	ra,0x2
    80003eac:	c38080e7          	jalr	-968(ra) # 80005ae0 <_ZN9Scheduler3putEP3PCB>
}
    80003eb0:	00000513          	li	a0,0
    80003eb4:	00813083          	ld	ra,8(sp)
    80003eb8:	00013403          	ld	s0,0(sp)
    80003ebc:	01010113          	addi	sp,sp,16
    80003ec0:	00008067          	ret

0000000080003ec4 <_ZN3PCB12createThreadEPFvPvES0_Pm>:
PCB* PCB::createThread(Body body, void* arg, uint64* stack) {
    80003ec4:	fe010113          	addi	sp,sp,-32
    80003ec8:	00113c23          	sd	ra,24(sp)
    80003ecc:	00813823          	sd	s0,16(sp)
    80003ed0:	00913423          	sd	s1,8(sp)
    80003ed4:	02010413          	addi	s0,sp,32
    PCB *pcb = initialize(body, arg, stack);
    80003ed8:	00000097          	auipc	ra,0x0
    80003edc:	dd0080e7          	jalr	-560(ra) # 80003ca8 <_ZN3PCB10initializeEPFvPvES0_Pm>
    80003ee0:	00050493          	mv	s1,a0
    pcb->start();
    80003ee4:	00000097          	auipc	ra,0x0
    80003ee8:	f9c080e7          	jalr	-100(ra) # 80003e80 <_ZN3PCB5startEv>
}
    80003eec:	00048513          	mv	a0,s1
    80003ef0:	01813083          	ld	ra,24(sp)
    80003ef4:	01013403          	ld	s0,16(sp)
    80003ef8:	00813483          	ld	s1,8(sp)
    80003efc:	02010113          	addi	sp,sp,32
    80003f00:	00008067          	ret

0000000080003f04 <_ZN3PCB4exitEv>:
    if(running->state == RUNNING){
    80003f04:	00008797          	auipc	a5,0x8
    80003f08:	8dc7b783          	ld	a5,-1828(a5) # 8000b7e0 <_ZN3PCB7runningE>
    80003f0c:	0287a683          	lw	a3,40(a5)
    80003f10:	00200713          	li	a4,2
    80003f14:	0ee69863          	bne	a3,a4,80004004 <_ZN3PCB4exitEv+0x100>
int PCB::exit() {
    80003f18:	fe010113          	addi	sp,sp,-32
    80003f1c:	00113c23          	sd	ra,24(sp)
    80003f20:	00813823          	sd	s0,16(sp)
    80003f24:	00913423          	sd	s1,8(sp)
    80003f28:	02010413          	addi	s0,sp,32
        state = FINISHED;
    80003f2c:	00400713          	li	a4,4
    80003f30:	02e7a423          	sw	a4,40(a5)
        finished = value;
    80003f34:	00100713          	li	a4,1
    80003f38:	02e78623          	sb	a4,44(a5)
        if(Thread::cntWaiting > 0){
    80003f3c:	00007797          	auipc	a5,0x7
    80003f40:	7fc7b783          	ld	a5,2044(a5) # 8000b738 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003f44:	0007a783          	lw	a5,0(a5)
    80003f48:	0af05263          	blez	a5,80003fec <_ZN3PCB4exitEv+0xe8>
            Thread::cntWaiting--;
    80003f4c:	fff7879b          	addiw	a5,a5,-1
    80003f50:	00007717          	auipc	a4,0x7
    80003f54:	7e873703          	ld	a4,2024(a4) # 8000b738 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003f58:	00f72023          	sw	a5,0(a4)
            Thread::cntThreads++;
    80003f5c:	00007717          	auipc	a4,0x7
    80003f60:	7e473703          	ld	a4,2020(a4) # 8000b740 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003f64:	00072783          	lw	a5,0(a4)
    80003f68:	0017879b          	addiw	a5,a5,1
    80003f6c:	00f72023          	sw	a5,0(a4)
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    80003f70:	00007797          	auipc	a5,0x7
    80003f74:	7807b783          	ld	a5,1920(a5) # 8000b6f0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80003f78:	0007b503          	ld	a0,0(a5)
    80003f7c:	06050463          	beqz	a0,80003fe4 <_ZN3PCB4exitEv+0xe0>

        Elem *elem = head;
        head = head->next;
    80003f80:	00853783          	ld	a5,8(a0)
    80003f84:	00007717          	auipc	a4,0x7
    80003f88:	76c73703          	ld	a4,1900(a4) # 8000b6f0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80003f8c:	00f73023          	sd	a5,0(a4)
        if (!head) { tail = 0; }
    80003f90:	04078663          	beqz	a5,80003fdc <_ZN3PCB4exitEv+0xd8>

        T *ret = elem->data;
    80003f94:	00053483          	ld	s1,0(a0)
        delete elem;
    80003f98:	00001097          	auipc	ra,0x1
    80003f9c:	fb0080e7          	jalr	-80(ra) # 80004f48 <_ZdlPv>
            printString("Odblokirana nit!\n");
    80003fa0:	00005517          	auipc	a0,0x5
    80003fa4:	2a850513          	addi	a0,a0,680 # 80009248 <CONSOLE_STATUS+0x238>
    80003fa8:	00000097          	auipc	ra,0x0
    80003fac:	064080e7          	jalr	100(ra) # 8000400c <_Z11printStringPKc>
            pcb->start();
    80003fb0:	00048513          	mv	a0,s1
    80003fb4:	00000097          	auipc	ra,0x0
    80003fb8:	ecc080e7          	jalr	-308(ra) # 80003e80 <_ZN3PCB5startEv>
        dispatch();
    80003fbc:	00000097          	auipc	ra,0x0
    80003fc0:	de4080e7          	jalr	-540(ra) # 80003da0 <_ZN3PCB8dispatchEv>
        return 0;
    80003fc4:	00000513          	li	a0,0
}
    80003fc8:	01813083          	ld	ra,24(sp)
    80003fcc:	01013403          	ld	s0,16(sp)
    80003fd0:	00813483          	ld	s1,8(sp)
    80003fd4:	02010113          	addi	sp,sp,32
    80003fd8:	00008067          	ret
        if (!head) { tail = 0; }
    80003fdc:	00073423          	sd	zero,8(a4)
    80003fe0:	fb5ff06f          	j	80003f94 <_ZN3PCB4exitEv+0x90>
        if (!head) { return 0; }
    80003fe4:	00050493          	mv	s1,a0
    80003fe8:	fb9ff06f          	j	80003fa0 <_ZN3PCB4exitEv+0x9c>
            Thread::cntThreads--;
    80003fec:	00007717          	auipc	a4,0x7
    80003ff0:	75473703          	ld	a4,1876(a4) # 8000b740 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003ff4:	00072783          	lw	a5,0(a4)
    80003ff8:	fff7879b          	addiw	a5,a5,-1
    80003ffc:	00f72023          	sw	a5,0(a4)
    80004000:	fbdff06f          	j	80003fbc <_ZN3PCB4exitEv+0xb8>
    return -1;
    80004004:	fff00513          	li	a0,-1
}
    80004008:	00008067          	ret

000000008000400c <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    8000400c:	fe010113          	addi	sp,sp,-32
    80004010:	00113c23          	sd	ra,24(sp)
    80004014:	00813823          	sd	s0,16(sp)
    80004018:	00913423          	sd	s1,8(sp)
    8000401c:	02010413          	addi	s0,sp,32
    80004020:	00050493          	mv	s1,a0
    LOCK();
    80004024:	00100613          	li	a2,1
    80004028:	00000593          	li	a1,0
    8000402c:	00007517          	auipc	a0,0x7
    80004030:	7cc50513          	addi	a0,a0,1996 # 8000b7f8 <lockPrint>
    80004034:	ffffd097          	auipc	ra,0xffffd
    80004038:	fcc080e7          	jalr	-52(ra) # 80001000 <copy_and_swap>
    8000403c:	00050863          	beqz	a0,8000404c <_Z11printStringPKc+0x40>
    80004040:	ffffd097          	auipc	ra,0xffffd
    80004044:	524080e7          	jalr	1316(ra) # 80001564 <_Z15thread_dispatchv>
    80004048:	fddff06f          	j	80004024 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    8000404c:	0004c503          	lbu	a0,0(s1)
    80004050:	00050a63          	beqz	a0,80004064 <_Z11printStringPKc+0x58>
    {
        putc(*string);
    80004054:	ffffd097          	auipc	ra,0xffffd
    80004058:	72c080e7          	jalr	1836(ra) # 80001780 <_Z4putcc>
        string++;
    8000405c:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80004060:	fedff06f          	j	8000404c <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    80004064:	00000613          	li	a2,0
    80004068:	00100593          	li	a1,1
    8000406c:	00007517          	auipc	a0,0x7
    80004070:	78c50513          	addi	a0,a0,1932 # 8000b7f8 <lockPrint>
    80004074:	ffffd097          	auipc	ra,0xffffd
    80004078:	f8c080e7          	jalr	-116(ra) # 80001000 <copy_and_swap>
    8000407c:	fe0514e3          	bnez	a0,80004064 <_Z11printStringPKc+0x58>
}
    80004080:	01813083          	ld	ra,24(sp)
    80004084:	01013403          	ld	s0,16(sp)
    80004088:	00813483          	ld	s1,8(sp)
    8000408c:	02010113          	addi	sp,sp,32
    80004090:	00008067          	ret

0000000080004094 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80004094:	fd010113          	addi	sp,sp,-48
    80004098:	02113423          	sd	ra,40(sp)
    8000409c:	02813023          	sd	s0,32(sp)
    800040a0:	00913c23          	sd	s1,24(sp)
    800040a4:	01213823          	sd	s2,16(sp)
    800040a8:	01313423          	sd	s3,8(sp)
    800040ac:	01413023          	sd	s4,0(sp)
    800040b0:	03010413          	addi	s0,sp,48
    800040b4:	00050993          	mv	s3,a0
    800040b8:	00058a13          	mv	s4,a1
    LOCK();
    800040bc:	00100613          	li	a2,1
    800040c0:	00000593          	li	a1,0
    800040c4:	00007517          	auipc	a0,0x7
    800040c8:	73450513          	addi	a0,a0,1844 # 8000b7f8 <lockPrint>
    800040cc:	ffffd097          	auipc	ra,0xffffd
    800040d0:	f34080e7          	jalr	-204(ra) # 80001000 <copy_and_swap>
    800040d4:	00050863          	beqz	a0,800040e4 <_Z9getStringPci+0x50>
    800040d8:	ffffd097          	auipc	ra,0xffffd
    800040dc:	48c080e7          	jalr	1164(ra) # 80001564 <_Z15thread_dispatchv>
    800040e0:	fddff06f          	j	800040bc <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    800040e4:	00000913          	li	s2,0
    800040e8:	00090493          	mv	s1,s2
    800040ec:	0019091b          	addiw	s2,s2,1
    800040f0:	03495a63          	bge	s2,s4,80004124 <_Z9getStringPci+0x90>
        cc = getc();
    800040f4:	ffffd097          	auipc	ra,0xffffd
    800040f8:	658080e7          	jalr	1624(ra) # 8000174c <_Z4getcv>
        if(cc < 1)
    800040fc:	02050463          	beqz	a0,80004124 <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    80004100:	009984b3          	add	s1,s3,s1
    80004104:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80004108:	00a00793          	li	a5,10
    8000410c:	00f50a63          	beq	a0,a5,80004120 <_Z9getStringPci+0x8c>
    80004110:	00d00793          	li	a5,13
    80004114:	fcf51ae3          	bne	a0,a5,800040e8 <_Z9getStringPci+0x54>
        buf[i++] = c;
    80004118:	00090493          	mv	s1,s2
    8000411c:	0080006f          	j	80004124 <_Z9getStringPci+0x90>
    80004120:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80004124:	009984b3          	add	s1,s3,s1
    80004128:	00048023          	sb	zero,0(s1)

    UNLOCK();
    8000412c:	00000613          	li	a2,0
    80004130:	00100593          	li	a1,1
    80004134:	00007517          	auipc	a0,0x7
    80004138:	6c450513          	addi	a0,a0,1732 # 8000b7f8 <lockPrint>
    8000413c:	ffffd097          	auipc	ra,0xffffd
    80004140:	ec4080e7          	jalr	-316(ra) # 80001000 <copy_and_swap>
    80004144:	fe0514e3          	bnez	a0,8000412c <_Z9getStringPci+0x98>
    return buf;
}
    80004148:	00098513          	mv	a0,s3
    8000414c:	02813083          	ld	ra,40(sp)
    80004150:	02013403          	ld	s0,32(sp)
    80004154:	01813483          	ld	s1,24(sp)
    80004158:	01013903          	ld	s2,16(sp)
    8000415c:	00813983          	ld	s3,8(sp)
    80004160:	00013a03          	ld	s4,0(sp)
    80004164:	03010113          	addi	sp,sp,48
    80004168:	00008067          	ret

000000008000416c <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    8000416c:	ff010113          	addi	sp,sp,-16
    80004170:	00813423          	sd	s0,8(sp)
    80004174:	01010413          	addi	s0,sp,16
    80004178:	00050693          	mv	a3,a0
    int n;

    n = 0;
    8000417c:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80004180:	0006c603          	lbu	a2,0(a3)
    80004184:	fd06071b          	addiw	a4,a2,-48
    80004188:	0ff77713          	andi	a4,a4,255
    8000418c:	00900793          	li	a5,9
    80004190:	02e7e063          	bltu	a5,a4,800041b0 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80004194:	0025179b          	slliw	a5,a0,0x2
    80004198:	00a787bb          	addw	a5,a5,a0
    8000419c:	0017979b          	slliw	a5,a5,0x1
    800041a0:	00168693          	addi	a3,a3,1
    800041a4:	00c787bb          	addw	a5,a5,a2
    800041a8:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    800041ac:	fd5ff06f          	j	80004180 <_Z11stringToIntPKc+0x14>
    return n;
}
    800041b0:	00813403          	ld	s0,8(sp)
    800041b4:	01010113          	addi	sp,sp,16
    800041b8:	00008067          	ret

00000000800041bc <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    800041bc:	fc010113          	addi	sp,sp,-64
    800041c0:	02113c23          	sd	ra,56(sp)
    800041c4:	02813823          	sd	s0,48(sp)
    800041c8:	02913423          	sd	s1,40(sp)
    800041cc:	03213023          	sd	s2,32(sp)
    800041d0:	01313c23          	sd	s3,24(sp)
    800041d4:	04010413          	addi	s0,sp,64
    800041d8:	00050493          	mv	s1,a0
    800041dc:	00058913          	mv	s2,a1
    800041e0:	00060993          	mv	s3,a2
    LOCK();
    800041e4:	00100613          	li	a2,1
    800041e8:	00000593          	li	a1,0
    800041ec:	00007517          	auipc	a0,0x7
    800041f0:	60c50513          	addi	a0,a0,1548 # 8000b7f8 <lockPrint>
    800041f4:	ffffd097          	auipc	ra,0xffffd
    800041f8:	e0c080e7          	jalr	-500(ra) # 80001000 <copy_and_swap>
    800041fc:	00050863          	beqz	a0,8000420c <_Z8printIntiii+0x50>
    80004200:	ffffd097          	auipc	ra,0xffffd
    80004204:	364080e7          	jalr	868(ra) # 80001564 <_Z15thread_dispatchv>
    80004208:	fddff06f          	j	800041e4 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    8000420c:	00098463          	beqz	s3,80004214 <_Z8printIntiii+0x58>
    80004210:	0804c463          	bltz	s1,80004298 <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80004214:	0004851b          	sext.w	a0,s1
    neg = 0;
    80004218:	00000593          	li	a1,0
    }

    i = 0;
    8000421c:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80004220:	0009079b          	sext.w	a5,s2
    80004224:	0325773b          	remuw	a4,a0,s2
    80004228:	00048613          	mv	a2,s1
    8000422c:	0014849b          	addiw	s1,s1,1
    80004230:	02071693          	slli	a3,a4,0x20
    80004234:	0206d693          	srli	a3,a3,0x20
    80004238:	00007717          	auipc	a4,0x7
    8000423c:	44070713          	addi	a4,a4,1088 # 8000b678 <digits>
    80004240:	00d70733          	add	a4,a4,a3
    80004244:	00074683          	lbu	a3,0(a4)
    80004248:	fd040713          	addi	a4,s0,-48
    8000424c:	00c70733          	add	a4,a4,a2
    80004250:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80004254:	0005071b          	sext.w	a4,a0
    80004258:	0325553b          	divuw	a0,a0,s2
    8000425c:	fcf772e3          	bgeu	a4,a5,80004220 <_Z8printIntiii+0x64>
    if(neg)
    80004260:	00058c63          	beqz	a1,80004278 <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80004264:	fd040793          	addi	a5,s0,-48
    80004268:	009784b3          	add	s1,a5,s1
    8000426c:	02d00793          	li	a5,45
    80004270:	fef48823          	sb	a5,-16(s1)
    80004274:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80004278:	fff4849b          	addiw	s1,s1,-1
    8000427c:	0204c463          	bltz	s1,800042a4 <_Z8printIntiii+0xe8>
        putc(buf[i]);
    80004280:	fd040793          	addi	a5,s0,-48
    80004284:	009787b3          	add	a5,a5,s1
    80004288:	ff07c503          	lbu	a0,-16(a5)
    8000428c:	ffffd097          	auipc	ra,0xffffd
    80004290:	4f4080e7          	jalr	1268(ra) # 80001780 <_Z4putcc>
    80004294:	fe5ff06f          	j	80004278 <_Z8printIntiii+0xbc>
        x = -xx;
    80004298:	4090053b          	negw	a0,s1
        neg = 1;
    8000429c:	00100593          	li	a1,1
        x = -xx;
    800042a0:	f7dff06f          	j	8000421c <_Z8printIntiii+0x60>

    UNLOCK();
    800042a4:	00000613          	li	a2,0
    800042a8:	00100593          	li	a1,1
    800042ac:	00007517          	auipc	a0,0x7
    800042b0:	54c50513          	addi	a0,a0,1356 # 8000b7f8 <lockPrint>
    800042b4:	ffffd097          	auipc	ra,0xffffd
    800042b8:	d4c080e7          	jalr	-692(ra) # 80001000 <copy_and_swap>
    800042bc:	fe0514e3          	bnez	a0,800042a4 <_Z8printIntiii+0xe8>
    800042c0:	03813083          	ld	ra,56(sp)
    800042c4:	03013403          	ld	s0,48(sp)
    800042c8:	02813483          	ld	s1,40(sp)
    800042cc:	02013903          	ld	s2,32(sp)
    800042d0:	01813983          	ld	s3,24(sp)
    800042d4:	04010113          	addi	sp,sp,64
    800042d8:	00008067          	ret

00000000800042dc <_ZN9BufferCPPC1Ei>:
#include "../h/buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800042dc:	fd010113          	addi	sp,sp,-48
    800042e0:	02113423          	sd	ra,40(sp)
    800042e4:	02813023          	sd	s0,32(sp)
    800042e8:	00913c23          	sd	s1,24(sp)
    800042ec:	01213823          	sd	s2,16(sp)
    800042f0:	01313423          	sd	s3,8(sp)
    800042f4:	03010413          	addi	s0,sp,48
    800042f8:	00050493          	mv	s1,a0
    800042fc:	00058913          	mv	s2,a1
    80004300:	0015879b          	addiw	a5,a1,1
    80004304:	0007851b          	sext.w	a0,a5
    80004308:	00f4a023          	sw	a5,0(s1)
    8000430c:	0004a823          	sw	zero,16(s1)
    80004310:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004314:	00251513          	slli	a0,a0,0x2
    80004318:	ffffd097          	auipc	ra,0xffffd
    8000431c:	084080e7          	jalr	132(ra) # 8000139c <_Z9mem_allocm>
    80004320:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80004324:	01000513          	li	a0,16
    80004328:	00001097          	auipc	ra,0x1
    8000432c:	ba0080e7          	jalr	-1120(ra) # 80004ec8 <_Znwm>
    80004330:	00050993          	mv	s3,a0
    80004334:	00000593          	li	a1,0
    80004338:	00001097          	auipc	ra,0x1
    8000433c:	e38080e7          	jalr	-456(ra) # 80005170 <_ZN9SemaphoreC1Ej>
    80004340:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80004344:	01000513          	li	a0,16
    80004348:	00001097          	auipc	ra,0x1
    8000434c:	b80080e7          	jalr	-1152(ra) # 80004ec8 <_Znwm>
    80004350:	00050993          	mv	s3,a0
    80004354:	00090593          	mv	a1,s2
    80004358:	00001097          	auipc	ra,0x1
    8000435c:	e18080e7          	jalr	-488(ra) # 80005170 <_ZN9SemaphoreC1Ej>
    80004360:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    80004364:	01000513          	li	a0,16
    80004368:	00001097          	auipc	ra,0x1
    8000436c:	b60080e7          	jalr	-1184(ra) # 80004ec8 <_Znwm>
    80004370:	00050913          	mv	s2,a0
    80004374:	00100593          	li	a1,1
    80004378:	00001097          	auipc	ra,0x1
    8000437c:	df8080e7          	jalr	-520(ra) # 80005170 <_ZN9SemaphoreC1Ej>
    80004380:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80004384:	01000513          	li	a0,16
    80004388:	00001097          	auipc	ra,0x1
    8000438c:	b40080e7          	jalr	-1216(ra) # 80004ec8 <_Znwm>
    80004390:	00050913          	mv	s2,a0
    80004394:	00100593          	li	a1,1
    80004398:	00001097          	auipc	ra,0x1
    8000439c:	dd8080e7          	jalr	-552(ra) # 80005170 <_ZN9SemaphoreC1Ej>
    800043a0:	0324b823          	sd	s2,48(s1)
}
    800043a4:	02813083          	ld	ra,40(sp)
    800043a8:	02013403          	ld	s0,32(sp)
    800043ac:	01813483          	ld	s1,24(sp)
    800043b0:	01013903          	ld	s2,16(sp)
    800043b4:	00813983          	ld	s3,8(sp)
    800043b8:	03010113          	addi	sp,sp,48
    800043bc:	00008067          	ret
    800043c0:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    800043c4:	00098513          	mv	a0,s3
    800043c8:	00001097          	auipc	ra,0x1
    800043cc:	b80080e7          	jalr	-1152(ra) # 80004f48 <_ZdlPv>
    800043d0:	00048513          	mv	a0,s1
    800043d4:	00008097          	auipc	ra,0x8
    800043d8:	554080e7          	jalr	1364(ra) # 8000c928 <_Unwind_Resume>
    800043dc:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    800043e0:	00098513          	mv	a0,s3
    800043e4:	00001097          	auipc	ra,0x1
    800043e8:	b64080e7          	jalr	-1180(ra) # 80004f48 <_ZdlPv>
    800043ec:	00048513          	mv	a0,s1
    800043f0:	00008097          	auipc	ra,0x8
    800043f4:	538080e7          	jalr	1336(ra) # 8000c928 <_Unwind_Resume>
    800043f8:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    800043fc:	00090513          	mv	a0,s2
    80004400:	00001097          	auipc	ra,0x1
    80004404:	b48080e7          	jalr	-1208(ra) # 80004f48 <_ZdlPv>
    80004408:	00048513          	mv	a0,s1
    8000440c:	00008097          	auipc	ra,0x8
    80004410:	51c080e7          	jalr	1308(ra) # 8000c928 <_Unwind_Resume>
    80004414:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80004418:	00090513          	mv	a0,s2
    8000441c:	00001097          	auipc	ra,0x1
    80004420:	b2c080e7          	jalr	-1236(ra) # 80004f48 <_ZdlPv>
    80004424:	00048513          	mv	a0,s1
    80004428:	00008097          	auipc	ra,0x8
    8000442c:	500080e7          	jalr	1280(ra) # 8000c928 <_Unwind_Resume>

0000000080004430 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80004430:	fe010113          	addi	sp,sp,-32
    80004434:	00113c23          	sd	ra,24(sp)
    80004438:	00813823          	sd	s0,16(sp)
    8000443c:	00913423          	sd	s1,8(sp)
    80004440:	01213023          	sd	s2,0(sp)
    80004444:	02010413          	addi	s0,sp,32
    80004448:	00050493          	mv	s1,a0
    8000444c:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80004450:	01853503          	ld	a0,24(a0)
    80004454:	00001097          	auipc	ra,0x1
    80004458:	d54080e7          	jalr	-684(ra) # 800051a8 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    8000445c:	0304b503          	ld	a0,48(s1)
    80004460:	00001097          	auipc	ra,0x1
    80004464:	d48080e7          	jalr	-696(ra) # 800051a8 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80004468:	0084b783          	ld	a5,8(s1)
    8000446c:	0144a703          	lw	a4,20(s1)
    80004470:	00271713          	slli	a4,a4,0x2
    80004474:	00e787b3          	add	a5,a5,a4
    80004478:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    8000447c:	0144a783          	lw	a5,20(s1)
    80004480:	0017879b          	addiw	a5,a5,1
    80004484:	0004a703          	lw	a4,0(s1)
    80004488:	02e7e7bb          	remw	a5,a5,a4
    8000448c:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80004490:	0304b503          	ld	a0,48(s1)
    80004494:	00001097          	auipc	ra,0x1
    80004498:	d40080e7          	jalr	-704(ra) # 800051d4 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    8000449c:	0204b503          	ld	a0,32(s1)
    800044a0:	00001097          	auipc	ra,0x1
    800044a4:	d34080e7          	jalr	-716(ra) # 800051d4 <_ZN9Semaphore6signalEv>

}
    800044a8:	01813083          	ld	ra,24(sp)
    800044ac:	01013403          	ld	s0,16(sp)
    800044b0:	00813483          	ld	s1,8(sp)
    800044b4:	00013903          	ld	s2,0(sp)
    800044b8:	02010113          	addi	sp,sp,32
    800044bc:	00008067          	ret

00000000800044c0 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    800044c0:	fe010113          	addi	sp,sp,-32
    800044c4:	00113c23          	sd	ra,24(sp)
    800044c8:	00813823          	sd	s0,16(sp)
    800044cc:	00913423          	sd	s1,8(sp)
    800044d0:	01213023          	sd	s2,0(sp)
    800044d4:	02010413          	addi	s0,sp,32
    800044d8:	00050493          	mv	s1,a0
    itemAvailable->wait();
    800044dc:	02053503          	ld	a0,32(a0)
    800044e0:	00001097          	auipc	ra,0x1
    800044e4:	cc8080e7          	jalr	-824(ra) # 800051a8 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    800044e8:	0284b503          	ld	a0,40(s1)
    800044ec:	00001097          	auipc	ra,0x1
    800044f0:	cbc080e7          	jalr	-836(ra) # 800051a8 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    800044f4:	0084b703          	ld	a4,8(s1)
    800044f8:	0104a783          	lw	a5,16(s1)
    800044fc:	00279693          	slli	a3,a5,0x2
    80004500:	00d70733          	add	a4,a4,a3
    80004504:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80004508:	0017879b          	addiw	a5,a5,1
    8000450c:	0004a703          	lw	a4,0(s1)
    80004510:	02e7e7bb          	remw	a5,a5,a4
    80004514:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80004518:	0284b503          	ld	a0,40(s1)
    8000451c:	00001097          	auipc	ra,0x1
    80004520:	cb8080e7          	jalr	-840(ra) # 800051d4 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80004524:	0184b503          	ld	a0,24(s1)
    80004528:	00001097          	auipc	ra,0x1
    8000452c:	cac080e7          	jalr	-852(ra) # 800051d4 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004530:	00090513          	mv	a0,s2
    80004534:	01813083          	ld	ra,24(sp)
    80004538:	01013403          	ld	s0,16(sp)
    8000453c:	00813483          	ld	s1,8(sp)
    80004540:	00013903          	ld	s2,0(sp)
    80004544:	02010113          	addi	sp,sp,32
    80004548:	00008067          	ret

000000008000454c <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    8000454c:	fe010113          	addi	sp,sp,-32
    80004550:	00113c23          	sd	ra,24(sp)
    80004554:	00813823          	sd	s0,16(sp)
    80004558:	00913423          	sd	s1,8(sp)
    8000455c:	01213023          	sd	s2,0(sp)
    80004560:	02010413          	addi	s0,sp,32
    80004564:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80004568:	02853503          	ld	a0,40(a0)
    8000456c:	00001097          	auipc	ra,0x1
    80004570:	c3c080e7          	jalr	-964(ra) # 800051a8 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80004574:	0304b503          	ld	a0,48(s1)
    80004578:	00001097          	auipc	ra,0x1
    8000457c:	c30080e7          	jalr	-976(ra) # 800051a8 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80004580:	0144a783          	lw	a5,20(s1)
    80004584:	0104a903          	lw	s2,16(s1)
    80004588:	0327ce63          	blt	a5,s2,800045c4 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    8000458c:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80004590:	0304b503          	ld	a0,48(s1)
    80004594:	00001097          	auipc	ra,0x1
    80004598:	c40080e7          	jalr	-960(ra) # 800051d4 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    8000459c:	0284b503          	ld	a0,40(s1)
    800045a0:	00001097          	auipc	ra,0x1
    800045a4:	c34080e7          	jalr	-972(ra) # 800051d4 <_ZN9Semaphore6signalEv>

    return ret;
}
    800045a8:	00090513          	mv	a0,s2
    800045ac:	01813083          	ld	ra,24(sp)
    800045b0:	01013403          	ld	s0,16(sp)
    800045b4:	00813483          	ld	s1,8(sp)
    800045b8:	00013903          	ld	s2,0(sp)
    800045bc:	02010113          	addi	sp,sp,32
    800045c0:	00008067          	ret
        ret = cap - head + tail;
    800045c4:	0004a703          	lw	a4,0(s1)
    800045c8:	4127093b          	subw	s2,a4,s2
    800045cc:	00f9093b          	addw	s2,s2,a5
    800045d0:	fc1ff06f          	j	80004590 <_ZN9BufferCPP6getCntEv+0x44>

00000000800045d4 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    800045d4:	fe010113          	addi	sp,sp,-32
    800045d8:	00113c23          	sd	ra,24(sp)
    800045dc:	00813823          	sd	s0,16(sp)
    800045e0:	00913423          	sd	s1,8(sp)
    800045e4:	02010413          	addi	s0,sp,32
    800045e8:	00050493          	mv	s1,a0
    Console::putc('\n');
    800045ec:	00a00513          	li	a0,10
    800045f0:	00001097          	auipc	ra,0x1
    800045f4:	c38080e7          	jalr	-968(ra) # 80005228 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    800045f8:	00005517          	auipc	a0,0x5
    800045fc:	c6850513          	addi	a0,a0,-920 # 80009260 <CONSOLE_STATUS+0x250>
    80004600:	00000097          	auipc	ra,0x0
    80004604:	a0c080e7          	jalr	-1524(ra) # 8000400c <_Z11printStringPKc>
    while (getCnt()) {
    80004608:	00048513          	mv	a0,s1
    8000460c:	00000097          	auipc	ra,0x0
    80004610:	f40080e7          	jalr	-192(ra) # 8000454c <_ZN9BufferCPP6getCntEv>
    80004614:	02050c63          	beqz	a0,8000464c <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80004618:	0084b783          	ld	a5,8(s1)
    8000461c:	0104a703          	lw	a4,16(s1)
    80004620:	00271713          	slli	a4,a4,0x2
    80004624:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80004628:	0007c503          	lbu	a0,0(a5)
    8000462c:	00001097          	auipc	ra,0x1
    80004630:	bfc080e7          	jalr	-1028(ra) # 80005228 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80004634:	0104a783          	lw	a5,16(s1)
    80004638:	0017879b          	addiw	a5,a5,1
    8000463c:	0004a703          	lw	a4,0(s1)
    80004640:	02e7e7bb          	remw	a5,a5,a4
    80004644:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80004648:	fc1ff06f          	j	80004608 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    8000464c:	02100513          	li	a0,33
    80004650:	00001097          	auipc	ra,0x1
    80004654:	bd8080e7          	jalr	-1064(ra) # 80005228 <_ZN7Console4putcEc>
    Console::putc('\n');
    80004658:	00a00513          	li	a0,10
    8000465c:	00001097          	auipc	ra,0x1
    80004660:	bcc080e7          	jalr	-1076(ra) # 80005228 <_ZN7Console4putcEc>
    mem_free(buffer);
    80004664:	0084b503          	ld	a0,8(s1)
    80004668:	ffffd097          	auipc	ra,0xffffd
    8000466c:	d68080e7          	jalr	-664(ra) # 800013d0 <_Z8mem_freePv>
    delete itemAvailable;
    80004670:	0204b503          	ld	a0,32(s1)
    80004674:	00050863          	beqz	a0,80004684 <_ZN9BufferCPPD1Ev+0xb0>
    80004678:	00053783          	ld	a5,0(a0)
    8000467c:	0087b783          	ld	a5,8(a5)
    80004680:	000780e7          	jalr	a5
    delete spaceAvailable;
    80004684:	0184b503          	ld	a0,24(s1)
    80004688:	00050863          	beqz	a0,80004698 <_ZN9BufferCPPD1Ev+0xc4>
    8000468c:	00053783          	ld	a5,0(a0)
    80004690:	0087b783          	ld	a5,8(a5)
    80004694:	000780e7          	jalr	a5
    delete mutexTail;
    80004698:	0304b503          	ld	a0,48(s1)
    8000469c:	00050863          	beqz	a0,800046ac <_ZN9BufferCPPD1Ev+0xd8>
    800046a0:	00053783          	ld	a5,0(a0)
    800046a4:	0087b783          	ld	a5,8(a5)
    800046a8:	000780e7          	jalr	a5
    delete mutexHead;
    800046ac:	0284b503          	ld	a0,40(s1)
    800046b0:	00050863          	beqz	a0,800046c0 <_ZN9BufferCPPD1Ev+0xec>
    800046b4:	00053783          	ld	a5,0(a0)
    800046b8:	0087b783          	ld	a5,8(a5)
    800046bc:	000780e7          	jalr	a5
}
    800046c0:	01813083          	ld	ra,24(sp)
    800046c4:	01013403          	ld	s0,16(sp)
    800046c8:	00813483          	ld	s1,8(sp)
    800046cc:	02010113          	addi	sp,sp,32
    800046d0:	00008067          	ret

00000000800046d4 <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "System_Mode_test.hpp"

#endif

void userMain() {
    800046d4:	fe010113          	addi	sp,sp,-32
    800046d8:	00113c23          	sd	ra,24(sp)
    800046dc:	00813823          	sd	s0,16(sp)
    800046e0:	00913423          	sd	s1,8(sp)
    800046e4:	01213023          	sd	s2,0(sp)
    800046e8:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    800046ec:	00005517          	auipc	a0,0x5
    800046f0:	b8c50513          	addi	a0,a0,-1140 # 80009278 <CONSOLE_STATUS+0x268>
    800046f4:	00000097          	auipc	ra,0x0
    800046f8:	918080e7          	jalr	-1768(ra) # 8000400c <_Z11printStringPKc>
    int test = getc() - '0';
    800046fc:	ffffd097          	auipc	ra,0xffffd
    80004700:	050080e7          	jalr	80(ra) # 8000174c <_Z4getcv>
    80004704:	00050913          	mv	s2,a0
    80004708:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    8000470c:	ffffd097          	auipc	ra,0xffffd
    80004710:	040080e7          	jalr	64(ra) # 8000174c <_Z4getcv>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
            return;
        }
    }

    if (test >= 5 && test <= 6) {
    80004714:	fcb9091b          	addiw	s2,s2,-53
    80004718:	00100793          	li	a5,1
    8000471c:	0327f463          	bgeu	a5,s2,80004744 <_Z8userMainv+0x70>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    80004720:	00700793          	li	a5,7
    80004724:	0e97e263          	bltu	a5,s1,80004808 <_Z8userMainv+0x134>
    80004728:	00249493          	slli	s1,s1,0x2
    8000472c:	00005717          	auipc	a4,0x5
    80004730:	d6470713          	addi	a4,a4,-668 # 80009490 <CONSOLE_STATUS+0x480>
    80004734:	00e484b3          	add	s1,s1,a4
    80004738:	0004a783          	lw	a5,0(s1)
    8000473c:	00e787b3          	add	a5,a5,a4
    80004740:	00078067          	jr	a5
            printString("Nije navedeno da je zadatak 4 implementiran\n");
    80004744:	00005517          	auipc	a0,0x5
    80004748:	b5450513          	addi	a0,a0,-1196 # 80009298 <CONSOLE_STATUS+0x288>
    8000474c:	00000097          	auipc	ra,0x0
    80004750:	8c0080e7          	jalr	-1856(ra) # 8000400c <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    80004754:	01813083          	ld	ra,24(sp)
    80004758:	01013403          	ld	s0,16(sp)
    8000475c:	00813483          	ld	s1,8(sp)
    80004760:	00013903          	ld	s2,0(sp)
    80004764:	02010113          	addi	sp,sp,32
    80004768:	00008067          	ret
            Threads_C_API_test();
    8000476c:	fffff097          	auipc	ra,0xfffff
    80004770:	b50080e7          	jalr	-1200(ra) # 800032bc <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    80004774:	00005517          	auipc	a0,0x5
    80004778:	b5450513          	addi	a0,a0,-1196 # 800092c8 <CONSOLE_STATUS+0x2b8>
    8000477c:	00000097          	auipc	ra,0x0
    80004780:	890080e7          	jalr	-1904(ra) # 8000400c <_Z11printStringPKc>
            break;
    80004784:	fd1ff06f          	j	80004754 <_Z8userMainv+0x80>
            Threads_CPP_API_test();
    80004788:	ffffe097          	auipc	ra,0xffffe
    8000478c:	a14080e7          	jalr	-1516(ra) # 8000219c <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    80004790:	00005517          	auipc	a0,0x5
    80004794:	b7850513          	addi	a0,a0,-1160 # 80009308 <CONSOLE_STATUS+0x2f8>
    80004798:	00000097          	auipc	ra,0x0
    8000479c:	874080e7          	jalr	-1932(ra) # 8000400c <_Z11printStringPKc>
            break;
    800047a0:	fb5ff06f          	j	80004754 <_Z8userMainv+0x80>
            producerConsumer_C_API();
    800047a4:	ffffd097          	auipc	ra,0xffffd
    800047a8:	24c080e7          	jalr	588(ra) # 800019f0 <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    800047ac:	00005517          	auipc	a0,0x5
    800047b0:	b9c50513          	addi	a0,a0,-1124 # 80009348 <CONSOLE_STATUS+0x338>
    800047b4:	00000097          	auipc	ra,0x0
    800047b8:	858080e7          	jalr	-1960(ra) # 8000400c <_Z11printStringPKc>
            break;
    800047bc:	f99ff06f          	j	80004754 <_Z8userMainv+0x80>
            producerConsumer_CPP_Sync_API();
    800047c0:	fffff097          	auipc	ra,0xfffff
    800047c4:	e40080e7          	jalr	-448(ra) # 80003600 <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    800047c8:	00005517          	auipc	a0,0x5
    800047cc:	bd050513          	addi	a0,a0,-1072 # 80009398 <CONSOLE_STATUS+0x388>
    800047d0:	00000097          	auipc	ra,0x0
    800047d4:	83c080e7          	jalr	-1988(ra) # 8000400c <_Z11printStringPKc>
            break;
    800047d8:	f7dff06f          	j	80004754 <_Z8userMainv+0x80>
            System_Mode_test();
    800047dc:	00002097          	auipc	ra,0x2
    800047e0:	890080e7          	jalr	-1904(ra) # 8000606c <_Z16System_Mode_testv>
            printString("Test se nije uspesno zavrsio\n");
    800047e4:	00005517          	auipc	a0,0x5
    800047e8:	c0c50513          	addi	a0,a0,-1012 # 800093f0 <CONSOLE_STATUS+0x3e0>
    800047ec:	00000097          	auipc	ra,0x0
    800047f0:	820080e7          	jalr	-2016(ra) # 8000400c <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    800047f4:	00005517          	auipc	a0,0x5
    800047f8:	c1c50513          	addi	a0,a0,-996 # 80009410 <CONSOLE_STATUS+0x400>
    800047fc:	00000097          	auipc	ra,0x0
    80004800:	810080e7          	jalr	-2032(ra) # 8000400c <_Z11printStringPKc>
            break;
    80004804:	f51ff06f          	j	80004754 <_Z8userMainv+0x80>
            printString("Niste uneli odgovarajuci broj za test\n");
    80004808:	00005517          	auipc	a0,0x5
    8000480c:	c6050513          	addi	a0,a0,-928 # 80009468 <CONSOLE_STATUS+0x458>
    80004810:	fffff097          	auipc	ra,0xfffff
    80004814:	7fc080e7          	jalr	2044(ra) # 8000400c <_Z11printStringPKc>
    80004818:	f3dff06f          	j	80004754 <_Z8userMainv+0x80>

000000008000481c <main>:
    }
};
*/
extern void userMain();

int main() {
    8000481c:	fe010113          	addi	sp,sp,-32
    80004820:	00113c23          	sd	ra,24(sp)
    80004824:	00813823          	sd	s0,16(sp)
    80004828:	02010413          	addi	s0,sp,32
    Riscv::w_stvec((uint64) &Riscv::supervisorTrap | 0b01);
    8000482c:	00007797          	auipc	a5,0x7
    80004830:	ecc7b783          	ld	a5,-308(a5) # 8000b6f8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80004834:	0017e793          	ori	a5,a5,1
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    80004838:	10579073          	csrw	stvec,a5
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    8000483c:	00200793          	li	a5,2
    80004840:	1007a073          	csrs	sstatus,a5
    /*printString("MAIN\n");
    auto* mainThread = new Thread(nullptr, nullptr);
    Thread::setRunning(mainThread);
     */

    PCB::running = PCB::createThread(nullptr, nullptr, nullptr);
    80004844:	00000613          	li	a2,0
    80004848:	00000593          	li	a1,0
    8000484c:	00000513          	li	a0,0
    80004850:	fffff097          	auipc	ra,0xfffff
    80004854:	674080e7          	jalr	1652(ra) # 80003ec4 <_ZN3PCB12createThreadEPFvPvES0_Pm>
    80004858:	00007797          	auipc	a5,0x7
    8000485c:	ec87b783          	ld	a5,-312(a5) # 8000b720 <_GLOBAL_OFFSET_TABLE_+0x48>
    80004860:	00a7b023          	sd	a0,0(a5)
    printString("MAIN\n");
    80004864:	00005517          	auipc	a0,0x5
    80004868:	c4c50513          	addi	a0,a0,-948 # 800094b0 <CONSOLE_STATUS+0x4a0>
    8000486c:	fffff097          	auipc	ra,0xfffff
    80004870:	7a0080e7          	jalr	1952(ra) # 8000400c <_Z11printStringPKc>

    thread_t user;
    thread_create(&user, reinterpret_cast<void (*)(void *)>(userMain), nullptr);
    80004874:	00000613          	li	a2,0
    80004878:	00007597          	auipc	a1,0x7
    8000487c:	e685b583          	ld	a1,-408(a1) # 8000b6e0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80004880:	fe840513          	addi	a0,s0,-24
    80004884:	ffffd097          	auipc	ra,0xffffd
    80004888:	b84080e7          	jalr	-1148(ra) # 80001408 <_Z13thread_createPP3PCBPFvPvES2_>

    thread_join(user);
    8000488c:	fe843503          	ld	a0,-24(s0)
    80004890:	ffffd097          	auipc	ra,0xffffd
    80004894:	cf8080e7          	jalr	-776(ra) # 80001588 <_Z11thread_joinP3PCB>

    printString("Main finished\n");
    80004898:	00005517          	auipc	a0,0x5
    8000489c:	c2050513          	addi	a0,a0,-992 # 800094b8 <CONSOLE_STATUS+0x4a8>
    800048a0:	fffff097          	auipc	ra,0xfffff
    800048a4:	76c080e7          	jalr	1900(ra) # 8000400c <_Z11printStringPKc>
    }

    printString("Main finished\n");
    return 0;
     */
    800048a8:	00000513          	li	a0,0
    800048ac:	01813083          	ld	ra,24(sp)
    800048b0:	01013403          	ld	s0,16(sp)
    800048b4:	02010113          	addi	sp,sp,32
    800048b8:	00008067          	ret

00000000800048bc <_ZN8ResourceC1Ei>:
//
// Created by os on 2/5/24.
//
#include "../h/resource.hpp"

Resource::Resource(int n){
    800048bc:	fe010113          	addi	sp,sp,-32
    800048c0:	00113c23          	sd	ra,24(sp)
    800048c4:	00813823          	sd	s0,16(sp)
    800048c8:	00913423          	sd	s1,8(sp)
    800048cc:	01213023          	sd	s2,0(sp)
    800048d0:	02010413          	addi	s0,sp,32
    800048d4:	00050493          	mv	s1,a0
    cnt = n;
    800048d8:	00b52023          	sw	a1,0(a0)
    mutex = new Semaphore(1);
    800048dc:	01000513          	li	a0,16
    800048e0:	00000097          	auipc	ra,0x0
    800048e4:	5e8080e7          	jalr	1512(ra) # 80004ec8 <_Znwm>
    800048e8:	00050913          	mv	s2,a0
    800048ec:	00100593          	li	a1,1
    800048f0:	00001097          	auipc	ra,0x1
    800048f4:	880080e7          	jalr	-1920(ra) # 80005170 <_ZN9SemaphoreC1Ej>
    800048f8:	0124b423          	sd	s2,8(s1)
    sem = new Semaphore(0);
    800048fc:	01000513          	li	a0,16
    80004900:	00000097          	auipc	ra,0x0
    80004904:	5c8080e7          	jalr	1480(ra) # 80004ec8 <_Znwm>
    80004908:	00050913          	mv	s2,a0
    8000490c:	00000593          	li	a1,0
    80004910:	00001097          	auipc	ra,0x1
    80004914:	860080e7          	jalr	-1952(ra) # 80005170 <_ZN9SemaphoreC1Ej>
    80004918:	0124b823          	sd	s2,16(s1)
    waiting = 0;
    8000491c:	0004ac23          	sw	zero,24(s1)
}
    80004920:	01813083          	ld	ra,24(sp)
    80004924:	01013403          	ld	s0,16(sp)
    80004928:	00813483          	ld	s1,8(sp)
    8000492c:	00013903          	ld	s2,0(sp)
    80004930:	02010113          	addi	sp,sp,32
    80004934:	00008067          	ret
    80004938:	00050493          	mv	s1,a0
    mutex = new Semaphore(1);
    8000493c:	00090513          	mv	a0,s2
    80004940:	00000097          	auipc	ra,0x0
    80004944:	608080e7          	jalr	1544(ra) # 80004f48 <_ZdlPv>
    80004948:	00048513          	mv	a0,s1
    8000494c:	00008097          	auipc	ra,0x8
    80004950:	fdc080e7          	jalr	-36(ra) # 8000c928 <_Unwind_Resume>
    80004954:	00050493          	mv	s1,a0
    sem = new Semaphore(0);
    80004958:	00090513          	mv	a0,s2
    8000495c:	00000097          	auipc	ra,0x0
    80004960:	5ec080e7          	jalr	1516(ra) # 80004f48 <_ZdlPv>
    80004964:	00048513          	mv	a0,s1
    80004968:	00008097          	auipc	ra,0x8
    8000496c:	fc0080e7          	jalr	-64(ra) # 8000c928 <_Unwind_Resume>

0000000080004970 <_ZN8Resource4takeEi>:

void Resource::take(int num){
    80004970:	fe010113          	addi	sp,sp,-32
    80004974:	00113c23          	sd	ra,24(sp)
    80004978:	00813823          	sd	s0,16(sp)
    8000497c:	00913423          	sd	s1,8(sp)
    80004980:	01213023          	sd	s2,0(sp)
    80004984:	02010413          	addi	s0,sp,32
    80004988:	00050493          	mv	s1,a0
    8000498c:	00058913          	mv	s2,a1
    mutex->wait();
    80004990:	00853503          	ld	a0,8(a0)
    80004994:	00001097          	auipc	ra,0x1
    80004998:	814080e7          	jalr	-2028(ra) # 800051a8 <_ZN9Semaphore4waitEv>
    if(num > cnt){
    8000499c:	0004a583          	lw	a1,0(s1)
    800049a0:	0725d263          	bge	a1,s2,80004a04 <_ZN8Resource4takeEi+0x94>
        mutex->signal();
    800049a4:	0084b503          	ld	a0,8(s1)
    800049a8:	00001097          	auipc	ra,0x1
    800049ac:	82c080e7          	jalr	-2004(ra) # 800051d4 <_ZN9Semaphore6signalEv>
        waiting++;
    800049b0:	0184a783          	lw	a5,24(s1)
    800049b4:	0017879b          	addiw	a5,a5,1
    800049b8:	00f4ac23          	sw	a5,24(s1)
        sem->wait();
    800049bc:	0104b503          	ld	a0,16(s1)
    800049c0:	00000097          	auipc	ra,0x0
    800049c4:	7e8080e7          	jalr	2024(ra) # 800051a8 <_ZN9Semaphore4waitEv>
        mutex->wait();
    800049c8:	0084b503          	ld	a0,8(s1)
    800049cc:	00000097          	auipc	ra,0x0
    800049d0:	7dc080e7          	jalr	2012(ra) # 800051a8 <_ZN9Semaphore4waitEv>
        cnt -= num;
    800049d4:	0004a583          	lw	a1,0(s1)
    800049d8:	4125893b          	subw	s2,a1,s2
    800049dc:	0124a023          	sw	s2,0(s1)
        mutex->signal();
    800049e0:	0084b503          	ld	a0,8(s1)
    800049e4:	00000097          	auipc	ra,0x0
    800049e8:	7f0080e7          	jalr	2032(ra) # 800051d4 <_ZN9Semaphore6signalEv>
    } else {
        cnt -= num;
        mutex->signal();
    }
}
    800049ec:	01813083          	ld	ra,24(sp)
    800049f0:	01013403          	ld	s0,16(sp)
    800049f4:	00813483          	ld	s1,8(sp)
    800049f8:	00013903          	ld	s2,0(sp)
    800049fc:	02010113          	addi	sp,sp,32
    80004a00:	00008067          	ret
        cnt -= num;
    80004a04:	412585bb          	subw	a1,a1,s2
    80004a08:	00b4a023          	sw	a1,0(s1)
        mutex->signal();
    80004a0c:	0084b503          	ld	a0,8(s1)
    80004a10:	00000097          	auipc	ra,0x0
    80004a14:	7c4080e7          	jalr	1988(ra) # 800051d4 <_ZN9Semaphore6signalEv>
}
    80004a18:	fd5ff06f          	j	800049ec <_ZN8Resource4takeEi+0x7c>

0000000080004a1c <_ZN8Resource9give_backEi>:

int Resource::give_back(int num){
    80004a1c:	fe010113          	addi	sp,sp,-32
    80004a20:	00113c23          	sd	ra,24(sp)
    80004a24:	00813823          	sd	s0,16(sp)
    80004a28:	00913423          	sd	s1,8(sp)
    80004a2c:	01213023          	sd	s2,0(sp)
    80004a30:	02010413          	addi	s0,sp,32
    80004a34:	00050493          	mv	s1,a0
    80004a38:	00058913          	mv	s2,a1
    mutex->wait();
    80004a3c:	00853503          	ld	a0,8(a0)
    80004a40:	00000097          	auipc	ra,0x0
    80004a44:	768080e7          	jalr	1896(ra) # 800051a8 <_ZN9Semaphore4waitEv>
    cnt+= num;
    80004a48:	0004a783          	lw	a5,0(s1)
    80004a4c:	012785bb          	addw	a1,a5,s2
    80004a50:	00b4a023          	sw	a1,0(s1)
    while(waiting > 0){
    80004a54:	0184a783          	lw	a5,24(s1)
    80004a58:	00f05e63          	blez	a5,80004a74 <_ZN8Resource9give_backEi+0x58>
        waiting--;
    80004a5c:	fff7879b          	addiw	a5,a5,-1
    80004a60:	00f4ac23          	sw	a5,24(s1)
        sem->signal();
    80004a64:	0104b503          	ld	a0,16(s1)
    80004a68:	00000097          	auipc	ra,0x0
    80004a6c:	76c080e7          	jalr	1900(ra) # 800051d4 <_ZN9Semaphore6signalEv>
    while(waiting > 0){
    80004a70:	fe5ff06f          	j	80004a54 <_ZN8Resource9give_backEi+0x38>
    }
    mutex->signal();
    80004a74:	0084b503          	ld	a0,8(s1)
    80004a78:	00000097          	auipc	ra,0x0
    80004a7c:	75c080e7          	jalr	1884(ra) # 800051d4 <_ZN9Semaphore6signalEv>
    return 0;
    80004a80:	00000513          	li	a0,0
    80004a84:	01813083          	ld	ra,24(sp)
    80004a88:	01013403          	ld	s0,16(sp)
    80004a8c:	00813483          	ld	s1,8(sp)
    80004a90:	00013903          	ld	s2,0(sp)
    80004a94:	02010113          	addi	sp,sp,32
    80004a98:	00008067          	ret

0000000080004a9c <_ZN15MemoryAllocator11getInstanceEv>:

MemBlock* MemoryAllocator::freeMemHead = nullptr;
MemBlock* MemoryAllocator::allocMemHead = nullptr;
bool MemoryAllocator::init_memory = false;

MemoryAllocator& MemoryAllocator::getInstance(){
    80004a9c:	ff010113          	addi	sp,sp,-16
    80004aa0:	00813423          	sd	s0,8(sp)
    80004aa4:	01010413          	addi	s0,sp,16
    static MemoryAllocator singleton;
    return singleton;
}
    80004aa8:	00007517          	auipc	a0,0x7
    80004aac:	d5850513          	addi	a0,a0,-680 # 8000b800 <_ZZN15MemoryAllocator11getInstanceEvE9singleton>
    80004ab0:	00813403          	ld	s0,8(sp)
    80004ab4:	01010113          	addi	sp,sp,16
    80004ab8:	00008067          	ret

0000000080004abc <_ZN15MemoryAllocator4initEv>:

void MemoryAllocator::init(){
    80004abc:	ff010113          	addi	sp,sp,-16
    80004ac0:	00813423          	sd	s0,8(sp)
    80004ac4:	01010413          	addi	s0,sp,16
    freeMemHead = (MemBlock*)((char*)HEAP_START_ADDR);
    80004ac8:	00007797          	auipc	a5,0x7
    80004acc:	c207b783          	ld	a5,-992(a5) # 8000b6e8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80004ad0:	0007b683          	ld	a3,0(a5)
    80004ad4:	00007717          	auipc	a4,0x7
    80004ad8:	d2c70713          	addi	a4,a4,-724 # 8000b800 <_ZZN15MemoryAllocator11getInstanceEvE9singleton>
    80004adc:	00d73423          	sd	a3,8(a4)
    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR - sizeof(MemBlock);
    80004ae0:	00007797          	auipc	a5,0x7
    80004ae4:	c487b783          	ld	a5,-952(a5) # 8000b728 <_GLOBAL_OFFSET_TABLE_+0x50>
    80004ae8:	0007b783          	ld	a5,0(a5)
    80004aec:	40d787b3          	sub	a5,a5,a3
    80004af0:	ff078793          	addi	a5,a5,-16
    80004af4:	00f6b023          	sd	a5,0(a3)
    freeMemHead->next = nullptr;
    80004af8:	00873783          	ld	a5,8(a4)
    80004afc:	0007b423          	sd	zero,8(a5)
    allocMemHead = nullptr;
    80004b00:	00073823          	sd	zero,16(a4)
}
    80004b04:	00813403          	ld	s0,8(sp)
    80004b08:	01010113          	addi	sp,sp,16
    80004b0c:	00008067          	ret

0000000080004b10 <_ZN15MemoryAllocator9mem_allocEm>:

void* MemoryAllocator::mem_alloc(size_t size){
    80004b10:	fe010113          	addi	sp,sp,-32
    80004b14:	00113c23          	sd	ra,24(sp)
    80004b18:	00813823          	sd	s0,16(sp)
    80004b1c:	00913423          	sd	s1,8(sp)
    80004b20:	01213023          	sd	s2,0(sp)
    80004b24:	02010413          	addi	s0,sp,32
    size *= MEM_BLOCK_SIZE;
    80004b28:	00651493          	slli	s1,a0,0x6
    if(size <= 0) return nullptr;
    80004b2c:	14048c63          	beqz	s1,80004c84 <_ZN15MemoryAllocator9mem_allocEm+0x174>
    80004b30:	00050913          	mv	s2,a0

    if(!init_memory){
    80004b34:	00007797          	auipc	a5,0x7
    80004b38:	ce47c783          	lbu	a5,-796(a5) # 8000b818 <_ZN15MemoryAllocator11init_memoryE>
    80004b3c:	04078863          	beqz	a5,80004b8c <_ZN15MemoryAllocator9mem_allocEm+0x7c>
        init_memory = true;
        init();
    }
    if(PCB::running){
    80004b40:	00007797          	auipc	a5,0x7
    80004b44:	be07b783          	ld	a5,-1056(a5) # 8000b720 <_GLOBAL_OFFSET_TABLE_+0x48>
    80004b48:	0007b783          	ld	a5,0(a5)
    80004b4c:	00078e63          	beqz	a5,80004b68 <_ZN15MemoryAllocator9mem_allocEm+0x58>
        PCB::running->incrementMemory(size/MEM_BLOCK_SIZE);
    80004b50:	fff00513          	li	a0,-1
    80004b54:	00655513          	srli	a0,a0,0x6
    80004b58:	00a97933          	and	s2,s2,a0
    void incrementMemory(int inc){this->allocatedBlocks+=inc;}
    80004b5c:	03c7a703          	lw	a4,60(a5)
    80004b60:	0127093b          	addw	s2,a4,s2
    80004b64:	0327ae23          	sw	s2,60(a5)
    }
    MemBlock *current = freeMemHead, *prev = nullptr;
    80004b68:	00007517          	auipc	a0,0x7
    80004b6c:	ca053503          	ld	a0,-864(a0) # 8000b808 <_ZN15MemoryAllocator11freeMemHeadE>
    80004b70:	00000713          	li	a4,0
    while(current){
    80004b74:	0c050e63          	beqz	a0,80004c50 <_ZN15MemoryAllocator9mem_allocEm+0x140>
        if(current->size >= size){
    80004b78:	00053783          	ld	a5,0(a0)
    80004b7c:	0297f463          	bgeu	a5,s1,80004ba4 <_ZN15MemoryAllocator9mem_allocEm+0x94>
                prevCurrent->next = current;
            }

            return (char*)current + sizeof(MemBlock);
        }
        prev = current;
    80004b80:	00050713          	mv	a4,a0
        current = current->next;
    80004b84:	00853503          	ld	a0,8(a0)
    while(current){
    80004b88:	fedff06f          	j	80004b74 <_ZN15MemoryAllocator9mem_allocEm+0x64>
        init_memory = true;
    80004b8c:	00100793          	li	a5,1
    80004b90:	00007717          	auipc	a4,0x7
    80004b94:	c8f70423          	sb	a5,-888(a4) # 8000b818 <_ZN15MemoryAllocator11init_memoryE>
        init();
    80004b98:	00000097          	auipc	ra,0x0
    80004b9c:	f24080e7          	jalr	-220(ra) # 80004abc <_ZN15MemoryAllocator4initEv>
    80004ba0:	fa1ff06f          	j	80004b40 <_ZN15MemoryAllocator9mem_allocEm+0x30>
            if(current->size == size){
    80004ba4:	04978c63          	beq	a5,s1,80004bfc <_ZN15MemoryAllocator9mem_allocEm+0xec>
                MemBlock* freeSegment = (MemBlock*)((char*)current + size + sizeof(MemBlock));
    80004ba8:	01048693          	addi	a3,s1,16
    80004bac:	00d506b3          	add	a3,a0,a3
                freeSegment->size = current->size - size - sizeof(MemBlock);
    80004bb0:	409787b3          	sub	a5,a5,s1
    80004bb4:	ff078793          	addi	a5,a5,-16
    80004bb8:	00f6b023          	sd	a5,0(a3)
                freeSegment->next = current->next;
    80004bbc:	00853783          	ld	a5,8(a0)
    80004bc0:	00f6b423          	sd	a5,8(a3)
                current->size = size;
    80004bc4:	00953023          	sd	s1,0(a0)
                if(current == freeMemHead)
    80004bc8:	00007797          	auipc	a5,0x7
    80004bcc:	c407b783          	ld	a5,-960(a5) # 8000b808 <_ZN15MemoryAllocator11freeMemHeadE>
    80004bd0:	04a78663          	beq	a5,a0,80004c1c <_ZN15MemoryAllocator9mem_allocEm+0x10c>
                    prev->next = freeSegment;
    80004bd4:	00d73423          	sd	a3,8(a4)
            if(allocMemHead == nullptr) {
    80004bd8:	00007797          	auipc	a5,0x7
    80004bdc:	c387b783          	ld	a5,-968(a5) # 8000b810 <_ZN15MemoryAllocator12allocMemHeadE>
    80004be0:	04078463          	beqz	a5,80004c28 <_ZN15MemoryAllocator9mem_allocEm+0x118>
            MemBlock *allocCurrent = allocMemHead, *prevCurrent = nullptr;
    80004be4:	00000713          	li	a4,0
            while(allocCurrent){
    80004be8:	06078063          	beqz	a5,80004c48 <_ZN15MemoryAllocator9mem_allocEm+0x138>
                if((char*)allocCurrent > (char*)current){
    80004bec:	04f56863          	bltu	a0,a5,80004c3c <_ZN15MemoryAllocator9mem_allocEm+0x12c>
                prevCurrent = allocCurrent;
    80004bf0:	00078713          	mv	a4,a5
                allocCurrent = allocCurrent->next;
    80004bf4:	0087b783          	ld	a5,8(a5)
            while(allocCurrent){
    80004bf8:	ff1ff06f          	j	80004be8 <_ZN15MemoryAllocator9mem_allocEm+0xd8>
                if(prev)
    80004bfc:	00070863          	beqz	a4,80004c0c <_ZN15MemoryAllocator9mem_allocEm+0xfc>
                    prev->next = current->next;
    80004c00:	00853783          	ld	a5,8(a0)
    80004c04:	00f73423          	sd	a5,8(a4)
    80004c08:	fd1ff06f          	j	80004bd8 <_ZN15MemoryAllocator9mem_allocEm+0xc8>
                    freeMemHead = current->next;
    80004c0c:	00853783          	ld	a5,8(a0)
    80004c10:	00007717          	auipc	a4,0x7
    80004c14:	bef73c23          	sd	a5,-1032(a4) # 8000b808 <_ZN15MemoryAllocator11freeMemHeadE>
    80004c18:	fc1ff06f          	j	80004bd8 <_ZN15MemoryAllocator9mem_allocEm+0xc8>
                    freeMemHead = freeSegment;
    80004c1c:	00007797          	auipc	a5,0x7
    80004c20:	bed7b623          	sd	a3,-1044(a5) # 8000b808 <_ZN15MemoryAllocator11freeMemHeadE>
    80004c24:	fb5ff06f          	j	80004bd8 <_ZN15MemoryAllocator9mem_allocEm+0xc8>
                allocMemHead = current;
    80004c28:	00007797          	auipc	a5,0x7
    80004c2c:	bea7b423          	sd	a0,-1048(a5) # 8000b810 <_ZN15MemoryAllocator12allocMemHeadE>
                current->next = nullptr;
    80004c30:	00053423          	sd	zero,8(a0)
                return (char*)current + sizeof(MemBlock);
    80004c34:	01050513          	addi	a0,a0,16
    80004c38:	0180006f          	j	80004c50 <_ZN15MemoryAllocator9mem_allocEm+0x140>
                    if(prevCurrent)
    80004c3c:	02070663          	beqz	a4,80004c68 <_ZN15MemoryAllocator9mem_allocEm+0x158>
                        prevCurrent->next = current;
    80004c40:	00a73423          	sd	a0,8(a4)
                    current->next = allocCurrent;
    80004c44:	00f53423          	sd	a5,8(a0)
            if(allocCurrent == nullptr && prevCurrent != nullptr){
    80004c48:	02078663          	beqz	a5,80004c74 <_ZN15MemoryAllocator9mem_allocEm+0x164>
            return (char*)current + sizeof(MemBlock);
    80004c4c:	01050513          	addi	a0,a0,16
    }
    return nullptr;
}
    80004c50:	01813083          	ld	ra,24(sp)
    80004c54:	01013403          	ld	s0,16(sp)
    80004c58:	00813483          	ld	s1,8(sp)
    80004c5c:	00013903          	ld	s2,0(sp)
    80004c60:	02010113          	addi	sp,sp,32
    80004c64:	00008067          	ret
                        allocMemHead = current;
    80004c68:	00007697          	auipc	a3,0x7
    80004c6c:	baa6b423          	sd	a0,-1112(a3) # 8000b810 <_ZN15MemoryAllocator12allocMemHeadE>
    80004c70:	fd5ff06f          	j	80004c44 <_ZN15MemoryAllocator9mem_allocEm+0x134>
            if(allocCurrent == nullptr && prevCurrent != nullptr){
    80004c74:	fc070ce3          	beqz	a4,80004c4c <_ZN15MemoryAllocator9mem_allocEm+0x13c>
                current->next = nullptr;
    80004c78:	00053423          	sd	zero,8(a0)
                prevCurrent->next = current;
    80004c7c:	00a73423          	sd	a0,8(a4)
    80004c80:	fcdff06f          	j	80004c4c <_ZN15MemoryAllocator9mem_allocEm+0x13c>
    if(size <= 0) return nullptr;
    80004c84:	00000513          	li	a0,0
    80004c88:	fc9ff06f          	j	80004c50 <_ZN15MemoryAllocator9mem_allocEm+0x140>

0000000080004c8c <_ZN15MemoryAllocator9tryToJoinEv>:
        current = current->next;
    }
    return -1;
}

void MemoryAllocator::tryToJoin(){
    80004c8c:	ff010113          	addi	sp,sp,-16
    80004c90:	00813423          	sd	s0,8(sp)
    80004c94:	01010413          	addi	s0,sp,16
    MemBlock* current = freeMemHead;
    80004c98:	00007797          	auipc	a5,0x7
    80004c9c:	b707b783          	ld	a5,-1168(a5) # 8000b808 <_ZN15MemoryAllocator11freeMemHeadE>
    80004ca0:	0080006f          	j	80004ca8 <_ZN15MemoryAllocator9tryToJoinEv+0x1c>
        if (currentEndAddr == (char*)(current->next)) {
            // Merge the current block with the next block
            current->size += current->next->size + sizeof(MemBlock);
            current->next = current->next->next;
        } else {
            current = current->next;
    80004ca4:	00070793          	mv	a5,a4
    while (current && current->next) {
    80004ca8:	02078c63          	beqz	a5,80004ce0 <_ZN15MemoryAllocator9tryToJoinEv+0x54>
    80004cac:	0087b703          	ld	a4,8(a5)
    80004cb0:	02070863          	beqz	a4,80004ce0 <_ZN15MemoryAllocator9tryToJoinEv+0x54>
        char* currentEndAddr = (char*)(current) + current->size + sizeof(MemBlock);
    80004cb4:	0007b603          	ld	a2,0(a5)
    80004cb8:	01060693          	addi	a3,a2,16 # 2010 <_entry-0x7fffdff0>
    80004cbc:	00d786b3          	add	a3,a5,a3
        if (currentEndAddr == (char*)(current->next)) {
    80004cc0:	fed712e3          	bne	a4,a3,80004ca4 <_ZN15MemoryAllocator9tryToJoinEv+0x18>
            current->size += current->next->size + sizeof(MemBlock);
    80004cc4:	00073683          	ld	a3,0(a4)
    80004cc8:	00d60633          	add	a2,a2,a3
    80004ccc:	01060613          	addi	a2,a2,16
    80004cd0:	00c7b023          	sd	a2,0(a5)
            current->next = current->next->next;
    80004cd4:	00873703          	ld	a4,8(a4)
    80004cd8:	00e7b423          	sd	a4,8(a5)
    80004cdc:	fcdff06f          	j	80004ca8 <_ZN15MemoryAllocator9tryToJoinEv+0x1c>
        }
    }
    80004ce0:	00813403          	ld	s0,8(sp)
    80004ce4:	01010113          	addi	sp,sp,16
    80004ce8:	00008067          	ret

0000000080004cec <_ZN15MemoryAllocator8mem_freeEPv>:
    if(addr == nullptr) return -1;
    80004cec:	0e050263          	beqz	a0,80004dd0 <_ZN15MemoryAllocator8mem_freeEPv+0xe4>
    if(allocMemHead == nullptr) return -2;
    80004cf0:	00007797          	auipc	a5,0x7
    80004cf4:	b207b783          	ld	a5,-1248(a5) # 8000b810 <_ZN15MemoryAllocator12allocMemHeadE>
    80004cf8:	0e078063          	beqz	a5,80004dd8 <_ZN15MemoryAllocator8mem_freeEPv+0xec>
    if(addr < HEAP_START_ADDR) return -3;
    80004cfc:	00007717          	auipc	a4,0x7
    80004d00:	9ec73703          	ld	a4,-1556(a4) # 8000b6e8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80004d04:	00073703          	ld	a4,0(a4)
    80004d08:	0ce56c63          	bltu	a0,a4,80004de0 <_ZN15MemoryAllocator8mem_freeEPv+0xf4>
    if(addr > HEAP_END_ADDR) return -4;
    80004d0c:	00007717          	auipc	a4,0x7
    80004d10:	a1c73703          	ld	a4,-1508(a4) # 8000b728 <_GLOBAL_OFFSET_TABLE_+0x50>
    80004d14:	00073703          	ld	a4,0(a4)
    80004d18:	0ca76863          	bltu	a4,a0,80004de8 <_ZN15MemoryAllocator8mem_freeEPv+0xfc>
    MemBlock *current = allocMemHead, *prev = nullptr;
    80004d1c:	00000693          	li	a3,0
    while(current){
    80004d20:	0c078863          	beqz	a5,80004df0 <_ZN15MemoryAllocator8mem_freeEPv+0x104>
        if((char*)current == (char*)addr - sizeof(MemBlock)){
    80004d24:	ff050713          	addi	a4,a0,-16
    80004d28:	00f70863          	beq	a4,a5,80004d38 <_ZN15MemoryAllocator8mem_freeEPv+0x4c>
        prev = current;
    80004d2c:	00078693          	mv	a3,a5
        current = current->next;
    80004d30:	0087b783          	ld	a5,8(a5)
    while(current){
    80004d34:	fedff06f          	j	80004d20 <_ZN15MemoryAllocator8mem_freeEPv+0x34>
            if(prev)
    80004d38:	04068063          	beqz	a3,80004d78 <_ZN15MemoryAllocator8mem_freeEPv+0x8c>
                prev->next = current->next;
    80004d3c:	0087b783          	ld	a5,8(a5)
    80004d40:	00f6b423          	sd	a5,8(a3)
            MemBlock *freeCurrent = freeMemHead, *prevCurrent = nullptr;
    80004d44:	00007797          	auipc	a5,0x7
    80004d48:	ac47b783          	ld	a5,-1340(a5) # 8000b808 <_ZN15MemoryAllocator11freeMemHeadE>
            if(freeCurrent == nullptr) {
    80004d4c:	0a078663          	beqz	a5,80004df8 <_ZN15MemoryAllocator8mem_freeEPv+0x10c>
int MemoryAllocator::mem_free(void* addr){
    80004d50:	ff010113          	addi	sp,sp,-16
    80004d54:	00113423          	sd	ra,8(sp)
    80004d58:	00813023          	sd	s0,0(sp)
    80004d5c:	01010413          	addi	s0,sp,16
            MemBlock *freeCurrent = freeMemHead, *prevCurrent = nullptr;
    80004d60:	00000693          	li	a3,0
                while(freeCurrent){
    80004d64:	02078863          	beqz	a5,80004d94 <_ZN15MemoryAllocator8mem_freeEPv+0xa8>
                    if((char*)freeCurrent > (char*)freeBlock){
    80004d68:	02f76063          	bltu	a4,a5,80004d88 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
                    prevCurrent = freeCurrent;
    80004d6c:	00078693          	mv	a3,a5
                    freeCurrent = freeCurrent->next;
    80004d70:	0087b783          	ld	a5,8(a5)
                while(freeCurrent){
    80004d74:	ff1ff06f          	j	80004d64 <_ZN15MemoryAllocator8mem_freeEPv+0x78>
                allocMemHead = current->next;
    80004d78:	0087b783          	ld	a5,8(a5)
    80004d7c:	00007697          	auipc	a3,0x7
    80004d80:	a8f6ba23          	sd	a5,-1388(a3) # 8000b810 <_ZN15MemoryAllocator12allocMemHeadE>
    80004d84:	fc1ff06f          	j	80004d44 <_ZN15MemoryAllocator8mem_freeEPv+0x58>
                        if(prevCurrent)
    80004d88:	02068663          	beqz	a3,80004db4 <_ZN15MemoryAllocator8mem_freeEPv+0xc8>
                            prevCurrent->next = freeBlock;
    80004d8c:	00e6b423          	sd	a4,8(a3)
                        freeBlock->next = freeCurrent;
    80004d90:	fef53c23          	sd	a5,-8(a0)
                if(freeCurrent == nullptr && prevCurrent != nullptr){
    80004d94:	02078663          	beqz	a5,80004dc0 <_ZN15MemoryAllocator8mem_freeEPv+0xd4>
                tryToJoin();
    80004d98:	00000097          	auipc	ra,0x0
    80004d9c:	ef4080e7          	jalr	-268(ra) # 80004c8c <_ZN15MemoryAllocator9tryToJoinEv>
            return 0;
    80004da0:	00000513          	li	a0,0
}
    80004da4:	00813083          	ld	ra,8(sp)
    80004da8:	00013403          	ld	s0,0(sp)
    80004dac:	01010113          	addi	sp,sp,16
    80004db0:	00008067          	ret
                            freeMemHead = freeBlock;
    80004db4:	00007617          	auipc	a2,0x7
    80004db8:	a4e63a23          	sd	a4,-1452(a2) # 8000b808 <_ZN15MemoryAllocator11freeMemHeadE>
    80004dbc:	fd5ff06f          	j	80004d90 <_ZN15MemoryAllocator8mem_freeEPv+0xa4>
                if(freeCurrent == nullptr && prevCurrent != nullptr){
    80004dc0:	fc068ce3          	beqz	a3,80004d98 <_ZN15MemoryAllocator8mem_freeEPv+0xac>
                    freeBlock->next = nullptr;
    80004dc4:	fe053c23          	sd	zero,-8(a0)
                    prevCurrent->next = freeBlock;
    80004dc8:	00e6b423          	sd	a4,8(a3)
    80004dcc:	fcdff06f          	j	80004d98 <_ZN15MemoryAllocator8mem_freeEPv+0xac>
    if(addr == nullptr) return -1;
    80004dd0:	fff00513          	li	a0,-1
    80004dd4:	00008067          	ret
    if(allocMemHead == nullptr) return -2;
    80004dd8:	ffe00513          	li	a0,-2
    80004ddc:	00008067          	ret
    if(addr < HEAP_START_ADDR) return -3;
    80004de0:	ffd00513          	li	a0,-3
    80004de4:	00008067          	ret
    if(addr > HEAP_END_ADDR) return -4;
    80004de8:	ffc00513          	li	a0,-4
    80004dec:	00008067          	ret
    return -1;
    80004df0:	fff00513          	li	a0,-1
    80004df4:	00008067          	ret
                freeMemHead = freeBlock;
    80004df8:	00007797          	auipc	a5,0x7
    80004dfc:	a0e7b823          	sd	a4,-1520(a5) # 8000b808 <_ZN15MemoryAllocator11freeMemHeadE>
                freeBlock->next = nullptr;
    80004e00:	fe053c23          	sd	zero,-8(a0)
            return 0;
    80004e04:	00000513          	li	a0,0
}
    80004e08:	00008067          	ret

0000000080004e0c <_ZN6ThreadD1Ev>:

Thread::Thread(void (*body)(void*), void* arg){
    thread_create(&myHandle, body, arg);
}

Thread::~Thread(){
    80004e0c:	ff010113          	addi	sp,sp,-16
    80004e10:	00813423          	sd	s0,8(sp)
    80004e14:	01010413          	addi	s0,sp,16
}
    80004e18:	00813403          	ld	s0,8(sp)
    80004e1c:	01010113          	addi	sp,sp,16
    80004e20:	00008067          	ret

0000000080004e24 <_ZN6Thread12startWrapperEPv>:

Thread::Thread(){
    _thread_create(&myHandle, startWrapper, this);
}

void Thread::startWrapper(void* handle){
    80004e24:	ff010113          	addi	sp,sp,-16
    80004e28:	00113423          	sd	ra,8(sp)
    80004e2c:	00813023          	sd	s0,0(sp)
    80004e30:	01010413          	addi	s0,sp,16
    ((Thread*)handle)->run();
    80004e34:	00053783          	ld	a5,0(a0)
    80004e38:	0107b783          	ld	a5,16(a5)
    80004e3c:	000780e7          	jalr	a5
}
    80004e40:	00813083          	ld	ra,8(sp)
    80004e44:	00013403          	ld	s0,0(sp)
    80004e48:	01010113          	addi	sp,sp,16
    80004e4c:	00008067          	ret

0000000080004e50 <_Z41__static_initialization_and_destruction_0ii>:
    return ::getc();
}

void Console::putc(char c) {
    ::putc(c);
    80004e50:	ff010113          	addi	sp,sp,-16
    80004e54:	00813423          	sd	s0,8(sp)
    80004e58:	01010413          	addi	s0,sp,16
    80004e5c:	00100793          	li	a5,1
    80004e60:	00f50863          	beq	a0,a5,80004e70 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80004e64:	00813403          	ld	s0,8(sp)
    80004e68:	01010113          	addi	sp,sp,16
    80004e6c:	00008067          	ret
    80004e70:	000107b7          	lui	a5,0x10
    80004e74:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80004e78:	fef596e3          	bne	a1,a5,80004e64 <_Z41__static_initialization_and_destruction_0ii+0x14>
    List() : head(0), tail(0) {}
    80004e7c:	00007797          	auipc	a5,0x7
    80004e80:	9a478793          	addi	a5,a5,-1628 # 8000b820 <_ZN6Thread7waitingE>
    80004e84:	0007b023          	sd	zero,0(a5)
    80004e88:	0007b423          	sd	zero,8(a5)
    80004e8c:	fd9ff06f          	j	80004e64 <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080004e90 <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    80004e90:	ff010113          	addi	sp,sp,-16
    80004e94:	00113423          	sd	ra,8(sp)
    80004e98:	00813023          	sd	s0,0(sp)
    80004e9c:	01010413          	addi	s0,sp,16
    80004ea0:	00007797          	auipc	a5,0x7
    80004ea4:	82878793          	addi	a5,a5,-2008 # 8000b6c8 <_ZTV9Semaphore+0x10>
    80004ea8:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80004eac:	00853503          	ld	a0,8(a0)
    80004eb0:	ffffc097          	auipc	ra,0xffffc
    80004eb4:	7d8080e7          	jalr	2008(ra) # 80001688 <_Z9sem_closeP3Sem>
}
    80004eb8:	00813083          	ld	ra,8(sp)
    80004ebc:	00013403          	ld	s0,0(sp)
    80004ec0:	01010113          	addi	sp,sp,16
    80004ec4:	00008067          	ret

0000000080004ec8 <_Znwm>:
void* operator new(size_t size){
    80004ec8:	ff010113          	addi	sp,sp,-16
    80004ecc:	00113423          	sd	ra,8(sp)
    80004ed0:	00813023          	sd	s0,0(sp)
    80004ed4:	01010413          	addi	s0,sp,16
    if(size % MEM_BLOCK_SIZE > 0){
    80004ed8:	03f57793          	andi	a5,a0,63
    80004edc:	02078263          	beqz	a5,80004f00 <_Znwm+0x38>
        size/=MEM_BLOCK_SIZE;
    80004ee0:	00655513          	srli	a0,a0,0x6
        ++size;
    80004ee4:	00150513          	addi	a0,a0,1
    return mem_alloc(size);
    80004ee8:	ffffc097          	auipc	ra,0xffffc
    80004eec:	4b4080e7          	jalr	1204(ra) # 8000139c <_Z9mem_allocm>
}
    80004ef0:	00813083          	ld	ra,8(sp)
    80004ef4:	00013403          	ld	s0,0(sp)
    80004ef8:	01010113          	addi	sp,sp,16
    80004efc:	00008067          	ret
        size/=MEM_BLOCK_SIZE;
    80004f00:	00655513          	srli	a0,a0,0x6
    80004f04:	fe5ff06f          	j	80004ee8 <_Znwm+0x20>

0000000080004f08 <_Znam>:
void* operator new[](size_t size){
    80004f08:	ff010113          	addi	sp,sp,-16
    80004f0c:	00113423          	sd	ra,8(sp)
    80004f10:	00813023          	sd	s0,0(sp)
    80004f14:	01010413          	addi	s0,sp,16
    if(size % MEM_BLOCK_SIZE > 0){
    80004f18:	03f57793          	andi	a5,a0,63
    80004f1c:	02078263          	beqz	a5,80004f40 <_Znam+0x38>
        size/=MEM_BLOCK_SIZE;
    80004f20:	00655513          	srli	a0,a0,0x6
        ++size;
    80004f24:	00150513          	addi	a0,a0,1
    return mem_alloc(size);
    80004f28:	ffffc097          	auipc	ra,0xffffc
    80004f2c:	474080e7          	jalr	1140(ra) # 8000139c <_Z9mem_allocm>
}
    80004f30:	00813083          	ld	ra,8(sp)
    80004f34:	00013403          	ld	s0,0(sp)
    80004f38:	01010113          	addi	sp,sp,16
    80004f3c:	00008067          	ret
        size/=MEM_BLOCK_SIZE;
    80004f40:	00655513          	srli	a0,a0,0x6
    80004f44:	fe5ff06f          	j	80004f28 <_Znam+0x20>

0000000080004f48 <_ZdlPv>:
void operator delete(void* ptr){
    80004f48:	ff010113          	addi	sp,sp,-16
    80004f4c:	00113423          	sd	ra,8(sp)
    80004f50:	00813023          	sd	s0,0(sp)
    80004f54:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    80004f58:	ffffc097          	auipc	ra,0xffffc
    80004f5c:	478080e7          	jalr	1144(ra) # 800013d0 <_Z8mem_freePv>
}
    80004f60:	00813083          	ld	ra,8(sp)
    80004f64:	00013403          	ld	s0,0(sp)
    80004f68:	01010113          	addi	sp,sp,16
    80004f6c:	00008067          	ret

0000000080004f70 <_ZN6ThreadD0Ev>:
Thread::~Thread(){
    80004f70:	ff010113          	addi	sp,sp,-16
    80004f74:	00113423          	sd	ra,8(sp)
    80004f78:	00813023          	sd	s0,0(sp)
    80004f7c:	01010413          	addi	s0,sp,16
}
    80004f80:	00000097          	auipc	ra,0x0
    80004f84:	fc8080e7          	jalr	-56(ra) # 80004f48 <_ZdlPv>
    80004f88:	00813083          	ld	ra,8(sp)
    80004f8c:	00013403          	ld	s0,0(sp)
    80004f90:	01010113          	addi	sp,sp,16
    80004f94:	00008067          	ret

0000000080004f98 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    80004f98:	fe010113          	addi	sp,sp,-32
    80004f9c:	00113c23          	sd	ra,24(sp)
    80004fa0:	00813823          	sd	s0,16(sp)
    80004fa4:	00913423          	sd	s1,8(sp)
    80004fa8:	02010413          	addi	s0,sp,32
    80004fac:	00050493          	mv	s1,a0
}
    80004fb0:	00000097          	auipc	ra,0x0
    80004fb4:	ee0080e7          	jalr	-288(ra) # 80004e90 <_ZN9SemaphoreD1Ev>
    80004fb8:	00048513          	mv	a0,s1
    80004fbc:	00000097          	auipc	ra,0x0
    80004fc0:	f8c080e7          	jalr	-116(ra) # 80004f48 <_ZdlPv>
    80004fc4:	01813083          	ld	ra,24(sp)
    80004fc8:	01013403          	ld	s0,16(sp)
    80004fcc:	00813483          	ld	s1,8(sp)
    80004fd0:	02010113          	addi	sp,sp,32
    80004fd4:	00008067          	ret

0000000080004fd8 <_ZdaPv>:
void operator delete[](void* ptr){
    80004fd8:	ff010113          	addi	sp,sp,-16
    80004fdc:	00113423          	sd	ra,8(sp)
    80004fe0:	00813023          	sd	s0,0(sp)
    80004fe4:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    80004fe8:	ffffc097          	auipc	ra,0xffffc
    80004fec:	3e8080e7          	jalr	1000(ra) # 800013d0 <_Z8mem_freePv>
}
    80004ff0:	00813083          	ld	ra,8(sp)
    80004ff4:	00013403          	ld	s0,0(sp)
    80004ff8:	01010113          	addi	sp,sp,16
    80004ffc:	00008067          	ret

0000000080005000 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void* arg){
    80005000:	ff010113          	addi	sp,sp,-16
    80005004:	00113423          	sd	ra,8(sp)
    80005008:	00813023          	sd	s0,0(sp)
    8000500c:	01010413          	addi	s0,sp,16
    80005010:	00006797          	auipc	a5,0x6
    80005014:	69078793          	addi	a5,a5,1680 # 8000b6a0 <_ZTV6Thread+0x10>
    80005018:	00f53023          	sd	a5,0(a0)
    thread_create(&myHandle, body, arg);
    8000501c:	00850513          	addi	a0,a0,8
    80005020:	ffffc097          	auipc	ra,0xffffc
    80005024:	3e8080e7          	jalr	1000(ra) # 80001408 <_Z13thread_createPP3PCBPFvPvES2_>
}
    80005028:	00813083          	ld	ra,8(sp)
    8000502c:	00013403          	ld	s0,0(sp)
    80005030:	01010113          	addi	sp,sp,16
    80005034:	00008067          	ret

0000000080005038 <_ZN6Thread5startEv>:
int Thread::start(){
    80005038:	ff010113          	addi	sp,sp,-16
    8000503c:	00113423          	sd	ra,8(sp)
    80005040:	00813023          	sd	s0,0(sp)
    80005044:	01010413          	addi	s0,sp,16
    Scheduler::put((PCB*)myHandle);
    80005048:	00853503          	ld	a0,8(a0)
    8000504c:	00001097          	auipc	ra,0x1
    80005050:	a94080e7          	jalr	-1388(ra) # 80005ae0 <_ZN9Scheduler3putEP3PCB>
}
    80005054:	00000513          	li	a0,0
    80005058:	00813083          	ld	ra,8(sp)
    8000505c:	00013403          	ld	s0,0(sp)
    80005060:	01010113          	addi	sp,sp,16
    80005064:	00008067          	ret

0000000080005068 <_ZN6Thread4joinEv>:
void Thread::join(){
    80005068:	ff010113          	addi	sp,sp,-16
    8000506c:	00113423          	sd	ra,8(sp)
    80005070:	00813023          	sd	s0,0(sp)
    80005074:	01010413          	addi	s0,sp,16
    thread_join(myHandle);
    80005078:	00853503          	ld	a0,8(a0)
    8000507c:	ffffc097          	auipc	ra,0xffffc
    80005080:	50c080e7          	jalr	1292(ra) # 80001588 <_Z11thread_joinP3PCB>
}
    80005084:	00813083          	ld	ra,8(sp)
    80005088:	00013403          	ld	s0,0(sp)
    8000508c:	01010113          	addi	sp,sp,16
    80005090:	00008067          	ret

0000000080005094 <_ZN6Thread8dispatchEv>:
void Thread::dispatch(){
    80005094:	ff010113          	addi	sp,sp,-16
    80005098:	00113423          	sd	ra,8(sp)
    8000509c:	00813023          	sd	s0,0(sp)
    800050a0:	01010413          	addi	s0,sp,16
    thread_dispatch();
    800050a4:	ffffc097          	auipc	ra,0xffffc
    800050a8:	4c0080e7          	jalr	1216(ra) # 80001564 <_Z15thread_dispatchv>
}
    800050ac:	00813083          	ld	ra,8(sp)
    800050b0:	00013403          	ld	s0,0(sp)
    800050b4:	01010113          	addi	sp,sp,16
    800050b8:	00008067          	ret

00000000800050bc <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t t){
    800050bc:	ff010113          	addi	sp,sp,-16
    800050c0:	00113423          	sd	ra,8(sp)
    800050c4:	00813023          	sd	s0,0(sp)
    800050c8:	01010413          	addi	s0,sp,16
    return time_sleep(t);
    800050cc:	ffffc097          	auipc	ra,0xffffc
    800050d0:	664080e7          	jalr	1636(ra) # 80001730 <_Z10time_sleepm>
}
    800050d4:	00813083          	ld	ra,8(sp)
    800050d8:	00013403          	ld	s0,0(sp)
    800050dc:	01010113          	addi	sp,sp,16
    800050e0:	00008067          	ret

00000000800050e4 <_ZN6Thread10setRunningEPS_>:
void Thread::setRunning(Thread *thread) {
    800050e4:	ff010113          	addi	sp,sp,-16
    800050e8:	00813423          	sd	s0,8(sp)
    800050ec:	01010413          	addi	s0,sp,16
    PCB::running = thread->myHandle;
    800050f0:	00853703          	ld	a4,8(a0)
    800050f4:	00006797          	auipc	a5,0x6
    800050f8:	62c7b783          	ld	a5,1580(a5) # 8000b720 <_GLOBAL_OFFSET_TABLE_+0x48>
    800050fc:	00e7b023          	sd	a4,0(a5)
}
    80005100:	00813403          	ld	s0,8(sp)
    80005104:	01010113          	addi	sp,sp,16
    80005108:	00008067          	ret

000000008000510c <_ZN6ThreadC1Ev>:
Thread::Thread(){
    8000510c:	ff010113          	addi	sp,sp,-16
    80005110:	00113423          	sd	ra,8(sp)
    80005114:	00813023          	sd	s0,0(sp)
    80005118:	01010413          	addi	s0,sp,16
    8000511c:	00006797          	auipc	a5,0x6
    80005120:	58478793          	addi	a5,a5,1412 # 8000b6a0 <_ZTV6Thread+0x10>
    80005124:	00f53023          	sd	a5,0(a0)
    _thread_create(&myHandle, startWrapper, this);
    80005128:	00050613          	mv	a2,a0
    8000512c:	00000597          	auipc	a1,0x0
    80005130:	cf858593          	addi	a1,a1,-776 # 80004e24 <_ZN6Thread12startWrapperEPv>
    80005134:	00850513          	addi	a0,a0,8
    80005138:	ffffc097          	auipc	ra,0xffffc
    8000513c:	364080e7          	jalr	868(ra) # 8000149c <_Z14_thread_createPP3PCBPFvPvES2_>
}
    80005140:	00813083          	ld	ra,8(sp)
    80005144:	00013403          	ld	s0,0(sp)
    80005148:	01010113          	addi	sp,sp,16
    8000514c:	00008067          	ret

0000000080005150 <_ZN6Thread17SetMaximumThreadsEi>:
void Thread::SetMaximumThreads(int num_of_threads) {
    80005150:	ff010113          	addi	sp,sp,-16
    80005154:	00813423          	sd	s0,8(sp)
    80005158:	01010413          	addi	s0,sp,16
    maxThreads = num_of_threads;
    8000515c:	00006797          	auipc	a5,0x6
    80005160:	6ca7aa23          	sw	a0,1748(a5) # 8000b830 <_ZN6Thread10maxThreadsE>
}
    80005164:	00813403          	ld	s0,8(sp)
    80005168:	01010113          	addi	sp,sp,16
    8000516c:	00008067          	ret

0000000080005170 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned init){
    80005170:	ff010113          	addi	sp,sp,-16
    80005174:	00113423          	sd	ra,8(sp)
    80005178:	00813023          	sd	s0,0(sp)
    8000517c:	01010413          	addi	s0,sp,16
    80005180:	00006797          	auipc	a5,0x6
    80005184:	54878793          	addi	a5,a5,1352 # 8000b6c8 <_ZTV9Semaphore+0x10>
    80005188:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    8000518c:	00850513          	addi	a0,a0,8
    80005190:	ffffc097          	auipc	ra,0xffffc
    80005194:	4b4080e7          	jalr	1204(ra) # 80001644 <_Z8sem_openPP3Semj>
}
    80005198:	00813083          	ld	ra,8(sp)
    8000519c:	00013403          	ld	s0,0(sp)
    800051a0:	01010113          	addi	sp,sp,16
    800051a4:	00008067          	ret

00000000800051a8 <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    800051a8:	ff010113          	addi	sp,sp,-16
    800051ac:	00113423          	sd	ra,8(sp)
    800051b0:	00813023          	sd	s0,0(sp)
    800051b4:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    800051b8:	00853503          	ld	a0,8(a0)
    800051bc:	ffffc097          	auipc	ra,0xffffc
    800051c0:	504080e7          	jalr	1284(ra) # 800016c0 <_Z8sem_waitP3Sem>
}
    800051c4:	00813083          	ld	ra,8(sp)
    800051c8:	00013403          	ld	s0,0(sp)
    800051cc:	01010113          	addi	sp,sp,16
    800051d0:	00008067          	ret

00000000800051d4 <_ZN9Semaphore6signalEv>:
int Semaphore::signal(){
    800051d4:	ff010113          	addi	sp,sp,-16
    800051d8:	00113423          	sd	ra,8(sp)
    800051dc:	00813023          	sd	s0,0(sp)
    800051e0:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    800051e4:	00853503          	ld	a0,8(a0)
    800051e8:	ffffc097          	auipc	ra,0xffffc
    800051ec:	510080e7          	jalr	1296(ra) # 800016f8 <_Z10sem_signalP3Sem>
}
    800051f0:	00813083          	ld	ra,8(sp)
    800051f4:	00013403          	ld	s0,0(sp)
    800051f8:	01010113          	addi	sp,sp,16
    800051fc:	00008067          	ret

0000000080005200 <_ZN7Console4getcEv>:
char Console::getc() {
    80005200:	ff010113          	addi	sp,sp,-16
    80005204:	00113423          	sd	ra,8(sp)
    80005208:	00813023          	sd	s0,0(sp)
    8000520c:	01010413          	addi	s0,sp,16
    return ::getc();
    80005210:	ffffc097          	auipc	ra,0xffffc
    80005214:	53c080e7          	jalr	1340(ra) # 8000174c <_Z4getcv>
}
    80005218:	00813083          	ld	ra,8(sp)
    8000521c:	00013403          	ld	s0,0(sp)
    80005220:	01010113          	addi	sp,sp,16
    80005224:	00008067          	ret

0000000080005228 <_ZN7Console4putcEc>:
void Console::putc(char c) {
    80005228:	ff010113          	addi	sp,sp,-16
    8000522c:	00113423          	sd	ra,8(sp)
    80005230:	00813023          	sd	s0,0(sp)
    80005234:	01010413          	addi	s0,sp,16
    ::putc(c);
    80005238:	ffffc097          	auipc	ra,0xffffc
    8000523c:	548080e7          	jalr	1352(ra) # 80001780 <_Z4putcc>
    80005240:	00813083          	ld	ra,8(sp)
    80005244:	00013403          	ld	s0,0(sp)
    80005248:	01010113          	addi	sp,sp,16
    8000524c:	00008067          	ret

0000000080005250 <_GLOBAL__sub_I__ZN6Thread10maxThreadsE>:
    80005250:	ff010113          	addi	sp,sp,-16
    80005254:	00113423          	sd	ra,8(sp)
    80005258:	00813023          	sd	s0,0(sp)
    8000525c:	01010413          	addi	s0,sp,16
    80005260:	000105b7          	lui	a1,0x10
    80005264:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80005268:	00100513          	li	a0,1
    8000526c:	00000097          	auipc	ra,0x0
    80005270:	be4080e7          	jalr	-1052(ra) # 80004e50 <_Z41__static_initialization_and_destruction_0ii>
    80005274:	00813083          	ld	ra,8(sp)
    80005278:	00013403          	ld	s0,0(sp)
    8000527c:	01010113          	addi	sp,sp,16
    80005280:	00008067          	ret

0000000080005284 <_ZN6Thread3runEv>:
    static int cntThreads;
    static List<PCB> waiting;
    static int cntWaiting;
protected:
    Thread();
    virtual void run(){}
    80005284:	ff010113          	addi	sp,sp,-16
    80005288:	00813423          	sd	s0,8(sp)
    8000528c:	01010413          	addi	s0,sp,16
    80005290:	00813403          	ld	s0,8(sp)
    80005294:	01010113          	addi	sp,sp,16
    80005298:	00008067          	ret

000000008000529c <_ZL9sleepyRunPv>:
#include "../h/syscall_c.hpp"
#include "../h/printing.hpp"

static volatile bool finished[2];

static void sleepyRun(void *arg) {
    8000529c:	fe010113          	addi	sp,sp,-32
    800052a0:	00113c23          	sd	ra,24(sp)
    800052a4:	00813823          	sd	s0,16(sp)
    800052a8:	00913423          	sd	s1,8(sp)
    800052ac:	01213023          	sd	s2,0(sp)
    800052b0:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    800052b4:	00053903          	ld	s2,0(a0)
    int i = 6;
    800052b8:	00600493          	li	s1,6
    while (--i > 0) {
    800052bc:	fff4849b          	addiw	s1,s1,-1
    800052c0:	04905463          	blez	s1,80005308 <_ZL9sleepyRunPv+0x6c>

        printString("Hello ");
    800052c4:	00004517          	auipc	a0,0x4
    800052c8:	20450513          	addi	a0,a0,516 # 800094c8 <CONSOLE_STATUS+0x4b8>
    800052cc:	fffff097          	auipc	ra,0xfffff
    800052d0:	d40080e7          	jalr	-704(ra) # 8000400c <_Z11printStringPKc>
        printInt(sleep_time);
    800052d4:	00000613          	li	a2,0
    800052d8:	00a00593          	li	a1,10
    800052dc:	0009051b          	sext.w	a0,s2
    800052e0:	fffff097          	auipc	ra,0xfffff
    800052e4:	edc080e7          	jalr	-292(ra) # 800041bc <_Z8printIntiii>
        printString(" !\n");
    800052e8:	00004517          	auipc	a0,0x4
    800052ec:	1e850513          	addi	a0,a0,488 # 800094d0 <CONSOLE_STATUS+0x4c0>
    800052f0:	fffff097          	auipc	ra,0xfffff
    800052f4:	d1c080e7          	jalr	-740(ra) # 8000400c <_Z11printStringPKc>
        time_sleep(sleep_time);
    800052f8:	00090513          	mv	a0,s2
    800052fc:	ffffc097          	auipc	ra,0xffffc
    80005300:	434080e7          	jalr	1076(ra) # 80001730 <_Z10time_sleepm>
    while (--i > 0) {
    80005304:	fb9ff06f          	j	800052bc <_ZL9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    80005308:	00a00793          	li	a5,10
    8000530c:	02f95933          	divu	s2,s2,a5
    80005310:	fff90913          	addi	s2,s2,-1
    80005314:	00006797          	auipc	a5,0x6
    80005318:	52c78793          	addi	a5,a5,1324 # 8000b840 <_ZL8finished>
    8000531c:	01278933          	add	s2,a5,s2
    80005320:	00100793          	li	a5,1
    80005324:	00f90023          	sb	a5,0(s2)
}
    80005328:	01813083          	ld	ra,24(sp)
    8000532c:	01013403          	ld	s0,16(sp)
    80005330:	00813483          	ld	s1,8(sp)
    80005334:	00013903          	ld	s2,0(sp)
    80005338:	02010113          	addi	sp,sp,32
    8000533c:	00008067          	ret

0000000080005340 <_Z12testSleepingv>:

void testSleeping() {
    80005340:	fc010113          	addi	sp,sp,-64
    80005344:	02113c23          	sd	ra,56(sp)
    80005348:	02813823          	sd	s0,48(sp)
    8000534c:	02913423          	sd	s1,40(sp)
    80005350:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    80005354:	00a00793          	li	a5,10
    80005358:	fcf43823          	sd	a5,-48(s0)
    8000535c:	01400793          	li	a5,20
    80005360:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    80005364:	00000493          	li	s1,0
    80005368:	02c0006f          	j	80005394 <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    8000536c:	00349793          	slli	a5,s1,0x3
    80005370:	fd040613          	addi	a2,s0,-48
    80005374:	00f60633          	add	a2,a2,a5
    80005378:	00000597          	auipc	a1,0x0
    8000537c:	f2458593          	addi	a1,a1,-220 # 8000529c <_ZL9sleepyRunPv>
    80005380:	fc040513          	addi	a0,s0,-64
    80005384:	00f50533          	add	a0,a0,a5
    80005388:	ffffc097          	auipc	ra,0xffffc
    8000538c:	080080e7          	jalr	128(ra) # 80001408 <_Z13thread_createPP3PCBPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    80005390:	0014849b          	addiw	s1,s1,1
    80005394:	00100793          	li	a5,1
    80005398:	fc97dae3          	bge	a5,s1,8000536c <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    8000539c:	00006797          	auipc	a5,0x6
    800053a0:	4a47c783          	lbu	a5,1188(a5) # 8000b840 <_ZL8finished>
    800053a4:	fe078ce3          	beqz	a5,8000539c <_Z12testSleepingv+0x5c>
    800053a8:	00006797          	auipc	a5,0x6
    800053ac:	4997c783          	lbu	a5,1177(a5) # 8000b841 <_ZL8finished+0x1>
    800053b0:	fe0786e3          	beqz	a5,8000539c <_Z12testSleepingv+0x5c>
}
    800053b4:	03813083          	ld	ra,56(sp)
    800053b8:	03013403          	ld	s0,48(sp)
    800053bc:	02813483          	ld	s1,40(sp)
    800053c0:	04010113          	addi	sp,sp,64
    800053c4:	00008067          	ret

00000000800053c8 <_ZN5Riscv10popSppSpieEv>:
#include "../lib/console.h"
#include "../h/printing.hpp"
#include "../h/sem.hpp"

void Riscv::popSppSpie()
{
    800053c8:	ff010113          	addi	sp,sp,-16
    800053cc:	00813423          	sd	s0,8(sp)
    800053d0:	01010413          	addi	s0,sp,16
    __asm__ volatile ("csrw sepc, ra");
    800053d4:	14109073          	csrw	sepc,ra
    __asm__ volatile ("sret");
    800053d8:	10200073          	sret
}
    800053dc:	00813403          	ld	s0,8(sp)
    800053e0:	01010113          	addi	sp,sp,16
    800053e4:	00008067          	ret

00000000800053e8 <_ZN5Riscv25handleSupervisorInterruptEv>:

void Riscv::handleSupervisorInterrupt() {
    800053e8:	f7010113          	addi	sp,sp,-144
    800053ec:	08113423          	sd	ra,136(sp)
    800053f0:	08813023          	sd	s0,128(sp)
    800053f4:	06913c23          	sd	s1,120(sp)
    800053f8:	07213823          	sd	s2,112(sp)
    800053fc:	07313423          	sd	s3,104(sp)
    80005400:	07413023          	sd	s4,96(sp)
    80005404:	05513c23          	sd	s5,88(sp)
    80005408:	09010413          	addi	s0,sp,144
    __asm__ volatile ("ld %0, 11*8(fp)" : "=r"(a1));
    8000540c:	05843783          	ld	a5,88(s0)
    80005410:	faf43023          	sd	a5,-96(s0)
    return a1;
    80005414:	fa043903          	ld	s2,-96(s0)
    __asm__ volatile ("ld %0, 12*8(fp)" : "=r"(a2));
    80005418:	06043783          	ld	a5,96(s0)
    8000541c:	f8f43c23          	sd	a5,-104(s0)
    return a2;
    80005420:	f9843983          	ld	s3,-104(s0)
    __asm__ volatile ("ld %0, 16*8(fp)" : "=r"(a6));
    80005424:	08043783          	ld	a5,128(s0)
    80005428:	f8f43823          	sd	a5,-112(s0)
    return a6;
    8000542c:	f9043583          	ld	a1,-112(s0)
}

inline uint64 Riscv::r_a7() {
    uint64 volatile a7;
    __asm__ volatile ("ld %0, 17*8(fp)" : "=r"(a7));
    80005430:	08843783          	ld	a5,136(s0)
    80005434:	f8f43423          	sd	a5,-120(s0)
    return a7;
    80005438:	f8843603          	ld	a2,-120(s0)
    __asm__ volatile ("ld %0, 10*8(fp)" : "=r"(a0));
    8000543c:	05043783          	ld	a5,80(s0)
    80005440:	f8f43023          	sd	a5,-128(s0)
    return a0;
    80005444:	f8043783          	ld	a5,-128(s0)
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80005448:	14202773          	csrr	a4,scause
    8000544c:	f6e43c23          	sd	a4,-136(s0)
    return scause;
    80005450:	f7843483          	ld	s1,-136(s0)
    uint64 a6 = r_a6();
    uint64 a7 = r_a7();
    long a0 = r_a0();
    uint64 scause = r_scause();

    if (scause == 0x0000000000000008UL || scause == 0x0000000000000009UL) {
    80005454:	ff848693          	addi	a3,s1,-8
    80005458:	00100713          	li	a4,1
    8000545c:	28d76463          	bltu	a4,a3,800056e4 <_ZN5Riscv25handleSupervisorInterruptEv+0x2fc>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80005460:	14102773          	csrr	a4,sepc
    80005464:	fae43823          	sd	a4,-80(s0)
    return sepc;
    80005468:	fb043703          	ld	a4,-80(s0)
        // interrupt -> call ecall from user/system mode
        uint64 sepc = r_sepc() + 4;
    8000546c:	00470493          	addi	s1,a4,4
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80005470:	10002773          	csrr	a4,sstatus
    80005474:	fae43423          	sd	a4,-88(s0)
    return sstatus;
    80005478:	fa843a03          	ld	s4,-88(s0)
        uint64 sstatus = r_sstatus(); // save value of status register

        if(a0 == 0x01) { // mem_alloc
    8000547c:	00100713          	li	a4,1
    80005480:	0ae78263          	beq	a5,a4,80005524 <_ZN5Riscv25handleSupervisorInterruptEv+0x13c>
            size_t size = (size_t)a1;
            void* ptr = MemoryAllocator::mem_alloc(size);
            w_a0_stack((long)ptr);
        }
        else if(a0 == 0x02) { // mem_free
    80005484:	00200713          	li	a4,2
    80005488:	0ce78c63          	beq	a5,a4,80005560 <_ZN5Riscv25handleSupervisorInterruptEv+0x178>
            a0 = MemoryAllocator::mem_free((void *)a1);
            w_a0_stack(a0);
        }
        else if(a0 == 0x11) { //thread_create
    8000548c:	01100713          	li	a4,17
    80005490:	0ee78263          	beq	a5,a4,80005574 <_ZN5Riscv25handleSupervisorInterruptEv+0x18c>
                PCB** h = (PCB**)a1;
                *(h) = handle;
                w_a0_stack(0);
            }
        }
        else if(a0 == 0x12) { // thread_exit
    80005494:	01200713          	li	a4,18
    80005498:	10e78463          	beq	a5,a4,800055a0 <_ZN5Riscv25handleSupervisorInterruptEv+0x1b8>
            a0 = PCB::exit();
            w_a0_stack(a0);
        }
        else if(a0 == 0x13) { // thread_dispatch
    8000549c:	01300713          	li	a4,19
    800054a0:	10e78863          	beq	a5,a4,800055b0 <_ZN5Riscv25handleSupervisorInterruptEv+0x1c8>
            PCB::dispatch();
        }
        else if(a0 == 0x14) { //thread_join
    800054a4:	01400713          	li	a4,20
    800054a8:	10e78a63          	beq	a5,a4,800055bc <_ZN5Riscv25handleSupervisorInterruptEv+0x1d4>
            PCB* volatile handle = (PCB*)a1;
            PCB::join(handle);
        }
        else if(a0 == 0x15){ //thread_start
    800054ac:	01500713          	li	a4,21
    800054b0:	12e78063          	beq	a5,a4,800055d0 <_ZN5Riscv25handleSupervisorInterruptEv+0x1e8>
            thread_t thread = (thread_t)a1;
            thread->start();
        } else if(a0 == 0x16){ //thread_create bez start-a
    800054b4:	01600713          	li	a4,22
    800054b8:	12e78463          	beq	a5,a4,800055e0 <_ZN5Riscv25handleSupervisorInterruptEv+0x1f8>
            else {
                PCB** h = (PCB**)a1;
                *(h) = handle;
                w_a0_stack(0);
            }
        } else if(a0 == 0x17){
    800054bc:	01700713          	li	a4,23
    800054c0:	14e78663          	beq	a5,a4,8000560c <_ZN5Riscv25handleSupervisorInterruptEv+0x224>
            thread_t thread = (thread_t)a1;
            thread->pingThread();
        }
        else if(a0 == 0x21) { // sem_open
    800054c4:	02100713          	li	a4,33
    800054c8:	16e78063          	beq	a5,a4,80005628 <_ZN5Riscv25handleSupervisorInterruptEv+0x240>
            Sem* handle = new Sem((unsigned)a2);
            Sem** h = (Sem**)a1;
            *(h) = handle;
            w_a0_stack(0);
        }
        else if(a0 == 0x22) { // sem_close
    800054cc:	02200713          	li	a4,34
    800054d0:	18e78263          	beq	a5,a4,80005654 <_ZN5Riscv25handleSupervisorInterruptEv+0x26c>
            else {
                delete sem;
                w_a0_stack(0);
            }
        }
        else if(a0 == 0x23) { // sem_wait
    800054d4:	02300713          	li	a4,35
    800054d8:	1ae78863          	beq	a5,a4,80005688 <_ZN5Riscv25handleSupervisorInterruptEv+0x2a0>
            Sem* sem = (Sem*)a1;
            sem->wait();
        }
        else if(a0 == 0x24) { // sem_signal
    800054dc:	02400713          	li	a4,36
    800054e0:	1ae78c63          	beq	a5,a4,80005698 <_ZN5Riscv25handleSupervisorInterruptEv+0x2b0>
            Sem* sem = (Sem*)a1;
            sem->signal();
        }
        else if(a0 == 0x25) { // change to user mode
    800054e4:	02500713          	li	a4,37
    800054e8:	1ce78063          	beq	a5,a4,800056a8 <_ZN5Riscv25handleSupervisorInterruptEv+0x2c0>
            mc_sstatus(1<<8);
            __asm__ volatile("csrw sepc, %0" : : "r" (sepc));
            mc_sip(SIP_SSIP);
            return;
        }
        else if(a0 == 0x41) { // getc
    800054ec:	04100713          	li	a4,65
    800054f0:	1ce78a63          	beq	a5,a4,800056c4 <_ZN5Riscv25handleSupervisorInterruptEv+0x2dc>
            char c = __getc();
            w_a0_stack((long)c);
        }
        else if(a0 == 0x42) { // putc
    800054f4:	04200713          	li	a4,66
    800054f8:	1ce78e63          	beq	a5,a4,800056d4 <_ZN5Riscv25handleSupervisorInterruptEv+0x2ec>
            __putc((char)a1);
        }
        else if(a0 == 0x50){ // getThreadId
    800054fc:	05000713          	li	a4,80
    80005500:	02e79a63          	bne	a5,a4,80005534 <_ZN5Riscv25handleSupervisorInterruptEv+0x14c>
    static int getThreadID() {return running->id;}
    80005504:	00006797          	auipc	a5,0x6
    80005508:	21c7b783          	ld	a5,540(a5) # 8000b720 <_GLOBAL_OFFSET_TABLE_+0x48>
    8000550c:	0007b783          	ld	a5,0(a5)
    80005510:	0307a783          	lw	a5,48(a5)
}

inline void Riscv::w_a0_stack(long a0) {
    __asm__ volatile ("sd %0, 10*8(fp)" : : "r"(a0));       //na 10*8(fp) se nalazi a0
    80005514:	04f43823          	sd	a5,80(s0)
            a0 = PCB::getThreadID();
            w_a0_stack(a0);

            PCB::dispatch();
    80005518:	fffff097          	auipc	ra,0xfffff
    8000551c:	888080e7          	jalr	-1912(ra) # 80003da0 <_ZN3PCB8dispatchEv>
    80005520:	0140006f          	j	80005534 <_ZN5Riscv25handleSupervisorInterruptEv+0x14c>
            void* ptr = MemoryAllocator::mem_alloc(size);
    80005524:	00090513          	mv	a0,s2
    80005528:	fffff097          	auipc	ra,0xfffff
    8000552c:	5e8080e7          	jalr	1512(ra) # 80004b10 <_ZN15MemoryAllocator9mem_allocEm>
    80005530:	04a43823          	sd	a0,80(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80005534:	100a1073          	csrw	sstatus,s4
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80005538:	14149073          	csrw	sepc,s1
        printInt(scause);
        printString("\n");
        printInt(r_sepc());
        printString("\n");
    }
}
    8000553c:	08813083          	ld	ra,136(sp)
    80005540:	08013403          	ld	s0,128(sp)
    80005544:	07813483          	ld	s1,120(sp)
    80005548:	07013903          	ld	s2,112(sp)
    8000554c:	06813983          	ld	s3,104(sp)
    80005550:	06013a03          	ld	s4,96(sp)
    80005554:	05813a83          	ld	s5,88(sp)
    80005558:	09010113          	addi	sp,sp,144
    8000555c:	00008067          	ret
            a0 = MemoryAllocator::mem_free((void *)a1);
    80005560:	00090513          	mv	a0,s2
    80005564:	fffff097          	auipc	ra,0xfffff
    80005568:	788080e7          	jalr	1928(ra) # 80004cec <_ZN15MemoryAllocator8mem_freeEPv>
    __asm__ volatile ("sd %0, 10*8(fp)" : : "r"(a0));       //na 10*8(fp) se nalazi a0
    8000556c:	04a43823          	sd	a0,80(s0)
}
    80005570:	fc5ff06f          	j	80005534 <_ZN5Riscv25handleSupervisorInterruptEv+0x14c>
            PCB *handle = PCB::createThread((void (*)(void*))(a2), (void*)a6, (uint64*)a7);
    80005574:	00098513          	mv	a0,s3
    80005578:	fffff097          	auipc	ra,0xfffff
    8000557c:	94c080e7          	jalr	-1716(ra) # 80003ec4 <_ZN3PCB12createThreadEPFvPvES0_Pm>
            if(!handle) w_a0_stack(-1);
    80005580:	00050a63          	beqz	a0,80005594 <_ZN5Riscv25handleSupervisorInterruptEv+0x1ac>
                *(h) = handle;
    80005584:	00a93023          	sd	a0,0(s2)
    __asm__ volatile ("sd %0, 10*8(fp)" : : "r"(a0));       //na 10*8(fp) se nalazi a0
    80005588:	00000793          	li	a5,0
    8000558c:	04f43823          	sd	a5,80(s0)
}
    80005590:	fa5ff06f          	j	80005534 <_ZN5Riscv25handleSupervisorInterruptEv+0x14c>
    __asm__ volatile ("sd %0, 10*8(fp)" : : "r"(a0));       //na 10*8(fp) se nalazi a0
    80005594:	fff00793          	li	a5,-1
    80005598:	04f43823          	sd	a5,80(s0)
}
    8000559c:	f99ff06f          	j	80005534 <_ZN5Riscv25handleSupervisorInterruptEv+0x14c>
            a0 = PCB::exit();
    800055a0:	fffff097          	auipc	ra,0xfffff
    800055a4:	964080e7          	jalr	-1692(ra) # 80003f04 <_ZN3PCB4exitEv>
    __asm__ volatile ("sd %0, 10*8(fp)" : : "r"(a0));       //na 10*8(fp) se nalazi a0
    800055a8:	04a43823          	sd	a0,80(s0)
}
    800055ac:	f89ff06f          	j	80005534 <_ZN5Riscv25handleSupervisorInterruptEv+0x14c>
            PCB::dispatch();
    800055b0:	ffffe097          	auipc	ra,0xffffe
    800055b4:	7f0080e7          	jalr	2032(ra) # 80003da0 <_ZN3PCB8dispatchEv>
    800055b8:	f7dff06f          	j	80005534 <_ZN5Riscv25handleSupervisorInterruptEv+0x14c>
            PCB* volatile handle = (PCB*)a1;
    800055bc:	f7243823          	sd	s2,-144(s0)
            PCB::join(handle);
    800055c0:	f7043503          	ld	a0,-144(s0)
    800055c4:	fffff097          	auipc	ra,0xfffff
    800055c8:	87c080e7          	jalr	-1924(ra) # 80003e40 <_ZN3PCB4joinEPS_>
    800055cc:	f69ff06f          	j	80005534 <_ZN5Riscv25handleSupervisorInterruptEv+0x14c>
            thread->start();
    800055d0:	00090513          	mv	a0,s2
    800055d4:	fffff097          	auipc	ra,0xfffff
    800055d8:	8ac080e7          	jalr	-1876(ra) # 80003e80 <_ZN3PCB5startEv>
    800055dc:	f59ff06f          	j	80005534 <_ZN5Riscv25handleSupervisorInterruptEv+0x14c>
            PCB *handle = PCB::_createThread((void (*)(void*))(a2), (void*)a6, (uint64*)a7);
    800055e0:	00098513          	mv	a0,s3
    800055e4:	ffffe097          	auipc	ra,0xffffe
    800055e8:	794080e7          	jalr	1940(ra) # 80003d78 <_ZN3PCB13_createThreadEPFvPvES0_Pm>
            if(!handle) w_a0_stack(-1);
    800055ec:	00050a63          	beqz	a0,80005600 <_ZN5Riscv25handleSupervisorInterruptEv+0x218>
                *(h) = handle;
    800055f0:	00a93023          	sd	a0,0(s2)
    __asm__ volatile ("sd %0, 10*8(fp)" : : "r"(a0));       //na 10*8(fp) se nalazi a0
    800055f4:	00000793          	li	a5,0
    800055f8:	04f43823          	sd	a5,80(s0)
}
    800055fc:	f39ff06f          	j	80005534 <_ZN5Riscv25handleSupervisorInterruptEv+0x14c>
    __asm__ volatile ("sd %0, 10*8(fp)" : : "r"(a0));       //na 10*8(fp) se nalazi a0
    80005600:	fff00793          	li	a5,-1
    80005604:	04f43823          	sd	a5,80(s0)
}
    80005608:	f2dff06f          	j	80005534 <_ZN5Riscv25handleSupervisorInterruptEv+0x14c>
        printString("Pingovao!\n");
    8000560c:	00004517          	auipc	a0,0x4
    80005610:	ecc50513          	addi	a0,a0,-308 # 800094d8 <CONSOLE_STATUS+0x4c8>
    80005614:	fffff097          	auipc	ra,0xfffff
    80005618:	9f8080e7          	jalr	-1544(ra) # 8000400c <_Z11printStringPKc>
        this->pinged = true;
    8000561c:	00100793          	li	a5,1
    80005620:	02f90a23          	sb	a5,52(s2)
    }
    80005624:	f11ff06f          	j	80005534 <_ZN5Riscv25handleSupervisorInterruptEv+0x14c>
            size/=MEM_BLOCK_SIZE;
            ++size;
        } else {
            size/=MEM_BLOCK_SIZE;
        }
        return MemoryAllocator::mem_alloc(size);
    80005628:	00100513          	li	a0,1
    8000562c:	fffff097          	auipc	ra,0xfffff
    80005630:	4e4080e7          	jalr	1252(ra) # 80004b10 <_ZN15MemoryAllocator9mem_allocEm>
    80005634:	00050a93          	mv	s5,a0
            Sem* handle = new Sem((unsigned)a2);
    80005638:	0009859b          	sext.w	a1,s3
    8000563c:	00000097          	auipc	ra,0x0
    80005640:	1f4080e7          	jalr	500(ra) # 80005830 <_ZN3SemC1Ej>
            *(h) = handle;
    80005644:	01593023          	sd	s5,0(s2)
    __asm__ volatile ("sd %0, 10*8(fp)" : : "r"(a0));       //na 10*8(fp) se nalazi a0
    80005648:	00000793          	li	a5,0
    8000564c:	04f43823          	sd	a5,80(s0)
}
    80005650:	ee5ff06f          	j	80005534 <_ZN5Riscv25handleSupervisorInterruptEv+0x14c>
            if(!sem) w_a0_stack(-1);
    80005654:	00091863          	bnez	s2,80005664 <_ZN5Riscv25handleSupervisorInterruptEv+0x27c>
    __asm__ volatile ("sd %0, 10*8(fp)" : : "r"(a0));       //na 10*8(fp) se nalazi a0
    80005658:	fff00793          	li	a5,-1
    8000565c:	04f43823          	sd	a5,80(s0)
}
    80005660:	ed5ff06f          	j	80005534 <_ZN5Riscv25handleSupervisorInterruptEv+0x14c>
                delete sem;
    80005664:	00090513          	mv	a0,s2
    80005668:	00000097          	auipc	ra,0x0
    8000566c:	1f0080e7          	jalr	496(ra) # 80005858 <_ZN3SemD1Ev>
            size/=MEM_BLOCK_SIZE;
        }
        return MemoryAllocator::mem_alloc(size);
    }
    void operator delete(void* ptr){
        MemoryAllocator::mem_free(ptr);
    80005670:	00090513          	mv	a0,s2
    80005674:	fffff097          	auipc	ra,0xfffff
    80005678:	678080e7          	jalr	1656(ra) # 80004cec <_ZN15MemoryAllocator8mem_freeEPv>
    __asm__ volatile ("sd %0, 10*8(fp)" : : "r"(a0));       //na 10*8(fp) se nalazi a0
    8000567c:	00000793          	li	a5,0
    80005680:	04f43823          	sd	a5,80(s0)
}
    80005684:	eb1ff06f          	j	80005534 <_ZN5Riscv25handleSupervisorInterruptEv+0x14c>
            sem->wait();
    80005688:	00090513          	mv	a0,s2
    8000568c:	00000097          	auipc	ra,0x0
    80005690:	250080e7          	jalr	592(ra) # 800058dc <_ZN3Sem4waitEv>
    80005694:	ea1ff06f          	j	80005534 <_ZN5Riscv25handleSupervisorInterruptEv+0x14c>
            sem->signal();
    80005698:	00090513          	mv	a0,s2
    8000569c:	00000097          	auipc	ra,0x0
    800056a0:	2fc080e7          	jalr	764(ra) # 80005998 <_ZN3Sem6signalEv>
    800056a4:	e91ff06f          	j	80005534 <_ZN5Riscv25handleSupervisorInterruptEv+0x14c>
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800056a8:	100a1073          	csrw	sstatus,s4
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    800056ac:	10000793          	li	a5,256
    800056b0:	1007b073          	csrc	sstatus,a5
            __asm__ volatile("csrw sepc, %0" : : "r" (sepc));
    800056b4:	14149073          	csrw	sepc,s1
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800056b8:	00200793          	li	a5,2
    800056bc:	1447b073          	csrc	sip,a5
            return;
    800056c0:	e7dff06f          	j	8000553c <_ZN5Riscv25handleSupervisorInterruptEv+0x154>
            char c = __getc();
    800056c4:	00003097          	auipc	ra,0x3
    800056c8:	ec4080e7          	jalr	-316(ra) # 80008588 <__getc>
    __asm__ volatile ("sd %0, 10*8(fp)" : : "r"(a0));       //na 10*8(fp) se nalazi a0
    800056cc:	04a43823          	sd	a0,80(s0)
}
    800056d0:	e65ff06f          	j	80005534 <_ZN5Riscv25handleSupervisorInterruptEv+0x14c>
            __putc((char)a1);
    800056d4:	0ff97513          	andi	a0,s2,255
    800056d8:	00003097          	auipc	ra,0x3
    800056dc:	e74080e7          	jalr	-396(ra) # 8000854c <__putc>
    800056e0:	e55ff06f          	j	80005534 <_ZN5Riscv25handleSupervisorInterruptEv+0x14c>
        printString("Trap cause\n");
    800056e4:	00004517          	auipc	a0,0x4
    800056e8:	e0450513          	addi	a0,a0,-508 # 800094e8 <CONSOLE_STATUS+0x4d8>
    800056ec:	fffff097          	auipc	ra,0xfffff
    800056f0:	920080e7          	jalr	-1760(ra) # 8000400c <_Z11printStringPKc>
        printInt(scause);
    800056f4:	00000613          	li	a2,0
    800056f8:	00a00593          	li	a1,10
    800056fc:	0004851b          	sext.w	a0,s1
    80005700:	fffff097          	auipc	ra,0xfffff
    80005704:	abc080e7          	jalr	-1348(ra) # 800041bc <_Z8printIntiii>
        printString("\n");
    80005708:	00004517          	auipc	a0,0x4
    8000570c:	b5050513          	addi	a0,a0,-1200 # 80009258 <CONSOLE_STATUS+0x248>
    80005710:	fffff097          	auipc	ra,0xfffff
    80005714:	8fc080e7          	jalr	-1796(ra) # 8000400c <_Z11printStringPKc>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80005718:	141027f3          	csrr	a5,sepc
    8000571c:	faf43c23          	sd	a5,-72(s0)
    return sepc;
    80005720:	fb843503          	ld	a0,-72(s0)
        printInt(r_sepc());
    80005724:	00000613          	li	a2,0
    80005728:	00a00593          	li	a1,10
    8000572c:	0005051b          	sext.w	a0,a0
    80005730:	fffff097          	auipc	ra,0xfffff
    80005734:	a8c080e7          	jalr	-1396(ra) # 800041bc <_Z8printIntiii>
        printString("\n");
    80005738:	00004517          	auipc	a0,0x4
    8000573c:	b2050513          	addi	a0,a0,-1248 # 80009258 <CONSOLE_STATUS+0x248>
    80005740:	fffff097          	auipc	ra,0xfffff
    80005744:	8cc080e7          	jalr	-1844(ra) # 8000400c <_Z11printStringPKc>
    80005748:	df5ff06f          	j	8000553c <_ZN5Riscv25handleSupervisorInterruptEv+0x154>
    8000574c:	00050493          	mv	s1,a0
    80005750:	000a8513          	mv	a0,s5
    80005754:	fffff097          	auipc	ra,0xfffff
    80005758:	598080e7          	jalr	1432(ra) # 80004cec <_ZN15MemoryAllocator8mem_freeEPv>
    8000575c:	00048513          	mv	a0,s1
    80005760:	00007097          	auipc	ra,0x7
    80005764:	1c8080e7          	jalr	456(ra) # 8000c928 <_Unwind_Resume>

0000000080005768 <_ZN5Riscv22handleConsoleInterruptEv>:

void Riscv::handleConsoleInterrupt(){
    80005768:	ff010113          	addi	sp,sp,-16
    8000576c:	00113423          	sd	ra,8(sp)
    80005770:	00813023          	sd	s0,0(sp)
    80005774:	01010413          	addi	s0,sp,16
    //extern hardware interrupt
    console_handler();
    80005778:	00003097          	auipc	ra,0x3
    8000577c:	e48080e7          	jalr	-440(ra) # 800085c0 <console_handler>
}
    80005780:	00813083          	ld	ra,8(sp)
    80005784:	00013403          	ld	s0,0(sp)
    80005788:	01010113          	addi	sp,sp,16
    8000578c:	00008067          	ret

0000000080005790 <_ZN5Riscv20handleTimerInterruptEv>:

void Riscv::handleTimerInterrupt() {
    80005790:	ff010113          	addi	sp,sp,-16
    80005794:	00813423          	sd	s0,8(sp)
    80005798:	01010413          	addi	s0,sp,16
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    8000579c:	00200793          	li	a5,2
    800057a0:	1447b073          	csrc	sip,a5
    //timer interrupt
    mc_sip(SIP_SSIP);
    if(PCB::timeSliceCounter++ >= 10 && !(PCB::readyToPrintA || PCB::readyToPrintB || PCB::readyToPrintC)){
    800057a4:	00006717          	auipc	a4,0x6
    800057a8:	f6473703          	ld	a4,-156(a4) # 8000b708 <_GLOBAL_OFFSET_TABLE_+0x30>
    800057ac:	00072783          	lw	a5,0(a4)
    800057b0:	0017869b          	addiw	a3,a5,1
    800057b4:	00d72023          	sw	a3,0(a4)
    800057b8:	00900713          	li	a4,9
    800057bc:	06f75463          	bge	a4,a5,80005824 <_ZN5Riscv20handleTimerInterruptEv+0x94>
    800057c0:	00006797          	auipc	a5,0x6
    800057c4:	f587b783          	ld	a5,-168(a5) # 8000b718 <_GLOBAL_OFFSET_TABLE_+0x40>
    800057c8:	0007c783          	lbu	a5,0(a5)
    800057cc:	04079c63          	bnez	a5,80005824 <_ZN5Riscv20handleTimerInterruptEv+0x94>
    800057d0:	00006797          	auipc	a5,0x6
    800057d4:	f307b783          	ld	a5,-208(a5) # 8000b700 <_GLOBAL_OFFSET_TABLE_+0x28>
    800057d8:	0007c783          	lbu	a5,0(a5)
    800057dc:	04079463          	bnez	a5,80005824 <_ZN5Riscv20handleTimerInterruptEv+0x94>
    800057e0:	00006797          	auipc	a5,0x6
    800057e4:	f507b783          	ld	a5,-176(a5) # 8000b730 <_GLOBAL_OFFSET_TABLE_+0x58>
    800057e8:	0007c783          	lbu	a5,0(a5)
    800057ec:	02079c63          	bnez	a5,80005824 <_ZN5Riscv20handleTimerInterruptEv+0x94>
        PCB::readyToPrintB = true;
    800057f0:	00100793          	li	a5,1
    800057f4:	00006717          	auipc	a4,0x6
    800057f8:	f0c73703          	ld	a4,-244(a4) # 8000b700 <_GLOBAL_OFFSET_TABLE_+0x28>
    800057fc:	00f70023          	sb	a5,0(a4)
        PCB::readyToPrintA = true;
    80005800:	00006717          	auipc	a4,0x6
    80005804:	f1873703          	ld	a4,-232(a4) # 8000b718 <_GLOBAL_OFFSET_TABLE_+0x40>
    80005808:	00f70023          	sb	a5,0(a4)
        PCB::readyToPrintC = true;
    8000580c:	00006717          	auipc	a4,0x6
    80005810:	f2473703          	ld	a4,-220(a4) # 8000b730 <_GLOBAL_OFFSET_TABLE_+0x58>
    80005814:	00f70023          	sb	a5,0(a4)
        PCB::timeSliceCounter = 0;
    80005818:	00006797          	auipc	a5,0x6
    8000581c:	ef07b783          	ld	a5,-272(a5) # 8000b708 <_GLOBAL_OFFSET_TABLE_+0x30>
    80005820:	0007a023          	sw	zero,0(a5)
    }
    80005824:	00813403          	ld	s0,8(sp)
    80005828:	01010113          	addi	sp,sp,16
    8000582c:	00008067          	ret

0000000080005830 <_ZN3SemC1Ej>:
//
// Created by os on 8/30/23.
//
#include "../h/sem.hpp"

Sem::Sem(unsigned  value){
    80005830:	ff010113          	addi	sp,sp,-16
    80005834:	00813423          	sd	s0,8(sp)
    80005838:	01010413          	addi	s0,sp,16
    };

    Elem *head, *tail;

public:
    List() : head(0), tail(0) {}
    8000583c:	00053423          	sd	zero,8(a0)
    80005840:	00053823          	sd	zero,16(a0)
    this->value = value;
    80005844:	00b52023          	sw	a1,0(a0)
    this->finished = false;
    80005848:	00050c23          	sb	zero,24(a0)
}
    8000584c:	00813403          	ld	s0,8(sp)
    80005850:	01010113          	addi	sp,sp,16
    80005854:	00008067          	ret

0000000080005858 <_ZN3SemD1Ev>:

Sem::~Sem(){
    80005858:	fe010113          	addi	sp,sp,-32
    8000585c:	00113c23          	sd	ra,24(sp)
    80005860:	00813823          	sd	s0,16(sp)
    80005864:	00913423          	sd	s1,8(sp)
    80005868:	01213023          	sd	s2,0(sp)
    8000586c:	02010413          	addi	s0,sp,32
    80005870:	00050493          	mv	s1,a0
    this->finished = true;
    80005874:	00100793          	li	a5,1
    80005878:	00f50c23          	sb	a5,24(a0)
    8000587c:	0280006f          	j	800058a4 <_ZN3SemD1Ev+0x4c>
    {
        if (!head) { return 0; }

        Elem *elem = head;
        head = head->next;
        if (!head) { tail = 0; }
    80005880:	0004b823          	sd	zero,16(s1)

        T *ret = elem->data;
    80005884:	00053903          	ld	s2,0(a0)
        delete elem;
    80005888:	fffff097          	auipc	ra,0xfffff
    8000588c:	6c0080e7          	jalr	1728(ra) # 80004f48 <_ZdlPv>
    while(blocked.peekFirst()){
        PCB* handle = blocked.removeFirst();
        handle->state = PCB::READY;
    80005890:	00100793          	li	a5,1
    80005894:	02f92423          	sw	a5,40(s2)
        Scheduler::put(handle);
    80005898:	00090513          	mv	a0,s2
    8000589c:	00000097          	auipc	ra,0x0
    800058a0:	244080e7          	jalr	580(ra) # 80005ae0 <_ZN9Scheduler3putEP3PCB>
        return ret;
    }

    T *peekFirst()
    {
        if (!head) { return 0; }
    800058a4:	0084b503          	ld	a0,8(s1)
    800058a8:	00050e63          	beqz	a0,800058c4 <_ZN3SemD1Ev+0x6c>
        return head->data;
    800058ac:	00053783          	ld	a5,0(a0)
    while(blocked.peekFirst()){
    800058b0:	00078a63          	beqz	a5,800058c4 <_ZN3SemD1Ev+0x6c>
        head = head->next;
    800058b4:	00853783          	ld	a5,8(a0)
    800058b8:	00f4b423          	sd	a5,8(s1)
        if (!head) { tail = 0; }
    800058bc:	fc0794e3          	bnez	a5,80005884 <_ZN3SemD1Ev+0x2c>
    800058c0:	fc1ff06f          	j	80005880 <_ZN3SemD1Ev+0x28>
    }
}
    800058c4:	01813083          	ld	ra,24(sp)
    800058c8:	01013403          	ld	s0,16(sp)
    800058cc:	00813483          	ld	s1,8(sp)
    800058d0:	00013903          	ld	s2,0(sp)
    800058d4:	02010113          	addi	sp,sp,32
    800058d8:	00008067          	ret

00000000800058dc <_ZN3Sem4waitEv>:

int Sem::wait(){
    if(finished) return -1;
    800058dc:	01854783          	lbu	a5,24(a0)
    800058e0:	0a079863          	bnez	a5,80005990 <_ZN3Sem4waitEv+0xb4>
int Sem::wait(){
    800058e4:	fe010113          	addi	sp,sp,-32
    800058e8:	00113c23          	sd	ra,24(sp)
    800058ec:	00813823          	sd	s0,16(sp)
    800058f0:	00913423          	sd	s1,8(sp)
    800058f4:	01213023          	sd	s2,0(sp)
    800058f8:	02010413          	addi	s0,sp,32
    800058fc:	00050493          	mv	s1,a0
    if(--value < 0) {
    80005900:	00052783          	lw	a5,0(a0)
    80005904:	fff7879b          	addiw	a5,a5,-1
    80005908:	00f52023          	sw	a5,0(a0)
    8000590c:	02079713          	slli	a4,a5,0x20
    80005910:	02074463          	bltz	a4,80005938 <_ZN3Sem4waitEv+0x5c>
        PCB::running->state = PCB::BLOCKED;
        this->blocked.addLast(PCB::running);
        PCB::dispatch();
        //thread_dispatch();
    }
    if (!finished) return 0;
    80005914:	0184c783          	lbu	a5,24(s1)
    80005918:	06079863          	bnez	a5,80005988 <_ZN3Sem4waitEv+0xac>
    8000591c:	00000513          	li	a0,0
    return -1;
}
    80005920:	01813083          	ld	ra,24(sp)
    80005924:	01013403          	ld	s0,16(sp)
    80005928:	00813483          	ld	s1,8(sp)
    8000592c:	00013903          	ld	s2,0(sp)
    80005930:	02010113          	addi	sp,sp,32
    80005934:	00008067          	ret
        PCB::running->state = PCB::BLOCKED;
    80005938:	00006797          	auipc	a5,0x6
    8000593c:	de87b783          	ld	a5,-536(a5) # 8000b720 <_GLOBAL_OFFSET_TABLE_+0x48>
    80005940:	0007b903          	ld	s2,0(a5)
    80005944:	00300793          	li	a5,3
    80005948:	02f92423          	sw	a5,40(s2)
        Elem *elem = new Elem(data, 0);
    8000594c:	01000513          	li	a0,16
    80005950:	fffff097          	auipc	ra,0xfffff
    80005954:	578080e7          	jalr	1400(ra) # 80004ec8 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80005958:	01253023          	sd	s2,0(a0)
    8000595c:	00053423          	sd	zero,8(a0)
        if (tail)
    80005960:	0104b783          	ld	a5,16(s1)
    80005964:	00078c63          	beqz	a5,8000597c <_ZN3Sem4waitEv+0xa0>
            tail->next = elem;
    80005968:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    8000596c:	00a4b823          	sd	a0,16(s1)
        PCB::dispatch();
    80005970:	ffffe097          	auipc	ra,0xffffe
    80005974:	430080e7          	jalr	1072(ra) # 80003da0 <_ZN3PCB8dispatchEv>
    80005978:	f9dff06f          	j	80005914 <_ZN3Sem4waitEv+0x38>
            head = tail = elem;
    8000597c:	00a4b823          	sd	a0,16(s1)
    80005980:	00a4b423          	sd	a0,8(s1)
    80005984:	fedff06f          	j	80005970 <_ZN3Sem4waitEv+0x94>
    return -1;
    80005988:	fff00513          	li	a0,-1
    8000598c:	f95ff06f          	j	80005920 <_ZN3Sem4waitEv+0x44>
    if(finished) return -1;
    80005990:	fff00513          	li	a0,-1
}
    80005994:	00008067          	ret

0000000080005998 <_ZN3Sem6signalEv>:

int Sem::signal(){
    if(finished) return -1;
    80005998:	01854703          	lbu	a4,24(a0)
    8000599c:	08071a63          	bnez	a4,80005a30 <_ZN3Sem6signalEv+0x98>
    800059a0:	00050793          	mv	a5,a0
    if(++value <= 0){
    800059a4:	00052703          	lw	a4,0(a0)
    800059a8:	0017071b          	addiw	a4,a4,1
    800059ac:	0007069b          	sext.w	a3,a4
    800059b0:	00e52023          	sw	a4,0(a0)
    800059b4:	00d05663          	blez	a3,800059c0 <_ZN3Sem6signalEv+0x28>
        PCB* pcb = blocked.removeFirst();
        pcb->state = PCB::READY;
        Scheduler::put(pcb);
    }
    return 0;
    800059b8:	00000513          	li	a0,0
    800059bc:	00008067          	ret
int Sem::signal(){
    800059c0:	fe010113          	addi	sp,sp,-32
    800059c4:	00113c23          	sd	ra,24(sp)
    800059c8:	00813823          	sd	s0,16(sp)
    800059cc:	00913423          	sd	s1,8(sp)
    800059d0:	02010413          	addi	s0,sp,32
        if (!head) { return 0; }
    800059d4:	00853503          	ld	a0,8(a0)
    800059d8:	04050863          	beqz	a0,80005a28 <_ZN3Sem6signalEv+0x90>
        head = head->next;
    800059dc:	00853703          	ld	a4,8(a0)
    800059e0:	00e7b423          	sd	a4,8(a5)
        if (!head) { tail = 0; }
    800059e4:	02070e63          	beqz	a4,80005a20 <_ZN3Sem6signalEv+0x88>
        T *ret = elem->data;
    800059e8:	00053483          	ld	s1,0(a0)
        delete elem;
    800059ec:	fffff097          	auipc	ra,0xfffff
    800059f0:	55c080e7          	jalr	1372(ra) # 80004f48 <_ZdlPv>
        pcb->state = PCB::READY;
    800059f4:	00100793          	li	a5,1
    800059f8:	02f4a423          	sw	a5,40(s1)
        Scheduler::put(pcb);
    800059fc:	00048513          	mv	a0,s1
    80005a00:	00000097          	auipc	ra,0x0
    80005a04:	0e0080e7          	jalr	224(ra) # 80005ae0 <_ZN9Scheduler3putEP3PCB>
    return 0;
    80005a08:	00000513          	li	a0,0
    80005a0c:	01813083          	ld	ra,24(sp)
    80005a10:	01013403          	ld	s0,16(sp)
    80005a14:	00813483          	ld	s1,8(sp)
    80005a18:	02010113          	addi	sp,sp,32
    80005a1c:	00008067          	ret
        if (!head) { tail = 0; }
    80005a20:	0007b823          	sd	zero,16(a5)
    80005a24:	fc5ff06f          	j	800059e8 <_ZN3Sem6signalEv+0x50>
        if (!head) { return 0; }
    80005a28:	00050493          	mv	s1,a0
    80005a2c:	fc9ff06f          	j	800059f4 <_ZN3Sem6signalEv+0x5c>
    if(finished) return -1;
    80005a30:	fff00513          	li	a0,-1
    80005a34:	00008067          	ret

0000000080005a38 <_Z41__static_initialization_and_destruction_0ii>:
}

void Scheduler::put(PCB *pcb)
{
    readyCoroutineQueue.addLast(pcb);
    80005a38:	ff010113          	addi	sp,sp,-16
    80005a3c:	00813423          	sd	s0,8(sp)
    80005a40:	01010413          	addi	s0,sp,16
    80005a44:	00100793          	li	a5,1
    80005a48:	00f50863          	beq	a0,a5,80005a58 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80005a4c:	00813403          	ld	s0,8(sp)
    80005a50:	01010113          	addi	sp,sp,16
    80005a54:	00008067          	ret
    80005a58:	000107b7          	lui	a5,0x10
    80005a5c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80005a60:	fef596e3          	bne	a1,a5,80005a4c <_Z41__static_initialization_and_destruction_0ii+0x14>
    80005a64:	00006797          	auipc	a5,0x6
    80005a68:	de478793          	addi	a5,a5,-540 # 8000b848 <_ZN9Scheduler19readyCoroutineQueueE>
    80005a6c:	0007b023          	sd	zero,0(a5)
    80005a70:	0007b423          	sd	zero,8(a5)
    80005a74:	fd9ff06f          	j	80005a4c <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080005a78 <_ZN9Scheduler3getEv>:
{
    80005a78:	fe010113          	addi	sp,sp,-32
    80005a7c:	00113c23          	sd	ra,24(sp)
    80005a80:	00813823          	sd	s0,16(sp)
    80005a84:	00913423          	sd	s1,8(sp)
    80005a88:	02010413          	addi	s0,sp,32
        if (!head) { return 0; }
    80005a8c:	00006517          	auipc	a0,0x6
    80005a90:	dbc53503          	ld	a0,-580(a0) # 8000b848 <_ZN9Scheduler19readyCoroutineQueueE>
    80005a94:	04050263          	beqz	a0,80005ad8 <_ZN9Scheduler3getEv+0x60>
        head = head->next;
    80005a98:	00853783          	ld	a5,8(a0)
    80005a9c:	00006717          	auipc	a4,0x6
    80005aa0:	daf73623          	sd	a5,-596(a4) # 8000b848 <_ZN9Scheduler19readyCoroutineQueueE>
        if (!head) { tail = 0; }
    80005aa4:	02078463          	beqz	a5,80005acc <_ZN9Scheduler3getEv+0x54>
        T *ret = elem->data;
    80005aa8:	00053483          	ld	s1,0(a0)
        delete elem;
    80005aac:	fffff097          	auipc	ra,0xfffff
    80005ab0:	49c080e7          	jalr	1180(ra) # 80004f48 <_ZdlPv>
}
    80005ab4:	00048513          	mv	a0,s1
    80005ab8:	01813083          	ld	ra,24(sp)
    80005abc:	01013403          	ld	s0,16(sp)
    80005ac0:	00813483          	ld	s1,8(sp)
    80005ac4:	02010113          	addi	sp,sp,32
    80005ac8:	00008067          	ret
        if (!head) { tail = 0; }
    80005acc:	00006797          	auipc	a5,0x6
    80005ad0:	d807b223          	sd	zero,-636(a5) # 8000b850 <_ZN9Scheduler19readyCoroutineQueueE+0x8>
    80005ad4:	fd5ff06f          	j	80005aa8 <_ZN9Scheduler3getEv+0x30>
        if (!head) { return 0; }
    80005ad8:	00050493          	mv	s1,a0
    return readyCoroutineQueue.removeFirst();
    80005adc:	fd9ff06f          	j	80005ab4 <_ZN9Scheduler3getEv+0x3c>

0000000080005ae0 <_ZN9Scheduler3putEP3PCB>:
{
    80005ae0:	fe010113          	addi	sp,sp,-32
    80005ae4:	00113c23          	sd	ra,24(sp)
    80005ae8:	00813823          	sd	s0,16(sp)
    80005aec:	00913423          	sd	s1,8(sp)
    80005af0:	02010413          	addi	s0,sp,32
    80005af4:	00050493          	mv	s1,a0
        Elem *elem = new Elem(data, 0);
    80005af8:	01000513          	li	a0,16
    80005afc:	fffff097          	auipc	ra,0xfffff
    80005b00:	3cc080e7          	jalr	972(ra) # 80004ec8 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80005b04:	00953023          	sd	s1,0(a0)
    80005b08:	00053423          	sd	zero,8(a0)
        if (tail)
    80005b0c:	00006797          	auipc	a5,0x6
    80005b10:	d447b783          	ld	a5,-700(a5) # 8000b850 <_ZN9Scheduler19readyCoroutineQueueE+0x8>
    80005b14:	02078263          	beqz	a5,80005b38 <_ZN9Scheduler3putEP3PCB+0x58>
            tail->next = elem;
    80005b18:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80005b1c:	00006797          	auipc	a5,0x6
    80005b20:	d2a7ba23          	sd	a0,-716(a5) # 8000b850 <_ZN9Scheduler19readyCoroutineQueueE+0x8>
    80005b24:	01813083          	ld	ra,24(sp)
    80005b28:	01013403          	ld	s0,16(sp)
    80005b2c:	00813483          	ld	s1,8(sp)
    80005b30:	02010113          	addi	sp,sp,32
    80005b34:	00008067          	ret
            head = tail = elem;
    80005b38:	00006797          	auipc	a5,0x6
    80005b3c:	d1078793          	addi	a5,a5,-752 # 8000b848 <_ZN9Scheduler19readyCoroutineQueueE>
    80005b40:	00a7b423          	sd	a0,8(a5)
    80005b44:	00a7b023          	sd	a0,0(a5)
    80005b48:	fddff06f          	j	80005b24 <_ZN9Scheduler3putEP3PCB+0x44>

0000000080005b4c <_GLOBAL__sub_I__ZN9Scheduler19readyCoroutineQueueE>:
    80005b4c:	ff010113          	addi	sp,sp,-16
    80005b50:	00113423          	sd	ra,8(sp)
    80005b54:	00813023          	sd	s0,0(sp)
    80005b58:	01010413          	addi	s0,sp,16
    80005b5c:	000105b7          	lui	a1,0x10
    80005b60:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80005b64:	00100513          	li	a0,1
    80005b68:	00000097          	auipc	ra,0x0
    80005b6c:	ed0080e7          	jalr	-304(ra) # 80005a38 <_Z41__static_initialization_and_destruction_0ii>
    80005b70:	00813083          	ld	ra,8(sp)
    80005b74:	00013403          	ld	s0,0(sp)
    80005b78:	01010113          	addi	sp,sp,16
    80005b7c:	00008067          	ret

0000000080005b80 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80005b80:	fe010113          	addi	sp,sp,-32
    80005b84:	00113c23          	sd	ra,24(sp)
    80005b88:	00813823          	sd	s0,16(sp)
    80005b8c:	00913423          	sd	s1,8(sp)
    80005b90:	01213023          	sd	s2,0(sp)
    80005b94:	02010413          	addi	s0,sp,32
    80005b98:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80005b9c:	00100793          	li	a5,1
    80005ba0:	02a7f863          	bgeu	a5,a0,80005bd0 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80005ba4:	00a00793          	li	a5,10
    80005ba8:	02f577b3          	remu	a5,a0,a5
    80005bac:	02078e63          	beqz	a5,80005be8 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80005bb0:	fff48513          	addi	a0,s1,-1
    80005bb4:	00000097          	auipc	ra,0x0
    80005bb8:	fcc080e7          	jalr	-52(ra) # 80005b80 <_ZL9fibonaccim>
    80005bbc:	00050913          	mv	s2,a0
    80005bc0:	ffe48513          	addi	a0,s1,-2
    80005bc4:	00000097          	auipc	ra,0x0
    80005bc8:	fbc080e7          	jalr	-68(ra) # 80005b80 <_ZL9fibonaccim>
    80005bcc:	00a90533          	add	a0,s2,a0
}
    80005bd0:	01813083          	ld	ra,24(sp)
    80005bd4:	01013403          	ld	s0,16(sp)
    80005bd8:	00813483          	ld	s1,8(sp)
    80005bdc:	00013903          	ld	s2,0(sp)
    80005be0:	02010113          	addi	sp,sp,32
    80005be4:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80005be8:	ffffc097          	auipc	ra,0xffffc
    80005bec:	97c080e7          	jalr	-1668(ra) # 80001564 <_Z15thread_dispatchv>
    80005bf0:	fc1ff06f          	j	80005bb0 <_ZL9fibonaccim+0x30>

0000000080005bf4 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80005bf4:	fe010113          	addi	sp,sp,-32
    80005bf8:	00113c23          	sd	ra,24(sp)
    80005bfc:	00813823          	sd	s0,16(sp)
    80005c00:	00913423          	sd	s1,8(sp)
    80005c04:	01213023          	sd	s2,0(sp)
    80005c08:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80005c0c:	00a00493          	li	s1,10
    80005c10:	0400006f          	j	80005c50 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005c14:	00003517          	auipc	a0,0x3
    80005c18:	54c50513          	addi	a0,a0,1356 # 80009160 <CONSOLE_STATUS+0x150>
    80005c1c:	ffffe097          	auipc	ra,0xffffe
    80005c20:	3f0080e7          	jalr	1008(ra) # 8000400c <_Z11printStringPKc>
    80005c24:	00000613          	li	a2,0
    80005c28:	00a00593          	li	a1,10
    80005c2c:	00048513          	mv	a0,s1
    80005c30:	ffffe097          	auipc	ra,0xffffe
    80005c34:	58c080e7          	jalr	1420(ra) # 800041bc <_Z8printIntiii>
    80005c38:	00003517          	auipc	a0,0x3
    80005c3c:	62050513          	addi	a0,a0,1568 # 80009258 <CONSOLE_STATUS+0x248>
    80005c40:	ffffe097          	auipc	ra,0xffffe
    80005c44:	3cc080e7          	jalr	972(ra) # 8000400c <_Z11printStringPKc>
    for (; i < 13; i++) {
    80005c48:	0014849b          	addiw	s1,s1,1
    80005c4c:	0ff4f493          	andi	s1,s1,255
    80005c50:	00c00793          	li	a5,12
    80005c54:	fc97f0e3          	bgeu	a5,s1,80005c14 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80005c58:	00003517          	auipc	a0,0x3
    80005c5c:	51050513          	addi	a0,a0,1296 # 80009168 <CONSOLE_STATUS+0x158>
    80005c60:	ffffe097          	auipc	ra,0xffffe
    80005c64:	3ac080e7          	jalr	940(ra) # 8000400c <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80005c68:	00500313          	li	t1,5
    thread_dispatch();
    80005c6c:	ffffc097          	auipc	ra,0xffffc
    80005c70:	8f8080e7          	jalr	-1800(ra) # 80001564 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80005c74:	01000513          	li	a0,16
    80005c78:	00000097          	auipc	ra,0x0
    80005c7c:	f08080e7          	jalr	-248(ra) # 80005b80 <_ZL9fibonaccim>
    80005c80:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80005c84:	00003517          	auipc	a0,0x3
    80005c88:	4f450513          	addi	a0,a0,1268 # 80009178 <CONSOLE_STATUS+0x168>
    80005c8c:	ffffe097          	auipc	ra,0xffffe
    80005c90:	380080e7          	jalr	896(ra) # 8000400c <_Z11printStringPKc>
    80005c94:	00000613          	li	a2,0
    80005c98:	00a00593          	li	a1,10
    80005c9c:	0009051b          	sext.w	a0,s2
    80005ca0:	ffffe097          	auipc	ra,0xffffe
    80005ca4:	51c080e7          	jalr	1308(ra) # 800041bc <_Z8printIntiii>
    80005ca8:	00003517          	auipc	a0,0x3
    80005cac:	5b050513          	addi	a0,a0,1456 # 80009258 <CONSOLE_STATUS+0x248>
    80005cb0:	ffffe097          	auipc	ra,0xffffe
    80005cb4:	35c080e7          	jalr	860(ra) # 8000400c <_Z11printStringPKc>
    80005cb8:	0400006f          	j	80005cf8 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005cbc:	00003517          	auipc	a0,0x3
    80005cc0:	4a450513          	addi	a0,a0,1188 # 80009160 <CONSOLE_STATUS+0x150>
    80005cc4:	ffffe097          	auipc	ra,0xffffe
    80005cc8:	348080e7          	jalr	840(ra) # 8000400c <_Z11printStringPKc>
    80005ccc:	00000613          	li	a2,0
    80005cd0:	00a00593          	li	a1,10
    80005cd4:	00048513          	mv	a0,s1
    80005cd8:	ffffe097          	auipc	ra,0xffffe
    80005cdc:	4e4080e7          	jalr	1252(ra) # 800041bc <_Z8printIntiii>
    80005ce0:	00003517          	auipc	a0,0x3
    80005ce4:	57850513          	addi	a0,a0,1400 # 80009258 <CONSOLE_STATUS+0x248>
    80005ce8:	ffffe097          	auipc	ra,0xffffe
    80005cec:	324080e7          	jalr	804(ra) # 8000400c <_Z11printStringPKc>
    for (; i < 16; i++) {
    80005cf0:	0014849b          	addiw	s1,s1,1
    80005cf4:	0ff4f493          	andi	s1,s1,255
    80005cf8:	00f00793          	li	a5,15
    80005cfc:	fc97f0e3          	bgeu	a5,s1,80005cbc <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80005d00:	00003517          	auipc	a0,0x3
    80005d04:	48850513          	addi	a0,a0,1160 # 80009188 <CONSOLE_STATUS+0x178>
    80005d08:	ffffe097          	auipc	ra,0xffffe
    80005d0c:	304080e7          	jalr	772(ra) # 8000400c <_Z11printStringPKc>
    finishedD = true;
    80005d10:	00100793          	li	a5,1
    80005d14:	00006717          	auipc	a4,0x6
    80005d18:	b4f70223          	sb	a5,-1212(a4) # 8000b858 <_ZL9finishedD>
    thread_dispatch();
    80005d1c:	ffffc097          	auipc	ra,0xffffc
    80005d20:	848080e7          	jalr	-1976(ra) # 80001564 <_Z15thread_dispatchv>
}
    80005d24:	01813083          	ld	ra,24(sp)
    80005d28:	01013403          	ld	s0,16(sp)
    80005d2c:	00813483          	ld	s1,8(sp)
    80005d30:	00013903          	ld	s2,0(sp)
    80005d34:	02010113          	addi	sp,sp,32
    80005d38:	00008067          	ret

0000000080005d3c <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80005d3c:	fe010113          	addi	sp,sp,-32
    80005d40:	00113c23          	sd	ra,24(sp)
    80005d44:	00813823          	sd	s0,16(sp)
    80005d48:	00913423          	sd	s1,8(sp)
    80005d4c:	01213023          	sd	s2,0(sp)
    80005d50:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80005d54:	00000493          	li	s1,0
    80005d58:	0400006f          	j	80005d98 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80005d5c:	00003517          	auipc	a0,0x3
    80005d60:	3d450513          	addi	a0,a0,980 # 80009130 <CONSOLE_STATUS+0x120>
    80005d64:	ffffe097          	auipc	ra,0xffffe
    80005d68:	2a8080e7          	jalr	680(ra) # 8000400c <_Z11printStringPKc>
    80005d6c:	00000613          	li	a2,0
    80005d70:	00a00593          	li	a1,10
    80005d74:	00048513          	mv	a0,s1
    80005d78:	ffffe097          	auipc	ra,0xffffe
    80005d7c:	444080e7          	jalr	1092(ra) # 800041bc <_Z8printIntiii>
    80005d80:	00003517          	auipc	a0,0x3
    80005d84:	4d850513          	addi	a0,a0,1240 # 80009258 <CONSOLE_STATUS+0x248>
    80005d88:	ffffe097          	auipc	ra,0xffffe
    80005d8c:	284080e7          	jalr	644(ra) # 8000400c <_Z11printStringPKc>
    for (; i < 3; i++) {
    80005d90:	0014849b          	addiw	s1,s1,1
    80005d94:	0ff4f493          	andi	s1,s1,255
    80005d98:	00200793          	li	a5,2
    80005d9c:	fc97f0e3          	bgeu	a5,s1,80005d5c <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80005da0:	00003517          	auipc	a0,0x3
    80005da4:	39850513          	addi	a0,a0,920 # 80009138 <CONSOLE_STATUS+0x128>
    80005da8:	ffffe097          	auipc	ra,0xffffe
    80005dac:	264080e7          	jalr	612(ra) # 8000400c <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80005db0:	00700313          	li	t1,7
    thread_dispatch();
    80005db4:	ffffb097          	auipc	ra,0xffffb
    80005db8:	7b0080e7          	jalr	1968(ra) # 80001564 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80005dbc:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80005dc0:	00003517          	auipc	a0,0x3
    80005dc4:	38850513          	addi	a0,a0,904 # 80009148 <CONSOLE_STATUS+0x138>
    80005dc8:	ffffe097          	auipc	ra,0xffffe
    80005dcc:	244080e7          	jalr	580(ra) # 8000400c <_Z11printStringPKc>
    80005dd0:	00000613          	li	a2,0
    80005dd4:	00a00593          	li	a1,10
    80005dd8:	0009051b          	sext.w	a0,s2
    80005ddc:	ffffe097          	auipc	ra,0xffffe
    80005de0:	3e0080e7          	jalr	992(ra) # 800041bc <_Z8printIntiii>
    80005de4:	00003517          	auipc	a0,0x3
    80005de8:	47450513          	addi	a0,a0,1140 # 80009258 <CONSOLE_STATUS+0x248>
    80005dec:	ffffe097          	auipc	ra,0xffffe
    80005df0:	220080e7          	jalr	544(ra) # 8000400c <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80005df4:	00c00513          	li	a0,12
    80005df8:	00000097          	auipc	ra,0x0
    80005dfc:	d88080e7          	jalr	-632(ra) # 80005b80 <_ZL9fibonaccim>
    80005e00:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80005e04:	00003517          	auipc	a0,0x3
    80005e08:	34c50513          	addi	a0,a0,844 # 80009150 <CONSOLE_STATUS+0x140>
    80005e0c:	ffffe097          	auipc	ra,0xffffe
    80005e10:	200080e7          	jalr	512(ra) # 8000400c <_Z11printStringPKc>
    80005e14:	00000613          	li	a2,0
    80005e18:	00a00593          	li	a1,10
    80005e1c:	0009051b          	sext.w	a0,s2
    80005e20:	ffffe097          	auipc	ra,0xffffe
    80005e24:	39c080e7          	jalr	924(ra) # 800041bc <_Z8printIntiii>
    80005e28:	00003517          	auipc	a0,0x3
    80005e2c:	43050513          	addi	a0,a0,1072 # 80009258 <CONSOLE_STATUS+0x248>
    80005e30:	ffffe097          	auipc	ra,0xffffe
    80005e34:	1dc080e7          	jalr	476(ra) # 8000400c <_Z11printStringPKc>
    80005e38:	0400006f          	j	80005e78 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80005e3c:	00003517          	auipc	a0,0x3
    80005e40:	2f450513          	addi	a0,a0,756 # 80009130 <CONSOLE_STATUS+0x120>
    80005e44:	ffffe097          	auipc	ra,0xffffe
    80005e48:	1c8080e7          	jalr	456(ra) # 8000400c <_Z11printStringPKc>
    80005e4c:	00000613          	li	a2,0
    80005e50:	00a00593          	li	a1,10
    80005e54:	00048513          	mv	a0,s1
    80005e58:	ffffe097          	auipc	ra,0xffffe
    80005e5c:	364080e7          	jalr	868(ra) # 800041bc <_Z8printIntiii>
    80005e60:	00003517          	auipc	a0,0x3
    80005e64:	3f850513          	addi	a0,a0,1016 # 80009258 <CONSOLE_STATUS+0x248>
    80005e68:	ffffe097          	auipc	ra,0xffffe
    80005e6c:	1a4080e7          	jalr	420(ra) # 8000400c <_Z11printStringPKc>
    for (; i < 6; i++) {
    80005e70:	0014849b          	addiw	s1,s1,1
    80005e74:	0ff4f493          	andi	s1,s1,255
    80005e78:	00500793          	li	a5,5
    80005e7c:	fc97f0e3          	bgeu	a5,s1,80005e3c <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80005e80:	00003517          	auipc	a0,0x3
    80005e84:	28850513          	addi	a0,a0,648 # 80009108 <CONSOLE_STATUS+0xf8>
    80005e88:	ffffe097          	auipc	ra,0xffffe
    80005e8c:	184080e7          	jalr	388(ra) # 8000400c <_Z11printStringPKc>
    finishedC = true;
    80005e90:	00100793          	li	a5,1
    80005e94:	00006717          	auipc	a4,0x6
    80005e98:	9cf702a3          	sb	a5,-1595(a4) # 8000b859 <_ZL9finishedC>
    thread_dispatch();
    80005e9c:	ffffb097          	auipc	ra,0xffffb
    80005ea0:	6c8080e7          	jalr	1736(ra) # 80001564 <_Z15thread_dispatchv>
}
    80005ea4:	01813083          	ld	ra,24(sp)
    80005ea8:	01013403          	ld	s0,16(sp)
    80005eac:	00813483          	ld	s1,8(sp)
    80005eb0:	00013903          	ld	s2,0(sp)
    80005eb4:	02010113          	addi	sp,sp,32
    80005eb8:	00008067          	ret

0000000080005ebc <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80005ebc:	fe010113          	addi	sp,sp,-32
    80005ec0:	00113c23          	sd	ra,24(sp)
    80005ec4:	00813823          	sd	s0,16(sp)
    80005ec8:	00913423          	sd	s1,8(sp)
    80005ecc:	01213023          	sd	s2,0(sp)
    80005ed0:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80005ed4:	00000913          	li	s2,0
    80005ed8:	0400006f          	j	80005f18 <_ZL11workerBodyBPv+0x5c>
            thread_dispatch();
    80005edc:	ffffb097          	auipc	ra,0xffffb
    80005ee0:	688080e7          	jalr	1672(ra) # 80001564 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005ee4:	00148493          	addi	s1,s1,1
    80005ee8:	000027b7          	lui	a5,0x2
    80005eec:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005ef0:	0097ee63          	bltu	a5,s1,80005f0c <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005ef4:	00000713          	li	a4,0
    80005ef8:	000077b7          	lui	a5,0x7
    80005efc:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005f00:	fce7eee3          	bltu	a5,a4,80005edc <_ZL11workerBodyBPv+0x20>
    80005f04:	00170713          	addi	a4,a4,1
    80005f08:	ff1ff06f          	j	80005ef8 <_ZL11workerBodyBPv+0x3c>
        if (i == 10) {
    80005f0c:	00a00793          	li	a5,10
    80005f10:	04f90663          	beq	s2,a5,80005f5c <_ZL11workerBodyBPv+0xa0>
    for (uint64 i = 0; i < 16; i++) {
    80005f14:	00190913          	addi	s2,s2,1
    80005f18:	00f00793          	li	a5,15
    80005f1c:	0527e463          	bltu	a5,s2,80005f64 <_ZL11workerBodyBPv+0xa8>
        printString("B: i="); printInt(i); printString("\n");
    80005f20:	00003517          	auipc	a0,0x3
    80005f24:	1f850513          	addi	a0,a0,504 # 80009118 <CONSOLE_STATUS+0x108>
    80005f28:	ffffe097          	auipc	ra,0xffffe
    80005f2c:	0e4080e7          	jalr	228(ra) # 8000400c <_Z11printStringPKc>
    80005f30:	00000613          	li	a2,0
    80005f34:	00a00593          	li	a1,10
    80005f38:	0009051b          	sext.w	a0,s2
    80005f3c:	ffffe097          	auipc	ra,0xffffe
    80005f40:	280080e7          	jalr	640(ra) # 800041bc <_Z8printIntiii>
    80005f44:	00003517          	auipc	a0,0x3
    80005f48:	31450513          	addi	a0,a0,788 # 80009258 <CONSOLE_STATUS+0x248>
    80005f4c:	ffffe097          	auipc	ra,0xffffe
    80005f50:	0c0080e7          	jalr	192(ra) # 8000400c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005f54:	00000493          	li	s1,0
    80005f58:	f91ff06f          	j	80005ee8 <_ZL11workerBodyBPv+0x2c>
            asm volatile("csrr t6, sepc");
    80005f5c:	14102ff3          	csrr	t6,sepc
    80005f60:	fb5ff06f          	j	80005f14 <_ZL11workerBodyBPv+0x58>
    printString("B finished!\n");
    80005f64:	00003517          	auipc	a0,0x3
    80005f68:	1bc50513          	addi	a0,a0,444 # 80009120 <CONSOLE_STATUS+0x110>
    80005f6c:	ffffe097          	auipc	ra,0xffffe
    80005f70:	0a0080e7          	jalr	160(ra) # 8000400c <_Z11printStringPKc>
    finishedB = true;
    80005f74:	00100793          	li	a5,1
    80005f78:	00006717          	auipc	a4,0x6
    80005f7c:	8ef70123          	sb	a5,-1822(a4) # 8000b85a <_ZL9finishedB>
    thread_dispatch();
    80005f80:	ffffb097          	auipc	ra,0xffffb
    80005f84:	5e4080e7          	jalr	1508(ra) # 80001564 <_Z15thread_dispatchv>
}
    80005f88:	01813083          	ld	ra,24(sp)
    80005f8c:	01013403          	ld	s0,16(sp)
    80005f90:	00813483          	ld	s1,8(sp)
    80005f94:	00013903          	ld	s2,0(sp)
    80005f98:	02010113          	addi	sp,sp,32
    80005f9c:	00008067          	ret

0000000080005fa0 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80005fa0:	fe010113          	addi	sp,sp,-32
    80005fa4:	00113c23          	sd	ra,24(sp)
    80005fa8:	00813823          	sd	s0,16(sp)
    80005fac:	00913423          	sd	s1,8(sp)
    80005fb0:	01213023          	sd	s2,0(sp)
    80005fb4:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80005fb8:	00000913          	li	s2,0
    80005fbc:	0380006f          	j	80005ff4 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80005fc0:	ffffb097          	auipc	ra,0xffffb
    80005fc4:	5a4080e7          	jalr	1444(ra) # 80001564 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005fc8:	00148493          	addi	s1,s1,1
    80005fcc:	000027b7          	lui	a5,0x2
    80005fd0:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005fd4:	0097ee63          	bltu	a5,s1,80005ff0 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005fd8:	00000713          	li	a4,0
    80005fdc:	000077b7          	lui	a5,0x7
    80005fe0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005fe4:	fce7eee3          	bltu	a5,a4,80005fc0 <_ZL11workerBodyAPv+0x20>
    80005fe8:	00170713          	addi	a4,a4,1
    80005fec:	ff1ff06f          	j	80005fdc <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80005ff0:	00190913          	addi	s2,s2,1
    80005ff4:	00900793          	li	a5,9
    80005ff8:	0527e063          	bltu	a5,s2,80006038 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80005ffc:	00003517          	auipc	a0,0x3
    80006000:	10450513          	addi	a0,a0,260 # 80009100 <CONSOLE_STATUS+0xf0>
    80006004:	ffffe097          	auipc	ra,0xffffe
    80006008:	008080e7          	jalr	8(ra) # 8000400c <_Z11printStringPKc>
    8000600c:	00000613          	li	a2,0
    80006010:	00a00593          	li	a1,10
    80006014:	0009051b          	sext.w	a0,s2
    80006018:	ffffe097          	auipc	ra,0xffffe
    8000601c:	1a4080e7          	jalr	420(ra) # 800041bc <_Z8printIntiii>
    80006020:	00003517          	auipc	a0,0x3
    80006024:	23850513          	addi	a0,a0,568 # 80009258 <CONSOLE_STATUS+0x248>
    80006028:	ffffe097          	auipc	ra,0xffffe
    8000602c:	fe4080e7          	jalr	-28(ra) # 8000400c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80006030:	00000493          	li	s1,0
    80006034:	f99ff06f          	j	80005fcc <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80006038:	00003517          	auipc	a0,0x3
    8000603c:	0d050513          	addi	a0,a0,208 # 80009108 <CONSOLE_STATUS+0xf8>
    80006040:	ffffe097          	auipc	ra,0xffffe
    80006044:	fcc080e7          	jalr	-52(ra) # 8000400c <_Z11printStringPKc>
    finishedA = true;
    80006048:	00100793          	li	a5,1
    8000604c:	00006717          	auipc	a4,0x6
    80006050:	80f707a3          	sb	a5,-2033(a4) # 8000b85b <_ZL9finishedA>
}
    80006054:	01813083          	ld	ra,24(sp)
    80006058:	01013403          	ld	s0,16(sp)
    8000605c:	00813483          	ld	s1,8(sp)
    80006060:	00013903          	ld	s2,0(sp)
    80006064:	02010113          	addi	sp,sp,32
    80006068:	00008067          	ret

000000008000606c <_Z16System_Mode_testv>:


void System_Mode_test() {
    8000606c:	fd010113          	addi	sp,sp,-48
    80006070:	02113423          	sd	ra,40(sp)
    80006074:	02813023          	sd	s0,32(sp)
    80006078:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    8000607c:	00000613          	li	a2,0
    80006080:	00000597          	auipc	a1,0x0
    80006084:	f2058593          	addi	a1,a1,-224 # 80005fa0 <_ZL11workerBodyAPv>
    80006088:	fd040513          	addi	a0,s0,-48
    8000608c:	ffffb097          	auipc	ra,0xffffb
    80006090:	37c080e7          	jalr	892(ra) # 80001408 <_Z13thread_createPP3PCBPFvPvES2_>
    printString("ThreadA created\n");
    80006094:	00003517          	auipc	a0,0x3
    80006098:	10450513          	addi	a0,a0,260 # 80009198 <CONSOLE_STATUS+0x188>
    8000609c:	ffffe097          	auipc	ra,0xffffe
    800060a0:	f70080e7          	jalr	-144(ra) # 8000400c <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    800060a4:	00000613          	li	a2,0
    800060a8:	00000597          	auipc	a1,0x0
    800060ac:	e1458593          	addi	a1,a1,-492 # 80005ebc <_ZL11workerBodyBPv>
    800060b0:	fd840513          	addi	a0,s0,-40
    800060b4:	ffffb097          	auipc	ra,0xffffb
    800060b8:	354080e7          	jalr	852(ra) # 80001408 <_Z13thread_createPP3PCBPFvPvES2_>
    printString("ThreadB created\n");
    800060bc:	00003517          	auipc	a0,0x3
    800060c0:	0f450513          	addi	a0,a0,244 # 800091b0 <CONSOLE_STATUS+0x1a0>
    800060c4:	ffffe097          	auipc	ra,0xffffe
    800060c8:	f48080e7          	jalr	-184(ra) # 8000400c <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    800060cc:	00000613          	li	a2,0
    800060d0:	00000597          	auipc	a1,0x0
    800060d4:	c6c58593          	addi	a1,a1,-916 # 80005d3c <_ZL11workerBodyCPv>
    800060d8:	fe040513          	addi	a0,s0,-32
    800060dc:	ffffb097          	auipc	ra,0xffffb
    800060e0:	32c080e7          	jalr	812(ra) # 80001408 <_Z13thread_createPP3PCBPFvPvES2_>
    printString("ThreadC created\n");
    800060e4:	00003517          	auipc	a0,0x3
    800060e8:	0e450513          	addi	a0,a0,228 # 800091c8 <CONSOLE_STATUS+0x1b8>
    800060ec:	ffffe097          	auipc	ra,0xffffe
    800060f0:	f20080e7          	jalr	-224(ra) # 8000400c <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    800060f4:	00000613          	li	a2,0
    800060f8:	00000597          	auipc	a1,0x0
    800060fc:	afc58593          	addi	a1,a1,-1284 # 80005bf4 <_ZL11workerBodyDPv>
    80006100:	fe840513          	addi	a0,s0,-24
    80006104:	ffffb097          	auipc	ra,0xffffb
    80006108:	304080e7          	jalr	772(ra) # 80001408 <_Z13thread_createPP3PCBPFvPvES2_>
    printString("ThreadD created\n");
    8000610c:	00003517          	auipc	a0,0x3
    80006110:	0d450513          	addi	a0,a0,212 # 800091e0 <CONSOLE_STATUS+0x1d0>
    80006114:	ffffe097          	auipc	ra,0xffffe
    80006118:	ef8080e7          	jalr	-264(ra) # 8000400c <_Z11printStringPKc>
    8000611c:	00c0006f          	j	80006128 <_Z16System_Mode_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80006120:	ffffb097          	auipc	ra,0xffffb
    80006124:	444080e7          	jalr	1092(ra) # 80001564 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80006128:	00005797          	auipc	a5,0x5
    8000612c:	7337c783          	lbu	a5,1843(a5) # 8000b85b <_ZL9finishedA>
    80006130:	fe0788e3          	beqz	a5,80006120 <_Z16System_Mode_testv+0xb4>
    80006134:	00005797          	auipc	a5,0x5
    80006138:	7267c783          	lbu	a5,1830(a5) # 8000b85a <_ZL9finishedB>
    8000613c:	fe0782e3          	beqz	a5,80006120 <_Z16System_Mode_testv+0xb4>
    80006140:	00005797          	auipc	a5,0x5
    80006144:	7197c783          	lbu	a5,1817(a5) # 8000b859 <_ZL9finishedC>
    80006148:	fc078ce3          	beqz	a5,80006120 <_Z16System_Mode_testv+0xb4>
    8000614c:	00005797          	auipc	a5,0x5
    80006150:	70c7c783          	lbu	a5,1804(a5) # 8000b858 <_ZL9finishedD>
    80006154:	fc0786e3          	beqz	a5,80006120 <_Z16System_Mode_testv+0xb4>
    }

}
    80006158:	02813083          	ld	ra,40(sp)
    8000615c:	02013403          	ld	s0,32(sp)
    80006160:	03010113          	addi	sp,sp,48
    80006164:	00008067          	ret

0000000080006168 <_ZN6BufferC1Ei>:
#include "../h/buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80006168:	fe010113          	addi	sp,sp,-32
    8000616c:	00113c23          	sd	ra,24(sp)
    80006170:	00813823          	sd	s0,16(sp)
    80006174:	00913423          	sd	s1,8(sp)
    80006178:	01213023          	sd	s2,0(sp)
    8000617c:	02010413          	addi	s0,sp,32
    80006180:	00050493          	mv	s1,a0
    80006184:	00058913          	mv	s2,a1
    80006188:	0015879b          	addiw	a5,a1,1
    8000618c:	0007851b          	sext.w	a0,a5
    80006190:	00f4a023          	sw	a5,0(s1)
    80006194:	0004a823          	sw	zero,16(s1)
    80006198:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    8000619c:	00251513          	slli	a0,a0,0x2
    800061a0:	ffffb097          	auipc	ra,0xffffb
    800061a4:	1fc080e7          	jalr	508(ra) # 8000139c <_Z9mem_allocm>
    800061a8:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    800061ac:	00000593          	li	a1,0
    800061b0:	02048513          	addi	a0,s1,32
    800061b4:	ffffb097          	auipc	ra,0xffffb
    800061b8:	490080e7          	jalr	1168(ra) # 80001644 <_Z8sem_openPP3Semj>
    sem_open(&spaceAvailable, _cap);
    800061bc:	00090593          	mv	a1,s2
    800061c0:	01848513          	addi	a0,s1,24
    800061c4:	ffffb097          	auipc	ra,0xffffb
    800061c8:	480080e7          	jalr	1152(ra) # 80001644 <_Z8sem_openPP3Semj>
    sem_open(&mutexHead, 1);
    800061cc:	00100593          	li	a1,1
    800061d0:	02848513          	addi	a0,s1,40
    800061d4:	ffffb097          	auipc	ra,0xffffb
    800061d8:	470080e7          	jalr	1136(ra) # 80001644 <_Z8sem_openPP3Semj>
    sem_open(&mutexTail, 1);
    800061dc:	00100593          	li	a1,1
    800061e0:	03048513          	addi	a0,s1,48
    800061e4:	ffffb097          	auipc	ra,0xffffb
    800061e8:	460080e7          	jalr	1120(ra) # 80001644 <_Z8sem_openPP3Semj>
}
    800061ec:	01813083          	ld	ra,24(sp)
    800061f0:	01013403          	ld	s0,16(sp)
    800061f4:	00813483          	ld	s1,8(sp)
    800061f8:	00013903          	ld	s2,0(sp)
    800061fc:	02010113          	addi	sp,sp,32
    80006200:	00008067          	ret

0000000080006204 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80006204:	fe010113          	addi	sp,sp,-32
    80006208:	00113c23          	sd	ra,24(sp)
    8000620c:	00813823          	sd	s0,16(sp)
    80006210:	00913423          	sd	s1,8(sp)
    80006214:	01213023          	sd	s2,0(sp)
    80006218:	02010413          	addi	s0,sp,32
    8000621c:	00050493          	mv	s1,a0
    80006220:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80006224:	01853503          	ld	a0,24(a0)
    80006228:	ffffb097          	auipc	ra,0xffffb
    8000622c:	498080e7          	jalr	1176(ra) # 800016c0 <_Z8sem_waitP3Sem>

    sem_wait(mutexTail);
    80006230:	0304b503          	ld	a0,48(s1)
    80006234:	ffffb097          	auipc	ra,0xffffb
    80006238:	48c080e7          	jalr	1164(ra) # 800016c0 <_Z8sem_waitP3Sem>
    buffer[tail] = val;
    8000623c:	0084b783          	ld	a5,8(s1)
    80006240:	0144a703          	lw	a4,20(s1)
    80006244:	00271713          	slli	a4,a4,0x2
    80006248:	00e787b3          	add	a5,a5,a4
    8000624c:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80006250:	0144a783          	lw	a5,20(s1)
    80006254:	0017879b          	addiw	a5,a5,1
    80006258:	0004a703          	lw	a4,0(s1)
    8000625c:	02e7e7bb          	remw	a5,a5,a4
    80006260:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80006264:	0304b503          	ld	a0,48(s1)
    80006268:	ffffb097          	auipc	ra,0xffffb
    8000626c:	490080e7          	jalr	1168(ra) # 800016f8 <_Z10sem_signalP3Sem>

    sem_signal(itemAvailable);
    80006270:	0204b503          	ld	a0,32(s1)
    80006274:	ffffb097          	auipc	ra,0xffffb
    80006278:	484080e7          	jalr	1156(ra) # 800016f8 <_Z10sem_signalP3Sem>

}
    8000627c:	01813083          	ld	ra,24(sp)
    80006280:	01013403          	ld	s0,16(sp)
    80006284:	00813483          	ld	s1,8(sp)
    80006288:	00013903          	ld	s2,0(sp)
    8000628c:	02010113          	addi	sp,sp,32
    80006290:	00008067          	ret

0000000080006294 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80006294:	fe010113          	addi	sp,sp,-32
    80006298:	00113c23          	sd	ra,24(sp)
    8000629c:	00813823          	sd	s0,16(sp)
    800062a0:	00913423          	sd	s1,8(sp)
    800062a4:	01213023          	sd	s2,0(sp)
    800062a8:	02010413          	addi	s0,sp,32
    800062ac:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    800062b0:	02053503          	ld	a0,32(a0)
    800062b4:	ffffb097          	auipc	ra,0xffffb
    800062b8:	40c080e7          	jalr	1036(ra) # 800016c0 <_Z8sem_waitP3Sem>

    sem_wait(mutexHead);
    800062bc:	0284b503          	ld	a0,40(s1)
    800062c0:	ffffb097          	auipc	ra,0xffffb
    800062c4:	400080e7          	jalr	1024(ra) # 800016c0 <_Z8sem_waitP3Sem>

    int ret = buffer[head];
    800062c8:	0084b703          	ld	a4,8(s1)
    800062cc:	0104a783          	lw	a5,16(s1)
    800062d0:	00279693          	slli	a3,a5,0x2
    800062d4:	00d70733          	add	a4,a4,a3
    800062d8:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    800062dc:	0017879b          	addiw	a5,a5,1
    800062e0:	0004a703          	lw	a4,0(s1)
    800062e4:	02e7e7bb          	remw	a5,a5,a4
    800062e8:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    800062ec:	0284b503          	ld	a0,40(s1)
    800062f0:	ffffb097          	auipc	ra,0xffffb
    800062f4:	408080e7          	jalr	1032(ra) # 800016f8 <_Z10sem_signalP3Sem>

    sem_signal(spaceAvailable);
    800062f8:	0184b503          	ld	a0,24(s1)
    800062fc:	ffffb097          	auipc	ra,0xffffb
    80006300:	3fc080e7          	jalr	1020(ra) # 800016f8 <_Z10sem_signalP3Sem>

    return ret;
}
    80006304:	00090513          	mv	a0,s2
    80006308:	01813083          	ld	ra,24(sp)
    8000630c:	01013403          	ld	s0,16(sp)
    80006310:	00813483          	ld	s1,8(sp)
    80006314:	00013903          	ld	s2,0(sp)
    80006318:	02010113          	addi	sp,sp,32
    8000631c:	00008067          	ret

0000000080006320 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80006320:	fe010113          	addi	sp,sp,-32
    80006324:	00113c23          	sd	ra,24(sp)
    80006328:	00813823          	sd	s0,16(sp)
    8000632c:	00913423          	sd	s1,8(sp)
    80006330:	01213023          	sd	s2,0(sp)
    80006334:	02010413          	addi	s0,sp,32
    80006338:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    8000633c:	02853503          	ld	a0,40(a0)
    80006340:	ffffb097          	auipc	ra,0xffffb
    80006344:	380080e7          	jalr	896(ra) # 800016c0 <_Z8sem_waitP3Sem>
    sem_wait(mutexTail);
    80006348:	0304b503          	ld	a0,48(s1)
    8000634c:	ffffb097          	auipc	ra,0xffffb
    80006350:	374080e7          	jalr	884(ra) # 800016c0 <_Z8sem_waitP3Sem>

    if (tail >= head) {
    80006354:	0144a783          	lw	a5,20(s1)
    80006358:	0104a903          	lw	s2,16(s1)
    8000635c:	0327ce63          	blt	a5,s2,80006398 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80006360:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80006364:	0304b503          	ld	a0,48(s1)
    80006368:	ffffb097          	auipc	ra,0xffffb
    8000636c:	390080e7          	jalr	912(ra) # 800016f8 <_Z10sem_signalP3Sem>
    sem_signal(mutexHead);
    80006370:	0284b503          	ld	a0,40(s1)
    80006374:	ffffb097          	auipc	ra,0xffffb
    80006378:	384080e7          	jalr	900(ra) # 800016f8 <_Z10sem_signalP3Sem>

    return ret;
}
    8000637c:	00090513          	mv	a0,s2
    80006380:	01813083          	ld	ra,24(sp)
    80006384:	01013403          	ld	s0,16(sp)
    80006388:	00813483          	ld	s1,8(sp)
    8000638c:	00013903          	ld	s2,0(sp)
    80006390:	02010113          	addi	sp,sp,32
    80006394:	00008067          	ret
        ret = cap - head + tail;
    80006398:	0004a703          	lw	a4,0(s1)
    8000639c:	4127093b          	subw	s2,a4,s2
    800063a0:	00f9093b          	addw	s2,s2,a5
    800063a4:	fc1ff06f          	j	80006364 <_ZN6Buffer6getCntEv+0x44>

00000000800063a8 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    800063a8:	fe010113          	addi	sp,sp,-32
    800063ac:	00113c23          	sd	ra,24(sp)
    800063b0:	00813823          	sd	s0,16(sp)
    800063b4:	00913423          	sd	s1,8(sp)
    800063b8:	02010413          	addi	s0,sp,32
    800063bc:	00050493          	mv	s1,a0
    putc('\n');
    800063c0:	00a00513          	li	a0,10
    800063c4:	ffffb097          	auipc	ra,0xffffb
    800063c8:	3bc080e7          	jalr	956(ra) # 80001780 <_Z4putcc>
    printString("Buffer deleted!\n");
    800063cc:	00003517          	auipc	a0,0x3
    800063d0:	e9450513          	addi	a0,a0,-364 # 80009260 <CONSOLE_STATUS+0x250>
    800063d4:	ffffe097          	auipc	ra,0xffffe
    800063d8:	c38080e7          	jalr	-968(ra) # 8000400c <_Z11printStringPKc>
    while (getCnt() > 0) {
    800063dc:	00048513          	mv	a0,s1
    800063e0:	00000097          	auipc	ra,0x0
    800063e4:	f40080e7          	jalr	-192(ra) # 80006320 <_ZN6Buffer6getCntEv>
    800063e8:	02a05c63          	blez	a0,80006420 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    800063ec:	0084b783          	ld	a5,8(s1)
    800063f0:	0104a703          	lw	a4,16(s1)
    800063f4:	00271713          	slli	a4,a4,0x2
    800063f8:	00e787b3          	add	a5,a5,a4
        putc(ch);
    800063fc:	0007c503          	lbu	a0,0(a5)
    80006400:	ffffb097          	auipc	ra,0xffffb
    80006404:	380080e7          	jalr	896(ra) # 80001780 <_Z4putcc>
        head = (head + 1) % cap;
    80006408:	0104a783          	lw	a5,16(s1)
    8000640c:	0017879b          	addiw	a5,a5,1
    80006410:	0004a703          	lw	a4,0(s1)
    80006414:	02e7e7bb          	remw	a5,a5,a4
    80006418:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    8000641c:	fc1ff06f          	j	800063dc <_ZN6BufferD1Ev+0x34>
    putc('!');
    80006420:	02100513          	li	a0,33
    80006424:	ffffb097          	auipc	ra,0xffffb
    80006428:	35c080e7          	jalr	860(ra) # 80001780 <_Z4putcc>
    putc('\n');
    8000642c:	00a00513          	li	a0,10
    80006430:	ffffb097          	auipc	ra,0xffffb
    80006434:	350080e7          	jalr	848(ra) # 80001780 <_Z4putcc>
    mem_free(buffer);
    80006438:	0084b503          	ld	a0,8(s1)
    8000643c:	ffffb097          	auipc	ra,0xffffb
    80006440:	f94080e7          	jalr	-108(ra) # 800013d0 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80006444:	0204b503          	ld	a0,32(s1)
    80006448:	ffffb097          	auipc	ra,0xffffb
    8000644c:	240080e7          	jalr	576(ra) # 80001688 <_Z9sem_closeP3Sem>
    sem_close(spaceAvailable);
    80006450:	0184b503          	ld	a0,24(s1)
    80006454:	ffffb097          	auipc	ra,0xffffb
    80006458:	234080e7          	jalr	564(ra) # 80001688 <_Z9sem_closeP3Sem>
    sem_close(mutexTail);
    8000645c:	0304b503          	ld	a0,48(s1)
    80006460:	ffffb097          	auipc	ra,0xffffb
    80006464:	228080e7          	jalr	552(ra) # 80001688 <_Z9sem_closeP3Sem>
    sem_close(mutexHead);
    80006468:	0284b503          	ld	a0,40(s1)
    8000646c:	ffffb097          	auipc	ra,0xffffb
    80006470:	21c080e7          	jalr	540(ra) # 80001688 <_Z9sem_closeP3Sem>
}
    80006474:	01813083          	ld	ra,24(sp)
    80006478:	01013403          	ld	s0,16(sp)
    8000647c:	00813483          	ld	s1,8(sp)
    80006480:	02010113          	addi	sp,sp,32
    80006484:	00008067          	ret

0000000080006488 <start>:
    80006488:	ff010113          	addi	sp,sp,-16
    8000648c:	00813423          	sd	s0,8(sp)
    80006490:	01010413          	addi	s0,sp,16
    80006494:	300027f3          	csrr	a5,mstatus
    80006498:	ffffe737          	lui	a4,0xffffe
    8000649c:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff1d3f>
    800064a0:	00e7f7b3          	and	a5,a5,a4
    800064a4:	00001737          	lui	a4,0x1
    800064a8:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800064ac:	00e7e7b3          	or	a5,a5,a4
    800064b0:	30079073          	csrw	mstatus,a5
    800064b4:	00000797          	auipc	a5,0x0
    800064b8:	16078793          	addi	a5,a5,352 # 80006614 <system_main>
    800064bc:	34179073          	csrw	mepc,a5
    800064c0:	00000793          	li	a5,0
    800064c4:	18079073          	csrw	satp,a5
    800064c8:	000107b7          	lui	a5,0x10
    800064cc:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800064d0:	30279073          	csrw	medeleg,a5
    800064d4:	30379073          	csrw	mideleg,a5
    800064d8:	104027f3          	csrr	a5,sie
    800064dc:	2227e793          	ori	a5,a5,546
    800064e0:	10479073          	csrw	sie,a5
    800064e4:	fff00793          	li	a5,-1
    800064e8:	00a7d793          	srli	a5,a5,0xa
    800064ec:	3b079073          	csrw	pmpaddr0,a5
    800064f0:	00f00793          	li	a5,15
    800064f4:	3a079073          	csrw	pmpcfg0,a5
    800064f8:	f14027f3          	csrr	a5,mhartid
    800064fc:	0200c737          	lui	a4,0x200c
    80006500:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80006504:	0007869b          	sext.w	a3,a5
    80006508:	00269713          	slli	a4,a3,0x2
    8000650c:	000f4637          	lui	a2,0xf4
    80006510:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006514:	00d70733          	add	a4,a4,a3
    80006518:	0037979b          	slliw	a5,a5,0x3
    8000651c:	020046b7          	lui	a3,0x2004
    80006520:	00d787b3          	add	a5,a5,a3
    80006524:	00c585b3          	add	a1,a1,a2
    80006528:	00371693          	slli	a3,a4,0x3
    8000652c:	00005717          	auipc	a4,0x5
    80006530:	33470713          	addi	a4,a4,820 # 8000b860 <timer_scratch>
    80006534:	00b7b023          	sd	a1,0(a5)
    80006538:	00d70733          	add	a4,a4,a3
    8000653c:	00f73c23          	sd	a5,24(a4)
    80006540:	02c73023          	sd	a2,32(a4)
    80006544:	34071073          	csrw	mscratch,a4
    80006548:	00000797          	auipc	a5,0x0
    8000654c:	6e878793          	addi	a5,a5,1768 # 80006c30 <timervec>
    80006550:	30579073          	csrw	mtvec,a5
    80006554:	300027f3          	csrr	a5,mstatus
    80006558:	0087e793          	ori	a5,a5,8
    8000655c:	30079073          	csrw	mstatus,a5
    80006560:	304027f3          	csrr	a5,mie
    80006564:	0807e793          	ori	a5,a5,128
    80006568:	30479073          	csrw	mie,a5
    8000656c:	f14027f3          	csrr	a5,mhartid
    80006570:	0007879b          	sext.w	a5,a5
    80006574:	00078213          	mv	tp,a5
    80006578:	30200073          	mret
    8000657c:	00813403          	ld	s0,8(sp)
    80006580:	01010113          	addi	sp,sp,16
    80006584:	00008067          	ret

0000000080006588 <timerinit>:
    80006588:	ff010113          	addi	sp,sp,-16
    8000658c:	00813423          	sd	s0,8(sp)
    80006590:	01010413          	addi	s0,sp,16
    80006594:	f14027f3          	csrr	a5,mhartid
    80006598:	0200c737          	lui	a4,0x200c
    8000659c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800065a0:	0007869b          	sext.w	a3,a5
    800065a4:	00269713          	slli	a4,a3,0x2
    800065a8:	000f4637          	lui	a2,0xf4
    800065ac:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800065b0:	00d70733          	add	a4,a4,a3
    800065b4:	0037979b          	slliw	a5,a5,0x3
    800065b8:	020046b7          	lui	a3,0x2004
    800065bc:	00d787b3          	add	a5,a5,a3
    800065c0:	00c585b3          	add	a1,a1,a2
    800065c4:	00371693          	slli	a3,a4,0x3
    800065c8:	00005717          	auipc	a4,0x5
    800065cc:	29870713          	addi	a4,a4,664 # 8000b860 <timer_scratch>
    800065d0:	00b7b023          	sd	a1,0(a5)
    800065d4:	00d70733          	add	a4,a4,a3
    800065d8:	00f73c23          	sd	a5,24(a4)
    800065dc:	02c73023          	sd	a2,32(a4)
    800065e0:	34071073          	csrw	mscratch,a4
    800065e4:	00000797          	auipc	a5,0x0
    800065e8:	64c78793          	addi	a5,a5,1612 # 80006c30 <timervec>
    800065ec:	30579073          	csrw	mtvec,a5
    800065f0:	300027f3          	csrr	a5,mstatus
    800065f4:	0087e793          	ori	a5,a5,8
    800065f8:	30079073          	csrw	mstatus,a5
    800065fc:	304027f3          	csrr	a5,mie
    80006600:	0807e793          	ori	a5,a5,128
    80006604:	30479073          	csrw	mie,a5
    80006608:	00813403          	ld	s0,8(sp)
    8000660c:	01010113          	addi	sp,sp,16
    80006610:	00008067          	ret

0000000080006614 <system_main>:
    80006614:	fe010113          	addi	sp,sp,-32
    80006618:	00813823          	sd	s0,16(sp)
    8000661c:	00913423          	sd	s1,8(sp)
    80006620:	00113c23          	sd	ra,24(sp)
    80006624:	02010413          	addi	s0,sp,32
    80006628:	00000097          	auipc	ra,0x0
    8000662c:	0c4080e7          	jalr	196(ra) # 800066ec <cpuid>
    80006630:	00005497          	auipc	s1,0x5
    80006634:	14048493          	addi	s1,s1,320 # 8000b770 <started>
    80006638:	02050263          	beqz	a0,8000665c <system_main+0x48>
    8000663c:	0004a783          	lw	a5,0(s1)
    80006640:	0007879b          	sext.w	a5,a5
    80006644:	fe078ce3          	beqz	a5,8000663c <system_main+0x28>
    80006648:	0ff0000f          	fence
    8000664c:	00003517          	auipc	a0,0x3
    80006650:	edc50513          	addi	a0,a0,-292 # 80009528 <CONSOLE_STATUS+0x518>
    80006654:	00001097          	auipc	ra,0x1
    80006658:	a78080e7          	jalr	-1416(ra) # 800070cc <panic>
    8000665c:	00001097          	auipc	ra,0x1
    80006660:	9cc080e7          	jalr	-1588(ra) # 80007028 <consoleinit>
    80006664:	00001097          	auipc	ra,0x1
    80006668:	158080e7          	jalr	344(ra) # 800077bc <printfinit>
    8000666c:	00003517          	auipc	a0,0x3
    80006670:	bec50513          	addi	a0,a0,-1044 # 80009258 <CONSOLE_STATUS+0x248>
    80006674:	00001097          	auipc	ra,0x1
    80006678:	ab4080e7          	jalr	-1356(ra) # 80007128 <__printf>
    8000667c:	00003517          	auipc	a0,0x3
    80006680:	e7c50513          	addi	a0,a0,-388 # 800094f8 <CONSOLE_STATUS+0x4e8>
    80006684:	00001097          	auipc	ra,0x1
    80006688:	aa4080e7          	jalr	-1372(ra) # 80007128 <__printf>
    8000668c:	00003517          	auipc	a0,0x3
    80006690:	bcc50513          	addi	a0,a0,-1076 # 80009258 <CONSOLE_STATUS+0x248>
    80006694:	00001097          	auipc	ra,0x1
    80006698:	a94080e7          	jalr	-1388(ra) # 80007128 <__printf>
    8000669c:	00001097          	auipc	ra,0x1
    800066a0:	4ac080e7          	jalr	1196(ra) # 80007b48 <kinit>
    800066a4:	00000097          	auipc	ra,0x0
    800066a8:	148080e7          	jalr	328(ra) # 800067ec <trapinit>
    800066ac:	00000097          	auipc	ra,0x0
    800066b0:	16c080e7          	jalr	364(ra) # 80006818 <trapinithart>
    800066b4:	00000097          	auipc	ra,0x0
    800066b8:	5bc080e7          	jalr	1468(ra) # 80006c70 <plicinit>
    800066bc:	00000097          	auipc	ra,0x0
    800066c0:	5dc080e7          	jalr	1500(ra) # 80006c98 <plicinithart>
    800066c4:	00000097          	auipc	ra,0x0
    800066c8:	078080e7          	jalr	120(ra) # 8000673c <userinit>
    800066cc:	0ff0000f          	fence
    800066d0:	00100793          	li	a5,1
    800066d4:	00003517          	auipc	a0,0x3
    800066d8:	e3c50513          	addi	a0,a0,-452 # 80009510 <CONSOLE_STATUS+0x500>
    800066dc:	00f4a023          	sw	a5,0(s1)
    800066e0:	00001097          	auipc	ra,0x1
    800066e4:	a48080e7          	jalr	-1464(ra) # 80007128 <__printf>
    800066e8:	0000006f          	j	800066e8 <system_main+0xd4>

00000000800066ec <cpuid>:
    800066ec:	ff010113          	addi	sp,sp,-16
    800066f0:	00813423          	sd	s0,8(sp)
    800066f4:	01010413          	addi	s0,sp,16
    800066f8:	00020513          	mv	a0,tp
    800066fc:	00813403          	ld	s0,8(sp)
    80006700:	0005051b          	sext.w	a0,a0
    80006704:	01010113          	addi	sp,sp,16
    80006708:	00008067          	ret

000000008000670c <mycpu>:
    8000670c:	ff010113          	addi	sp,sp,-16
    80006710:	00813423          	sd	s0,8(sp)
    80006714:	01010413          	addi	s0,sp,16
    80006718:	00020793          	mv	a5,tp
    8000671c:	00813403          	ld	s0,8(sp)
    80006720:	0007879b          	sext.w	a5,a5
    80006724:	00779793          	slli	a5,a5,0x7
    80006728:	00006517          	auipc	a0,0x6
    8000672c:	16850513          	addi	a0,a0,360 # 8000c890 <cpus>
    80006730:	00f50533          	add	a0,a0,a5
    80006734:	01010113          	addi	sp,sp,16
    80006738:	00008067          	ret

000000008000673c <userinit>:
    8000673c:	ff010113          	addi	sp,sp,-16
    80006740:	00813423          	sd	s0,8(sp)
    80006744:	01010413          	addi	s0,sp,16
    80006748:	00813403          	ld	s0,8(sp)
    8000674c:	01010113          	addi	sp,sp,16
    80006750:	ffffe317          	auipc	t1,0xffffe
    80006754:	0cc30067          	jr	204(t1) # 8000481c <main>

0000000080006758 <either_copyout>:
    80006758:	ff010113          	addi	sp,sp,-16
    8000675c:	00813023          	sd	s0,0(sp)
    80006760:	00113423          	sd	ra,8(sp)
    80006764:	01010413          	addi	s0,sp,16
    80006768:	02051663          	bnez	a0,80006794 <either_copyout+0x3c>
    8000676c:	00058513          	mv	a0,a1
    80006770:	00060593          	mv	a1,a2
    80006774:	0006861b          	sext.w	a2,a3
    80006778:	00002097          	auipc	ra,0x2
    8000677c:	c5c080e7          	jalr	-932(ra) # 800083d4 <__memmove>
    80006780:	00813083          	ld	ra,8(sp)
    80006784:	00013403          	ld	s0,0(sp)
    80006788:	00000513          	li	a0,0
    8000678c:	01010113          	addi	sp,sp,16
    80006790:	00008067          	ret
    80006794:	00003517          	auipc	a0,0x3
    80006798:	dbc50513          	addi	a0,a0,-580 # 80009550 <CONSOLE_STATUS+0x540>
    8000679c:	00001097          	auipc	ra,0x1
    800067a0:	930080e7          	jalr	-1744(ra) # 800070cc <panic>

00000000800067a4 <either_copyin>:
    800067a4:	ff010113          	addi	sp,sp,-16
    800067a8:	00813023          	sd	s0,0(sp)
    800067ac:	00113423          	sd	ra,8(sp)
    800067b0:	01010413          	addi	s0,sp,16
    800067b4:	02059463          	bnez	a1,800067dc <either_copyin+0x38>
    800067b8:	00060593          	mv	a1,a2
    800067bc:	0006861b          	sext.w	a2,a3
    800067c0:	00002097          	auipc	ra,0x2
    800067c4:	c14080e7          	jalr	-1004(ra) # 800083d4 <__memmove>
    800067c8:	00813083          	ld	ra,8(sp)
    800067cc:	00013403          	ld	s0,0(sp)
    800067d0:	00000513          	li	a0,0
    800067d4:	01010113          	addi	sp,sp,16
    800067d8:	00008067          	ret
    800067dc:	00003517          	auipc	a0,0x3
    800067e0:	d9c50513          	addi	a0,a0,-612 # 80009578 <CONSOLE_STATUS+0x568>
    800067e4:	00001097          	auipc	ra,0x1
    800067e8:	8e8080e7          	jalr	-1816(ra) # 800070cc <panic>

00000000800067ec <trapinit>:
    800067ec:	ff010113          	addi	sp,sp,-16
    800067f0:	00813423          	sd	s0,8(sp)
    800067f4:	01010413          	addi	s0,sp,16
    800067f8:	00813403          	ld	s0,8(sp)
    800067fc:	00003597          	auipc	a1,0x3
    80006800:	da458593          	addi	a1,a1,-604 # 800095a0 <CONSOLE_STATUS+0x590>
    80006804:	00006517          	auipc	a0,0x6
    80006808:	10c50513          	addi	a0,a0,268 # 8000c910 <tickslock>
    8000680c:	01010113          	addi	sp,sp,16
    80006810:	00001317          	auipc	t1,0x1
    80006814:	5c830067          	jr	1480(t1) # 80007dd8 <initlock>

0000000080006818 <trapinithart>:
    80006818:	ff010113          	addi	sp,sp,-16
    8000681c:	00813423          	sd	s0,8(sp)
    80006820:	01010413          	addi	s0,sp,16
    80006824:	00000797          	auipc	a5,0x0
    80006828:	2fc78793          	addi	a5,a5,764 # 80006b20 <kernelvec>
    8000682c:	10579073          	csrw	stvec,a5
    80006830:	00813403          	ld	s0,8(sp)
    80006834:	01010113          	addi	sp,sp,16
    80006838:	00008067          	ret

000000008000683c <usertrap>:
    8000683c:	ff010113          	addi	sp,sp,-16
    80006840:	00813423          	sd	s0,8(sp)
    80006844:	01010413          	addi	s0,sp,16
    80006848:	00813403          	ld	s0,8(sp)
    8000684c:	01010113          	addi	sp,sp,16
    80006850:	00008067          	ret

0000000080006854 <usertrapret>:
    80006854:	ff010113          	addi	sp,sp,-16
    80006858:	00813423          	sd	s0,8(sp)
    8000685c:	01010413          	addi	s0,sp,16
    80006860:	00813403          	ld	s0,8(sp)
    80006864:	01010113          	addi	sp,sp,16
    80006868:	00008067          	ret

000000008000686c <kerneltrap>:
    8000686c:	fe010113          	addi	sp,sp,-32
    80006870:	00813823          	sd	s0,16(sp)
    80006874:	00113c23          	sd	ra,24(sp)
    80006878:	00913423          	sd	s1,8(sp)
    8000687c:	02010413          	addi	s0,sp,32
    80006880:	142025f3          	csrr	a1,scause
    80006884:	100027f3          	csrr	a5,sstatus
    80006888:	0027f793          	andi	a5,a5,2
    8000688c:	10079c63          	bnez	a5,800069a4 <kerneltrap+0x138>
    80006890:	142027f3          	csrr	a5,scause
    80006894:	0207ce63          	bltz	a5,800068d0 <kerneltrap+0x64>
    80006898:	00003517          	auipc	a0,0x3
    8000689c:	d5050513          	addi	a0,a0,-688 # 800095e8 <CONSOLE_STATUS+0x5d8>
    800068a0:	00001097          	auipc	ra,0x1
    800068a4:	888080e7          	jalr	-1912(ra) # 80007128 <__printf>
    800068a8:	141025f3          	csrr	a1,sepc
    800068ac:	14302673          	csrr	a2,stval
    800068b0:	00003517          	auipc	a0,0x3
    800068b4:	d4850513          	addi	a0,a0,-696 # 800095f8 <CONSOLE_STATUS+0x5e8>
    800068b8:	00001097          	auipc	ra,0x1
    800068bc:	870080e7          	jalr	-1936(ra) # 80007128 <__printf>
    800068c0:	00003517          	auipc	a0,0x3
    800068c4:	d5050513          	addi	a0,a0,-688 # 80009610 <CONSOLE_STATUS+0x600>
    800068c8:	00001097          	auipc	ra,0x1
    800068cc:	804080e7          	jalr	-2044(ra) # 800070cc <panic>
    800068d0:	0ff7f713          	andi	a4,a5,255
    800068d4:	00900693          	li	a3,9
    800068d8:	04d70063          	beq	a4,a3,80006918 <kerneltrap+0xac>
    800068dc:	fff00713          	li	a4,-1
    800068e0:	03f71713          	slli	a4,a4,0x3f
    800068e4:	00170713          	addi	a4,a4,1
    800068e8:	fae798e3          	bne	a5,a4,80006898 <kerneltrap+0x2c>
    800068ec:	00000097          	auipc	ra,0x0
    800068f0:	e00080e7          	jalr	-512(ra) # 800066ec <cpuid>
    800068f4:	06050663          	beqz	a0,80006960 <kerneltrap+0xf4>
    800068f8:	144027f3          	csrr	a5,sip
    800068fc:	ffd7f793          	andi	a5,a5,-3
    80006900:	14479073          	csrw	sip,a5
    80006904:	01813083          	ld	ra,24(sp)
    80006908:	01013403          	ld	s0,16(sp)
    8000690c:	00813483          	ld	s1,8(sp)
    80006910:	02010113          	addi	sp,sp,32
    80006914:	00008067          	ret
    80006918:	00000097          	auipc	ra,0x0
    8000691c:	3cc080e7          	jalr	972(ra) # 80006ce4 <plic_claim>
    80006920:	00a00793          	li	a5,10
    80006924:	00050493          	mv	s1,a0
    80006928:	06f50863          	beq	a0,a5,80006998 <kerneltrap+0x12c>
    8000692c:	fc050ce3          	beqz	a0,80006904 <kerneltrap+0x98>
    80006930:	00050593          	mv	a1,a0
    80006934:	00003517          	auipc	a0,0x3
    80006938:	c9450513          	addi	a0,a0,-876 # 800095c8 <CONSOLE_STATUS+0x5b8>
    8000693c:	00000097          	auipc	ra,0x0
    80006940:	7ec080e7          	jalr	2028(ra) # 80007128 <__printf>
    80006944:	01013403          	ld	s0,16(sp)
    80006948:	01813083          	ld	ra,24(sp)
    8000694c:	00048513          	mv	a0,s1
    80006950:	00813483          	ld	s1,8(sp)
    80006954:	02010113          	addi	sp,sp,32
    80006958:	00000317          	auipc	t1,0x0
    8000695c:	3c430067          	jr	964(t1) # 80006d1c <plic_complete>
    80006960:	00006517          	auipc	a0,0x6
    80006964:	fb050513          	addi	a0,a0,-80 # 8000c910 <tickslock>
    80006968:	00001097          	auipc	ra,0x1
    8000696c:	494080e7          	jalr	1172(ra) # 80007dfc <acquire>
    80006970:	00005717          	auipc	a4,0x5
    80006974:	e0470713          	addi	a4,a4,-508 # 8000b774 <ticks>
    80006978:	00072783          	lw	a5,0(a4)
    8000697c:	00006517          	auipc	a0,0x6
    80006980:	f9450513          	addi	a0,a0,-108 # 8000c910 <tickslock>
    80006984:	0017879b          	addiw	a5,a5,1
    80006988:	00f72023          	sw	a5,0(a4)
    8000698c:	00001097          	auipc	ra,0x1
    80006990:	53c080e7          	jalr	1340(ra) # 80007ec8 <release>
    80006994:	f65ff06f          	j	800068f8 <kerneltrap+0x8c>
    80006998:	00001097          	auipc	ra,0x1
    8000699c:	098080e7          	jalr	152(ra) # 80007a30 <uartintr>
    800069a0:	fa5ff06f          	j	80006944 <kerneltrap+0xd8>
    800069a4:	00003517          	auipc	a0,0x3
    800069a8:	c0450513          	addi	a0,a0,-1020 # 800095a8 <CONSOLE_STATUS+0x598>
    800069ac:	00000097          	auipc	ra,0x0
    800069b0:	720080e7          	jalr	1824(ra) # 800070cc <panic>

00000000800069b4 <clockintr>:
    800069b4:	fe010113          	addi	sp,sp,-32
    800069b8:	00813823          	sd	s0,16(sp)
    800069bc:	00913423          	sd	s1,8(sp)
    800069c0:	00113c23          	sd	ra,24(sp)
    800069c4:	02010413          	addi	s0,sp,32
    800069c8:	00006497          	auipc	s1,0x6
    800069cc:	f4848493          	addi	s1,s1,-184 # 8000c910 <tickslock>
    800069d0:	00048513          	mv	a0,s1
    800069d4:	00001097          	auipc	ra,0x1
    800069d8:	428080e7          	jalr	1064(ra) # 80007dfc <acquire>
    800069dc:	00005717          	auipc	a4,0x5
    800069e0:	d9870713          	addi	a4,a4,-616 # 8000b774 <ticks>
    800069e4:	00072783          	lw	a5,0(a4)
    800069e8:	01013403          	ld	s0,16(sp)
    800069ec:	01813083          	ld	ra,24(sp)
    800069f0:	00048513          	mv	a0,s1
    800069f4:	0017879b          	addiw	a5,a5,1
    800069f8:	00813483          	ld	s1,8(sp)
    800069fc:	00f72023          	sw	a5,0(a4)
    80006a00:	02010113          	addi	sp,sp,32
    80006a04:	00001317          	auipc	t1,0x1
    80006a08:	4c430067          	jr	1220(t1) # 80007ec8 <release>

0000000080006a0c <devintr>:
    80006a0c:	142027f3          	csrr	a5,scause
    80006a10:	00000513          	li	a0,0
    80006a14:	0007c463          	bltz	a5,80006a1c <devintr+0x10>
    80006a18:	00008067          	ret
    80006a1c:	fe010113          	addi	sp,sp,-32
    80006a20:	00813823          	sd	s0,16(sp)
    80006a24:	00113c23          	sd	ra,24(sp)
    80006a28:	00913423          	sd	s1,8(sp)
    80006a2c:	02010413          	addi	s0,sp,32
    80006a30:	0ff7f713          	andi	a4,a5,255
    80006a34:	00900693          	li	a3,9
    80006a38:	04d70c63          	beq	a4,a3,80006a90 <devintr+0x84>
    80006a3c:	fff00713          	li	a4,-1
    80006a40:	03f71713          	slli	a4,a4,0x3f
    80006a44:	00170713          	addi	a4,a4,1
    80006a48:	00e78c63          	beq	a5,a4,80006a60 <devintr+0x54>
    80006a4c:	01813083          	ld	ra,24(sp)
    80006a50:	01013403          	ld	s0,16(sp)
    80006a54:	00813483          	ld	s1,8(sp)
    80006a58:	02010113          	addi	sp,sp,32
    80006a5c:	00008067          	ret
    80006a60:	00000097          	auipc	ra,0x0
    80006a64:	c8c080e7          	jalr	-884(ra) # 800066ec <cpuid>
    80006a68:	06050663          	beqz	a0,80006ad4 <devintr+0xc8>
    80006a6c:	144027f3          	csrr	a5,sip
    80006a70:	ffd7f793          	andi	a5,a5,-3
    80006a74:	14479073          	csrw	sip,a5
    80006a78:	01813083          	ld	ra,24(sp)
    80006a7c:	01013403          	ld	s0,16(sp)
    80006a80:	00813483          	ld	s1,8(sp)
    80006a84:	00200513          	li	a0,2
    80006a88:	02010113          	addi	sp,sp,32
    80006a8c:	00008067          	ret
    80006a90:	00000097          	auipc	ra,0x0
    80006a94:	254080e7          	jalr	596(ra) # 80006ce4 <plic_claim>
    80006a98:	00a00793          	li	a5,10
    80006a9c:	00050493          	mv	s1,a0
    80006aa0:	06f50663          	beq	a0,a5,80006b0c <devintr+0x100>
    80006aa4:	00100513          	li	a0,1
    80006aa8:	fa0482e3          	beqz	s1,80006a4c <devintr+0x40>
    80006aac:	00048593          	mv	a1,s1
    80006ab0:	00003517          	auipc	a0,0x3
    80006ab4:	b1850513          	addi	a0,a0,-1256 # 800095c8 <CONSOLE_STATUS+0x5b8>
    80006ab8:	00000097          	auipc	ra,0x0
    80006abc:	670080e7          	jalr	1648(ra) # 80007128 <__printf>
    80006ac0:	00048513          	mv	a0,s1
    80006ac4:	00000097          	auipc	ra,0x0
    80006ac8:	258080e7          	jalr	600(ra) # 80006d1c <plic_complete>
    80006acc:	00100513          	li	a0,1
    80006ad0:	f7dff06f          	j	80006a4c <devintr+0x40>
    80006ad4:	00006517          	auipc	a0,0x6
    80006ad8:	e3c50513          	addi	a0,a0,-452 # 8000c910 <tickslock>
    80006adc:	00001097          	auipc	ra,0x1
    80006ae0:	320080e7          	jalr	800(ra) # 80007dfc <acquire>
    80006ae4:	00005717          	auipc	a4,0x5
    80006ae8:	c9070713          	addi	a4,a4,-880 # 8000b774 <ticks>
    80006aec:	00072783          	lw	a5,0(a4)
    80006af0:	00006517          	auipc	a0,0x6
    80006af4:	e2050513          	addi	a0,a0,-480 # 8000c910 <tickslock>
    80006af8:	0017879b          	addiw	a5,a5,1
    80006afc:	00f72023          	sw	a5,0(a4)
    80006b00:	00001097          	auipc	ra,0x1
    80006b04:	3c8080e7          	jalr	968(ra) # 80007ec8 <release>
    80006b08:	f65ff06f          	j	80006a6c <devintr+0x60>
    80006b0c:	00001097          	auipc	ra,0x1
    80006b10:	f24080e7          	jalr	-220(ra) # 80007a30 <uartintr>
    80006b14:	fadff06f          	j	80006ac0 <devintr+0xb4>
	...

0000000080006b20 <kernelvec>:
    80006b20:	f0010113          	addi	sp,sp,-256
    80006b24:	00113023          	sd	ra,0(sp)
    80006b28:	00213423          	sd	sp,8(sp)
    80006b2c:	00313823          	sd	gp,16(sp)
    80006b30:	00413c23          	sd	tp,24(sp)
    80006b34:	02513023          	sd	t0,32(sp)
    80006b38:	02613423          	sd	t1,40(sp)
    80006b3c:	02713823          	sd	t2,48(sp)
    80006b40:	02813c23          	sd	s0,56(sp)
    80006b44:	04913023          	sd	s1,64(sp)
    80006b48:	04a13423          	sd	a0,72(sp)
    80006b4c:	04b13823          	sd	a1,80(sp)
    80006b50:	04c13c23          	sd	a2,88(sp)
    80006b54:	06d13023          	sd	a3,96(sp)
    80006b58:	06e13423          	sd	a4,104(sp)
    80006b5c:	06f13823          	sd	a5,112(sp)
    80006b60:	07013c23          	sd	a6,120(sp)
    80006b64:	09113023          	sd	a7,128(sp)
    80006b68:	09213423          	sd	s2,136(sp)
    80006b6c:	09313823          	sd	s3,144(sp)
    80006b70:	09413c23          	sd	s4,152(sp)
    80006b74:	0b513023          	sd	s5,160(sp)
    80006b78:	0b613423          	sd	s6,168(sp)
    80006b7c:	0b713823          	sd	s7,176(sp)
    80006b80:	0b813c23          	sd	s8,184(sp)
    80006b84:	0d913023          	sd	s9,192(sp)
    80006b88:	0da13423          	sd	s10,200(sp)
    80006b8c:	0db13823          	sd	s11,208(sp)
    80006b90:	0dc13c23          	sd	t3,216(sp)
    80006b94:	0fd13023          	sd	t4,224(sp)
    80006b98:	0fe13423          	sd	t5,232(sp)
    80006b9c:	0ff13823          	sd	t6,240(sp)
    80006ba0:	ccdff0ef          	jal	ra,8000686c <kerneltrap>
    80006ba4:	00013083          	ld	ra,0(sp)
    80006ba8:	00813103          	ld	sp,8(sp)
    80006bac:	01013183          	ld	gp,16(sp)
    80006bb0:	02013283          	ld	t0,32(sp)
    80006bb4:	02813303          	ld	t1,40(sp)
    80006bb8:	03013383          	ld	t2,48(sp)
    80006bbc:	03813403          	ld	s0,56(sp)
    80006bc0:	04013483          	ld	s1,64(sp)
    80006bc4:	04813503          	ld	a0,72(sp)
    80006bc8:	05013583          	ld	a1,80(sp)
    80006bcc:	05813603          	ld	a2,88(sp)
    80006bd0:	06013683          	ld	a3,96(sp)
    80006bd4:	06813703          	ld	a4,104(sp)
    80006bd8:	07013783          	ld	a5,112(sp)
    80006bdc:	07813803          	ld	a6,120(sp)
    80006be0:	08013883          	ld	a7,128(sp)
    80006be4:	08813903          	ld	s2,136(sp)
    80006be8:	09013983          	ld	s3,144(sp)
    80006bec:	09813a03          	ld	s4,152(sp)
    80006bf0:	0a013a83          	ld	s5,160(sp)
    80006bf4:	0a813b03          	ld	s6,168(sp)
    80006bf8:	0b013b83          	ld	s7,176(sp)
    80006bfc:	0b813c03          	ld	s8,184(sp)
    80006c00:	0c013c83          	ld	s9,192(sp)
    80006c04:	0c813d03          	ld	s10,200(sp)
    80006c08:	0d013d83          	ld	s11,208(sp)
    80006c0c:	0d813e03          	ld	t3,216(sp)
    80006c10:	0e013e83          	ld	t4,224(sp)
    80006c14:	0e813f03          	ld	t5,232(sp)
    80006c18:	0f013f83          	ld	t6,240(sp)
    80006c1c:	10010113          	addi	sp,sp,256
    80006c20:	10200073          	sret
    80006c24:	00000013          	nop
    80006c28:	00000013          	nop
    80006c2c:	00000013          	nop

0000000080006c30 <timervec>:
    80006c30:	34051573          	csrrw	a0,mscratch,a0
    80006c34:	00b53023          	sd	a1,0(a0)
    80006c38:	00c53423          	sd	a2,8(a0)
    80006c3c:	00d53823          	sd	a3,16(a0)
    80006c40:	01853583          	ld	a1,24(a0)
    80006c44:	02053603          	ld	a2,32(a0)
    80006c48:	0005b683          	ld	a3,0(a1)
    80006c4c:	00c686b3          	add	a3,a3,a2
    80006c50:	00d5b023          	sd	a3,0(a1)
    80006c54:	00200593          	li	a1,2
    80006c58:	14459073          	csrw	sip,a1
    80006c5c:	01053683          	ld	a3,16(a0)
    80006c60:	00853603          	ld	a2,8(a0)
    80006c64:	00053583          	ld	a1,0(a0)
    80006c68:	34051573          	csrrw	a0,mscratch,a0
    80006c6c:	30200073          	mret

0000000080006c70 <plicinit>:
    80006c70:	ff010113          	addi	sp,sp,-16
    80006c74:	00813423          	sd	s0,8(sp)
    80006c78:	01010413          	addi	s0,sp,16
    80006c7c:	00813403          	ld	s0,8(sp)
    80006c80:	0c0007b7          	lui	a5,0xc000
    80006c84:	00100713          	li	a4,1
    80006c88:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80006c8c:	00e7a223          	sw	a4,4(a5)
    80006c90:	01010113          	addi	sp,sp,16
    80006c94:	00008067          	ret

0000000080006c98 <plicinithart>:
    80006c98:	ff010113          	addi	sp,sp,-16
    80006c9c:	00813023          	sd	s0,0(sp)
    80006ca0:	00113423          	sd	ra,8(sp)
    80006ca4:	01010413          	addi	s0,sp,16
    80006ca8:	00000097          	auipc	ra,0x0
    80006cac:	a44080e7          	jalr	-1468(ra) # 800066ec <cpuid>
    80006cb0:	0085171b          	slliw	a4,a0,0x8
    80006cb4:	0c0027b7          	lui	a5,0xc002
    80006cb8:	00e787b3          	add	a5,a5,a4
    80006cbc:	40200713          	li	a4,1026
    80006cc0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80006cc4:	00813083          	ld	ra,8(sp)
    80006cc8:	00013403          	ld	s0,0(sp)
    80006ccc:	00d5151b          	slliw	a0,a0,0xd
    80006cd0:	0c2017b7          	lui	a5,0xc201
    80006cd4:	00a78533          	add	a0,a5,a0
    80006cd8:	00052023          	sw	zero,0(a0)
    80006cdc:	01010113          	addi	sp,sp,16
    80006ce0:	00008067          	ret

0000000080006ce4 <plic_claim>:
    80006ce4:	ff010113          	addi	sp,sp,-16
    80006ce8:	00813023          	sd	s0,0(sp)
    80006cec:	00113423          	sd	ra,8(sp)
    80006cf0:	01010413          	addi	s0,sp,16
    80006cf4:	00000097          	auipc	ra,0x0
    80006cf8:	9f8080e7          	jalr	-1544(ra) # 800066ec <cpuid>
    80006cfc:	00813083          	ld	ra,8(sp)
    80006d00:	00013403          	ld	s0,0(sp)
    80006d04:	00d5151b          	slliw	a0,a0,0xd
    80006d08:	0c2017b7          	lui	a5,0xc201
    80006d0c:	00a78533          	add	a0,a5,a0
    80006d10:	00452503          	lw	a0,4(a0)
    80006d14:	01010113          	addi	sp,sp,16
    80006d18:	00008067          	ret

0000000080006d1c <plic_complete>:
    80006d1c:	fe010113          	addi	sp,sp,-32
    80006d20:	00813823          	sd	s0,16(sp)
    80006d24:	00913423          	sd	s1,8(sp)
    80006d28:	00113c23          	sd	ra,24(sp)
    80006d2c:	02010413          	addi	s0,sp,32
    80006d30:	00050493          	mv	s1,a0
    80006d34:	00000097          	auipc	ra,0x0
    80006d38:	9b8080e7          	jalr	-1608(ra) # 800066ec <cpuid>
    80006d3c:	01813083          	ld	ra,24(sp)
    80006d40:	01013403          	ld	s0,16(sp)
    80006d44:	00d5179b          	slliw	a5,a0,0xd
    80006d48:	0c201737          	lui	a4,0xc201
    80006d4c:	00f707b3          	add	a5,a4,a5
    80006d50:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80006d54:	00813483          	ld	s1,8(sp)
    80006d58:	02010113          	addi	sp,sp,32
    80006d5c:	00008067          	ret

0000000080006d60 <consolewrite>:
    80006d60:	fb010113          	addi	sp,sp,-80
    80006d64:	04813023          	sd	s0,64(sp)
    80006d68:	04113423          	sd	ra,72(sp)
    80006d6c:	02913c23          	sd	s1,56(sp)
    80006d70:	03213823          	sd	s2,48(sp)
    80006d74:	03313423          	sd	s3,40(sp)
    80006d78:	03413023          	sd	s4,32(sp)
    80006d7c:	01513c23          	sd	s5,24(sp)
    80006d80:	05010413          	addi	s0,sp,80
    80006d84:	06c05c63          	blez	a2,80006dfc <consolewrite+0x9c>
    80006d88:	00060993          	mv	s3,a2
    80006d8c:	00050a13          	mv	s4,a0
    80006d90:	00058493          	mv	s1,a1
    80006d94:	00000913          	li	s2,0
    80006d98:	fff00a93          	li	s5,-1
    80006d9c:	01c0006f          	j	80006db8 <consolewrite+0x58>
    80006da0:	fbf44503          	lbu	a0,-65(s0)
    80006da4:	0019091b          	addiw	s2,s2,1
    80006da8:	00148493          	addi	s1,s1,1
    80006dac:	00001097          	auipc	ra,0x1
    80006db0:	a9c080e7          	jalr	-1380(ra) # 80007848 <uartputc>
    80006db4:	03298063          	beq	s3,s2,80006dd4 <consolewrite+0x74>
    80006db8:	00048613          	mv	a2,s1
    80006dbc:	00100693          	li	a3,1
    80006dc0:	000a0593          	mv	a1,s4
    80006dc4:	fbf40513          	addi	a0,s0,-65
    80006dc8:	00000097          	auipc	ra,0x0
    80006dcc:	9dc080e7          	jalr	-1572(ra) # 800067a4 <either_copyin>
    80006dd0:	fd5518e3          	bne	a0,s5,80006da0 <consolewrite+0x40>
    80006dd4:	04813083          	ld	ra,72(sp)
    80006dd8:	04013403          	ld	s0,64(sp)
    80006ddc:	03813483          	ld	s1,56(sp)
    80006de0:	02813983          	ld	s3,40(sp)
    80006de4:	02013a03          	ld	s4,32(sp)
    80006de8:	01813a83          	ld	s5,24(sp)
    80006dec:	00090513          	mv	a0,s2
    80006df0:	03013903          	ld	s2,48(sp)
    80006df4:	05010113          	addi	sp,sp,80
    80006df8:	00008067          	ret
    80006dfc:	00000913          	li	s2,0
    80006e00:	fd5ff06f          	j	80006dd4 <consolewrite+0x74>

0000000080006e04 <consoleread>:
    80006e04:	f9010113          	addi	sp,sp,-112
    80006e08:	06813023          	sd	s0,96(sp)
    80006e0c:	04913c23          	sd	s1,88(sp)
    80006e10:	05213823          	sd	s2,80(sp)
    80006e14:	05313423          	sd	s3,72(sp)
    80006e18:	05413023          	sd	s4,64(sp)
    80006e1c:	03513c23          	sd	s5,56(sp)
    80006e20:	03613823          	sd	s6,48(sp)
    80006e24:	03713423          	sd	s7,40(sp)
    80006e28:	03813023          	sd	s8,32(sp)
    80006e2c:	06113423          	sd	ra,104(sp)
    80006e30:	01913c23          	sd	s9,24(sp)
    80006e34:	07010413          	addi	s0,sp,112
    80006e38:	00060b93          	mv	s7,a2
    80006e3c:	00050913          	mv	s2,a0
    80006e40:	00058c13          	mv	s8,a1
    80006e44:	00060b1b          	sext.w	s6,a2
    80006e48:	00006497          	auipc	s1,0x6
    80006e4c:	af048493          	addi	s1,s1,-1296 # 8000c938 <cons>
    80006e50:	00400993          	li	s3,4
    80006e54:	fff00a13          	li	s4,-1
    80006e58:	00a00a93          	li	s5,10
    80006e5c:	05705e63          	blez	s7,80006eb8 <consoleread+0xb4>
    80006e60:	09c4a703          	lw	a4,156(s1)
    80006e64:	0984a783          	lw	a5,152(s1)
    80006e68:	0007071b          	sext.w	a4,a4
    80006e6c:	08e78463          	beq	a5,a4,80006ef4 <consoleread+0xf0>
    80006e70:	07f7f713          	andi	a4,a5,127
    80006e74:	00e48733          	add	a4,s1,a4
    80006e78:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80006e7c:	0017869b          	addiw	a3,a5,1
    80006e80:	08d4ac23          	sw	a3,152(s1)
    80006e84:	00070c9b          	sext.w	s9,a4
    80006e88:	0b370663          	beq	a4,s3,80006f34 <consoleread+0x130>
    80006e8c:	00100693          	li	a3,1
    80006e90:	f9f40613          	addi	a2,s0,-97
    80006e94:	000c0593          	mv	a1,s8
    80006e98:	00090513          	mv	a0,s2
    80006e9c:	f8e40fa3          	sb	a4,-97(s0)
    80006ea0:	00000097          	auipc	ra,0x0
    80006ea4:	8b8080e7          	jalr	-1864(ra) # 80006758 <either_copyout>
    80006ea8:	01450863          	beq	a0,s4,80006eb8 <consoleread+0xb4>
    80006eac:	001c0c13          	addi	s8,s8,1
    80006eb0:	fffb8b9b          	addiw	s7,s7,-1
    80006eb4:	fb5c94e3          	bne	s9,s5,80006e5c <consoleread+0x58>
    80006eb8:	000b851b          	sext.w	a0,s7
    80006ebc:	06813083          	ld	ra,104(sp)
    80006ec0:	06013403          	ld	s0,96(sp)
    80006ec4:	05813483          	ld	s1,88(sp)
    80006ec8:	05013903          	ld	s2,80(sp)
    80006ecc:	04813983          	ld	s3,72(sp)
    80006ed0:	04013a03          	ld	s4,64(sp)
    80006ed4:	03813a83          	ld	s5,56(sp)
    80006ed8:	02813b83          	ld	s7,40(sp)
    80006edc:	02013c03          	ld	s8,32(sp)
    80006ee0:	01813c83          	ld	s9,24(sp)
    80006ee4:	40ab053b          	subw	a0,s6,a0
    80006ee8:	03013b03          	ld	s6,48(sp)
    80006eec:	07010113          	addi	sp,sp,112
    80006ef0:	00008067          	ret
    80006ef4:	00001097          	auipc	ra,0x1
    80006ef8:	1d8080e7          	jalr	472(ra) # 800080cc <push_on>
    80006efc:	0984a703          	lw	a4,152(s1)
    80006f00:	09c4a783          	lw	a5,156(s1)
    80006f04:	0007879b          	sext.w	a5,a5
    80006f08:	fef70ce3          	beq	a4,a5,80006f00 <consoleread+0xfc>
    80006f0c:	00001097          	auipc	ra,0x1
    80006f10:	234080e7          	jalr	564(ra) # 80008140 <pop_on>
    80006f14:	0984a783          	lw	a5,152(s1)
    80006f18:	07f7f713          	andi	a4,a5,127
    80006f1c:	00e48733          	add	a4,s1,a4
    80006f20:	01874703          	lbu	a4,24(a4)
    80006f24:	0017869b          	addiw	a3,a5,1
    80006f28:	08d4ac23          	sw	a3,152(s1)
    80006f2c:	00070c9b          	sext.w	s9,a4
    80006f30:	f5371ee3          	bne	a4,s3,80006e8c <consoleread+0x88>
    80006f34:	000b851b          	sext.w	a0,s7
    80006f38:	f96bf2e3          	bgeu	s7,s6,80006ebc <consoleread+0xb8>
    80006f3c:	08f4ac23          	sw	a5,152(s1)
    80006f40:	f7dff06f          	j	80006ebc <consoleread+0xb8>

0000000080006f44 <consputc>:
    80006f44:	10000793          	li	a5,256
    80006f48:	00f50663          	beq	a0,a5,80006f54 <consputc+0x10>
    80006f4c:	00001317          	auipc	t1,0x1
    80006f50:	9f430067          	jr	-1548(t1) # 80007940 <uartputc_sync>
    80006f54:	ff010113          	addi	sp,sp,-16
    80006f58:	00113423          	sd	ra,8(sp)
    80006f5c:	00813023          	sd	s0,0(sp)
    80006f60:	01010413          	addi	s0,sp,16
    80006f64:	00800513          	li	a0,8
    80006f68:	00001097          	auipc	ra,0x1
    80006f6c:	9d8080e7          	jalr	-1576(ra) # 80007940 <uartputc_sync>
    80006f70:	02000513          	li	a0,32
    80006f74:	00001097          	auipc	ra,0x1
    80006f78:	9cc080e7          	jalr	-1588(ra) # 80007940 <uartputc_sync>
    80006f7c:	00013403          	ld	s0,0(sp)
    80006f80:	00813083          	ld	ra,8(sp)
    80006f84:	00800513          	li	a0,8
    80006f88:	01010113          	addi	sp,sp,16
    80006f8c:	00001317          	auipc	t1,0x1
    80006f90:	9b430067          	jr	-1612(t1) # 80007940 <uartputc_sync>

0000000080006f94 <consoleintr>:
    80006f94:	fe010113          	addi	sp,sp,-32
    80006f98:	00813823          	sd	s0,16(sp)
    80006f9c:	00913423          	sd	s1,8(sp)
    80006fa0:	01213023          	sd	s2,0(sp)
    80006fa4:	00113c23          	sd	ra,24(sp)
    80006fa8:	02010413          	addi	s0,sp,32
    80006fac:	00006917          	auipc	s2,0x6
    80006fb0:	98c90913          	addi	s2,s2,-1652 # 8000c938 <cons>
    80006fb4:	00050493          	mv	s1,a0
    80006fb8:	00090513          	mv	a0,s2
    80006fbc:	00001097          	auipc	ra,0x1
    80006fc0:	e40080e7          	jalr	-448(ra) # 80007dfc <acquire>
    80006fc4:	02048c63          	beqz	s1,80006ffc <consoleintr+0x68>
    80006fc8:	0a092783          	lw	a5,160(s2)
    80006fcc:	09892703          	lw	a4,152(s2)
    80006fd0:	07f00693          	li	a3,127
    80006fd4:	40e7873b          	subw	a4,a5,a4
    80006fd8:	02e6e263          	bltu	a3,a4,80006ffc <consoleintr+0x68>
    80006fdc:	00d00713          	li	a4,13
    80006fe0:	04e48063          	beq	s1,a4,80007020 <consoleintr+0x8c>
    80006fe4:	07f7f713          	andi	a4,a5,127
    80006fe8:	00e90733          	add	a4,s2,a4
    80006fec:	0017879b          	addiw	a5,a5,1
    80006ff0:	0af92023          	sw	a5,160(s2)
    80006ff4:	00970c23          	sb	s1,24(a4)
    80006ff8:	08f92e23          	sw	a5,156(s2)
    80006ffc:	01013403          	ld	s0,16(sp)
    80007000:	01813083          	ld	ra,24(sp)
    80007004:	00813483          	ld	s1,8(sp)
    80007008:	00013903          	ld	s2,0(sp)
    8000700c:	00006517          	auipc	a0,0x6
    80007010:	92c50513          	addi	a0,a0,-1748 # 8000c938 <cons>
    80007014:	02010113          	addi	sp,sp,32
    80007018:	00001317          	auipc	t1,0x1
    8000701c:	eb030067          	jr	-336(t1) # 80007ec8 <release>
    80007020:	00a00493          	li	s1,10
    80007024:	fc1ff06f          	j	80006fe4 <consoleintr+0x50>

0000000080007028 <consoleinit>:
    80007028:	fe010113          	addi	sp,sp,-32
    8000702c:	00113c23          	sd	ra,24(sp)
    80007030:	00813823          	sd	s0,16(sp)
    80007034:	00913423          	sd	s1,8(sp)
    80007038:	02010413          	addi	s0,sp,32
    8000703c:	00006497          	auipc	s1,0x6
    80007040:	8fc48493          	addi	s1,s1,-1796 # 8000c938 <cons>
    80007044:	00048513          	mv	a0,s1
    80007048:	00002597          	auipc	a1,0x2
    8000704c:	5d858593          	addi	a1,a1,1496 # 80009620 <CONSOLE_STATUS+0x610>
    80007050:	00001097          	auipc	ra,0x1
    80007054:	d88080e7          	jalr	-632(ra) # 80007dd8 <initlock>
    80007058:	00000097          	auipc	ra,0x0
    8000705c:	7ac080e7          	jalr	1964(ra) # 80007804 <uartinit>
    80007060:	01813083          	ld	ra,24(sp)
    80007064:	01013403          	ld	s0,16(sp)
    80007068:	00000797          	auipc	a5,0x0
    8000706c:	d9c78793          	addi	a5,a5,-612 # 80006e04 <consoleread>
    80007070:	0af4bc23          	sd	a5,184(s1)
    80007074:	00000797          	auipc	a5,0x0
    80007078:	cec78793          	addi	a5,a5,-788 # 80006d60 <consolewrite>
    8000707c:	0cf4b023          	sd	a5,192(s1)
    80007080:	00813483          	ld	s1,8(sp)
    80007084:	02010113          	addi	sp,sp,32
    80007088:	00008067          	ret

000000008000708c <console_read>:
    8000708c:	ff010113          	addi	sp,sp,-16
    80007090:	00813423          	sd	s0,8(sp)
    80007094:	01010413          	addi	s0,sp,16
    80007098:	00813403          	ld	s0,8(sp)
    8000709c:	00006317          	auipc	t1,0x6
    800070a0:	95433303          	ld	t1,-1708(t1) # 8000c9f0 <devsw+0x10>
    800070a4:	01010113          	addi	sp,sp,16
    800070a8:	00030067          	jr	t1

00000000800070ac <console_write>:
    800070ac:	ff010113          	addi	sp,sp,-16
    800070b0:	00813423          	sd	s0,8(sp)
    800070b4:	01010413          	addi	s0,sp,16
    800070b8:	00813403          	ld	s0,8(sp)
    800070bc:	00006317          	auipc	t1,0x6
    800070c0:	93c33303          	ld	t1,-1732(t1) # 8000c9f8 <devsw+0x18>
    800070c4:	01010113          	addi	sp,sp,16
    800070c8:	00030067          	jr	t1

00000000800070cc <panic>:
    800070cc:	fe010113          	addi	sp,sp,-32
    800070d0:	00113c23          	sd	ra,24(sp)
    800070d4:	00813823          	sd	s0,16(sp)
    800070d8:	00913423          	sd	s1,8(sp)
    800070dc:	02010413          	addi	s0,sp,32
    800070e0:	00050493          	mv	s1,a0
    800070e4:	00002517          	auipc	a0,0x2
    800070e8:	54450513          	addi	a0,a0,1348 # 80009628 <CONSOLE_STATUS+0x618>
    800070ec:	00006797          	auipc	a5,0x6
    800070f0:	9a07a623          	sw	zero,-1620(a5) # 8000ca98 <pr+0x18>
    800070f4:	00000097          	auipc	ra,0x0
    800070f8:	034080e7          	jalr	52(ra) # 80007128 <__printf>
    800070fc:	00048513          	mv	a0,s1
    80007100:	00000097          	auipc	ra,0x0
    80007104:	028080e7          	jalr	40(ra) # 80007128 <__printf>
    80007108:	00002517          	auipc	a0,0x2
    8000710c:	15050513          	addi	a0,a0,336 # 80009258 <CONSOLE_STATUS+0x248>
    80007110:	00000097          	auipc	ra,0x0
    80007114:	018080e7          	jalr	24(ra) # 80007128 <__printf>
    80007118:	00100793          	li	a5,1
    8000711c:	00004717          	auipc	a4,0x4
    80007120:	64f72e23          	sw	a5,1628(a4) # 8000b778 <panicked>
    80007124:	0000006f          	j	80007124 <panic+0x58>

0000000080007128 <__printf>:
    80007128:	f3010113          	addi	sp,sp,-208
    8000712c:	08813023          	sd	s0,128(sp)
    80007130:	07313423          	sd	s3,104(sp)
    80007134:	09010413          	addi	s0,sp,144
    80007138:	05813023          	sd	s8,64(sp)
    8000713c:	08113423          	sd	ra,136(sp)
    80007140:	06913c23          	sd	s1,120(sp)
    80007144:	07213823          	sd	s2,112(sp)
    80007148:	07413023          	sd	s4,96(sp)
    8000714c:	05513c23          	sd	s5,88(sp)
    80007150:	05613823          	sd	s6,80(sp)
    80007154:	05713423          	sd	s7,72(sp)
    80007158:	03913c23          	sd	s9,56(sp)
    8000715c:	03a13823          	sd	s10,48(sp)
    80007160:	03b13423          	sd	s11,40(sp)
    80007164:	00006317          	auipc	t1,0x6
    80007168:	91c30313          	addi	t1,t1,-1764 # 8000ca80 <pr>
    8000716c:	01832c03          	lw	s8,24(t1)
    80007170:	00b43423          	sd	a1,8(s0)
    80007174:	00c43823          	sd	a2,16(s0)
    80007178:	00d43c23          	sd	a3,24(s0)
    8000717c:	02e43023          	sd	a4,32(s0)
    80007180:	02f43423          	sd	a5,40(s0)
    80007184:	03043823          	sd	a6,48(s0)
    80007188:	03143c23          	sd	a7,56(s0)
    8000718c:	00050993          	mv	s3,a0
    80007190:	4a0c1663          	bnez	s8,8000763c <__printf+0x514>
    80007194:	60098c63          	beqz	s3,800077ac <__printf+0x684>
    80007198:	0009c503          	lbu	a0,0(s3)
    8000719c:	00840793          	addi	a5,s0,8
    800071a0:	f6f43c23          	sd	a5,-136(s0)
    800071a4:	00000493          	li	s1,0
    800071a8:	22050063          	beqz	a0,800073c8 <__printf+0x2a0>
    800071ac:	00002a37          	lui	s4,0x2
    800071b0:	00018ab7          	lui	s5,0x18
    800071b4:	000f4b37          	lui	s6,0xf4
    800071b8:	00989bb7          	lui	s7,0x989
    800071bc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    800071c0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    800071c4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    800071c8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    800071cc:	00148c9b          	addiw	s9,s1,1
    800071d0:	02500793          	li	a5,37
    800071d4:	01998933          	add	s2,s3,s9
    800071d8:	38f51263          	bne	a0,a5,8000755c <__printf+0x434>
    800071dc:	00094783          	lbu	a5,0(s2)
    800071e0:	00078c9b          	sext.w	s9,a5
    800071e4:	1e078263          	beqz	a5,800073c8 <__printf+0x2a0>
    800071e8:	0024849b          	addiw	s1,s1,2
    800071ec:	07000713          	li	a4,112
    800071f0:	00998933          	add	s2,s3,s1
    800071f4:	38e78a63          	beq	a5,a4,80007588 <__printf+0x460>
    800071f8:	20f76863          	bltu	a4,a5,80007408 <__printf+0x2e0>
    800071fc:	42a78863          	beq	a5,a0,8000762c <__printf+0x504>
    80007200:	06400713          	li	a4,100
    80007204:	40e79663          	bne	a5,a4,80007610 <__printf+0x4e8>
    80007208:	f7843783          	ld	a5,-136(s0)
    8000720c:	0007a603          	lw	a2,0(a5)
    80007210:	00878793          	addi	a5,a5,8
    80007214:	f6f43c23          	sd	a5,-136(s0)
    80007218:	42064a63          	bltz	a2,8000764c <__printf+0x524>
    8000721c:	00a00713          	li	a4,10
    80007220:	02e677bb          	remuw	a5,a2,a4
    80007224:	00002d97          	auipc	s11,0x2
    80007228:	42cd8d93          	addi	s11,s11,1068 # 80009650 <digits>
    8000722c:	00900593          	li	a1,9
    80007230:	0006051b          	sext.w	a0,a2
    80007234:	00000c93          	li	s9,0
    80007238:	02079793          	slli	a5,a5,0x20
    8000723c:	0207d793          	srli	a5,a5,0x20
    80007240:	00fd87b3          	add	a5,s11,a5
    80007244:	0007c783          	lbu	a5,0(a5)
    80007248:	02e656bb          	divuw	a3,a2,a4
    8000724c:	f8f40023          	sb	a5,-128(s0)
    80007250:	14c5d863          	bge	a1,a2,800073a0 <__printf+0x278>
    80007254:	06300593          	li	a1,99
    80007258:	00100c93          	li	s9,1
    8000725c:	02e6f7bb          	remuw	a5,a3,a4
    80007260:	02079793          	slli	a5,a5,0x20
    80007264:	0207d793          	srli	a5,a5,0x20
    80007268:	00fd87b3          	add	a5,s11,a5
    8000726c:	0007c783          	lbu	a5,0(a5)
    80007270:	02e6d73b          	divuw	a4,a3,a4
    80007274:	f8f400a3          	sb	a5,-127(s0)
    80007278:	12a5f463          	bgeu	a1,a0,800073a0 <__printf+0x278>
    8000727c:	00a00693          	li	a3,10
    80007280:	00900593          	li	a1,9
    80007284:	02d777bb          	remuw	a5,a4,a3
    80007288:	02079793          	slli	a5,a5,0x20
    8000728c:	0207d793          	srli	a5,a5,0x20
    80007290:	00fd87b3          	add	a5,s11,a5
    80007294:	0007c503          	lbu	a0,0(a5)
    80007298:	02d757bb          	divuw	a5,a4,a3
    8000729c:	f8a40123          	sb	a0,-126(s0)
    800072a0:	48e5f263          	bgeu	a1,a4,80007724 <__printf+0x5fc>
    800072a4:	06300513          	li	a0,99
    800072a8:	02d7f5bb          	remuw	a1,a5,a3
    800072ac:	02059593          	slli	a1,a1,0x20
    800072b0:	0205d593          	srli	a1,a1,0x20
    800072b4:	00bd85b3          	add	a1,s11,a1
    800072b8:	0005c583          	lbu	a1,0(a1)
    800072bc:	02d7d7bb          	divuw	a5,a5,a3
    800072c0:	f8b401a3          	sb	a1,-125(s0)
    800072c4:	48e57263          	bgeu	a0,a4,80007748 <__printf+0x620>
    800072c8:	3e700513          	li	a0,999
    800072cc:	02d7f5bb          	remuw	a1,a5,a3
    800072d0:	02059593          	slli	a1,a1,0x20
    800072d4:	0205d593          	srli	a1,a1,0x20
    800072d8:	00bd85b3          	add	a1,s11,a1
    800072dc:	0005c583          	lbu	a1,0(a1)
    800072e0:	02d7d7bb          	divuw	a5,a5,a3
    800072e4:	f8b40223          	sb	a1,-124(s0)
    800072e8:	46e57663          	bgeu	a0,a4,80007754 <__printf+0x62c>
    800072ec:	02d7f5bb          	remuw	a1,a5,a3
    800072f0:	02059593          	slli	a1,a1,0x20
    800072f4:	0205d593          	srli	a1,a1,0x20
    800072f8:	00bd85b3          	add	a1,s11,a1
    800072fc:	0005c583          	lbu	a1,0(a1)
    80007300:	02d7d7bb          	divuw	a5,a5,a3
    80007304:	f8b402a3          	sb	a1,-123(s0)
    80007308:	46ea7863          	bgeu	s4,a4,80007778 <__printf+0x650>
    8000730c:	02d7f5bb          	remuw	a1,a5,a3
    80007310:	02059593          	slli	a1,a1,0x20
    80007314:	0205d593          	srli	a1,a1,0x20
    80007318:	00bd85b3          	add	a1,s11,a1
    8000731c:	0005c583          	lbu	a1,0(a1)
    80007320:	02d7d7bb          	divuw	a5,a5,a3
    80007324:	f8b40323          	sb	a1,-122(s0)
    80007328:	3eeaf863          	bgeu	s5,a4,80007718 <__printf+0x5f0>
    8000732c:	02d7f5bb          	remuw	a1,a5,a3
    80007330:	02059593          	slli	a1,a1,0x20
    80007334:	0205d593          	srli	a1,a1,0x20
    80007338:	00bd85b3          	add	a1,s11,a1
    8000733c:	0005c583          	lbu	a1,0(a1)
    80007340:	02d7d7bb          	divuw	a5,a5,a3
    80007344:	f8b403a3          	sb	a1,-121(s0)
    80007348:	42eb7e63          	bgeu	s6,a4,80007784 <__printf+0x65c>
    8000734c:	02d7f5bb          	remuw	a1,a5,a3
    80007350:	02059593          	slli	a1,a1,0x20
    80007354:	0205d593          	srli	a1,a1,0x20
    80007358:	00bd85b3          	add	a1,s11,a1
    8000735c:	0005c583          	lbu	a1,0(a1)
    80007360:	02d7d7bb          	divuw	a5,a5,a3
    80007364:	f8b40423          	sb	a1,-120(s0)
    80007368:	42ebfc63          	bgeu	s7,a4,800077a0 <__printf+0x678>
    8000736c:	02079793          	slli	a5,a5,0x20
    80007370:	0207d793          	srli	a5,a5,0x20
    80007374:	00fd8db3          	add	s11,s11,a5
    80007378:	000dc703          	lbu	a4,0(s11)
    8000737c:	00a00793          	li	a5,10
    80007380:	00900c93          	li	s9,9
    80007384:	f8e404a3          	sb	a4,-119(s0)
    80007388:	00065c63          	bgez	a2,800073a0 <__printf+0x278>
    8000738c:	f9040713          	addi	a4,s0,-112
    80007390:	00f70733          	add	a4,a4,a5
    80007394:	02d00693          	li	a3,45
    80007398:	fed70823          	sb	a3,-16(a4)
    8000739c:	00078c93          	mv	s9,a5
    800073a0:	f8040793          	addi	a5,s0,-128
    800073a4:	01978cb3          	add	s9,a5,s9
    800073a8:	f7f40d13          	addi	s10,s0,-129
    800073ac:	000cc503          	lbu	a0,0(s9)
    800073b0:	fffc8c93          	addi	s9,s9,-1
    800073b4:	00000097          	auipc	ra,0x0
    800073b8:	b90080e7          	jalr	-1136(ra) # 80006f44 <consputc>
    800073bc:	ffac98e3          	bne	s9,s10,800073ac <__printf+0x284>
    800073c0:	00094503          	lbu	a0,0(s2)
    800073c4:	e00514e3          	bnez	a0,800071cc <__printf+0xa4>
    800073c8:	1a0c1663          	bnez	s8,80007574 <__printf+0x44c>
    800073cc:	08813083          	ld	ra,136(sp)
    800073d0:	08013403          	ld	s0,128(sp)
    800073d4:	07813483          	ld	s1,120(sp)
    800073d8:	07013903          	ld	s2,112(sp)
    800073dc:	06813983          	ld	s3,104(sp)
    800073e0:	06013a03          	ld	s4,96(sp)
    800073e4:	05813a83          	ld	s5,88(sp)
    800073e8:	05013b03          	ld	s6,80(sp)
    800073ec:	04813b83          	ld	s7,72(sp)
    800073f0:	04013c03          	ld	s8,64(sp)
    800073f4:	03813c83          	ld	s9,56(sp)
    800073f8:	03013d03          	ld	s10,48(sp)
    800073fc:	02813d83          	ld	s11,40(sp)
    80007400:	0d010113          	addi	sp,sp,208
    80007404:	00008067          	ret
    80007408:	07300713          	li	a4,115
    8000740c:	1ce78a63          	beq	a5,a4,800075e0 <__printf+0x4b8>
    80007410:	07800713          	li	a4,120
    80007414:	1ee79e63          	bne	a5,a4,80007610 <__printf+0x4e8>
    80007418:	f7843783          	ld	a5,-136(s0)
    8000741c:	0007a703          	lw	a4,0(a5)
    80007420:	00878793          	addi	a5,a5,8
    80007424:	f6f43c23          	sd	a5,-136(s0)
    80007428:	28074263          	bltz	a4,800076ac <__printf+0x584>
    8000742c:	00002d97          	auipc	s11,0x2
    80007430:	224d8d93          	addi	s11,s11,548 # 80009650 <digits>
    80007434:	00f77793          	andi	a5,a4,15
    80007438:	00fd87b3          	add	a5,s11,a5
    8000743c:	0007c683          	lbu	a3,0(a5)
    80007440:	00f00613          	li	a2,15
    80007444:	0007079b          	sext.w	a5,a4
    80007448:	f8d40023          	sb	a3,-128(s0)
    8000744c:	0047559b          	srliw	a1,a4,0x4
    80007450:	0047569b          	srliw	a3,a4,0x4
    80007454:	00000c93          	li	s9,0
    80007458:	0ee65063          	bge	a2,a4,80007538 <__printf+0x410>
    8000745c:	00f6f693          	andi	a3,a3,15
    80007460:	00dd86b3          	add	a3,s11,a3
    80007464:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80007468:	0087d79b          	srliw	a5,a5,0x8
    8000746c:	00100c93          	li	s9,1
    80007470:	f8d400a3          	sb	a3,-127(s0)
    80007474:	0cb67263          	bgeu	a2,a1,80007538 <__printf+0x410>
    80007478:	00f7f693          	andi	a3,a5,15
    8000747c:	00dd86b3          	add	a3,s11,a3
    80007480:	0006c583          	lbu	a1,0(a3)
    80007484:	00f00613          	li	a2,15
    80007488:	0047d69b          	srliw	a3,a5,0x4
    8000748c:	f8b40123          	sb	a1,-126(s0)
    80007490:	0047d593          	srli	a1,a5,0x4
    80007494:	28f67e63          	bgeu	a2,a5,80007730 <__printf+0x608>
    80007498:	00f6f693          	andi	a3,a3,15
    8000749c:	00dd86b3          	add	a3,s11,a3
    800074a0:	0006c503          	lbu	a0,0(a3)
    800074a4:	0087d813          	srli	a6,a5,0x8
    800074a8:	0087d69b          	srliw	a3,a5,0x8
    800074ac:	f8a401a3          	sb	a0,-125(s0)
    800074b0:	28b67663          	bgeu	a2,a1,8000773c <__printf+0x614>
    800074b4:	00f6f693          	andi	a3,a3,15
    800074b8:	00dd86b3          	add	a3,s11,a3
    800074bc:	0006c583          	lbu	a1,0(a3)
    800074c0:	00c7d513          	srli	a0,a5,0xc
    800074c4:	00c7d69b          	srliw	a3,a5,0xc
    800074c8:	f8b40223          	sb	a1,-124(s0)
    800074cc:	29067a63          	bgeu	a2,a6,80007760 <__printf+0x638>
    800074d0:	00f6f693          	andi	a3,a3,15
    800074d4:	00dd86b3          	add	a3,s11,a3
    800074d8:	0006c583          	lbu	a1,0(a3)
    800074dc:	0107d813          	srli	a6,a5,0x10
    800074e0:	0107d69b          	srliw	a3,a5,0x10
    800074e4:	f8b402a3          	sb	a1,-123(s0)
    800074e8:	28a67263          	bgeu	a2,a0,8000776c <__printf+0x644>
    800074ec:	00f6f693          	andi	a3,a3,15
    800074f0:	00dd86b3          	add	a3,s11,a3
    800074f4:	0006c683          	lbu	a3,0(a3)
    800074f8:	0147d79b          	srliw	a5,a5,0x14
    800074fc:	f8d40323          	sb	a3,-122(s0)
    80007500:	21067663          	bgeu	a2,a6,8000770c <__printf+0x5e4>
    80007504:	02079793          	slli	a5,a5,0x20
    80007508:	0207d793          	srli	a5,a5,0x20
    8000750c:	00fd8db3          	add	s11,s11,a5
    80007510:	000dc683          	lbu	a3,0(s11)
    80007514:	00800793          	li	a5,8
    80007518:	00700c93          	li	s9,7
    8000751c:	f8d403a3          	sb	a3,-121(s0)
    80007520:	00075c63          	bgez	a4,80007538 <__printf+0x410>
    80007524:	f9040713          	addi	a4,s0,-112
    80007528:	00f70733          	add	a4,a4,a5
    8000752c:	02d00693          	li	a3,45
    80007530:	fed70823          	sb	a3,-16(a4)
    80007534:	00078c93          	mv	s9,a5
    80007538:	f8040793          	addi	a5,s0,-128
    8000753c:	01978cb3          	add	s9,a5,s9
    80007540:	f7f40d13          	addi	s10,s0,-129
    80007544:	000cc503          	lbu	a0,0(s9)
    80007548:	fffc8c93          	addi	s9,s9,-1
    8000754c:	00000097          	auipc	ra,0x0
    80007550:	9f8080e7          	jalr	-1544(ra) # 80006f44 <consputc>
    80007554:	ff9d18e3          	bne	s10,s9,80007544 <__printf+0x41c>
    80007558:	0100006f          	j	80007568 <__printf+0x440>
    8000755c:	00000097          	auipc	ra,0x0
    80007560:	9e8080e7          	jalr	-1560(ra) # 80006f44 <consputc>
    80007564:	000c8493          	mv	s1,s9
    80007568:	00094503          	lbu	a0,0(s2)
    8000756c:	c60510e3          	bnez	a0,800071cc <__printf+0xa4>
    80007570:	e40c0ee3          	beqz	s8,800073cc <__printf+0x2a4>
    80007574:	00005517          	auipc	a0,0x5
    80007578:	50c50513          	addi	a0,a0,1292 # 8000ca80 <pr>
    8000757c:	00001097          	auipc	ra,0x1
    80007580:	94c080e7          	jalr	-1716(ra) # 80007ec8 <release>
    80007584:	e49ff06f          	j	800073cc <__printf+0x2a4>
    80007588:	f7843783          	ld	a5,-136(s0)
    8000758c:	03000513          	li	a0,48
    80007590:	01000d13          	li	s10,16
    80007594:	00878713          	addi	a4,a5,8
    80007598:	0007bc83          	ld	s9,0(a5)
    8000759c:	f6e43c23          	sd	a4,-136(s0)
    800075a0:	00000097          	auipc	ra,0x0
    800075a4:	9a4080e7          	jalr	-1628(ra) # 80006f44 <consputc>
    800075a8:	07800513          	li	a0,120
    800075ac:	00000097          	auipc	ra,0x0
    800075b0:	998080e7          	jalr	-1640(ra) # 80006f44 <consputc>
    800075b4:	00002d97          	auipc	s11,0x2
    800075b8:	09cd8d93          	addi	s11,s11,156 # 80009650 <digits>
    800075bc:	03ccd793          	srli	a5,s9,0x3c
    800075c0:	00fd87b3          	add	a5,s11,a5
    800075c4:	0007c503          	lbu	a0,0(a5)
    800075c8:	fffd0d1b          	addiw	s10,s10,-1
    800075cc:	004c9c93          	slli	s9,s9,0x4
    800075d0:	00000097          	auipc	ra,0x0
    800075d4:	974080e7          	jalr	-1676(ra) # 80006f44 <consputc>
    800075d8:	fe0d12e3          	bnez	s10,800075bc <__printf+0x494>
    800075dc:	f8dff06f          	j	80007568 <__printf+0x440>
    800075e0:	f7843783          	ld	a5,-136(s0)
    800075e4:	0007bc83          	ld	s9,0(a5)
    800075e8:	00878793          	addi	a5,a5,8
    800075ec:	f6f43c23          	sd	a5,-136(s0)
    800075f0:	000c9a63          	bnez	s9,80007604 <__printf+0x4dc>
    800075f4:	1080006f          	j	800076fc <__printf+0x5d4>
    800075f8:	001c8c93          	addi	s9,s9,1
    800075fc:	00000097          	auipc	ra,0x0
    80007600:	948080e7          	jalr	-1720(ra) # 80006f44 <consputc>
    80007604:	000cc503          	lbu	a0,0(s9)
    80007608:	fe0518e3          	bnez	a0,800075f8 <__printf+0x4d0>
    8000760c:	f5dff06f          	j	80007568 <__printf+0x440>
    80007610:	02500513          	li	a0,37
    80007614:	00000097          	auipc	ra,0x0
    80007618:	930080e7          	jalr	-1744(ra) # 80006f44 <consputc>
    8000761c:	000c8513          	mv	a0,s9
    80007620:	00000097          	auipc	ra,0x0
    80007624:	924080e7          	jalr	-1756(ra) # 80006f44 <consputc>
    80007628:	f41ff06f          	j	80007568 <__printf+0x440>
    8000762c:	02500513          	li	a0,37
    80007630:	00000097          	auipc	ra,0x0
    80007634:	914080e7          	jalr	-1772(ra) # 80006f44 <consputc>
    80007638:	f31ff06f          	j	80007568 <__printf+0x440>
    8000763c:	00030513          	mv	a0,t1
    80007640:	00000097          	auipc	ra,0x0
    80007644:	7bc080e7          	jalr	1980(ra) # 80007dfc <acquire>
    80007648:	b4dff06f          	j	80007194 <__printf+0x6c>
    8000764c:	40c0053b          	negw	a0,a2
    80007650:	00a00713          	li	a4,10
    80007654:	02e576bb          	remuw	a3,a0,a4
    80007658:	00002d97          	auipc	s11,0x2
    8000765c:	ff8d8d93          	addi	s11,s11,-8 # 80009650 <digits>
    80007660:	ff700593          	li	a1,-9
    80007664:	02069693          	slli	a3,a3,0x20
    80007668:	0206d693          	srli	a3,a3,0x20
    8000766c:	00dd86b3          	add	a3,s11,a3
    80007670:	0006c683          	lbu	a3,0(a3)
    80007674:	02e557bb          	divuw	a5,a0,a4
    80007678:	f8d40023          	sb	a3,-128(s0)
    8000767c:	10b65e63          	bge	a2,a1,80007798 <__printf+0x670>
    80007680:	06300593          	li	a1,99
    80007684:	02e7f6bb          	remuw	a3,a5,a4
    80007688:	02069693          	slli	a3,a3,0x20
    8000768c:	0206d693          	srli	a3,a3,0x20
    80007690:	00dd86b3          	add	a3,s11,a3
    80007694:	0006c683          	lbu	a3,0(a3)
    80007698:	02e7d73b          	divuw	a4,a5,a4
    8000769c:	00200793          	li	a5,2
    800076a0:	f8d400a3          	sb	a3,-127(s0)
    800076a4:	bca5ece3          	bltu	a1,a0,8000727c <__printf+0x154>
    800076a8:	ce5ff06f          	j	8000738c <__printf+0x264>
    800076ac:	40e007bb          	negw	a5,a4
    800076b0:	00002d97          	auipc	s11,0x2
    800076b4:	fa0d8d93          	addi	s11,s11,-96 # 80009650 <digits>
    800076b8:	00f7f693          	andi	a3,a5,15
    800076bc:	00dd86b3          	add	a3,s11,a3
    800076c0:	0006c583          	lbu	a1,0(a3)
    800076c4:	ff100613          	li	a2,-15
    800076c8:	0047d69b          	srliw	a3,a5,0x4
    800076cc:	f8b40023          	sb	a1,-128(s0)
    800076d0:	0047d59b          	srliw	a1,a5,0x4
    800076d4:	0ac75e63          	bge	a4,a2,80007790 <__printf+0x668>
    800076d8:	00f6f693          	andi	a3,a3,15
    800076dc:	00dd86b3          	add	a3,s11,a3
    800076e0:	0006c603          	lbu	a2,0(a3)
    800076e4:	00f00693          	li	a3,15
    800076e8:	0087d79b          	srliw	a5,a5,0x8
    800076ec:	f8c400a3          	sb	a2,-127(s0)
    800076f0:	d8b6e4e3          	bltu	a3,a1,80007478 <__printf+0x350>
    800076f4:	00200793          	li	a5,2
    800076f8:	e2dff06f          	j	80007524 <__printf+0x3fc>
    800076fc:	00002c97          	auipc	s9,0x2
    80007700:	f34c8c93          	addi	s9,s9,-204 # 80009630 <CONSOLE_STATUS+0x620>
    80007704:	02800513          	li	a0,40
    80007708:	ef1ff06f          	j	800075f8 <__printf+0x4d0>
    8000770c:	00700793          	li	a5,7
    80007710:	00600c93          	li	s9,6
    80007714:	e0dff06f          	j	80007520 <__printf+0x3f8>
    80007718:	00700793          	li	a5,7
    8000771c:	00600c93          	li	s9,6
    80007720:	c69ff06f          	j	80007388 <__printf+0x260>
    80007724:	00300793          	li	a5,3
    80007728:	00200c93          	li	s9,2
    8000772c:	c5dff06f          	j	80007388 <__printf+0x260>
    80007730:	00300793          	li	a5,3
    80007734:	00200c93          	li	s9,2
    80007738:	de9ff06f          	j	80007520 <__printf+0x3f8>
    8000773c:	00400793          	li	a5,4
    80007740:	00300c93          	li	s9,3
    80007744:	dddff06f          	j	80007520 <__printf+0x3f8>
    80007748:	00400793          	li	a5,4
    8000774c:	00300c93          	li	s9,3
    80007750:	c39ff06f          	j	80007388 <__printf+0x260>
    80007754:	00500793          	li	a5,5
    80007758:	00400c93          	li	s9,4
    8000775c:	c2dff06f          	j	80007388 <__printf+0x260>
    80007760:	00500793          	li	a5,5
    80007764:	00400c93          	li	s9,4
    80007768:	db9ff06f          	j	80007520 <__printf+0x3f8>
    8000776c:	00600793          	li	a5,6
    80007770:	00500c93          	li	s9,5
    80007774:	dadff06f          	j	80007520 <__printf+0x3f8>
    80007778:	00600793          	li	a5,6
    8000777c:	00500c93          	li	s9,5
    80007780:	c09ff06f          	j	80007388 <__printf+0x260>
    80007784:	00800793          	li	a5,8
    80007788:	00700c93          	li	s9,7
    8000778c:	bfdff06f          	j	80007388 <__printf+0x260>
    80007790:	00100793          	li	a5,1
    80007794:	d91ff06f          	j	80007524 <__printf+0x3fc>
    80007798:	00100793          	li	a5,1
    8000779c:	bf1ff06f          	j	8000738c <__printf+0x264>
    800077a0:	00900793          	li	a5,9
    800077a4:	00800c93          	li	s9,8
    800077a8:	be1ff06f          	j	80007388 <__printf+0x260>
    800077ac:	00002517          	auipc	a0,0x2
    800077b0:	e8c50513          	addi	a0,a0,-372 # 80009638 <CONSOLE_STATUS+0x628>
    800077b4:	00000097          	auipc	ra,0x0
    800077b8:	918080e7          	jalr	-1768(ra) # 800070cc <panic>

00000000800077bc <printfinit>:
    800077bc:	fe010113          	addi	sp,sp,-32
    800077c0:	00813823          	sd	s0,16(sp)
    800077c4:	00913423          	sd	s1,8(sp)
    800077c8:	00113c23          	sd	ra,24(sp)
    800077cc:	02010413          	addi	s0,sp,32
    800077d0:	00005497          	auipc	s1,0x5
    800077d4:	2b048493          	addi	s1,s1,688 # 8000ca80 <pr>
    800077d8:	00048513          	mv	a0,s1
    800077dc:	00002597          	auipc	a1,0x2
    800077e0:	e6c58593          	addi	a1,a1,-404 # 80009648 <CONSOLE_STATUS+0x638>
    800077e4:	00000097          	auipc	ra,0x0
    800077e8:	5f4080e7          	jalr	1524(ra) # 80007dd8 <initlock>
    800077ec:	01813083          	ld	ra,24(sp)
    800077f0:	01013403          	ld	s0,16(sp)
    800077f4:	0004ac23          	sw	zero,24(s1)
    800077f8:	00813483          	ld	s1,8(sp)
    800077fc:	02010113          	addi	sp,sp,32
    80007800:	00008067          	ret

0000000080007804 <uartinit>:
    80007804:	ff010113          	addi	sp,sp,-16
    80007808:	00813423          	sd	s0,8(sp)
    8000780c:	01010413          	addi	s0,sp,16
    80007810:	100007b7          	lui	a5,0x10000
    80007814:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80007818:	f8000713          	li	a4,-128
    8000781c:	00e781a3          	sb	a4,3(a5)
    80007820:	00300713          	li	a4,3
    80007824:	00e78023          	sb	a4,0(a5)
    80007828:	000780a3          	sb	zero,1(a5)
    8000782c:	00e781a3          	sb	a4,3(a5)
    80007830:	00700693          	li	a3,7
    80007834:	00d78123          	sb	a3,2(a5)
    80007838:	00e780a3          	sb	a4,1(a5)
    8000783c:	00813403          	ld	s0,8(sp)
    80007840:	01010113          	addi	sp,sp,16
    80007844:	00008067          	ret

0000000080007848 <uartputc>:
    80007848:	00004797          	auipc	a5,0x4
    8000784c:	f307a783          	lw	a5,-208(a5) # 8000b778 <panicked>
    80007850:	00078463          	beqz	a5,80007858 <uartputc+0x10>
    80007854:	0000006f          	j	80007854 <uartputc+0xc>
    80007858:	fd010113          	addi	sp,sp,-48
    8000785c:	02813023          	sd	s0,32(sp)
    80007860:	00913c23          	sd	s1,24(sp)
    80007864:	01213823          	sd	s2,16(sp)
    80007868:	01313423          	sd	s3,8(sp)
    8000786c:	02113423          	sd	ra,40(sp)
    80007870:	03010413          	addi	s0,sp,48
    80007874:	00004917          	auipc	s2,0x4
    80007878:	f0c90913          	addi	s2,s2,-244 # 8000b780 <uart_tx_r>
    8000787c:	00093783          	ld	a5,0(s2)
    80007880:	00004497          	auipc	s1,0x4
    80007884:	f0848493          	addi	s1,s1,-248 # 8000b788 <uart_tx_w>
    80007888:	0004b703          	ld	a4,0(s1)
    8000788c:	02078693          	addi	a3,a5,32
    80007890:	00050993          	mv	s3,a0
    80007894:	02e69c63          	bne	a3,a4,800078cc <uartputc+0x84>
    80007898:	00001097          	auipc	ra,0x1
    8000789c:	834080e7          	jalr	-1996(ra) # 800080cc <push_on>
    800078a0:	00093783          	ld	a5,0(s2)
    800078a4:	0004b703          	ld	a4,0(s1)
    800078a8:	02078793          	addi	a5,a5,32
    800078ac:	00e79463          	bne	a5,a4,800078b4 <uartputc+0x6c>
    800078b0:	0000006f          	j	800078b0 <uartputc+0x68>
    800078b4:	00001097          	auipc	ra,0x1
    800078b8:	88c080e7          	jalr	-1908(ra) # 80008140 <pop_on>
    800078bc:	00093783          	ld	a5,0(s2)
    800078c0:	0004b703          	ld	a4,0(s1)
    800078c4:	02078693          	addi	a3,a5,32
    800078c8:	fce688e3          	beq	a3,a4,80007898 <uartputc+0x50>
    800078cc:	01f77693          	andi	a3,a4,31
    800078d0:	00005597          	auipc	a1,0x5
    800078d4:	1d058593          	addi	a1,a1,464 # 8000caa0 <uart_tx_buf>
    800078d8:	00d586b3          	add	a3,a1,a3
    800078dc:	00170713          	addi	a4,a4,1
    800078e0:	01368023          	sb	s3,0(a3)
    800078e4:	00e4b023          	sd	a4,0(s1)
    800078e8:	10000637          	lui	a2,0x10000
    800078ec:	02f71063          	bne	a4,a5,8000790c <uartputc+0xc4>
    800078f0:	0340006f          	j	80007924 <uartputc+0xdc>
    800078f4:	00074703          	lbu	a4,0(a4)
    800078f8:	00f93023          	sd	a5,0(s2)
    800078fc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80007900:	00093783          	ld	a5,0(s2)
    80007904:	0004b703          	ld	a4,0(s1)
    80007908:	00f70e63          	beq	a4,a5,80007924 <uartputc+0xdc>
    8000790c:	00564683          	lbu	a3,5(a2)
    80007910:	01f7f713          	andi	a4,a5,31
    80007914:	00e58733          	add	a4,a1,a4
    80007918:	0206f693          	andi	a3,a3,32
    8000791c:	00178793          	addi	a5,a5,1
    80007920:	fc069ae3          	bnez	a3,800078f4 <uartputc+0xac>
    80007924:	02813083          	ld	ra,40(sp)
    80007928:	02013403          	ld	s0,32(sp)
    8000792c:	01813483          	ld	s1,24(sp)
    80007930:	01013903          	ld	s2,16(sp)
    80007934:	00813983          	ld	s3,8(sp)
    80007938:	03010113          	addi	sp,sp,48
    8000793c:	00008067          	ret

0000000080007940 <uartputc_sync>:
    80007940:	ff010113          	addi	sp,sp,-16
    80007944:	00813423          	sd	s0,8(sp)
    80007948:	01010413          	addi	s0,sp,16
    8000794c:	00004717          	auipc	a4,0x4
    80007950:	e2c72703          	lw	a4,-468(a4) # 8000b778 <panicked>
    80007954:	02071663          	bnez	a4,80007980 <uartputc_sync+0x40>
    80007958:	00050793          	mv	a5,a0
    8000795c:	100006b7          	lui	a3,0x10000
    80007960:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80007964:	02077713          	andi	a4,a4,32
    80007968:	fe070ce3          	beqz	a4,80007960 <uartputc_sync+0x20>
    8000796c:	0ff7f793          	andi	a5,a5,255
    80007970:	00f68023          	sb	a5,0(a3)
    80007974:	00813403          	ld	s0,8(sp)
    80007978:	01010113          	addi	sp,sp,16
    8000797c:	00008067          	ret
    80007980:	0000006f          	j	80007980 <uartputc_sync+0x40>

0000000080007984 <uartstart>:
    80007984:	ff010113          	addi	sp,sp,-16
    80007988:	00813423          	sd	s0,8(sp)
    8000798c:	01010413          	addi	s0,sp,16
    80007990:	00004617          	auipc	a2,0x4
    80007994:	df060613          	addi	a2,a2,-528 # 8000b780 <uart_tx_r>
    80007998:	00004517          	auipc	a0,0x4
    8000799c:	df050513          	addi	a0,a0,-528 # 8000b788 <uart_tx_w>
    800079a0:	00063783          	ld	a5,0(a2)
    800079a4:	00053703          	ld	a4,0(a0)
    800079a8:	04f70263          	beq	a4,a5,800079ec <uartstart+0x68>
    800079ac:	100005b7          	lui	a1,0x10000
    800079b0:	00005817          	auipc	a6,0x5
    800079b4:	0f080813          	addi	a6,a6,240 # 8000caa0 <uart_tx_buf>
    800079b8:	01c0006f          	j	800079d4 <uartstart+0x50>
    800079bc:	0006c703          	lbu	a4,0(a3)
    800079c0:	00f63023          	sd	a5,0(a2)
    800079c4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800079c8:	00063783          	ld	a5,0(a2)
    800079cc:	00053703          	ld	a4,0(a0)
    800079d0:	00f70e63          	beq	a4,a5,800079ec <uartstart+0x68>
    800079d4:	01f7f713          	andi	a4,a5,31
    800079d8:	00e806b3          	add	a3,a6,a4
    800079dc:	0055c703          	lbu	a4,5(a1)
    800079e0:	00178793          	addi	a5,a5,1
    800079e4:	02077713          	andi	a4,a4,32
    800079e8:	fc071ae3          	bnez	a4,800079bc <uartstart+0x38>
    800079ec:	00813403          	ld	s0,8(sp)
    800079f0:	01010113          	addi	sp,sp,16
    800079f4:	00008067          	ret

00000000800079f8 <uartgetc>:
    800079f8:	ff010113          	addi	sp,sp,-16
    800079fc:	00813423          	sd	s0,8(sp)
    80007a00:	01010413          	addi	s0,sp,16
    80007a04:	10000737          	lui	a4,0x10000
    80007a08:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80007a0c:	0017f793          	andi	a5,a5,1
    80007a10:	00078c63          	beqz	a5,80007a28 <uartgetc+0x30>
    80007a14:	00074503          	lbu	a0,0(a4)
    80007a18:	0ff57513          	andi	a0,a0,255
    80007a1c:	00813403          	ld	s0,8(sp)
    80007a20:	01010113          	addi	sp,sp,16
    80007a24:	00008067          	ret
    80007a28:	fff00513          	li	a0,-1
    80007a2c:	ff1ff06f          	j	80007a1c <uartgetc+0x24>

0000000080007a30 <uartintr>:
    80007a30:	100007b7          	lui	a5,0x10000
    80007a34:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80007a38:	0017f793          	andi	a5,a5,1
    80007a3c:	0a078463          	beqz	a5,80007ae4 <uartintr+0xb4>
    80007a40:	fe010113          	addi	sp,sp,-32
    80007a44:	00813823          	sd	s0,16(sp)
    80007a48:	00913423          	sd	s1,8(sp)
    80007a4c:	00113c23          	sd	ra,24(sp)
    80007a50:	02010413          	addi	s0,sp,32
    80007a54:	100004b7          	lui	s1,0x10000
    80007a58:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80007a5c:	0ff57513          	andi	a0,a0,255
    80007a60:	fffff097          	auipc	ra,0xfffff
    80007a64:	534080e7          	jalr	1332(ra) # 80006f94 <consoleintr>
    80007a68:	0054c783          	lbu	a5,5(s1)
    80007a6c:	0017f793          	andi	a5,a5,1
    80007a70:	fe0794e3          	bnez	a5,80007a58 <uartintr+0x28>
    80007a74:	00004617          	auipc	a2,0x4
    80007a78:	d0c60613          	addi	a2,a2,-756 # 8000b780 <uart_tx_r>
    80007a7c:	00004517          	auipc	a0,0x4
    80007a80:	d0c50513          	addi	a0,a0,-756 # 8000b788 <uart_tx_w>
    80007a84:	00063783          	ld	a5,0(a2)
    80007a88:	00053703          	ld	a4,0(a0)
    80007a8c:	04f70263          	beq	a4,a5,80007ad0 <uartintr+0xa0>
    80007a90:	100005b7          	lui	a1,0x10000
    80007a94:	00005817          	auipc	a6,0x5
    80007a98:	00c80813          	addi	a6,a6,12 # 8000caa0 <uart_tx_buf>
    80007a9c:	01c0006f          	j	80007ab8 <uartintr+0x88>
    80007aa0:	0006c703          	lbu	a4,0(a3)
    80007aa4:	00f63023          	sd	a5,0(a2)
    80007aa8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007aac:	00063783          	ld	a5,0(a2)
    80007ab0:	00053703          	ld	a4,0(a0)
    80007ab4:	00f70e63          	beq	a4,a5,80007ad0 <uartintr+0xa0>
    80007ab8:	01f7f713          	andi	a4,a5,31
    80007abc:	00e806b3          	add	a3,a6,a4
    80007ac0:	0055c703          	lbu	a4,5(a1)
    80007ac4:	00178793          	addi	a5,a5,1
    80007ac8:	02077713          	andi	a4,a4,32
    80007acc:	fc071ae3          	bnez	a4,80007aa0 <uartintr+0x70>
    80007ad0:	01813083          	ld	ra,24(sp)
    80007ad4:	01013403          	ld	s0,16(sp)
    80007ad8:	00813483          	ld	s1,8(sp)
    80007adc:	02010113          	addi	sp,sp,32
    80007ae0:	00008067          	ret
    80007ae4:	00004617          	auipc	a2,0x4
    80007ae8:	c9c60613          	addi	a2,a2,-868 # 8000b780 <uart_tx_r>
    80007aec:	00004517          	auipc	a0,0x4
    80007af0:	c9c50513          	addi	a0,a0,-868 # 8000b788 <uart_tx_w>
    80007af4:	00063783          	ld	a5,0(a2)
    80007af8:	00053703          	ld	a4,0(a0)
    80007afc:	04f70263          	beq	a4,a5,80007b40 <uartintr+0x110>
    80007b00:	100005b7          	lui	a1,0x10000
    80007b04:	00005817          	auipc	a6,0x5
    80007b08:	f9c80813          	addi	a6,a6,-100 # 8000caa0 <uart_tx_buf>
    80007b0c:	01c0006f          	j	80007b28 <uartintr+0xf8>
    80007b10:	0006c703          	lbu	a4,0(a3)
    80007b14:	00f63023          	sd	a5,0(a2)
    80007b18:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007b1c:	00063783          	ld	a5,0(a2)
    80007b20:	00053703          	ld	a4,0(a0)
    80007b24:	02f70063          	beq	a4,a5,80007b44 <uartintr+0x114>
    80007b28:	01f7f713          	andi	a4,a5,31
    80007b2c:	00e806b3          	add	a3,a6,a4
    80007b30:	0055c703          	lbu	a4,5(a1)
    80007b34:	00178793          	addi	a5,a5,1
    80007b38:	02077713          	andi	a4,a4,32
    80007b3c:	fc071ae3          	bnez	a4,80007b10 <uartintr+0xe0>
    80007b40:	00008067          	ret
    80007b44:	00008067          	ret

0000000080007b48 <kinit>:
    80007b48:	fc010113          	addi	sp,sp,-64
    80007b4c:	02913423          	sd	s1,40(sp)
    80007b50:	fffff7b7          	lui	a5,0xfffff
    80007b54:	00006497          	auipc	s1,0x6
    80007b58:	f6b48493          	addi	s1,s1,-149 # 8000dabf <end+0xfff>
    80007b5c:	02813823          	sd	s0,48(sp)
    80007b60:	01313c23          	sd	s3,24(sp)
    80007b64:	00f4f4b3          	and	s1,s1,a5
    80007b68:	02113c23          	sd	ra,56(sp)
    80007b6c:	03213023          	sd	s2,32(sp)
    80007b70:	01413823          	sd	s4,16(sp)
    80007b74:	01513423          	sd	s5,8(sp)
    80007b78:	04010413          	addi	s0,sp,64
    80007b7c:	000017b7          	lui	a5,0x1
    80007b80:	01100993          	li	s3,17
    80007b84:	00f487b3          	add	a5,s1,a5
    80007b88:	01b99993          	slli	s3,s3,0x1b
    80007b8c:	06f9e063          	bltu	s3,a5,80007bec <kinit+0xa4>
    80007b90:	00005a97          	auipc	s5,0x5
    80007b94:	f30a8a93          	addi	s5,s5,-208 # 8000cac0 <end>
    80007b98:	0754ec63          	bltu	s1,s5,80007c10 <kinit+0xc8>
    80007b9c:	0734fa63          	bgeu	s1,s3,80007c10 <kinit+0xc8>
    80007ba0:	00088a37          	lui	s4,0x88
    80007ba4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80007ba8:	00004917          	auipc	s2,0x4
    80007bac:	be890913          	addi	s2,s2,-1048 # 8000b790 <kmem>
    80007bb0:	00ca1a13          	slli	s4,s4,0xc
    80007bb4:	0140006f          	j	80007bc8 <kinit+0x80>
    80007bb8:	000017b7          	lui	a5,0x1
    80007bbc:	00f484b3          	add	s1,s1,a5
    80007bc0:	0554e863          	bltu	s1,s5,80007c10 <kinit+0xc8>
    80007bc4:	0534f663          	bgeu	s1,s3,80007c10 <kinit+0xc8>
    80007bc8:	00001637          	lui	a2,0x1
    80007bcc:	00100593          	li	a1,1
    80007bd0:	00048513          	mv	a0,s1
    80007bd4:	00000097          	auipc	ra,0x0
    80007bd8:	5e4080e7          	jalr	1508(ra) # 800081b8 <__memset>
    80007bdc:	00093783          	ld	a5,0(s2)
    80007be0:	00f4b023          	sd	a5,0(s1)
    80007be4:	00993023          	sd	s1,0(s2)
    80007be8:	fd4498e3          	bne	s1,s4,80007bb8 <kinit+0x70>
    80007bec:	03813083          	ld	ra,56(sp)
    80007bf0:	03013403          	ld	s0,48(sp)
    80007bf4:	02813483          	ld	s1,40(sp)
    80007bf8:	02013903          	ld	s2,32(sp)
    80007bfc:	01813983          	ld	s3,24(sp)
    80007c00:	01013a03          	ld	s4,16(sp)
    80007c04:	00813a83          	ld	s5,8(sp)
    80007c08:	04010113          	addi	sp,sp,64
    80007c0c:	00008067          	ret
    80007c10:	00002517          	auipc	a0,0x2
    80007c14:	a5850513          	addi	a0,a0,-1448 # 80009668 <digits+0x18>
    80007c18:	fffff097          	auipc	ra,0xfffff
    80007c1c:	4b4080e7          	jalr	1204(ra) # 800070cc <panic>

0000000080007c20 <freerange>:
    80007c20:	fc010113          	addi	sp,sp,-64
    80007c24:	000017b7          	lui	a5,0x1
    80007c28:	02913423          	sd	s1,40(sp)
    80007c2c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80007c30:	009504b3          	add	s1,a0,s1
    80007c34:	fffff537          	lui	a0,0xfffff
    80007c38:	02813823          	sd	s0,48(sp)
    80007c3c:	02113c23          	sd	ra,56(sp)
    80007c40:	03213023          	sd	s2,32(sp)
    80007c44:	01313c23          	sd	s3,24(sp)
    80007c48:	01413823          	sd	s4,16(sp)
    80007c4c:	01513423          	sd	s5,8(sp)
    80007c50:	01613023          	sd	s6,0(sp)
    80007c54:	04010413          	addi	s0,sp,64
    80007c58:	00a4f4b3          	and	s1,s1,a0
    80007c5c:	00f487b3          	add	a5,s1,a5
    80007c60:	06f5e463          	bltu	a1,a5,80007cc8 <freerange+0xa8>
    80007c64:	00005a97          	auipc	s5,0x5
    80007c68:	e5ca8a93          	addi	s5,s5,-420 # 8000cac0 <end>
    80007c6c:	0954e263          	bltu	s1,s5,80007cf0 <freerange+0xd0>
    80007c70:	01100993          	li	s3,17
    80007c74:	01b99993          	slli	s3,s3,0x1b
    80007c78:	0734fc63          	bgeu	s1,s3,80007cf0 <freerange+0xd0>
    80007c7c:	00058a13          	mv	s4,a1
    80007c80:	00004917          	auipc	s2,0x4
    80007c84:	b1090913          	addi	s2,s2,-1264 # 8000b790 <kmem>
    80007c88:	00002b37          	lui	s6,0x2
    80007c8c:	0140006f          	j	80007ca0 <freerange+0x80>
    80007c90:	000017b7          	lui	a5,0x1
    80007c94:	00f484b3          	add	s1,s1,a5
    80007c98:	0554ec63          	bltu	s1,s5,80007cf0 <freerange+0xd0>
    80007c9c:	0534fa63          	bgeu	s1,s3,80007cf0 <freerange+0xd0>
    80007ca0:	00001637          	lui	a2,0x1
    80007ca4:	00100593          	li	a1,1
    80007ca8:	00048513          	mv	a0,s1
    80007cac:	00000097          	auipc	ra,0x0
    80007cb0:	50c080e7          	jalr	1292(ra) # 800081b8 <__memset>
    80007cb4:	00093703          	ld	a4,0(s2)
    80007cb8:	016487b3          	add	a5,s1,s6
    80007cbc:	00e4b023          	sd	a4,0(s1)
    80007cc0:	00993023          	sd	s1,0(s2)
    80007cc4:	fcfa76e3          	bgeu	s4,a5,80007c90 <freerange+0x70>
    80007cc8:	03813083          	ld	ra,56(sp)
    80007ccc:	03013403          	ld	s0,48(sp)
    80007cd0:	02813483          	ld	s1,40(sp)
    80007cd4:	02013903          	ld	s2,32(sp)
    80007cd8:	01813983          	ld	s3,24(sp)
    80007cdc:	01013a03          	ld	s4,16(sp)
    80007ce0:	00813a83          	ld	s5,8(sp)
    80007ce4:	00013b03          	ld	s6,0(sp)
    80007ce8:	04010113          	addi	sp,sp,64
    80007cec:	00008067          	ret
    80007cf0:	00002517          	auipc	a0,0x2
    80007cf4:	97850513          	addi	a0,a0,-1672 # 80009668 <digits+0x18>
    80007cf8:	fffff097          	auipc	ra,0xfffff
    80007cfc:	3d4080e7          	jalr	980(ra) # 800070cc <panic>

0000000080007d00 <kfree>:
    80007d00:	fe010113          	addi	sp,sp,-32
    80007d04:	00813823          	sd	s0,16(sp)
    80007d08:	00113c23          	sd	ra,24(sp)
    80007d0c:	00913423          	sd	s1,8(sp)
    80007d10:	02010413          	addi	s0,sp,32
    80007d14:	03451793          	slli	a5,a0,0x34
    80007d18:	04079c63          	bnez	a5,80007d70 <kfree+0x70>
    80007d1c:	00005797          	auipc	a5,0x5
    80007d20:	da478793          	addi	a5,a5,-604 # 8000cac0 <end>
    80007d24:	00050493          	mv	s1,a0
    80007d28:	04f56463          	bltu	a0,a5,80007d70 <kfree+0x70>
    80007d2c:	01100793          	li	a5,17
    80007d30:	01b79793          	slli	a5,a5,0x1b
    80007d34:	02f57e63          	bgeu	a0,a5,80007d70 <kfree+0x70>
    80007d38:	00001637          	lui	a2,0x1
    80007d3c:	00100593          	li	a1,1
    80007d40:	00000097          	auipc	ra,0x0
    80007d44:	478080e7          	jalr	1144(ra) # 800081b8 <__memset>
    80007d48:	00004797          	auipc	a5,0x4
    80007d4c:	a4878793          	addi	a5,a5,-1464 # 8000b790 <kmem>
    80007d50:	0007b703          	ld	a4,0(a5)
    80007d54:	01813083          	ld	ra,24(sp)
    80007d58:	01013403          	ld	s0,16(sp)
    80007d5c:	00e4b023          	sd	a4,0(s1)
    80007d60:	0097b023          	sd	s1,0(a5)
    80007d64:	00813483          	ld	s1,8(sp)
    80007d68:	02010113          	addi	sp,sp,32
    80007d6c:	00008067          	ret
    80007d70:	00002517          	auipc	a0,0x2
    80007d74:	8f850513          	addi	a0,a0,-1800 # 80009668 <digits+0x18>
    80007d78:	fffff097          	auipc	ra,0xfffff
    80007d7c:	354080e7          	jalr	852(ra) # 800070cc <panic>

0000000080007d80 <kalloc>:
    80007d80:	fe010113          	addi	sp,sp,-32
    80007d84:	00813823          	sd	s0,16(sp)
    80007d88:	00913423          	sd	s1,8(sp)
    80007d8c:	00113c23          	sd	ra,24(sp)
    80007d90:	02010413          	addi	s0,sp,32
    80007d94:	00004797          	auipc	a5,0x4
    80007d98:	9fc78793          	addi	a5,a5,-1540 # 8000b790 <kmem>
    80007d9c:	0007b483          	ld	s1,0(a5)
    80007da0:	02048063          	beqz	s1,80007dc0 <kalloc+0x40>
    80007da4:	0004b703          	ld	a4,0(s1)
    80007da8:	00001637          	lui	a2,0x1
    80007dac:	00500593          	li	a1,5
    80007db0:	00048513          	mv	a0,s1
    80007db4:	00e7b023          	sd	a4,0(a5)
    80007db8:	00000097          	auipc	ra,0x0
    80007dbc:	400080e7          	jalr	1024(ra) # 800081b8 <__memset>
    80007dc0:	01813083          	ld	ra,24(sp)
    80007dc4:	01013403          	ld	s0,16(sp)
    80007dc8:	00048513          	mv	a0,s1
    80007dcc:	00813483          	ld	s1,8(sp)
    80007dd0:	02010113          	addi	sp,sp,32
    80007dd4:	00008067          	ret

0000000080007dd8 <initlock>:
    80007dd8:	ff010113          	addi	sp,sp,-16
    80007ddc:	00813423          	sd	s0,8(sp)
    80007de0:	01010413          	addi	s0,sp,16
    80007de4:	00813403          	ld	s0,8(sp)
    80007de8:	00b53423          	sd	a1,8(a0)
    80007dec:	00052023          	sw	zero,0(a0)
    80007df0:	00053823          	sd	zero,16(a0)
    80007df4:	01010113          	addi	sp,sp,16
    80007df8:	00008067          	ret

0000000080007dfc <acquire>:
    80007dfc:	fe010113          	addi	sp,sp,-32
    80007e00:	00813823          	sd	s0,16(sp)
    80007e04:	00913423          	sd	s1,8(sp)
    80007e08:	00113c23          	sd	ra,24(sp)
    80007e0c:	01213023          	sd	s2,0(sp)
    80007e10:	02010413          	addi	s0,sp,32
    80007e14:	00050493          	mv	s1,a0
    80007e18:	10002973          	csrr	s2,sstatus
    80007e1c:	100027f3          	csrr	a5,sstatus
    80007e20:	ffd7f793          	andi	a5,a5,-3
    80007e24:	10079073          	csrw	sstatus,a5
    80007e28:	fffff097          	auipc	ra,0xfffff
    80007e2c:	8e4080e7          	jalr	-1820(ra) # 8000670c <mycpu>
    80007e30:	07852783          	lw	a5,120(a0)
    80007e34:	06078e63          	beqz	a5,80007eb0 <acquire+0xb4>
    80007e38:	fffff097          	auipc	ra,0xfffff
    80007e3c:	8d4080e7          	jalr	-1836(ra) # 8000670c <mycpu>
    80007e40:	07852783          	lw	a5,120(a0)
    80007e44:	0004a703          	lw	a4,0(s1)
    80007e48:	0017879b          	addiw	a5,a5,1
    80007e4c:	06f52c23          	sw	a5,120(a0)
    80007e50:	04071063          	bnez	a4,80007e90 <acquire+0x94>
    80007e54:	00100713          	li	a4,1
    80007e58:	00070793          	mv	a5,a4
    80007e5c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80007e60:	0007879b          	sext.w	a5,a5
    80007e64:	fe079ae3          	bnez	a5,80007e58 <acquire+0x5c>
    80007e68:	0ff0000f          	fence
    80007e6c:	fffff097          	auipc	ra,0xfffff
    80007e70:	8a0080e7          	jalr	-1888(ra) # 8000670c <mycpu>
    80007e74:	01813083          	ld	ra,24(sp)
    80007e78:	01013403          	ld	s0,16(sp)
    80007e7c:	00a4b823          	sd	a0,16(s1)
    80007e80:	00013903          	ld	s2,0(sp)
    80007e84:	00813483          	ld	s1,8(sp)
    80007e88:	02010113          	addi	sp,sp,32
    80007e8c:	00008067          	ret
    80007e90:	0104b903          	ld	s2,16(s1)
    80007e94:	fffff097          	auipc	ra,0xfffff
    80007e98:	878080e7          	jalr	-1928(ra) # 8000670c <mycpu>
    80007e9c:	faa91ce3          	bne	s2,a0,80007e54 <acquire+0x58>
    80007ea0:	00001517          	auipc	a0,0x1
    80007ea4:	7d050513          	addi	a0,a0,2000 # 80009670 <digits+0x20>
    80007ea8:	fffff097          	auipc	ra,0xfffff
    80007eac:	224080e7          	jalr	548(ra) # 800070cc <panic>
    80007eb0:	00195913          	srli	s2,s2,0x1
    80007eb4:	fffff097          	auipc	ra,0xfffff
    80007eb8:	858080e7          	jalr	-1960(ra) # 8000670c <mycpu>
    80007ebc:	00197913          	andi	s2,s2,1
    80007ec0:	07252e23          	sw	s2,124(a0)
    80007ec4:	f75ff06f          	j	80007e38 <acquire+0x3c>

0000000080007ec8 <release>:
    80007ec8:	fe010113          	addi	sp,sp,-32
    80007ecc:	00813823          	sd	s0,16(sp)
    80007ed0:	00113c23          	sd	ra,24(sp)
    80007ed4:	00913423          	sd	s1,8(sp)
    80007ed8:	01213023          	sd	s2,0(sp)
    80007edc:	02010413          	addi	s0,sp,32
    80007ee0:	00052783          	lw	a5,0(a0)
    80007ee4:	00079a63          	bnez	a5,80007ef8 <release+0x30>
    80007ee8:	00001517          	auipc	a0,0x1
    80007eec:	79050513          	addi	a0,a0,1936 # 80009678 <digits+0x28>
    80007ef0:	fffff097          	auipc	ra,0xfffff
    80007ef4:	1dc080e7          	jalr	476(ra) # 800070cc <panic>
    80007ef8:	01053903          	ld	s2,16(a0)
    80007efc:	00050493          	mv	s1,a0
    80007f00:	fffff097          	auipc	ra,0xfffff
    80007f04:	80c080e7          	jalr	-2036(ra) # 8000670c <mycpu>
    80007f08:	fea910e3          	bne	s2,a0,80007ee8 <release+0x20>
    80007f0c:	0004b823          	sd	zero,16(s1)
    80007f10:	0ff0000f          	fence
    80007f14:	0f50000f          	fence	iorw,ow
    80007f18:	0804a02f          	amoswap.w	zero,zero,(s1)
    80007f1c:	ffffe097          	auipc	ra,0xffffe
    80007f20:	7f0080e7          	jalr	2032(ra) # 8000670c <mycpu>
    80007f24:	100027f3          	csrr	a5,sstatus
    80007f28:	0027f793          	andi	a5,a5,2
    80007f2c:	04079a63          	bnez	a5,80007f80 <release+0xb8>
    80007f30:	07852783          	lw	a5,120(a0)
    80007f34:	02f05e63          	blez	a5,80007f70 <release+0xa8>
    80007f38:	fff7871b          	addiw	a4,a5,-1
    80007f3c:	06e52c23          	sw	a4,120(a0)
    80007f40:	00071c63          	bnez	a4,80007f58 <release+0x90>
    80007f44:	07c52783          	lw	a5,124(a0)
    80007f48:	00078863          	beqz	a5,80007f58 <release+0x90>
    80007f4c:	100027f3          	csrr	a5,sstatus
    80007f50:	0027e793          	ori	a5,a5,2
    80007f54:	10079073          	csrw	sstatus,a5
    80007f58:	01813083          	ld	ra,24(sp)
    80007f5c:	01013403          	ld	s0,16(sp)
    80007f60:	00813483          	ld	s1,8(sp)
    80007f64:	00013903          	ld	s2,0(sp)
    80007f68:	02010113          	addi	sp,sp,32
    80007f6c:	00008067          	ret
    80007f70:	00001517          	auipc	a0,0x1
    80007f74:	72850513          	addi	a0,a0,1832 # 80009698 <digits+0x48>
    80007f78:	fffff097          	auipc	ra,0xfffff
    80007f7c:	154080e7          	jalr	340(ra) # 800070cc <panic>
    80007f80:	00001517          	auipc	a0,0x1
    80007f84:	70050513          	addi	a0,a0,1792 # 80009680 <digits+0x30>
    80007f88:	fffff097          	auipc	ra,0xfffff
    80007f8c:	144080e7          	jalr	324(ra) # 800070cc <panic>

0000000080007f90 <holding>:
    80007f90:	00052783          	lw	a5,0(a0)
    80007f94:	00079663          	bnez	a5,80007fa0 <holding+0x10>
    80007f98:	00000513          	li	a0,0
    80007f9c:	00008067          	ret
    80007fa0:	fe010113          	addi	sp,sp,-32
    80007fa4:	00813823          	sd	s0,16(sp)
    80007fa8:	00913423          	sd	s1,8(sp)
    80007fac:	00113c23          	sd	ra,24(sp)
    80007fb0:	02010413          	addi	s0,sp,32
    80007fb4:	01053483          	ld	s1,16(a0)
    80007fb8:	ffffe097          	auipc	ra,0xffffe
    80007fbc:	754080e7          	jalr	1876(ra) # 8000670c <mycpu>
    80007fc0:	01813083          	ld	ra,24(sp)
    80007fc4:	01013403          	ld	s0,16(sp)
    80007fc8:	40a48533          	sub	a0,s1,a0
    80007fcc:	00153513          	seqz	a0,a0
    80007fd0:	00813483          	ld	s1,8(sp)
    80007fd4:	02010113          	addi	sp,sp,32
    80007fd8:	00008067          	ret

0000000080007fdc <push_off>:
    80007fdc:	fe010113          	addi	sp,sp,-32
    80007fe0:	00813823          	sd	s0,16(sp)
    80007fe4:	00113c23          	sd	ra,24(sp)
    80007fe8:	00913423          	sd	s1,8(sp)
    80007fec:	02010413          	addi	s0,sp,32
    80007ff0:	100024f3          	csrr	s1,sstatus
    80007ff4:	100027f3          	csrr	a5,sstatus
    80007ff8:	ffd7f793          	andi	a5,a5,-3
    80007ffc:	10079073          	csrw	sstatus,a5
    80008000:	ffffe097          	auipc	ra,0xffffe
    80008004:	70c080e7          	jalr	1804(ra) # 8000670c <mycpu>
    80008008:	07852783          	lw	a5,120(a0)
    8000800c:	02078663          	beqz	a5,80008038 <push_off+0x5c>
    80008010:	ffffe097          	auipc	ra,0xffffe
    80008014:	6fc080e7          	jalr	1788(ra) # 8000670c <mycpu>
    80008018:	07852783          	lw	a5,120(a0)
    8000801c:	01813083          	ld	ra,24(sp)
    80008020:	01013403          	ld	s0,16(sp)
    80008024:	0017879b          	addiw	a5,a5,1
    80008028:	06f52c23          	sw	a5,120(a0)
    8000802c:	00813483          	ld	s1,8(sp)
    80008030:	02010113          	addi	sp,sp,32
    80008034:	00008067          	ret
    80008038:	0014d493          	srli	s1,s1,0x1
    8000803c:	ffffe097          	auipc	ra,0xffffe
    80008040:	6d0080e7          	jalr	1744(ra) # 8000670c <mycpu>
    80008044:	0014f493          	andi	s1,s1,1
    80008048:	06952e23          	sw	s1,124(a0)
    8000804c:	fc5ff06f          	j	80008010 <push_off+0x34>

0000000080008050 <pop_off>:
    80008050:	ff010113          	addi	sp,sp,-16
    80008054:	00813023          	sd	s0,0(sp)
    80008058:	00113423          	sd	ra,8(sp)
    8000805c:	01010413          	addi	s0,sp,16
    80008060:	ffffe097          	auipc	ra,0xffffe
    80008064:	6ac080e7          	jalr	1708(ra) # 8000670c <mycpu>
    80008068:	100027f3          	csrr	a5,sstatus
    8000806c:	0027f793          	andi	a5,a5,2
    80008070:	04079663          	bnez	a5,800080bc <pop_off+0x6c>
    80008074:	07852783          	lw	a5,120(a0)
    80008078:	02f05a63          	blez	a5,800080ac <pop_off+0x5c>
    8000807c:	fff7871b          	addiw	a4,a5,-1
    80008080:	06e52c23          	sw	a4,120(a0)
    80008084:	00071c63          	bnez	a4,8000809c <pop_off+0x4c>
    80008088:	07c52783          	lw	a5,124(a0)
    8000808c:	00078863          	beqz	a5,8000809c <pop_off+0x4c>
    80008090:	100027f3          	csrr	a5,sstatus
    80008094:	0027e793          	ori	a5,a5,2
    80008098:	10079073          	csrw	sstatus,a5
    8000809c:	00813083          	ld	ra,8(sp)
    800080a0:	00013403          	ld	s0,0(sp)
    800080a4:	01010113          	addi	sp,sp,16
    800080a8:	00008067          	ret
    800080ac:	00001517          	auipc	a0,0x1
    800080b0:	5ec50513          	addi	a0,a0,1516 # 80009698 <digits+0x48>
    800080b4:	fffff097          	auipc	ra,0xfffff
    800080b8:	018080e7          	jalr	24(ra) # 800070cc <panic>
    800080bc:	00001517          	auipc	a0,0x1
    800080c0:	5c450513          	addi	a0,a0,1476 # 80009680 <digits+0x30>
    800080c4:	fffff097          	auipc	ra,0xfffff
    800080c8:	008080e7          	jalr	8(ra) # 800070cc <panic>

00000000800080cc <push_on>:
    800080cc:	fe010113          	addi	sp,sp,-32
    800080d0:	00813823          	sd	s0,16(sp)
    800080d4:	00113c23          	sd	ra,24(sp)
    800080d8:	00913423          	sd	s1,8(sp)
    800080dc:	02010413          	addi	s0,sp,32
    800080e0:	100024f3          	csrr	s1,sstatus
    800080e4:	100027f3          	csrr	a5,sstatus
    800080e8:	0027e793          	ori	a5,a5,2
    800080ec:	10079073          	csrw	sstatus,a5
    800080f0:	ffffe097          	auipc	ra,0xffffe
    800080f4:	61c080e7          	jalr	1564(ra) # 8000670c <mycpu>
    800080f8:	07852783          	lw	a5,120(a0)
    800080fc:	02078663          	beqz	a5,80008128 <push_on+0x5c>
    80008100:	ffffe097          	auipc	ra,0xffffe
    80008104:	60c080e7          	jalr	1548(ra) # 8000670c <mycpu>
    80008108:	07852783          	lw	a5,120(a0)
    8000810c:	01813083          	ld	ra,24(sp)
    80008110:	01013403          	ld	s0,16(sp)
    80008114:	0017879b          	addiw	a5,a5,1
    80008118:	06f52c23          	sw	a5,120(a0)
    8000811c:	00813483          	ld	s1,8(sp)
    80008120:	02010113          	addi	sp,sp,32
    80008124:	00008067          	ret
    80008128:	0014d493          	srli	s1,s1,0x1
    8000812c:	ffffe097          	auipc	ra,0xffffe
    80008130:	5e0080e7          	jalr	1504(ra) # 8000670c <mycpu>
    80008134:	0014f493          	andi	s1,s1,1
    80008138:	06952e23          	sw	s1,124(a0)
    8000813c:	fc5ff06f          	j	80008100 <push_on+0x34>

0000000080008140 <pop_on>:
    80008140:	ff010113          	addi	sp,sp,-16
    80008144:	00813023          	sd	s0,0(sp)
    80008148:	00113423          	sd	ra,8(sp)
    8000814c:	01010413          	addi	s0,sp,16
    80008150:	ffffe097          	auipc	ra,0xffffe
    80008154:	5bc080e7          	jalr	1468(ra) # 8000670c <mycpu>
    80008158:	100027f3          	csrr	a5,sstatus
    8000815c:	0027f793          	andi	a5,a5,2
    80008160:	04078463          	beqz	a5,800081a8 <pop_on+0x68>
    80008164:	07852783          	lw	a5,120(a0)
    80008168:	02f05863          	blez	a5,80008198 <pop_on+0x58>
    8000816c:	fff7879b          	addiw	a5,a5,-1
    80008170:	06f52c23          	sw	a5,120(a0)
    80008174:	07853783          	ld	a5,120(a0)
    80008178:	00079863          	bnez	a5,80008188 <pop_on+0x48>
    8000817c:	100027f3          	csrr	a5,sstatus
    80008180:	ffd7f793          	andi	a5,a5,-3
    80008184:	10079073          	csrw	sstatus,a5
    80008188:	00813083          	ld	ra,8(sp)
    8000818c:	00013403          	ld	s0,0(sp)
    80008190:	01010113          	addi	sp,sp,16
    80008194:	00008067          	ret
    80008198:	00001517          	auipc	a0,0x1
    8000819c:	52850513          	addi	a0,a0,1320 # 800096c0 <digits+0x70>
    800081a0:	fffff097          	auipc	ra,0xfffff
    800081a4:	f2c080e7          	jalr	-212(ra) # 800070cc <panic>
    800081a8:	00001517          	auipc	a0,0x1
    800081ac:	4f850513          	addi	a0,a0,1272 # 800096a0 <digits+0x50>
    800081b0:	fffff097          	auipc	ra,0xfffff
    800081b4:	f1c080e7          	jalr	-228(ra) # 800070cc <panic>

00000000800081b8 <__memset>:
    800081b8:	ff010113          	addi	sp,sp,-16
    800081bc:	00813423          	sd	s0,8(sp)
    800081c0:	01010413          	addi	s0,sp,16
    800081c4:	1a060e63          	beqz	a2,80008380 <__memset+0x1c8>
    800081c8:	40a007b3          	neg	a5,a0
    800081cc:	0077f793          	andi	a5,a5,7
    800081d0:	00778693          	addi	a3,a5,7
    800081d4:	00b00813          	li	a6,11
    800081d8:	0ff5f593          	andi	a1,a1,255
    800081dc:	fff6071b          	addiw	a4,a2,-1
    800081e0:	1b06e663          	bltu	a3,a6,8000838c <__memset+0x1d4>
    800081e4:	1cd76463          	bltu	a4,a3,800083ac <__memset+0x1f4>
    800081e8:	1a078e63          	beqz	a5,800083a4 <__memset+0x1ec>
    800081ec:	00b50023          	sb	a1,0(a0)
    800081f0:	00100713          	li	a4,1
    800081f4:	1ae78463          	beq	a5,a4,8000839c <__memset+0x1e4>
    800081f8:	00b500a3          	sb	a1,1(a0)
    800081fc:	00200713          	li	a4,2
    80008200:	1ae78a63          	beq	a5,a4,800083b4 <__memset+0x1fc>
    80008204:	00b50123          	sb	a1,2(a0)
    80008208:	00300713          	li	a4,3
    8000820c:	18e78463          	beq	a5,a4,80008394 <__memset+0x1dc>
    80008210:	00b501a3          	sb	a1,3(a0)
    80008214:	00400713          	li	a4,4
    80008218:	1ae78263          	beq	a5,a4,800083bc <__memset+0x204>
    8000821c:	00b50223          	sb	a1,4(a0)
    80008220:	00500713          	li	a4,5
    80008224:	1ae78063          	beq	a5,a4,800083c4 <__memset+0x20c>
    80008228:	00b502a3          	sb	a1,5(a0)
    8000822c:	00700713          	li	a4,7
    80008230:	18e79e63          	bne	a5,a4,800083cc <__memset+0x214>
    80008234:	00b50323          	sb	a1,6(a0)
    80008238:	00700e93          	li	t4,7
    8000823c:	00859713          	slli	a4,a1,0x8
    80008240:	00e5e733          	or	a4,a1,a4
    80008244:	01059e13          	slli	t3,a1,0x10
    80008248:	01c76e33          	or	t3,a4,t3
    8000824c:	01859313          	slli	t1,a1,0x18
    80008250:	006e6333          	or	t1,t3,t1
    80008254:	02059893          	slli	a7,a1,0x20
    80008258:	40f60e3b          	subw	t3,a2,a5
    8000825c:	011368b3          	or	a7,t1,a7
    80008260:	02859813          	slli	a6,a1,0x28
    80008264:	0108e833          	or	a6,a7,a6
    80008268:	03059693          	slli	a3,a1,0x30
    8000826c:	003e589b          	srliw	a7,t3,0x3
    80008270:	00d866b3          	or	a3,a6,a3
    80008274:	03859713          	slli	a4,a1,0x38
    80008278:	00389813          	slli	a6,a7,0x3
    8000827c:	00f507b3          	add	a5,a0,a5
    80008280:	00e6e733          	or	a4,a3,a4
    80008284:	000e089b          	sext.w	a7,t3
    80008288:	00f806b3          	add	a3,a6,a5
    8000828c:	00e7b023          	sd	a4,0(a5)
    80008290:	00878793          	addi	a5,a5,8
    80008294:	fed79ce3          	bne	a5,a3,8000828c <__memset+0xd4>
    80008298:	ff8e7793          	andi	a5,t3,-8
    8000829c:	0007871b          	sext.w	a4,a5
    800082a0:	01d787bb          	addw	a5,a5,t4
    800082a4:	0ce88e63          	beq	a7,a4,80008380 <__memset+0x1c8>
    800082a8:	00f50733          	add	a4,a0,a5
    800082ac:	00b70023          	sb	a1,0(a4)
    800082b0:	0017871b          	addiw	a4,a5,1
    800082b4:	0cc77663          	bgeu	a4,a2,80008380 <__memset+0x1c8>
    800082b8:	00e50733          	add	a4,a0,a4
    800082bc:	00b70023          	sb	a1,0(a4)
    800082c0:	0027871b          	addiw	a4,a5,2
    800082c4:	0ac77e63          	bgeu	a4,a2,80008380 <__memset+0x1c8>
    800082c8:	00e50733          	add	a4,a0,a4
    800082cc:	00b70023          	sb	a1,0(a4)
    800082d0:	0037871b          	addiw	a4,a5,3
    800082d4:	0ac77663          	bgeu	a4,a2,80008380 <__memset+0x1c8>
    800082d8:	00e50733          	add	a4,a0,a4
    800082dc:	00b70023          	sb	a1,0(a4)
    800082e0:	0047871b          	addiw	a4,a5,4
    800082e4:	08c77e63          	bgeu	a4,a2,80008380 <__memset+0x1c8>
    800082e8:	00e50733          	add	a4,a0,a4
    800082ec:	00b70023          	sb	a1,0(a4)
    800082f0:	0057871b          	addiw	a4,a5,5
    800082f4:	08c77663          	bgeu	a4,a2,80008380 <__memset+0x1c8>
    800082f8:	00e50733          	add	a4,a0,a4
    800082fc:	00b70023          	sb	a1,0(a4)
    80008300:	0067871b          	addiw	a4,a5,6
    80008304:	06c77e63          	bgeu	a4,a2,80008380 <__memset+0x1c8>
    80008308:	00e50733          	add	a4,a0,a4
    8000830c:	00b70023          	sb	a1,0(a4)
    80008310:	0077871b          	addiw	a4,a5,7
    80008314:	06c77663          	bgeu	a4,a2,80008380 <__memset+0x1c8>
    80008318:	00e50733          	add	a4,a0,a4
    8000831c:	00b70023          	sb	a1,0(a4)
    80008320:	0087871b          	addiw	a4,a5,8
    80008324:	04c77e63          	bgeu	a4,a2,80008380 <__memset+0x1c8>
    80008328:	00e50733          	add	a4,a0,a4
    8000832c:	00b70023          	sb	a1,0(a4)
    80008330:	0097871b          	addiw	a4,a5,9
    80008334:	04c77663          	bgeu	a4,a2,80008380 <__memset+0x1c8>
    80008338:	00e50733          	add	a4,a0,a4
    8000833c:	00b70023          	sb	a1,0(a4)
    80008340:	00a7871b          	addiw	a4,a5,10
    80008344:	02c77e63          	bgeu	a4,a2,80008380 <__memset+0x1c8>
    80008348:	00e50733          	add	a4,a0,a4
    8000834c:	00b70023          	sb	a1,0(a4)
    80008350:	00b7871b          	addiw	a4,a5,11
    80008354:	02c77663          	bgeu	a4,a2,80008380 <__memset+0x1c8>
    80008358:	00e50733          	add	a4,a0,a4
    8000835c:	00b70023          	sb	a1,0(a4)
    80008360:	00c7871b          	addiw	a4,a5,12
    80008364:	00c77e63          	bgeu	a4,a2,80008380 <__memset+0x1c8>
    80008368:	00e50733          	add	a4,a0,a4
    8000836c:	00b70023          	sb	a1,0(a4)
    80008370:	00d7879b          	addiw	a5,a5,13
    80008374:	00c7f663          	bgeu	a5,a2,80008380 <__memset+0x1c8>
    80008378:	00f507b3          	add	a5,a0,a5
    8000837c:	00b78023          	sb	a1,0(a5)
    80008380:	00813403          	ld	s0,8(sp)
    80008384:	01010113          	addi	sp,sp,16
    80008388:	00008067          	ret
    8000838c:	00b00693          	li	a3,11
    80008390:	e55ff06f          	j	800081e4 <__memset+0x2c>
    80008394:	00300e93          	li	t4,3
    80008398:	ea5ff06f          	j	8000823c <__memset+0x84>
    8000839c:	00100e93          	li	t4,1
    800083a0:	e9dff06f          	j	8000823c <__memset+0x84>
    800083a4:	00000e93          	li	t4,0
    800083a8:	e95ff06f          	j	8000823c <__memset+0x84>
    800083ac:	00000793          	li	a5,0
    800083b0:	ef9ff06f          	j	800082a8 <__memset+0xf0>
    800083b4:	00200e93          	li	t4,2
    800083b8:	e85ff06f          	j	8000823c <__memset+0x84>
    800083bc:	00400e93          	li	t4,4
    800083c0:	e7dff06f          	j	8000823c <__memset+0x84>
    800083c4:	00500e93          	li	t4,5
    800083c8:	e75ff06f          	j	8000823c <__memset+0x84>
    800083cc:	00600e93          	li	t4,6
    800083d0:	e6dff06f          	j	8000823c <__memset+0x84>

00000000800083d4 <__memmove>:
    800083d4:	ff010113          	addi	sp,sp,-16
    800083d8:	00813423          	sd	s0,8(sp)
    800083dc:	01010413          	addi	s0,sp,16
    800083e0:	0e060863          	beqz	a2,800084d0 <__memmove+0xfc>
    800083e4:	fff6069b          	addiw	a3,a2,-1
    800083e8:	0006881b          	sext.w	a6,a3
    800083ec:	0ea5e863          	bltu	a1,a0,800084dc <__memmove+0x108>
    800083f0:	00758713          	addi	a4,a1,7
    800083f4:	00a5e7b3          	or	a5,a1,a0
    800083f8:	40a70733          	sub	a4,a4,a0
    800083fc:	0077f793          	andi	a5,a5,7
    80008400:	00f73713          	sltiu	a4,a4,15
    80008404:	00174713          	xori	a4,a4,1
    80008408:	0017b793          	seqz	a5,a5
    8000840c:	00e7f7b3          	and	a5,a5,a4
    80008410:	10078863          	beqz	a5,80008520 <__memmove+0x14c>
    80008414:	00900793          	li	a5,9
    80008418:	1107f463          	bgeu	a5,a6,80008520 <__memmove+0x14c>
    8000841c:	0036581b          	srliw	a6,a2,0x3
    80008420:	fff8081b          	addiw	a6,a6,-1
    80008424:	02081813          	slli	a6,a6,0x20
    80008428:	01d85893          	srli	a7,a6,0x1d
    8000842c:	00858813          	addi	a6,a1,8
    80008430:	00058793          	mv	a5,a1
    80008434:	00050713          	mv	a4,a0
    80008438:	01088833          	add	a6,a7,a6
    8000843c:	0007b883          	ld	a7,0(a5)
    80008440:	00878793          	addi	a5,a5,8
    80008444:	00870713          	addi	a4,a4,8
    80008448:	ff173c23          	sd	a7,-8(a4)
    8000844c:	ff0798e3          	bne	a5,a6,8000843c <__memmove+0x68>
    80008450:	ff867713          	andi	a4,a2,-8
    80008454:	02071793          	slli	a5,a4,0x20
    80008458:	0207d793          	srli	a5,a5,0x20
    8000845c:	00f585b3          	add	a1,a1,a5
    80008460:	40e686bb          	subw	a3,a3,a4
    80008464:	00f507b3          	add	a5,a0,a5
    80008468:	06e60463          	beq	a2,a4,800084d0 <__memmove+0xfc>
    8000846c:	0005c703          	lbu	a4,0(a1)
    80008470:	00e78023          	sb	a4,0(a5)
    80008474:	04068e63          	beqz	a3,800084d0 <__memmove+0xfc>
    80008478:	0015c603          	lbu	a2,1(a1)
    8000847c:	00100713          	li	a4,1
    80008480:	00c780a3          	sb	a2,1(a5)
    80008484:	04e68663          	beq	a3,a4,800084d0 <__memmove+0xfc>
    80008488:	0025c603          	lbu	a2,2(a1)
    8000848c:	00200713          	li	a4,2
    80008490:	00c78123          	sb	a2,2(a5)
    80008494:	02e68e63          	beq	a3,a4,800084d0 <__memmove+0xfc>
    80008498:	0035c603          	lbu	a2,3(a1)
    8000849c:	00300713          	li	a4,3
    800084a0:	00c781a3          	sb	a2,3(a5)
    800084a4:	02e68663          	beq	a3,a4,800084d0 <__memmove+0xfc>
    800084a8:	0045c603          	lbu	a2,4(a1)
    800084ac:	00400713          	li	a4,4
    800084b0:	00c78223          	sb	a2,4(a5)
    800084b4:	00e68e63          	beq	a3,a4,800084d0 <__memmove+0xfc>
    800084b8:	0055c603          	lbu	a2,5(a1)
    800084bc:	00500713          	li	a4,5
    800084c0:	00c782a3          	sb	a2,5(a5)
    800084c4:	00e68663          	beq	a3,a4,800084d0 <__memmove+0xfc>
    800084c8:	0065c703          	lbu	a4,6(a1)
    800084cc:	00e78323          	sb	a4,6(a5)
    800084d0:	00813403          	ld	s0,8(sp)
    800084d4:	01010113          	addi	sp,sp,16
    800084d8:	00008067          	ret
    800084dc:	02061713          	slli	a4,a2,0x20
    800084e0:	02075713          	srli	a4,a4,0x20
    800084e4:	00e587b3          	add	a5,a1,a4
    800084e8:	f0f574e3          	bgeu	a0,a5,800083f0 <__memmove+0x1c>
    800084ec:	02069613          	slli	a2,a3,0x20
    800084f0:	02065613          	srli	a2,a2,0x20
    800084f4:	fff64613          	not	a2,a2
    800084f8:	00e50733          	add	a4,a0,a4
    800084fc:	00c78633          	add	a2,a5,a2
    80008500:	fff7c683          	lbu	a3,-1(a5)
    80008504:	fff78793          	addi	a5,a5,-1
    80008508:	fff70713          	addi	a4,a4,-1
    8000850c:	00d70023          	sb	a3,0(a4)
    80008510:	fec798e3          	bne	a5,a2,80008500 <__memmove+0x12c>
    80008514:	00813403          	ld	s0,8(sp)
    80008518:	01010113          	addi	sp,sp,16
    8000851c:	00008067          	ret
    80008520:	02069713          	slli	a4,a3,0x20
    80008524:	02075713          	srli	a4,a4,0x20
    80008528:	00170713          	addi	a4,a4,1
    8000852c:	00e50733          	add	a4,a0,a4
    80008530:	00050793          	mv	a5,a0
    80008534:	0005c683          	lbu	a3,0(a1)
    80008538:	00178793          	addi	a5,a5,1
    8000853c:	00158593          	addi	a1,a1,1
    80008540:	fed78fa3          	sb	a3,-1(a5)
    80008544:	fee798e3          	bne	a5,a4,80008534 <__memmove+0x160>
    80008548:	f89ff06f          	j	800084d0 <__memmove+0xfc>

000000008000854c <__putc>:
    8000854c:	fe010113          	addi	sp,sp,-32
    80008550:	00813823          	sd	s0,16(sp)
    80008554:	00113c23          	sd	ra,24(sp)
    80008558:	02010413          	addi	s0,sp,32
    8000855c:	00050793          	mv	a5,a0
    80008560:	fef40593          	addi	a1,s0,-17
    80008564:	00100613          	li	a2,1
    80008568:	00000513          	li	a0,0
    8000856c:	fef407a3          	sb	a5,-17(s0)
    80008570:	fffff097          	auipc	ra,0xfffff
    80008574:	b3c080e7          	jalr	-1220(ra) # 800070ac <console_write>
    80008578:	01813083          	ld	ra,24(sp)
    8000857c:	01013403          	ld	s0,16(sp)
    80008580:	02010113          	addi	sp,sp,32
    80008584:	00008067          	ret

0000000080008588 <__getc>:
    80008588:	fe010113          	addi	sp,sp,-32
    8000858c:	00813823          	sd	s0,16(sp)
    80008590:	00113c23          	sd	ra,24(sp)
    80008594:	02010413          	addi	s0,sp,32
    80008598:	fe840593          	addi	a1,s0,-24
    8000859c:	00100613          	li	a2,1
    800085a0:	00000513          	li	a0,0
    800085a4:	fffff097          	auipc	ra,0xfffff
    800085a8:	ae8080e7          	jalr	-1304(ra) # 8000708c <console_read>
    800085ac:	fe844503          	lbu	a0,-24(s0)
    800085b0:	01813083          	ld	ra,24(sp)
    800085b4:	01013403          	ld	s0,16(sp)
    800085b8:	02010113          	addi	sp,sp,32
    800085bc:	00008067          	ret

00000000800085c0 <console_handler>:
    800085c0:	fe010113          	addi	sp,sp,-32
    800085c4:	00813823          	sd	s0,16(sp)
    800085c8:	00113c23          	sd	ra,24(sp)
    800085cc:	00913423          	sd	s1,8(sp)
    800085d0:	02010413          	addi	s0,sp,32
    800085d4:	14202773          	csrr	a4,scause
    800085d8:	100027f3          	csrr	a5,sstatus
    800085dc:	0027f793          	andi	a5,a5,2
    800085e0:	06079e63          	bnez	a5,8000865c <console_handler+0x9c>
    800085e4:	00074c63          	bltz	a4,800085fc <console_handler+0x3c>
    800085e8:	01813083          	ld	ra,24(sp)
    800085ec:	01013403          	ld	s0,16(sp)
    800085f0:	00813483          	ld	s1,8(sp)
    800085f4:	02010113          	addi	sp,sp,32
    800085f8:	00008067          	ret
    800085fc:	0ff77713          	andi	a4,a4,255
    80008600:	00900793          	li	a5,9
    80008604:	fef712e3          	bne	a4,a5,800085e8 <console_handler+0x28>
    80008608:	ffffe097          	auipc	ra,0xffffe
    8000860c:	6dc080e7          	jalr	1756(ra) # 80006ce4 <plic_claim>
    80008610:	00a00793          	li	a5,10
    80008614:	00050493          	mv	s1,a0
    80008618:	02f50c63          	beq	a0,a5,80008650 <console_handler+0x90>
    8000861c:	fc0506e3          	beqz	a0,800085e8 <console_handler+0x28>
    80008620:	00050593          	mv	a1,a0
    80008624:	00001517          	auipc	a0,0x1
    80008628:	fa450513          	addi	a0,a0,-92 # 800095c8 <CONSOLE_STATUS+0x5b8>
    8000862c:	fffff097          	auipc	ra,0xfffff
    80008630:	afc080e7          	jalr	-1284(ra) # 80007128 <__printf>
    80008634:	01013403          	ld	s0,16(sp)
    80008638:	01813083          	ld	ra,24(sp)
    8000863c:	00048513          	mv	a0,s1
    80008640:	00813483          	ld	s1,8(sp)
    80008644:	02010113          	addi	sp,sp,32
    80008648:	ffffe317          	auipc	t1,0xffffe
    8000864c:	6d430067          	jr	1748(t1) # 80006d1c <plic_complete>
    80008650:	fffff097          	auipc	ra,0xfffff
    80008654:	3e0080e7          	jalr	992(ra) # 80007a30 <uartintr>
    80008658:	fddff06f          	j	80008634 <console_handler+0x74>
    8000865c:	00001517          	auipc	a0,0x1
    80008660:	06c50513          	addi	a0,a0,108 # 800096c8 <digits+0x78>
    80008664:	fffff097          	auipc	ra,0xfffff
    80008668:	a68080e7          	jalr	-1432(ra) # 800070cc <panic>
	...
