# Xv6-OS
## Introduction

**_Specification 1:  Invertcase Command_**

Implement ‘invertcase’ command in xv6. This command takes string arguments and prints out the case inverted string.

**_Eg:_**
```
$ invertcase hello World!
HELLO wORLD!
```

**_Specification 2: Priority Based Scheduling_**

The default scheduler of xv6 is a round-robin based scheduler. Implement a priority-based scheduler to replace the default scheduler.

A priority based scheduler selects the process with highest priority for execution. In case two or more processes have same priority, we choose them in a round robin fashion. The priority of a process can be in the range [0,100]. Smaller value will represent higher priority. Set the default priority of a process as 60.

Implement the syscalls - **ps** and **set_priority.**

- where **ps** prints out the currently running processes names, pids and their
priorities.
- **set_priority** is used to change the priority of a process.

**int set_priority(int)** - is the function declaration to be used while implementing the syscall.

**_Specification 3: System call Tracing_**

Modify the xv6 kernel to print out a line for each system call invocation.

When you're done, you should see output that looks something like this when booting xv6:
```
fork -> 2
exec -> 0
open -> 3
close -> 0
write -> 1
write -> 1
```
The above should work even for regular commands, and display appropriate call tracing
output.

## General Notes:

1. The xv6 OS base code can be downloaded from https://github.com/mit-pdos/xv6-public
2. Whenever you add new files do not forget to add them to the Makefile so that they
    get included in the build.
3. Documentation - [https://pdos.csail.mit.edu/6.828/2011/xv6/book-rev6.pdf](https://pdos.csail.mit.edu/6.828/2011/xv6/book-rev6.pdf)
4. File Docs - [http://www.cse.iitd.ernet.in/~sbansal/os/previous_years/2011/xv6_html/files.html](http://www.cse.iitd.ernet.in/~sbansal/os/previous_years/2011/xv6_html/files.html)

## Information:

1. To enable ​ **Priority Scheduling** ​​ in ​ **xv6** ​​, kindly include the ​ **-DPR_SCHEDULE** ​​ directive in
    the makefile and then run test commands in the background for efficiency estimations.
2. To enable ​ **System Tracing** ​​in​ **xv6,** ​​kindly include the ​ **-DTRACE_SYSCALLS** ​​ directive in
    the makefile.



