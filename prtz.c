#include "types.h"
#include "user.h"

int
main(int argc, char *argv[])
{
    int priority, pid;
    char prior[5];

    if (argc != 3) {
        printf(2,"Usage: prtz [PID] [Priority]\n");
        exit();
    }
    if (argv[1][0] == '-') {
        printf(2, "Invalid PID: Must be positive\n");
        exit();
    }
    else{
        pid = atoi(argv[1]);
    }

    if (argv[2][0] == '-') {
        strcpy(prior, argv[2]+sizeof(char));
        priority = -atoi(prior);
    }
    else {
        priority = atoi(argv[2]);
    }

    if (priority < 0 || priority > MAX) {
        printf(2, "Invalid Priority: Allowed values [0-100]\n");
        exit();
    }
    if (setpriority(pid, priority) < 0) {
        printf(2, "Error: PID not found.\n");
    }
    else{
        printf(2, "Done: Priority updated for %d\n", pid);
    };
    exit();
}
