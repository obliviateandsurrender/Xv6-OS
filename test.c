#include "types.h"
#include "user.h"

void 
printnum(const uint num)
{
    if (num % 100 > 9)
        printf(2, "%d.%d\t", num / 100, num % 100);
    else
        printf(2, "%d.%d%d\t", num / 100, 0, num % 100);
}

int 
main(int argc, char *argv[])
{
    int k = 0, n = 20, id = 0;
    int blue = 0, pflag = 0, piflag = -1;
    uint start_time = uptime();
    double x = 0, z, d = 0.007;

    if (argc < 3) {
        n = atoi(argv[1]);
    }
    if (argc < 4) {
        d = atoi(argv[2]);
    }

    if (n < 0) {
        n = 20;
    }

    #ifdef PR_SCHEDULE
    int prior = -1;
    int a[9] = {-4, 3, -2, 1, 0, -1, 2, -3, 4};
    if(!pflag) {
        int t_id = getpid();
        prior = (t_id * 13) % 35 + a[t_id % 9] + 60;
        if (setpriority(t_id, prior) < 0)
        {
            printf(1, "Error: PID not found.\n");
        }
        else
        {
            printf(2, "Updating Priority updated for test id: %d to %d\n", t_id, prior);
        }
    }
    #endif

    for(; k < n;) {
        k += 1;
        z = 0;
        id = fork();
        #ifdef PR_SCHEDULE 
        setpriority(id, prior);
        #endif
        if (id < 0) {
            printf(2, "%d Failed in Fork\n", getpid());
        }
        else if (id) {
            
            if (!pflag) {
                printf(2, "Starting test Id: %d\n", getpid());
                piflag = getpid();
                pflag = 1;
            }
            wait();

        }
        else {
            for (; z < 8000000.0;) {
                x -= 3.14*69.96;
                blue += x*d;
                z += 1*d;
                x += 3.14*71.17;
            }
            break;
        }
    }

    if (piflag == getpid())
    {
        printf(2, "Total time for test id: %d is: ", getpid());
        printnum(uptime() - start_time);
        printf(2, "\n");
    }

    exit();
}
