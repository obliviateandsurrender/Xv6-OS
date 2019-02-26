#include "types.h"
#include "user.h"
#define zero 0
#define one 1

void printnum(const char *cmd, const uint time)
{
    if (time % 100 - 9 > zero)
        printf(2, "%s ran in %d.%d seconds\n", cmd, time / 100, time % 100);
    else
        printf(2, "%s ran in %d.0%d seconds\n", cmd, time / 100, time % 100);
}

int main(int argc, char *argv[])
{
    uint start_time = uptime();
    int pid = fork();

    if (!pid)
    { //child
        int exec_ret = exec(argv[one], &argv[one]);
        //suppress complaints for null execution
        if (exec_ret < zero && argv[one])
        {
            printf(2, "execution of %s failed\n", argv[1]);
            exit();
        }
    }
    else
    {
        int wait_ret = wait();
        if (wait_ret >= zero)
            printnum(argv[one], uptime() - start_time);
        else
            printf(2, "Error: %s could not be executed", argv[one]);
    }

    exit();
}