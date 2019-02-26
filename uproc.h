#define STRMAX 32

struct uproc
{
    uint pid;
    uint uid;
    uint gid;
    uint ppid;
    uint size;
    uint priority; //prints aren't conditionally compiled, so let's leave this in
    uint elapsed_ticks;
    uint total_ticks;
    uint age;
    char state[STRMAX];
    char name[STRMAX];
};
