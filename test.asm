
_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
        printf(2, "%d.%d%d\t", num / 100, 0, num % 100);
}

int 
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 58             	sub    $0x58,%esp
  14:	8b 31                	mov    (%ecx),%esi
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
    int k = 0, n = 20, id = 0;
    int blue = 0, pflag = 0, piflag = -1;
    uint start_time = uptime();
  19:	e8 7c 05 00 00       	call   59a <uptime>
  1e:	89 45 a0             	mov    %eax,-0x60(%ebp)
    double x = 0, z, d = 0.007;

    if (argc < 3) {
  21:	83 fe 02             	cmp    $0x2,%esi
  24:	0f 8e 8f 01 00 00    	jle    1b9 <main+0x1b9>
        n = atoi(argv[1]);
    }
    if (argc < 4) {
  2a:	83 fe 03             	cmp    $0x3,%esi
  2d:	0f 84 09 02 00 00    	je     23c <main+0x23c>
main(int argc, char *argv[])
{
    int k = 0, n = 20, id = 0;
    int blue = 0, pflag = 0, piflag = -1;
    uint start_time = uptime();
    double x = 0, z, d = 0.007;
  33:	dd 05 28 0a 00 00    	fldl   0xa28
}

int 
main(int argc, char *argv[])
{
    int k = 0, n = 20, id = 0;
  39:	c7 45 b0 14 00 00 00 	movl   $0x14,-0x50(%ebp)
    int blue = 0, pflag = 0, piflag = -1;
    uint start_time = uptime();
    double x = 0, z, d = 0.007;
  40:	dd 5d a8             	fstpl  -0x58(%ebp)
        n = 20;
    }

    #ifdef PR_SCHEDULE
    int prior = -1;
    int a[9] = {-4, 3, -2, 1, 0, -1, 2, -3, 4};
  43:	c7 45 c4 fc ff ff ff 	movl   $0xfffffffc,-0x3c(%ebp)
  4a:	c7 45 c8 03 00 00 00 	movl   $0x3,-0x38(%ebp)
  51:	c7 45 cc fe ff ff ff 	movl   $0xfffffffe,-0x34(%ebp)
  58:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
  5f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  66:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%ebp)
  6d:	c7 45 dc 02 00 00 00 	movl   $0x2,-0x24(%ebp)
  74:	c7 45 e0 fd ff ff ff 	movl   $0xfffffffd,-0x20(%ebp)
  7b:	c7 45 e4 04 00 00 00 	movl   $0x4,-0x1c(%ebp)
    if(!pflag) {
        int t_id = getpid();
  82:	e8 fb 04 00 00       	call   582 <getpid>
  87:	89 c3                	mov    %eax,%ebx
        prior = (t_id * 13) % 35 + a[t_id % 9] + 60;
  89:	8d 04 40             	lea    (%eax,%eax,2),%eax
  8c:	ba eb a0 0e ea       	mov    $0xea0ea0eb,%edx
  91:	89 d9                	mov    %ebx,%ecx
        if (setpriority(t_id, prior) < 0)
  93:	83 ec 08             	sub    $0x8,%esp
    #ifdef PR_SCHEDULE
    int prior = -1;
    int a[9] = {-4, 3, -2, 1, 0, -1, 2, -3, 4};
    if(!pflag) {
        int t_id = getpid();
        prior = (t_id * 13) % 35 + a[t_id % 9] + 60;
  96:	8d 34 83             	lea    (%ebx,%eax,4),%esi
  99:	89 f0                	mov    %esi,%eax
  9b:	f7 ea                	imul   %edx
  9d:	8d 04 32             	lea    (%edx,%esi,1),%eax
  a0:	89 f2                	mov    %esi,%edx
  a2:	c1 fa 1f             	sar    $0x1f,%edx
  a5:	c1 f8 05             	sar    $0x5,%eax
  a8:	29 d0                	sub    %edx,%eax
  aa:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
  af:	6b c0 23             	imul   $0x23,%eax,%eax
  b2:	29 c6                	sub    %eax,%esi
  b4:	89 d8                	mov    %ebx,%eax
  b6:	f7 ea                	imul   %edx
  b8:	89 d8                	mov    %ebx,%eax
  ba:	c1 f8 1f             	sar    $0x1f,%eax
  bd:	d1 fa                	sar    %edx
  bf:	29 c2                	sub    %eax,%edx
  c1:	8d 04 d2             	lea    (%edx,%edx,8),%eax
  c4:	29 c1                	sub    %eax,%ecx
  c6:	03 74 8d c4          	add    -0x3c(%ebp,%ecx,4),%esi
  ca:	8d 46 3c             	lea    0x3c(%esi),%eax
        if (setpriority(t_id, prior) < 0)
  cd:	50                   	push   %eax
  ce:	53                   	push   %ebx
    #ifdef PR_SCHEDULE
    int prior = -1;
    int a[9] = {-4, 3, -2, 1, 0, -1, 2, -3, 4};
    if(!pflag) {
        int t_id = getpid();
        prior = (t_id * 13) % 35 + a[t_id % 9] + 60;
  cf:	89 45 b4             	mov    %eax,-0x4c(%ebp)
        if (setpriority(t_id, prior) < 0)
  d2:	e8 d3 04 00 00       	call   5aa <setpriority>
  d7:	83 c4 10             	add    $0x10,%esp
  da:	85 c0                	test   %eax,%eax
  dc:	0f 88 0b 01 00 00    	js     1ed <main+0x1ed>
        {
            printf(1, "Error: PID not found.\n");
        }
        else
        {
            printf(2, "Updating Priority updated for test id: %d to %d\n", t_id, prior);
  e2:	ff 75 b4             	pushl  -0x4c(%ebp)
  e5:	53                   	push   %ebx
  e6:	68 d0 09 00 00       	push   $0x9d0
  eb:	6a 02                	push   $0x2
  ed:	e8 6e 05 00 00       	call   660 <printf>
  f2:	83 c4 10             	add    $0x10,%esp
        }
    }
    #endif

    for(; k < n;) {
  f5:	8b 75 b0             	mov    -0x50(%ebp),%esi
  f8:	c7 45 a4 ff ff ff ff 	movl   $0xffffffff,-0x5c(%ebp)
  ff:	85 f6                	test   %esi,%esi
 101:	0f 84 81 00 00 00    	je     188 <main+0x188>
 107:	31 ff                	xor    %edi,%edi
 109:	31 db                	xor    %ebx,%ebx
 10b:	eb 12                	jmp    11f <main+0x11f>
 10d:	8d 76 00             	lea    0x0(%esi),%esi
            if (!pflag) {
                printf(2, "Starting test Id: %d\n", getpid());
                piflag = getpid();
                pflag = 1;
            }
            wait();
 110:	e8 f5 03 00 00       	call   50a <wait>
            printf(2, "Updating Priority updated for test id: %d to %d\n", t_id, prior);
        }
    }
    #endif

    for(; k < n;) {
 115:	39 5d b0             	cmp    %ebx,-0x50(%ebp)
 118:	bf 01 00 00 00       	mov    $0x1,%edi
 11d:	74 69                	je     188 <main+0x188>
        k += 1;
        z = 0;
        id = fork();
 11f:	e8 d6 03 00 00       	call   4fa <fork>
        #ifdef PR_SCHEDULE 
        setpriority(id, prior);
 124:	83 ec 08             	sub    $0x8,%esp
 127:	ff 75 b4             	pushl  -0x4c(%ebp)
    #endif

    for(; k < n;) {
        k += 1;
        z = 0;
        id = fork();
 12a:	89 c6                	mov    %eax,%esi
        #ifdef PR_SCHEDULE 
        setpriority(id, prior);
 12c:	50                   	push   %eax
        }
    }
    #endif

    for(; k < n;) {
        k += 1;
 12d:	83 c3 01             	add    $0x1,%ebx
        z = 0;
        id = fork();
        #ifdef PR_SCHEDULE 
        setpriority(id, prior);
 130:	e8 75 04 00 00       	call   5aa <setpriority>
        #endif
        if (id < 0) {
 135:	83 c4 10             	add    $0x10,%esp
 138:	85 f6                	test   %esi,%esi
 13a:	78 2c                	js     168 <main+0x168>
            printf(2, "%d Failed in Fork\n", getpid());
        }
        else if (id) {
 13c:	74 59                	je     197 <main+0x197>
            
            if (!pflag) {
 13e:	85 ff                	test   %edi,%edi
 140:	75 ce                	jne    110 <main+0x110>
                printf(2, "Starting test Id: %d\n", getpid());
 142:	e8 3b 04 00 00       	call   582 <getpid>
 147:	83 ec 04             	sub    $0x4,%esp
 14a:	50                   	push   %eax
 14b:	68 ba 09 00 00       	push   $0x9ba
 150:	6a 02                	push   $0x2
 152:	e8 09 05 00 00       	call   660 <printf>
                piflag = getpid();
 157:	e8 26 04 00 00       	call   582 <getpid>
 15c:	83 c4 10             	add    $0x10,%esp
 15f:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 162:	eb ac                	jmp    110 <main+0x110>
 164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        id = fork();
        #ifdef PR_SCHEDULE 
        setpriority(id, prior);
        #endif
        if (id < 0) {
            printf(2, "%d Failed in Fork\n", getpid());
 168:	e8 15 04 00 00       	call   582 <getpid>
 16d:	83 ec 04             	sub    $0x4,%esp
 170:	50                   	push   %eax
 171:	68 a7 09 00 00       	push   $0x9a7
 176:	6a 02                	push   $0x2
 178:	e8 e3 04 00 00       	call   660 <printf>
 17d:	83 c4 10             	add    $0x10,%esp
            printf(2, "Updating Priority updated for test id: %d to %d\n", t_id, prior);
        }
    }
    #endif

    for(; k < n;) {
 180:	39 5d b0             	cmp    %ebx,-0x50(%ebp)
 183:	75 9a                	jne    11f <main+0x11f>
 185:	8d 76 00             	lea    0x0(%esi),%esi
            }
            break;
        }
    }

    if (piflag == getpid())
 188:	e8 f5 03 00 00       	call   582 <getpid>
 18d:	3b 45 a4             	cmp    -0x5c(%ebp),%eax
 190:	74 71                	je     203 <main+0x203>
        printf(2, "Total time for test id: %d is: ", getpid());
        printnum(uptime() - start_time);
        printf(2, "\n");
    }

    exit();
 192:	e8 6b 03 00 00       	call   502 <exit>
 197:	d9 ee                	fldz   
            }
            wait();

        }
        else {
            for (; z < 8000000.0;) {
 199:	d9 05 30 0a 00 00    	flds   0xa30
 19f:	d9 c9                	fxch   %st(1)
 1a1:	eb 07                	jmp    1aa <main+0x1aa>
 1a3:	90                   	nop
 1a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1a8:	d9 c9                	fxch   %st(1)
                x -= 3.14*69.96;
                blue += x*d;
                z += 1*d;
 1aa:	dc 45 a8             	faddl  -0x58(%ebp)
 1ad:	d9 c9                	fxch   %st(1)
            }
            wait();

        }
        else {
            for (; z < 8000000.0;) {
 1af:	db e9                	fucomi %st(1),%st
 1b1:	77 f5                	ja     1a8 <main+0x1a8>
 1b3:	dd d8                	fstp   %st(0)
 1b5:	dd d8                	fstp   %st(0)
 1b7:	eb cf                	jmp    188 <main+0x188>
    int blue = 0, pflag = 0, piflag = -1;
    uint start_time = uptime();
    double x = 0, z, d = 0.007;

    if (argc < 3) {
        n = atoi(argv[1]);
 1b9:	83 ec 0c             	sub    $0xc,%esp
 1bc:	ff 73 04             	pushl  0x4(%ebx)
 1bf:	e8 cc 02 00 00       	call   490 <atoi>
 1c4:	89 c7                	mov    %eax,%edi
    }
    if (argc < 4) {
        d = atoi(argv[2]);
 1c6:	58                   	pop    %eax
 1c7:	ff 73 08             	pushl  0x8(%ebx)
 1ca:	e8 c1 02 00 00       	call   490 <atoi>
 1cf:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    }

    if (n < 0) {
 1d2:	83 c4 10             	add    $0x10,%esp
        n = 20;
 1d5:	b8 14 00 00 00       	mov    $0x14,%eax

    if (argc < 3) {
        n = atoi(argv[1]);
    }
    if (argc < 4) {
        d = atoi(argv[2]);
 1da:	db 45 b4             	fildl  -0x4c(%ebp)
    }

    if (n < 0) {
        n = 20;
 1dd:	85 ff                	test   %edi,%edi
 1df:	0f 49 c7             	cmovns %edi,%eax

    if (argc < 3) {
        n = atoi(argv[1]);
    }
    if (argc < 4) {
        d = atoi(argv[2]);
 1e2:	dd 5d a8             	fstpl  -0x58(%ebp)
    }

    if (n < 0) {
        n = 20;
 1e5:	89 45 b0             	mov    %eax,-0x50(%ebp)
 1e8:	e9 56 fe ff ff       	jmp    43 <main+0x43>
    if(!pflag) {
        int t_id = getpid();
        prior = (t_id * 13) % 35 + a[t_id % 9] + 60;
        if (setpriority(t_id, prior) < 0)
        {
            printf(1, "Error: PID not found.\n");
 1ed:	57                   	push   %edi
 1ee:	57                   	push   %edi
 1ef:	68 90 09 00 00       	push   $0x990
 1f4:	6a 01                	push   $0x1
 1f6:	e8 65 04 00 00       	call   660 <printf>
 1fb:	83 c4 10             	add    $0x10,%esp
 1fe:	e9 f2 fe ff ff       	jmp    f5 <main+0xf5>
        }
    }

    if (piflag == getpid())
    {
        printf(2, "Total time for test id: %d is: ", getpid());
 203:	e8 7a 03 00 00       	call   582 <getpid>
 208:	52                   	push   %edx
 209:	50                   	push   %eax
 20a:	68 04 0a 00 00       	push   $0xa04
 20f:	6a 02                	push   $0x2
 211:	e8 4a 04 00 00       	call   660 <printf>
        printnum(uptime() - start_time);
 216:	e8 7f 03 00 00       	call   59a <uptime>
 21b:	2b 45 a0             	sub    -0x60(%ebp),%eax
 21e:	89 04 24             	mov    %eax,(%esp)
 221:	e8 3a 00 00 00       	call   260 <printnum>
        printf(2, "\n");
 226:	59                   	pop    %ecx
 227:	5b                   	pop    %ebx
 228:	68 a5 09 00 00       	push   $0x9a5
 22d:	6a 02                	push   $0x2
 22f:	e8 2c 04 00 00       	call   660 <printf>
 234:	83 c4 10             	add    $0x10,%esp
 237:	e9 56 ff ff ff       	jmp    192 <main+0x192>

    if (argc < 3) {
        n = atoi(argv[1]);
    }
    if (argc < 4) {
        d = atoi(argv[2]);
 23c:	83 ec 0c             	sub    $0xc,%esp
 23f:	ff 73 08             	pushl  0x8(%ebx)
 242:	e8 49 02 00 00       	call   490 <atoi>
 247:	89 45 b4             	mov    %eax,-0x4c(%ebp)
 24a:	83 c4 10             	add    $0x10,%esp
}

int 
main(int argc, char *argv[])
{
    int k = 0, n = 20, id = 0;
 24d:	c7 45 b0 14 00 00 00 	movl   $0x14,-0x50(%ebp)

    if (argc < 3) {
        n = atoi(argv[1]);
    }
    if (argc < 4) {
        d = atoi(argv[2]);
 254:	db 45 b4             	fildl  -0x4c(%ebp)
 257:	dd 5d a8             	fstpl  -0x58(%ebp)
 25a:	e9 e4 fd ff ff       	jmp    43 <main+0x43>
 25f:	90                   	nop

00000260 <printnum>:
#include "types.h"
#include "user.h"

void 
printnum(const uint num)
{
 260:	55                   	push   %ebp
    if (num % 100 > 9)
 261:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
#include "types.h"
#include "user.h"

void 
printnum(const uint num)
{
 266:	89 e5                	mov    %esp,%ebp
 268:	83 ec 08             	sub    $0x8,%esp
 26b:	8b 4d 08             	mov    0x8(%ebp),%ecx
    if (num % 100 > 9)
 26e:	89 c8                	mov    %ecx,%eax
 270:	f7 e2                	mul    %edx
 272:	89 d0                	mov    %edx,%eax
 274:	c1 e8 05             	shr    $0x5,%eax
 277:	6b c0 64             	imul   $0x64,%eax,%eax
 27a:	29 c1                	sub    %eax,%ecx
 27c:	83 f9 09             	cmp    $0x9,%ecx
 27f:	77 1f                	ja     2a0 <printnum+0x40>
        printf(2, "%d.%d\t", num / 100, num % 100);
    else
        printf(2, "%d.%d%d\t", num / 100, 0, num % 100);
 281:	83 ec 0c             	sub    $0xc,%esp
 284:	c1 ea 05             	shr    $0x5,%edx
 287:	51                   	push   %ecx
 288:	6a 00                	push   $0x0
 28a:	52                   	push   %edx
 28b:	68 87 09 00 00       	push   $0x987
 290:	6a 02                	push   $0x2
 292:	e8 c9 03 00 00       	call   660 <printf>
 297:	83 c4 20             	add    $0x20,%esp
}
 29a:	c9                   	leave  
 29b:	c3                   	ret    
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void 
printnum(const uint num)
{
    if (num % 100 > 9)
        printf(2, "%d.%d\t", num / 100, num % 100);
 2a0:	c1 ea 05             	shr    $0x5,%edx
 2a3:	51                   	push   %ecx
 2a4:	52                   	push   %edx
 2a5:	68 80 09 00 00       	push   $0x980
 2aa:	6a 02                	push   $0x2
 2ac:	e8 af 03 00 00       	call   660 <printf>
 2b1:	83 c4 10             	add    $0x10,%esp
    else
        printf(2, "%d.%d%d\t", num / 100, 0, num % 100);
}
 2b4:	c9                   	leave  
 2b5:	c3                   	ret    
 2b6:	66 90                	xchg   %ax,%ax
 2b8:	66 90                	xchg   %ax,%ax
 2ba:	66 90                	xchg   %ax,%ax
 2bc:	66 90                	xchg   %ax,%ax
 2be:	66 90                	xchg   %ax,%ax

000002c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	53                   	push   %ebx
 2c4:	8b 45 08             	mov    0x8(%ebp),%eax
 2c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2ca:	89 c2                	mov    %eax,%edx
 2cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2d0:	83 c1 01             	add    $0x1,%ecx
 2d3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 2d7:	83 c2 01             	add    $0x1,%edx
 2da:	84 db                	test   %bl,%bl
 2dc:	88 5a ff             	mov    %bl,-0x1(%edx)
 2df:	75 ef                	jne    2d0 <strcpy+0x10>
    ;
  return os;
}
 2e1:	5b                   	pop    %ebx
 2e2:	5d                   	pop    %ebp
 2e3:	c3                   	ret    
 2e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	56                   	push   %esi
 2f4:	53                   	push   %ebx
 2f5:	8b 55 08             	mov    0x8(%ebp),%edx
 2f8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 2fb:	0f b6 02             	movzbl (%edx),%eax
 2fe:	0f b6 19             	movzbl (%ecx),%ebx
 301:	84 c0                	test   %al,%al
 303:	75 1e                	jne    323 <strcmp+0x33>
 305:	eb 29                	jmp    330 <strcmp+0x40>
 307:	89 f6                	mov    %esi,%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 310:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 313:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 316:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 319:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 31d:	84 c0                	test   %al,%al
 31f:	74 0f                	je     330 <strcmp+0x40>
 321:	89 f1                	mov    %esi,%ecx
 323:	38 d8                	cmp    %bl,%al
 325:	74 e9                	je     310 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 327:	29 d8                	sub    %ebx,%eax
}
 329:	5b                   	pop    %ebx
 32a:	5e                   	pop    %esi
 32b:	5d                   	pop    %ebp
 32c:	c3                   	ret    
 32d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 330:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 332:	29 d8                	sub    %ebx,%eax
}
 334:	5b                   	pop    %ebx
 335:	5e                   	pop    %esi
 336:	5d                   	pop    %ebp
 337:	c3                   	ret    
 338:	90                   	nop
 339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000340 <strlen>:

uint
strlen(const char *s)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 346:	80 39 00             	cmpb   $0x0,(%ecx)
 349:	74 12                	je     35d <strlen+0x1d>
 34b:	31 d2                	xor    %edx,%edx
 34d:	8d 76 00             	lea    0x0(%esi),%esi
 350:	83 c2 01             	add    $0x1,%edx
 353:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 357:	89 d0                	mov    %edx,%eax
 359:	75 f5                	jne    350 <strlen+0x10>
    ;
  return n;
}
 35b:	5d                   	pop    %ebp
 35c:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 35d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 35f:	5d                   	pop    %ebp
 360:	c3                   	ret    
 361:	eb 0d                	jmp    370 <memset>
 363:	90                   	nop
 364:	90                   	nop
 365:	90                   	nop
 366:	90                   	nop
 367:	90                   	nop
 368:	90                   	nop
 369:	90                   	nop
 36a:	90                   	nop
 36b:	90                   	nop
 36c:	90                   	nop
 36d:	90                   	nop
 36e:	90                   	nop
 36f:	90                   	nop

00000370 <memset>:

void*
memset(void *dst, int c, uint n)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 377:	8b 4d 10             	mov    0x10(%ebp),%ecx
 37a:	8b 45 0c             	mov    0xc(%ebp),%eax
 37d:	89 d7                	mov    %edx,%edi
 37f:	fc                   	cld    
 380:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 382:	89 d0                	mov    %edx,%eax
 384:	5f                   	pop    %edi
 385:	5d                   	pop    %ebp
 386:	c3                   	ret    
 387:	89 f6                	mov    %esi,%esi
 389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000390 <strchr>:

char*
strchr(const char *s, char c)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	53                   	push   %ebx
 394:	8b 45 08             	mov    0x8(%ebp),%eax
 397:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 39a:	0f b6 10             	movzbl (%eax),%edx
 39d:	84 d2                	test   %dl,%dl
 39f:	74 1d                	je     3be <strchr+0x2e>
    if(*s == c)
 3a1:	38 d3                	cmp    %dl,%bl
 3a3:	89 d9                	mov    %ebx,%ecx
 3a5:	75 0d                	jne    3b4 <strchr+0x24>
 3a7:	eb 17                	jmp    3c0 <strchr+0x30>
 3a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3b0:	38 ca                	cmp    %cl,%dl
 3b2:	74 0c                	je     3c0 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 3b4:	83 c0 01             	add    $0x1,%eax
 3b7:	0f b6 10             	movzbl (%eax),%edx
 3ba:	84 d2                	test   %dl,%dl
 3bc:	75 f2                	jne    3b0 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 3be:	31 c0                	xor    %eax,%eax
}
 3c0:	5b                   	pop    %ebx
 3c1:	5d                   	pop    %ebp
 3c2:	c3                   	ret    
 3c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003d0 <gets>:

char*
gets(char *buf, int max)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	56                   	push   %esi
 3d5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3d6:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 3d8:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 3db:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3de:	eb 29                	jmp    409 <gets+0x39>
    cc = read(0, &c, 1);
 3e0:	83 ec 04             	sub    $0x4,%esp
 3e3:	6a 01                	push   $0x1
 3e5:	57                   	push   %edi
 3e6:	6a 00                	push   $0x0
 3e8:	e8 2d 01 00 00       	call   51a <read>
    if(cc < 1)
 3ed:	83 c4 10             	add    $0x10,%esp
 3f0:	85 c0                	test   %eax,%eax
 3f2:	7e 1d                	jle    411 <gets+0x41>
      break;
    buf[i++] = c;
 3f4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 3f8:	8b 55 08             	mov    0x8(%ebp),%edx
 3fb:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 3fd:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 3ff:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 403:	74 1b                	je     420 <gets+0x50>
 405:	3c 0d                	cmp    $0xd,%al
 407:	74 17                	je     420 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 409:	8d 5e 01             	lea    0x1(%esi),%ebx
 40c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 40f:	7c cf                	jl     3e0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 411:	8b 45 08             	mov    0x8(%ebp),%eax
 414:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 418:	8d 65 f4             	lea    -0xc(%ebp),%esp
 41b:	5b                   	pop    %ebx
 41c:	5e                   	pop    %esi
 41d:	5f                   	pop    %edi
 41e:	5d                   	pop    %ebp
 41f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 420:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 423:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 425:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 429:	8d 65 f4             	lea    -0xc(%ebp),%esp
 42c:	5b                   	pop    %ebx
 42d:	5e                   	pop    %esi
 42e:	5f                   	pop    %edi
 42f:	5d                   	pop    %ebp
 430:	c3                   	ret    
 431:	eb 0d                	jmp    440 <stat>
 433:	90                   	nop
 434:	90                   	nop
 435:	90                   	nop
 436:	90                   	nop
 437:	90                   	nop
 438:	90                   	nop
 439:	90                   	nop
 43a:	90                   	nop
 43b:	90                   	nop
 43c:	90                   	nop
 43d:	90                   	nop
 43e:	90                   	nop
 43f:	90                   	nop

00000440 <stat>:

int
stat(const char *n, struct stat *st)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	56                   	push   %esi
 444:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 445:	83 ec 08             	sub    $0x8,%esp
 448:	6a 00                	push   $0x0
 44a:	ff 75 08             	pushl  0x8(%ebp)
 44d:	e8 f0 00 00 00       	call   542 <open>
  if(fd < 0)
 452:	83 c4 10             	add    $0x10,%esp
 455:	85 c0                	test   %eax,%eax
 457:	78 27                	js     480 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 459:	83 ec 08             	sub    $0x8,%esp
 45c:	ff 75 0c             	pushl  0xc(%ebp)
 45f:	89 c3                	mov    %eax,%ebx
 461:	50                   	push   %eax
 462:	e8 f3 00 00 00       	call   55a <fstat>
  close(fd);
 467:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 46a:	89 c6                	mov    %eax,%esi
  close(fd);
 46c:	e8 b9 00 00 00       	call   52a <close>
  return r;
 471:	83 c4 10             	add    $0x10,%esp
}
 474:	8d 65 f8             	lea    -0x8(%ebp),%esp
 477:	89 f0                	mov    %esi,%eax
 479:	5b                   	pop    %ebx
 47a:	5e                   	pop    %esi
 47b:	5d                   	pop    %ebp
 47c:	c3                   	ret    
 47d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 480:	be ff ff ff ff       	mov    $0xffffffff,%esi
 485:	eb ed                	jmp    474 <stat+0x34>
 487:	89 f6                	mov    %esi,%esi
 489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000490 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	53                   	push   %ebx
 494:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 497:	0f be 11             	movsbl (%ecx),%edx
 49a:	8d 42 d0             	lea    -0x30(%edx),%eax
 49d:	3c 09                	cmp    $0x9,%al
 49f:	b8 00 00 00 00       	mov    $0x0,%eax
 4a4:	77 1f                	ja     4c5 <atoi+0x35>
 4a6:	8d 76 00             	lea    0x0(%esi),%esi
 4a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 4b0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 4b3:	83 c1 01             	add    $0x1,%ecx
 4b6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4ba:	0f be 11             	movsbl (%ecx),%edx
 4bd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 4c0:	80 fb 09             	cmp    $0x9,%bl
 4c3:	76 eb                	jbe    4b0 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 4c5:	5b                   	pop    %ebx
 4c6:	5d                   	pop    %ebp
 4c7:	c3                   	ret    
 4c8:	90                   	nop
 4c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	56                   	push   %esi
 4d4:	53                   	push   %ebx
 4d5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4d8:	8b 45 08             	mov    0x8(%ebp),%eax
 4db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4de:	85 db                	test   %ebx,%ebx
 4e0:	7e 14                	jle    4f6 <memmove+0x26>
 4e2:	31 d2                	xor    %edx,%edx
 4e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 4e8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 4ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 4ef:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4f2:	39 da                	cmp    %ebx,%edx
 4f4:	75 f2                	jne    4e8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 4f6:	5b                   	pop    %ebx
 4f7:	5e                   	pop    %esi
 4f8:	5d                   	pop    %ebp
 4f9:	c3                   	ret    

000004fa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4fa:	b8 01 00 00 00       	mov    $0x1,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <exit>:
SYSCALL(exit)
 502:	b8 02 00 00 00       	mov    $0x2,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <wait>:
SYSCALL(wait)
 50a:	b8 03 00 00 00       	mov    $0x3,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <pipe>:
SYSCALL(pipe)
 512:	b8 04 00 00 00       	mov    $0x4,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <read>:
SYSCALL(read)
 51a:	b8 05 00 00 00       	mov    $0x5,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <write>:
SYSCALL(write)
 522:	b8 10 00 00 00       	mov    $0x10,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <close>:
SYSCALL(close)
 52a:	b8 15 00 00 00       	mov    $0x15,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <kill>:
SYSCALL(kill)
 532:	b8 06 00 00 00       	mov    $0x6,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <exec>:
SYSCALL(exec)
 53a:	b8 07 00 00 00       	mov    $0x7,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <open>:
SYSCALL(open)
 542:	b8 0f 00 00 00       	mov    $0xf,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <mknod>:
SYSCALL(mknod)
 54a:	b8 11 00 00 00       	mov    $0x11,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <unlink>:
SYSCALL(unlink)
 552:	b8 12 00 00 00       	mov    $0x12,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <fstat>:
SYSCALL(fstat)
 55a:	b8 08 00 00 00       	mov    $0x8,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <link>:
SYSCALL(link)
 562:	b8 13 00 00 00       	mov    $0x13,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <mkdir>:
SYSCALL(mkdir)
 56a:	b8 14 00 00 00       	mov    $0x14,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <chdir>:
SYSCALL(chdir)
 572:	b8 09 00 00 00       	mov    $0x9,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <dup>:
SYSCALL(dup)
 57a:	b8 0a 00 00 00       	mov    $0xa,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <getpid>:
SYSCALL(getpid)
 582:	b8 0b 00 00 00       	mov    $0xb,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <sbrk>:
SYSCALL(sbrk)
 58a:	b8 0c 00 00 00       	mov    $0xc,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <sleep>:
SYSCALL(sleep)
 592:	b8 0d 00 00 00       	mov    $0xd,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <uptime>:
SYSCALL(uptime)
 59a:	b8 0e 00 00 00       	mov    $0xe,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <getprocs>:
SYSCALL(getprocs)
 5a2:	b8 16 00 00 00       	mov    $0x16,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <setpriority>:
SYSCALL(setpriority)
 5aa:	b8 17 00 00 00       	mov    $0x17,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    
 5b2:	66 90                	xchg   %ax,%ax
 5b4:	66 90                	xchg   %ax,%ax
 5b6:	66 90                	xchg   %ax,%ax
 5b8:	66 90                	xchg   %ax,%ax
 5ba:	66 90                	xchg   %ax,%ax
 5bc:	66 90                	xchg   %ax,%ax
 5be:	66 90                	xchg   %ax,%ax

000005c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	57                   	push   %edi
 5c4:	56                   	push   %esi
 5c5:	53                   	push   %ebx
 5c6:	89 c6                	mov    %eax,%esi
 5c8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5ce:	85 db                	test   %ebx,%ebx
 5d0:	74 7e                	je     650 <printint+0x90>
 5d2:	89 d0                	mov    %edx,%eax
 5d4:	c1 e8 1f             	shr    $0x1f,%eax
 5d7:	84 c0                	test   %al,%al
 5d9:	74 75                	je     650 <printint+0x90>
    neg = 1;
    x = -xx;
 5db:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 5dd:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 5e4:	f7 d8                	neg    %eax
 5e6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 5e9:	31 ff                	xor    %edi,%edi
 5eb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 5ee:	89 ce                	mov    %ecx,%esi
 5f0:	eb 08                	jmp    5fa <printint+0x3a>
 5f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 5f8:	89 cf                	mov    %ecx,%edi
 5fa:	31 d2                	xor    %edx,%edx
 5fc:	8d 4f 01             	lea    0x1(%edi),%ecx
 5ff:	f7 f6                	div    %esi
 601:	0f b6 92 3c 0a 00 00 	movzbl 0xa3c(%edx),%edx
  }while((x /= base) != 0);
 608:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 60a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 60d:	75 e9                	jne    5f8 <printint+0x38>
  if(neg)
 60f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 612:	8b 75 c0             	mov    -0x40(%ebp),%esi
 615:	85 c0                	test   %eax,%eax
 617:	74 08                	je     621 <printint+0x61>
    buf[i++] = '-';
 619:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 61e:	8d 4f 02             	lea    0x2(%edi),%ecx

  while(--i >= 0)
 621:	8d 79 ff             	lea    -0x1(%ecx),%edi
 624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 628:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 62d:	83 ec 04             	sub    $0x4,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 630:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 633:	6a 01                	push   $0x1
 635:	53                   	push   %ebx
 636:	56                   	push   %esi
 637:	88 45 d7             	mov    %al,-0x29(%ebp)
 63a:	e8 e3 fe ff ff       	call   522 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 63f:	83 c4 10             	add    $0x10,%esp
 642:	83 ff ff             	cmp    $0xffffffff,%edi
 645:	75 e1                	jne    628 <printint+0x68>
    putc(fd, buf[i]);
}
 647:	8d 65 f4             	lea    -0xc(%ebp),%esp
 64a:	5b                   	pop    %ebx
 64b:	5e                   	pop    %esi
 64c:	5f                   	pop    %edi
 64d:	5d                   	pop    %ebp
 64e:	c3                   	ret    
 64f:	90                   	nop
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 650:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 652:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 659:	eb 8b                	jmp    5e6 <printint+0x26>
 65b:	90                   	nop
 65c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000660 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	57                   	push   %edi
 664:	56                   	push   %esi
 665:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 666:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 669:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 66c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 66f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 672:	89 45 d0             	mov    %eax,-0x30(%ebp)
 675:	0f b6 1e             	movzbl (%esi),%ebx
 678:	83 c6 01             	add    $0x1,%esi
 67b:	84 db                	test   %bl,%bl
 67d:	0f 84 b0 00 00 00    	je     733 <printf+0xd3>
 683:	31 d2                	xor    %edx,%edx
 685:	eb 39                	jmp    6c0 <printf+0x60>
 687:	89 f6                	mov    %esi,%esi
 689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 690:	83 f8 25             	cmp    $0x25,%eax
 693:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 696:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 69b:	74 18                	je     6b5 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 69d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6a0:	83 ec 04             	sub    $0x4,%esp
 6a3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 6a6:	6a 01                	push   $0x1
 6a8:	50                   	push   %eax
 6a9:	57                   	push   %edi
 6aa:	e8 73 fe ff ff       	call   522 <write>
 6af:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 6b2:	83 c4 10             	add    $0x10,%esp
 6b5:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6b8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 6bc:	84 db                	test   %bl,%bl
 6be:	74 73                	je     733 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 6c0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 6c2:	0f be cb             	movsbl %bl,%ecx
 6c5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 6c8:	74 c6                	je     690 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6ca:	83 fa 25             	cmp    $0x25,%edx
 6cd:	75 e6                	jne    6b5 <printf+0x55>
      if(c == 'd'){
 6cf:	83 f8 64             	cmp    $0x64,%eax
 6d2:	0f 84 f8 00 00 00    	je     7d0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 6d8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 6de:	83 f9 70             	cmp    $0x70,%ecx
 6e1:	74 5d                	je     740 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 6e3:	83 f8 73             	cmp    $0x73,%eax
 6e6:	0f 84 84 00 00 00    	je     770 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6ec:	83 f8 63             	cmp    $0x63,%eax
 6ef:	0f 84 ea 00 00 00    	je     7df <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 6f5:	83 f8 25             	cmp    $0x25,%eax
 6f8:	0f 84 c2 00 00 00    	je     7c0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6fe:	8d 45 e7             	lea    -0x19(%ebp),%eax
 701:	83 ec 04             	sub    $0x4,%esp
 704:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 708:	6a 01                	push   $0x1
 70a:	50                   	push   %eax
 70b:	57                   	push   %edi
 70c:	e8 11 fe ff ff       	call   522 <write>
 711:	83 c4 0c             	add    $0xc,%esp
 714:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 717:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 71a:	6a 01                	push   $0x1
 71c:	50                   	push   %eax
 71d:	57                   	push   %edi
 71e:	83 c6 01             	add    $0x1,%esi
 721:	e8 fc fd ff ff       	call   522 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 726:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 72a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 72d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 72f:	84 db                	test   %bl,%bl
 731:	75 8d                	jne    6c0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 733:	8d 65 f4             	lea    -0xc(%ebp),%esp
 736:	5b                   	pop    %ebx
 737:	5e                   	pop    %esi
 738:	5f                   	pop    %edi
 739:	5d                   	pop    %ebp
 73a:	c3                   	ret    
 73b:	90                   	nop
 73c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 740:	83 ec 0c             	sub    $0xc,%esp
 743:	b9 10 00 00 00       	mov    $0x10,%ecx
 748:	6a 00                	push   $0x0
 74a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 74d:	89 f8                	mov    %edi,%eax
 74f:	8b 13                	mov    (%ebx),%edx
 751:	e8 6a fe ff ff       	call   5c0 <printint>
        ap++;
 756:	89 d8                	mov    %ebx,%eax
 758:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 75b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 75d:	83 c0 04             	add    $0x4,%eax
 760:	89 45 d0             	mov    %eax,-0x30(%ebp)
 763:	e9 4d ff ff ff       	jmp    6b5 <printf+0x55>
 768:	90                   	nop
 769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 770:	8b 45 d0             	mov    -0x30(%ebp),%eax
 773:	8b 18                	mov    (%eax),%ebx
        ap++;
 775:	83 c0 04             	add    $0x4,%eax
 778:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 77b:	85 db                	test   %ebx,%ebx
 77d:	74 7c                	je     7fb <printf+0x19b>
          s = "(null)";
        while(*s != 0){
 77f:	0f b6 03             	movzbl (%ebx),%eax
 782:	84 c0                	test   %al,%al
 784:	74 29                	je     7af <printf+0x14f>
 786:	8d 76 00             	lea    0x0(%esi),%esi
 789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 790:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 793:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 796:	83 ec 04             	sub    $0x4,%esp
 799:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 79b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 79e:	50                   	push   %eax
 79f:	57                   	push   %edi
 7a0:	e8 7d fd ff ff       	call   522 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7a5:	0f b6 03             	movzbl (%ebx),%eax
 7a8:	83 c4 10             	add    $0x10,%esp
 7ab:	84 c0                	test   %al,%al
 7ad:	75 e1                	jne    790 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7af:	31 d2                	xor    %edx,%edx
 7b1:	e9 ff fe ff ff       	jmp    6b5 <printf+0x55>
 7b6:	8d 76 00             	lea    0x0(%esi),%esi
 7b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7c0:	83 ec 04             	sub    $0x4,%esp
 7c3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 7c6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 7c9:	6a 01                	push   $0x1
 7cb:	e9 4c ff ff ff       	jmp    71c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 7d0:	83 ec 0c             	sub    $0xc,%esp
 7d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7d8:	6a 01                	push   $0x1
 7da:	e9 6b ff ff ff       	jmp    74a <printf+0xea>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 7df:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7e2:	83 ec 04             	sub    $0x4,%esp
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 7e5:	8b 03                	mov    (%ebx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7e7:	6a 01                	push   $0x1
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 7e9:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7ec:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 7ef:	50                   	push   %eax
 7f0:	57                   	push   %edi
 7f1:	e8 2c fd ff ff       	call   522 <write>
 7f6:	e9 5b ff ff ff       	jmp    756 <printf+0xf6>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7fb:	b8 28 00 00 00       	mov    $0x28,%eax
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 800:	bb 34 0a 00 00       	mov    $0xa34,%ebx
 805:	eb 89                	jmp    790 <printf+0x130>
 807:	66 90                	xchg   %ax,%ax
 809:	66 90                	xchg   %ax,%ax
 80b:	66 90                	xchg   %ax,%ax
 80d:	66 90                	xchg   %ax,%ax
 80f:	90                   	nop

00000810 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 810:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 811:	a1 08 0d 00 00       	mov    0xd08,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 816:	89 e5                	mov    %esp,%ebp
 818:	57                   	push   %edi
 819:	56                   	push   %esi
 81a:	53                   	push   %ebx
 81b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 81e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 820:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 823:	39 c8                	cmp    %ecx,%eax
 825:	73 19                	jae    840 <free+0x30>
 827:	89 f6                	mov    %esi,%esi
 829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 830:	39 d1                	cmp    %edx,%ecx
 832:	72 1c                	jb     850 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 834:	39 d0                	cmp    %edx,%eax
 836:	73 18                	jae    850 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 838:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 83a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 83c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 83e:	72 f0                	jb     830 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 840:	39 d0                	cmp    %edx,%eax
 842:	72 f4                	jb     838 <free+0x28>
 844:	39 d1                	cmp    %edx,%ecx
 846:	73 f0                	jae    838 <free+0x28>
 848:	90                   	nop
 849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 850:	8b 73 fc             	mov    -0x4(%ebx),%esi
 853:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 856:	39 fa                	cmp    %edi,%edx
 858:	74 19                	je     873 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 85a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 85d:	8b 50 04             	mov    0x4(%eax),%edx
 860:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 863:	39 f1                	cmp    %esi,%ecx
 865:	74 23                	je     88a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 867:	89 08                	mov    %ecx,(%eax)
  freep = p;
 869:	a3 08 0d 00 00       	mov    %eax,0xd08
}
 86e:	5b                   	pop    %ebx
 86f:	5e                   	pop    %esi
 870:	5f                   	pop    %edi
 871:	5d                   	pop    %ebp
 872:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 873:	03 72 04             	add    0x4(%edx),%esi
 876:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 879:	8b 10                	mov    (%eax),%edx
 87b:	8b 12                	mov    (%edx),%edx
 87d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 880:	8b 50 04             	mov    0x4(%eax),%edx
 883:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 886:	39 f1                	cmp    %esi,%ecx
 888:	75 dd                	jne    867 <free+0x57>
    p->s.size += bp->s.size;
 88a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 88d:	a3 08 0d 00 00       	mov    %eax,0xd08
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 892:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 895:	8b 53 f8             	mov    -0x8(%ebx),%edx
 898:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 89a:	5b                   	pop    %ebx
 89b:	5e                   	pop    %esi
 89c:	5f                   	pop    %edi
 89d:	5d                   	pop    %ebp
 89e:	c3                   	ret    
 89f:	90                   	nop

000008a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	57                   	push   %edi
 8a4:	56                   	push   %esi
 8a5:	53                   	push   %ebx
 8a6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 8ac:	8b 15 08 0d 00 00    	mov    0xd08,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8b2:	8d 78 07             	lea    0x7(%eax),%edi
 8b5:	c1 ef 03             	shr    $0x3,%edi
 8b8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 8bb:	85 d2                	test   %edx,%edx
 8bd:	0f 84 93 00 00 00    	je     956 <malloc+0xb6>
 8c3:	8b 02                	mov    (%edx),%eax
 8c5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 8c8:	39 cf                	cmp    %ecx,%edi
 8ca:	76 64                	jbe    930 <malloc+0x90>
 8cc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 8d2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 8d7:	0f 43 df             	cmovae %edi,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 8da:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 8e1:	eb 0e                	jmp    8f1 <malloc+0x51>
 8e3:	90                   	nop
 8e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8ea:	8b 48 04             	mov    0x4(%eax),%ecx
 8ed:	39 cf                	cmp    %ecx,%edi
 8ef:	76 3f                	jbe    930 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8f1:	39 05 08 0d 00 00    	cmp    %eax,0xd08
 8f7:	89 c2                	mov    %eax,%edx
 8f9:	75 ed                	jne    8e8 <malloc+0x48>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 8fb:	83 ec 0c             	sub    $0xc,%esp
 8fe:	56                   	push   %esi
 8ff:	e8 86 fc ff ff       	call   58a <sbrk>
  if(p == (char*)-1)
 904:	83 c4 10             	add    $0x10,%esp
 907:	83 f8 ff             	cmp    $0xffffffff,%eax
 90a:	74 1c                	je     928 <malloc+0x88>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 90c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 90f:	83 ec 0c             	sub    $0xc,%esp
 912:	83 c0 08             	add    $0x8,%eax
 915:	50                   	push   %eax
 916:	e8 f5 fe ff ff       	call   810 <free>
  return freep;
 91b:	8b 15 08 0d 00 00    	mov    0xd08,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 921:	83 c4 10             	add    $0x10,%esp
 924:	85 d2                	test   %edx,%edx
 926:	75 c0                	jne    8e8 <malloc+0x48>
        return 0;
 928:	31 c0                	xor    %eax,%eax
 92a:	eb 1c                	jmp    948 <malloc+0xa8>
 92c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 930:	39 cf                	cmp    %ecx,%edi
 932:	74 1c                	je     950 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 934:	29 f9                	sub    %edi,%ecx
 936:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 939:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 93c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 93f:	89 15 08 0d 00 00    	mov    %edx,0xd08
      return (void*)(p + 1);
 945:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 948:	8d 65 f4             	lea    -0xc(%ebp),%esp
 94b:	5b                   	pop    %ebx
 94c:	5e                   	pop    %esi
 94d:	5f                   	pop    %edi
 94e:	5d                   	pop    %ebp
 94f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 950:	8b 08                	mov    (%eax),%ecx
 952:	89 0a                	mov    %ecx,(%edx)
 954:	eb e9                	jmp    93f <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 956:	c7 05 08 0d 00 00 0c 	movl   $0xd0c,0xd08
 95d:	0d 00 00 
 960:	c7 05 0c 0d 00 00 0c 	movl   $0xd0c,0xd0c
 967:	0d 00 00 
    base.s.size = 0;
 96a:	b8 0c 0d 00 00       	mov    $0xd0c,%eax
 96f:	c7 05 10 0d 00 00 00 	movl   $0x0,0xd10
 976:	00 00 00 
 979:	e9 4e ff ff ff       	jmp    8cc <malloc+0x2c>
