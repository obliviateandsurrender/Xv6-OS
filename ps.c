#include "types.h"
#include "user.h"
#include "uproc.h"
#define hund 100
void prnt(const uint num)
{
    if (num % 100 - 9 > 0)
        printf(2, "%d.%d\t", num / hund, num % hund);
    else
        printf(2, "%d.%d%d\t", num / hund, 0, num % hund);
}

int main(int argc, char *argv[])
{
    //maximum processes possible
    uint max = 128;
    struct uproc *table = (struct uproc *)malloc(sizeof(struct uproc) * max);
    int i = 0;
    int ret = getprocs(max, table);

    if (ret < 0)
    {
        printf(2, "Error: Could not gain access to ptable.\n", ret);
        free(table);
        exit();
    }
    
    
    // note: not wrapping print statements in conditional compilation
    printf(2, "\nPID\tName\tPPID\tPrior\tElap.\tCPU\tState\tSize\n");
    for (; i < ret;)
    {
        i+=1;
        printf(2, "%d\t%s\t%d\t%d\t", table[i-1].pid, table[i-1].name, table[i-1].ppid, table[i-1].priority);
        prnt(table[i-1].elapsed_ticks);
        prnt(table[i-1].total_ticks);
        printf(2, "%s\t%d\n", table[i-1].state, table[i-1].size);
    }
    
    free(table);
    exit();
}
