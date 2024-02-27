<h1> OS1 Projekat </h1>
Cilj ovog projekta jeste realizacija malog, ali sasvim funkcionalnog jezgra operativnog sistema koji podržava niti.
OS jezgro je posebno razvijeno za arhitekturu RISC-V i izvršava se unutar QEMU emulatora. Ne koristi spoljašnje biblioteke, što znači da se ne koriste sistemski pozivi domaćeg operativnog sistema. Umesto toga, sve se implementira od nule, uključujući obradu niti, alokaciju memorije, semafore i prekide.

Cela specifikacija projekta, režimi rada, hijerarhija poziva i slično se može videti u PDF fajlu ili zaključiti iz koda projekta.

U ovom repozitorijumu su odrađeni zadaci 1, 2 i 3.

EN:

The goal of this project is the realization of a small, but fully functional operating system kernel that supports threads.
The OS kernel has been developed specifically for the RISC-V architecture and is executed within the QEMU emulator. It does not rely on any external libraries, which means that it refrains from utilizing system calls provided by the host operating system. Instead, it handles tasks such as threads, memory allocation, semaphores, and interrupts entirely from the ground up.

The entire project specification, operating modes, call hierarchy, and similar details can be seen in the PDF file or inferred from the project's code.

In this repository, tasks 1, 2, and 3 have been completed.


<h3> Neke od komandi za izvrsavanje testova </h3>

- Za pokretanje testova 3 i 4, pokrenuti njihovo izvrsavanje iz Terminala zbog prekida u izvrsavanju preko tastera Esc.
- Za prekid testova koristi se niz komandi: Ctrl+C A Q Enter.
- Test 7 treba da udje u nedozvoljeno stanje, zbog pristupa sistemskom registru iz korisnickog rezima (nit B - asm volatile("csrr t6, sepc")).
