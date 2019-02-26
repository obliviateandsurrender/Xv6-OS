#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "uproc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  //acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      //release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  //release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  //acquire(&tickslock);
  xticks = ticks;
  //release(&tickslock);
  return xticks;
}

int sys_getprocs(void)
{
  struct uproc *table;
  int zi = sizeof(*table);
  int stack_arg;
  //return failure to retrieve arguments
  if (argint(0, &stack_arg) < 0 || argptr(1, (void *)&table, zi) < 0)
    return -1;
  //we're just a wrapper for getprocs() in proc.c
  return getprocs((uint)stack_arg, table);
}

// sets the priority of the calling process
// no list transitions since proc must be in RUNNING
int sys_setpriority(void)
{
  int pid;
  int priority;
  if (argint(0, &pid) < 0 || argint(1, &priority) < 0)
    return -1;

  //access to lists are needed, so call into proc.c
  return setpriority(pid, priority);
}
