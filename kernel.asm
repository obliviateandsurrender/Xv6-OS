
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 20 b6 10 80       	mov    $0x8010b620,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 80 2e 10 80       	mov    $0x80102e80,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 b6 10 80       	mov    $0x8010b654,%ebx
  struct buf head;
} bcache;

void
binit(void)
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010004c:	68 a0 71 10 80       	push   $0x801071a0
80100051:	68 20 b6 10 80       	push   $0x8010b620
80100056:	e8 35 44 00 00       	call   80104490 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 6c fd 10 80 1c 	movl   $0x8010fd1c,0x8010fd6c
80100062:	fd 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 70 fd 10 80 1c 	movl   $0x8010fd1c,0x8010fd70
8010006c:	fd 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba 1c fd 10 80       	mov    $0x8010fd1c,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c fd 10 80 	movl   $0x8010fd1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 a7 71 10 80       	push   $0x801071a7
80100097:	50                   	push   %eax
80100098:	e8 c3 42 00 00       	call   80104360 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 fd 10 80       	mov    0x8010fd70,%eax

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000b0:	89 1d 70 fd 10 80    	mov    %ebx,0x8010fd70

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d 1c fd 10 80       	cmp    $0x8010fd1c,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000df:	68 20 b6 10 80       	push   $0x8010b620
801000e4:	e8 07 45 00 00       	call   801045f0 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 fd 10 80    	mov    0x8010fd70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fd 10 80    	cmp    $0x8010fd1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fd 10 80    	cmp    $0x8010fd1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c fd 10 80    	mov    0x8010fd6c,%ebx
80100126:	81 fb 1c fd 10 80    	cmp    $0x8010fd1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fd 10 80    	cmp    $0x8010fd1c,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 b6 10 80       	push   $0x8010b620
80100162:	e8 39 45 00 00       	call   801046a0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 2e 42 00 00       	call   801043a0 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 6d 1f 00 00       	call   801020f0 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 ae 71 10 80       	push   $0x801071ae
80100198:	e8 d3 01 00 00       	call   80100370 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 8d 42 00 00       	call   80104440 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001c4:	e9 27 1f 00 00       	jmp    801020f0 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 bf 71 10 80       	push   $0x801071bf
801001d1:	e8 9a 01 00 00       	call   80100370 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 4c 42 00 00       	call   80104440 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 fc 41 00 00       	call   80104400 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 20 b6 10 80 	movl   $0x8010b620,(%esp)
8010020b:	e8 e0 43 00 00       	call   801045f0 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 70 fd 10 80       	mov    0x8010fd70,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 1c fd 10 80 	movl   $0x8010fd1c,0x50(%ebx)
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
80100241:	a1 70 fd 10 80       	mov    0x8010fd70,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 70 fd 10 80    	mov    %ebx,0x8010fd70
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 20 b6 10 80 	movl   $0x8010b620,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
8010025c:	e9 3f 44 00 00       	jmp    801046a0 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 c6 71 10 80       	push   $0x801071c6
80100269:	e8 02 01 00 00       	call   80100370 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 cb 14 00 00       	call   80101750 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
8010028c:	e8 5f 43 00 00       	call   801045f0 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e 9a 00 00 00    	jle    8010033b <consoleread+0xcb>
    while(input.r == input.w){
801002a1:	a1 00 00 11 80       	mov    0x80110000,%eax
801002a6:	3b 05 04 00 11 80    	cmp    0x80110004,%eax
801002ac:	74 24                	je     801002d2 <consoleread+0x62>
801002ae:	eb 58                	jmp    80100308 <consoleread+0x98>
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b0:	83 ec 08             	sub    $0x8,%esp
801002b3:	68 80 a5 10 80       	push   $0x8010a580
801002b8:	68 00 00 11 80       	push   $0x80110000
801002bd:	e8 5e 3b 00 00       	call   80103e20 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801002c2:	a1 00 00 11 80       	mov    0x80110000,%eax
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	3b 05 04 00 11 80    	cmp    0x80110004,%eax
801002d0:	75 36                	jne    80100308 <consoleread+0x98>
      if(myproc()->killed){
801002d2:	e8 e9 34 00 00       	call   801037c0 <myproc>
801002d7:	8b 40 24             	mov    0x24(%eax),%eax
801002da:	85 c0                	test   %eax,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
        release(&cons.lock);
801002de:	83 ec 0c             	sub    $0xc,%esp
801002e1:	68 80 a5 10 80       	push   $0x8010a580
801002e6:	e8 b5 43 00 00       	call   801046a0 <release>
        ilock(ip);
801002eb:	89 3c 24             	mov    %edi,(%esp)
801002ee:	e8 7d 13 00 00       	call   80101670 <ilock>
        return -1;
801002f3:	83 c4 10             	add    $0x10,%esp
801002f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002fe:	5b                   	pop    %ebx
801002ff:	5e                   	pop    %esi
80100300:	5f                   	pop    %edi
80100301:	5d                   	pop    %ebp
80100302:	c3                   	ret    
80100303:	90                   	nop
80100304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100308:	8d 50 01             	lea    0x1(%eax),%edx
8010030b:	89 15 00 00 11 80    	mov    %edx,0x80110000
80100311:	89 c2                	mov    %eax,%edx
80100313:	83 e2 7f             	and    $0x7f,%edx
80100316:	0f be 92 80 ff 10 80 	movsbl -0x7fef0080(%edx),%edx
    if(c == C('D')){  // EOF
8010031d:	83 fa 04             	cmp    $0x4,%edx
80100320:	74 39                	je     8010035b <consoleread+0xeb>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100322:	83 c6 01             	add    $0x1,%esi
    --n;
80100325:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
80100328:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
8010032b:	88 56 ff             	mov    %dl,-0x1(%esi)
    --n;
    if(c == '\n')
8010032e:	74 35                	je     80100365 <consoleread+0xf5>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100330:	85 db                	test   %ebx,%ebx
80100332:	0f 85 69 ff ff ff    	jne    801002a1 <consoleread+0x31>
80100338:	8b 45 10             	mov    0x10(%ebp),%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
8010033b:	83 ec 0c             	sub    $0xc,%esp
8010033e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100341:	68 80 a5 10 80       	push   $0x8010a580
80100346:	e8 55 43 00 00       	call   801046a0 <release>
  ilock(ip);
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 1d 13 00 00       	call   80101670 <ilock>

  return target - n;
80100353:	83 c4 10             	add    $0x10,%esp
80100356:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100359:	eb a0                	jmp    801002fb <consoleread+0x8b>
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
8010035b:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010035e:	76 05                	jbe    80100365 <consoleread+0xf5>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100360:	a3 00 00 11 80       	mov    %eax,0x80110000
80100365:	8b 45 10             	mov    0x10(%ebp),%eax
80100368:	29 d8                	sub    %ebx,%eax
8010036a:	eb cf                	jmp    8010033b <consoleread+0xcb>
8010036c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100370 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100378:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
80100379:	c7 05 b4 a5 10 80 00 	movl   $0x0,0x8010a5b4
80100380:	00 00 00 
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
80100383:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100386:	8d 75 f8             	lea    -0x8(%ebp),%esi
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
80100389:	e8 72 23 00 00       	call   80102700 <lapicid>
8010038e:	83 ec 08             	sub    $0x8,%esp
80100391:	50                   	push   %eax
80100392:	68 cd 71 10 80       	push   $0x801071cd
80100397:	e8 c4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
8010039c:	58                   	pop    %eax
8010039d:	ff 75 08             	pushl  0x8(%ebp)
801003a0:	e8 bb 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003a5:	c7 04 24 a7 78 10 80 	movl   $0x801078a7,(%esp)
801003ac:	e8 af 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003b1:	5a                   	pop    %edx
801003b2:	8d 45 08             	lea    0x8(%ebp),%eax
801003b5:	59                   	pop    %ecx
801003b6:	53                   	push   %ebx
801003b7:	50                   	push   %eax
801003b8:	e8 f3 40 00 00       	call   801044b0 <getcallerpcs>
801003bd:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003c0:	83 ec 08             	sub    $0x8,%esp
801003c3:	ff 33                	pushl  (%ebx)
801003c5:	83 c3 04             	add    $0x4,%ebx
801003c8:	68 e1 71 10 80       	push   $0x801071e1
801003cd:	e8 8e 02 00 00       	call   80100660 <cprintf>
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801003d2:	83 c4 10             	add    $0x10,%esp
801003d5:	39 f3                	cmp    %esi,%ebx
801003d7:	75 e7                	jne    801003c0 <panic+0x50>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003d9:	c7 05 b8 a5 10 80 01 	movl   $0x1,0x8010a5b8
801003e0:	00 00 00 
801003e3:	eb fe                	jmp    801003e3 <panic+0x73>
801003e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801003e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801003f0 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
801003f0:	8b 15 b8 a5 10 80    	mov    0x8010a5b8,%edx
801003f6:	85 d2                	test   %edx,%edx
801003f8:	74 06                	je     80100400 <consputc+0x10>
801003fa:	fa                   	cli    
801003fb:	eb fe                	jmp    801003fb <consputc+0xb>
801003fd:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 0c             	sub    $0xc,%esp
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 b8 00 00 00    	je     801004ce <consputc+0xde>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 61 59 00 00       	call   80105d80 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100434:	89 ca                	mov    %ecx,%edx
80100436:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	c1 e0 08             	shl    $0x8,%eax
8010043f:	89 c6                	mov    %eax,%esi
80100441:	b8 0f 00 00 00       	mov    $0xf,%eax
80100446:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100447:	89 ca                	mov    %ecx,%edx
80100449:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
8010044a:	0f b6 c0             	movzbl %al,%eax
8010044d:	09 f0                	or     %esi,%eax

  if(c == '\n')
8010044f:	83 fb 0a             	cmp    $0xa,%ebx
80100452:	0f 84 0b 01 00 00    	je     80100563 <consputc+0x173>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
80100458:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045e:	0f 84 e6 00 00 00    	je     8010054a <consputc+0x15a>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100464:	0f b6 d3             	movzbl %bl,%edx
80100467:	8d 78 01             	lea    0x1(%eax),%edi
8010046a:	80 ce 07             	or     $0x7,%dh
8010046d:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100474:	80 

  if(pos < 0 || pos > 25*80)
80100475:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010047b:	0f 8f bc 00 00 00    	jg     8010053d <consputc+0x14d>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
80100481:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100487:	7f 6f                	jg     801004f8 <consputc+0x108>
80100489:	89 f8                	mov    %edi,%eax
8010048b:	8d 9c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ebx
80100492:	89 f9                	mov    %edi,%ecx
80100494:	c1 e8 08             	shr    $0x8,%eax
80100497:	89 c6                	mov    %eax,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100499:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010049e:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a3:	89 fa                	mov    %edi,%edx
801004a5:	ee                   	out    %al,(%dx)
801004a6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004ab:	89 f0                	mov    %esi,%eax
801004ad:	ee                   	out    %al,(%dx)
801004ae:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b3:	89 fa                	mov    %edi,%edx
801004b5:	ee                   	out    %al,(%dx)
801004b6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004bb:	89 c8                	mov    %ecx,%eax
801004bd:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
801004be:	b8 20 07 00 00       	mov    $0x720,%eax
801004c3:	66 89 03             	mov    %ax,(%ebx)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
801004c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c9:	5b                   	pop    %ebx
801004ca:	5e                   	pop    %esi
801004cb:	5f                   	pop    %edi
801004cc:	5d                   	pop    %ebp
801004cd:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004ce:	83 ec 0c             	sub    $0xc,%esp
801004d1:	6a 08                	push   $0x8
801004d3:	e8 a8 58 00 00       	call   80105d80 <uartputc>
801004d8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004df:	e8 9c 58 00 00       	call   80105d80 <uartputc>
801004e4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004eb:	e8 90 58 00 00       	call   80105d80 <uartputc>
801004f0:	83 c4 10             	add    $0x10,%esp
801004f3:	e9 2a ff ff ff       	jmp    80100422 <consputc+0x32>

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f8:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004fb:	83 ef 50             	sub    $0x50,%edi
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004fe:	be 07 00 00 00       	mov    $0x7,%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100503:	68 60 0e 00 00       	push   $0xe60
80100508:	68 a0 80 0b 80       	push   $0x800b80a0
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010050d:	8d 9c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ebx

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100514:	68 00 80 0b 80       	push   $0x800b8000
80100519:	e8 82 42 00 00       	call   801047a0 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010051e:	b8 80 07 00 00       	mov    $0x780,%eax
80100523:	83 c4 0c             	add    $0xc,%esp
80100526:	29 f8                	sub    %edi,%eax
80100528:	01 c0                	add    %eax,%eax
8010052a:	50                   	push   %eax
8010052b:	6a 00                	push   $0x0
8010052d:	53                   	push   %ebx
8010052e:	e8 bd 41 00 00       	call   801046f0 <memset>
80100533:	89 f9                	mov    %edi,%ecx
80100535:	83 c4 10             	add    $0x10,%esp
80100538:	e9 5c ff ff ff       	jmp    80100499 <consputc+0xa9>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
8010053d:	83 ec 0c             	sub    $0xc,%esp
80100540:	68 e5 71 10 80       	push   $0x801071e5
80100545:	e8 26 fe ff ff       	call   80100370 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
8010054a:	85 c0                	test   %eax,%eax
8010054c:	8d 78 ff             	lea    -0x1(%eax),%edi
8010054f:	0f 85 20 ff ff ff    	jne    80100475 <consputc+0x85>
80100555:	bb 00 80 0b 80       	mov    $0x800b8000,%ebx
8010055a:	31 c9                	xor    %ecx,%ecx
8010055c:	31 f6                	xor    %esi,%esi
8010055e:	e9 36 ff ff ff       	jmp    80100499 <consputc+0xa9>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
80100563:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100568:	f7 ea                	imul   %edx
8010056a:	89 d0                	mov    %edx,%eax
8010056c:	c1 e8 05             	shr    $0x5,%eax
8010056f:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100572:	c1 e0 04             	shl    $0x4,%eax
80100575:	8d 78 50             	lea    0x50(%eax),%edi
80100578:	e9 f8 fe ff ff       	jmp    80100475 <consputc+0x85>
8010057d:	8d 76 00             	lea    0x0(%esi),%esi

80100580 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d6                	mov    %edx,%esi
80100588:	83 ec 1c             	sub    $0x1c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
8010058d:	74 04                	je     80100593 <printint+0x13>
8010058f:	85 c0                	test   %eax,%eax
80100591:	78 57                	js     801005ea <printint+0x6a>
    x = -xx;
  else
    x = xx;
80100593:	31 ff                	xor    %edi,%edi

  i = 0;
80100595:	31 c9                	xor    %ecx,%ecx
80100597:	eb 09                	jmp    801005a2 <printint+0x22>
80100599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
801005a0:	89 d9                	mov    %ebx,%ecx
801005a2:	31 d2                	xor    %edx,%edx
801005a4:	8d 59 01             	lea    0x1(%ecx),%ebx
801005a7:	f7 f6                	div    %esi
801005a9:	0f b6 92 10 72 10 80 	movzbl -0x7fef8df0(%edx),%edx
  }while((x /= base) != 0);
801005b0:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
801005b2:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
801005b6:	75 e8                	jne    801005a0 <printint+0x20>

  if(sign)
801005b8:	85 ff                	test   %edi,%edi
801005ba:	74 08                	je     801005c4 <printint+0x44>
    buf[i++] = '-';
801005bc:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
801005c1:	8d 59 02             	lea    0x2(%ecx),%ebx

  while(--i >= 0)
801005c4:	83 eb 01             	sub    $0x1,%ebx
801005c7:	89 f6                	mov    %esi,%esi
801005c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    consputc(buf[i]);
801005d0:	0f be 44 1d d8       	movsbl -0x28(%ebp,%ebx,1),%eax
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801005d5:	83 eb 01             	sub    $0x1,%ebx
    consputc(buf[i]);
801005d8:	e8 13 fe ff ff       	call   801003f0 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801005dd:	83 fb ff             	cmp    $0xffffffff,%ebx
801005e0:	75 ee                	jne    801005d0 <printint+0x50>
    consputc(buf[i]);
}
801005e2:	83 c4 1c             	add    $0x1c,%esp
801005e5:	5b                   	pop    %ebx
801005e6:	5e                   	pop    %esi
801005e7:	5f                   	pop    %edi
801005e8:	5d                   	pop    %ebp
801005e9:	c3                   	ret    
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
801005ea:	f7 d8                	neg    %eax
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
801005ec:	bf 01 00 00 00       	mov    $0x1,%edi
    x = -xx;
801005f1:	eb a2                	jmp    80100595 <printint+0x15>
801005f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100600 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100609:	ff 75 08             	pushl  0x8(%ebp)
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
8010060c:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060f:	e8 3c 11 00 00       	call   80101750 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
8010061b:	e8 d0 3f 00 00       	call   801045f0 <acquire>
80100620:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100623:	83 c4 10             	add    $0x10,%esp
80100626:	85 f6                	test   %esi,%esi
80100628:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062b:	7e 12                	jle    8010063f <consolewrite+0x3f>
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 b5 fd ff ff       	call   801003f0 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 80 a5 10 80       	push   $0x8010a580
80100647:	e8 54 40 00 00       	call   801046a0 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 1b 10 00 00       	call   80101670 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100669:	a1 b4 a5 10 80       	mov    0x8010a5b4,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100670:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100673:	0f 85 27 01 00 00    	jne    801007a0 <cprintf+0x140>
    acquire(&cons.lock);

  if (fmt == 0)
80100679:	8b 75 08             	mov    0x8(%ebp),%esi
8010067c:	85 f6                	test   %esi,%esi
8010067e:	0f 84 40 01 00 00    	je     801007c4 <cprintf+0x164>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100684:	0f b6 06             	movzbl (%esi),%eax
80100687:	31 db                	xor    %ebx,%ebx
80100689:	8d 7d 0c             	lea    0xc(%ebp),%edi
8010068c:	85 c0                	test   %eax,%eax
8010068e:	75 51                	jne    801006e1 <cprintf+0x81>
80100690:	eb 64                	jmp    801006f6 <cprintf+0x96>
80100692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
80100698:	83 c3 01             	add    $0x1,%ebx
8010069b:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
8010069f:	85 d2                	test   %edx,%edx
801006a1:	74 53                	je     801006f6 <cprintf+0x96>
      break;
    switch(c){
801006a3:	83 fa 70             	cmp    $0x70,%edx
801006a6:	74 7a                	je     80100722 <cprintf+0xc2>
801006a8:	7f 6e                	jg     80100718 <cprintf+0xb8>
801006aa:	83 fa 25             	cmp    $0x25,%edx
801006ad:	0f 84 ad 00 00 00    	je     80100760 <cprintf+0x100>
801006b3:	83 fa 64             	cmp    $0x64,%edx
801006b6:	0f 85 84 00 00 00    	jne    80100740 <cprintf+0xe0>
    case 'd':
      printint(*argp++, 10, 1);
801006bc:	8d 47 04             	lea    0x4(%edi),%eax
801006bf:	b9 01 00 00 00       	mov    $0x1,%ecx
801006c4:	ba 0a 00 00 00       	mov    $0xa,%edx
801006c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006cc:	8b 07                	mov    (%edi),%eax
801006ce:	e8 ad fe ff ff       	call   80100580 <printint>
801006d3:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d6:	83 c3 01             	add    $0x1,%ebx
801006d9:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801006dd:	85 c0                	test   %eax,%eax
801006df:	74 15                	je     801006f6 <cprintf+0x96>
    if(c != '%'){
801006e1:	83 f8 25             	cmp    $0x25,%eax
801006e4:	74 b2                	je     80100698 <cprintf+0x38>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801006e6:	e8 05 fd ff ff       	call   801003f0 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006eb:	83 c3 01             	add    $0x1,%ebx
801006ee:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801006f2:	85 c0                	test   %eax,%eax
801006f4:	75 eb                	jne    801006e1 <cprintf+0x81>
      consputc(c);
      break;
    }
  }

  if(locking)
801006f6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801006f9:	85 c0                	test   %eax,%eax
801006fb:	74 10                	je     8010070d <cprintf+0xad>
    release(&cons.lock);
801006fd:	83 ec 0c             	sub    $0xc,%esp
80100700:	68 80 a5 10 80       	push   $0x8010a580
80100705:	e8 96 3f 00 00       	call   801046a0 <release>
8010070a:	83 c4 10             	add    $0x10,%esp
}
8010070d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100710:	5b                   	pop    %ebx
80100711:	5e                   	pop    %esi
80100712:	5f                   	pop    %edi
80100713:	5d                   	pop    %ebp
80100714:	c3                   	ret    
80100715:	8d 76 00             	lea    0x0(%esi),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
80100718:	83 fa 73             	cmp    $0x73,%edx
8010071b:	74 53                	je     80100770 <cprintf+0x110>
8010071d:	83 fa 78             	cmp    $0x78,%edx
80100720:	75 1e                	jne    80100740 <cprintf+0xe0>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
80100722:	8d 47 04             	lea    0x4(%edi),%eax
80100725:	31 c9                	xor    %ecx,%ecx
80100727:	ba 10 00 00 00       	mov    $0x10,%edx
8010072c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010072f:	8b 07                	mov    (%edi),%eax
80100731:	e8 4a fe ff ff       	call   80100580 <printint>
80100736:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      break;
80100739:	eb 9b                	jmp    801006d6 <cprintf+0x76>
8010073b:	90                   	nop
8010073c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100740:	b8 25 00 00 00       	mov    $0x25,%eax
80100745:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100748:	e8 a3 fc ff ff       	call   801003f0 <consputc>
      consputc(c);
8010074d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100750:	89 d0                	mov    %edx,%eax
80100752:	e8 99 fc ff ff       	call   801003f0 <consputc>
      break;
80100757:	e9 7a ff ff ff       	jmp    801006d6 <cprintf+0x76>
8010075c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100760:	b8 25 00 00 00       	mov    $0x25,%eax
80100765:	e8 86 fc ff ff       	call   801003f0 <consputc>
8010076a:	e9 7c ff ff ff       	jmp    801006eb <cprintf+0x8b>
8010076f:	90                   	nop
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100770:	8d 47 04             	lea    0x4(%edi),%eax
80100773:	8b 3f                	mov    (%edi),%edi
80100775:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100778:	85 ff                	test   %edi,%edi
8010077a:	75 0c                	jne    80100788 <cprintf+0x128>
8010077c:	eb 3a                	jmp    801007b8 <cprintf+0x158>
8010077e:	66 90                	xchg   %ax,%ax
        s = "(null)";
      for(; *s; s++)
80100780:	83 c7 01             	add    $0x1,%edi
        consputc(*s);
80100783:	e8 68 fc ff ff       	call   801003f0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
80100788:	0f be 07             	movsbl (%edi),%eax
8010078b:	84 c0                	test   %al,%al
8010078d:	75 f1                	jne    80100780 <cprintf+0x120>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
8010078f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80100792:	e9 3f ff ff ff       	jmp    801006d6 <cprintf+0x76>
80100797:	89 f6                	mov    %esi,%esi
80100799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
801007a0:	83 ec 0c             	sub    $0xc,%esp
801007a3:	68 80 a5 10 80       	push   $0x8010a580
801007a8:	e8 43 3e 00 00       	call   801045f0 <acquire>
801007ad:	83 c4 10             	add    $0x10,%esp
801007b0:	e9 c4 fe ff ff       	jmp    80100679 <cprintf+0x19>
801007b5:	8d 76 00             	lea    0x0(%esi),%esi
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801007b8:	b8 28 00 00 00       	mov    $0x28,%eax
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
801007bd:	bf f8 71 10 80       	mov    $0x801071f8,%edi
801007c2:	eb bc                	jmp    80100780 <cprintf+0x120>
  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);

  if (fmt == 0)
    panic("null fmt");
801007c4:	83 ec 0c             	sub    $0xc,%esp
801007c7:	68 ff 71 10 80       	push   $0x801071ff
801007cc:	e8 9f fb ff ff       	call   80100370 <panic>
801007d1:	eb 0d                	jmp    801007e0 <consoleintr>
801007d3:	90                   	nop
801007d4:	90                   	nop
801007d5:	90                   	nop
801007d6:	90                   	nop
801007d7:	90                   	nop
801007d8:	90                   	nop
801007d9:	90                   	nop
801007da:	90                   	nop
801007db:	90                   	nop
801007dc:	90                   	nop
801007dd:	90                   	nop
801007de:	90                   	nop
801007df:	90                   	nop

801007e0 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007e0:	55                   	push   %ebp
801007e1:	89 e5                	mov    %esp,%ebp
801007e3:	57                   	push   %edi
801007e4:	56                   	push   %esi
801007e5:	53                   	push   %ebx
  int c, doprocdump = 0;
801007e6:	31 f6                	xor    %esi,%esi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007e8:	83 ec 18             	sub    $0x18,%esp
801007eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
801007ee:	68 80 a5 10 80       	push   $0x8010a580
801007f3:	e8 f8 3d 00 00       	call   801045f0 <acquire>
  while((c = getc()) >= 0){
801007f8:	83 c4 10             	add    $0x10,%esp
801007fb:	90                   	nop
801007fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100800:	ff d3                	call   *%ebx
80100802:	85 c0                	test   %eax,%eax
80100804:	89 c7                	mov    %eax,%edi
80100806:	78 48                	js     80100850 <consoleintr+0x70>
    switch(c){
80100808:	83 ff 10             	cmp    $0x10,%edi
8010080b:	0f 84 3f 01 00 00    	je     80100950 <consoleintr+0x170>
80100811:	7e 5d                	jle    80100870 <consoleintr+0x90>
80100813:	83 ff 15             	cmp    $0x15,%edi
80100816:	0f 84 dc 00 00 00    	je     801008f8 <consoleintr+0x118>
8010081c:	83 ff 7f             	cmp    $0x7f,%edi
8010081f:	75 54                	jne    80100875 <consoleintr+0x95>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100821:	a1 08 00 11 80       	mov    0x80110008,%eax
80100826:	3b 05 04 00 11 80    	cmp    0x80110004,%eax
8010082c:	74 d2                	je     80100800 <consoleintr+0x20>
        input.e--;
8010082e:	83 e8 01             	sub    $0x1,%eax
80100831:	a3 08 00 11 80       	mov    %eax,0x80110008
        consputc(BACKSPACE);
80100836:	b8 00 01 00 00       	mov    $0x100,%eax
8010083b:	e8 b0 fb ff ff       	call   801003f0 <consputc>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100840:	ff d3                	call   *%ebx
80100842:	85 c0                	test   %eax,%eax
80100844:	89 c7                	mov    %eax,%edi
80100846:	79 c0                	jns    80100808 <consoleintr+0x28>
80100848:	90                   	nop
80100849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100850:	83 ec 0c             	sub    $0xc,%esp
80100853:	68 80 a5 10 80       	push   $0x8010a580
80100858:	e8 43 3e 00 00       	call   801046a0 <release>
  if(doprocdump) {
8010085d:	83 c4 10             	add    $0x10,%esp
80100860:	85 f6                	test   %esi,%esi
80100862:	0f 85 f8 00 00 00    	jne    80100960 <consoleintr+0x180>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100868:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010086b:	5b                   	pop    %ebx
8010086c:	5e                   	pop    %esi
8010086d:	5f                   	pop    %edi
8010086e:	5d                   	pop    %ebp
8010086f:	c3                   	ret    
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100870:	83 ff 08             	cmp    $0x8,%edi
80100873:	74 ac                	je     80100821 <consoleintr+0x41>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100875:	85 ff                	test   %edi,%edi
80100877:	74 87                	je     80100800 <consoleintr+0x20>
80100879:	a1 08 00 11 80       	mov    0x80110008,%eax
8010087e:	89 c2                	mov    %eax,%edx
80100880:	2b 15 00 00 11 80    	sub    0x80110000,%edx
80100886:	83 fa 7f             	cmp    $0x7f,%edx
80100889:	0f 87 71 ff ff ff    	ja     80100800 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010088f:	8d 50 01             	lea    0x1(%eax),%edx
80100892:	83 e0 7f             	and    $0x7f,%eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
80100895:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100898:	89 15 08 00 11 80    	mov    %edx,0x80110008
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
8010089e:	0f 84 c8 00 00 00    	je     8010096c <consoleintr+0x18c>
        input.buf[input.e++ % INPUT_BUF] = c;
801008a4:	89 f9                	mov    %edi,%ecx
801008a6:	88 88 80 ff 10 80    	mov    %cl,-0x7fef0080(%eax)
        consputc(c);
801008ac:	89 f8                	mov    %edi,%eax
801008ae:	e8 3d fb ff ff       	call   801003f0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008b3:	83 ff 0a             	cmp    $0xa,%edi
801008b6:	0f 84 c1 00 00 00    	je     8010097d <consoleintr+0x19d>
801008bc:	83 ff 04             	cmp    $0x4,%edi
801008bf:	0f 84 b8 00 00 00    	je     8010097d <consoleintr+0x19d>
801008c5:	a1 00 00 11 80       	mov    0x80110000,%eax
801008ca:	83 e8 80             	sub    $0xffffff80,%eax
801008cd:	39 05 08 00 11 80    	cmp    %eax,0x80110008
801008d3:	0f 85 27 ff ff ff    	jne    80100800 <consoleintr+0x20>
          input.w = input.e;
          wakeup(&input.r);
801008d9:	83 ec 0c             	sub    $0xc,%esp
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
801008dc:	a3 04 00 11 80       	mov    %eax,0x80110004
          wakeup(&input.r);
801008e1:	68 00 00 11 80       	push   $0x80110000
801008e6:	e8 f5 36 00 00       	call   80103fe0 <wakeup>
801008eb:	83 c4 10             	add    $0x10,%esp
801008ee:	e9 0d ff ff ff       	jmp    80100800 <consoleintr+0x20>
801008f3:	90                   	nop
801008f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
801008f8:	a1 08 00 11 80       	mov    0x80110008,%eax
801008fd:	39 05 04 00 11 80    	cmp    %eax,0x80110004
80100903:	75 2b                	jne    80100930 <consoleintr+0x150>
80100905:	e9 f6 fe ff ff       	jmp    80100800 <consoleintr+0x20>
8010090a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100910:	a3 08 00 11 80       	mov    %eax,0x80110008
        consputc(BACKSPACE);
80100915:	b8 00 01 00 00       	mov    $0x100,%eax
8010091a:	e8 d1 fa ff ff       	call   801003f0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010091f:	a1 08 00 11 80       	mov    0x80110008,%eax
80100924:	3b 05 04 00 11 80    	cmp    0x80110004,%eax
8010092a:	0f 84 d0 fe ff ff    	je     80100800 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100930:	83 e8 01             	sub    $0x1,%eax
80100933:	89 c2                	mov    %eax,%edx
80100935:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100938:	80 ba 80 ff 10 80 0a 	cmpb   $0xa,-0x7fef0080(%edx)
8010093f:	75 cf                	jne    80100910 <consoleintr+0x130>
80100941:	e9 ba fe ff ff       	jmp    80100800 <consoleintr+0x20>
80100946:	8d 76 00             	lea    0x0(%esi),%esi
80100949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100950:	be 01 00 00 00       	mov    $0x1,%esi
80100955:	e9 a6 fe ff ff       	jmp    80100800 <consoleintr+0x20>
8010095a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100960:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100963:	5b                   	pop    %ebx
80100964:	5e                   	pop    %esi
80100965:	5f                   	pop    %edi
80100966:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100967:	e9 64 37 00 00       	jmp    801040d0 <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010096c:	c6 80 80 ff 10 80 0a 	movb   $0xa,-0x7fef0080(%eax)
        consputc(c);
80100973:	b8 0a 00 00 00       	mov    $0xa,%eax
80100978:	e8 73 fa ff ff       	call   801003f0 <consputc>
8010097d:	a1 08 00 11 80       	mov    0x80110008,%eax
80100982:	e9 52 ff ff ff       	jmp    801008d9 <consoleintr+0xf9>
80100987:	89 f6                	mov    %esi,%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100990 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
80100990:	55                   	push   %ebp
80100991:	89 e5                	mov    %esp,%ebp
80100993:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100996:	68 08 72 10 80       	push   $0x80107208
8010099b:	68 80 a5 10 80       	push   $0x8010a580
801009a0:	e8 eb 3a 00 00       	call   80104490 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009a5:	58                   	pop    %eax
801009a6:	5a                   	pop    %edx
801009a7:	6a 00                	push   $0x0
801009a9:	6a 01                	push   $0x1
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
801009ab:	c7 05 cc 09 11 80 00 	movl   $0x80100600,0x801109cc
801009b2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009b5:	c7 05 c8 09 11 80 70 	movl   $0x80100270,0x801109c8
801009bc:	02 10 80 
  cons.locking = 1;
801009bf:	c7 05 b4 a5 10 80 01 	movl   $0x1,0x8010a5b4
801009c6:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
801009c9:	e8 d2 18 00 00       	call   801022a0 <ioapicenable>
}
801009ce:	83 c4 10             	add    $0x10,%esp
801009d1:	c9                   	leave  
801009d2:	c3                   	ret    
801009d3:	66 90                	xchg   %ax,%ax
801009d5:	66 90                	xchg   %ax,%ax
801009d7:	66 90                	xchg   %ax,%ax
801009d9:	66 90                	xchg   %ax,%ax
801009db:	66 90                	xchg   %ax,%ax
801009dd:	66 90                	xchg   %ax,%ax
801009df:	90                   	nop

801009e0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009e0:	55                   	push   %ebp
801009e1:	89 e5                	mov    %esp,%ebp
801009e3:	57                   	push   %edi
801009e4:	56                   	push   %esi
801009e5:	53                   	push   %ebx
801009e6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801009ec:	e8 cf 2d 00 00       	call   801037c0 <myproc>
801009f1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
801009f7:	e8 74 21 00 00       	call   80102b70 <begin_op>

  if((ip = namei(path)) == 0){
801009fc:	83 ec 0c             	sub    $0xc,%esp
801009ff:	ff 75 08             	pushl  0x8(%ebp)
80100a02:	e8 b9 14 00 00       	call   80101ec0 <namei>
80100a07:	83 c4 10             	add    $0x10,%esp
80100a0a:	85 c0                	test   %eax,%eax
80100a0c:	0f 84 9c 01 00 00    	je     80100bae <exec+0x1ce>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a12:	83 ec 0c             	sub    $0xc,%esp
80100a15:	89 c3                	mov    %eax,%ebx
80100a17:	50                   	push   %eax
80100a18:	e8 53 0c 00 00       	call   80101670 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a1d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a23:	6a 34                	push   $0x34
80100a25:	6a 00                	push   $0x0
80100a27:	50                   	push   %eax
80100a28:	53                   	push   %ebx
80100a29:	e8 22 0f 00 00       	call   80101950 <readi>
80100a2e:	83 c4 20             	add    $0x20,%esp
80100a31:	83 f8 34             	cmp    $0x34,%eax
80100a34:	74 22                	je     80100a58 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a36:	83 ec 0c             	sub    $0xc,%esp
80100a39:	53                   	push   %ebx
80100a3a:	e8 c1 0e 00 00       	call   80101900 <iunlockput>
    end_op();
80100a3f:	e8 9c 21 00 00       	call   80102be0 <end_op>
80100a44:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a47:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a4f:	5b                   	pop    %ebx
80100a50:	5e                   	pop    %esi
80100a51:	5f                   	pop    %edi
80100a52:	5d                   	pop    %ebp
80100a53:	c3                   	ret    
80100a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100a58:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a5f:	45 4c 46 
80100a62:	75 d2                	jne    80100a36 <exec+0x56>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100a64:	e8 97 64 00 00       	call   80106f00 <setupkvm>
80100a69:	85 c0                	test   %eax,%eax
80100a6b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a71:	74 c3                	je     80100a36 <exec+0x56>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a73:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a7a:	00 
80100a7b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100a81:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100a88:	00 00 00 
80100a8b:	0f 84 c5 00 00 00    	je     80100b56 <exec+0x176>
80100a91:	31 ff                	xor    %edi,%edi
80100a93:	eb 18                	jmp    80100aad <exec+0xcd>
80100a95:	8d 76 00             	lea    0x0(%esi),%esi
80100a98:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100a9f:	83 c7 01             	add    $0x1,%edi
80100aa2:	83 c6 20             	add    $0x20,%esi
80100aa5:	39 f8                	cmp    %edi,%eax
80100aa7:	0f 8e a9 00 00 00    	jle    80100b56 <exec+0x176>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100aad:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100ab3:	6a 20                	push   $0x20
80100ab5:	56                   	push   %esi
80100ab6:	50                   	push   %eax
80100ab7:	53                   	push   %ebx
80100ab8:	e8 93 0e 00 00       	call   80101950 <readi>
80100abd:	83 c4 10             	add    $0x10,%esp
80100ac0:	83 f8 20             	cmp    $0x20,%eax
80100ac3:	75 7b                	jne    80100b40 <exec+0x160>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100ac5:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100acc:	75 ca                	jne    80100a98 <exec+0xb8>
      continue;
    if(ph.memsz < ph.filesz)
80100ace:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ad4:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100ada:	72 64                	jb     80100b40 <exec+0x160>
80100adc:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ae2:	72 5c                	jb     80100b40 <exec+0x160>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100ae4:	83 ec 04             	sub    $0x4,%esp
80100ae7:	50                   	push   %eax
80100ae8:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100aee:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100af4:	e8 67 62 00 00       	call   80106d60 <allocuvm>
80100af9:	83 c4 10             	add    $0x10,%esp
80100afc:	85 c0                	test   %eax,%eax
80100afe:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100b04:	74 3a                	je     80100b40 <exec+0x160>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100b06:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b0c:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b11:	75 2d                	jne    80100b40 <exec+0x160>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b13:	83 ec 0c             	sub    $0xc,%esp
80100b16:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b1c:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b22:	53                   	push   %ebx
80100b23:	50                   	push   %eax
80100b24:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b2a:	e8 71 61 00 00       	call   80106ca0 <loaduvm>
80100b2f:	83 c4 20             	add    $0x20,%esp
80100b32:	85 c0                	test   %eax,%eax
80100b34:	0f 89 5e ff ff ff    	jns    80100a98 <exec+0xb8>
80100b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b40:	83 ec 0c             	sub    $0xc,%esp
80100b43:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b49:	e8 32 63 00 00       	call   80106e80 <freevm>
80100b4e:	83 c4 10             	add    $0x10,%esp
80100b51:	e9 e0 fe ff ff       	jmp    80100a36 <exec+0x56>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100b56:	83 ec 0c             	sub    $0xc,%esp
80100b59:	53                   	push   %ebx
80100b5a:	e8 a1 0d 00 00       	call   80101900 <iunlockput>
  end_op();
80100b5f:	e8 7c 20 00 00       	call   80102be0 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b64:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b6a:	83 c4 0c             	add    $0xc,%esp
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b6d:	05 ff 0f 00 00       	add    $0xfff,%eax
80100b72:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b77:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100b7d:	52                   	push   %edx
80100b7e:	50                   	push   %eax
80100b7f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b85:	e8 d6 61 00 00       	call   80106d60 <allocuvm>
80100b8a:	83 c4 10             	add    $0x10,%esp
80100b8d:	85 c0                	test   %eax,%eax
80100b8f:	89 c6                	mov    %eax,%esi
80100b91:	75 3a                	jne    80100bcd <exec+0x1ed>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b93:	83 ec 0c             	sub    $0xc,%esp
80100b96:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b9c:	e8 df 62 00 00       	call   80106e80 <freevm>
80100ba1:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100ba4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ba9:	e9 9e fe ff ff       	jmp    80100a4c <exec+0x6c>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100bae:	e8 2d 20 00 00       	call   80102be0 <end_op>
    cprintf("exec: fail\n");
80100bb3:	83 ec 0c             	sub    $0xc,%esp
80100bb6:	68 21 72 10 80       	push   $0x80107221
80100bbb:	e8 a0 fa ff ff       	call   80100660 <cprintf>
    return -1;
80100bc0:	83 c4 10             	add    $0x10,%esp
80100bc3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bc8:	e9 7f fe ff ff       	jmp    80100a4c <exec+0x6c>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bcd:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100bd3:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bd6:	31 ff                	xor    %edi,%edi
80100bd8:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bda:	50                   	push   %eax
80100bdb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100be1:	e8 ba 63 00 00       	call   80106fa0 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100be6:	8b 45 0c             	mov    0xc(%ebp),%eax
80100be9:	83 c4 10             	add    $0x10,%esp
80100bec:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100bf2:	8b 00                	mov    (%eax),%eax
80100bf4:	85 c0                	test   %eax,%eax
80100bf6:	74 79                	je     80100c71 <exec+0x291>
80100bf8:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100bfe:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c04:	eb 13                	jmp    80100c19 <exec+0x239>
80100c06:	8d 76 00             	lea    0x0(%esi),%esi
80100c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(argc >= MAXARG)
80100c10:	83 ff 20             	cmp    $0x20,%edi
80100c13:	0f 84 7a ff ff ff    	je     80100b93 <exec+0x1b3>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c19:	83 ec 0c             	sub    $0xc,%esp
80100c1c:	50                   	push   %eax
80100c1d:	e8 ee 3c 00 00       	call   80104910 <strlen>
80100c22:	f7 d0                	not    %eax
80100c24:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c26:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c29:	5a                   	pop    %edx

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c2a:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c2d:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c30:	e8 db 3c 00 00       	call   80104910 <strlen>
80100c35:	83 c0 01             	add    $0x1,%eax
80100c38:	50                   	push   %eax
80100c39:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c3c:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c3f:	53                   	push   %ebx
80100c40:	56                   	push   %esi
80100c41:	e8 ba 64 00 00       	call   80107100 <copyout>
80100c46:	83 c4 20             	add    $0x20,%esp
80100c49:	85 c0                	test   %eax,%eax
80100c4b:	0f 88 42 ff ff ff    	js     80100b93 <exec+0x1b3>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c51:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c54:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c5b:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c5e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c64:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c67:	85 c0                	test   %eax,%eax
80100c69:	75 a5                	jne    80100c10 <exec+0x230>
80100c6b:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c71:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c78:	89 d9                	mov    %ebx,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100c7a:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c81:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100c85:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100c8c:	ff ff ff 
  ustack[1] = argc;
80100c8f:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c95:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80100c97:	83 c0 0c             	add    $0xc,%eax
80100c9a:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c9c:	50                   	push   %eax
80100c9d:	52                   	push   %edx
80100c9e:	53                   	push   %ebx
80100c9f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ca5:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cab:	e8 50 64 00 00       	call   80107100 <copyout>
80100cb0:	83 c4 10             	add    $0x10,%esp
80100cb3:	85 c0                	test   %eax,%eax
80100cb5:	0f 88 d8 fe ff ff    	js     80100b93 <exec+0x1b3>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cbb:	8b 45 08             	mov    0x8(%ebp),%eax
80100cbe:	0f b6 10             	movzbl (%eax),%edx
80100cc1:	84 d2                	test   %dl,%dl
80100cc3:	74 19                	je     80100cde <exec+0x2fe>
80100cc5:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100cc8:	83 c0 01             	add    $0x1,%eax
    if(*s == '/')
      last = s+1;
80100ccb:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cce:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100cd1:	0f 44 c8             	cmove  %eax,%ecx
80100cd4:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cd7:	84 d2                	test   %dl,%dl
80100cd9:	75 f0                	jne    80100ccb <exec+0x2eb>
80100cdb:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cde:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100ce4:	50                   	push   %eax
80100ce5:	6a 10                	push   $0x10
80100ce7:	ff 75 08             	pushl  0x8(%ebp)
80100cea:	89 f8                	mov    %edi,%eax
80100cec:	83 c0 6c             	add    $0x6c,%eax
80100cef:	50                   	push   %eax
80100cf0:	e8 db 3b 00 00       	call   801048d0 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100cf5:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100cfb:	89 f8                	mov    %edi,%eax
80100cfd:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->pgdir = pgdir;
  curproc->sz = sz;
80100d00:	89 30                	mov    %esi,(%eax)
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100d02:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80100d05:	89 c1                	mov    %eax,%ecx
80100d07:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d0d:	8b 40 18             	mov    0x18(%eax),%eax
80100d10:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d13:	8b 41 18             	mov    0x18(%ecx),%eax
80100d16:	89 58 44             	mov    %ebx,0x44(%eax)
  curproc->priority = 30;   // Priority for System Calls.
80100d19:	c7 41 7c 1e 00 00 00 	movl   $0x1e,0x7c(%ecx)
  switchuvm(curproc);
80100d20:	89 0c 24             	mov    %ecx,(%esp)
80100d23:	e8 e8 5d 00 00       	call   80106b10 <switchuvm>
  freevm(oldpgdir);
80100d28:	89 3c 24             	mov    %edi,(%esp)
80100d2b:	e8 50 61 00 00       	call   80106e80 <freevm>
  return 0;
80100d30:	83 c4 10             	add    $0x10,%esp
80100d33:	31 c0                	xor    %eax,%eax
80100d35:	e9 12 fd ff ff       	jmp    80100a4c <exec+0x6c>
80100d3a:	66 90                	xchg   %ax,%ax
80100d3c:	66 90                	xchg   %ax,%ax
80100d3e:	66 90                	xchg   %ax,%ax

80100d40 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d40:	55                   	push   %ebp
80100d41:	89 e5                	mov    %esp,%ebp
80100d43:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d46:	68 2d 72 10 80       	push   $0x8010722d
80100d4b:	68 20 00 11 80       	push   $0x80110020
80100d50:	e8 3b 37 00 00       	call   80104490 <initlock>
}
80100d55:	83 c4 10             	add    $0x10,%esp
80100d58:	c9                   	leave  
80100d59:	c3                   	ret    
80100d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d60 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d60:	55                   	push   %ebp
80100d61:	89 e5                	mov    %esp,%ebp
80100d63:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d64:	bb 54 00 11 80       	mov    $0x80110054,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d69:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100d6c:	68 20 00 11 80       	push   $0x80110020
80100d71:	e8 7a 38 00 00       	call   801045f0 <acquire>
80100d76:	83 c4 10             	add    $0x10,%esp
80100d79:	eb 10                	jmp    80100d8b <filealloc+0x2b>
80100d7b:	90                   	nop
80100d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d80:	83 c3 18             	add    $0x18,%ebx
80100d83:	81 fb b4 09 11 80    	cmp    $0x801109b4,%ebx
80100d89:	73 25                	jae    80100db0 <filealloc+0x50>
    if(f->ref == 0){
80100d8b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d8e:	85 c0                	test   %eax,%eax
80100d90:	75 ee                	jne    80100d80 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100d92:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80100d95:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100d9c:	68 20 00 11 80       	push   $0x80110020
80100da1:	e8 fa 38 00 00       	call   801046a0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100da6:	89 d8                	mov    %ebx,%eax
  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
      release(&ftable.lock);
      return f;
80100da8:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dae:	c9                   	leave  
80100daf:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100db0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100db3:	31 db                	xor    %ebx,%ebx
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100db5:	68 20 00 11 80       	push   $0x80110020
80100dba:	e8 e1 38 00 00       	call   801046a0 <release>
  return 0;
}
80100dbf:	89 d8                	mov    %ebx,%eax
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
80100dc1:	83 c4 10             	add    $0x10,%esp
}
80100dc4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dc7:	c9                   	leave  
80100dc8:	c3                   	ret    
80100dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100dd0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100dd0:	55                   	push   %ebp
80100dd1:	89 e5                	mov    %esp,%ebp
80100dd3:	53                   	push   %ebx
80100dd4:	83 ec 10             	sub    $0x10,%esp
80100dd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dda:	68 20 00 11 80       	push   $0x80110020
80100ddf:	e8 0c 38 00 00       	call   801045f0 <acquire>
  if(f->ref < 1)
80100de4:	8b 43 04             	mov    0x4(%ebx),%eax
80100de7:	83 c4 10             	add    $0x10,%esp
80100dea:	85 c0                	test   %eax,%eax
80100dec:	7e 1a                	jle    80100e08 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100dee:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100df1:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
80100df4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100df7:	68 20 00 11 80       	push   $0x80110020
80100dfc:	e8 9f 38 00 00       	call   801046a0 <release>
  return f;
}
80100e01:	89 d8                	mov    %ebx,%eax
80100e03:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e06:	c9                   	leave  
80100e07:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100e08:	83 ec 0c             	sub    $0xc,%esp
80100e0b:	68 34 72 10 80       	push   $0x80107234
80100e10:	e8 5b f5 ff ff       	call   80100370 <panic>
80100e15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e20 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e20:	55                   	push   %ebp
80100e21:	89 e5                	mov    %esp,%ebp
80100e23:	57                   	push   %edi
80100e24:	56                   	push   %esi
80100e25:	53                   	push   %ebx
80100e26:	83 ec 28             	sub    $0x28,%esp
80100e29:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100e2c:	68 20 00 11 80       	push   $0x80110020
80100e31:	e8 ba 37 00 00       	call   801045f0 <acquire>
  if(f->ref < 1)
80100e36:	8b 47 04             	mov    0x4(%edi),%eax
80100e39:	83 c4 10             	add    $0x10,%esp
80100e3c:	85 c0                	test   %eax,%eax
80100e3e:	0f 8e 9b 00 00 00    	jle    80100edf <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e44:	83 e8 01             	sub    $0x1,%eax
80100e47:	85 c0                	test   %eax,%eax
80100e49:	89 47 04             	mov    %eax,0x4(%edi)
80100e4c:	74 1a                	je     80100e68 <fileclose+0x48>
    release(&ftable.lock);
80100e4e:	c7 45 08 20 00 11 80 	movl   $0x80110020,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e55:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e58:	5b                   	pop    %ebx
80100e59:	5e                   	pop    %esi
80100e5a:	5f                   	pop    %edi
80100e5b:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100e5c:	e9 3f 38 00 00       	jmp    801046a0 <release>
80100e61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
80100e68:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100e6c:	8b 1f                	mov    (%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e6e:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e71:	8b 77 0c             	mov    0xc(%edi),%esi
  f->ref = 0;
  f->type = FD_NONE;
80100e74:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e7a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e7d:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e80:	68 20 00 11 80       	push   $0x80110020
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e85:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e88:	e8 13 38 00 00       	call   801046a0 <release>

  if(ff.type == FD_PIPE)
80100e8d:	83 c4 10             	add    $0x10,%esp
80100e90:	83 fb 01             	cmp    $0x1,%ebx
80100e93:	74 13                	je     80100ea8 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100e95:	83 fb 02             	cmp    $0x2,%ebx
80100e98:	74 26                	je     80100ec0 <fileclose+0xa0>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e9d:	5b                   	pop    %ebx
80100e9e:	5e                   	pop    %esi
80100e9f:	5f                   	pop    %edi
80100ea0:	5d                   	pop    %ebp
80100ea1:	c3                   	ret    
80100ea2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100ea8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100eac:	83 ec 08             	sub    $0x8,%esp
80100eaf:	53                   	push   %ebx
80100eb0:	56                   	push   %esi
80100eb1:	e8 4a 24 00 00       	call   80103300 <pipeclose>
80100eb6:	83 c4 10             	add    $0x10,%esp
80100eb9:	eb df                	jmp    80100e9a <fileclose+0x7a>
80100ebb:	90                   	nop
80100ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80100ec0:	e8 ab 1c 00 00       	call   80102b70 <begin_op>
    iput(ff.ip);
80100ec5:	83 ec 0c             	sub    $0xc,%esp
80100ec8:	ff 75 e0             	pushl  -0x20(%ebp)
80100ecb:	e8 d0 08 00 00       	call   801017a0 <iput>
    end_op();
80100ed0:	83 c4 10             	add    $0x10,%esp
  }
}
80100ed3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ed6:	5b                   	pop    %ebx
80100ed7:	5e                   	pop    %esi
80100ed8:	5f                   	pop    %edi
80100ed9:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80100eda:	e9 01 1d 00 00       	jmp    80102be0 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100edf:	83 ec 0c             	sub    $0xc,%esp
80100ee2:	68 3c 72 10 80       	push   $0x8010723c
80100ee7:	e8 84 f4 ff ff       	call   80100370 <panic>
80100eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ef0 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100ef0:	55                   	push   %ebp
80100ef1:	89 e5                	mov    %esp,%ebp
80100ef3:	53                   	push   %ebx
80100ef4:	83 ec 04             	sub    $0x4,%esp
80100ef7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100efa:	83 3b 02             	cmpl   $0x2,(%ebx)
80100efd:	75 31                	jne    80100f30 <filestat+0x40>
    ilock(f->ip);
80100eff:	83 ec 0c             	sub    $0xc,%esp
80100f02:	ff 73 10             	pushl  0x10(%ebx)
80100f05:	e8 66 07 00 00       	call   80101670 <ilock>
    stati(f->ip, st);
80100f0a:	58                   	pop    %eax
80100f0b:	5a                   	pop    %edx
80100f0c:	ff 75 0c             	pushl  0xc(%ebp)
80100f0f:	ff 73 10             	pushl  0x10(%ebx)
80100f12:	e8 09 0a 00 00       	call   80101920 <stati>
    iunlock(f->ip);
80100f17:	59                   	pop    %ecx
80100f18:	ff 73 10             	pushl  0x10(%ebx)
80100f1b:	e8 30 08 00 00       	call   80101750 <iunlock>
    return 0;
80100f20:	83 c4 10             	add    $0x10,%esp
80100f23:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f25:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f28:	c9                   	leave  
80100f29:	c3                   	ret    
80100f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80100f30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f38:	c9                   	leave  
80100f39:	c3                   	ret    
80100f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f40 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f40:	55                   	push   %ebp
80100f41:	89 e5                	mov    %esp,%ebp
80100f43:	57                   	push   %edi
80100f44:	56                   	push   %esi
80100f45:	53                   	push   %ebx
80100f46:	83 ec 0c             	sub    $0xc,%esp
80100f49:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f4c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f4f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f52:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f56:	74 60                	je     80100fb8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f58:	8b 03                	mov    (%ebx),%eax
80100f5a:	83 f8 01             	cmp    $0x1,%eax
80100f5d:	74 41                	je     80100fa0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f5f:	83 f8 02             	cmp    $0x2,%eax
80100f62:	75 5b                	jne    80100fbf <fileread+0x7f>
    ilock(f->ip);
80100f64:	83 ec 0c             	sub    $0xc,%esp
80100f67:	ff 73 10             	pushl  0x10(%ebx)
80100f6a:	e8 01 07 00 00       	call   80101670 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f6f:	57                   	push   %edi
80100f70:	ff 73 14             	pushl  0x14(%ebx)
80100f73:	56                   	push   %esi
80100f74:	ff 73 10             	pushl  0x10(%ebx)
80100f77:	e8 d4 09 00 00       	call   80101950 <readi>
80100f7c:	83 c4 20             	add    $0x20,%esp
80100f7f:	85 c0                	test   %eax,%eax
80100f81:	89 c6                	mov    %eax,%esi
80100f83:	7e 03                	jle    80100f88 <fileread+0x48>
      f->off += r;
80100f85:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100f88:	83 ec 0c             	sub    $0xc,%esp
80100f8b:	ff 73 10             	pushl  0x10(%ebx)
80100f8e:	e8 bd 07 00 00       	call   80101750 <iunlock>
    return r;
80100f93:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100f96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f99:	89 f0                	mov    %esi,%eax
80100f9b:	5b                   	pop    %ebx
80100f9c:	5e                   	pop    %esi
80100f9d:	5f                   	pop    %edi
80100f9e:	5d                   	pop    %ebp
80100f9f:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fa0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fa3:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100fa6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fa9:	5b                   	pop    %ebx
80100faa:	5e                   	pop    %esi
80100fab:	5f                   	pop    %edi
80100fac:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fad:	e9 fe 24 00 00       	jmp    801034b0 <piperead>
80100fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80100fb8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100fbd:	eb d7                	jmp    80100f96 <fileread+0x56>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80100fbf:	83 ec 0c             	sub    $0xc,%esp
80100fc2:	68 46 72 10 80       	push   $0x80107246
80100fc7:	e8 a4 f3 ff ff       	call   80100370 <panic>
80100fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100fd0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fd0:	55                   	push   %ebp
80100fd1:	89 e5                	mov    %esp,%ebp
80100fd3:	57                   	push   %edi
80100fd4:	56                   	push   %esi
80100fd5:	53                   	push   %ebx
80100fd6:	83 ec 1c             	sub    $0x1c,%esp
80100fd9:	8b 75 08             	mov    0x8(%ebp),%esi
80100fdc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fdf:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fe3:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100fe6:	8b 45 10             	mov    0x10(%ebp),%eax
80100fe9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80100fec:	0f 84 aa 00 00 00    	je     8010109c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80100ff2:	8b 06                	mov    (%esi),%eax
80100ff4:	83 f8 01             	cmp    $0x1,%eax
80100ff7:	0f 84 c2 00 00 00    	je     801010bf <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100ffd:	83 f8 02             	cmp    $0x2,%eax
80101000:	0f 85 e4 00 00 00    	jne    801010ea <filewrite+0x11a>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101006:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101009:	31 ff                	xor    %edi,%edi
8010100b:	85 c0                	test   %eax,%eax
8010100d:	7f 34                	jg     80101043 <filewrite+0x73>
8010100f:	e9 9c 00 00 00       	jmp    801010b0 <filewrite+0xe0>
80101014:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101018:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010101b:	83 ec 0c             	sub    $0xc,%esp
8010101e:	ff 76 10             	pushl  0x10(%esi)
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101021:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101024:	e8 27 07 00 00       	call   80101750 <iunlock>
      end_op();
80101029:	e8 b2 1b 00 00       	call   80102be0 <end_op>
8010102e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101031:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101034:	39 d8                	cmp    %ebx,%eax
80101036:	0f 85 a1 00 00 00    	jne    801010dd <filewrite+0x10d>
        panic("short filewrite");
      i += r;
8010103c:	01 c7                	add    %eax,%edi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010103e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101041:	7e 6d                	jle    801010b0 <filewrite+0xe0>
      int n1 = n - i;
80101043:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101046:	b8 00 06 00 00       	mov    $0x600,%eax
8010104b:	29 fb                	sub    %edi,%ebx
8010104d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101053:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
80101056:	e8 15 1b 00 00       	call   80102b70 <begin_op>
      ilock(f->ip);
8010105b:	83 ec 0c             	sub    $0xc,%esp
8010105e:	ff 76 10             	pushl  0x10(%esi)
80101061:	e8 0a 06 00 00       	call   80101670 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101066:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101069:	53                   	push   %ebx
8010106a:	ff 76 14             	pushl  0x14(%esi)
8010106d:	01 f8                	add    %edi,%eax
8010106f:	50                   	push   %eax
80101070:	ff 76 10             	pushl  0x10(%esi)
80101073:	e8 d8 09 00 00       	call   80101a50 <writei>
80101078:	83 c4 20             	add    $0x20,%esp
8010107b:	85 c0                	test   %eax,%eax
8010107d:	7f 99                	jg     80101018 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
8010107f:	83 ec 0c             	sub    $0xc,%esp
80101082:	ff 76 10             	pushl  0x10(%esi)
80101085:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101088:	e8 c3 06 00 00       	call   80101750 <iunlock>
      end_op();
8010108d:	e8 4e 1b 00 00       	call   80102be0 <end_op>

      if(r < 0)
80101092:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101095:	83 c4 10             	add    $0x10,%esp
80101098:	85 c0                	test   %eax,%eax
8010109a:	74 98                	je     80101034 <filewrite+0x64>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010109c:	8d 65 f4             	lea    -0xc(%ebp),%esp
filewrite(struct file *f, char *addr, int n)
{
  int r;

  if(f->writable == 0)
    return -1;
8010109f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010a4:	5b                   	pop    %ebx
801010a5:	5e                   	pop    %esi
801010a6:	5f                   	pop    %edi
801010a7:	5d                   	pop    %ebp
801010a8:	c3                   	ret    
801010a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801010b0:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
801010b3:	75 e7                	jne    8010109c <filewrite+0xcc>
  }
  panic("filewrite");
}
801010b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010b8:	89 f8                	mov    %edi,%eax
801010ba:	5b                   	pop    %ebx
801010bb:	5e                   	pop    %esi
801010bc:	5f                   	pop    %edi
801010bd:	5d                   	pop    %ebp
801010be:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801010c2:	89 45 10             	mov    %eax,0x10(%ebp)
801010c5:	8b 45 dc             	mov    -0x24(%ebp),%eax
801010c8:	89 45 0c             	mov    %eax,0xc(%ebp)
801010cb:	8b 46 0c             	mov    0xc(%esi),%eax
801010ce:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d4:	5b                   	pop    %ebx
801010d5:	5e                   	pop    %esi
801010d6:	5f                   	pop    %edi
801010d7:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010d8:	e9 c3 22 00 00       	jmp    801033a0 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
801010dd:	83 ec 0c             	sub    $0xc,%esp
801010e0:	68 4f 72 10 80       	push   $0x8010724f
801010e5:	e8 86 f2 ff ff       	call   80100370 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801010ea:	83 ec 0c             	sub    $0xc,%esp
801010ed:	68 55 72 10 80       	push   $0x80107255
801010f2:	e8 79 f2 ff ff       	call   80100370 <panic>
801010f7:	66 90                	xchg   %ax,%ax
801010f9:	66 90                	xchg   %ax,%ax
801010fb:	66 90                	xchg   %ax,%ax
801010fd:	66 90                	xchg   %ax,%ax
801010ff:	90                   	nop

80101100 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101100:	55                   	push   %ebp
80101101:	89 e5                	mov    %esp,%ebp
80101103:	57                   	push   %edi
80101104:	56                   	push   %esi
80101105:	53                   	push   %ebx
80101106:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101109:	8b 0d 20 0a 11 80    	mov    0x80110a20,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010110f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101112:	85 c9                	test   %ecx,%ecx
80101114:	0f 84 87 00 00 00    	je     801011a1 <balloc+0xa1>
8010111a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101121:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101124:	83 ec 08             	sub    $0x8,%esp
80101127:	89 f0                	mov    %esi,%eax
80101129:	c1 f8 0c             	sar    $0xc,%eax
8010112c:	03 05 38 0a 11 80    	add    0x80110a38,%eax
80101132:	50                   	push   %eax
80101133:	ff 75 d8             	pushl  -0x28(%ebp)
80101136:	e8 95 ef ff ff       	call   801000d0 <bread>
8010113b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010113e:	a1 20 0a 11 80       	mov    0x80110a20,%eax
80101143:	83 c4 10             	add    $0x10,%esp
80101146:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101149:	31 c0                	xor    %eax,%eax
8010114b:	eb 2f                	jmp    8010117c <balloc+0x7c>
8010114d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101150:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101152:	8b 55 e4             	mov    -0x1c(%ebp),%edx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
80101155:	bb 01 00 00 00       	mov    $0x1,%ebx
8010115a:	83 e1 07             	and    $0x7,%ecx
8010115d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010115f:	89 c1                	mov    %eax,%ecx
80101161:	c1 f9 03             	sar    $0x3,%ecx
80101164:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101169:	85 df                	test   %ebx,%edi
8010116b:	89 fa                	mov    %edi,%edx
8010116d:	74 41                	je     801011b0 <balloc+0xb0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010116f:	83 c0 01             	add    $0x1,%eax
80101172:	83 c6 01             	add    $0x1,%esi
80101175:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010117a:	74 05                	je     80101181 <balloc+0x81>
8010117c:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010117f:	72 cf                	jb     80101150 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101181:	83 ec 0c             	sub    $0xc,%esp
80101184:	ff 75 e4             	pushl  -0x1c(%ebp)
80101187:	e8 54 f0 ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010118c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101193:	83 c4 10             	add    $0x10,%esp
80101196:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101199:	39 05 20 0a 11 80    	cmp    %eax,0x80110a20
8010119f:	77 80                	ja     80101121 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
801011a1:	83 ec 0c             	sub    $0xc,%esp
801011a4:	68 5f 72 10 80       	push   $0x8010725f
801011a9:	e8 c2 f1 ff ff       	call   80100370 <panic>
801011ae:	66 90                	xchg   %ax,%ax
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
801011b0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801011b3:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
801011b6:	09 da                	or     %ebx,%edx
801011b8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801011bc:	57                   	push   %edi
801011bd:	e8 8e 1b 00 00       	call   80102d50 <log_write>
        brelse(bp);
801011c2:	89 3c 24             	mov    %edi,(%esp)
801011c5:	e8 16 f0 ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
801011ca:	58                   	pop    %eax
801011cb:	5a                   	pop    %edx
801011cc:	56                   	push   %esi
801011cd:	ff 75 d8             	pushl  -0x28(%ebp)
801011d0:	e8 fb ee ff ff       	call   801000d0 <bread>
801011d5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801011d7:	8d 40 5c             	lea    0x5c(%eax),%eax
801011da:	83 c4 0c             	add    $0xc,%esp
801011dd:	68 00 02 00 00       	push   $0x200
801011e2:	6a 00                	push   $0x0
801011e4:	50                   	push   %eax
801011e5:	e8 06 35 00 00       	call   801046f0 <memset>
  log_write(bp);
801011ea:	89 1c 24             	mov    %ebx,(%esp)
801011ed:	e8 5e 1b 00 00       	call   80102d50 <log_write>
  brelse(bp);
801011f2:	89 1c 24             	mov    %ebx,(%esp)
801011f5:	e8 e6 ef ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
801011fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011fd:	89 f0                	mov    %esi,%eax
801011ff:	5b                   	pop    %ebx
80101200:	5e                   	pop    %esi
80101201:	5f                   	pop    %edi
80101202:	5d                   	pop    %ebp
80101203:	c3                   	ret    
80101204:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010120a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101210 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101210:	55                   	push   %ebp
80101211:	89 e5                	mov    %esp,%ebp
80101213:	57                   	push   %edi
80101214:	56                   	push   %esi
80101215:	53                   	push   %ebx
80101216:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101218:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010121a:	bb 74 0a 11 80       	mov    $0x80110a74,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
8010121f:	83 ec 28             	sub    $0x28,%esp
80101222:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101225:	68 40 0a 11 80       	push   $0x80110a40
8010122a:	e8 c1 33 00 00       	call   801045f0 <acquire>
8010122f:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101232:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101235:	eb 1b                	jmp    80101252 <iget+0x42>
80101237:	89 f6                	mov    %esi,%esi
80101239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101240:	85 f6                	test   %esi,%esi
80101242:	74 44                	je     80101288 <iget+0x78>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101244:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010124a:	81 fb 94 26 11 80    	cmp    $0x80112694,%ebx
80101250:	73 4e                	jae    801012a0 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101252:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101255:	85 c9                	test   %ecx,%ecx
80101257:	7e e7                	jle    80101240 <iget+0x30>
80101259:	39 3b                	cmp    %edi,(%ebx)
8010125b:	75 e3                	jne    80101240 <iget+0x30>
8010125d:	39 53 04             	cmp    %edx,0x4(%ebx)
80101260:	75 de                	jne    80101240 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
80101262:	83 ec 0c             	sub    $0xc,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
80101265:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
80101268:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
8010126a:	68 40 0a 11 80       	push   $0x80110a40

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
8010126f:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101272:	e8 29 34 00 00       	call   801046a0 <release>
      return ip;
80101277:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
8010127a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010127d:	89 f0                	mov    %esi,%eax
8010127f:	5b                   	pop    %ebx
80101280:	5e                   	pop    %esi
80101281:	5f                   	pop    %edi
80101282:	5d                   	pop    %ebp
80101283:	c3                   	ret    
80101284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101288:	85 c9                	test   %ecx,%ecx
8010128a:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010128d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101293:	81 fb 94 26 11 80    	cmp    $0x80112694,%ebx
80101299:	72 b7                	jb     80101252 <iget+0x42>
8010129b:	90                   	nop
8010129c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801012a0:	85 f6                	test   %esi,%esi
801012a2:	74 2d                	je     801012d1 <iget+0xc1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801012a4:	83 ec 0c             	sub    $0xc,%esp
  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
801012a7:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801012a9:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801012ac:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801012b3:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801012ba:	68 40 0a 11 80       	push   $0x80110a40
801012bf:	e8 dc 33 00 00       	call   801046a0 <release>

  return ip;
801012c4:	83 c4 10             	add    $0x10,%esp
}
801012c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ca:	89 f0                	mov    %esi,%eax
801012cc:	5b                   	pop    %ebx
801012cd:	5e                   	pop    %esi
801012ce:	5f                   	pop    %edi
801012cf:	5d                   	pop    %ebp
801012d0:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
801012d1:	83 ec 0c             	sub    $0xc,%esp
801012d4:	68 75 72 10 80       	push   $0x80107275
801012d9:	e8 92 f0 ff ff       	call   80100370 <panic>
801012de:	66 90                	xchg   %ax,%ax

801012e0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801012e0:	55                   	push   %ebp
801012e1:	89 e5                	mov    %esp,%ebp
801012e3:	57                   	push   %edi
801012e4:	56                   	push   %esi
801012e5:	53                   	push   %ebx
801012e6:	89 c6                	mov    %eax,%esi
801012e8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801012eb:	83 fa 0b             	cmp    $0xb,%edx
801012ee:	77 18                	ja     80101308 <bmap+0x28>
801012f0:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
801012f3:	8b 5f 5c             	mov    0x5c(%edi),%ebx
801012f6:	85 db                	test   %ebx,%ebx
801012f8:	74 76                	je     80101370 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801012fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012fd:	89 d8                	mov    %ebx,%eax
801012ff:	5b                   	pop    %ebx
80101300:	5e                   	pop    %esi
80101301:	5f                   	pop    %edi
80101302:	5d                   	pop    %ebp
80101303:	c3                   	ret    
80101304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101308:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
8010130b:	83 fb 7f             	cmp    $0x7f,%ebx
8010130e:	0f 87 8e 00 00 00    	ja     801013a2 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101314:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
8010131a:	85 c0                	test   %eax,%eax
8010131c:	74 72                	je     80101390 <bmap+0xb0>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010131e:	83 ec 08             	sub    $0x8,%esp
80101321:	50                   	push   %eax
80101322:	ff 36                	pushl  (%esi)
80101324:	e8 a7 ed ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101329:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010132d:	83 c4 10             	add    $0x10,%esp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101330:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101332:	8b 1a                	mov    (%edx),%ebx
80101334:	85 db                	test   %ebx,%ebx
80101336:	75 1d                	jne    80101355 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
80101338:	8b 06                	mov    (%esi),%eax
8010133a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010133d:	e8 be fd ff ff       	call   80101100 <balloc>
80101342:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101345:	83 ec 0c             	sub    $0xc,%esp
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
80101348:	89 c3                	mov    %eax,%ebx
8010134a:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010134c:	57                   	push   %edi
8010134d:	e8 fe 19 00 00       	call   80102d50 <log_write>
80101352:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101355:	83 ec 0c             	sub    $0xc,%esp
80101358:	57                   	push   %edi
80101359:	e8 82 ee ff ff       	call   801001e0 <brelse>
8010135e:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101361:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101364:	89 d8                	mov    %ebx,%eax
80101366:	5b                   	pop    %ebx
80101367:	5e                   	pop    %esi
80101368:	5f                   	pop    %edi
80101369:	5d                   	pop    %ebp
8010136a:	c3                   	ret    
8010136b:	90                   	nop
8010136c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101370:	8b 00                	mov    (%eax),%eax
80101372:	e8 89 fd ff ff       	call   80101100 <balloc>
80101377:	89 47 5c             	mov    %eax,0x5c(%edi)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010137a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
8010137d:	89 c3                	mov    %eax,%ebx
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010137f:	89 d8                	mov    %ebx,%eax
80101381:	5b                   	pop    %ebx
80101382:	5e                   	pop    %esi
80101383:	5f                   	pop    %edi
80101384:	5d                   	pop    %ebp
80101385:	c3                   	ret    
80101386:	8d 76 00             	lea    0x0(%esi),%esi
80101389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101390:	8b 06                	mov    (%esi),%eax
80101392:	e8 69 fd ff ff       	call   80101100 <balloc>
80101397:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010139d:	e9 7c ff ff ff       	jmp    8010131e <bmap+0x3e>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
801013a2:	83 ec 0c             	sub    $0xc,%esp
801013a5:	68 85 72 10 80       	push   $0x80107285
801013aa:	e8 c1 ef ff ff       	call   80100370 <panic>
801013af:	90                   	nop

801013b0 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801013b0:	55                   	push   %ebp
801013b1:	89 e5                	mov    %esp,%ebp
801013b3:	56                   	push   %esi
801013b4:	53                   	push   %ebx
801013b5:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
801013b8:	83 ec 08             	sub    $0x8,%esp
801013bb:	6a 01                	push   $0x1
801013bd:	ff 75 08             	pushl  0x8(%ebp)
801013c0:	e8 0b ed ff ff       	call   801000d0 <bread>
801013c5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013c7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013ca:	83 c4 0c             	add    $0xc,%esp
801013cd:	6a 1c                	push   $0x1c
801013cf:	50                   	push   %eax
801013d0:	56                   	push   %esi
801013d1:	e8 ca 33 00 00       	call   801047a0 <memmove>
  brelse(bp);
801013d6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801013d9:	83 c4 10             	add    $0x10,%esp
}
801013dc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801013df:	5b                   	pop    %ebx
801013e0:	5e                   	pop    %esi
801013e1:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801013e2:	e9 f9 ed ff ff       	jmp    801001e0 <brelse>
801013e7:	89 f6                	mov    %esi,%esi
801013e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801013f0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801013f0:	55                   	push   %ebp
801013f1:	89 e5                	mov    %esp,%ebp
801013f3:	56                   	push   %esi
801013f4:	53                   	push   %ebx
801013f5:	89 d3                	mov    %edx,%ebx
801013f7:	89 c6                	mov    %eax,%esi
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801013f9:	83 ec 08             	sub    $0x8,%esp
801013fc:	68 20 0a 11 80       	push   $0x80110a20
80101401:	50                   	push   %eax
80101402:	e8 a9 ff ff ff       	call   801013b0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101407:	58                   	pop    %eax
80101408:	5a                   	pop    %edx
80101409:	89 da                	mov    %ebx,%edx
8010140b:	c1 ea 0c             	shr    $0xc,%edx
8010140e:	03 15 38 0a 11 80    	add    0x80110a38,%edx
80101414:	52                   	push   %edx
80101415:	56                   	push   %esi
80101416:	e8 b5 ec ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010141b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010141d:	c1 fb 03             	sar    $0x3,%ebx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101420:	ba 01 00 00 00       	mov    $0x1,%edx
80101425:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101428:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010142e:	83 c4 10             	add    $0x10,%esp
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101431:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101433:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101438:	85 d1                	test   %edx,%ecx
8010143a:	74 25                	je     80101461 <bfree+0x71>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010143c:	f7 d2                	not    %edx
8010143e:	89 c6                	mov    %eax,%esi
  log_write(bp);
80101440:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101443:	21 ca                	and    %ecx,%edx
80101445:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101449:	56                   	push   %esi
8010144a:	e8 01 19 00 00       	call   80102d50 <log_write>
  brelse(bp);
8010144f:	89 34 24             	mov    %esi,(%esp)
80101452:	e8 89 ed ff ff       	call   801001e0 <brelse>
}
80101457:	83 c4 10             	add    $0x10,%esp
8010145a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010145d:	5b                   	pop    %ebx
8010145e:	5e                   	pop    %esi
8010145f:	5d                   	pop    %ebp
80101460:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101461:	83 ec 0c             	sub    $0xc,%esp
80101464:	68 98 72 10 80       	push   $0x80107298
80101469:	e8 02 ef ff ff       	call   80100370 <panic>
8010146e:	66 90                	xchg   %ax,%ax

80101470 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101470:	55                   	push   %ebp
80101471:	89 e5                	mov    %esp,%ebp
80101473:	53                   	push   %ebx
80101474:	bb 80 0a 11 80       	mov    $0x80110a80,%ebx
80101479:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
8010147c:	68 ab 72 10 80       	push   $0x801072ab
80101481:	68 40 0a 11 80       	push   $0x80110a40
80101486:	e8 05 30 00 00       	call   80104490 <initlock>
8010148b:	83 c4 10             	add    $0x10,%esp
8010148e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80101490:	83 ec 08             	sub    $0x8,%esp
80101493:	68 b2 72 10 80       	push   $0x801072b2
80101498:	53                   	push   %ebx
80101499:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010149f:	e8 bc 2e 00 00       	call   80104360 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
801014a4:	83 c4 10             	add    $0x10,%esp
801014a7:	81 fb a0 26 11 80    	cmp    $0x801126a0,%ebx
801014ad:	75 e1                	jne    80101490 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
801014af:	83 ec 08             	sub    $0x8,%esp
801014b2:	68 20 0a 11 80       	push   $0x80110a20
801014b7:	ff 75 08             	pushl  0x8(%ebp)
801014ba:	e8 f1 fe ff ff       	call   801013b0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014bf:	ff 35 38 0a 11 80    	pushl  0x80110a38
801014c5:	ff 35 34 0a 11 80    	pushl  0x80110a34
801014cb:	ff 35 30 0a 11 80    	pushl  0x80110a30
801014d1:	ff 35 2c 0a 11 80    	pushl  0x80110a2c
801014d7:	ff 35 28 0a 11 80    	pushl  0x80110a28
801014dd:	ff 35 24 0a 11 80    	pushl  0x80110a24
801014e3:	ff 35 20 0a 11 80    	pushl  0x80110a20
801014e9:	68 18 73 10 80       	push   $0x80107318
801014ee:	e8 6d f1 ff ff       	call   80100660 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
801014f3:	83 c4 30             	add    $0x30,%esp
801014f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801014f9:	c9                   	leave  
801014fa:	c3                   	ret    
801014fb:	90                   	nop
801014fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101500 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101500:	55                   	push   %ebp
80101501:	89 e5                	mov    %esp,%ebp
80101503:	57                   	push   %edi
80101504:	56                   	push   %esi
80101505:	53                   	push   %ebx
80101506:	83 ec 1c             	sub    $0x1c,%esp
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101509:	83 3d 28 0a 11 80 01 	cmpl   $0x1,0x80110a28
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101510:	8b 45 0c             	mov    0xc(%ebp),%eax
80101513:	8b 75 08             	mov    0x8(%ebp),%esi
80101516:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101519:	0f 86 91 00 00 00    	jbe    801015b0 <ialloc+0xb0>
8010151f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101524:	eb 21                	jmp    80101547 <ialloc+0x47>
80101526:	8d 76 00             	lea    0x0(%esi),%esi
80101529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101530:	83 ec 0c             	sub    $0xc,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101533:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101536:	57                   	push   %edi
80101537:	e8 a4 ec ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010153c:	83 c4 10             	add    $0x10,%esp
8010153f:	39 1d 28 0a 11 80    	cmp    %ebx,0x80110a28
80101545:	76 69                	jbe    801015b0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101547:	89 d8                	mov    %ebx,%eax
80101549:	83 ec 08             	sub    $0x8,%esp
8010154c:	c1 e8 03             	shr    $0x3,%eax
8010154f:	03 05 34 0a 11 80    	add    0x80110a34,%eax
80101555:	50                   	push   %eax
80101556:	56                   	push   %esi
80101557:	e8 74 eb ff ff       	call   801000d0 <bread>
8010155c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010155e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101560:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
80101563:	83 e0 07             	and    $0x7,%eax
80101566:	c1 e0 06             	shl    $0x6,%eax
80101569:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010156d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101571:	75 bd                	jne    80101530 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101573:	83 ec 04             	sub    $0x4,%esp
80101576:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101579:	6a 40                	push   $0x40
8010157b:	6a 00                	push   $0x0
8010157d:	51                   	push   %ecx
8010157e:	e8 6d 31 00 00       	call   801046f0 <memset>
      dip->type = type;
80101583:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101587:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010158a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010158d:	89 3c 24             	mov    %edi,(%esp)
80101590:	e8 bb 17 00 00       	call   80102d50 <log_write>
      brelse(bp);
80101595:	89 3c 24             	mov    %edi,(%esp)
80101598:	e8 43 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010159d:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801015a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801015a3:	89 da                	mov    %ebx,%edx
801015a5:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801015a7:	5b                   	pop    %ebx
801015a8:	5e                   	pop    %esi
801015a9:	5f                   	pop    %edi
801015aa:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801015ab:	e9 60 fc ff ff       	jmp    80101210 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
801015b0:	83 ec 0c             	sub    $0xc,%esp
801015b3:	68 b8 72 10 80       	push   $0x801072b8
801015b8:	e8 b3 ed ff ff       	call   80100370 <panic>
801015bd:	8d 76 00             	lea    0x0(%esi),%esi

801015c0 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
801015c0:	55                   	push   %ebp
801015c1:	89 e5                	mov    %esp,%ebp
801015c3:	56                   	push   %esi
801015c4:	53                   	push   %ebx
801015c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015c8:	83 ec 08             	sub    $0x8,%esp
801015cb:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015ce:	83 c3 5c             	add    $0x5c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015d1:	c1 e8 03             	shr    $0x3,%eax
801015d4:	03 05 34 0a 11 80    	add    0x80110a34,%eax
801015da:	50                   	push   %eax
801015db:	ff 73 a4             	pushl  -0x5c(%ebx)
801015de:	e8 ed ea ff ff       	call   801000d0 <bread>
801015e3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015e5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801015e8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015ec:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015ef:	83 e0 07             	and    $0x7,%eax
801015f2:	c1 e0 06             	shl    $0x6,%eax
801015f5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801015f9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801015fc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101600:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
80101603:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101607:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010160b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010160f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101613:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101617:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010161a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010161d:	6a 34                	push   $0x34
8010161f:	53                   	push   %ebx
80101620:	50                   	push   %eax
80101621:	e8 7a 31 00 00       	call   801047a0 <memmove>
  log_write(bp);
80101626:	89 34 24             	mov    %esi,(%esp)
80101629:	e8 22 17 00 00       	call   80102d50 <log_write>
  brelse(bp);
8010162e:	89 75 08             	mov    %esi,0x8(%ebp)
80101631:	83 c4 10             	add    $0x10,%esp
}
80101634:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101637:	5b                   	pop    %ebx
80101638:	5e                   	pop    %esi
80101639:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
8010163a:	e9 a1 eb ff ff       	jmp    801001e0 <brelse>
8010163f:	90                   	nop

80101640 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101640:	55                   	push   %ebp
80101641:	89 e5                	mov    %esp,%ebp
80101643:	53                   	push   %ebx
80101644:	83 ec 10             	sub    $0x10,%esp
80101647:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010164a:	68 40 0a 11 80       	push   $0x80110a40
8010164f:	e8 9c 2f 00 00       	call   801045f0 <acquire>
  ip->ref++;
80101654:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101658:	c7 04 24 40 0a 11 80 	movl   $0x80110a40,(%esp)
8010165f:	e8 3c 30 00 00       	call   801046a0 <release>
  return ip;
}
80101664:	89 d8                	mov    %ebx,%eax
80101666:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101669:	c9                   	leave  
8010166a:	c3                   	ret    
8010166b:	90                   	nop
8010166c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101670 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101670:	55                   	push   %ebp
80101671:	89 e5                	mov    %esp,%ebp
80101673:	56                   	push   %esi
80101674:	53                   	push   %ebx
80101675:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101678:	85 db                	test   %ebx,%ebx
8010167a:	0f 84 b7 00 00 00    	je     80101737 <ilock+0xc7>
80101680:	8b 53 08             	mov    0x8(%ebx),%edx
80101683:	85 d2                	test   %edx,%edx
80101685:	0f 8e ac 00 00 00    	jle    80101737 <ilock+0xc7>
    panic("ilock");

  acquiresleep(&ip->lock);
8010168b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010168e:	83 ec 0c             	sub    $0xc,%esp
80101691:	50                   	push   %eax
80101692:	e8 09 2d 00 00       	call   801043a0 <acquiresleep>

  if(ip->valid == 0){
80101697:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010169a:	83 c4 10             	add    $0x10,%esp
8010169d:	85 c0                	test   %eax,%eax
8010169f:	74 0f                	je     801016b0 <ilock+0x40>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
801016a1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016a4:	5b                   	pop    %ebx
801016a5:	5e                   	pop    %esi
801016a6:	5d                   	pop    %ebp
801016a7:	c3                   	ret    
801016a8:	90                   	nop
801016a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016b0:	8b 43 04             	mov    0x4(%ebx),%eax
801016b3:	83 ec 08             	sub    $0x8,%esp
801016b6:	c1 e8 03             	shr    $0x3,%eax
801016b9:	03 05 34 0a 11 80    	add    0x80110a34,%eax
801016bf:	50                   	push   %eax
801016c0:	ff 33                	pushl  (%ebx)
801016c2:	e8 09 ea ff ff       	call   801000d0 <bread>
801016c7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016c9:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016cc:	83 c4 0c             	add    $0xc,%esp

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016cf:	83 e0 07             	and    $0x7,%eax
801016d2:	c1 e0 06             	shl    $0x6,%eax
801016d5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801016d9:	0f b7 10             	movzwl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016dc:	83 c0 0c             	add    $0xc,%eax
  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
801016df:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801016e3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801016e7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801016eb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801016ef:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801016f3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801016f7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801016fb:	8b 50 fc             	mov    -0x4(%eax),%edx
801016fe:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101701:	6a 34                	push   $0x34
80101703:	50                   	push   %eax
80101704:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101707:	50                   	push   %eax
80101708:	e8 93 30 00 00       	call   801047a0 <memmove>
    brelse(bp);
8010170d:	89 34 24             	mov    %esi,(%esp)
80101710:	e8 cb ea ff ff       	call   801001e0 <brelse>
    ip->valid = 1;
    if(ip->type == 0)
80101715:	83 c4 10             	add    $0x10,%esp
80101718:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    brelse(bp);
    ip->valid = 1;
8010171d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101724:	0f 85 77 ff ff ff    	jne    801016a1 <ilock+0x31>
      panic("ilock: no type");
8010172a:	83 ec 0c             	sub    $0xc,%esp
8010172d:	68 d0 72 10 80       	push   $0x801072d0
80101732:	e8 39 ec ff ff       	call   80100370 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101737:	83 ec 0c             	sub    $0xc,%esp
8010173a:	68 ca 72 10 80       	push   $0x801072ca
8010173f:	e8 2c ec ff ff       	call   80100370 <panic>
80101744:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010174a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101750 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101750:	55                   	push   %ebp
80101751:	89 e5                	mov    %esp,%ebp
80101753:	56                   	push   %esi
80101754:	53                   	push   %ebx
80101755:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101758:	85 db                	test   %ebx,%ebx
8010175a:	74 28                	je     80101784 <iunlock+0x34>
8010175c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010175f:	83 ec 0c             	sub    $0xc,%esp
80101762:	56                   	push   %esi
80101763:	e8 d8 2c 00 00       	call   80104440 <holdingsleep>
80101768:	83 c4 10             	add    $0x10,%esp
8010176b:	85 c0                	test   %eax,%eax
8010176d:	74 15                	je     80101784 <iunlock+0x34>
8010176f:	8b 43 08             	mov    0x8(%ebx),%eax
80101772:	85 c0                	test   %eax,%eax
80101774:	7e 0e                	jle    80101784 <iunlock+0x34>
    panic("iunlock");

  releasesleep(&ip->lock);
80101776:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101779:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010177c:	5b                   	pop    %ebx
8010177d:	5e                   	pop    %esi
8010177e:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
8010177f:	e9 7c 2c 00 00       	jmp    80104400 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101784:	83 ec 0c             	sub    $0xc,%esp
80101787:	68 df 72 10 80       	push   $0x801072df
8010178c:	e8 df eb ff ff       	call   80100370 <panic>
80101791:	eb 0d                	jmp    801017a0 <iput>
80101793:	90                   	nop
80101794:	90                   	nop
80101795:	90                   	nop
80101796:	90                   	nop
80101797:	90                   	nop
80101798:	90                   	nop
80101799:	90                   	nop
8010179a:	90                   	nop
8010179b:	90                   	nop
8010179c:	90                   	nop
8010179d:	90                   	nop
8010179e:	90                   	nop
8010179f:	90                   	nop

801017a0 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
801017a0:	55                   	push   %ebp
801017a1:	89 e5                	mov    %esp,%ebp
801017a3:	57                   	push   %edi
801017a4:	56                   	push   %esi
801017a5:	53                   	push   %ebx
801017a6:	83 ec 28             	sub    $0x28,%esp
801017a9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
801017ac:	8d 7e 0c             	lea    0xc(%esi),%edi
801017af:	57                   	push   %edi
801017b0:	e8 eb 2b 00 00       	call   801043a0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801017b5:	8b 56 4c             	mov    0x4c(%esi),%edx
801017b8:	83 c4 10             	add    $0x10,%esp
801017bb:	85 d2                	test   %edx,%edx
801017bd:	74 07                	je     801017c6 <iput+0x26>
801017bf:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801017c4:	74 32                	je     801017f8 <iput+0x58>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
801017c6:	83 ec 0c             	sub    $0xc,%esp
801017c9:	57                   	push   %edi
801017ca:	e8 31 2c 00 00       	call   80104400 <releasesleep>

  acquire(&icache.lock);
801017cf:	c7 04 24 40 0a 11 80 	movl   $0x80110a40,(%esp)
801017d6:	e8 15 2e 00 00       	call   801045f0 <acquire>
  ip->ref--;
801017db:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
801017df:	83 c4 10             	add    $0x10,%esp
801017e2:	c7 45 08 40 0a 11 80 	movl   $0x80110a40,0x8(%ebp)
}
801017e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017ec:	5b                   	pop    %ebx
801017ed:	5e                   	pop    %esi
801017ee:	5f                   	pop    %edi
801017ef:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
801017f0:	e9 ab 2e 00 00       	jmp    801046a0 <release>
801017f5:	8d 76 00             	lea    0x0(%esi),%esi
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
801017f8:	83 ec 0c             	sub    $0xc,%esp
801017fb:	68 40 0a 11 80       	push   $0x80110a40
80101800:	e8 eb 2d 00 00       	call   801045f0 <acquire>
    int r = ip->ref;
80101805:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
80101808:	c7 04 24 40 0a 11 80 	movl   $0x80110a40,(%esp)
8010180f:	e8 8c 2e 00 00       	call   801046a0 <release>
    if(r == 1){
80101814:	83 c4 10             	add    $0x10,%esp
80101817:	83 fb 01             	cmp    $0x1,%ebx
8010181a:	75 aa                	jne    801017c6 <iput+0x26>
8010181c:	8d 8e 8c 00 00 00    	lea    0x8c(%esi),%ecx
80101822:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101825:	8d 5e 5c             	lea    0x5c(%esi),%ebx
80101828:	89 cf                	mov    %ecx,%edi
8010182a:	eb 0b                	jmp    80101837 <iput+0x97>
8010182c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101830:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101833:	39 fb                	cmp    %edi,%ebx
80101835:	74 19                	je     80101850 <iput+0xb0>
    if(ip->addrs[i]){
80101837:	8b 13                	mov    (%ebx),%edx
80101839:	85 d2                	test   %edx,%edx
8010183b:	74 f3                	je     80101830 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010183d:	8b 06                	mov    (%esi),%eax
8010183f:	e8 ac fb ff ff       	call   801013f0 <bfree>
      ip->addrs[i] = 0;
80101844:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010184a:	eb e4                	jmp    80101830 <iput+0x90>
8010184c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101850:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101856:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101859:	85 c0                	test   %eax,%eax
8010185b:	75 33                	jne    80101890 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010185d:	83 ec 0c             	sub    $0xc,%esp
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
80101860:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101867:	56                   	push   %esi
80101868:	e8 53 fd ff ff       	call   801015c0 <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
8010186d:	31 c0                	xor    %eax,%eax
8010186f:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
80101873:	89 34 24             	mov    %esi,(%esp)
80101876:	e8 45 fd ff ff       	call   801015c0 <iupdate>
      ip->valid = 0;
8010187b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101882:	83 c4 10             	add    $0x10,%esp
80101885:	e9 3c ff ff ff       	jmp    801017c6 <iput+0x26>
8010188a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101890:	83 ec 08             	sub    $0x8,%esp
80101893:	50                   	push   %eax
80101894:	ff 36                	pushl  (%esi)
80101896:	e8 35 e8 ff ff       	call   801000d0 <bread>
8010189b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801018a1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801018a4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801018a7:	8d 58 5c             	lea    0x5c(%eax),%ebx
801018aa:	83 c4 10             	add    $0x10,%esp
801018ad:	89 cf                	mov    %ecx,%edi
801018af:	eb 0e                	jmp    801018bf <iput+0x11f>
801018b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018b8:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
801018bb:	39 fb                	cmp    %edi,%ebx
801018bd:	74 0f                	je     801018ce <iput+0x12e>
      if(a[j])
801018bf:	8b 13                	mov    (%ebx),%edx
801018c1:	85 d2                	test   %edx,%edx
801018c3:	74 f3                	je     801018b8 <iput+0x118>
        bfree(ip->dev, a[j]);
801018c5:	8b 06                	mov    (%esi),%eax
801018c7:	e8 24 fb ff ff       	call   801013f0 <bfree>
801018cc:	eb ea                	jmp    801018b8 <iput+0x118>
    }
    brelse(bp);
801018ce:	83 ec 0c             	sub    $0xc,%esp
801018d1:	ff 75 e4             	pushl  -0x1c(%ebp)
801018d4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801018d7:	e8 04 e9 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018dc:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
801018e2:	8b 06                	mov    (%esi),%eax
801018e4:	e8 07 fb ff ff       	call   801013f0 <bfree>
    ip->addrs[NDIRECT] = 0;
801018e9:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
801018f0:	00 00 00 
801018f3:	83 c4 10             	add    $0x10,%esp
801018f6:	e9 62 ff ff ff       	jmp    8010185d <iput+0xbd>
801018fb:	90                   	nop
801018fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101900 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101900:	55                   	push   %ebp
80101901:	89 e5                	mov    %esp,%ebp
80101903:	53                   	push   %ebx
80101904:	83 ec 10             	sub    $0x10,%esp
80101907:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010190a:	53                   	push   %ebx
8010190b:	e8 40 fe ff ff       	call   80101750 <iunlock>
  iput(ip);
80101910:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101913:	83 c4 10             	add    $0x10,%esp
}
80101916:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101919:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
8010191a:	e9 81 fe ff ff       	jmp    801017a0 <iput>
8010191f:	90                   	nop

80101920 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	8b 55 08             	mov    0x8(%ebp),%edx
80101926:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101929:	8b 0a                	mov    (%edx),%ecx
8010192b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010192e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101931:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101934:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101938:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010193b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010193f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101943:	8b 52 58             	mov    0x58(%edx),%edx
80101946:	89 50 10             	mov    %edx,0x10(%eax)
}
80101949:	5d                   	pop    %ebp
8010194a:	c3                   	ret    
8010194b:	90                   	nop
8010194c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101950 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101950:	55                   	push   %ebp
80101951:	89 e5                	mov    %esp,%ebp
80101953:	57                   	push   %edi
80101954:	56                   	push   %esi
80101955:	53                   	push   %ebx
80101956:	83 ec 1c             	sub    $0x1c,%esp
80101959:	8b 45 08             	mov    0x8(%ebp),%eax
8010195c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010195f:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101962:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101967:	89 7d e0             	mov    %edi,-0x20(%ebp)
8010196a:	8b 7d 14             	mov    0x14(%ebp),%edi
8010196d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101970:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101973:	0f 84 a7 00 00 00    	je     80101a20 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101979:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010197c:	8b 40 58             	mov    0x58(%eax),%eax
8010197f:	39 f0                	cmp    %esi,%eax
80101981:	0f 82 ba 00 00 00    	jb     80101a41 <readi+0xf1>
80101987:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010198a:	89 f9                	mov    %edi,%ecx
8010198c:	01 f1                	add    %esi,%ecx
8010198e:	0f 82 ad 00 00 00    	jb     80101a41 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101994:	89 c2                	mov    %eax,%edx
80101996:	29 f2                	sub    %esi,%edx
80101998:	39 c8                	cmp    %ecx,%eax
8010199a:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010199d:	31 ff                	xor    %edi,%edi
8010199f:	85 d2                	test   %edx,%edx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019a1:	89 55 e4             	mov    %edx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019a4:	74 6c                	je     80101a12 <readi+0xc2>
801019a6:	8d 76 00             	lea    0x0(%esi),%esi
801019a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019b0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019b3:	89 f2                	mov    %esi,%edx
801019b5:	c1 ea 09             	shr    $0x9,%edx
801019b8:	89 d8                	mov    %ebx,%eax
801019ba:	e8 21 f9 ff ff       	call   801012e0 <bmap>
801019bf:	83 ec 08             	sub    $0x8,%esp
801019c2:	50                   	push   %eax
801019c3:	ff 33                	pushl  (%ebx)
801019c5:	e8 06 e7 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801019ca:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019cd:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019cf:	89 f0                	mov    %esi,%eax
801019d1:	25 ff 01 00 00       	and    $0x1ff,%eax
801019d6:	b9 00 02 00 00       	mov    $0x200,%ecx
801019db:	83 c4 0c             	add    $0xc,%esp
801019de:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
801019e0:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
801019e4:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
801019e7:	29 fb                	sub    %edi,%ebx
801019e9:	39 d9                	cmp    %ebx,%ecx
801019eb:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801019ee:	53                   	push   %ebx
801019ef:	50                   	push   %eax
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019f0:	01 df                	add    %ebx,%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
801019f2:	ff 75 e0             	pushl  -0x20(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019f5:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
801019f7:	e8 a4 2d 00 00       	call   801047a0 <memmove>
    brelse(bp);
801019fc:	8b 55 dc             	mov    -0x24(%ebp),%edx
801019ff:	89 14 24             	mov    %edx,(%esp)
80101a02:	e8 d9 e7 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a07:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a0a:	83 c4 10             	add    $0x10,%esp
80101a0d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a10:	77 9e                	ja     801019b0 <readi+0x60>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101a12:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a15:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a18:	5b                   	pop    %ebx
80101a19:	5e                   	pop    %esi
80101a1a:	5f                   	pop    %edi
80101a1b:	5d                   	pop    %ebp
80101a1c:	c3                   	ret    
80101a1d:	8d 76 00             	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a20:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a24:	66 83 f8 09          	cmp    $0x9,%ax
80101a28:	77 17                	ja     80101a41 <readi+0xf1>
80101a2a:	8b 04 c5 c0 09 11 80 	mov    -0x7feef640(,%eax,8),%eax
80101a31:	85 c0                	test   %eax,%eax
80101a33:	74 0c                	je     80101a41 <readi+0xf1>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a35:	89 7d 10             	mov    %edi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101a38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a3b:	5b                   	pop    %ebx
80101a3c:	5e                   	pop    %esi
80101a3d:	5f                   	pop    %edi
80101a3e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a3f:	ff e0                	jmp    *%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101a41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a46:	eb cd                	jmp    80101a15 <readi+0xc5>
80101a48:	90                   	nop
80101a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101a50 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a50:	55                   	push   %ebp
80101a51:	89 e5                	mov    %esp,%ebp
80101a53:	57                   	push   %edi
80101a54:	56                   	push   %esi
80101a55:	53                   	push   %ebx
80101a56:	83 ec 1c             	sub    $0x1c,%esp
80101a59:	8b 45 08             	mov    0x8(%ebp),%eax
80101a5c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a5f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a62:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a67:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a6a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a6d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a70:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a73:	0f 84 b7 00 00 00    	je     80101b30 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a79:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a7c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a7f:	0f 82 eb 00 00 00    	jb     80101b70 <writei+0x120>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101a85:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101a88:	89 c8                	mov    %ecx,%eax
80101a8a:	01 f0                	add    %esi,%eax
80101a8c:	0f 82 de 00 00 00    	jb     80101b70 <writei+0x120>
80101a92:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101a97:	0f 87 d3 00 00 00    	ja     80101b70 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101a9d:	85 c9                	test   %ecx,%ecx
80101a9f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101aa6:	74 79                	je     80101b21 <writei+0xd1>
80101aa8:	90                   	nop
80101aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ab0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ab3:	89 f2                	mov    %esi,%edx
80101ab5:	c1 ea 09             	shr    $0x9,%edx
80101ab8:	89 f8                	mov    %edi,%eax
80101aba:	e8 21 f8 ff ff       	call   801012e0 <bmap>
80101abf:	83 ec 08             	sub    $0x8,%esp
80101ac2:	50                   	push   %eax
80101ac3:	ff 37                	pushl  (%edi)
80101ac5:	e8 06 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101aca:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101acd:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ad0:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101ad2:	89 f0                	mov    %esi,%eax
80101ad4:	b9 00 02 00 00       	mov    $0x200,%ecx
80101ad9:	83 c4 0c             	add    $0xc,%esp
80101adc:	25 ff 01 00 00       	and    $0x1ff,%eax
80101ae1:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101ae3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101ae7:	39 d9                	cmp    %ebx,%ecx
80101ae9:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101aec:	53                   	push   %ebx
80101aed:	ff 75 dc             	pushl  -0x24(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101af0:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101af2:	50                   	push   %eax
80101af3:	e8 a8 2c 00 00       	call   801047a0 <memmove>
    log_write(bp);
80101af8:	89 3c 24             	mov    %edi,(%esp)
80101afb:	e8 50 12 00 00       	call   80102d50 <log_write>
    brelse(bp);
80101b00:	89 3c 24             	mov    %edi,(%esp)
80101b03:	e8 d8 e6 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b08:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b0b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b0e:	83 c4 10             	add    $0x10,%esp
80101b11:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101b14:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101b17:	77 97                	ja     80101ab0 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101b19:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b1c:	3b 70 58             	cmp    0x58(%eax),%esi
80101b1f:	77 37                	ja     80101b58 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b21:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b24:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b27:	5b                   	pop    %ebx
80101b28:	5e                   	pop    %esi
80101b29:	5f                   	pop    %edi
80101b2a:	5d                   	pop    %ebp
80101b2b:	c3                   	ret    
80101b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b30:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b34:	66 83 f8 09          	cmp    $0x9,%ax
80101b38:	77 36                	ja     80101b70 <writei+0x120>
80101b3a:	8b 04 c5 c4 09 11 80 	mov    -0x7feef63c(,%eax,8),%eax
80101b41:	85 c0                	test   %eax,%eax
80101b43:	74 2b                	je     80101b70 <writei+0x120>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b45:	89 4d 10             	mov    %ecx,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101b48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b4b:	5b                   	pop    %ebx
80101b4c:	5e                   	pop    %esi
80101b4d:	5f                   	pop    %edi
80101b4e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b4f:	ff e0                	jmp    *%eax
80101b51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101b58:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b5b:	83 ec 0c             	sub    $0xc,%esp
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101b5e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b61:	50                   	push   %eax
80101b62:	e8 59 fa ff ff       	call   801015c0 <iupdate>
80101b67:	83 c4 10             	add    $0x10,%esp
80101b6a:	eb b5                	jmp    80101b21 <writei+0xd1>
80101b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101b70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b75:	eb ad                	jmp    80101b24 <writei+0xd4>
80101b77:	89 f6                	mov    %esi,%esi
80101b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b80 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101b80:	55                   	push   %ebp
80101b81:	89 e5                	mov    %esp,%ebp
80101b83:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101b86:	6a 0e                	push   $0xe
80101b88:	ff 75 0c             	pushl  0xc(%ebp)
80101b8b:	ff 75 08             	pushl  0x8(%ebp)
80101b8e:	e8 7d 2c 00 00       	call   80104810 <strncmp>
}
80101b93:	c9                   	leave  
80101b94:	c3                   	ret    
80101b95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ba0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101ba0:	55                   	push   %ebp
80101ba1:	89 e5                	mov    %esp,%ebp
80101ba3:	57                   	push   %edi
80101ba4:	56                   	push   %esi
80101ba5:	53                   	push   %ebx
80101ba6:	83 ec 1c             	sub    $0x1c,%esp
80101ba9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bac:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101bb1:	0f 85 80 00 00 00    	jne    80101c37 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101bb7:	8b 53 58             	mov    0x58(%ebx),%edx
80101bba:	31 ff                	xor    %edi,%edi
80101bbc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bbf:	85 d2                	test   %edx,%edx
80101bc1:	75 0d                	jne    80101bd0 <dirlookup+0x30>
80101bc3:	eb 5b                	jmp    80101c20 <dirlookup+0x80>
80101bc5:	8d 76 00             	lea    0x0(%esi),%esi
80101bc8:	83 c7 10             	add    $0x10,%edi
80101bcb:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101bce:	76 50                	jbe    80101c20 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101bd0:	6a 10                	push   $0x10
80101bd2:	57                   	push   %edi
80101bd3:	56                   	push   %esi
80101bd4:	53                   	push   %ebx
80101bd5:	e8 76 fd ff ff       	call   80101950 <readi>
80101bda:	83 c4 10             	add    $0x10,%esp
80101bdd:	83 f8 10             	cmp    $0x10,%eax
80101be0:	75 48                	jne    80101c2a <dirlookup+0x8a>
      panic("dirlookup read");
    if(de.inum == 0)
80101be2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101be7:	74 df                	je     80101bc8 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101be9:	8d 45 da             	lea    -0x26(%ebp),%eax
80101bec:	83 ec 04             	sub    $0x4,%esp
80101bef:	6a 0e                	push   $0xe
80101bf1:	50                   	push   %eax
80101bf2:	ff 75 0c             	pushl  0xc(%ebp)
80101bf5:	e8 16 2c 00 00       	call   80104810 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101bfa:	83 c4 10             	add    $0x10,%esp
80101bfd:	85 c0                	test   %eax,%eax
80101bff:	75 c7                	jne    80101bc8 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101c01:	8b 45 10             	mov    0x10(%ebp),%eax
80101c04:	85 c0                	test   %eax,%eax
80101c06:	74 05                	je     80101c0d <dirlookup+0x6d>
        *poff = off;
80101c08:	8b 45 10             	mov    0x10(%ebp),%eax
80101c0b:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c0d:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c11:	8b 03                	mov    (%ebx),%eax
80101c13:	e8 f8 f5 ff ff       	call   80101210 <iget>
    }
  }

  return 0;
}
80101c18:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c1b:	5b                   	pop    %ebx
80101c1c:	5e                   	pop    %esi
80101c1d:	5f                   	pop    %edi
80101c1e:	5d                   	pop    %ebp
80101c1f:	c3                   	ret    
80101c20:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101c23:	31 c0                	xor    %eax,%eax
}
80101c25:	5b                   	pop    %ebx
80101c26:	5e                   	pop    %esi
80101c27:	5f                   	pop    %edi
80101c28:	5d                   	pop    %ebp
80101c29:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80101c2a:	83 ec 0c             	sub    $0xc,%esp
80101c2d:	68 f9 72 10 80       	push   $0x801072f9
80101c32:	e8 39 e7 ff ff       	call   80100370 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101c37:	83 ec 0c             	sub    $0xc,%esp
80101c3a:	68 e7 72 10 80       	push   $0x801072e7
80101c3f:	e8 2c e7 ff ff       	call   80100370 <panic>
80101c44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101c50 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c50:	55                   	push   %ebp
80101c51:	89 e5                	mov    %esp,%ebp
80101c53:	57                   	push   %edi
80101c54:	56                   	push   %esi
80101c55:	53                   	push   %ebx
80101c56:	89 cf                	mov    %ecx,%edi
80101c58:	89 c3                	mov    %eax,%ebx
80101c5a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c5d:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c60:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101c63:	0f 84 55 01 00 00    	je     80101dbe <namex+0x16e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c69:	e8 52 1b 00 00       	call   801037c0 <myproc>
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101c6e:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c71:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101c74:	68 40 0a 11 80       	push   $0x80110a40
80101c79:	e8 72 29 00 00       	call   801045f0 <acquire>
  ip->ref++;
80101c7e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101c82:	c7 04 24 40 0a 11 80 	movl   $0x80110a40,(%esp)
80101c89:	e8 12 2a 00 00       	call   801046a0 <release>
80101c8e:	83 c4 10             	add    $0x10,%esp
80101c91:	eb 08                	jmp    80101c9b <namex+0x4b>
80101c93:	90                   	nop
80101c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101c98:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101c9b:	0f b6 03             	movzbl (%ebx),%eax
80101c9e:	3c 2f                	cmp    $0x2f,%al
80101ca0:	74 f6                	je     80101c98 <namex+0x48>
    path++;
  if(*path == 0)
80101ca2:	84 c0                	test   %al,%al
80101ca4:	0f 84 e3 00 00 00    	je     80101d8d <namex+0x13d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101caa:	0f b6 03             	movzbl (%ebx),%eax
80101cad:	89 da                	mov    %ebx,%edx
80101caf:	84 c0                	test   %al,%al
80101cb1:	0f 84 ac 00 00 00    	je     80101d63 <namex+0x113>
80101cb7:	3c 2f                	cmp    $0x2f,%al
80101cb9:	75 09                	jne    80101cc4 <namex+0x74>
80101cbb:	e9 a3 00 00 00       	jmp    80101d63 <namex+0x113>
80101cc0:	84 c0                	test   %al,%al
80101cc2:	74 0a                	je     80101cce <namex+0x7e>
    path++;
80101cc4:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101cc7:	0f b6 02             	movzbl (%edx),%eax
80101cca:	3c 2f                	cmp    $0x2f,%al
80101ccc:	75 f2                	jne    80101cc0 <namex+0x70>
80101cce:	89 d1                	mov    %edx,%ecx
80101cd0:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101cd2:	83 f9 0d             	cmp    $0xd,%ecx
80101cd5:	0f 8e 8d 00 00 00    	jle    80101d68 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101cdb:	83 ec 04             	sub    $0x4,%esp
80101cde:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101ce1:	6a 0e                	push   $0xe
80101ce3:	53                   	push   %ebx
80101ce4:	57                   	push   %edi
80101ce5:	e8 b6 2a 00 00       	call   801047a0 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101cea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
80101ced:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101cf0:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101cf2:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101cf5:	75 11                	jne    80101d08 <namex+0xb8>
80101cf7:	89 f6                	mov    %esi,%esi
80101cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d00:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101d03:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d06:	74 f8                	je     80101d00 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d08:	83 ec 0c             	sub    $0xc,%esp
80101d0b:	56                   	push   %esi
80101d0c:	e8 5f f9 ff ff       	call   80101670 <ilock>
    if(ip->type != T_DIR){
80101d11:	83 c4 10             	add    $0x10,%esp
80101d14:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d19:	0f 85 7f 00 00 00    	jne    80101d9e <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d1f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d22:	85 d2                	test   %edx,%edx
80101d24:	74 09                	je     80101d2f <namex+0xdf>
80101d26:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d29:	0f 84 a5 00 00 00    	je     80101dd4 <namex+0x184>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d2f:	83 ec 04             	sub    $0x4,%esp
80101d32:	6a 00                	push   $0x0
80101d34:	57                   	push   %edi
80101d35:	56                   	push   %esi
80101d36:	e8 65 fe ff ff       	call   80101ba0 <dirlookup>
80101d3b:	83 c4 10             	add    $0x10,%esp
80101d3e:	85 c0                	test   %eax,%eax
80101d40:	74 5c                	je     80101d9e <namex+0x14e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101d42:	83 ec 0c             	sub    $0xc,%esp
80101d45:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d48:	56                   	push   %esi
80101d49:	e8 02 fa ff ff       	call   80101750 <iunlock>
  iput(ip);
80101d4e:	89 34 24             	mov    %esi,(%esp)
80101d51:	e8 4a fa ff ff       	call   801017a0 <iput>
80101d56:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d59:	83 c4 10             	add    $0x10,%esp
80101d5c:	89 c6                	mov    %eax,%esi
80101d5e:	e9 38 ff ff ff       	jmp    80101c9b <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101d63:	31 c9                	xor    %ecx,%ecx
80101d65:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101d68:	83 ec 04             	sub    $0x4,%esp
80101d6b:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d6e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101d71:	51                   	push   %ecx
80101d72:	53                   	push   %ebx
80101d73:	57                   	push   %edi
80101d74:	e8 27 2a 00 00       	call   801047a0 <memmove>
    name[len] = 0;
80101d79:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101d7c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d7f:	83 c4 10             	add    $0x10,%esp
80101d82:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101d86:	89 d3                	mov    %edx,%ebx
80101d88:	e9 65 ff ff ff       	jmp    80101cf2 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101d8d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d90:	85 c0                	test   %eax,%eax
80101d92:	75 56                	jne    80101dea <namex+0x19a>
    iput(ip);
    return 0;
  }
  return ip;
}
80101d94:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d97:	89 f0                	mov    %esi,%eax
80101d99:	5b                   	pop    %ebx
80101d9a:	5e                   	pop    %esi
80101d9b:	5f                   	pop    %edi
80101d9c:	5d                   	pop    %ebp
80101d9d:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101d9e:	83 ec 0c             	sub    $0xc,%esp
80101da1:	56                   	push   %esi
80101da2:	e8 a9 f9 ff ff       	call   80101750 <iunlock>
  iput(ip);
80101da7:	89 34 24             	mov    %esi,(%esp)
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101daa:	31 f6                	xor    %esi,%esi
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
80101dac:	e8 ef f9 ff ff       	call   801017a0 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101db1:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101db4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101db7:	89 f0                	mov    %esi,%eax
80101db9:	5b                   	pop    %ebx
80101dba:	5e                   	pop    %esi
80101dbb:	5f                   	pop    %edi
80101dbc:	5d                   	pop    %ebp
80101dbd:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101dbe:	ba 01 00 00 00       	mov    $0x1,%edx
80101dc3:	b8 01 00 00 00       	mov    $0x1,%eax
80101dc8:	e8 43 f4 ff ff       	call   80101210 <iget>
80101dcd:	89 c6                	mov    %eax,%esi
80101dcf:	e9 c7 fe ff ff       	jmp    80101c9b <namex+0x4b>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101dd4:	83 ec 0c             	sub    $0xc,%esp
80101dd7:	56                   	push   %esi
80101dd8:	e8 73 f9 ff ff       	call   80101750 <iunlock>
      return ip;
80101ddd:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101de0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101de3:	89 f0                	mov    %esi,%eax
80101de5:	5b                   	pop    %ebx
80101de6:	5e                   	pop    %esi
80101de7:	5f                   	pop    %edi
80101de8:	5d                   	pop    %ebp
80101de9:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101dea:	83 ec 0c             	sub    $0xc,%esp
80101ded:	56                   	push   %esi
    return 0;
80101dee:	31 f6                	xor    %esi,%esi
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101df0:	e8 ab f9 ff ff       	call   801017a0 <iput>
    return 0;
80101df5:	83 c4 10             	add    $0x10,%esp
80101df8:	eb 9a                	jmp    80101d94 <namex+0x144>
80101dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101e00 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101e00:	55                   	push   %ebp
80101e01:	89 e5                	mov    %esp,%ebp
80101e03:	57                   	push   %edi
80101e04:	56                   	push   %esi
80101e05:	53                   	push   %ebx
80101e06:	83 ec 20             	sub    $0x20,%esp
80101e09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e0c:	6a 00                	push   $0x0
80101e0e:	ff 75 0c             	pushl  0xc(%ebp)
80101e11:	53                   	push   %ebx
80101e12:	e8 89 fd ff ff       	call   80101ba0 <dirlookup>
80101e17:	83 c4 10             	add    $0x10,%esp
80101e1a:	85 c0                	test   %eax,%eax
80101e1c:	75 67                	jne    80101e85 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e1e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e21:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e24:	85 ff                	test   %edi,%edi
80101e26:	74 29                	je     80101e51 <dirlink+0x51>
80101e28:	31 ff                	xor    %edi,%edi
80101e2a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e2d:	eb 09                	jmp    80101e38 <dirlink+0x38>
80101e2f:	90                   	nop
80101e30:	83 c7 10             	add    $0x10,%edi
80101e33:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101e36:	76 19                	jbe    80101e51 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e38:	6a 10                	push   $0x10
80101e3a:	57                   	push   %edi
80101e3b:	56                   	push   %esi
80101e3c:	53                   	push   %ebx
80101e3d:	e8 0e fb ff ff       	call   80101950 <readi>
80101e42:	83 c4 10             	add    $0x10,%esp
80101e45:	83 f8 10             	cmp    $0x10,%eax
80101e48:	75 4e                	jne    80101e98 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
80101e4a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e4f:	75 df                	jne    80101e30 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101e51:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e54:	83 ec 04             	sub    $0x4,%esp
80101e57:	6a 0e                	push   $0xe
80101e59:	ff 75 0c             	pushl  0xc(%ebp)
80101e5c:	50                   	push   %eax
80101e5d:	e8 0e 2a 00 00       	call   80104870 <strncpy>
  de.inum = inum;
80101e62:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e65:	6a 10                	push   $0x10
80101e67:	57                   	push   %edi
80101e68:	56                   	push   %esi
80101e69:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80101e6a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e6e:	e8 dd fb ff ff       	call   80101a50 <writei>
80101e73:	83 c4 20             	add    $0x20,%esp
80101e76:	83 f8 10             	cmp    $0x10,%eax
80101e79:	75 2a                	jne    80101ea5 <dirlink+0xa5>
    panic("dirlink");

  return 0;
80101e7b:	31 c0                	xor    %eax,%eax
}
80101e7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e80:	5b                   	pop    %ebx
80101e81:	5e                   	pop    %esi
80101e82:	5f                   	pop    %edi
80101e83:	5d                   	pop    %ebp
80101e84:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101e85:	83 ec 0c             	sub    $0xc,%esp
80101e88:	50                   	push   %eax
80101e89:	e8 12 f9 ff ff       	call   801017a0 <iput>
    return -1;
80101e8e:	83 c4 10             	add    $0x10,%esp
80101e91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e96:	eb e5                	jmp    80101e7d <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101e98:	83 ec 0c             	sub    $0xc,%esp
80101e9b:	68 08 73 10 80       	push   $0x80107308
80101ea0:	e8 cb e4 ff ff       	call   80100370 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101ea5:	83 ec 0c             	sub    $0xc,%esp
80101ea8:	68 c6 79 10 80       	push   $0x801079c6
80101ead:	e8 be e4 ff ff       	call   80100370 <panic>
80101eb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ec0 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101ec0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ec1:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80101ec3:	89 e5                	mov    %esp,%ebp
80101ec5:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ec8:	8b 45 08             	mov    0x8(%ebp),%eax
80101ecb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101ece:	e8 7d fd ff ff       	call   80101c50 <namex>
}
80101ed3:	c9                   	leave  
80101ed4:	c3                   	ret    
80101ed5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ee0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101ee0:	55                   	push   %ebp
  return namex(path, 1, name);
80101ee1:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80101ee6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101ee8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101eeb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101eee:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80101eef:	e9 5c fd ff ff       	jmp    80101c50 <namex>
80101ef4:	66 90                	xchg   %ax,%ax
80101ef6:	66 90                	xchg   %ax,%ax
80101ef8:	66 90                	xchg   %ax,%ax
80101efa:	66 90                	xchg   %ax,%ax
80101efc:	66 90                	xchg   %ax,%ax
80101efe:	66 90                	xchg   %ax,%ax

80101f00 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f00:	55                   	push   %ebp
  if(b == 0)
80101f01:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f03:	89 e5                	mov    %esp,%ebp
80101f05:	56                   	push   %esi
80101f06:	53                   	push   %ebx
  if(b == 0)
80101f07:	0f 84 ad 00 00 00    	je     80101fba <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f0d:	8b 58 08             	mov    0x8(%eax),%ebx
80101f10:	89 c1                	mov    %eax,%ecx
80101f12:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f18:	0f 87 8f 00 00 00    	ja     80101fad <idestart+0xad>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f1e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f23:	90                   	nop
80101f24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f28:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f29:	83 e0 c0             	and    $0xffffffc0,%eax
80101f2c:	3c 40                	cmp    $0x40,%al
80101f2e:	75 f8                	jne    80101f28 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f30:	31 f6                	xor    %esi,%esi
80101f32:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f37:	89 f0                	mov    %esi,%eax
80101f39:	ee                   	out    %al,(%dx)
80101f3a:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f3f:	b8 01 00 00 00       	mov    $0x1,%eax
80101f44:	ee                   	out    %al,(%dx)
80101f45:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f4a:	89 d8                	mov    %ebx,%eax
80101f4c:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101f4d:	89 d8                	mov    %ebx,%eax
80101f4f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f54:	c1 f8 08             	sar    $0x8,%eax
80101f57:	ee                   	out    %al,(%dx)
80101f58:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101f5d:	89 f0                	mov    %esi,%eax
80101f5f:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101f60:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80101f64:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101f69:	c1 e0 04             	shl    $0x4,%eax
80101f6c:	83 e0 10             	and    $0x10,%eax
80101f6f:	83 c8 e0             	or     $0xffffffe0,%eax
80101f72:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101f73:	f6 01 04             	testb  $0x4,(%ecx)
80101f76:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f7b:	75 13                	jne    80101f90 <idestart+0x90>
80101f7d:	b8 20 00 00 00       	mov    $0x20,%eax
80101f82:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101f83:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f86:	5b                   	pop    %ebx
80101f87:	5e                   	pop    %esi
80101f88:	5d                   	pop    %ebp
80101f89:	c3                   	ret    
80101f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f90:	b8 30 00 00 00       	mov    $0x30,%eax
80101f95:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80101f96:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80101f9b:	8d 71 5c             	lea    0x5c(%ecx),%esi
80101f9e:	b9 80 00 00 00       	mov    $0x80,%ecx
80101fa3:	fc                   	cld    
80101fa4:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fa6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101fa9:	5b                   	pop    %ebx
80101faa:	5e                   	pop    %esi
80101fab:	5d                   	pop    %ebp
80101fac:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
80101fad:	83 ec 0c             	sub    $0xc,%esp
80101fb0:	68 74 73 10 80       	push   $0x80107374
80101fb5:	e8 b6 e3 ff ff       	call   80100370 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
80101fba:	83 ec 0c             	sub    $0xc,%esp
80101fbd:	68 6b 73 10 80       	push   $0x8010736b
80101fc2:	e8 a9 e3 ff ff       	call   80100370 <panic>
80101fc7:	89 f6                	mov    %esi,%esi
80101fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fd0 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80101fd0:	55                   	push   %ebp
80101fd1:	89 e5                	mov    %esp,%ebp
80101fd3:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80101fd6:	68 86 73 10 80       	push   $0x80107386
80101fdb:	68 e0 a5 10 80       	push   $0x8010a5e0
80101fe0:	e8 ab 24 00 00       	call   80104490 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80101fe5:	58                   	pop    %eax
80101fe6:	a1 60 2d 11 80       	mov    0x80112d60,%eax
80101feb:	5a                   	pop    %edx
80101fec:	83 e8 01             	sub    $0x1,%eax
80101fef:	50                   	push   %eax
80101ff0:	6a 0e                	push   $0xe
80101ff2:	e8 a9 02 00 00       	call   801022a0 <ioapicenable>
80101ff7:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101ffa:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fff:	90                   	nop
80102000:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102001:	83 e0 c0             	and    $0xffffffc0,%eax
80102004:	3c 40                	cmp    $0x40,%al
80102006:	75 f8                	jne    80102000 <ideinit+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102008:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010200d:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102012:	ee                   	out    %al,(%dx)
80102013:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102018:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010201d:	eb 06                	jmp    80102025 <ideinit+0x55>
8010201f:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102020:	83 e9 01             	sub    $0x1,%ecx
80102023:	74 0f                	je     80102034 <ideinit+0x64>
80102025:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102026:	84 c0                	test   %al,%al
80102028:	74 f6                	je     80102020 <ideinit+0x50>
      havedisk1 = 1;
8010202a:	c7 05 c0 a5 10 80 01 	movl   $0x1,0x8010a5c0
80102031:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102034:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102039:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010203e:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
8010203f:	c9                   	leave  
80102040:	c3                   	ret    
80102041:	eb 0d                	jmp    80102050 <ideintr>
80102043:	90                   	nop
80102044:	90                   	nop
80102045:	90                   	nop
80102046:	90                   	nop
80102047:	90                   	nop
80102048:	90                   	nop
80102049:	90                   	nop
8010204a:	90                   	nop
8010204b:	90                   	nop
8010204c:	90                   	nop
8010204d:	90                   	nop
8010204e:	90                   	nop
8010204f:	90                   	nop

80102050 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80102050:	55                   	push   %ebp
80102051:	89 e5                	mov    %esp,%ebp
80102053:	57                   	push   %edi
80102054:	56                   	push   %esi
80102055:	53                   	push   %ebx
80102056:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102059:	68 e0 a5 10 80       	push   $0x8010a5e0
8010205e:	e8 8d 25 00 00       	call   801045f0 <acquire>

  if((b = idequeue) == 0){
80102063:	8b 1d c4 a5 10 80    	mov    0x8010a5c4,%ebx
80102069:	83 c4 10             	add    $0x10,%esp
8010206c:	85 db                	test   %ebx,%ebx
8010206e:	74 34                	je     801020a4 <ideintr+0x54>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102070:	8b 43 58             	mov    0x58(%ebx),%eax
80102073:	a3 c4 a5 10 80       	mov    %eax,0x8010a5c4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102078:	8b 33                	mov    (%ebx),%esi
8010207a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102080:	74 3e                	je     801020c0 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102082:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102085:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102088:	83 ce 02             	or     $0x2,%esi
8010208b:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010208d:	53                   	push   %ebx
8010208e:	e8 4d 1f 00 00       	call   80103fe0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102093:	a1 c4 a5 10 80       	mov    0x8010a5c4,%eax
80102098:	83 c4 10             	add    $0x10,%esp
8010209b:	85 c0                	test   %eax,%eax
8010209d:	74 05                	je     801020a4 <ideintr+0x54>
    idestart(idequeue);
8010209f:	e8 5c fe ff ff       	call   80101f00 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
801020a4:	83 ec 0c             	sub    $0xc,%esp
801020a7:	68 e0 a5 10 80       	push   $0x8010a5e0
801020ac:	e8 ef 25 00 00       	call   801046a0 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
801020b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020b4:	5b                   	pop    %ebx
801020b5:	5e                   	pop    %esi
801020b6:	5f                   	pop    %edi
801020b7:	5d                   	pop    %ebp
801020b8:	c3                   	ret    
801020b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020c0:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020c5:	8d 76 00             	lea    0x0(%esi),%esi
801020c8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020c9:	89 c1                	mov    %eax,%ecx
801020cb:	83 e1 c0             	and    $0xffffffc0,%ecx
801020ce:	80 f9 40             	cmp    $0x40,%cl
801020d1:	75 f5                	jne    801020c8 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020d3:	a8 21                	test   $0x21,%al
801020d5:	75 ab                	jne    80102082 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
801020d7:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
801020da:	b9 80 00 00 00       	mov    $0x80,%ecx
801020df:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020e4:	fc                   	cld    
801020e5:	f3 6d                	rep insl (%dx),%es:(%edi)
801020e7:	8b 33                	mov    (%ebx),%esi
801020e9:	eb 97                	jmp    80102082 <ideintr+0x32>
801020eb:	90                   	nop
801020ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801020f0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801020f0:	55                   	push   %ebp
801020f1:	89 e5                	mov    %esp,%ebp
801020f3:	53                   	push   %ebx
801020f4:	83 ec 10             	sub    $0x10,%esp
801020f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801020fa:	8d 43 0c             	lea    0xc(%ebx),%eax
801020fd:	50                   	push   %eax
801020fe:	e8 3d 23 00 00       	call   80104440 <holdingsleep>
80102103:	83 c4 10             	add    $0x10,%esp
80102106:	85 c0                	test   %eax,%eax
80102108:	0f 84 ad 00 00 00    	je     801021bb <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010210e:	8b 03                	mov    (%ebx),%eax
80102110:	83 e0 06             	and    $0x6,%eax
80102113:	83 f8 02             	cmp    $0x2,%eax
80102116:	0f 84 b9 00 00 00    	je     801021d5 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010211c:	8b 53 04             	mov    0x4(%ebx),%edx
8010211f:	85 d2                	test   %edx,%edx
80102121:	74 0d                	je     80102130 <iderw+0x40>
80102123:	a1 c0 a5 10 80       	mov    0x8010a5c0,%eax
80102128:	85 c0                	test   %eax,%eax
8010212a:	0f 84 98 00 00 00    	je     801021c8 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102130:	83 ec 0c             	sub    $0xc,%esp
80102133:	68 e0 a5 10 80       	push   $0x8010a5e0
80102138:	e8 b3 24 00 00       	call   801045f0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010213d:	8b 15 c4 a5 10 80    	mov    0x8010a5c4,%edx
80102143:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
80102146:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010214d:	85 d2                	test   %edx,%edx
8010214f:	75 09                	jne    8010215a <iderw+0x6a>
80102151:	eb 58                	jmp    801021ab <iderw+0xbb>
80102153:	90                   	nop
80102154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102158:	89 c2                	mov    %eax,%edx
8010215a:	8b 42 58             	mov    0x58(%edx),%eax
8010215d:	85 c0                	test   %eax,%eax
8010215f:	75 f7                	jne    80102158 <iderw+0x68>
80102161:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102164:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102166:	3b 1d c4 a5 10 80    	cmp    0x8010a5c4,%ebx
8010216c:	74 44                	je     801021b2 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010216e:	8b 03                	mov    (%ebx),%eax
80102170:	83 e0 06             	and    $0x6,%eax
80102173:	83 f8 02             	cmp    $0x2,%eax
80102176:	74 23                	je     8010219b <iderw+0xab>
80102178:	90                   	nop
80102179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102180:	83 ec 08             	sub    $0x8,%esp
80102183:	68 e0 a5 10 80       	push   $0x8010a5e0
80102188:	53                   	push   %ebx
80102189:	e8 92 1c 00 00       	call   80103e20 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010218e:	8b 03                	mov    (%ebx),%eax
80102190:	83 c4 10             	add    $0x10,%esp
80102193:	83 e0 06             	and    $0x6,%eax
80102196:	83 f8 02             	cmp    $0x2,%eax
80102199:	75 e5                	jne    80102180 <iderw+0x90>
    sleep(b, &idelock);
  }


  release(&idelock);
8010219b:	c7 45 08 e0 a5 10 80 	movl   $0x8010a5e0,0x8(%ebp)
}
801021a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021a5:	c9                   	leave  
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
801021a6:	e9 f5 24 00 00       	jmp    801046a0 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021ab:	ba c4 a5 10 80       	mov    $0x8010a5c4,%edx
801021b0:	eb b2                	jmp    80102164 <iderw+0x74>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
801021b2:	89 d8                	mov    %ebx,%eax
801021b4:	e8 47 fd ff ff       	call   80101f00 <idestart>
801021b9:	eb b3                	jmp    8010216e <iderw+0x7e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
801021bb:	83 ec 0c             	sub    $0xc,%esp
801021be:	68 8a 73 10 80       	push   $0x8010738a
801021c3:	e8 a8 e1 ff ff       	call   80100370 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
801021c8:	83 ec 0c             	sub    $0xc,%esp
801021cb:	68 b5 73 10 80       	push   $0x801073b5
801021d0:	e8 9b e1 ff ff       	call   80100370 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
801021d5:	83 ec 0c             	sub    $0xc,%esp
801021d8:	68 a0 73 10 80       	push   $0x801073a0
801021dd:	e8 8e e1 ff ff       	call   80100370 <panic>
801021e2:	66 90                	xchg   %ax,%ax
801021e4:	66 90                	xchg   %ax,%ax
801021e6:	66 90                	xchg   %ax,%ax
801021e8:	66 90                	xchg   %ax,%ax
801021ea:	66 90                	xchg   %ax,%ax
801021ec:	66 90                	xchg   %ax,%ax
801021ee:	66 90                	xchg   %ax,%ax

801021f0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801021f0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801021f1:	c7 05 94 26 11 80 00 	movl   $0xfec00000,0x80112694
801021f8:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
801021fb:	89 e5                	mov    %esp,%ebp
801021fd:	56                   	push   %esi
801021fe:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801021ff:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102206:	00 00 00 
  return ioapic->data;
80102209:	8b 15 94 26 11 80    	mov    0x80112694,%edx
8010220f:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102212:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102218:	8b 0d 94 26 11 80    	mov    0x80112694,%ecx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010221e:	0f b6 15 c0 27 11 80 	movzbl 0x801127c0,%edx
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102225:	c1 ee 10             	shr    $0x10,%esi
80102228:	89 f0                	mov    %esi,%eax
8010222a:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
8010222d:	8b 41 10             	mov    0x10(%ecx),%eax
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
80102230:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102233:	39 d0                	cmp    %edx,%eax
80102235:	74 16                	je     8010224d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102237:	83 ec 0c             	sub    $0xc,%esp
8010223a:	68 d4 73 10 80       	push   $0x801073d4
8010223f:	e8 1c e4 ff ff       	call   80100660 <cprintf>
80102244:	8b 0d 94 26 11 80    	mov    0x80112694,%ecx
8010224a:	83 c4 10             	add    $0x10,%esp
8010224d:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102250:	ba 10 00 00 00       	mov    $0x10,%edx
80102255:	b8 20 00 00 00       	mov    $0x20,%eax
8010225a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102260:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102262:	8b 0d 94 26 11 80    	mov    0x80112694,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102268:	89 c3                	mov    %eax,%ebx
8010226a:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80102270:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102273:	89 59 10             	mov    %ebx,0x10(%ecx)
80102276:	8d 5a 01             	lea    0x1(%edx),%ebx
80102279:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010227c:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010227e:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102280:	8b 0d 94 26 11 80    	mov    0x80112694,%ecx
80102286:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010228d:	75 d1                	jne    80102260 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010228f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102292:	5b                   	pop    %ebx
80102293:	5e                   	pop    %esi
80102294:	5d                   	pop    %ebp
80102295:	c3                   	ret    
80102296:	8d 76 00             	lea    0x0(%esi),%esi
80102299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022a0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801022a0:	55                   	push   %ebp
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022a1:	8b 0d 94 26 11 80    	mov    0x80112694,%ecx
  }
}

void
ioapicenable(int irq, int cpunum)
{
801022a7:	89 e5                	mov    %esp,%ebp
801022a9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022ac:	8d 50 20             	lea    0x20(%eax),%edx
801022af:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022b3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022b5:	8b 0d 94 26 11 80    	mov    0x80112694,%ecx
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022bb:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801022be:	89 51 10             	mov    %edx,0x10(%ecx)
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022c1:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022c4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022c6:	a1 94 26 11 80       	mov    0x80112694,%eax
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022cb:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801022ce:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
801022d1:	5d                   	pop    %ebp
801022d2:	c3                   	ret    
801022d3:	66 90                	xchg   %ax,%ax
801022d5:	66 90                	xchg   %ax,%ax
801022d7:	66 90                	xchg   %ax,%ax
801022d9:	66 90                	xchg   %ax,%ax
801022db:	66 90                	xchg   %ax,%ax
801022dd:	66 90                	xchg   %ax,%ax
801022df:	90                   	nop

801022e0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801022e0:	55                   	push   %ebp
801022e1:	89 e5                	mov    %esp,%ebp
801022e3:	53                   	push   %ebx
801022e4:	83 ec 04             	sub    $0x4,%esp
801022e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801022ea:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801022f0:	75 70                	jne    80102362 <kfree+0x82>
801022f2:	81 fb 08 5a 11 80    	cmp    $0x80115a08,%ebx
801022f8:	72 68                	jb     80102362 <kfree+0x82>
801022fa:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102300:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102305:	77 5b                	ja     80102362 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102307:	83 ec 04             	sub    $0x4,%esp
8010230a:	68 00 10 00 00       	push   $0x1000
8010230f:	6a 01                	push   $0x1
80102311:	53                   	push   %ebx
80102312:	e8 d9 23 00 00       	call   801046f0 <memset>

  if(kmem.use_lock)
80102317:	8b 15 d4 26 11 80    	mov    0x801126d4,%edx
8010231d:	83 c4 10             	add    $0x10,%esp
80102320:	85 d2                	test   %edx,%edx
80102322:	75 2c                	jne    80102350 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102324:	a1 d8 26 11 80       	mov    0x801126d8,%eax
80102329:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010232b:	a1 d4 26 11 80       	mov    0x801126d4,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102330:	89 1d d8 26 11 80    	mov    %ebx,0x801126d8
  if(kmem.use_lock)
80102336:	85 c0                	test   %eax,%eax
80102338:	75 06                	jne    80102340 <kfree+0x60>
    release(&kmem.lock);
}
8010233a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010233d:	c9                   	leave  
8010233e:	c3                   	ret    
8010233f:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102340:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102347:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010234a:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
8010234b:	e9 50 23 00 00       	jmp    801046a0 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102350:	83 ec 0c             	sub    $0xc,%esp
80102353:	68 a0 26 11 80       	push   $0x801126a0
80102358:	e8 93 22 00 00       	call   801045f0 <acquire>
8010235d:	83 c4 10             	add    $0x10,%esp
80102360:	eb c2                	jmp    80102324 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102362:	83 ec 0c             	sub    $0xc,%esp
80102365:	68 06 74 10 80       	push   $0x80107406
8010236a:	e8 01 e0 ff ff       	call   80100370 <panic>
8010236f:	90                   	nop

80102370 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102370:	55                   	push   %ebp
80102371:	89 e5                	mov    %esp,%ebp
80102373:	56                   	push   %esi
80102374:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102375:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102378:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010237b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102381:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102387:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010238d:	39 de                	cmp    %ebx,%esi
8010238f:	72 23                	jb     801023b4 <freerange+0x44>
80102391:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102398:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010239e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023a1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023a7:	50                   	push   %eax
801023a8:	e8 33 ff ff ff       	call   801022e0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023ad:	83 c4 10             	add    $0x10,%esp
801023b0:	39 f3                	cmp    %esi,%ebx
801023b2:	76 e4                	jbe    80102398 <freerange+0x28>
    kfree(p);
}
801023b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023b7:	5b                   	pop    %ebx
801023b8:	5e                   	pop    %esi
801023b9:	5d                   	pop    %ebp
801023ba:	c3                   	ret    
801023bb:	90                   	nop
801023bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801023c0 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801023c0:	55                   	push   %ebp
801023c1:	89 e5                	mov    %esp,%ebp
801023c3:	56                   	push   %esi
801023c4:	53                   	push   %ebx
801023c5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801023c8:	83 ec 08             	sub    $0x8,%esp
801023cb:	68 0c 74 10 80       	push   $0x8010740c
801023d0:	68 a0 26 11 80       	push   $0x801126a0
801023d5:	e8 b6 20 00 00       	call   80104490 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023da:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023dd:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
801023e0:	c7 05 d4 26 11 80 00 	movl   $0x0,0x801126d4
801023e7:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023ea:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023f0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023f6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023fc:	39 de                	cmp    %ebx,%esi
801023fe:	72 1c                	jb     8010241c <kinit1+0x5c>
    kfree(p);
80102400:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102406:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102409:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010240f:	50                   	push   %eax
80102410:	e8 cb fe ff ff       	call   801022e0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102415:	83 c4 10             	add    $0x10,%esp
80102418:	39 de                	cmp    %ebx,%esi
8010241a:	73 e4                	jae    80102400 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
8010241c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010241f:	5b                   	pop    %ebx
80102420:	5e                   	pop    %esi
80102421:	5d                   	pop    %ebp
80102422:	c3                   	ret    
80102423:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102430 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102430:	55                   	push   %ebp
80102431:	89 e5                	mov    %esp,%ebp
80102433:	56                   	push   %esi
80102434:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102435:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
80102438:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010243b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102441:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102447:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010244d:	39 de                	cmp    %ebx,%esi
8010244f:	72 23                	jb     80102474 <kinit2+0x44>
80102451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102458:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010245e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102461:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102467:	50                   	push   %eax
80102468:	e8 73 fe ff ff       	call   801022e0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010246d:	83 c4 10             	add    $0x10,%esp
80102470:	39 de                	cmp    %ebx,%esi
80102472:	73 e4                	jae    80102458 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
80102474:	c7 05 d4 26 11 80 01 	movl   $0x1,0x801126d4
8010247b:	00 00 00 
}
8010247e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102481:	5b                   	pop    %ebx
80102482:	5e                   	pop    %esi
80102483:	5d                   	pop    %ebp
80102484:	c3                   	ret    
80102485:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102490 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	53                   	push   %ebx
80102494:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102497:	a1 d4 26 11 80       	mov    0x801126d4,%eax
8010249c:	85 c0                	test   %eax,%eax
8010249e:	75 30                	jne    801024d0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024a0:	8b 1d d8 26 11 80    	mov    0x801126d8,%ebx
  if(r)
801024a6:	85 db                	test   %ebx,%ebx
801024a8:	74 1c                	je     801024c6 <kalloc+0x36>
    kmem.freelist = r->next;
801024aa:	8b 13                	mov    (%ebx),%edx
801024ac:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  if(kmem.use_lock)
801024b2:	85 c0                	test   %eax,%eax
801024b4:	74 10                	je     801024c6 <kalloc+0x36>
    release(&kmem.lock);
801024b6:	83 ec 0c             	sub    $0xc,%esp
801024b9:	68 a0 26 11 80       	push   $0x801126a0
801024be:	e8 dd 21 00 00       	call   801046a0 <release>
801024c3:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
801024c6:	89 d8                	mov    %ebx,%eax
801024c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024cb:	c9                   	leave  
801024cc:	c3                   	ret    
801024cd:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
801024d0:	83 ec 0c             	sub    $0xc,%esp
801024d3:	68 a0 26 11 80       	push   $0x801126a0
801024d8:	e8 13 21 00 00       	call   801045f0 <acquire>
  r = kmem.freelist;
801024dd:	8b 1d d8 26 11 80    	mov    0x801126d8,%ebx
  if(r)
801024e3:	83 c4 10             	add    $0x10,%esp
801024e6:	a1 d4 26 11 80       	mov    0x801126d4,%eax
801024eb:	85 db                	test   %ebx,%ebx
801024ed:	75 bb                	jne    801024aa <kalloc+0x1a>
801024ef:	eb c1                	jmp    801024b2 <kalloc+0x22>
801024f1:	66 90                	xchg   %ax,%ax
801024f3:	66 90                	xchg   %ax,%ax
801024f5:	66 90                	xchg   %ax,%ax
801024f7:	66 90                	xchg   %ax,%ax
801024f9:	66 90                	xchg   %ax,%ax
801024fb:	66 90                	xchg   %ax,%ax
801024fd:	66 90                	xchg   %ax,%ax
801024ff:	90                   	nop

80102500 <kbdgetc>:
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102500:	ba 64 00 00 00       	mov    $0x64,%edx
80102505:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102506:	a8 01                	test   $0x1,%al
80102508:	0f 84 c2 00 00 00    	je     801025d0 <kbdgetc+0xd0>
8010250e:	ba 60 00 00 00       	mov    $0x60,%edx
80102513:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102514:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
80102517:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
8010251d:	0f 84 9d 00 00 00    	je     801025c0 <kbdgetc+0xc0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102523:	84 c0                	test   %al,%al
80102525:	78 59                	js     80102580 <kbdgetc+0x80>
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102527:	55                   	push   %ebp
80102528:	89 e5                	mov    %esp,%ebp
8010252a:	53                   	push   %ebx
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010252b:	8b 1d 14 a6 10 80    	mov    0x8010a614,%ebx
80102531:	f6 c3 40             	test   $0x40,%bl
80102534:	74 09                	je     8010253f <kbdgetc+0x3f>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102536:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102539:	83 e3 bf             	and    $0xffffffbf,%ebx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010253c:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
8010253f:	0f b6 8a 40 75 10 80 	movzbl -0x7fef8ac0(%edx),%ecx
  shift ^= togglecode[data];
80102546:	0f b6 82 40 74 10 80 	movzbl -0x7fef8bc0(%edx),%eax
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
8010254d:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
8010254f:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102551:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102553:	89 0d 14 a6 10 80    	mov    %ecx,0x8010a614
  c = charcode[shift & (CTL | SHIFT)][data];
80102559:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010255c:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010255f:	8b 04 85 20 74 10 80 	mov    -0x7fef8be0(,%eax,4),%eax
80102566:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010256a:	74 0b                	je     80102577 <kbdgetc+0x77>
    if('a' <= c && c <= 'z')
8010256c:	8d 50 9f             	lea    -0x61(%eax),%edx
8010256f:	83 fa 19             	cmp    $0x19,%edx
80102572:	77 3c                	ja     801025b0 <kbdgetc+0xb0>
      c += 'A' - 'a';
80102574:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102577:	5b                   	pop    %ebx
80102578:	5d                   	pop    %ebp
80102579:	c3                   	ret    
8010257a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102580:	8b 0d 14 a6 10 80    	mov    0x8010a614,%ecx
80102586:	83 e0 7f             	and    $0x7f,%eax
80102589:	f6 c1 40             	test   $0x40,%cl
8010258c:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
8010258f:	0f b6 82 40 75 10 80 	movzbl -0x7fef8ac0(%edx),%eax
80102596:	83 c8 40             	or     $0x40,%eax
80102599:	0f b6 c0             	movzbl %al,%eax
8010259c:	f7 d0                	not    %eax
8010259e:	21 c8                	and    %ecx,%eax
801025a0:	a3 14 a6 10 80       	mov    %eax,0x8010a614
    return 0;
801025a5:	31 c0                	xor    %eax,%eax
801025a7:	c3                   	ret    
801025a8:	90                   	nop
801025a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
801025b0:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801025b3:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
801025b6:	5b                   	pop    %ebx
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
801025b7:	83 f9 19             	cmp    $0x19,%ecx
801025ba:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
801025bd:	5d                   	pop    %ebp
801025be:	c3                   	ret    
801025bf:	90                   	nop
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801025c0:	83 0d 14 a6 10 80 40 	orl    $0x40,0x8010a614
    return 0;
801025c7:	31 c0                	xor    %eax,%eax
801025c9:	c3                   	ret    
801025ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
801025d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801025d5:	c3                   	ret    
801025d6:	8d 76 00             	lea    0x0(%esi),%esi
801025d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025e0 <kbdintr>:
  return c;
}

void
kbdintr(void)
{
801025e0:	55                   	push   %ebp
801025e1:	89 e5                	mov    %esp,%ebp
801025e3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801025e6:	68 00 25 10 80       	push   $0x80102500
801025eb:	e8 f0 e1 ff ff       	call   801007e0 <consoleintr>
}
801025f0:	83 c4 10             	add    $0x10,%esp
801025f3:	c9                   	leave  
801025f4:	c3                   	ret    
801025f5:	66 90                	xchg   %ax,%ax
801025f7:	66 90                	xchg   %ax,%ax
801025f9:	66 90                	xchg   %ax,%ax
801025fb:	66 90                	xchg   %ax,%ax
801025fd:	66 90                	xchg   %ax,%ax
801025ff:	90                   	nop

80102600 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102600:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
80102605:	55                   	push   %ebp
80102606:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102608:	85 c0                	test   %eax,%eax
8010260a:	0f 84 c8 00 00 00    	je     801026d8 <lapicinit+0xd8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102610:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102617:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010261a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010261d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102624:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102627:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010262a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102631:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102634:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102637:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010263e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102641:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102644:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010264b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010264e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102651:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102658:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010265b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010265e:	8b 50 30             	mov    0x30(%eax),%edx
80102661:	c1 ea 10             	shr    $0x10,%edx
80102664:	80 fa 03             	cmp    $0x3,%dl
80102667:	77 77                	ja     801026e0 <lapicinit+0xe0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102669:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102670:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102673:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102676:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010267d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102680:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102683:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010268a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010268d:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102690:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102697:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010269a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010269d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801026a4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026a7:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026aa:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801026b1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801026b4:	8b 50 20             	mov    0x20(%eax),%edx
801026b7:	89 f6                	mov    %esi,%esi
801026b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801026c0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801026c6:	80 e6 10             	and    $0x10,%dh
801026c9:	75 f5                	jne    801026c0 <lapicinit+0xc0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026cb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801026d2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026d5:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801026d8:	5d                   	pop    %ebp
801026d9:	c3                   	ret    
801026da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026e0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801026e7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026ea:	8b 50 20             	mov    0x20(%eax),%edx
801026ed:	e9 77 ff ff ff       	jmp    80102669 <lapicinit+0x69>
801026f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102700 <lapicid>:
}

int
lapicid(void)
{
  if (!lapic)
80102700:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  lapicw(TPR, 0);
}

int
lapicid(void)
{
80102705:	55                   	push   %ebp
80102706:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102708:	85 c0                	test   %eax,%eax
8010270a:	74 0c                	je     80102718 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
8010270c:	8b 40 20             	mov    0x20(%eax),%eax
}
8010270f:	5d                   	pop    %ebp
int
lapicid(void)
{
  if (!lapic)
    return 0;
  return lapic[ID] >> 24;
80102710:	c1 e8 18             	shr    $0x18,%eax
}
80102713:	c3                   	ret    
80102714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102718:	31 c0                	xor    %eax,%eax
8010271a:	5d                   	pop    %ebp
8010271b:	c3                   	ret    
8010271c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102720 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102720:	a1 dc 26 11 80       	mov    0x801126dc,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102725:	55                   	push   %ebp
80102726:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102728:	85 c0                	test   %eax,%eax
8010272a:	74 0d                	je     80102739 <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010272c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102733:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102736:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102739:	5d                   	pop    %ebp
8010273a:	c3                   	ret    
8010273b:	90                   	nop
8010273c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102740 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102740:	55                   	push   %ebp
80102741:	89 e5                	mov    %esp,%ebp
}
80102743:	5d                   	pop    %ebp
80102744:	c3                   	ret    
80102745:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102750 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102750:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102751:	ba 70 00 00 00       	mov    $0x70,%edx
80102756:	b8 0f 00 00 00       	mov    $0xf,%eax
8010275b:	89 e5                	mov    %esp,%ebp
8010275d:	53                   	push   %ebx
8010275e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102761:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102764:	ee                   	out    %al,(%dx)
80102765:	ba 71 00 00 00       	mov    $0x71,%edx
8010276a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010276f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102770:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102772:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102775:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010277b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010277d:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102780:	c1 e8 04             	shr    $0x4,%eax

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102783:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102785:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102788:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010278e:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102793:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102799:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010279c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801027a3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027a6:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027a9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801027b0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027b3:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027b6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027bc:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027bf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027c5:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027c8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027ce:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027d1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027d7:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801027da:	5b                   	pop    %ebx
801027db:	5d                   	pop    %ebp
801027dc:	c3                   	ret    
801027dd:	8d 76 00             	lea    0x0(%esi),%esi

801027e0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801027e0:	55                   	push   %ebp
801027e1:	ba 70 00 00 00       	mov    $0x70,%edx
801027e6:	b8 0b 00 00 00       	mov    $0xb,%eax
801027eb:	89 e5                	mov    %esp,%ebp
801027ed:	57                   	push   %edi
801027ee:	56                   	push   %esi
801027ef:	53                   	push   %ebx
801027f0:	83 ec 5c             	sub    $0x5c,%esp
801027f3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801027f4:	ba 71 00 00 00       	mov    $0x71,%edx
801027f9:	ec                   	in     (%dx),%al
801027fa:	83 e0 04             	and    $0x4,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027fd:	bb 70 00 00 00       	mov    $0x70,%ebx
80102802:	88 45 a7             	mov    %al,-0x59(%ebp)
80102805:	8d 76 00             	lea    0x0(%esi),%esi
80102808:	31 c0                	xor    %eax,%eax
8010280a:	89 da                	mov    %ebx,%edx
8010280c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010280d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102812:	89 ca                	mov    %ecx,%edx
80102814:	ec                   	in     (%dx),%al
cmos_read(uint reg)
{
  outb(CMOS_PORT,  reg);
  microdelay(200);

  return inb(CMOS_RETURN);
80102815:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102818:	89 da                	mov    %ebx,%edx
8010281a:	89 45 b4             	mov    %eax,-0x4c(%ebp)
8010281d:	b8 02 00 00 00       	mov    $0x2,%eax
80102822:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102823:	89 ca                	mov    %ecx,%edx
80102825:	ec                   	in     (%dx),%al
80102826:	0f b6 f0             	movzbl %al,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102829:	89 da                	mov    %ebx,%edx
8010282b:	b8 04 00 00 00       	mov    $0x4,%eax
80102830:	89 75 b0             	mov    %esi,-0x50(%ebp)
80102833:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102834:	89 ca                	mov    %ecx,%edx
80102836:	ec                   	in     (%dx),%al
80102837:	0f b6 f8             	movzbl %al,%edi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010283a:	89 da                	mov    %ebx,%edx
8010283c:	b8 07 00 00 00       	mov    $0x7,%eax
80102841:	89 7d ac             	mov    %edi,-0x54(%ebp)
80102844:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102845:	89 ca                	mov    %ecx,%edx
80102847:	ec                   	in     (%dx),%al
80102848:	0f b6 d0             	movzbl %al,%edx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010284b:	b8 08 00 00 00       	mov    $0x8,%eax
80102850:	89 55 a8             	mov    %edx,-0x58(%ebp)
80102853:	89 da                	mov    %ebx,%edx
80102855:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102856:	89 ca                	mov    %ecx,%edx
80102858:	ec                   	in     (%dx),%al
80102859:	0f b6 f8             	movzbl %al,%edi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010285c:	89 da                	mov    %ebx,%edx
8010285e:	b8 09 00 00 00       	mov    $0x9,%eax
80102863:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102864:	89 ca                	mov    %ecx,%edx
80102866:	ec                   	in     (%dx),%al
80102867:	0f b6 f0             	movzbl %al,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010286a:	89 da                	mov    %ebx,%edx
8010286c:	b8 0a 00 00 00       	mov    $0xa,%eax
80102871:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102872:	89 ca                	mov    %ecx,%edx
80102874:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102875:	84 c0                	test   %al,%al
80102877:	78 8f                	js     80102808 <cmostime+0x28>
80102879:	8b 45 b4             	mov    -0x4c(%ebp),%eax
8010287c:	8b 55 a8             	mov    -0x58(%ebp),%edx
8010287f:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102882:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102885:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102888:	8b 45 b0             	mov    -0x50(%ebp),%eax
8010288b:	89 55 c4             	mov    %edx,-0x3c(%ebp)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010288e:	89 da                	mov    %ebx,%edx
80102890:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102893:	8b 45 ac             	mov    -0x54(%ebp),%eax
80102896:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102899:	31 c0                	xor    %eax,%eax
8010289b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010289c:	89 ca                	mov    %ecx,%edx
8010289e:	ec                   	in     (%dx),%al
cmos_read(uint reg)
{
  outb(CMOS_PORT,  reg);
  microdelay(200);

  return inb(CMOS_RETURN);
8010289f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028a2:	89 da                	mov    %ebx,%edx
801028a4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801028a7:	b8 02 00 00 00       	mov    $0x2,%eax
801028ac:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ad:	89 ca                	mov    %ecx,%edx
801028af:	ec                   	in     (%dx),%al
801028b0:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028b3:	89 da                	mov    %ebx,%edx
801028b5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801028b8:	b8 04 00 00 00       	mov    $0x4,%eax
801028bd:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028be:	89 ca                	mov    %ecx,%edx
801028c0:	ec                   	in     (%dx),%al
801028c1:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028c4:	89 da                	mov    %ebx,%edx
801028c6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801028c9:	b8 07 00 00 00       	mov    $0x7,%eax
801028ce:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028cf:	89 ca                	mov    %ecx,%edx
801028d1:	ec                   	in     (%dx),%al
801028d2:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028d5:	89 da                	mov    %ebx,%edx
801028d7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801028da:	b8 08 00 00 00       	mov    $0x8,%eax
801028df:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028e0:	89 ca                	mov    %ecx,%edx
801028e2:	ec                   	in     (%dx),%al
801028e3:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028e6:	89 da                	mov    %ebx,%edx
801028e8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801028eb:	b8 09 00 00 00       	mov    $0x9,%eax
801028f0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028f1:	89 ca                	mov    %ecx,%edx
801028f3:	ec                   	in     (%dx),%al
801028f4:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801028f7:	83 ec 04             	sub    $0x4,%esp
cmos_read(uint reg)
{
  outb(CMOS_PORT,  reg);
  microdelay(200);

  return inb(CMOS_RETURN);
801028fa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801028fd:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102900:	6a 18                	push   $0x18
80102902:	50                   	push   %eax
80102903:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102906:	50                   	push   %eax
80102907:	e8 34 1e 00 00       	call   80104740 <memcmp>
8010290c:	83 c4 10             	add    $0x10,%esp
8010290f:	85 c0                	test   %eax,%eax
80102911:	0f 85 f1 fe ff ff    	jne    80102808 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102917:	80 7d a7 00          	cmpb   $0x0,-0x59(%ebp)
8010291b:	75 78                	jne    80102995 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010291d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102920:	89 c2                	mov    %eax,%edx
80102922:	83 e0 0f             	and    $0xf,%eax
80102925:	c1 ea 04             	shr    $0x4,%edx
80102928:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010292b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010292e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102931:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102934:	89 c2                	mov    %eax,%edx
80102936:	83 e0 0f             	and    $0xf,%eax
80102939:	c1 ea 04             	shr    $0x4,%edx
8010293c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010293f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102942:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102945:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102948:	89 c2                	mov    %eax,%edx
8010294a:	83 e0 0f             	and    $0xf,%eax
8010294d:	c1 ea 04             	shr    $0x4,%edx
80102950:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102953:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102956:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102959:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010295c:	89 c2                	mov    %eax,%edx
8010295e:	83 e0 0f             	and    $0xf,%eax
80102961:	c1 ea 04             	shr    $0x4,%edx
80102964:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102967:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010296a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010296d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102970:	89 c2                	mov    %eax,%edx
80102972:	83 e0 0f             	and    $0xf,%eax
80102975:	c1 ea 04             	shr    $0x4,%edx
80102978:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010297b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010297e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102981:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102984:	89 c2                	mov    %eax,%edx
80102986:	83 e0 0f             	and    $0xf,%eax
80102989:	c1 ea 04             	shr    $0x4,%edx
8010298c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010298f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102992:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102995:	8b 75 08             	mov    0x8(%ebp),%esi
80102998:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010299b:	89 06                	mov    %eax,(%esi)
8010299d:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029a0:	89 46 04             	mov    %eax,0x4(%esi)
801029a3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029a6:	89 46 08             	mov    %eax,0x8(%esi)
801029a9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029ac:	89 46 0c             	mov    %eax,0xc(%esi)
801029af:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029b2:	89 46 10             	mov    %eax,0x10(%esi)
801029b5:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029b8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801029bb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
801029c2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801029c5:	5b                   	pop    %ebx
801029c6:	5e                   	pop    %esi
801029c7:	5f                   	pop    %edi
801029c8:	5d                   	pop    %ebp
801029c9:	c3                   	ret    
801029ca:	66 90                	xchg   %ax,%ax
801029cc:	66 90                	xchg   %ax,%ax
801029ce:	66 90                	xchg   %ax,%ax

801029d0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801029d0:	8b 0d 28 27 11 80    	mov    0x80112728,%ecx
801029d6:	85 c9                	test   %ecx,%ecx
801029d8:	0f 8e 85 00 00 00    	jle    80102a63 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
801029de:	55                   	push   %ebp
801029df:	89 e5                	mov    %esp,%ebp
801029e1:	57                   	push   %edi
801029e2:	56                   	push   %esi
801029e3:	53                   	push   %ebx
801029e4:	31 db                	xor    %ebx,%ebx
801029e6:	83 ec 0c             	sub    $0xc,%esp
801029e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801029f0:	a1 14 27 11 80       	mov    0x80112714,%eax
801029f5:	83 ec 08             	sub    $0x8,%esp
801029f8:	01 d8                	add    %ebx,%eax
801029fa:	83 c0 01             	add    $0x1,%eax
801029fd:	50                   	push   %eax
801029fe:	ff 35 24 27 11 80    	pushl  0x80112724
80102a04:	e8 c7 d6 ff ff       	call   801000d0 <bread>
80102a09:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a0b:	58                   	pop    %eax
80102a0c:	5a                   	pop    %edx
80102a0d:	ff 34 9d 2c 27 11 80 	pushl  -0x7feed8d4(,%ebx,4)
80102a14:	ff 35 24 27 11 80    	pushl  0x80112724
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a1a:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a1d:	e8 ae d6 ff ff       	call   801000d0 <bread>
80102a22:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a24:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a27:	83 c4 0c             	add    $0xc,%esp
80102a2a:	68 00 02 00 00       	push   $0x200
80102a2f:	50                   	push   %eax
80102a30:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a33:	50                   	push   %eax
80102a34:	e8 67 1d 00 00       	call   801047a0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a39:	89 34 24             	mov    %esi,(%esp)
80102a3c:	e8 5f d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a41:	89 3c 24             	mov    %edi,(%esp)
80102a44:	e8 97 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102a49:	89 34 24             	mov    %esi,(%esp)
80102a4c:	e8 8f d7 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a51:	83 c4 10             	add    $0x10,%esp
80102a54:	39 1d 28 27 11 80    	cmp    %ebx,0x80112728
80102a5a:	7f 94                	jg     801029f0 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102a5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a5f:	5b                   	pop    %ebx
80102a60:	5e                   	pop    %esi
80102a61:	5f                   	pop    %edi
80102a62:	5d                   	pop    %ebp
80102a63:	f3 c3                	repz ret 
80102a65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a70 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102a70:	55                   	push   %ebp
80102a71:	89 e5                	mov    %esp,%ebp
80102a73:	53                   	push   %ebx
80102a74:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102a77:	ff 35 14 27 11 80    	pushl  0x80112714
80102a7d:	ff 35 24 27 11 80    	pushl  0x80112724
80102a83:	e8 48 d6 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102a88:	8b 0d 28 27 11 80    	mov    0x80112728,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102a8e:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102a91:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102a93:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102a95:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102a98:	7e 1f                	jle    80102ab9 <write_head+0x49>
80102a9a:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102aa1:	31 d2                	xor    %edx,%edx
80102aa3:	90                   	nop
80102aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102aa8:	8b 8a 2c 27 11 80    	mov    -0x7feed8d4(%edx),%ecx
80102aae:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102ab2:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102ab5:	39 c2                	cmp    %eax,%edx
80102ab7:	75 ef                	jne    80102aa8 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102ab9:	83 ec 0c             	sub    $0xc,%esp
80102abc:	53                   	push   %ebx
80102abd:	e8 de d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102ac2:	89 1c 24             	mov    %ebx,(%esp)
80102ac5:	e8 16 d7 ff ff       	call   801001e0 <brelse>
}
80102aca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102acd:	c9                   	leave  
80102ace:	c3                   	ret    
80102acf:	90                   	nop

80102ad0 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102ad0:	55                   	push   %ebp
80102ad1:	89 e5                	mov    %esp,%ebp
80102ad3:	53                   	push   %ebx
80102ad4:	83 ec 2c             	sub    $0x2c,%esp
80102ad7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102ada:	68 40 76 10 80       	push   $0x80107640
80102adf:	68 e0 26 11 80       	push   $0x801126e0
80102ae4:	e8 a7 19 00 00       	call   80104490 <initlock>
  readsb(dev, &sb);
80102ae9:	58                   	pop    %eax
80102aea:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102aed:	5a                   	pop    %edx
80102aee:	50                   	push   %eax
80102aef:	53                   	push   %ebx
80102af0:	e8 bb e8 ff ff       	call   801013b0 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102af5:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102af8:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102afb:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102afc:	89 1d 24 27 11 80    	mov    %ebx,0x80112724

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102b02:	89 15 18 27 11 80    	mov    %edx,0x80112718
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102b08:	a3 14 27 11 80       	mov    %eax,0x80112714

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b0d:	5a                   	pop    %edx
80102b0e:	50                   	push   %eax
80102b0f:	53                   	push   %ebx
80102b10:	e8 bb d5 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102b15:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102b18:	83 c4 10             	add    $0x10,%esp
80102b1b:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102b1d:	89 0d 28 27 11 80    	mov    %ecx,0x80112728
  for (i = 0; i < log.lh.n; i++) {
80102b23:	7e 1c                	jle    80102b41 <initlog+0x71>
80102b25:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102b2c:	31 d2                	xor    %edx,%edx
80102b2e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102b30:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b34:	83 c2 04             	add    $0x4,%edx
80102b37:	89 8a 28 27 11 80    	mov    %ecx,-0x7feed8d8(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102b3d:	39 da                	cmp    %ebx,%edx
80102b3f:	75 ef                	jne    80102b30 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102b41:	83 ec 0c             	sub    $0xc,%esp
80102b44:	50                   	push   %eax
80102b45:	e8 96 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b4a:	e8 81 fe ff ff       	call   801029d0 <install_trans>
  log.lh.n = 0;
80102b4f:	c7 05 28 27 11 80 00 	movl   $0x0,0x80112728
80102b56:	00 00 00 
  write_head(); // clear the log
80102b59:	e8 12 ff ff ff       	call   80102a70 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102b5e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b61:	c9                   	leave  
80102b62:	c3                   	ret    
80102b63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b70 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102b70:	55                   	push   %ebp
80102b71:	89 e5                	mov    %esp,%ebp
80102b73:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102b76:	68 e0 26 11 80       	push   $0x801126e0
80102b7b:	e8 70 1a 00 00       	call   801045f0 <acquire>
80102b80:	83 c4 10             	add    $0x10,%esp
80102b83:	eb 18                	jmp    80102b9d <begin_op+0x2d>
80102b85:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102b88:	83 ec 08             	sub    $0x8,%esp
80102b8b:	68 e0 26 11 80       	push   $0x801126e0
80102b90:	68 e0 26 11 80       	push   $0x801126e0
80102b95:	e8 86 12 00 00       	call   80103e20 <sleep>
80102b9a:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102b9d:	a1 20 27 11 80       	mov    0x80112720,%eax
80102ba2:	85 c0                	test   %eax,%eax
80102ba4:	75 e2                	jne    80102b88 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102ba6:	a1 1c 27 11 80       	mov    0x8011271c,%eax
80102bab:	8b 15 28 27 11 80    	mov    0x80112728,%edx
80102bb1:	83 c0 01             	add    $0x1,%eax
80102bb4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102bb7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102bba:	83 fa 1e             	cmp    $0x1e,%edx
80102bbd:	7f c9                	jg     80102b88 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102bbf:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102bc2:	a3 1c 27 11 80       	mov    %eax,0x8011271c
      release(&log.lock);
80102bc7:	68 e0 26 11 80       	push   $0x801126e0
80102bcc:	e8 cf 1a 00 00       	call   801046a0 <release>
      break;
    }
  }
}
80102bd1:	83 c4 10             	add    $0x10,%esp
80102bd4:	c9                   	leave  
80102bd5:	c3                   	ret    
80102bd6:	8d 76 00             	lea    0x0(%esi),%esi
80102bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102be0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102be0:	55                   	push   %ebp
80102be1:	89 e5                	mov    %esp,%ebp
80102be3:	57                   	push   %edi
80102be4:	56                   	push   %esi
80102be5:	53                   	push   %ebx
80102be6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102be9:	68 e0 26 11 80       	push   $0x801126e0
80102bee:	e8 fd 19 00 00       	call   801045f0 <acquire>
  log.outstanding -= 1;
80102bf3:	a1 1c 27 11 80       	mov    0x8011271c,%eax
  if(log.committing)
80102bf8:	8b 35 20 27 11 80    	mov    0x80112720,%esi
80102bfe:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102c01:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102c04:	85 f6                	test   %esi,%esi
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102c06:	89 1d 1c 27 11 80    	mov    %ebx,0x8011271c
  if(log.committing)
80102c0c:	0f 85 22 01 00 00    	jne    80102d34 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102c12:	85 db                	test   %ebx,%ebx
80102c14:	0f 85 f6 00 00 00    	jne    80102d10 <end_op+0x130>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102c1a:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102c1d:	c7 05 20 27 11 80 01 	movl   $0x1,0x80112720
80102c24:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102c27:	68 e0 26 11 80       	push   $0x801126e0
80102c2c:	e8 6f 1a 00 00       	call   801046a0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c31:	8b 0d 28 27 11 80    	mov    0x80112728,%ecx
80102c37:	83 c4 10             	add    $0x10,%esp
80102c3a:	85 c9                	test   %ecx,%ecx
80102c3c:	0f 8e 8b 00 00 00    	jle    80102ccd <end_op+0xed>
80102c42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c48:	a1 14 27 11 80       	mov    0x80112714,%eax
80102c4d:	83 ec 08             	sub    $0x8,%esp
80102c50:	01 d8                	add    %ebx,%eax
80102c52:	83 c0 01             	add    $0x1,%eax
80102c55:	50                   	push   %eax
80102c56:	ff 35 24 27 11 80    	pushl  0x80112724
80102c5c:	e8 6f d4 ff ff       	call   801000d0 <bread>
80102c61:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c63:	58                   	pop    %eax
80102c64:	5a                   	pop    %edx
80102c65:	ff 34 9d 2c 27 11 80 	pushl  -0x7feed8d4(,%ebx,4)
80102c6c:	ff 35 24 27 11 80    	pushl  0x80112724
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c72:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c75:	e8 56 d4 ff ff       	call   801000d0 <bread>
80102c7a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102c7c:	8d 40 5c             	lea    0x5c(%eax),%eax
80102c7f:	83 c4 0c             	add    $0xc,%esp
80102c82:	68 00 02 00 00       	push   $0x200
80102c87:	50                   	push   %eax
80102c88:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c8b:	50                   	push   %eax
80102c8c:	e8 0f 1b 00 00       	call   801047a0 <memmove>
    bwrite(to);  // write the log
80102c91:	89 34 24             	mov    %esi,(%esp)
80102c94:	e8 07 d5 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102c99:	89 3c 24             	mov    %edi,(%esp)
80102c9c:	e8 3f d5 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102ca1:	89 34 24             	mov    %esi,(%esp)
80102ca4:	e8 37 d5 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ca9:	83 c4 10             	add    $0x10,%esp
80102cac:	3b 1d 28 27 11 80    	cmp    0x80112728,%ebx
80102cb2:	7c 94                	jl     80102c48 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102cb4:	e8 b7 fd ff ff       	call   80102a70 <write_head>
    install_trans(); // Now install writes to home locations
80102cb9:	e8 12 fd ff ff       	call   801029d0 <install_trans>
    log.lh.n = 0;
80102cbe:	c7 05 28 27 11 80 00 	movl   $0x0,0x80112728
80102cc5:	00 00 00 
    write_head();    // Erase the transaction from the log
80102cc8:	e8 a3 fd ff ff       	call   80102a70 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102ccd:	83 ec 0c             	sub    $0xc,%esp
80102cd0:	68 e0 26 11 80       	push   $0x801126e0
80102cd5:	e8 16 19 00 00       	call   801045f0 <acquire>
    log.committing = 0;
    wakeup(&log);
80102cda:	c7 04 24 e0 26 11 80 	movl   $0x801126e0,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102ce1:	c7 05 20 27 11 80 00 	movl   $0x0,0x80112720
80102ce8:	00 00 00 
    wakeup(&log);
80102ceb:	e8 f0 12 00 00       	call   80103fe0 <wakeup>
    release(&log.lock);
80102cf0:	c7 04 24 e0 26 11 80 	movl   $0x801126e0,(%esp)
80102cf7:	e8 a4 19 00 00       	call   801046a0 <release>
80102cfc:	83 c4 10             	add    $0x10,%esp
  }
}
80102cff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d02:	5b                   	pop    %ebx
80102d03:	5e                   	pop    %esi
80102d04:	5f                   	pop    %edi
80102d05:	5d                   	pop    %ebp
80102d06:	c3                   	ret    
80102d07:	89 f6                	mov    %esi,%esi
80102d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
80102d10:	83 ec 0c             	sub    $0xc,%esp
80102d13:	68 e0 26 11 80       	push   $0x801126e0
80102d18:	e8 c3 12 00 00       	call   80103fe0 <wakeup>
  }
  release(&log.lock);
80102d1d:	c7 04 24 e0 26 11 80 	movl   $0x801126e0,(%esp)
80102d24:	e8 77 19 00 00       	call   801046a0 <release>
80102d29:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80102d2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d2f:	5b                   	pop    %ebx
80102d30:	5e                   	pop    %esi
80102d31:	5f                   	pop    %edi
80102d32:	5d                   	pop    %ebp
80102d33:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102d34:	83 ec 0c             	sub    $0xc,%esp
80102d37:	68 44 76 10 80       	push   $0x80107644
80102d3c:	e8 2f d6 ff ff       	call   80100370 <panic>
80102d41:	eb 0d                	jmp    80102d50 <log_write>
80102d43:	90                   	nop
80102d44:	90                   	nop
80102d45:	90                   	nop
80102d46:	90                   	nop
80102d47:	90                   	nop
80102d48:	90                   	nop
80102d49:	90                   	nop
80102d4a:	90                   	nop
80102d4b:	90                   	nop
80102d4c:	90                   	nop
80102d4d:	90                   	nop
80102d4e:	90                   	nop
80102d4f:	90                   	nop

80102d50 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d50:	55                   	push   %ebp
80102d51:	89 e5                	mov    %esp,%ebp
80102d53:	53                   	push   %ebx
80102d54:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d57:	8b 15 28 27 11 80    	mov    0x80112728,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d5d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d60:	83 fa 1d             	cmp    $0x1d,%edx
80102d63:	0f 8f 97 00 00 00    	jg     80102e00 <log_write+0xb0>
80102d69:	a1 18 27 11 80       	mov    0x80112718,%eax
80102d6e:	83 e8 01             	sub    $0x1,%eax
80102d71:	39 c2                	cmp    %eax,%edx
80102d73:	0f 8d 87 00 00 00    	jge    80102e00 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102d79:	a1 1c 27 11 80       	mov    0x8011271c,%eax
80102d7e:	85 c0                	test   %eax,%eax
80102d80:	0f 8e 87 00 00 00    	jle    80102e0d <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102d86:	83 ec 0c             	sub    $0xc,%esp
80102d89:	68 e0 26 11 80       	push   $0x801126e0
80102d8e:	e8 5d 18 00 00       	call   801045f0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102d93:	8b 0d 28 27 11 80    	mov    0x80112728,%ecx
80102d99:	83 c4 10             	add    $0x10,%esp
80102d9c:	83 f9 00             	cmp    $0x0,%ecx
80102d9f:	7e 50                	jle    80102df1 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102da1:	8b 53 08             	mov    0x8(%ebx),%edx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102da4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102da6:	3b 15 2c 27 11 80    	cmp    0x8011272c,%edx
80102dac:	75 0b                	jne    80102db9 <log_write+0x69>
80102dae:	eb 38                	jmp    80102de8 <log_write+0x98>
80102db0:	39 14 85 2c 27 11 80 	cmp    %edx,-0x7feed8d4(,%eax,4)
80102db7:	74 2f                	je     80102de8 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102db9:	83 c0 01             	add    $0x1,%eax
80102dbc:	39 c8                	cmp    %ecx,%eax
80102dbe:	75 f0                	jne    80102db0 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102dc0:	89 14 85 2c 27 11 80 	mov    %edx,-0x7feed8d4(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102dc7:	83 c0 01             	add    $0x1,%eax
80102dca:	a3 28 27 11 80       	mov    %eax,0x80112728
  b->flags |= B_DIRTY; // prevent eviction
80102dcf:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102dd2:	c7 45 08 e0 26 11 80 	movl   $0x801126e0,0x8(%ebp)
}
80102dd9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ddc:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102ddd:	e9 be 18 00 00       	jmp    801046a0 <release>
80102de2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102de8:	89 14 85 2c 27 11 80 	mov    %edx,-0x7feed8d4(,%eax,4)
80102def:	eb de                	jmp    80102dcf <log_write+0x7f>
80102df1:	8b 43 08             	mov    0x8(%ebx),%eax
80102df4:	a3 2c 27 11 80       	mov    %eax,0x8011272c
  if (i == log.lh.n)
80102df9:	75 d4                	jne    80102dcf <log_write+0x7f>
80102dfb:	31 c0                	xor    %eax,%eax
80102dfd:	eb c8                	jmp    80102dc7 <log_write+0x77>
80102dff:	90                   	nop
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102e00:	83 ec 0c             	sub    $0xc,%esp
80102e03:	68 53 76 10 80       	push   $0x80107653
80102e08:	e8 63 d5 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102e0d:	83 ec 0c             	sub    $0xc,%esp
80102e10:	68 69 76 10 80       	push   $0x80107669
80102e15:	e8 56 d5 ff ff       	call   80100370 <panic>
80102e1a:	66 90                	xchg   %ax,%ax
80102e1c:	66 90                	xchg   %ax,%ax
80102e1e:	66 90                	xchg   %ax,%ax

80102e20 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e20:	55                   	push   %ebp
80102e21:	89 e5                	mov    %esp,%ebp
80102e23:	53                   	push   %ebx
80102e24:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102e27:	e8 74 09 00 00       	call   801037a0 <cpuid>
80102e2c:	89 c3                	mov    %eax,%ebx
80102e2e:	e8 6d 09 00 00       	call   801037a0 <cpuid>
80102e33:	83 ec 04             	sub    $0x4,%esp
80102e36:	53                   	push   %ebx
80102e37:	50                   	push   %eax
80102e38:	68 84 76 10 80       	push   $0x80107684
80102e3d:	e8 1e d8 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e42:	e8 99 2b 00 00       	call   801059e0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e47:	e8 d4 08 00 00       	call   80103720 <mycpu>
80102e4c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e4e:	b8 01 00 00 00       	mov    $0x1,%eax
80102e53:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102e5a:	e8 91 0c 00 00       	call   80103af0 <scheduler>
80102e5f:	90                   	nop

80102e60 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102e60:	55                   	push   %ebp
80102e61:	89 e5                	mov    %esp,%ebp
80102e63:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102e66:	e8 85 3c 00 00       	call   80106af0 <switchkvm>
  seginit();
80102e6b:	e8 80 3b 00 00       	call   801069f0 <seginit>
  lapicinit();
80102e70:	e8 8b f7 ff ff       	call   80102600 <lapicinit>
  mpmain();
80102e75:	e8 a6 ff ff ff       	call   80102e20 <mpmain>
80102e7a:	66 90                	xchg   %ax,%ax
80102e7c:	66 90                	xchg   %ax,%ax
80102e7e:	66 90                	xchg   %ax,%ax

80102e80 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102e80:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102e84:	83 e4 f0             	and    $0xfffffff0,%esp
80102e87:	ff 71 fc             	pushl  -0x4(%ecx)
80102e8a:	55                   	push   %ebp
80102e8b:	89 e5                	mov    %esp,%ebp
80102e8d:	53                   	push   %ebx
80102e8e:	51                   	push   %ecx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102e8f:	bb e0 27 11 80       	mov    $0x801127e0,%ebx
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102e94:	83 ec 08             	sub    $0x8,%esp
80102e97:	68 00 00 40 80       	push   $0x80400000
80102e9c:	68 08 5a 11 80       	push   $0x80115a08
80102ea1:	e8 1a f5 ff ff       	call   801023c0 <kinit1>
  kvmalloc();      // kernel page table
80102ea6:	e8 d5 40 00 00       	call   80106f80 <kvmalloc>
  mpinit();        // detect other processors
80102eab:	e8 60 01 00 00       	call   80103010 <mpinit>
  lapicinit();     // interrupt controller
80102eb0:	e8 4b f7 ff ff       	call   80102600 <lapicinit>
  seginit();       // segment descriptors
80102eb5:	e8 36 3b 00 00       	call   801069f0 <seginit>
  picinit();       // disable pic
80102eba:	e8 21 03 00 00       	call   801031e0 <picinit>
  ioapicinit();    // another interrupt controller
80102ebf:	e8 2c f3 ff ff       	call   801021f0 <ioapicinit>
  consoleinit();   // console hardware
80102ec4:	e8 c7 da ff ff       	call   80100990 <consoleinit>
  uartinit();      // serial port
80102ec9:	e8 f2 2d 00 00       	call   80105cc0 <uartinit>
  pinit();         // process table
80102ece:	e8 2d 08 00 00       	call   80103700 <pinit>
  tvinit();        // trap vectors
80102ed3:	e8 88 2a 00 00       	call   80105960 <tvinit>
  binit();         // buffer cache
80102ed8:	e8 63 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102edd:	e8 5e de ff ff       	call   80100d40 <fileinit>
  ideinit();       // disk 
80102ee2:	e8 e9 f0 ff ff       	call   80101fd0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102ee7:	83 c4 0c             	add    $0xc,%esp
80102eea:	68 8a 00 00 00       	push   $0x8a
80102eef:	68 ec a4 10 80       	push   $0x8010a4ec
80102ef4:	68 00 70 00 80       	push   $0x80007000
80102ef9:	e8 a2 18 00 00       	call   801047a0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102efe:	69 05 60 2d 11 80 b0 	imul   $0xb0,0x80112d60,%eax
80102f05:	00 00 00 
80102f08:	83 c4 10             	add    $0x10,%esp
80102f0b:	05 e0 27 11 80       	add    $0x801127e0,%eax
80102f10:	39 d8                	cmp    %ebx,%eax
80102f12:	76 6f                	jbe    80102f83 <main+0x103>
80102f14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80102f18:	e8 03 08 00 00       	call   80103720 <mycpu>
80102f1d:	39 d8                	cmp    %ebx,%eax
80102f1f:	74 49                	je     80102f6a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f21:	e8 6a f5 ff ff       	call   80102490 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f26:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80102f2b:	c7 05 f8 6f 00 80 60 	movl   $0x80102e60,0x80006ff8
80102f32:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f35:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102f3c:	90 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f3f:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80102f44:	0f b6 03             	movzbl (%ebx),%eax
80102f47:	83 ec 08             	sub    $0x8,%esp
80102f4a:	68 00 70 00 00       	push   $0x7000
80102f4f:	50                   	push   %eax
80102f50:	e8 fb f7 ff ff       	call   80102750 <lapicstartap>
80102f55:	83 c4 10             	add    $0x10,%esp
80102f58:	90                   	nop
80102f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102f60:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102f66:	85 c0                	test   %eax,%eax
80102f68:	74 f6                	je     80102f60 <main+0xe0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102f6a:	69 05 60 2d 11 80 b0 	imul   $0xb0,0x80112d60,%eax
80102f71:	00 00 00 
80102f74:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102f7a:	05 e0 27 11 80       	add    $0x801127e0,%eax
80102f7f:	39 c3                	cmp    %eax,%ebx
80102f81:	72 95                	jb     80102f18 <main+0x98>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102f83:	83 ec 08             	sub    $0x8,%esp
80102f86:	68 00 00 00 8e       	push   $0x8e000000
80102f8b:	68 00 00 40 80       	push   $0x80400000
80102f90:	e8 9b f4 ff ff       	call   80102430 <kinit2>
  userinit();      // first user process
80102f95:	e8 b6 08 00 00       	call   80103850 <userinit>
  mpmain();        // finish this processor's setup
80102f9a:	e8 81 fe ff ff       	call   80102e20 <mpmain>
80102f9f:	90                   	nop

80102fa0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fa0:	55                   	push   %ebp
80102fa1:	89 e5                	mov    %esp,%ebp
80102fa3:	57                   	push   %edi
80102fa4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102fa5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fab:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
80102fac:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102faf:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80102fb2:	39 de                	cmp    %ebx,%esi
80102fb4:	73 40                	jae    80102ff6 <mpsearch1+0x56>
80102fb6:	8d 76 00             	lea    0x0(%esi),%esi
80102fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102fc0:	83 ec 04             	sub    $0x4,%esp
80102fc3:	8d 7e 10             	lea    0x10(%esi),%edi
80102fc6:	6a 04                	push   $0x4
80102fc8:	68 98 76 10 80       	push   $0x80107698
80102fcd:	56                   	push   %esi
80102fce:	e8 6d 17 00 00       	call   80104740 <memcmp>
80102fd3:	83 c4 10             	add    $0x10,%esp
80102fd6:	85 c0                	test   %eax,%eax
80102fd8:	75 16                	jne    80102ff0 <mpsearch1+0x50>
80102fda:	8d 7e 10             	lea    0x10(%esi),%edi
80102fdd:	89 f2                	mov    %esi,%edx
80102fdf:	90                   	nop
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80102fe0:	0f b6 0a             	movzbl (%edx),%ecx
80102fe3:	83 c2 01             	add    $0x1,%edx
80102fe6:	01 c8                	add    %ecx,%eax
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80102fe8:	39 fa                	cmp    %edi,%edx
80102fea:	75 f4                	jne    80102fe0 <mpsearch1+0x40>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102fec:	84 c0                	test   %al,%al
80102fee:	74 10                	je     80103000 <mpsearch1+0x60>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80102ff0:	39 fb                	cmp    %edi,%ebx
80102ff2:	89 fe                	mov    %edi,%esi
80102ff4:	77 ca                	ja     80102fc0 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
80102ff6:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80102ff9:	31 c0                	xor    %eax,%eax
}
80102ffb:	5b                   	pop    %ebx
80102ffc:	5e                   	pop    %esi
80102ffd:	5f                   	pop    %edi
80102ffe:	5d                   	pop    %ebp
80102fff:	c3                   	ret    
80103000:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103003:	89 f0                	mov    %esi,%eax
80103005:	5b                   	pop    %ebx
80103006:	5e                   	pop    %esi
80103007:	5f                   	pop    %edi
80103008:	5d                   	pop    %ebp
80103009:	c3                   	ret    
8010300a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103010 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103010:	55                   	push   %ebp
80103011:	89 e5                	mov    %esp,%ebp
80103013:	57                   	push   %edi
80103014:	56                   	push   %esi
80103015:	53                   	push   %ebx
80103016:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103019:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103020:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103027:	c1 e0 08             	shl    $0x8,%eax
8010302a:	09 d0                	or     %edx,%eax
8010302c:	c1 e0 04             	shl    $0x4,%eax
8010302f:	85 c0                	test   %eax,%eax
80103031:	75 1b                	jne    8010304e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103033:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010303a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103041:	c1 e0 08             	shl    $0x8,%eax
80103044:	09 d0                	or     %edx,%eax
80103046:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103049:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010304e:	ba 00 04 00 00       	mov    $0x400,%edx
80103053:	e8 48 ff ff ff       	call   80102fa0 <mpsearch1>
80103058:	85 c0                	test   %eax,%eax
8010305a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010305d:	0f 84 37 01 00 00    	je     8010319a <mpinit+0x18a>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103063:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103066:	8b 58 04             	mov    0x4(%eax),%ebx
80103069:	85 db                	test   %ebx,%ebx
8010306b:	0f 84 43 01 00 00    	je     801031b4 <mpinit+0x1a4>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103071:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103077:	83 ec 04             	sub    $0x4,%esp
8010307a:	6a 04                	push   $0x4
8010307c:	68 b5 76 10 80       	push   $0x801076b5
80103081:	56                   	push   %esi
80103082:	e8 b9 16 00 00       	call   80104740 <memcmp>
80103087:	83 c4 10             	add    $0x10,%esp
8010308a:	85 c0                	test   %eax,%eax
8010308c:	0f 85 22 01 00 00    	jne    801031b4 <mpinit+0x1a4>
    return 0;
  if(conf->version != 1 && conf->version != 4)
80103092:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103099:	3c 01                	cmp    $0x1,%al
8010309b:	74 08                	je     801030a5 <mpinit+0x95>
8010309d:	3c 04                	cmp    $0x4,%al
8010309f:	0f 85 0f 01 00 00    	jne    801031b4 <mpinit+0x1a4>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801030a5:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030ac:	85 ff                	test   %edi,%edi
801030ae:	74 21                	je     801030d1 <mpinit+0xc1>
801030b0:	31 d2                	xor    %edx,%edx
801030b2:	31 c0                	xor    %eax,%eax
801030b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801030b8:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
801030bf:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030c0:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801030c3:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030c5:	39 c7                	cmp    %eax,%edi
801030c7:	75 ef                	jne    801030b8 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801030c9:	84 d2                	test   %dl,%dl
801030cb:	0f 85 e3 00 00 00    	jne    801031b4 <mpinit+0x1a4>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801030d1:	85 f6                	test   %esi,%esi
801030d3:	0f 84 db 00 00 00    	je     801031b4 <mpinit+0x1a4>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801030d9:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801030df:	a3 dc 26 11 80       	mov    %eax,0x801126dc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801030e4:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801030eb:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
801030f1:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801030f6:	01 d6                	add    %edx,%esi
801030f8:	90                   	nop
801030f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103100:	39 c6                	cmp    %eax,%esi
80103102:	76 23                	jbe    80103127 <mpinit+0x117>
80103104:	0f b6 10             	movzbl (%eax),%edx
    switch(*p){
80103107:	80 fa 04             	cmp    $0x4,%dl
8010310a:	0f 87 c0 00 00 00    	ja     801031d0 <mpinit+0x1c0>
80103110:	ff 24 95 dc 76 10 80 	jmp    *-0x7fef8924(,%edx,4)
80103117:	89 f6                	mov    %esi,%esi
80103119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103120:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103123:	39 c6                	cmp    %eax,%esi
80103125:	77 dd                	ja     80103104 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103127:	85 db                	test   %ebx,%ebx
80103129:	0f 84 92 00 00 00    	je     801031c1 <mpinit+0x1b1>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010312f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103132:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103136:	74 15                	je     8010314d <mpinit+0x13d>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103138:	ba 22 00 00 00       	mov    $0x22,%edx
8010313d:	b8 70 00 00 00       	mov    $0x70,%eax
80103142:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103143:	ba 23 00 00 00       	mov    $0x23,%edx
80103148:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103149:	83 c8 01             	or     $0x1,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010314c:	ee                   	out    %al,(%dx)
  }
}
8010314d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103150:	5b                   	pop    %ebx
80103151:	5e                   	pop    %esi
80103152:	5f                   	pop    %edi
80103153:	5d                   	pop    %ebp
80103154:	c3                   	ret    
80103155:	8d 76 00             	lea    0x0(%esi),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103158:	8b 0d 60 2d 11 80    	mov    0x80112d60,%ecx
8010315e:	83 f9 07             	cmp    $0x7,%ecx
80103161:	7f 19                	jg     8010317c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103163:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103167:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010316d:	83 c1 01             	add    $0x1,%ecx
80103170:	89 0d 60 2d 11 80    	mov    %ecx,0x80112d60
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103176:	88 97 e0 27 11 80    	mov    %dl,-0x7feed820(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
8010317c:	83 c0 14             	add    $0x14,%eax
      continue;
8010317f:	e9 7c ff ff ff       	jmp    80103100 <mpinit+0xf0>
80103184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103188:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010318c:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
8010318f:	88 15 c0 27 11 80    	mov    %dl,0x801127c0
      p += sizeof(struct mpioapic);
      continue;
80103195:	e9 66 ff ff ff       	jmp    80103100 <mpinit+0xf0>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
8010319a:	ba 00 00 01 00       	mov    $0x10000,%edx
8010319f:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801031a4:	e8 f7 fd ff ff       	call   80102fa0 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031a9:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801031ab:	89 45 e4             	mov    %eax,-0x1c(%ebp)
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031ae:	0f 85 af fe ff ff    	jne    80103063 <mpinit+0x53>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
801031b4:	83 ec 0c             	sub    $0xc,%esp
801031b7:	68 9d 76 10 80       	push   $0x8010769d
801031bc:	e8 af d1 ff ff       	call   80100370 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
801031c1:	83 ec 0c             	sub    $0xc,%esp
801031c4:	68 bc 76 10 80       	push   $0x801076bc
801031c9:	e8 a2 d1 ff ff       	call   80100370 <panic>
801031ce:	66 90                	xchg   %ax,%ax
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
801031d0:	31 db                	xor    %ebx,%ebx
801031d2:	e9 30 ff ff ff       	jmp    80103107 <mpinit+0xf7>
801031d7:	66 90                	xchg   %ax,%ax
801031d9:	66 90                	xchg   %ax,%ax
801031db:	66 90                	xchg   %ax,%ax
801031dd:	66 90                	xchg   %ax,%ax
801031df:	90                   	nop

801031e0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801031e0:	55                   	push   %ebp
801031e1:	ba 21 00 00 00       	mov    $0x21,%edx
801031e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801031eb:	89 e5                	mov    %esp,%ebp
801031ed:	ee                   	out    %al,(%dx)
801031ee:	ba a1 00 00 00       	mov    $0xa1,%edx
801031f3:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801031f4:	5d                   	pop    %ebp
801031f5:	c3                   	ret    
801031f6:	66 90                	xchg   %ax,%ax
801031f8:	66 90                	xchg   %ax,%ax
801031fa:	66 90                	xchg   %ax,%ax
801031fc:	66 90                	xchg   %ax,%ax
801031fe:	66 90                	xchg   %ax,%ax

80103200 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103200:	55                   	push   %ebp
80103201:	89 e5                	mov    %esp,%ebp
80103203:	57                   	push   %edi
80103204:	56                   	push   %esi
80103205:	53                   	push   %ebx
80103206:	83 ec 0c             	sub    $0xc,%esp
80103209:	8b 75 08             	mov    0x8(%ebp),%esi
8010320c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010320f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103215:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010321b:	e8 40 db ff ff       	call   80100d60 <filealloc>
80103220:	85 c0                	test   %eax,%eax
80103222:	89 06                	mov    %eax,(%esi)
80103224:	0f 84 a8 00 00 00    	je     801032d2 <pipealloc+0xd2>
8010322a:	e8 31 db ff ff       	call   80100d60 <filealloc>
8010322f:	85 c0                	test   %eax,%eax
80103231:	89 03                	mov    %eax,(%ebx)
80103233:	0f 84 87 00 00 00    	je     801032c0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103239:	e8 52 f2 ff ff       	call   80102490 <kalloc>
8010323e:	85 c0                	test   %eax,%eax
80103240:	89 c7                	mov    %eax,%edi
80103242:	0f 84 b0 00 00 00    	je     801032f8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103248:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
8010324b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103252:	00 00 00 
  p->writeopen = 1;
80103255:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010325c:	00 00 00 
  p->nwrite = 0;
8010325f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103266:	00 00 00 
  p->nread = 0;
80103269:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103270:	00 00 00 
  initlock(&p->lock, "pipe");
80103273:	68 f0 76 10 80       	push   $0x801076f0
80103278:	50                   	push   %eax
80103279:	e8 12 12 00 00       	call   80104490 <initlock>
  (*f0)->type = FD_PIPE;
8010327e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103280:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
80103283:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103289:	8b 06                	mov    (%esi),%eax
8010328b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010328f:	8b 06                	mov    (%esi),%eax
80103291:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103295:	8b 06                	mov    (%esi),%eax
80103297:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010329a:	8b 03                	mov    (%ebx),%eax
8010329c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801032a2:	8b 03                	mov    (%ebx),%eax
801032a4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801032a8:	8b 03                	mov    (%ebx),%eax
801032aa:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801032ae:	8b 03                	mov    (%ebx),%eax
801032b0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801032b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801032b6:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801032b8:	5b                   	pop    %ebx
801032b9:	5e                   	pop    %esi
801032ba:	5f                   	pop    %edi
801032bb:	5d                   	pop    %ebp
801032bc:	c3                   	ret    
801032bd:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801032c0:	8b 06                	mov    (%esi),%eax
801032c2:	85 c0                	test   %eax,%eax
801032c4:	74 1e                	je     801032e4 <pipealloc+0xe4>
    fileclose(*f0);
801032c6:	83 ec 0c             	sub    $0xc,%esp
801032c9:	50                   	push   %eax
801032ca:	e8 51 db ff ff       	call   80100e20 <fileclose>
801032cf:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801032d2:	8b 03                	mov    (%ebx),%eax
801032d4:	85 c0                	test   %eax,%eax
801032d6:	74 0c                	je     801032e4 <pipealloc+0xe4>
    fileclose(*f1);
801032d8:	83 ec 0c             	sub    $0xc,%esp
801032db:	50                   	push   %eax
801032dc:	e8 3f db ff ff       	call   80100e20 <fileclose>
801032e1:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801032e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
801032e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801032ec:	5b                   	pop    %ebx
801032ed:	5e                   	pop    %esi
801032ee:	5f                   	pop    %edi
801032ef:	5d                   	pop    %ebp
801032f0:	c3                   	ret    
801032f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801032f8:	8b 06                	mov    (%esi),%eax
801032fa:	85 c0                	test   %eax,%eax
801032fc:	75 c8                	jne    801032c6 <pipealloc+0xc6>
801032fe:	eb d2                	jmp    801032d2 <pipealloc+0xd2>

80103300 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
80103300:	55                   	push   %ebp
80103301:	89 e5                	mov    %esp,%ebp
80103303:	56                   	push   %esi
80103304:	53                   	push   %ebx
80103305:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103308:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010330b:	83 ec 0c             	sub    $0xc,%esp
8010330e:	53                   	push   %ebx
8010330f:	e8 dc 12 00 00       	call   801045f0 <acquire>
  if(writable){
80103314:	83 c4 10             	add    $0x10,%esp
80103317:	85 f6                	test   %esi,%esi
80103319:	74 45                	je     80103360 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010331b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103321:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
80103324:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010332b:	00 00 00 
    wakeup(&p->nread);
8010332e:	50                   	push   %eax
8010332f:	e8 ac 0c 00 00       	call   80103fe0 <wakeup>
80103334:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103337:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010333d:	85 d2                	test   %edx,%edx
8010333f:	75 0a                	jne    8010334b <pipeclose+0x4b>
80103341:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103347:	85 c0                	test   %eax,%eax
80103349:	74 35                	je     80103380 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010334b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010334e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103351:	5b                   	pop    %ebx
80103352:	5e                   	pop    %esi
80103353:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103354:	e9 47 13 00 00       	jmp    801046a0 <release>
80103359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80103360:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103366:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80103369:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103370:	00 00 00 
    wakeup(&p->nwrite);
80103373:	50                   	push   %eax
80103374:	e8 67 0c 00 00       	call   80103fe0 <wakeup>
80103379:	83 c4 10             	add    $0x10,%esp
8010337c:	eb b9                	jmp    80103337 <pipeclose+0x37>
8010337e:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103380:	83 ec 0c             	sub    $0xc,%esp
80103383:	53                   	push   %ebx
80103384:	e8 17 13 00 00       	call   801046a0 <release>
    kfree((char*)p);
80103389:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010338c:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
8010338f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103392:	5b                   	pop    %ebx
80103393:	5e                   	pop    %esi
80103394:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
80103395:	e9 46 ef ff ff       	jmp    801022e0 <kfree>
8010339a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801033a0 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801033a0:	55                   	push   %ebp
801033a1:	89 e5                	mov    %esp,%ebp
801033a3:	57                   	push   %edi
801033a4:	56                   	push   %esi
801033a5:	53                   	push   %ebx
801033a6:	83 ec 28             	sub    $0x28,%esp
801033a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801033ac:	53                   	push   %ebx
801033ad:	e8 3e 12 00 00       	call   801045f0 <acquire>
  for(i = 0; i < n; i++){
801033b2:	8b 45 10             	mov    0x10(%ebp),%eax
801033b5:	83 c4 10             	add    $0x10,%esp
801033b8:	85 c0                	test   %eax,%eax
801033ba:	0f 8e ca 00 00 00    	jle    8010348a <pipewrite+0xea>
801033c0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801033c3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801033c9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801033cf:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801033d2:	03 4d 10             	add    0x10(%ebp),%ecx
801033d5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801033d8:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
801033de:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
801033e4:	39 d0                	cmp    %edx,%eax
801033e6:	75 71                	jne    80103459 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
801033e8:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801033ee:	85 c0                	test   %eax,%eax
801033f0:	74 4e                	je     80103440 <pipewrite+0xa0>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801033f2:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801033f8:	eb 3a                	jmp    80103434 <pipewrite+0x94>
801033fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103400:	83 ec 0c             	sub    $0xc,%esp
80103403:	57                   	push   %edi
80103404:	e8 d7 0b 00 00       	call   80103fe0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103409:	5a                   	pop    %edx
8010340a:	59                   	pop    %ecx
8010340b:	53                   	push   %ebx
8010340c:	56                   	push   %esi
8010340d:	e8 0e 0a 00 00       	call   80103e20 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103412:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103418:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010341e:	83 c4 10             	add    $0x10,%esp
80103421:	05 00 02 00 00       	add    $0x200,%eax
80103426:	39 c2                	cmp    %eax,%edx
80103428:	75 36                	jne    80103460 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010342a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103430:	85 c0                	test   %eax,%eax
80103432:	74 0c                	je     80103440 <pipewrite+0xa0>
80103434:	e8 87 03 00 00       	call   801037c0 <myproc>
80103439:	8b 40 24             	mov    0x24(%eax),%eax
8010343c:	85 c0                	test   %eax,%eax
8010343e:	74 c0                	je     80103400 <pipewrite+0x60>
        release(&p->lock);
80103440:	83 ec 0c             	sub    $0xc,%esp
80103443:	53                   	push   %ebx
80103444:	e8 57 12 00 00       	call   801046a0 <release>
        return -1;
80103449:	83 c4 10             	add    $0x10,%esp
8010344c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103451:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103454:	5b                   	pop    %ebx
80103455:	5e                   	pop    %esi
80103456:	5f                   	pop    %edi
80103457:	5d                   	pop    %ebp
80103458:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103459:	89 c2                	mov    %eax,%edx
8010345b:	90                   	nop
8010345c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103460:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103463:	8d 42 01             	lea    0x1(%edx),%eax
80103466:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010346c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103472:	0f b6 0e             	movzbl (%esi),%ecx
80103475:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
80103479:	89 f1                	mov    %esi,%ecx
8010347b:	83 c1 01             	add    $0x1,%ecx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
8010347e:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
80103481:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103484:	0f 85 4e ff ff ff    	jne    801033d8 <pipewrite+0x38>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010348a:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103490:	83 ec 0c             	sub    $0xc,%esp
80103493:	50                   	push   %eax
80103494:	e8 47 0b 00 00       	call   80103fe0 <wakeup>
  release(&p->lock);
80103499:	89 1c 24             	mov    %ebx,(%esp)
8010349c:	e8 ff 11 00 00       	call   801046a0 <release>
  return n;
801034a1:	83 c4 10             	add    $0x10,%esp
801034a4:	8b 45 10             	mov    0x10(%ebp),%eax
801034a7:	eb a8                	jmp    80103451 <pipewrite+0xb1>
801034a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801034b0 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
801034b0:	55                   	push   %ebp
801034b1:	89 e5                	mov    %esp,%ebp
801034b3:	57                   	push   %edi
801034b4:	56                   	push   %esi
801034b5:	53                   	push   %ebx
801034b6:	83 ec 18             	sub    $0x18,%esp
801034b9:	8b 75 08             	mov    0x8(%ebp),%esi
801034bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801034bf:	56                   	push   %esi
801034c0:	e8 2b 11 00 00       	call   801045f0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801034c5:	83 c4 10             	add    $0x10,%esp
801034c8:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801034ce:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801034d4:	75 6a                	jne    80103540 <piperead+0x90>
801034d6:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
801034dc:	85 db                	test   %ebx,%ebx
801034de:	0f 84 c4 00 00 00    	je     801035a8 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801034e4:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801034ea:	eb 2d                	jmp    80103519 <piperead+0x69>
801034ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801034f0:	83 ec 08             	sub    $0x8,%esp
801034f3:	56                   	push   %esi
801034f4:	53                   	push   %ebx
801034f5:	e8 26 09 00 00       	call   80103e20 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801034fa:	83 c4 10             	add    $0x10,%esp
801034fd:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103503:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103509:	75 35                	jne    80103540 <piperead+0x90>
8010350b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103511:	85 d2                	test   %edx,%edx
80103513:	0f 84 8f 00 00 00    	je     801035a8 <piperead+0xf8>
    if(myproc()->killed){
80103519:	e8 a2 02 00 00       	call   801037c0 <myproc>
8010351e:	8b 48 24             	mov    0x24(%eax),%ecx
80103521:	85 c9                	test   %ecx,%ecx
80103523:	74 cb                	je     801034f0 <piperead+0x40>
      release(&p->lock);
80103525:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103528:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
8010352d:	56                   	push   %esi
8010352e:	e8 6d 11 00 00       	call   801046a0 <release>
      return -1;
80103533:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103536:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103539:	89 d8                	mov    %ebx,%eax
8010353b:	5b                   	pop    %ebx
8010353c:	5e                   	pop    %esi
8010353d:	5f                   	pop    %edi
8010353e:	5d                   	pop    %ebp
8010353f:	c3                   	ret    
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103540:	8b 45 10             	mov    0x10(%ebp),%eax
80103543:	85 c0                	test   %eax,%eax
80103545:	7e 61                	jle    801035a8 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103547:	31 db                	xor    %ebx,%ebx
80103549:	eb 13                	jmp    8010355e <piperead+0xae>
8010354b:	90                   	nop
8010354c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103550:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103556:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
8010355c:	74 1f                	je     8010357d <piperead+0xcd>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010355e:	8d 41 01             	lea    0x1(%ecx),%eax
80103561:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103567:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
8010356d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103572:	88 04 1f             	mov    %al,(%edi,%ebx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103575:	83 c3 01             	add    $0x1,%ebx
80103578:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010357b:	75 d3                	jne    80103550 <piperead+0xa0>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010357d:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103583:	83 ec 0c             	sub    $0xc,%esp
80103586:	50                   	push   %eax
80103587:	e8 54 0a 00 00       	call   80103fe0 <wakeup>
  release(&p->lock);
8010358c:	89 34 24             	mov    %esi,(%esp)
8010358f:	e8 0c 11 00 00       	call   801046a0 <release>
  return i;
80103594:	83 c4 10             	add    $0x10,%esp
}
80103597:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010359a:	89 d8                	mov    %ebx,%eax
8010359c:	5b                   	pop    %ebx
8010359d:	5e                   	pop    %esi
8010359e:	5f                   	pop    %edi
8010359f:	5d                   	pop    %ebp
801035a0:	c3                   	ret    
801035a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    if(p->nread == p->nwrite)
801035a8:	31 db                	xor    %ebx,%ebx
801035aa:	eb d1                	jmp    8010357d <piperead+0xcd>
801035ac:	66 90                	xchg   %ax,%ax
801035ae:	66 90                	xchg   %ax,%ax

801035b0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801035b0:	55                   	push   %ebp
801035b1:	89 e5                	mov    %esp,%ebp
801035b3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801035b4:	bb b4 2d 11 80       	mov    $0x80112db4,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801035b9:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801035bc:	68 80 2d 11 80       	push   $0x80112d80
801035c1:	e8 2a 10 00 00       	call   801045f0 <acquire>
801035c6:	83 c4 10             	add    $0x10,%esp
801035c9:	eb 17                	jmp    801035e2 <allocproc+0x32>
801035cb:	90                   	nop
801035cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801035d0:	81 c3 90 00 00 00    	add    $0x90,%ebx
801035d6:	81 fb b4 51 11 80    	cmp    $0x801151b4,%ebx
801035dc:	0f 83 9e 00 00 00    	jae    80103680 <allocproc+0xd0>
    if(p->state == UNUSED)
801035e2:	8b 43 0c             	mov    0xc(%ebx),%eax
801035e5:	85 c0                	test   %eax,%eax
801035e7:	75 e7                	jne    801035d0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801035e9:	a1 04 a0 10 80       	mov    0x8010a004,%eax
  p->priority = 60;         //Default Priortiy

  release(&ptable.lock);
801035ee:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801035f1:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
  p->priority = 60;         //Default Priortiy
801035f8:	c7 43 7c 3c 00 00 00 	movl   $0x3c,0x7c(%ebx)
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801035ff:	8d 50 01             	lea    0x1(%eax),%edx
80103602:	89 43 10             	mov    %eax,0x10(%ebx)
  p->priority = 60;         //Default Priortiy

  release(&ptable.lock);
80103605:	68 80 2d 11 80       	push   $0x80112d80
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
8010360a:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  p->priority = 60;         //Default Priortiy

  release(&ptable.lock);
80103610:	e8 8b 10 00 00       	call   801046a0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103615:	e8 76 ee ff ff       	call   80102490 <kalloc>
8010361a:	83 c4 10             	add    $0x10,%esp
8010361d:	85 c0                	test   %eax,%eax
8010361f:	89 43 08             	mov    %eax,0x8(%ebx)
80103622:	74 75                	je     80103699 <allocproc+0xe9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103624:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  p->cpu_ticks_in = 0;
  p->cpu_in_time = ticks;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010362a:	83 ec 04             	sub    $0x4,%esp
  //initialize running time counts
  p->cpu_ticks_total = 0;
  p->cpu_ticks_in = 0;
  p->cpu_in_time = ticks;

  sp -= sizeof *p->context;
8010362d:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103632:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;

  //initialize running time counts
  p->cpu_ticks_total = 0;
  p->cpu_ticks_in = 0;
  p->cpu_in_time = ticks;
80103635:	8b 15 00 5a 11 80    	mov    0x80115a00,%edx
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
8010363b:	c7 40 14 4f 59 10 80 	movl   $0x8010594f,0x14(%eax)

  //initialize running time counts
  p->cpu_ticks_total = 0;
80103642:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80103649:	00 00 00 
  p->cpu_ticks_in = 0;
8010364c:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80103653:	00 00 00 
  p->cpu_in_time = ticks;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
80103656:	89 43 1c             	mov    %eax,0x1c(%ebx)
  *(uint*)sp = (uint)trapret;

  //initialize running time counts
  p->cpu_ticks_total = 0;
  p->cpu_ticks_in = 0;
  p->cpu_in_time = ticks;
80103659:	89 93 8c 00 00 00    	mov    %edx,0x8c(%ebx)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010365f:	6a 14                	push   $0x14
80103661:	6a 00                	push   $0x0
80103663:	50                   	push   %eax
80103664:	e8 87 10 00 00       	call   801046f0 <memset>
  p->context->eip = (uint)forkret;
80103669:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010366c:	83 c4 10             	add    $0x10,%esp
  p->cpu_in_time = ticks;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
8010366f:	c7 40 10 b0 36 10 80 	movl   $0x801036b0,0x10(%eax)

  return p;
}
80103676:	89 d8                	mov    %ebx,%eax
80103678:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010367b:	c9                   	leave  
8010367c:	c3                   	ret    
8010367d:	8d 76 00             	lea    0x0(%esi),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103680:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103683:	31 db                	xor    %ebx,%ebx

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103685:	68 80 2d 11 80       	push   $0x80112d80
8010368a:	e8 11 10 00 00       	call   801046a0 <release>
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
8010368f:	89 d8                	mov    %ebx,%eax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;
80103691:	83 c4 10             	add    $0x10,%esp
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80103694:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103697:	c9                   	leave  
80103698:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80103699:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801036a0:	31 db                	xor    %ebx,%ebx
801036a2:	eb d2                	jmp    80103676 <allocproc+0xc6>
801036a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801036aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801036b0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801036b0:	55                   	push   %ebp
801036b1:	89 e5                	mov    %esp,%ebp
801036b3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801036b6:	68 80 2d 11 80       	push   $0x80112d80
801036bb:	e8 e0 0f 00 00       	call   801046a0 <release>

  if (first) {
801036c0:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801036c5:	83 c4 10             	add    $0x10,%esp
801036c8:	85 c0                	test   %eax,%eax
801036ca:	75 04                	jne    801036d0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801036cc:	c9                   	leave  
801036cd:	c3                   	ret    
801036ce:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
801036d0:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
801036d3:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
801036da:	00 00 00 
    iinit(ROOTDEV);
801036dd:	6a 01                	push   $0x1
801036df:	e8 8c dd ff ff       	call   80101470 <iinit>
    initlog(ROOTDEV);
801036e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801036eb:	e8 e0 f3 ff ff       	call   80102ad0 <initlog>
801036f0:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
801036f3:	c9                   	leave  
801036f4:	c3                   	ret    
801036f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103700 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80103700:	55                   	push   %ebp
80103701:	89 e5                	mov    %esp,%ebp
80103703:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103706:	68 f5 76 10 80       	push   $0x801076f5
8010370b:	68 80 2d 11 80       	push   $0x80112d80
80103710:	e8 7b 0d 00 00       	call   80104490 <initlock>
}
80103715:	83 c4 10             	add    $0x10,%esp
80103718:	c9                   	leave  
80103719:	c3                   	ret    
8010371a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103720 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
80103720:	55                   	push   %ebp
80103721:	89 e5                	mov    %esp,%ebp
80103723:	56                   	push   %esi
80103724:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103725:	9c                   	pushf  
80103726:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
80103727:	f6 c4 02             	test   $0x2,%ah
8010372a:	75 5e                	jne    8010378a <mycpu+0x6a>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
8010372c:	e8 cf ef ff ff       	call   80102700 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103731:	8b 35 60 2d 11 80    	mov    0x80112d60,%esi
80103737:	85 f6                	test   %esi,%esi
80103739:	7e 42                	jle    8010377d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
8010373b:	0f b6 15 e0 27 11 80 	movzbl 0x801127e0,%edx
80103742:	39 d0                	cmp    %edx,%eax
80103744:	74 30                	je     80103776 <mycpu+0x56>
80103746:	b9 90 28 11 80       	mov    $0x80112890,%ecx
8010374b:	31 d2                	xor    %edx,%edx
8010374d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103750:	83 c2 01             	add    $0x1,%edx
80103753:	39 f2                	cmp    %esi,%edx
80103755:	74 26                	je     8010377d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103757:	0f b6 19             	movzbl (%ecx),%ebx
8010375a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103760:	39 d8                	cmp    %ebx,%eax
80103762:	75 ec                	jne    80103750 <mycpu+0x30>
80103764:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
8010376a:	05 e0 27 11 80       	add    $0x801127e0,%eax
      return &cpus[i];
  }
  panic("unknown apicid\n");
}
8010376f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103772:	5b                   	pop    %ebx
80103773:	5e                   	pop    %esi
80103774:	5d                   	pop    %ebp
80103775:	c3                   	ret    
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
80103776:	b8 e0 27 11 80       	mov    $0x801127e0,%eax
      return &cpus[i];
8010377b:	eb f2                	jmp    8010376f <mycpu+0x4f>
  }
  panic("unknown apicid\n");
8010377d:	83 ec 0c             	sub    $0xc,%esp
80103780:	68 fc 76 10 80       	push   $0x801076fc
80103785:	e8 e6 cb ff ff       	call   80100370 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
8010378a:	83 ec 0c             	sub    $0xc,%esp
8010378d:	68 0c 78 10 80       	push   $0x8010780c
80103792:	e8 d9 cb ff ff       	call   80100370 <panic>
80103797:	89 f6                	mov    %esi,%esi
80103799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037a0 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
801037a0:	55                   	push   %ebp
801037a1:	89 e5                	mov    %esp,%ebp
801037a3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801037a6:	e8 75 ff ff ff       	call   80103720 <mycpu>
801037ab:	2d e0 27 11 80       	sub    $0x801127e0,%eax
}
801037b0:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
801037b1:	c1 f8 04             	sar    $0x4,%eax
801037b4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801037ba:	c3                   	ret    
801037bb:	90                   	nop
801037bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801037c0 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	53                   	push   %ebx
801037c4:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
801037c7:	e8 44 0d 00 00       	call   80104510 <pushcli>
  c = mycpu();
801037cc:	e8 4f ff ff ff       	call   80103720 <mycpu>
  p = c->proc;
801037d1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801037d7:	e8 74 0d 00 00       	call   80104550 <popcli>
  return p;
}
801037dc:	83 c4 04             	add    $0x4,%esp
801037df:	89 d8                	mov    %ebx,%eax
801037e1:	5b                   	pop    %ebx
801037e2:	5d                   	pop    %ebp
801037e3:	c3                   	ret    
801037e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801037ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801037f0 <printnum>:

//prints a number with leading zero in hundreths place
void printnum(const uint num)
{
801037f0:	55                   	push   %ebp
  if (num % 100 > 9)
801037f1:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  return p;
}

//prints a number with leading zero in hundreths place
void printnum(const uint num)
{
801037f6:	89 e5                	mov    %esp,%ebp
801037f8:	83 ec 08             	sub    $0x8,%esp
801037fb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if (num % 100 > 9)
801037fe:	89 c8                	mov    %ecx,%eax
80103800:	f7 e2                	mul    %edx
80103802:	89 d0                	mov    %edx,%eax
80103804:	c1 e8 05             	shr    $0x5,%eax
80103807:	6b c0 64             	imul   $0x64,%eax,%eax
8010380a:	29 c1                	sub    %eax,%ecx
8010380c:	83 f9 09             	cmp    $0x9,%ecx
8010380f:	77 1f                	ja     80103830 <printnum+0x40>
    cprintf("%d.%d\t", num / 100, num % 100);
  else
    cprintf("%d.%d%d\t", num / 100, 0, num % 100);
80103811:	c1 ea 05             	shr    $0x5,%edx
80103814:	51                   	push   %ecx
80103815:	6a 00                	push   $0x0
80103817:	52                   	push   %edx
80103818:	68 13 77 10 80       	push   $0x80107713
8010381d:	e8 3e ce ff ff       	call   80100660 <cprintf>
80103822:	83 c4 10             	add    $0x10,%esp
}
80103825:	c9                   	leave  
80103826:	c3                   	ret    
80103827:	89 f6                	mov    %esi,%esi
80103829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

//prints a number with leading zero in hundreths place
void printnum(const uint num)
{
  if (num % 100 > 9)
    cprintf("%d.%d\t", num / 100, num % 100);
80103830:	83 ec 04             	sub    $0x4,%esp
80103833:	c1 ea 05             	shr    $0x5,%edx
80103836:	51                   	push   %ecx
80103837:	52                   	push   %edx
80103838:	68 0c 77 10 80       	push   $0x8010770c
8010383d:	e8 1e ce ff ff       	call   80100660 <cprintf>
80103842:	83 c4 10             	add    $0x10,%esp
  else
    cprintf("%d.%d%d\t", num / 100, 0, num % 100);
}
80103845:	c9                   	leave  
80103846:	c3                   	ret    
80103847:	89 f6                	mov    %esi,%esi
80103849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103850 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80103850:	55                   	push   %ebp
80103851:	89 e5                	mov    %esp,%ebp
80103853:	53                   	push   %ebx
80103854:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80103857:	e8 54 fd ff ff       	call   801035b0 <allocproc>
8010385c:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
8010385e:	a3 18 a6 10 80       	mov    %eax,0x8010a618
  if((p->pgdir = setupkvm()) == 0)
80103863:	e8 98 36 00 00       	call   80106f00 <setupkvm>
80103868:	85 c0                	test   %eax,%eax
8010386a:	89 43 04             	mov    %eax,0x4(%ebx)
8010386d:	0f 84 c8 00 00 00    	je     8010393b <userinit+0xeb>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103873:	83 ec 04             	sub    $0x4,%esp
80103876:	68 2c 00 00 00       	push   $0x2c
8010387b:	68 c0 a4 10 80       	push   $0x8010a4c0
80103880:	50                   	push   %eax
80103881:	e8 9a 33 00 00       	call   80106c20 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
80103886:	83 c4 0c             	add    $0xc,%esp
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
80103889:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010388f:	6a 4c                	push   $0x4c
80103891:	6a 00                	push   $0x0
80103893:	ff 73 18             	pushl  0x18(%ebx)
80103896:	e8 55 0e 00 00       	call   801046f0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010389b:	8b 43 18             	mov    0x18(%ebx),%eax
8010389e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801038a3:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
801038a8:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801038ab:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801038af:	8b 43 18             	mov    0x18(%ebx),%eax
801038b2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801038b6:	8b 43 18             	mov    0x18(%ebx),%eax
801038b9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801038bd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801038c1:	8b 43 18             	mov    0x18(%ebx),%eax
801038c4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801038c8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801038cc:	8b 43 18             	mov    0x18(%ebx),%eax
801038cf:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801038d6:	8b 43 18             	mov    0x18(%ebx),%eax
801038d9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801038e0:	8b 43 18             	mov    0x18(%ebx),%eax
801038e3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
801038ea:	8d 43 6c             	lea    0x6c(%ebx),%eax
801038ed:	6a 10                	push   $0x10
801038ef:	68 35 77 10 80       	push   $0x80107735
801038f4:	50                   	push   %eax
801038f5:	e8 d6 0f 00 00       	call   801048d0 <safestrcpy>
  p->cwd = namei("/");
801038fa:	c7 04 24 3e 77 10 80 	movl   $0x8010773e,(%esp)
80103901:	e8 ba e5 ff ff       	call   80101ec0 <namei>
80103906:	89 43 68             	mov    %eax,0x68(%ebx)
  p->start_ticks = ticks;
80103909:	a1 00 5a 11 80       	mov    0x80115a00,%eax
8010390e:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103914:	c7 04 24 80 2d 11 80 	movl   $0x80112d80,(%esp)
8010391b:	e8 d0 0c 00 00       	call   801045f0 <acquire>

  p->state = RUNNABLE;
80103920:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80103927:	c7 04 24 80 2d 11 80 	movl   $0x80112d80,(%esp)
8010392e:	e8 6d 0d 00 00       	call   801046a0 <release>
}
80103933:	83 c4 10             	add    $0x10,%esp
80103936:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103939:	c9                   	leave  
8010393a:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
8010393b:	83 ec 0c             	sub    $0xc,%esp
8010393e:	68 1c 77 10 80       	push   $0x8010771c
80103943:	e8 28 ca ff ff       	call   80100370 <panic>
80103948:	90                   	nop
80103949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103950 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103950:	55                   	push   %ebp
80103951:	89 e5                	mov    %esp,%ebp
80103953:	56                   	push   %esi
80103954:	53                   	push   %ebx
80103955:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103958:	e8 b3 0b 00 00       	call   80104510 <pushcli>
  c = mycpu();
8010395d:	e8 be fd ff ff       	call   80103720 <mycpu>
  p = c->proc;
80103962:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103968:	e8 e3 0b 00 00       	call   80104550 <popcli>
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
8010396d:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
80103970:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103972:	7e 34                	jle    801039a8 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103974:	83 ec 04             	sub    $0x4,%esp
80103977:	01 c6                	add    %eax,%esi
80103979:	56                   	push   %esi
8010397a:	50                   	push   %eax
8010397b:	ff 73 04             	pushl  0x4(%ebx)
8010397e:	e8 dd 33 00 00       	call   80106d60 <allocuvm>
80103983:	83 c4 10             	add    $0x10,%esp
80103986:	85 c0                	test   %eax,%eax
80103988:	74 36                	je     801039c0 <growproc+0x70>
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
8010398a:	83 ec 0c             	sub    $0xc,%esp
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
8010398d:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
8010398f:	53                   	push   %ebx
80103990:	e8 7b 31 00 00       	call   80106b10 <switchuvm>
  return 0;
80103995:	83 c4 10             	add    $0x10,%esp
80103998:	31 c0                	xor    %eax,%eax
}
8010399a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010399d:	5b                   	pop    %ebx
8010399e:	5e                   	pop    %esi
8010399f:	5d                   	pop    %ebp
801039a0:	c3                   	ret    
801039a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
801039a8:	74 e0                	je     8010398a <growproc+0x3a>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
801039aa:	83 ec 04             	sub    $0x4,%esp
801039ad:	01 c6                	add    %eax,%esi
801039af:	56                   	push   %esi
801039b0:	50                   	push   %eax
801039b1:	ff 73 04             	pushl  0x4(%ebx)
801039b4:	e8 97 34 00 00       	call   80106e50 <deallocuvm>
801039b9:	83 c4 10             	add    $0x10,%esp
801039bc:	85 c0                	test   %eax,%eax
801039be:	75 ca                	jne    8010398a <growproc+0x3a>
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
801039c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801039c5:	eb d3                	jmp    8010399a <growproc+0x4a>
801039c7:	89 f6                	mov    %esi,%esi
801039c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801039d0 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
801039d0:	55                   	push   %ebp
801039d1:	89 e5                	mov    %esp,%ebp
801039d3:	57                   	push   %edi
801039d4:	56                   	push   %esi
801039d5:	53                   	push   %ebx
801039d6:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801039d9:	e8 32 0b 00 00       	call   80104510 <pushcli>
  c = mycpu();
801039de:	e8 3d fd ff ff       	call   80103720 <mycpu>
  p = c->proc;
801039e3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039e9:	e8 62 0b 00 00       	call   80104550 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
801039ee:	e8 bd fb ff ff       	call   801035b0 <allocproc>
801039f3:	85 c0                	test   %eax,%eax
801039f5:	89 c7                	mov    %eax,%edi
801039f7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801039fa:	0f 84 c0 00 00 00    	je     80103ac0 <fork+0xf0>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103a00:	83 ec 08             	sub    $0x8,%esp
80103a03:	ff 33                	pushl  (%ebx)
80103a05:	ff 73 04             	pushl  0x4(%ebx)
80103a08:	e8 c3 35 00 00       	call   80106fd0 <copyuvm>
80103a0d:	83 c4 10             	add    $0x10,%esp
80103a10:	85 c0                	test   %eax,%eax
80103a12:	89 47 04             	mov    %eax,0x4(%edi)
80103a15:	0f 84 ac 00 00 00    	je     80103ac7 <fork+0xf7>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103a1b:	8b 03                	mov    (%ebx),%eax
80103a1d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  np->parent = curproc;
  *np->tf = *curproc->tf;
80103a20:	b9 13 00 00 00       	mov    $0x13,%ecx
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103a25:	89 07                	mov    %eax,(%edi)
  np->parent = curproc;
80103a27:	89 5f 14             	mov    %ebx,0x14(%edi)
  *np->tf = *curproc->tf;
80103a2a:	89 f8                	mov    %edi,%eax
80103a2c:	8b 73 18             	mov    0x18(%ebx),%esi
80103a2f:	8b 7f 18             	mov    0x18(%edi),%edi
80103a32:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103a34:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103a36:	8b 40 18             	mov    0x18(%eax),%eax
80103a39:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103a40:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103a44:	85 c0                	test   %eax,%eax
80103a46:	74 13                	je     80103a5b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103a48:	83 ec 0c             	sub    $0xc,%esp
80103a4b:	50                   	push   %eax
80103a4c:	e8 7f d3 ff ff       	call   80100dd0 <filedup>
80103a51:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103a54:	83 c4 10             	add    $0x10,%esp
80103a57:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103a5b:	83 c6 01             	add    $0x1,%esi
80103a5e:	83 fe 10             	cmp    $0x10,%esi
80103a61:	75 dd                	jne    80103a40 <fork+0x70>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103a63:	83 ec 0c             	sub    $0xc,%esp
80103a66:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a69:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103a6c:	e8 cf db ff ff       	call   80101640 <idup>
80103a71:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a74:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103a77:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a7a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103a7d:	6a 10                	push   $0x10
80103a7f:	53                   	push   %ebx
80103a80:	50                   	push   %eax
80103a81:	e8 4a 0e 00 00       	call   801048d0 <safestrcpy>

  pid = np->pid;
  np->start_ticks = ticks;
80103a86:	a1 00 5a 11 80       	mov    0x80115a00,%eax
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  pid = np->pid;
80103a8b:	8b 5f 10             	mov    0x10(%edi),%ebx
  np->start_ticks = ticks;
80103a8e:	89 87 80 00 00 00    	mov    %eax,0x80(%edi)

  acquire(&ptable.lock);
80103a94:	c7 04 24 80 2d 11 80 	movl   $0x80112d80,(%esp)
80103a9b:	e8 50 0b 00 00       	call   801045f0 <acquire>

  np->state = RUNNABLE;
80103aa0:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
80103aa7:	c7 04 24 80 2d 11 80 	movl   $0x80112d80,(%esp)
80103aae:	e8 ed 0b 00 00       	call   801046a0 <release>

  return pid;
80103ab3:	83 c4 10             	add    $0x10,%esp
}
80103ab6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ab9:	89 d8                	mov    %ebx,%eax
80103abb:	5b                   	pop    %ebx
80103abc:	5e                   	pop    %esi
80103abd:	5f                   	pop    %edi
80103abe:	5d                   	pop    %ebp
80103abf:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103ac0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103ac5:	eb ef                	jmp    80103ab6 <fork+0xe6>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103ac7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103aca:	83 ec 0c             	sub    $0xc,%esp
80103acd:	ff 73 08             	pushl  0x8(%ebx)
80103ad0:	e8 0b e8 ff ff       	call   801022e0 <kfree>
    np->kstack = 0;
80103ad5:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103adc:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103ae3:	83 c4 10             	add    $0x10,%esp
80103ae6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103aeb:	eb c9                	jmp    80103ab6 <fork+0xe6>
80103aed:	8d 76 00             	lea    0x0(%esi),%esi

80103af0 <scheduler>:
  }
}
#else
void
scheduler(void)
{
80103af0:	55                   	push   %ebp
80103af1:	89 e5                	mov    %esp,%ebp
80103af3:	57                   	push   %edi
80103af4:	56                   	push   %esi
80103af5:	53                   	push   %ebx
80103af6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p1;
  struct proc *p2;
  struct cpu *c = mycpu();
80103af9:	e8 22 fc ff ff       	call   80103720 <mycpu>
80103afe:	8d 70 04             	lea    0x4(%eax),%esi
80103b01:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
80103b03:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103b0a:	00 00 00 
}

static inline void
sti(void)
{
  asm volatile("sti");
80103b0d:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103b0e:	83 ec 0c             	sub    $0xc,%esp
    for(p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++){
80103b11:	bf b4 2d 11 80       	mov    $0x80112db4,%edi
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103b16:	68 80 2d 11 80       	push   $0x80112d80
80103b1b:	e8 d0 0a 00 00       	call   801045f0 <acquire>
80103b20:	83 c4 10             	add    $0x10,%esp
80103b23:	eb 15                	jmp    80103b3a <scheduler+0x4a>
80103b25:	8d 76 00             	lea    0x0(%esi),%esi
    for(p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++){
80103b28:	81 c7 90 00 00 00    	add    $0x90,%edi
80103b2e:	81 ff b4 51 11 80    	cmp    $0x801151b4,%edi
80103b34:	0f 83 8d 00 00 00    	jae    80103bc7 <scheduler+0xd7>
      if(p1->state != RUNNABLE)
80103b3a:	83 7f 0c 03          	cmpl   $0x3,0xc(%edi)
80103b3e:	75 e8                	jne    80103b28 <scheduler+0x38>
80103b40:	b8 b4 2d 11 80       	mov    $0x80112db4,%eax
80103b45:	eb 15                	jmp    80103b5c <scheduler+0x6c>
80103b47:	89 f6                	mov    %esi,%esi
80103b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        continue;
      
      hp = p1;
      for (p2 = ptable.proc; p2 < &ptable.proc[NPROC]; p2++)
80103b50:	05 90 00 00 00       	add    $0x90,%eax
80103b55:	3d b4 51 11 80       	cmp    $0x801151b4,%eax
80103b5a:	73 1b                	jae    80103b77 <scheduler+0x87>
      {
        if (p2->state != RUNNABLE)
80103b5c:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103b60:	75 ee                	jne    80103b50 <scheduler+0x60>
          continue;
        if (hp->priority > p2->priority) {
80103b62:	8b 50 7c             	mov    0x7c(%eax),%edx
80103b65:	39 57 7c             	cmp    %edx,0x7c(%edi)
80103b68:	0f 4f f8             	cmovg  %eax,%edi
    for(p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++){
      if(p1->state != RUNNABLE)
        continue;
      
      hp = p1;
      for (p2 = ptable.proc; p2 < &ptable.proc[NPROC]; p2++)
80103b6b:	05 90 00 00 00       	add    $0x90,%eax
80103b70:	3d b4 51 11 80       	cmp    $0x801151b4,%eax
80103b75:	72 e5                	jb     80103b5c <scheduler+0x6c>
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      p1 = hp;
      c->proc = p1;
      switchuvm(p1);
80103b77:	83 ec 0c             	sub    $0xc,%esp
      }
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      p1 = hp;
      c->proc = p1;
80103b7a:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
      switchuvm(p1);
80103b80:	57                   	push   %edi
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++){
80103b81:	81 c7 90 00 00 00    	add    $0x90,%edi
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      p1 = hp;
      c->proc = p1;
      switchuvm(p1);
80103b87:	e8 84 2f 00 00       	call   80106b10 <switchuvm>
      p1->state = RUNNING;
      p1->cpu_ticks_in = ticks;
80103b8c:	a1 00 5a 11 80       	mov    0x80115a00,%eax
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      p1 = hp;
      c->proc = p1;
      switchuvm(p1);
      p1->state = RUNNING;
80103b91:	c7 87 7c ff ff ff 04 	movl   $0x4,-0x84(%edi)
80103b98:	00 00 00 
      p1->cpu_ticks_in = ticks;
80103b9b:	89 47 f8             	mov    %eax,-0x8(%edi)
      //cprintf("Scheduler: %d\n", p1->pid);
      swtch(&(c->scheduler), p1->context);
80103b9e:	58                   	pop    %eax
80103b9f:	5a                   	pop    %edx
80103ba0:	ff 77 8c             	pushl  -0x74(%edi)
80103ba3:	56                   	push   %esi
80103ba4:	e8 82 0d 00 00       	call   8010492b <swtch>
      switchkvm();
80103ba9:	e8 42 2f 00 00       	call   80106af0 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103bae:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++){
80103bb1:	81 ff b4 51 11 80    	cmp    $0x801151b4,%edi
      swtch(&(c->scheduler), p1->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103bb7:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80103bbe:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++){
80103bc1:	0f 82 73 ff ff ff    	jb     80103b3a <scheduler+0x4a>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80103bc7:	83 ec 0c             	sub    $0xc,%esp
80103bca:	68 80 2d 11 80       	push   $0x80112d80
80103bcf:	e8 cc 0a 00 00       	call   801046a0 <release>
  c->proc = 0;
  struct proc *hp = ((void *)0);
  
  for(;;){
    // Enable interrupts on this processor.
    sti();
80103bd4:	83 c4 10             	add    $0x10,%esp
80103bd7:	e9 31 ff ff ff       	jmp    80103b0d <scheduler+0x1d>
80103bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103be0 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103be0:	55                   	push   %ebp
80103be1:	89 e5                	mov    %esp,%ebp
80103be3:	56                   	push   %esi
80103be4:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103be5:	e8 26 09 00 00       	call   80104510 <pushcli>
  c = mycpu();
80103bea:	e8 31 fb ff ff       	call   80103720 <mycpu>
  p = c->proc;
80103bef:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103bf5:	e8 56 09 00 00       	call   80104550 <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
80103bfa:	83 ec 0c             	sub    $0xc,%esp
80103bfd:	68 80 2d 11 80       	push   $0x80112d80
80103c02:	e8 b9 09 00 00       	call   801045c0 <holding>
80103c07:	83 c4 10             	add    $0x10,%esp
80103c0a:	85 c0                	test   %eax,%eax
80103c0c:	74 5d                	je     80103c6b <sched+0x8b>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103c0e:	e8 0d fb ff ff       	call   80103720 <mycpu>
80103c13:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103c1a:	75 76                	jne    80103c92 <sched+0xb2>
    panic("sched locks");
  if(p->state == RUNNING)
80103c1c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103c20:	74 63                	je     80103c85 <sched+0xa5>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c22:	9c                   	pushf  
80103c23:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103c24:	f6 c4 02             	test   $0x2,%ah
80103c27:	75 4f                	jne    80103c78 <sched+0x98>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103c29:	e8 f2 fa ff ff       	call   80103720 <mycpu>
80103c2e:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  //cprintf("Sched: %s\n", p->name);
  p->cpu_ticks_total += ticks - p->cpu_ticks_in;
80103c34:	a1 00 5a 11 80       	mov    0x80115a00,%eax
  swtch(&p->context, mycpu()->scheduler);
80103c39:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  //cprintf("Sched: %s\n", p->name);
  p->cpu_ticks_total += ticks - p->cpu_ticks_in;
80103c3c:	03 43 68             	add    0x68(%ebx),%eax
80103c3f:	2b 43 6c             	sub    0x6c(%ebx),%eax
80103c42:	89 43 68             	mov    %eax,0x68(%ebx)
  swtch(&p->context, mycpu()->scheduler);
80103c45:	e8 d6 fa ff ff       	call   80103720 <mycpu>
80103c4a:	83 ec 08             	sub    $0x8,%esp
80103c4d:	ff 70 04             	pushl  0x4(%eax)
80103c50:	53                   	push   %ebx
80103c51:	e8 d5 0c 00 00       	call   8010492b <swtch>
  mycpu()->intena = intena;
80103c56:	e8 c5 fa ff ff       	call   80103720 <mycpu>
}
80103c5b:	83 c4 10             	add    $0x10,%esp
    panic("sched interruptible");
  intena = mycpu()->intena;
  //cprintf("Sched: %s\n", p->name);
  p->cpu_ticks_total += ticks - p->cpu_ticks_in;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
80103c5e:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103c64:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c67:	5b                   	pop    %ebx
80103c68:	5e                   	pop    %esi
80103c69:	5d                   	pop    %ebp
80103c6a:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103c6b:	83 ec 0c             	sub    $0xc,%esp
80103c6e:	68 40 77 10 80       	push   $0x80107740
80103c73:	e8 f8 c6 ff ff       	call   80100370 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103c78:	83 ec 0c             	sub    $0xc,%esp
80103c7b:	68 6c 77 10 80       	push   $0x8010776c
80103c80:	e8 eb c6 ff ff       	call   80100370 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103c85:	83 ec 0c             	sub    $0xc,%esp
80103c88:	68 5e 77 10 80       	push   $0x8010775e
80103c8d:	e8 de c6 ff ff       	call   80100370 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103c92:	83 ec 0c             	sub    $0xc,%esp
80103c95:	68 52 77 10 80       	push   $0x80107752
80103c9a:	e8 d1 c6 ff ff       	call   80100370 <panic>
80103c9f:	90                   	nop

80103ca0 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103ca0:	55                   	push   %ebp
80103ca1:	89 e5                	mov    %esp,%ebp
80103ca3:	57                   	push   %edi
80103ca4:	56                   	push   %esi
80103ca5:	53                   	push   %ebx
80103ca6:	83 ec 0c             	sub    $0xc,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103ca9:	e8 62 08 00 00       	call   80104510 <pushcli>
  c = mycpu();
80103cae:	e8 6d fa ff ff       	call   80103720 <mycpu>
  p = c->proc;
80103cb3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103cb9:	e8 92 08 00 00       	call   80104550 <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103cbe:	39 35 18 a6 10 80    	cmp    %esi,0x8010a618
80103cc4:	8d 5e 28             	lea    0x28(%esi),%ebx
80103cc7:	8d 7e 68             	lea    0x68(%esi),%edi
80103cca:	0f 84 f1 00 00 00    	je     80103dc1 <exit+0x121>
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103cd0:	8b 03                	mov    (%ebx),%eax
80103cd2:	85 c0                	test   %eax,%eax
80103cd4:	74 12                	je     80103ce8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103cd6:	83 ec 0c             	sub    $0xc,%esp
80103cd9:	50                   	push   %eax
80103cda:	e8 41 d1 ff ff       	call   80100e20 <fileclose>
      curproc->ofile[fd] = 0;
80103cdf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103ce5:	83 c4 10             	add    $0x10,%esp
80103ce8:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103ceb:	39 fb                	cmp    %edi,%ebx
80103ced:	75 e1                	jne    80103cd0 <exit+0x30>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103cef:	e8 7c ee ff ff       	call   80102b70 <begin_op>
  iput(curproc->cwd);
80103cf4:	83 ec 0c             	sub    $0xc,%esp
80103cf7:	ff 76 68             	pushl  0x68(%esi)
80103cfa:	e8 a1 da ff ff       	call   801017a0 <iput>
  end_op();
80103cff:	e8 dc ee ff ff       	call   80102be0 <end_op>
  curproc->cwd = 0;
80103d04:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
//  printnum(curproc->cpu_ticks_total);
//  printnum(curproc->cpu_ticks_in);
//  printnum(curproc->cpu_in_time);
//  printnum(ticks - curproc->cpu_in_time);
//  cprintf("\n");
  acquire(&ptable.lock);
80103d0b:	c7 04 24 80 2d 11 80 	movl   $0x80112d80,(%esp)
80103d12:	e8 d9 08 00 00       	call   801045f0 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103d17:	8b 56 14             	mov    0x14(%esi),%edx
80103d1a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d1d:	b8 b4 2d 11 80       	mov    $0x80112db4,%eax
80103d22:	eb 10                	jmp    80103d34 <exit+0x94>
80103d24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d28:	05 90 00 00 00       	add    $0x90,%eax
80103d2d:	3d b4 51 11 80       	cmp    $0x801151b4,%eax
80103d32:	73 1e                	jae    80103d52 <exit+0xb2>
    if(p->state == SLEEPING && p->chan == chan)
80103d34:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d38:	75 ee                	jne    80103d28 <exit+0x88>
80103d3a:	3b 50 20             	cmp    0x20(%eax),%edx
80103d3d:	75 e9                	jne    80103d28 <exit+0x88>
      p->state = RUNNABLE;
80103d3f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d46:	05 90 00 00 00       	add    $0x90,%eax
80103d4b:	3d b4 51 11 80       	cmp    $0x801151b4,%eax
80103d50:	72 e2                	jb     80103d34 <exit+0x94>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103d52:	8b 0d 18 a6 10 80    	mov    0x8010a618,%ecx
80103d58:	ba b4 2d 11 80       	mov    $0x80112db4,%edx
80103d5d:	eb 0f                	jmp    80103d6e <exit+0xce>
80103d5f:	90                   	nop

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d60:	81 c2 90 00 00 00    	add    $0x90,%edx
80103d66:	81 fa b4 51 11 80    	cmp    $0x801151b4,%edx
80103d6c:	73 3a                	jae    80103da8 <exit+0x108>
    if(p->parent == curproc){
80103d6e:	39 72 14             	cmp    %esi,0x14(%edx)
80103d71:	75 ed                	jne    80103d60 <exit+0xc0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103d73:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103d77:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103d7a:	75 e4                	jne    80103d60 <exit+0xc0>
80103d7c:	b8 b4 2d 11 80       	mov    $0x80112db4,%eax
80103d81:	eb 11                	jmp    80103d94 <exit+0xf4>
80103d83:	90                   	nop
80103d84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d88:	05 90 00 00 00       	add    $0x90,%eax
80103d8d:	3d b4 51 11 80       	cmp    $0x801151b4,%eax
80103d92:	73 cc                	jae    80103d60 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103d94:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d98:	75 ee                	jne    80103d88 <exit+0xe8>
80103d9a:	3b 48 20             	cmp    0x20(%eax),%ecx
80103d9d:	75 e9                	jne    80103d88 <exit+0xe8>
      p->state = RUNNABLE;
80103d9f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103da6:	eb e0                	jmp    80103d88 <exit+0xe8>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103da8:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103daf:	e8 2c fe ff ff       	call   80103be0 <sched>
  panic("zombie exit");
80103db4:	83 ec 0c             	sub    $0xc,%esp
80103db7:	68 8d 77 10 80       	push   $0x8010778d
80103dbc:	e8 af c5 ff ff       	call   80100370 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80103dc1:	83 ec 0c             	sub    $0xc,%esp
80103dc4:	68 80 77 10 80       	push   $0x80107780
80103dc9:	e8 a2 c5 ff ff       	call   80100370 <panic>
80103dce:	66 90                	xchg   %ax,%ax

80103dd0 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103dd0:	55                   	push   %ebp
80103dd1:	89 e5                	mov    %esp,%ebp
80103dd3:	53                   	push   %ebx
80103dd4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103dd7:	68 80 2d 11 80       	push   $0x80112d80
80103ddc:	e8 0f 08 00 00       	call   801045f0 <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103de1:	e8 2a 07 00 00       	call   80104510 <pushcli>
  c = mycpu();
80103de6:	e8 35 f9 ff ff       	call   80103720 <mycpu>
  p = c->proc;
80103deb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103df1:	e8 5a 07 00 00       	call   80104550 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
80103df6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103dfd:	e8 de fd ff ff       	call   80103be0 <sched>
  release(&ptable.lock);
80103e02:	c7 04 24 80 2d 11 80 	movl   $0x80112d80,(%esp)
80103e09:	e8 92 08 00 00       	call   801046a0 <release>
}
80103e0e:	83 c4 10             	add    $0x10,%esp
80103e11:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e14:	c9                   	leave  
80103e15:	c3                   	ret    
80103e16:	8d 76 00             	lea    0x0(%esi),%esi
80103e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e20 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103e20:	55                   	push   %ebp
80103e21:	89 e5                	mov    %esp,%ebp
80103e23:	57                   	push   %edi
80103e24:	56                   	push   %esi
80103e25:	53                   	push   %ebx
80103e26:	83 ec 0c             	sub    $0xc,%esp
80103e29:	8b 7d 08             	mov    0x8(%ebp),%edi
80103e2c:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103e2f:	e8 dc 06 00 00       	call   80104510 <pushcli>
  c = mycpu();
80103e34:	e8 e7 f8 ff ff       	call   80103720 <mycpu>
  p = c->proc;
80103e39:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e3f:	e8 0c 07 00 00       	call   80104550 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
80103e44:	85 db                	test   %ebx,%ebx
80103e46:	0f 84 87 00 00 00    	je     80103ed3 <sleep+0xb3>
    panic("sleep");

  if(lk == 0)
80103e4c:	85 f6                	test   %esi,%esi
80103e4e:	74 76                	je     80103ec6 <sleep+0xa6>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103e50:	81 fe 80 2d 11 80    	cmp    $0x80112d80,%esi
80103e56:	74 50                	je     80103ea8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103e58:	83 ec 0c             	sub    $0xc,%esp
80103e5b:	68 80 2d 11 80       	push   $0x80112d80
80103e60:	e8 8b 07 00 00       	call   801045f0 <acquire>
    release(lk);
80103e65:	89 34 24             	mov    %esi,(%esp)
80103e68:	e8 33 08 00 00       	call   801046a0 <release>
  }
  // Go to sleep.
  p->chan = chan;
80103e6d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103e70:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103e77:	e8 64 fd ff ff       	call   80103be0 <sched>

  // Tidy up.
  p->chan = 0;
80103e7c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103e83:	c7 04 24 80 2d 11 80 	movl   $0x80112d80,(%esp)
80103e8a:	e8 11 08 00 00       	call   801046a0 <release>
    acquire(lk);
80103e8f:	89 75 08             	mov    %esi,0x8(%ebp)
80103e92:	83 c4 10             	add    $0x10,%esp
  }
}
80103e95:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e98:	5b                   	pop    %ebx
80103e99:	5e                   	pop    %esi
80103e9a:	5f                   	pop    %edi
80103e9b:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103e9c:	e9 4f 07 00 00       	jmp    801045f0 <acquire>
80103ea1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80103ea8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103eab:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103eb2:	e8 29 fd ff ff       	call   80103be0 <sched>

  // Tidy up.
  p->chan = 0;
80103eb7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103ebe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ec1:	5b                   	pop    %ebx
80103ec2:	5e                   	pop    %esi
80103ec3:	5f                   	pop    %edi
80103ec4:	5d                   	pop    %ebp
80103ec5:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80103ec6:	83 ec 0c             	sub    $0xc,%esp
80103ec9:	68 9f 77 10 80       	push   $0x8010779f
80103ece:	e8 9d c4 ff ff       	call   80100370 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
80103ed3:	83 ec 0c             	sub    $0xc,%esp
80103ed6:	68 99 77 10 80       	push   $0x80107799
80103edb:	e8 90 c4 ff ff       	call   80100370 <panic>

80103ee0 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103ee0:	55                   	push   %ebp
80103ee1:	89 e5                	mov    %esp,%ebp
80103ee3:	56                   	push   %esi
80103ee4:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103ee5:	e8 26 06 00 00       	call   80104510 <pushcli>
  c = mycpu();
80103eea:	e8 31 f8 ff ff       	call   80103720 <mycpu>
  p = c->proc;
80103eef:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103ef5:	e8 56 06 00 00       	call   80104550 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
80103efa:	83 ec 0c             	sub    $0xc,%esp
80103efd:	68 80 2d 11 80       	push   $0x80112d80
80103f02:	e8 e9 06 00 00       	call   801045f0 <acquire>
80103f07:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80103f0a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f0c:	bb b4 2d 11 80       	mov    $0x80112db4,%ebx
80103f11:	eb 13                	jmp    80103f26 <wait+0x46>
80103f13:	90                   	nop
80103f14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f18:	81 c3 90 00 00 00    	add    $0x90,%ebx
80103f1e:	81 fb b4 51 11 80    	cmp    $0x801151b4,%ebx
80103f24:	73 22                	jae    80103f48 <wait+0x68>
      if(p->parent != curproc)
80103f26:	39 73 14             	cmp    %esi,0x14(%ebx)
80103f29:	75 ed                	jne    80103f18 <wait+0x38>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80103f2b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103f2f:	74 35                	je     80103f66 <wait+0x86>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f31:	81 c3 90 00 00 00    	add    $0x90,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80103f37:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f3c:	81 fb b4 51 11 80    	cmp    $0x801151b4,%ebx
80103f42:	72 e2                	jb     80103f26 <wait+0x46>
80103f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80103f48:	85 c0                	test   %eax,%eax
80103f4a:	74 70                	je     80103fbc <wait+0xdc>
80103f4c:	8b 46 24             	mov    0x24(%esi),%eax
80103f4f:	85 c0                	test   %eax,%eax
80103f51:	75 69                	jne    80103fbc <wait+0xdc>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103f53:	83 ec 08             	sub    $0x8,%esp
80103f56:	68 80 2d 11 80       	push   $0x80112d80
80103f5b:	56                   	push   %esi
80103f5c:	e8 bf fe ff ff       	call   80103e20 <sleep>
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80103f61:	83 c4 10             	add    $0x10,%esp
80103f64:	eb a4                	jmp    80103f0a <wait+0x2a>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80103f66:	83 ec 0c             	sub    $0xc,%esp
80103f69:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80103f6c:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103f6f:	e8 6c e3 ff ff       	call   801022e0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80103f74:	5a                   	pop    %edx
80103f75:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80103f78:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103f7f:	e8 fc 2e 00 00       	call   80106e80 <freevm>
        p->pid = 0;
80103f84:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103f8b:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103f92:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103f96:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103f9d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103fa4:	c7 04 24 80 2d 11 80 	movl   $0x80112d80,(%esp)
80103fab:	e8 f0 06 00 00       	call   801046a0 <release>
        return pid;
80103fb0:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103fb3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103fb6:	89 f0                	mov    %esi,%eax
80103fb8:	5b                   	pop    %ebx
80103fb9:	5e                   	pop    %esi
80103fba:	5d                   	pop    %ebp
80103fbb:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80103fbc:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103fbf:	be ff ff ff ff       	mov    $0xffffffff,%esi
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80103fc4:	68 80 2d 11 80       	push   $0x80112d80
80103fc9:	e8 d2 06 00 00       	call   801046a0 <release>
      return -1;
80103fce:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103fd1:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103fd4:	89 f0                	mov    %esi,%eax
80103fd6:	5b                   	pop    %ebx
80103fd7:	5e                   	pop    %esi
80103fd8:	5d                   	pop    %ebp
80103fd9:	c3                   	ret    
80103fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103fe0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103fe0:	55                   	push   %ebp
80103fe1:	89 e5                	mov    %esp,%ebp
80103fe3:	53                   	push   %ebx
80103fe4:	83 ec 10             	sub    $0x10,%esp
80103fe7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103fea:	68 80 2d 11 80       	push   $0x80112d80
80103fef:	e8 fc 05 00 00       	call   801045f0 <acquire>
80103ff4:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ff7:	b8 b4 2d 11 80       	mov    $0x80112db4,%eax
80103ffc:	eb 0e                	jmp    8010400c <wakeup+0x2c>
80103ffe:	66 90                	xchg   %ax,%ax
80104000:	05 90 00 00 00       	add    $0x90,%eax
80104005:	3d b4 51 11 80       	cmp    $0x801151b4,%eax
8010400a:	73 1e                	jae    8010402a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010400c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104010:	75 ee                	jne    80104000 <wakeup+0x20>
80104012:	3b 58 20             	cmp    0x20(%eax),%ebx
80104015:	75 e9                	jne    80104000 <wakeup+0x20>
      p->state = RUNNABLE;
80104017:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010401e:	05 90 00 00 00       	add    $0x90,%eax
80104023:	3d b4 51 11 80       	cmp    $0x801151b4,%eax
80104028:	72 e2                	jb     8010400c <wakeup+0x2c>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
8010402a:	c7 45 08 80 2d 11 80 	movl   $0x80112d80,0x8(%ebp)
}
80104031:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104034:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104035:	e9 66 06 00 00       	jmp    801046a0 <release>
8010403a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104040 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104040:	55                   	push   %ebp
80104041:	89 e5                	mov    %esp,%ebp
80104043:	53                   	push   %ebx
80104044:	83 ec 10             	sub    $0x10,%esp
80104047:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010404a:	68 80 2d 11 80       	push   $0x80112d80
8010404f:	e8 9c 05 00 00       	call   801045f0 <acquire>
80104054:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104057:	b8 b4 2d 11 80       	mov    $0x80112db4,%eax
8010405c:	eb 0e                	jmp    8010406c <kill+0x2c>
8010405e:	66 90                	xchg   %ax,%ax
80104060:	05 90 00 00 00       	add    $0x90,%eax
80104065:	3d b4 51 11 80       	cmp    $0x801151b4,%eax
8010406a:	73 3c                	jae    801040a8 <kill+0x68>
    if(p->pid == pid){
8010406c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010406f:	75 ef                	jne    80104060 <kill+0x20>
      p->killed = 1;
      //cprintf("HERE %s %d %d\n", p->name, p->pid, p->cpu_ticks_total);
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104071:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80104075:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      //cprintf("HERE %s %d %d\n", p->name, p->pid, p->cpu_ticks_total);
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010407c:	74 1a                	je     80104098 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
8010407e:	83 ec 0c             	sub    $0xc,%esp
80104081:	68 80 2d 11 80       	push   $0x80112d80
80104086:	e8 15 06 00 00       	call   801046a0 <release>
      return 0;
8010408b:	83 c4 10             	add    $0x10,%esp
8010408e:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104090:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104093:	c9                   	leave  
80104094:	c3                   	ret    
80104095:	8d 76 00             	lea    0x0(%esi),%esi
    if(p->pid == pid){
      p->killed = 1;
      //cprintf("HERE %s %d %d\n", p->name, p->pid, p->cpu_ticks_total);
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80104098:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010409f:	eb dd                	jmp    8010407e <kill+0x3e>
801040a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
801040a8:	83 ec 0c             	sub    $0xc,%esp
801040ab:	68 80 2d 11 80       	push   $0x80112d80
801040b0:	e8 eb 05 00 00       	call   801046a0 <release>
  return -1;
801040b5:	83 c4 10             	add    $0x10,%esp
801040b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801040bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040c0:	c9                   	leave  
801040c1:	c3                   	ret    
801040c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801040d0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801040d0:	55                   	push   %ebp
801040d1:	89 e5                	mov    %esp,%ebp
801040d3:	57                   	push   %edi
801040d4:	56                   	push   %esi
801040d5:	53                   	push   %ebx
  struct proc *p;
  char *state;
  uint curr_ticks = ticks;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040d6:	bf b4 2d 11 80       	mov    $0x80112db4,%edi
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801040db:	83 ec 3c             	sub    $0x3c,%esp
  [ZOMBIE]    "zombie"
  };
  int i;
  struct proc *p;
  char *state;
  uint curr_ticks = ticks;
801040de:	8b 1d 00 5a 11 80    	mov    0x80115a00,%ebx
801040e4:	eb 2c                	jmp    80104112 <procdump+0x42>
801040e6:	8d 76 00             	lea    0x0(%esi),%esi
801040e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801040f0:	83 ec 0c             	sub    $0xc,%esp
801040f3:	68 a7 78 10 80       	push   $0x801078a7
801040f8:	e8 63 c5 ff ff       	call   80100660 <cprintf>
801040fd:	83 c4 10             	add    $0x10,%esp
  struct proc *p;
  char *state;
  uint curr_ticks = ticks;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104100:	81 c7 90 00 00 00    	add    $0x90,%edi
80104106:	81 ff b4 51 11 80    	cmp    $0x801151b4,%edi
8010410c:	0f 83 ae 00 00 00    	jae    801041c0 <procdump+0xf0>
    if(p->state == UNUSED)
80104112:	8b 57 0c             	mov    0xc(%edi),%edx
80104115:	85 d2                	test   %edx,%edx
80104117:	74 e7                	je     80104100 <procdump+0x30>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104119:	83 fa 05             	cmp    $0x5,%edx
      state = states[p->state];
    else
      state = "???";
8010411c:	b9 b0 77 10 80       	mov    $0x801077b0,%ecx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104121:	77 11                	ja     80104134 <procdump+0x64>
80104123:	8b 0c 95 4c 78 10 80 	mov    -0x7fef87b4(,%edx,4),%ecx
      state = states[p->state];
    else
      state = "???";
8010412a:	ba b0 77 10 80       	mov    $0x801077b0,%edx
8010412f:	85 c9                	test   %ecx,%ecx
80104131:	0f 44 ca             	cmove  %edx,%ecx
    cprintf("%d %s %s", p->pid, state, p->name);
80104134:	8d 57 6c             	lea    0x6c(%edi),%edx
80104137:	52                   	push   %edx
80104138:	51                   	push   %ecx
80104139:	ff 77 10             	pushl  0x10(%edi)
8010413c:	68 b4 77 10 80       	push   $0x801077b4
80104141:	e8 1a c5 ff ff       	call   80100660 <cprintf>
    printnum(curr_ticks - p->start_ticks);
80104146:	89 da                	mov    %ebx,%edx
80104148:	2b 97 80 00 00 00    	sub    0x80(%edi),%edx
8010414e:	89 14 24             	mov    %edx,(%esp)
80104151:	e8 9a f6 ff ff       	call   801037f0 <printnum>
    printnum(p->cpu_ticks_total);
80104156:	58                   	pop    %eax
80104157:	ff b7 84 00 00 00    	pushl  0x84(%edi)
8010415d:	e8 8e f6 ff ff       	call   801037f0 <printnum>
    if(p->state == SLEEPING){
80104162:	83 c4 10             	add    $0x10,%esp
80104165:	83 7f 0c 02          	cmpl   $0x2,0xc(%edi)
80104169:	75 85                	jne    801040f0 <procdump+0x20>
      getcallerpcs((uint*)p->context->ebp+2, pc);
8010416b:	8b 57 1c             	mov    0x1c(%edi),%edx
8010416e:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104171:	83 ec 08             	sub    $0x8,%esp
80104174:	8d 75 c0             	lea    -0x40(%ebp),%esi
80104177:	50                   	push   %eax
80104178:	8b 52 0c             	mov    0xc(%edx),%edx
8010417b:	83 c2 08             	add    $0x8,%edx
8010417e:	52                   	push   %edx
8010417f:	e8 2c 03 00 00       	call   801044b0 <getcallerpcs>
80104184:	83 c4 10             	add    $0x10,%esp
80104187:	89 f6                	mov    %esi,%esi
80104189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      for(i=0; i<10 && pc[i] != 0; i++)
80104190:	8b 0e                	mov    (%esi),%ecx
80104192:	85 c9                	test   %ecx,%ecx
80104194:	0f 84 56 ff ff ff    	je     801040f0 <procdump+0x20>
        cprintf(" %p", pc[i]);
8010419a:	83 ec 08             	sub    $0x8,%esp
8010419d:	83 c6 04             	add    $0x4,%esi
801041a0:	51                   	push   %ecx
801041a1:	68 e1 71 10 80       	push   $0x801071e1
801041a6:	e8 b5 c4 ff ff       	call   80100660 <cprintf>
    cprintf("%d %s %s", p->pid, state, p->name);
    printnum(curr_ticks - p->start_ticks);
    printnum(p->cpu_ticks_total);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
801041ab:	8d 45 e8             	lea    -0x18(%ebp),%eax
801041ae:	83 c4 10             	add    $0x10,%esp
801041b1:	39 f0                	cmp    %esi,%eax
801041b3:	75 db                	jne    80104190 <procdump+0xc0>
801041b5:	e9 36 ff ff ff       	jmp    801040f0 <procdump+0x20>
801041ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
801041c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041c3:	5b                   	pop    %ebx
801041c4:	5e                   	pop    %esi
801041c5:	5f                   	pop    %edi
801041c6:	5d                   	pop    %ebp
801041c7:	c3                   	ret    
801041c8:	90                   	nop
801041c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801041d0 <getprocs>:
// since we must access the list to find pid
// and may need to make a list transition 
// to be able to display them
int 
getprocs(uint max, struct uproc *table)
{
801041d0:	55                   	push   %ebp
801041d1:	89 e5                	mov    %esp,%ebp
801041d3:	57                   	push   %edi
801041d4:	56                   	push   %esi
801041d5:	53                   	push   %ebx
801041d6:	83 ec 18             	sub    $0x18,%esp
      [RUNNABLE] "Ready",
      [RUNNING] "Run",
      [ZOMBIE] "Zombie"
  };
  
  acquire(&ptable.lock);
801041d9:	68 80 2d 11 80       	push   $0x80112d80
801041de:	e8 0d 04 00 00       	call   801045f0 <acquire>
  p = ptable.proc;
  for (; p < &ptable.proc[NPROC] && i < max; i++, p++) {
801041e3:	8b 55 08             	mov    0x8(%ebp),%edx
801041e6:	83 c4 10             	add    $0x10,%esp
801041e9:	85 d2                	test   %edx,%edx
801041eb:	0f 84 bd 00 00 00    	je     801042ae <getprocs+0xde>
801041f1:	bb b4 2d 11 80       	mov    $0x80112db4,%ebx
801041f6:	31 f6                	xor    %esi,%esi
801041f8:	eb 27                	jmp    80104221 <getprocs+0x51>
801041fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    
    if (p->state == UNUSED) {
      i--;
80104200:	83 ee 01             	sub    $0x1,%esi
      [ZOMBIE] "Zombie"
  };
  
  acquire(&ptable.lock);
  p = ptable.proc;
  for (; p < &ptable.proc[NPROC] && i < max; i++, p++) {
80104203:	81 c3 90 00 00 00    	add    $0x90,%ebx
80104209:	83 c6 01             	add    $0x1,%esi
8010420c:	81 fb b4 51 11 80    	cmp    $0x801151b4,%ebx
80104212:	0f 83 98 00 00 00    	jae    801042b0 <getprocs+0xe0>
80104218:	39 75 08             	cmp    %esi,0x8(%ebp)
8010421b:	0f 86 8f 00 00 00    	jbe    801042b0 <getprocs+0xe0>
    
    if (p->state == UNUSED) {
80104221:	8b 43 0c             	mov    0xc(%ebx),%eax
80104224:	85 c0                	test   %eax,%eax
80104226:	74 d8                	je     80104200 <getprocs+0x30>
      i--;
      continue; //skipping unused processes
    }

    strncpy(table[i].name, p->name, STRMAX);
80104228:	6b d6 64             	imul   $0x64,%esi,%edx
8010422b:	03 55 0c             	add    0xc(%ebp),%edx
8010422e:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104231:	83 ec 04             	sub    $0x4,%esp
80104234:	6a 20                	push   $0x20
80104236:	50                   	push   %eax
80104237:	8d 42 44             	lea    0x44(%edx),%eax
8010423a:	89 d7                	mov    %edx,%edi
8010423c:	50                   	push   %eax
8010423d:	e8 2e 06 00 00       	call   80104870 <strncpy>
    table[i].pid = p->pid;
80104242:	8b 43 10             	mov    0x10(%ebx),%eax
    table[i].ppid = (p->parent ? p->parent->pid : p->pid);
80104245:	83 c4 10             	add    $0x10,%esp
      i--;
      continue; //skipping unused processes
    }

    strncpy(table[i].name, p->name, STRMAX);
    table[i].pid = p->pid;
80104248:	89 07                	mov    %eax,(%edi)
    table[i].ppid = (p->parent ? p->parent->pid : p->pid);
8010424a:	8b 43 14             	mov    0x14(%ebx),%eax
8010424d:	85 c0                	test   %eax,%eax
8010424f:	74 7f                	je     801042d0 <getprocs+0x100>
80104251:	8b 40 10             	mov    0x10(%eax),%eax
80104254:	89 47 0c             	mov    %eax,0xc(%edi)
    table[i].priority = p->priority;
80104257:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010425a:	89 47 14             	mov    %eax,0x14(%edi)

    //both p->name and state < STRMAX
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010425d:	8b 4b 0c             	mov    0xc(%ebx),%ecx
      state = states[p->state];
    else
      state = "???";
80104260:	b8 b0 77 10 80       	mov    $0x801077b0,%eax
    table[i].pid = p->pid;
    table[i].ppid = (p->parent ? p->parent->pid : p->pid);
    table[i].priority = p->priority;

    //both p->name and state < STRMAX
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104265:	83 f9 05             	cmp    $0x5,%ecx
80104268:	77 11                	ja     8010427b <getprocs+0xab>
8010426a:	8b 04 8d 34 78 10 80 	mov    -0x7fef87cc(,%ecx,4),%eax
      state = states[p->state];
    else
      state = "???";
80104271:	b9 b0 77 10 80       	mov    $0x801077b0,%ecx
80104276:	85 c0                	test   %eax,%eax
80104278:	0f 44 c1             	cmove  %ecx,%eax
    
    strncpy(table[i].state, state, STRMAX);
8010427b:	83 ec 04             	sub    $0x4,%esp
8010427e:	6a 20                	push   $0x20
80104280:	50                   	push   %eax
80104281:	8d 47 24             	lea    0x24(%edi),%eax
80104284:	50                   	push   %eax
80104285:	e8 e6 05 00 00       	call   80104870 <strncpy>
    table[i].elapsed_ticks = ticks - p->start_ticks;
8010428a:	a1 00 5a 11 80       	mov    0x80115a00,%eax
8010428f:	2b 83 80 00 00 00    	sub    0x80(%ebx),%eax
    table[i].total_ticks = p->cpu_ticks_total;
    table[i].size = p->sz;
80104295:	83 c4 10             	add    $0x10,%esp
      state = states[p->state];
    else
      state = "???";
    
    strncpy(table[i].state, state, STRMAX);
    table[i].elapsed_ticks = ticks - p->start_ticks;
80104298:	89 47 18             	mov    %eax,0x18(%edi)
    table[i].total_ticks = p->cpu_ticks_total;
8010429b:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
801042a1:	89 47 1c             	mov    %eax,0x1c(%edi)
    table[i].size = p->sz;
801042a4:	8b 03                	mov    (%ebx),%eax
801042a6:	89 47 10             	mov    %eax,0x10(%edi)
801042a9:	e9 55 ff ff ff       	jmp    80104203 <getprocs+0x33>
      [ZOMBIE] "Zombie"
  };
  
  acquire(&ptable.lock);
  p = ptable.proc;
  for (; p < &ptable.proc[NPROC] && i < max; i++, p++) {
801042ae:	31 f6                	xor    %esi,%esi
    table[i].elapsed_ticks = ticks - p->start_ticks;
    table[i].total_ticks = p->cpu_ticks_total;
    table[i].size = p->sz;
    //table[i].age = ticks - p->cpu_in_time;
  }
  release(&ptable.lock);
801042b0:	83 ec 0c             	sub    $0xc,%esp
801042b3:	68 80 2d 11 80       	push   $0x80112d80
801042b8:	e8 e3 03 00 00       	call   801046a0 <release>

  //return number of elements filled
  return i;
}
801042bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042c0:	89 f0                	mov    %esi,%eax
801042c2:	5b                   	pop    %ebx
801042c3:	5e                   	pop    %esi
801042c4:	5f                   	pop    %edi
801042c5:	5d                   	pop    %ebp
801042c6:	c3                   	ret    
801042c7:	89 f6                	mov    %esi,%esi
801042c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      continue; //skipping unused processes
    }

    strncpy(table[i].name, p->name, STRMAX);
    table[i].pid = p->pid;
    table[i].ppid = (p->parent ? p->parent->pid : p->pid);
801042d0:	8b 43 10             	mov    0x10(%ebx),%eax
801042d3:	e9 7c ff ff ff       	jmp    80104254 <getprocs+0x84>
801042d8:	90                   	nop
801042d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801042e0 <setpriority>:
  return rc;
}
# else
int 
setpriority(int pid, int priority)
{
801042e0:	55                   	push   %ebp
801042e1:	89 e5                	mov    %esp,%ebp
801042e3:	56                   	push   %esi
801042e4:	53                   	push   %ebx
801042e5:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801042e8:	8b 75 08             	mov    0x8(%ebp),%esi
  int rc = -1;
  struct proc *p;

  if (priority < 0 || priority > MAX)
801042eb:	83 fb 64             	cmp    $0x64,%ebx
801042ee:	77 67                	ja     80104357 <setpriority+0x77>
   return -1;
  
  acquire(&ptable.lock);
801042f0:	83 ec 0c             	sub    $0xc,%esp
801042f3:	68 80 2d 11 80       	push   $0x80112d80
801042f8:	e8 f3 02 00 00       	call   801045f0 <acquire>
  p = ptable.proc;
  for (; p - &ptable.proc[NPROC] < 0;) {
    if (p->pid - pid == 0) {
801042fd:	83 c4 10             	add    $0x10,%esp
80104300:	3b 35 c4 2d 11 80    	cmp    0x80112dc4,%esi

  if (priority < 0 || priority > MAX)
   return -1;
  
  acquire(&ptable.lock);
  p = ptable.proc;
80104306:	b8 b4 2d 11 80       	mov    $0x80112db4,%eax
  for (; p - &ptable.proc[NPROC] < 0;) {
    if (p->pid - pid == 0) {
8010430b:	75 08                	jne    80104315 <setpriority+0x35>
8010430d:	eb 41                	jmp    80104350 <setpriority+0x70>
8010430f:	90                   	nop
80104310:	39 70 10             	cmp    %esi,0x10(%eax)
80104313:	74 3b                	je     80104350 <setpriority+0x70>
      p->priority = priority;
      rc = 0;
      break;
    }
    p++;
80104315:	05 90 00 00 00       	add    $0x90,%eax
  if (priority < 0 || priority > MAX)
   return -1;
  
  acquire(&ptable.lock);
  p = ptable.proc;
  for (; p - &ptable.proc[NPROC] < 0;) {
8010431a:	89 c2                	mov    %eax,%edx
8010431c:	81 ea b4 51 11 80    	sub    $0x801151b4,%edx
80104322:	81 fa 71 ff ff ff    	cmp    $0xffffff71,%edx
80104328:	7c e6                	jl     80104310 <setpriority+0x30>
}
# else
int 
setpriority(int pid, int priority)
{
  int rc = -1;
8010432a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      rc = 0;
      break;
    }
    p++;
  }
  release(&ptable.lock);
8010432f:	83 ec 0c             	sub    $0xc,%esp
80104332:	68 80 2d 11 80       	push   $0x80112d80
80104337:	e8 64 03 00 00       	call   801046a0 <release>
  return rc;
8010433c:	83 c4 10             	add    $0x10,%esp
}
8010433f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104342:	89 d8                	mov    %ebx,%eax
80104344:	5b                   	pop    %ebx
80104345:	5e                   	pop    %esi
80104346:	5d                   	pop    %ebp
80104347:	c3                   	ret    
80104348:	90                   	nop
80104349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  
  acquire(&ptable.lock);
  p = ptable.proc;
  for (; p - &ptable.proc[NPROC] < 0;) {
    if (p->pid - pid == 0) {
      p->priority = priority;
80104350:	89 58 7c             	mov    %ebx,0x7c(%eax)
      rc = 0;
80104353:	31 db                	xor    %ebx,%ebx
      break;
80104355:	eb d8                	jmp    8010432f <setpriority+0x4f>
{
  int rc = -1;
  struct proc *p;

  if (priority < 0 || priority > MAX)
   return -1;
80104357:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010435c:	eb e1                	jmp    8010433f <setpriority+0x5f>
8010435e:	66 90                	xchg   %ax,%ax

80104360 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104360:	55                   	push   %ebp
80104361:	89 e5                	mov    %esp,%ebp
80104363:	53                   	push   %ebx
80104364:	83 ec 0c             	sub    $0xc,%esp
80104367:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010436a:	68 64 78 10 80       	push   $0x80107864
8010436f:	8d 43 04             	lea    0x4(%ebx),%eax
80104372:	50                   	push   %eax
80104373:	e8 18 01 00 00       	call   80104490 <initlock>
  lk->name = name;
80104378:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010437b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104381:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
80104384:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
8010438b:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
8010438e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104391:	c9                   	leave  
80104392:	c3                   	ret    
80104393:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801043a0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	56                   	push   %esi
801043a4:	53                   	push   %ebx
801043a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801043a8:	83 ec 0c             	sub    $0xc,%esp
801043ab:	8d 73 04             	lea    0x4(%ebx),%esi
801043ae:	56                   	push   %esi
801043af:	e8 3c 02 00 00       	call   801045f0 <acquire>
  while (lk->locked) {
801043b4:	8b 13                	mov    (%ebx),%edx
801043b6:	83 c4 10             	add    $0x10,%esp
801043b9:	85 d2                	test   %edx,%edx
801043bb:	74 16                	je     801043d3 <acquiresleep+0x33>
801043bd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801043c0:	83 ec 08             	sub    $0x8,%esp
801043c3:	56                   	push   %esi
801043c4:	53                   	push   %ebx
801043c5:	e8 56 fa ff ff       	call   80103e20 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
801043ca:	8b 03                	mov    (%ebx),%eax
801043cc:	83 c4 10             	add    $0x10,%esp
801043cf:	85 c0                	test   %eax,%eax
801043d1:	75 ed                	jne    801043c0 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
801043d3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801043d9:	e8 e2 f3 ff ff       	call   801037c0 <myproc>
801043de:	8b 40 10             	mov    0x10(%eax),%eax
801043e1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801043e4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801043e7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043ea:	5b                   	pop    %ebx
801043eb:	5e                   	pop    %esi
801043ec:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
801043ed:	e9 ae 02 00 00       	jmp    801046a0 <release>
801043f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104400 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	56                   	push   %esi
80104404:	53                   	push   %ebx
80104405:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104408:	83 ec 0c             	sub    $0xc,%esp
8010440b:	8d 73 04             	lea    0x4(%ebx),%esi
8010440e:	56                   	push   %esi
8010440f:	e8 dc 01 00 00       	call   801045f0 <acquire>
  lk->locked = 0;
80104414:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010441a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104421:	89 1c 24             	mov    %ebx,(%esp)
80104424:	e8 b7 fb ff ff       	call   80103fe0 <wakeup>
  release(&lk->lk);
80104429:	89 75 08             	mov    %esi,0x8(%ebp)
8010442c:	83 c4 10             	add    $0x10,%esp
}
8010442f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104432:	5b                   	pop    %ebx
80104433:	5e                   	pop    %esi
80104434:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80104435:	e9 66 02 00 00       	jmp    801046a0 <release>
8010443a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104440 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	57                   	push   %edi
80104444:	56                   	push   %esi
80104445:	53                   	push   %ebx
80104446:	31 ff                	xor    %edi,%edi
80104448:	83 ec 18             	sub    $0x18,%esp
8010444b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010444e:	8d 73 04             	lea    0x4(%ebx),%esi
80104451:	56                   	push   %esi
80104452:	e8 99 01 00 00       	call   801045f0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104457:	8b 03                	mov    (%ebx),%eax
80104459:	83 c4 10             	add    $0x10,%esp
8010445c:	85 c0                	test   %eax,%eax
8010445e:	74 13                	je     80104473 <holdingsleep+0x33>
80104460:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104463:	e8 58 f3 ff ff       	call   801037c0 <myproc>
80104468:	39 58 10             	cmp    %ebx,0x10(%eax)
8010446b:	0f 94 c0             	sete   %al
8010446e:	0f b6 c0             	movzbl %al,%eax
80104471:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104473:	83 ec 0c             	sub    $0xc,%esp
80104476:	56                   	push   %esi
80104477:	e8 24 02 00 00       	call   801046a0 <release>
  return r;
}
8010447c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010447f:	89 f8                	mov    %edi,%eax
80104481:	5b                   	pop    %ebx
80104482:	5e                   	pop    %esi
80104483:	5f                   	pop    %edi
80104484:	5d                   	pop    %ebp
80104485:	c3                   	ret    
80104486:	66 90                	xchg   %ax,%ax
80104488:	66 90                	xchg   %ax,%ax
8010448a:	66 90                	xchg   %ax,%ax
8010448c:	66 90                	xchg   %ax,%ax
8010448e:	66 90                	xchg   %ax,%ax

80104490 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104496:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104499:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
8010449f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
801044a2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801044a9:	5d                   	pop    %ebp
801044aa:	c3                   	ret    
801044ab:	90                   	nop
801044ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801044b0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801044b0:	55                   	push   %ebp
801044b1:	89 e5                	mov    %esp,%ebp
801044b3:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801044b4:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801044b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801044ba:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
801044bd:	31 c0                	xor    %eax,%eax
801044bf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801044c0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801044c6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801044cc:	77 1a                	ja     801044e8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801044ce:	8b 5a 04             	mov    0x4(%edx),%ebx
801044d1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801044d4:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
801044d7:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801044d9:	83 f8 0a             	cmp    $0xa,%eax
801044dc:	75 e2                	jne    801044c0 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801044de:	5b                   	pop    %ebx
801044df:	5d                   	pop    %ebp
801044e0:	c3                   	ret    
801044e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
801044e8:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801044ef:	83 c0 01             	add    $0x1,%eax
801044f2:	83 f8 0a             	cmp    $0xa,%eax
801044f5:	74 e7                	je     801044de <getcallerpcs+0x2e>
    pcs[i] = 0;
801044f7:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801044fe:	83 c0 01             	add    $0x1,%eax
80104501:	83 f8 0a             	cmp    $0xa,%eax
80104504:	75 e2                	jne    801044e8 <getcallerpcs+0x38>
80104506:	eb d6                	jmp    801044de <getcallerpcs+0x2e>
80104508:	90                   	nop
80104509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104510 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104510:	55                   	push   %ebp
80104511:	89 e5                	mov    %esp,%ebp
80104513:	53                   	push   %ebx
80104514:	83 ec 04             	sub    $0x4,%esp
80104517:	9c                   	pushf  
80104518:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104519:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010451a:	e8 01 f2 ff ff       	call   80103720 <mycpu>
8010451f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104525:	85 c0                	test   %eax,%eax
80104527:	75 11                	jne    8010453a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104529:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010452f:	e8 ec f1 ff ff       	call   80103720 <mycpu>
80104534:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010453a:	e8 e1 f1 ff ff       	call   80103720 <mycpu>
8010453f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104546:	83 c4 04             	add    $0x4,%esp
80104549:	5b                   	pop    %ebx
8010454a:	5d                   	pop    %ebp
8010454b:	c3                   	ret    
8010454c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104550 <popcli>:

void
popcli(void)
{
80104550:	55                   	push   %ebp
80104551:	89 e5                	mov    %esp,%ebp
80104553:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104556:	9c                   	pushf  
80104557:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104558:	f6 c4 02             	test   $0x2,%ah
8010455b:	75 52                	jne    801045af <popcli+0x5f>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010455d:	e8 be f1 ff ff       	call   80103720 <mycpu>
80104562:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80104568:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010456b:	85 d2                	test   %edx,%edx
8010456d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80104573:	78 2d                	js     801045a2 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104575:	e8 a6 f1 ff ff       	call   80103720 <mycpu>
8010457a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104580:	85 d2                	test   %edx,%edx
80104582:	74 0c                	je     80104590 <popcli+0x40>
    sti();
}
80104584:	c9                   	leave  
80104585:	c3                   	ret    
80104586:	8d 76 00             	lea    0x0(%esi),%esi
80104589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104590:	e8 8b f1 ff ff       	call   80103720 <mycpu>
80104595:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010459b:	85 c0                	test   %eax,%eax
8010459d:	74 e5                	je     80104584 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
8010459f:	fb                   	sti    
    sti();
}
801045a0:	c9                   	leave  
801045a1:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
801045a2:	83 ec 0c             	sub    $0xc,%esp
801045a5:	68 86 78 10 80       	push   $0x80107886
801045aa:	e8 c1 bd ff ff       	call   80100370 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
801045af:	83 ec 0c             	sub    $0xc,%esp
801045b2:	68 6f 78 10 80       	push   $0x8010786f
801045b7:	e8 b4 bd ff ff       	call   80100370 <panic>
801045bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801045c0 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	56                   	push   %esi
801045c4:	53                   	push   %ebx
801045c5:	8b 75 08             	mov    0x8(%ebp),%esi
801045c8:	31 db                	xor    %ebx,%ebx
  int r;
  pushcli();
801045ca:	e8 41 ff ff ff       	call   80104510 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801045cf:	8b 06                	mov    (%esi),%eax
801045d1:	85 c0                	test   %eax,%eax
801045d3:	74 10                	je     801045e5 <holding+0x25>
801045d5:	8b 5e 08             	mov    0x8(%esi),%ebx
801045d8:	e8 43 f1 ff ff       	call   80103720 <mycpu>
801045dd:	39 c3                	cmp    %eax,%ebx
801045df:	0f 94 c3             	sete   %bl
801045e2:	0f b6 db             	movzbl %bl,%ebx
  popcli();
801045e5:	e8 66 ff ff ff       	call   80104550 <popcli>
  return r;
}
801045ea:	89 d8                	mov    %ebx,%eax
801045ec:	5b                   	pop    %ebx
801045ed:	5e                   	pop    %esi
801045ee:	5d                   	pop    %ebp
801045ef:	c3                   	ret    

801045f0 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
801045f0:	55                   	push   %ebp
801045f1:	89 e5                	mov    %esp,%ebp
801045f3:	56                   	push   %esi
801045f4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
801045f5:	e8 16 ff ff ff       	call   80104510 <pushcli>
  if(holding(lk))
801045fa:	8b 75 08             	mov    0x8(%ebp),%esi
801045fd:	83 ec 0c             	sub    $0xc,%esp
80104600:	56                   	push   %esi
80104601:	e8 ba ff ff ff       	call   801045c0 <holding>
80104606:	83 c4 10             	add    $0x10,%esp
80104609:	85 c0                	test   %eax,%eax
8010460b:	0f 85 7f 00 00 00    	jne    80104690 <acquire+0xa0>
80104611:	89 c3                	mov    %eax,%ebx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104613:	ba 01 00 00 00       	mov    $0x1,%edx
80104618:	eb 09                	jmp    80104623 <acquire+0x33>
8010461a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104620:	8b 75 08             	mov    0x8(%ebp),%esi
80104623:	89 d0                	mov    %edx,%eax
80104625:	f0 87 06             	lock xchg %eax,(%esi)
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80104628:	85 c0                	test   %eax,%eax
8010462a:	75 f4                	jne    80104620 <acquire+0x30>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
8010462c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80104631:	8b 75 08             	mov    0x8(%ebp),%esi
80104634:	e8 e7 f0 ff ff       	call   80103720 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104639:	8d 56 0c             	lea    0xc(%esi),%edx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
8010463c:	89 46 08             	mov    %eax,0x8(%esi)
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010463f:	89 e8                	mov    %ebp,%eax
80104641:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104648:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010464e:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104654:	77 1a                	ja     80104670 <acquire+0x80>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104656:	8b 48 04             	mov    0x4(%eax),%ecx
80104659:	89 0c 9a             	mov    %ecx,(%edx,%ebx,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
8010465c:	83 c3 01             	add    $0x1,%ebx
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
8010465f:	8b 00                	mov    (%eax),%eax
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104661:	83 fb 0a             	cmp    $0xa,%ebx
80104664:	75 e2                	jne    80104648 <acquire+0x58>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
80104666:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104669:	5b                   	pop    %ebx
8010466a:	5e                   	pop    %esi
8010466b:	5d                   	pop    %ebp
8010466c:	c3                   	ret    
8010466d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104670:	c7 04 9a 00 00 00 00 	movl   $0x0,(%edx,%ebx,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104677:	83 c3 01             	add    $0x1,%ebx
8010467a:	83 fb 0a             	cmp    $0xa,%ebx
8010467d:	74 e7                	je     80104666 <acquire+0x76>
    pcs[i] = 0;
8010467f:	c7 04 9a 00 00 00 00 	movl   $0x0,(%edx,%ebx,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104686:	83 c3 01             	add    $0x1,%ebx
80104689:	83 fb 0a             	cmp    $0xa,%ebx
8010468c:	75 e2                	jne    80104670 <acquire+0x80>
8010468e:	eb d6                	jmp    80104666 <acquire+0x76>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80104690:	83 ec 0c             	sub    $0xc,%esp
80104693:	68 8d 78 10 80       	push   $0x8010788d
80104698:	e8 d3 bc ff ff       	call   80100370 <panic>
8010469d:	8d 76 00             	lea    0x0(%esi),%esi

801046a0 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
801046a3:	53                   	push   %ebx
801046a4:	83 ec 10             	sub    $0x10,%esp
801046a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
801046aa:	53                   	push   %ebx
801046ab:	e8 10 ff ff ff       	call   801045c0 <holding>
801046b0:	83 c4 10             	add    $0x10,%esp
801046b3:	85 c0                	test   %eax,%eax
801046b5:	74 22                	je     801046d9 <release+0x39>
    panic("release");

  lk->pcs[0] = 0;
801046b7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801046be:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
801046c5:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801046ca:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
801046d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046d3:	c9                   	leave  
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
801046d4:	e9 77 fe ff ff       	jmp    80104550 <popcli>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
801046d9:	83 ec 0c             	sub    $0xc,%esp
801046dc:	68 95 78 10 80       	push   $0x80107895
801046e1:	e8 8a bc ff ff       	call   80100370 <panic>
801046e6:	66 90                	xchg   %ax,%ax
801046e8:	66 90                	xchg   %ax,%ax
801046ea:	66 90                	xchg   %ax,%ax
801046ec:	66 90                	xchg   %ax,%ax
801046ee:	66 90                	xchg   %ax,%ax

801046f0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
801046f3:	57                   	push   %edi
801046f4:	53                   	push   %ebx
801046f5:	8b 55 08             	mov    0x8(%ebp),%edx
801046f8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801046fb:	f6 c2 03             	test   $0x3,%dl
801046fe:	75 05                	jne    80104705 <memset+0x15>
80104700:	f6 c1 03             	test   $0x3,%cl
80104703:	74 13                	je     80104718 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80104705:	89 d7                	mov    %edx,%edi
80104707:	8b 45 0c             	mov    0xc(%ebp),%eax
8010470a:	fc                   	cld    
8010470b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010470d:	5b                   	pop    %ebx
8010470e:	89 d0                	mov    %edx,%eax
80104710:	5f                   	pop    %edi
80104711:	5d                   	pop    %ebp
80104712:	c3                   	ret    
80104713:	90                   	nop
80104714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80104718:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010471c:	c1 e9 02             	shr    $0x2,%ecx
8010471f:	89 f8                	mov    %edi,%eax
80104721:	89 fb                	mov    %edi,%ebx
80104723:	c1 e0 18             	shl    $0x18,%eax
80104726:	c1 e3 10             	shl    $0x10,%ebx
80104729:	09 d8                	or     %ebx,%eax
8010472b:	09 f8                	or     %edi,%eax
8010472d:	c1 e7 08             	shl    $0x8,%edi
80104730:	09 f8                	or     %edi,%eax
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
80104732:	89 d7                	mov    %edx,%edi
80104734:	fc                   	cld    
80104735:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104737:	5b                   	pop    %ebx
80104738:	89 d0                	mov    %edx,%eax
8010473a:	5f                   	pop    %edi
8010473b:	5d                   	pop    %ebp
8010473c:	c3                   	ret    
8010473d:	8d 76 00             	lea    0x0(%esi),%esi

80104740 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	57                   	push   %edi
80104744:	56                   	push   %esi
80104745:	53                   	push   %ebx
80104746:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104749:	8b 75 08             	mov    0x8(%ebp),%esi
8010474c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010474f:	85 db                	test   %ebx,%ebx
80104751:	74 29                	je     8010477c <memcmp+0x3c>
    if(*s1 != *s2)
80104753:	0f b6 16             	movzbl (%esi),%edx
80104756:	0f b6 0f             	movzbl (%edi),%ecx
80104759:	38 d1                	cmp    %dl,%cl
8010475b:	75 2b                	jne    80104788 <memcmp+0x48>
8010475d:	b8 01 00 00 00       	mov    $0x1,%eax
80104762:	eb 14                	jmp    80104778 <memcmp+0x38>
80104764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104768:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
8010476c:	83 c0 01             	add    $0x1,%eax
8010476f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104774:	38 ca                	cmp    %cl,%dl
80104776:	75 10                	jne    80104788 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104778:	39 d8                	cmp    %ebx,%eax
8010477a:	75 ec                	jne    80104768 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010477c:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010477d:	31 c0                	xor    %eax,%eax
}
8010477f:	5e                   	pop    %esi
80104780:	5f                   	pop    %edi
80104781:	5d                   	pop    %ebp
80104782:	c3                   	ret    
80104783:	90                   	nop
80104784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104788:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
8010478b:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
8010478c:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
8010478e:	5e                   	pop    %esi
8010478f:	5f                   	pop    %edi
80104790:	5d                   	pop    %ebp
80104791:	c3                   	ret    
80104792:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047a0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	56                   	push   %esi
801047a4:	53                   	push   %ebx
801047a5:	8b 45 08             	mov    0x8(%ebp),%eax
801047a8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801047ab:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801047ae:	39 c3                	cmp    %eax,%ebx
801047b0:	73 26                	jae    801047d8 <memmove+0x38>
801047b2:	8d 14 33             	lea    (%ebx,%esi,1),%edx
801047b5:	39 d0                	cmp    %edx,%eax
801047b7:	73 1f                	jae    801047d8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
801047b9:	85 f6                	test   %esi,%esi
801047bb:	8d 56 ff             	lea    -0x1(%esi),%edx
801047be:	74 0f                	je     801047cf <memmove+0x2f>
      *--d = *--s;
801047c0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801047c4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801047c7:	83 ea 01             	sub    $0x1,%edx
801047ca:	83 fa ff             	cmp    $0xffffffff,%edx
801047cd:	75 f1                	jne    801047c0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801047cf:	5b                   	pop    %ebx
801047d0:	5e                   	pop    %esi
801047d1:	5d                   	pop    %ebp
801047d2:	c3                   	ret    
801047d3:	90                   	nop
801047d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801047d8:	31 d2                	xor    %edx,%edx
801047da:	85 f6                	test   %esi,%esi
801047dc:	74 f1                	je     801047cf <memmove+0x2f>
801047de:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
801047e0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801047e4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801047e7:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801047ea:	39 f2                	cmp    %esi,%edx
801047ec:	75 f2                	jne    801047e0 <memmove+0x40>
      *d++ = *s++;

  return dst;
}
801047ee:	5b                   	pop    %ebx
801047ef:	5e                   	pop    %esi
801047f0:	5d                   	pop    %ebp
801047f1:	c3                   	ret    
801047f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104800 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104800:	55                   	push   %ebp
80104801:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104803:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104804:	eb 9a                	jmp    801047a0 <memmove>
80104806:	8d 76 00             	lea    0x0(%esi),%esi
80104809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104810 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104810:	55                   	push   %ebp
80104811:	89 e5                	mov    %esp,%ebp
80104813:	57                   	push   %edi
80104814:	56                   	push   %esi
80104815:	8b 7d 10             	mov    0x10(%ebp),%edi
80104818:	53                   	push   %ebx
80104819:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010481c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010481f:	85 ff                	test   %edi,%edi
80104821:	74 2f                	je     80104852 <strncmp+0x42>
80104823:	0f b6 11             	movzbl (%ecx),%edx
80104826:	0f b6 1e             	movzbl (%esi),%ebx
80104829:	84 d2                	test   %dl,%dl
8010482b:	74 37                	je     80104864 <strncmp+0x54>
8010482d:	38 d3                	cmp    %dl,%bl
8010482f:	75 33                	jne    80104864 <strncmp+0x54>
80104831:	01 f7                	add    %esi,%edi
80104833:	eb 13                	jmp    80104848 <strncmp+0x38>
80104835:	8d 76 00             	lea    0x0(%esi),%esi
80104838:	0f b6 11             	movzbl (%ecx),%edx
8010483b:	84 d2                	test   %dl,%dl
8010483d:	74 21                	je     80104860 <strncmp+0x50>
8010483f:	0f b6 18             	movzbl (%eax),%ebx
80104842:	89 c6                	mov    %eax,%esi
80104844:	38 da                	cmp    %bl,%dl
80104846:	75 1c                	jne    80104864 <strncmp+0x54>
    n--, p++, q++;
80104848:	8d 46 01             	lea    0x1(%esi),%eax
8010484b:	83 c1 01             	add    $0x1,%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
8010484e:	39 f8                	cmp    %edi,%eax
80104850:	75 e6                	jne    80104838 <strncmp+0x28>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104852:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
80104853:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
80104855:	5e                   	pop    %esi
80104856:	5f                   	pop    %edi
80104857:	5d                   	pop    %ebp
80104858:	c3                   	ret    
80104859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104860:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104864:	0f b6 c2             	movzbl %dl,%eax
80104867:	29 d8                	sub    %ebx,%eax
}
80104869:	5b                   	pop    %ebx
8010486a:	5e                   	pop    %esi
8010486b:	5f                   	pop    %edi
8010486c:	5d                   	pop    %ebp
8010486d:	c3                   	ret    
8010486e:	66 90                	xchg   %ax,%ax

80104870 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	56                   	push   %esi
80104874:	53                   	push   %ebx
80104875:	8b 45 08             	mov    0x8(%ebp),%eax
80104878:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010487b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010487e:	89 c2                	mov    %eax,%edx
80104880:	eb 19                	jmp    8010489b <strncpy+0x2b>
80104882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104888:	83 c3 01             	add    $0x1,%ebx
8010488b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010488f:	83 c2 01             	add    $0x1,%edx
80104892:	84 c9                	test   %cl,%cl
80104894:	88 4a ff             	mov    %cl,-0x1(%edx)
80104897:	74 09                	je     801048a2 <strncpy+0x32>
80104899:	89 f1                	mov    %esi,%ecx
8010489b:	85 c9                	test   %ecx,%ecx
8010489d:	8d 71 ff             	lea    -0x1(%ecx),%esi
801048a0:	7f e6                	jg     80104888 <strncpy+0x18>
    ;
  while(n-- > 0)
801048a2:	31 c9                	xor    %ecx,%ecx
801048a4:	85 f6                	test   %esi,%esi
801048a6:	7e 17                	jle    801048bf <strncpy+0x4f>
801048a8:	90                   	nop
801048a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
801048b0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
801048b4:	89 f3                	mov    %esi,%ebx
801048b6:	83 c1 01             	add    $0x1,%ecx
801048b9:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
801048bb:	85 db                	test   %ebx,%ebx
801048bd:	7f f1                	jg     801048b0 <strncpy+0x40>
    *s++ = 0;
  return os;
}
801048bf:	5b                   	pop    %ebx
801048c0:	5e                   	pop    %esi
801048c1:	5d                   	pop    %ebp
801048c2:	c3                   	ret    
801048c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048d0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	56                   	push   %esi
801048d4:	53                   	push   %ebx
801048d5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801048d8:	8b 45 08             	mov    0x8(%ebp),%eax
801048db:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
801048de:	85 c9                	test   %ecx,%ecx
801048e0:	7e 26                	jle    80104908 <safestrcpy+0x38>
801048e2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801048e6:	89 c1                	mov    %eax,%ecx
801048e8:	eb 17                	jmp    80104901 <safestrcpy+0x31>
801048ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801048f0:	83 c2 01             	add    $0x1,%edx
801048f3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801048f7:	83 c1 01             	add    $0x1,%ecx
801048fa:	84 db                	test   %bl,%bl
801048fc:	88 59 ff             	mov    %bl,-0x1(%ecx)
801048ff:	74 04                	je     80104905 <safestrcpy+0x35>
80104901:	39 f2                	cmp    %esi,%edx
80104903:	75 eb                	jne    801048f0 <safestrcpy+0x20>
    ;
  *s = 0;
80104905:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104908:	5b                   	pop    %ebx
80104909:	5e                   	pop    %esi
8010490a:	5d                   	pop    %ebp
8010490b:	c3                   	ret    
8010490c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104910 <strlen>:

int
strlen(const char *s)
{
80104910:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104911:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80104913:	89 e5                	mov    %esp,%ebp
80104915:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80104918:	80 3a 00             	cmpb   $0x0,(%edx)
8010491b:	74 0c                	je     80104929 <strlen+0x19>
8010491d:	8d 76 00             	lea    0x0(%esi),%esi
80104920:	83 c0 01             	add    $0x1,%eax
80104923:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104927:	75 f7                	jne    80104920 <strlen+0x10>
    ;
  return n;
}
80104929:	5d                   	pop    %ebp
8010492a:	c3                   	ret    

8010492b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010492b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010492f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104933:	55                   	push   %ebp
  pushl %ebx
80104934:	53                   	push   %ebx
  pushl %esi
80104935:	56                   	push   %esi
  pushl %edi
80104936:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104937:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104939:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010493b:	5f                   	pop    %edi
  popl %esi
8010493c:	5e                   	pop    %esi
  popl %ebx
8010493d:	5b                   	pop    %ebx
  popl %ebp
8010493e:	5d                   	pop    %ebp
  ret
8010493f:	c3                   	ret    

80104940 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104940:	55                   	push   %ebp
80104941:	89 e5                	mov    %esp,%ebp
80104943:	53                   	push   %ebx
80104944:	83 ec 04             	sub    $0x4,%esp
80104947:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010494a:	e8 71 ee ff ff       	call   801037c0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010494f:	8b 00                	mov    (%eax),%eax
80104951:	39 d8                	cmp    %ebx,%eax
80104953:	76 1b                	jbe    80104970 <fetchint+0x30>
80104955:	8d 53 04             	lea    0x4(%ebx),%edx
80104958:	39 d0                	cmp    %edx,%eax
8010495a:	72 14                	jb     80104970 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010495c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010495f:	8b 13                	mov    (%ebx),%edx
80104961:	89 10                	mov    %edx,(%eax)
  return 0;
80104963:	31 c0                	xor    %eax,%eax
}
80104965:	83 c4 04             	add    $0x4,%esp
80104968:	5b                   	pop    %ebx
80104969:	5d                   	pop    %ebp
8010496a:	c3                   	ret    
8010496b:	90                   	nop
8010496c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104970:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104975:	eb ee                	jmp    80104965 <fetchint+0x25>
80104977:	89 f6                	mov    %esi,%esi
80104979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104980 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104980:	55                   	push   %ebp
80104981:	89 e5                	mov    %esp,%ebp
80104983:	53                   	push   %ebx
80104984:	83 ec 04             	sub    $0x4,%esp
80104987:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010498a:	e8 31 ee ff ff       	call   801037c0 <myproc>

  if(addr >= curproc->sz)
8010498f:	39 18                	cmp    %ebx,(%eax)
80104991:	76 29                	jbe    801049bc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104993:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104996:	89 da                	mov    %ebx,%edx
80104998:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010499a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010499c:	39 c3                	cmp    %eax,%ebx
8010499e:	73 1c                	jae    801049bc <fetchstr+0x3c>
    if(*s == 0)
801049a0:	80 3b 00             	cmpb   $0x0,(%ebx)
801049a3:	75 10                	jne    801049b5 <fetchstr+0x35>
801049a5:	eb 29                	jmp    801049d0 <fetchstr+0x50>
801049a7:	89 f6                	mov    %esi,%esi
801049a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801049b0:	80 3a 00             	cmpb   $0x0,(%edx)
801049b3:	74 1b                	je     801049d0 <fetchstr+0x50>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
801049b5:	83 c2 01             	add    $0x1,%edx
801049b8:	39 d0                	cmp    %edx,%eax
801049ba:	77 f4                	ja     801049b0 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
801049bc:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
801049bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
801049c4:	5b                   	pop    %ebx
801049c5:	5d                   	pop    %ebp
801049c6:	c3                   	ret    
801049c7:	89 f6                	mov    %esi,%esi
801049c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801049d0:	83 c4 04             	add    $0x4,%esp
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
801049d3:	89 d0                	mov    %edx,%eax
801049d5:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
801049d7:	5b                   	pop    %ebx
801049d8:	5d                   	pop    %ebp
801049d9:	c3                   	ret    
801049da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049e0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801049e0:	55                   	push   %ebp
801049e1:	89 e5                	mov    %esp,%ebp
801049e3:	56                   	push   %esi
801049e4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801049e5:	e8 d6 ed ff ff       	call   801037c0 <myproc>
801049ea:	8b 40 18             	mov    0x18(%eax),%eax
801049ed:	8b 55 08             	mov    0x8(%ebp),%edx
801049f0:	8b 40 44             	mov    0x44(%eax),%eax
801049f3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
801049f6:	e8 c5 ed ff ff       	call   801037c0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801049fb:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801049fd:	8d 73 04             	lea    0x4(%ebx),%esi
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104a00:	39 c6                	cmp    %eax,%esi
80104a02:	73 1c                	jae    80104a20 <argint+0x40>
80104a04:	8d 53 08             	lea    0x8(%ebx),%edx
80104a07:	39 d0                	cmp    %edx,%eax
80104a09:	72 15                	jb     80104a20 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
80104a0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a0e:	8b 53 04             	mov    0x4(%ebx),%edx
80104a11:	89 10                	mov    %edx,(%eax)
  return 0;
80104a13:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
80104a15:	5b                   	pop    %ebx
80104a16:	5e                   	pop    %esi
80104a17:	5d                   	pop    %ebp
80104a18:	c3                   	ret    
80104a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104a20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a25:	eb ee                	jmp    80104a15 <argint+0x35>
80104a27:	89 f6                	mov    %esi,%esi
80104a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a30 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104a30:	55                   	push   %ebp
80104a31:	89 e5                	mov    %esp,%ebp
80104a33:	56                   	push   %esi
80104a34:	53                   	push   %ebx
80104a35:	83 ec 10             	sub    $0x10,%esp
80104a38:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104a3b:	e8 80 ed ff ff       	call   801037c0 <myproc>
80104a40:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104a42:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a45:	83 ec 08             	sub    $0x8,%esp
80104a48:	50                   	push   %eax
80104a49:	ff 75 08             	pushl  0x8(%ebp)
80104a4c:	e8 8f ff ff ff       	call   801049e0 <argint>
80104a51:	c1 e8 1f             	shr    $0x1f,%eax
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104a54:	83 c4 10             	add    $0x10,%esp
80104a57:	84 c0                	test   %al,%al
80104a59:	75 2d                	jne    80104a88 <argptr+0x58>
80104a5b:	89 d8                	mov    %ebx,%eax
80104a5d:	c1 e8 1f             	shr    $0x1f,%eax
80104a60:	84 c0                	test   %al,%al
80104a62:	75 24                	jne    80104a88 <argptr+0x58>
80104a64:	8b 16                	mov    (%esi),%edx
80104a66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a69:	39 c2                	cmp    %eax,%edx
80104a6b:	76 1b                	jbe    80104a88 <argptr+0x58>
80104a6d:	01 c3                	add    %eax,%ebx
80104a6f:	39 da                	cmp    %ebx,%edx
80104a71:	72 15                	jb     80104a88 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80104a73:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a76:	89 02                	mov    %eax,(%edx)
  return 0;
80104a78:	31 c0                	xor    %eax,%eax
}
80104a7a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a7d:	5b                   	pop    %ebx
80104a7e:	5e                   	pop    %esi
80104a7f:	5d                   	pop    %ebp
80104a80:	c3                   	ret    
80104a81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
80104a88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a8d:	eb eb                	jmp    80104a7a <argptr+0x4a>
80104a8f:	90                   	nop

80104a90 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104a90:	55                   	push   %ebp
80104a91:	89 e5                	mov    %esp,%ebp
80104a93:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104a96:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a99:	50                   	push   %eax
80104a9a:	ff 75 08             	pushl  0x8(%ebp)
80104a9d:	e8 3e ff ff ff       	call   801049e0 <argint>
80104aa2:	83 c4 10             	add    $0x10,%esp
80104aa5:	85 c0                	test   %eax,%eax
80104aa7:	78 17                	js     80104ac0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104aa9:	83 ec 08             	sub    $0x8,%esp
80104aac:	ff 75 0c             	pushl  0xc(%ebp)
80104aaf:	ff 75 f4             	pushl  -0xc(%ebp)
80104ab2:	e8 c9 fe ff ff       	call   80104980 <fetchstr>
80104ab7:	83 c4 10             	add    $0x10,%esp
}
80104aba:	c9                   	leave  
80104abb:	c3                   	ret    
80104abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104ac0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104ac5:	c9                   	leave  
80104ac6:	c3                   	ret    
80104ac7:	89 f6                	mov    %esi,%esi
80104ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ad0 <syscall>:
    [SYS_setpriority] "setpriority",
};
#endif 

void syscall(void)
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	57                   	push   %edi
80104ad4:	56                   	push   %esi
80104ad5:	53                   	push   %ebx
80104ad6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80104ad9:	e8 e2 ec ff ff       	call   801037c0 <myproc>
  int num = curproc->tf->eax;
80104ade:	8b 78 18             	mov    0x18(%eax),%edi
};
#endif 

void syscall(void)
{
  struct proc *curproc = myproc();
80104ae1:	89 c6                	mov    %eax,%esi
  int num = curproc->tf->eax;
80104ae3:	8b 5f 1c             	mov    0x1c(%edi),%ebx
  int max_el = NELEM(syscalls);
  if (num > 0 && num < max_el && syscalls[num])
80104ae6:	8d 43 ff             	lea    -0x1(%ebx),%eax
80104ae9:	83 f8 16             	cmp    $0x16,%eax
80104aec:	77 3a                	ja     80104b28 <syscall+0x58>
80104aee:	8b 04 9d 40 79 10 80 	mov    -0x7fef86c0(,%ebx,4),%eax
80104af5:	85 c0                	test   %eax,%eax
80104af7:	74 2f                	je     80104b28 <syscall+0x58>
  {
    curproc->tf->eax = syscalls[num]();
80104af9:	ff d0                	call   *%eax
80104afb:	89 47 1c             	mov    %eax,0x1c(%edi)
    #ifdef TRACE_SYSCALLS
      cprintf(" %s -> %d \n", syscalltrace[num], curproc->tf->eax);
80104afe:	8b 46 18             	mov    0x18(%esi),%eax
80104b01:	83 ec 04             	sub    $0x4,%esp
80104b04:	ff 70 1c             	pushl  0x1c(%eax)
80104b07:	ff 34 9d 20 a0 10 80 	pushl  -0x7fef5fe0(,%ebx,4)
80104b0e:	68 9d 78 10 80       	push   $0x8010789d
80104b13:	e8 48 bb ff ff       	call   80100660 <cprintf>
80104b18:	83 c4 10             	add    $0x10,%esp
  else
  {
    curproc->tf->eax = -1;
    cprintf("%d %s: Error: Unknown Syscall -> %d\n", curproc->pid, curproc->name, num);
  }
80104b1b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b1e:	5b                   	pop    %ebx
80104b1f:	5e                   	pop    %esi
80104b20:	5f                   	pop    %edi
80104b21:	5d                   	pop    %ebp
80104b22:	c3                   	ret    
80104b23:	90                   	nop
80104b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    #endif
  }
  else
  {
    curproc->tf->eax = -1;
    cprintf("%d %s: Error: Unknown Syscall -> %d\n", curproc->pid, curproc->name, num);
80104b28:	8d 46 6c             	lea    0x6c(%esi),%eax
      cprintf(" %s -> %d \n", syscalltrace[num], curproc->tf->eax);
    #endif
  }
  else
  {
    curproc->tf->eax = -1;
80104b2b:	c7 47 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%edi)
    cprintf("%d %s: Error: Unknown Syscall -> %d\n", curproc->pid, curproc->name, num);
80104b32:	53                   	push   %ebx
80104b33:	50                   	push   %eax
80104b34:	ff 76 10             	pushl  0x10(%esi)
80104b37:	68 0c 79 10 80       	push   $0x8010790c
80104b3c:	e8 1f bb ff ff       	call   80100660 <cprintf>
80104b41:	83 c4 10             	add    $0x10,%esp
  }
80104b44:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b47:	5b                   	pop    %ebx
80104b48:	5e                   	pop    %esi
80104b49:	5f                   	pop    %edi
80104b4a:	5d                   	pop    %ebp
80104b4b:	c3                   	ret    
80104b4c:	66 90                	xchg   %ax,%ax
80104b4e:	66 90                	xchg   %ax,%ax

80104b50 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104b50:	55                   	push   %ebp
80104b51:	89 e5                	mov    %esp,%ebp
80104b53:	57                   	push   %edi
80104b54:	56                   	push   %esi
80104b55:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104b56:	8d 5d da             	lea    -0x26(%ebp),%ebx
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104b59:	83 ec 44             	sub    $0x44,%esp
80104b5c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104b5f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104b62:	53                   	push   %ebx
80104b63:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104b64:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104b67:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104b6a:	e8 71 d3 ff ff       	call   80101ee0 <nameiparent>
80104b6f:	83 c4 10             	add    $0x10,%esp
80104b72:	85 c0                	test   %eax,%eax
80104b74:	0f 84 f6 00 00 00    	je     80104c70 <create+0x120>
    return 0;
  ilock(dp);
80104b7a:	83 ec 0c             	sub    $0xc,%esp
80104b7d:	89 c6                	mov    %eax,%esi
80104b7f:	50                   	push   %eax
80104b80:	e8 eb ca ff ff       	call   80101670 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104b85:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104b88:	83 c4 0c             	add    $0xc,%esp
80104b8b:	50                   	push   %eax
80104b8c:	53                   	push   %ebx
80104b8d:	56                   	push   %esi
80104b8e:	e8 0d d0 ff ff       	call   80101ba0 <dirlookup>
80104b93:	83 c4 10             	add    $0x10,%esp
80104b96:	85 c0                	test   %eax,%eax
80104b98:	89 c7                	mov    %eax,%edi
80104b9a:	74 54                	je     80104bf0 <create+0xa0>
    iunlockput(dp);
80104b9c:	83 ec 0c             	sub    $0xc,%esp
80104b9f:	56                   	push   %esi
80104ba0:	e8 5b cd ff ff       	call   80101900 <iunlockput>
    ilock(ip);
80104ba5:	89 3c 24             	mov    %edi,(%esp)
80104ba8:	e8 c3 ca ff ff       	call   80101670 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104bad:	83 c4 10             	add    $0x10,%esp
80104bb0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104bb5:	75 19                	jne    80104bd0 <create+0x80>
80104bb7:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104bbc:	75 12                	jne    80104bd0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104bbe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bc1:	89 f8                	mov    %edi,%eax
80104bc3:	5b                   	pop    %ebx
80104bc4:	5e                   	pop    %esi
80104bc5:	5f                   	pop    %edi
80104bc6:	5d                   	pop    %ebp
80104bc7:	c3                   	ret    
80104bc8:	90                   	nop
80104bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104bd0:	83 ec 0c             	sub    $0xc,%esp
80104bd3:	57                   	push   %edi
    return 0;
80104bd4:	31 ff                	xor    %edi,%edi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104bd6:	e8 25 cd ff ff       	call   80101900 <iunlockput>
    return 0;
80104bdb:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104bde:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104be1:	89 f8                	mov    %edi,%eax
80104be3:	5b                   	pop    %ebx
80104be4:	5e                   	pop    %esi
80104be5:	5f                   	pop    %edi
80104be6:	5d                   	pop    %ebp
80104be7:	c3                   	ret    
80104be8:	90                   	nop
80104be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104bf0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104bf4:	83 ec 08             	sub    $0x8,%esp
80104bf7:	50                   	push   %eax
80104bf8:	ff 36                	pushl  (%esi)
80104bfa:	e8 01 c9 ff ff       	call   80101500 <ialloc>
80104bff:	83 c4 10             	add    $0x10,%esp
80104c02:	85 c0                	test   %eax,%eax
80104c04:	89 c7                	mov    %eax,%edi
80104c06:	0f 84 cc 00 00 00    	je     80104cd8 <create+0x188>
    panic("create: ialloc");

  ilock(ip);
80104c0c:	83 ec 0c             	sub    $0xc,%esp
80104c0f:	50                   	push   %eax
80104c10:	e8 5b ca ff ff       	call   80101670 <ilock>
  ip->major = major;
80104c15:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104c19:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104c1d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104c21:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104c25:	b8 01 00 00 00       	mov    $0x1,%eax
80104c2a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104c2e:	89 3c 24             	mov    %edi,(%esp)
80104c31:	e8 8a c9 ff ff       	call   801015c0 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80104c36:	83 c4 10             	add    $0x10,%esp
80104c39:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104c3e:	74 40                	je     80104c80 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104c40:	83 ec 04             	sub    $0x4,%esp
80104c43:	ff 77 04             	pushl  0x4(%edi)
80104c46:	53                   	push   %ebx
80104c47:	56                   	push   %esi
80104c48:	e8 b3 d1 ff ff       	call   80101e00 <dirlink>
80104c4d:	83 c4 10             	add    $0x10,%esp
80104c50:	85 c0                	test   %eax,%eax
80104c52:	78 77                	js     80104ccb <create+0x17b>
    panic("create: dirlink");

  iunlockput(dp);
80104c54:	83 ec 0c             	sub    $0xc,%esp
80104c57:	56                   	push   %esi
80104c58:	e8 a3 cc ff ff       	call   80101900 <iunlockput>

  return ip;
80104c5d:	83 c4 10             	add    $0x10,%esp
}
80104c60:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c63:	89 f8                	mov    %edi,%eax
80104c65:	5b                   	pop    %ebx
80104c66:	5e                   	pop    %esi
80104c67:	5f                   	pop    %edi
80104c68:	5d                   	pop    %ebp
80104c69:	c3                   	ret    
80104c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104c70:	31 ff                	xor    %edi,%edi
80104c72:	e9 47 ff ff ff       	jmp    80104bbe <create+0x6e>
80104c77:	89 f6                	mov    %esi,%esi
80104c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104c80:	66 83 46 56 01       	addw   $0x1,0x56(%esi)
    iupdate(dp);
80104c85:	83 ec 0c             	sub    $0xc,%esp
80104c88:	56                   	push   %esi
80104c89:	e8 32 c9 ff ff       	call   801015c0 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104c8e:	83 c4 0c             	add    $0xc,%esp
80104c91:	ff 77 04             	pushl  0x4(%edi)
80104c94:	68 bc 79 10 80       	push   $0x801079bc
80104c99:	57                   	push   %edi
80104c9a:	e8 61 d1 ff ff       	call   80101e00 <dirlink>
80104c9f:	83 c4 10             	add    $0x10,%esp
80104ca2:	85 c0                	test   %eax,%eax
80104ca4:	78 18                	js     80104cbe <create+0x16e>
80104ca6:	83 ec 04             	sub    $0x4,%esp
80104ca9:	ff 76 04             	pushl  0x4(%esi)
80104cac:	68 bb 79 10 80       	push   $0x801079bb
80104cb1:	57                   	push   %edi
80104cb2:	e8 49 d1 ff ff       	call   80101e00 <dirlink>
80104cb7:	83 c4 10             	add    $0x10,%esp
80104cba:	85 c0                	test   %eax,%eax
80104cbc:	79 82                	jns    80104c40 <create+0xf0>
      panic("create dots");
80104cbe:	83 ec 0c             	sub    $0xc,%esp
80104cc1:	68 af 79 10 80       	push   $0x801079af
80104cc6:	e8 a5 b6 ff ff       	call   80100370 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104ccb:	83 ec 0c             	sub    $0xc,%esp
80104cce:	68 be 79 10 80       	push   $0x801079be
80104cd3:	e8 98 b6 ff ff       	call   80100370 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104cd8:	83 ec 0c             	sub    $0xc,%esp
80104cdb:	68 a0 79 10 80       	push   $0x801079a0
80104ce0:	e8 8b b6 ff ff       	call   80100370 <panic>
80104ce5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104cf0 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104cf0:	55                   	push   %ebp
80104cf1:	89 e5                	mov    %esp,%ebp
80104cf3:	56                   	push   %esi
80104cf4:	53                   	push   %ebx
80104cf5:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104cf7:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104cfa:	89 d3                	mov    %edx,%ebx
80104cfc:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104cff:	50                   	push   %eax
80104d00:	6a 00                	push   $0x0
80104d02:	e8 d9 fc ff ff       	call   801049e0 <argint>
80104d07:	83 c4 10             	add    $0x10,%esp
80104d0a:	85 c0                	test   %eax,%eax
80104d0c:	78 32                	js     80104d40 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104d0e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104d12:	77 2c                	ja     80104d40 <argfd.constprop.0+0x50>
80104d14:	e8 a7 ea ff ff       	call   801037c0 <myproc>
80104d19:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104d1c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104d20:	85 c0                	test   %eax,%eax
80104d22:	74 1c                	je     80104d40 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
80104d24:	85 f6                	test   %esi,%esi
80104d26:	74 02                	je     80104d2a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104d28:	89 16                	mov    %edx,(%esi)
  if(pf)
80104d2a:	85 db                	test   %ebx,%ebx
80104d2c:	74 22                	je     80104d50 <argfd.constprop.0+0x60>
    *pf = f;
80104d2e:	89 03                	mov    %eax,(%ebx)
  return 0;
80104d30:	31 c0                	xor    %eax,%eax
}
80104d32:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d35:	5b                   	pop    %ebx
80104d36:	5e                   	pop    %esi
80104d37:	5d                   	pop    %ebp
80104d38:	c3                   	ret    
80104d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d40:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104d43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
80104d48:	5b                   	pop    %ebx
80104d49:	5e                   	pop    %esi
80104d4a:	5d                   	pop    %ebp
80104d4b:	c3                   	ret    
80104d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104d50:	31 c0                	xor    %eax,%eax
80104d52:	eb de                	jmp    80104d32 <argfd.constprop.0+0x42>
80104d54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104d60 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104d60:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104d61:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104d63:	89 e5                	mov    %esp,%ebp
80104d65:	56                   	push   %esi
80104d66:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104d67:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
80104d6a:	83 ec 10             	sub    $0x10,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104d6d:	e8 7e ff ff ff       	call   80104cf0 <argfd.constprop.0>
80104d72:	85 c0                	test   %eax,%eax
80104d74:	78 1a                	js     80104d90 <sys_dup+0x30>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104d76:	31 db                	xor    %ebx,%ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
80104d78:	8b 75 f4             	mov    -0xc(%ebp),%esi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80104d7b:	e8 40 ea ff ff       	call   801037c0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80104d80:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104d84:	85 d2                	test   %edx,%edx
80104d86:	74 18                	je     80104da0 <sys_dup+0x40>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104d88:	83 c3 01             	add    $0x1,%ebx
80104d8b:	83 fb 10             	cmp    $0x10,%ebx
80104d8e:	75 f0                	jne    80104d80 <sys_dup+0x20>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104d90:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104d93:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104d98:	89 d8                	mov    %ebx,%eax
80104d9a:	5b                   	pop    %ebx
80104d9b:	5e                   	pop    %esi
80104d9c:	5d                   	pop    %ebp
80104d9d:	c3                   	ret    
80104d9e:	66 90                	xchg   %ax,%ax
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80104da0:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104da4:	83 ec 0c             	sub    $0xc,%esp
80104da7:	ff 75 f4             	pushl  -0xc(%ebp)
80104daa:	e8 21 c0 ff ff       	call   80100dd0 <filedup>
  return fd;
80104daf:	83 c4 10             	add    $0x10,%esp
}
80104db2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104db5:	89 d8                	mov    %ebx,%eax
80104db7:	5b                   	pop    %ebx
80104db8:	5e                   	pop    %esi
80104db9:	5d                   	pop    %ebp
80104dba:	c3                   	ret    
80104dbb:	90                   	nop
80104dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104dc0 <sys_read>:

int
sys_read(void)
{
80104dc0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104dc1:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104dc3:	89 e5                	mov    %esp,%ebp
80104dc5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104dc8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104dcb:	e8 20 ff ff ff       	call   80104cf0 <argfd.constprop.0>
80104dd0:	85 c0                	test   %eax,%eax
80104dd2:	78 4c                	js     80104e20 <sys_read+0x60>
80104dd4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104dd7:	83 ec 08             	sub    $0x8,%esp
80104dda:	50                   	push   %eax
80104ddb:	6a 02                	push   $0x2
80104ddd:	e8 fe fb ff ff       	call   801049e0 <argint>
80104de2:	83 c4 10             	add    $0x10,%esp
80104de5:	85 c0                	test   %eax,%eax
80104de7:	78 37                	js     80104e20 <sys_read+0x60>
80104de9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dec:	83 ec 04             	sub    $0x4,%esp
80104def:	ff 75 f0             	pushl  -0x10(%ebp)
80104df2:	50                   	push   %eax
80104df3:	6a 01                	push   $0x1
80104df5:	e8 36 fc ff ff       	call   80104a30 <argptr>
80104dfa:	83 c4 10             	add    $0x10,%esp
80104dfd:	85 c0                	test   %eax,%eax
80104dff:	78 1f                	js     80104e20 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80104e01:	83 ec 04             	sub    $0x4,%esp
80104e04:	ff 75 f0             	pushl  -0x10(%ebp)
80104e07:	ff 75 f4             	pushl  -0xc(%ebp)
80104e0a:	ff 75 ec             	pushl  -0x14(%ebp)
80104e0d:	e8 2e c1 ff ff       	call   80100f40 <fileread>
80104e12:	83 c4 10             	add    $0x10,%esp
}
80104e15:	c9                   	leave  
80104e16:	c3                   	ret    
80104e17:	89 f6                	mov    %esi,%esi
80104e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104e20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104e25:	c9                   	leave  
80104e26:	c3                   	ret    
80104e27:	89 f6                	mov    %esi,%esi
80104e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e30 <sys_write>:

int
sys_write(void)
{
80104e30:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e31:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104e33:	89 e5                	mov    %esp,%ebp
80104e35:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e38:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104e3b:	e8 b0 fe ff ff       	call   80104cf0 <argfd.constprop.0>
80104e40:	85 c0                	test   %eax,%eax
80104e42:	78 4c                	js     80104e90 <sys_write+0x60>
80104e44:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e47:	83 ec 08             	sub    $0x8,%esp
80104e4a:	50                   	push   %eax
80104e4b:	6a 02                	push   $0x2
80104e4d:	e8 8e fb ff ff       	call   801049e0 <argint>
80104e52:	83 c4 10             	add    $0x10,%esp
80104e55:	85 c0                	test   %eax,%eax
80104e57:	78 37                	js     80104e90 <sys_write+0x60>
80104e59:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e5c:	83 ec 04             	sub    $0x4,%esp
80104e5f:	ff 75 f0             	pushl  -0x10(%ebp)
80104e62:	50                   	push   %eax
80104e63:	6a 01                	push   $0x1
80104e65:	e8 c6 fb ff ff       	call   80104a30 <argptr>
80104e6a:	83 c4 10             	add    $0x10,%esp
80104e6d:	85 c0                	test   %eax,%eax
80104e6f:	78 1f                	js     80104e90 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80104e71:	83 ec 04             	sub    $0x4,%esp
80104e74:	ff 75 f0             	pushl  -0x10(%ebp)
80104e77:	ff 75 f4             	pushl  -0xc(%ebp)
80104e7a:	ff 75 ec             	pushl  -0x14(%ebp)
80104e7d:	e8 4e c1 ff ff       	call   80100fd0 <filewrite>
80104e82:	83 c4 10             	add    $0x10,%esp
}
80104e85:	c9                   	leave  
80104e86:	c3                   	ret    
80104e87:	89 f6                	mov    %esi,%esi
80104e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104e90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80104e95:	c9                   	leave  
80104e96:	c3                   	ret    
80104e97:	89 f6                	mov    %esi,%esi
80104e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ea0 <sys_close>:

int
sys_close(void)
{
80104ea0:	55                   	push   %ebp
80104ea1:	89 e5                	mov    %esp,%ebp
80104ea3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104ea6:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104ea9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104eac:	e8 3f fe ff ff       	call   80104cf0 <argfd.constprop.0>
80104eb1:	85 c0                	test   %eax,%eax
80104eb3:	78 2b                	js     80104ee0 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80104eb5:	e8 06 e9 ff ff       	call   801037c0 <myproc>
80104eba:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104ebd:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
80104ec0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104ec7:	00 
  fileclose(f);
80104ec8:	ff 75 f4             	pushl  -0xc(%ebp)
80104ecb:	e8 50 bf ff ff       	call   80100e20 <fileclose>
  return 0;
80104ed0:	83 c4 10             	add    $0x10,%esp
80104ed3:	31 c0                	xor    %eax,%eax
}
80104ed5:	c9                   	leave  
80104ed6:	c3                   	ret    
80104ed7:	89 f6                	mov    %esi,%esi
80104ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104ee0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104ee5:	c9                   	leave  
80104ee6:	c3                   	ret    
80104ee7:	89 f6                	mov    %esi,%esi
80104ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ef0 <sys_fstat>:

int
sys_fstat(void)
{
80104ef0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104ef1:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104ef3:	89 e5                	mov    %esp,%ebp
80104ef5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104ef8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104efb:	e8 f0 fd ff ff       	call   80104cf0 <argfd.constprop.0>
80104f00:	85 c0                	test   %eax,%eax
80104f02:	78 2c                	js     80104f30 <sys_fstat+0x40>
80104f04:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f07:	83 ec 04             	sub    $0x4,%esp
80104f0a:	6a 14                	push   $0x14
80104f0c:	50                   	push   %eax
80104f0d:	6a 01                	push   $0x1
80104f0f:	e8 1c fb ff ff       	call   80104a30 <argptr>
80104f14:	83 c4 10             	add    $0x10,%esp
80104f17:	85 c0                	test   %eax,%eax
80104f19:	78 15                	js     80104f30 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
80104f1b:	83 ec 08             	sub    $0x8,%esp
80104f1e:	ff 75 f4             	pushl  -0xc(%ebp)
80104f21:	ff 75 f0             	pushl  -0x10(%ebp)
80104f24:	e8 c7 bf ff ff       	call   80100ef0 <filestat>
80104f29:	83 c4 10             	add    $0x10,%esp
}
80104f2c:	c9                   	leave  
80104f2d:	c3                   	ret    
80104f2e:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104f30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104f35:	c9                   	leave  
80104f36:	c3                   	ret    
80104f37:	89 f6                	mov    %esi,%esi
80104f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f40 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104f40:	55                   	push   %ebp
80104f41:	89 e5                	mov    %esp,%ebp
80104f43:	57                   	push   %edi
80104f44:	56                   	push   %esi
80104f45:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f46:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104f49:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f4c:	50                   	push   %eax
80104f4d:	6a 00                	push   $0x0
80104f4f:	e8 3c fb ff ff       	call   80104a90 <argstr>
80104f54:	83 c4 10             	add    $0x10,%esp
80104f57:	85 c0                	test   %eax,%eax
80104f59:	0f 88 fb 00 00 00    	js     8010505a <sys_link+0x11a>
80104f5f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104f62:	83 ec 08             	sub    $0x8,%esp
80104f65:	50                   	push   %eax
80104f66:	6a 01                	push   $0x1
80104f68:	e8 23 fb ff ff       	call   80104a90 <argstr>
80104f6d:	83 c4 10             	add    $0x10,%esp
80104f70:	85 c0                	test   %eax,%eax
80104f72:	0f 88 e2 00 00 00    	js     8010505a <sys_link+0x11a>
    return -1;

  begin_op();
80104f78:	e8 f3 db ff ff       	call   80102b70 <begin_op>
  if((ip = namei(old)) == 0){
80104f7d:	83 ec 0c             	sub    $0xc,%esp
80104f80:	ff 75 d4             	pushl  -0x2c(%ebp)
80104f83:	e8 38 cf ff ff       	call   80101ec0 <namei>
80104f88:	83 c4 10             	add    $0x10,%esp
80104f8b:	85 c0                	test   %eax,%eax
80104f8d:	89 c3                	mov    %eax,%ebx
80104f8f:	0f 84 f3 00 00 00    	je     80105088 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
80104f95:	83 ec 0c             	sub    $0xc,%esp
80104f98:	50                   	push   %eax
80104f99:	e8 d2 c6 ff ff       	call   80101670 <ilock>
  if(ip->type == T_DIR){
80104f9e:	83 c4 10             	add    $0x10,%esp
80104fa1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104fa6:	0f 84 c4 00 00 00    	je     80105070 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80104fac:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104fb1:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80104fb4:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80104fb7:	53                   	push   %ebx
80104fb8:	e8 03 c6 ff ff       	call   801015c0 <iupdate>
  iunlock(ip);
80104fbd:	89 1c 24             	mov    %ebx,(%esp)
80104fc0:	e8 8b c7 ff ff       	call   80101750 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80104fc5:	58                   	pop    %eax
80104fc6:	5a                   	pop    %edx
80104fc7:	57                   	push   %edi
80104fc8:	ff 75 d0             	pushl  -0x30(%ebp)
80104fcb:	e8 10 cf ff ff       	call   80101ee0 <nameiparent>
80104fd0:	83 c4 10             	add    $0x10,%esp
80104fd3:	85 c0                	test   %eax,%eax
80104fd5:	89 c6                	mov    %eax,%esi
80104fd7:	74 5b                	je     80105034 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80104fd9:	83 ec 0c             	sub    $0xc,%esp
80104fdc:	50                   	push   %eax
80104fdd:	e8 8e c6 ff ff       	call   80101670 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104fe2:	83 c4 10             	add    $0x10,%esp
80104fe5:	8b 03                	mov    (%ebx),%eax
80104fe7:	39 06                	cmp    %eax,(%esi)
80104fe9:	75 3d                	jne    80105028 <sys_link+0xe8>
80104feb:	83 ec 04             	sub    $0x4,%esp
80104fee:	ff 73 04             	pushl  0x4(%ebx)
80104ff1:	57                   	push   %edi
80104ff2:	56                   	push   %esi
80104ff3:	e8 08 ce ff ff       	call   80101e00 <dirlink>
80104ff8:	83 c4 10             	add    $0x10,%esp
80104ffb:	85 c0                	test   %eax,%eax
80104ffd:	78 29                	js     80105028 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104fff:	83 ec 0c             	sub    $0xc,%esp
80105002:	56                   	push   %esi
80105003:	e8 f8 c8 ff ff       	call   80101900 <iunlockput>
  iput(ip);
80105008:	89 1c 24             	mov    %ebx,(%esp)
8010500b:	e8 90 c7 ff ff       	call   801017a0 <iput>

  end_op();
80105010:	e8 cb db ff ff       	call   80102be0 <end_op>

  return 0;
80105015:	83 c4 10             	add    $0x10,%esp
80105018:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
8010501a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010501d:	5b                   	pop    %ebx
8010501e:	5e                   	pop    %esi
8010501f:	5f                   	pop    %edi
80105020:	5d                   	pop    %ebp
80105021:	c3                   	ret    
80105022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80105028:	83 ec 0c             	sub    $0xc,%esp
8010502b:	56                   	push   %esi
8010502c:	e8 cf c8 ff ff       	call   80101900 <iunlockput>
    goto bad;
80105031:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80105034:	83 ec 0c             	sub    $0xc,%esp
80105037:	53                   	push   %ebx
80105038:	e8 33 c6 ff ff       	call   80101670 <ilock>
  ip->nlink--;
8010503d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105042:	89 1c 24             	mov    %ebx,(%esp)
80105045:	e8 76 c5 ff ff       	call   801015c0 <iupdate>
  iunlockput(ip);
8010504a:	89 1c 24             	mov    %ebx,(%esp)
8010504d:	e8 ae c8 ff ff       	call   80101900 <iunlockput>
  end_op();
80105052:	e8 89 db ff ff       	call   80102be0 <end_op>
  return -1;
80105057:	83 c4 10             	add    $0x10,%esp
}
8010505a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
8010505d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105062:	5b                   	pop    %ebx
80105063:	5e                   	pop    %esi
80105064:	5f                   	pop    %edi
80105065:	5d                   	pop    %ebp
80105066:	c3                   	ret    
80105067:	89 f6                	mov    %esi,%esi
80105069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
80105070:	83 ec 0c             	sub    $0xc,%esp
80105073:	53                   	push   %ebx
80105074:	e8 87 c8 ff ff       	call   80101900 <iunlockput>
    end_op();
80105079:	e8 62 db ff ff       	call   80102be0 <end_op>
    return -1;
8010507e:	83 c4 10             	add    $0x10,%esp
80105081:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105086:	eb 92                	jmp    8010501a <sys_link+0xda>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
80105088:	e8 53 db ff ff       	call   80102be0 <end_op>
    return -1;
8010508d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105092:	eb 86                	jmp    8010501a <sys_link+0xda>
80105094:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010509a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801050a0 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	57                   	push   %edi
801050a4:	56                   	push   %esi
801050a5:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801050a6:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
801050a9:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801050ac:	50                   	push   %eax
801050ad:	6a 00                	push   $0x0
801050af:	e8 dc f9 ff ff       	call   80104a90 <argstr>
801050b4:	83 c4 10             	add    $0x10,%esp
801050b7:	85 c0                	test   %eax,%eax
801050b9:	0f 88 82 01 00 00    	js     80105241 <sys_unlink+0x1a1>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
801050bf:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
801050c2:	e8 a9 da ff ff       	call   80102b70 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801050c7:	83 ec 08             	sub    $0x8,%esp
801050ca:	53                   	push   %ebx
801050cb:	ff 75 c0             	pushl  -0x40(%ebp)
801050ce:	e8 0d ce ff ff       	call   80101ee0 <nameiparent>
801050d3:	83 c4 10             	add    $0x10,%esp
801050d6:	85 c0                	test   %eax,%eax
801050d8:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801050db:	0f 84 6a 01 00 00    	je     8010524b <sys_unlink+0x1ab>
    end_op();
    return -1;
  }

  ilock(dp);
801050e1:	8b 75 b4             	mov    -0x4c(%ebp),%esi
801050e4:	83 ec 0c             	sub    $0xc,%esp
801050e7:	56                   	push   %esi
801050e8:	e8 83 c5 ff ff       	call   80101670 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801050ed:	58                   	pop    %eax
801050ee:	5a                   	pop    %edx
801050ef:	68 bc 79 10 80       	push   $0x801079bc
801050f4:	53                   	push   %ebx
801050f5:	e8 86 ca ff ff       	call   80101b80 <namecmp>
801050fa:	83 c4 10             	add    $0x10,%esp
801050fd:	85 c0                	test   %eax,%eax
801050ff:	0f 84 fc 00 00 00    	je     80105201 <sys_unlink+0x161>
80105105:	83 ec 08             	sub    $0x8,%esp
80105108:	68 bb 79 10 80       	push   $0x801079bb
8010510d:	53                   	push   %ebx
8010510e:	e8 6d ca ff ff       	call   80101b80 <namecmp>
80105113:	83 c4 10             	add    $0x10,%esp
80105116:	85 c0                	test   %eax,%eax
80105118:	0f 84 e3 00 00 00    	je     80105201 <sys_unlink+0x161>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
8010511e:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105121:	83 ec 04             	sub    $0x4,%esp
80105124:	50                   	push   %eax
80105125:	53                   	push   %ebx
80105126:	56                   	push   %esi
80105127:	e8 74 ca ff ff       	call   80101ba0 <dirlookup>
8010512c:	83 c4 10             	add    $0x10,%esp
8010512f:	85 c0                	test   %eax,%eax
80105131:	89 c3                	mov    %eax,%ebx
80105133:	0f 84 c8 00 00 00    	je     80105201 <sys_unlink+0x161>
    goto bad;
  ilock(ip);
80105139:	83 ec 0c             	sub    $0xc,%esp
8010513c:	50                   	push   %eax
8010513d:	e8 2e c5 ff ff       	call   80101670 <ilock>

  if(ip->nlink < 1)
80105142:	83 c4 10             	add    $0x10,%esp
80105145:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010514a:	0f 8e 24 01 00 00    	jle    80105274 <sys_unlink+0x1d4>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80105150:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105155:	8d 75 d8             	lea    -0x28(%ebp),%esi
80105158:	74 66                	je     801051c0 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
8010515a:	83 ec 04             	sub    $0x4,%esp
8010515d:	6a 10                	push   $0x10
8010515f:	6a 00                	push   $0x0
80105161:	56                   	push   %esi
80105162:	e8 89 f5 ff ff       	call   801046f0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105167:	6a 10                	push   $0x10
80105169:	ff 75 c4             	pushl  -0x3c(%ebp)
8010516c:	56                   	push   %esi
8010516d:	ff 75 b4             	pushl  -0x4c(%ebp)
80105170:	e8 db c8 ff ff       	call   80101a50 <writei>
80105175:	83 c4 20             	add    $0x20,%esp
80105178:	83 f8 10             	cmp    $0x10,%eax
8010517b:	0f 85 e6 00 00 00    	jne    80105267 <sys_unlink+0x1c7>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80105181:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105186:	0f 84 9c 00 00 00    	je     80105228 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
8010518c:	83 ec 0c             	sub    $0xc,%esp
8010518f:	ff 75 b4             	pushl  -0x4c(%ebp)
80105192:	e8 69 c7 ff ff       	call   80101900 <iunlockput>

  ip->nlink--;
80105197:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010519c:	89 1c 24             	mov    %ebx,(%esp)
8010519f:	e8 1c c4 ff ff       	call   801015c0 <iupdate>
  iunlockput(ip);
801051a4:	89 1c 24             	mov    %ebx,(%esp)
801051a7:	e8 54 c7 ff ff       	call   80101900 <iunlockput>

  end_op();
801051ac:	e8 2f da ff ff       	call   80102be0 <end_op>

  return 0;
801051b1:	83 c4 10             	add    $0x10,%esp
801051b4:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
801051b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051b9:	5b                   	pop    %ebx
801051ba:	5e                   	pop    %esi
801051bb:	5f                   	pop    %edi
801051bc:	5d                   	pop    %ebp
801051bd:	c3                   	ret    
801051be:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801051c0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801051c4:	76 94                	jbe    8010515a <sys_unlink+0xba>
801051c6:	bf 20 00 00 00       	mov    $0x20,%edi
801051cb:	eb 0f                	jmp    801051dc <sys_unlink+0x13c>
801051cd:	8d 76 00             	lea    0x0(%esi),%esi
801051d0:	83 c7 10             	add    $0x10,%edi
801051d3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801051d6:	0f 83 7e ff ff ff    	jae    8010515a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801051dc:	6a 10                	push   $0x10
801051de:	57                   	push   %edi
801051df:	56                   	push   %esi
801051e0:	53                   	push   %ebx
801051e1:	e8 6a c7 ff ff       	call   80101950 <readi>
801051e6:	83 c4 10             	add    $0x10,%esp
801051e9:	83 f8 10             	cmp    $0x10,%eax
801051ec:	75 6c                	jne    8010525a <sys_unlink+0x1ba>
      panic("isdirempty: readi");
    if(de.inum != 0)
801051ee:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801051f3:	74 db                	je     801051d0 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
801051f5:	83 ec 0c             	sub    $0xc,%esp
801051f8:	53                   	push   %ebx
801051f9:	e8 02 c7 ff ff       	call   80101900 <iunlockput>
    goto bad;
801051fe:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
80105201:	83 ec 0c             	sub    $0xc,%esp
80105204:	ff 75 b4             	pushl  -0x4c(%ebp)
80105207:	e8 f4 c6 ff ff       	call   80101900 <iunlockput>
  end_op();
8010520c:	e8 cf d9 ff ff       	call   80102be0 <end_op>
  return -1;
80105211:	83 c4 10             	add    $0x10,%esp
}
80105214:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
80105217:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010521c:	5b                   	pop    %ebx
8010521d:	5e                   	pop    %esi
8010521e:	5f                   	pop    %edi
8010521f:	5d                   	pop    %ebp
80105220:	c3                   	ret    
80105221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80105228:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
8010522b:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
8010522e:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105233:	50                   	push   %eax
80105234:	e8 87 c3 ff ff       	call   801015c0 <iupdate>
80105239:	83 c4 10             	add    $0x10,%esp
8010523c:	e9 4b ff ff ff       	jmp    8010518c <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80105241:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105246:	e9 6b ff ff ff       	jmp    801051b6 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
8010524b:	e8 90 d9 ff ff       	call   80102be0 <end_op>
    return -1;
80105250:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105255:	e9 5c ff ff ff       	jmp    801051b6 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
8010525a:	83 ec 0c             	sub    $0xc,%esp
8010525d:	68 e0 79 10 80       	push   $0x801079e0
80105262:	e8 09 b1 ff ff       	call   80100370 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80105267:	83 ec 0c             	sub    $0xc,%esp
8010526a:	68 f2 79 10 80       	push   $0x801079f2
8010526f:	e8 fc b0 ff ff       	call   80100370 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80105274:	83 ec 0c             	sub    $0xc,%esp
80105277:	68 ce 79 10 80       	push   $0x801079ce
8010527c:	e8 ef b0 ff ff       	call   80100370 <panic>
80105281:	eb 0d                	jmp    80105290 <sys_open>
80105283:	90                   	nop
80105284:	90                   	nop
80105285:	90                   	nop
80105286:	90                   	nop
80105287:	90                   	nop
80105288:	90                   	nop
80105289:	90                   	nop
8010528a:	90                   	nop
8010528b:	90                   	nop
8010528c:	90                   	nop
8010528d:	90                   	nop
8010528e:	90                   	nop
8010528f:	90                   	nop

80105290 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80105290:	55                   	push   %ebp
80105291:	89 e5                	mov    %esp,%ebp
80105293:	57                   	push   %edi
80105294:	56                   	push   %esi
80105295:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105296:	8d 45 e0             	lea    -0x20(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
80105299:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010529c:	50                   	push   %eax
8010529d:	6a 00                	push   $0x0
8010529f:	e8 ec f7 ff ff       	call   80104a90 <argstr>
801052a4:	83 c4 10             	add    $0x10,%esp
801052a7:	85 c0                	test   %eax,%eax
801052a9:	0f 88 9e 00 00 00    	js     8010534d <sys_open+0xbd>
801052af:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801052b2:	83 ec 08             	sub    $0x8,%esp
801052b5:	50                   	push   %eax
801052b6:	6a 01                	push   $0x1
801052b8:	e8 23 f7 ff ff       	call   801049e0 <argint>
801052bd:	83 c4 10             	add    $0x10,%esp
801052c0:	85 c0                	test   %eax,%eax
801052c2:	0f 88 85 00 00 00    	js     8010534d <sys_open+0xbd>
    return -1;

  begin_op();
801052c8:	e8 a3 d8 ff ff       	call   80102b70 <begin_op>

  if(omode & O_CREATE){
801052cd:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801052d1:	0f 85 89 00 00 00    	jne    80105360 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801052d7:	83 ec 0c             	sub    $0xc,%esp
801052da:	ff 75 e0             	pushl  -0x20(%ebp)
801052dd:	e8 de cb ff ff       	call   80101ec0 <namei>
801052e2:	83 c4 10             	add    $0x10,%esp
801052e5:	85 c0                	test   %eax,%eax
801052e7:	89 c6                	mov    %eax,%esi
801052e9:	0f 84 8e 00 00 00    	je     8010537d <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
801052ef:	83 ec 0c             	sub    $0xc,%esp
801052f2:	50                   	push   %eax
801052f3:	e8 78 c3 ff ff       	call   80101670 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801052f8:	83 c4 10             	add    $0x10,%esp
801052fb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105300:	0f 84 d2 00 00 00    	je     801053d8 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105306:	e8 55 ba ff ff       	call   80100d60 <filealloc>
8010530b:	85 c0                	test   %eax,%eax
8010530d:	89 c7                	mov    %eax,%edi
8010530f:	74 2b                	je     8010533c <sys_open+0xac>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105311:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105313:	e8 a8 e4 ff ff       	call   801037c0 <myproc>
80105318:	90                   	nop
80105319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105320:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105324:	85 d2                	test   %edx,%edx
80105326:	74 68                	je     80105390 <sys_open+0x100>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105328:	83 c3 01             	add    $0x1,%ebx
8010532b:	83 fb 10             	cmp    $0x10,%ebx
8010532e:	75 f0                	jne    80105320 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80105330:	83 ec 0c             	sub    $0xc,%esp
80105333:	57                   	push   %edi
80105334:	e8 e7 ba ff ff       	call   80100e20 <fileclose>
80105339:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010533c:	83 ec 0c             	sub    $0xc,%esp
8010533f:	56                   	push   %esi
80105340:	e8 bb c5 ff ff       	call   80101900 <iunlockput>
    end_op();
80105345:	e8 96 d8 ff ff       	call   80102be0 <end_op>
    return -1;
8010534a:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
8010534d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
80105350:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80105355:	89 d8                	mov    %ebx,%eax
80105357:	5b                   	pop    %ebx
80105358:	5e                   	pop    %esi
80105359:	5f                   	pop    %edi
8010535a:	5d                   	pop    %ebp
8010535b:	c3                   	ret    
8010535c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105360:	83 ec 0c             	sub    $0xc,%esp
80105363:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105366:	31 c9                	xor    %ecx,%ecx
80105368:	6a 00                	push   $0x0
8010536a:	ba 02 00 00 00       	mov    $0x2,%edx
8010536f:	e8 dc f7 ff ff       	call   80104b50 <create>
    if(ip == 0){
80105374:	83 c4 10             	add    $0x10,%esp
80105377:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105379:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010537b:	75 89                	jne    80105306 <sys_open+0x76>
      end_op();
8010537d:	e8 5e d8 ff ff       	call   80102be0 <end_op>
      return -1;
80105382:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105387:	eb 40                	jmp    801053c9 <sys_open+0x139>
80105389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105390:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105393:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105397:	56                   	push   %esi
80105398:	e8 b3 c3 ff ff       	call   80101750 <iunlock>
  end_op();
8010539d:	e8 3e d8 ff ff       	call   80102be0 <end_op>

  f->type = FD_INODE;
801053a2:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801053a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801053ab:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
801053ae:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801053b1:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801053b8:	89 c2                	mov    %eax,%edx
801053ba:	f7 d2                	not    %edx
801053bc:	88 57 08             	mov    %dl,0x8(%edi)
801053bf:	80 67 08 01          	andb   $0x1,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801053c3:	a8 03                	test   $0x3,%al
801053c5:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801053c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053cc:	89 d8                	mov    %ebx,%eax
801053ce:	5b                   	pop    %ebx
801053cf:	5e                   	pop    %esi
801053d0:	5f                   	pop    %edi
801053d1:	5d                   	pop    %ebp
801053d2:	c3                   	ret    
801053d3:	90                   	nop
801053d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
801053d8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801053db:	85 c9                	test   %ecx,%ecx
801053dd:	0f 84 23 ff ff ff    	je     80105306 <sys_open+0x76>
801053e3:	e9 54 ff ff ff       	jmp    8010533c <sys_open+0xac>
801053e8:	90                   	nop
801053e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801053f0 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
801053f0:	55                   	push   %ebp
801053f1:	89 e5                	mov    %esp,%ebp
801053f3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801053f6:	e8 75 d7 ff ff       	call   80102b70 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801053fb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053fe:	83 ec 08             	sub    $0x8,%esp
80105401:	50                   	push   %eax
80105402:	6a 00                	push   $0x0
80105404:	e8 87 f6 ff ff       	call   80104a90 <argstr>
80105409:	83 c4 10             	add    $0x10,%esp
8010540c:	85 c0                	test   %eax,%eax
8010540e:	78 30                	js     80105440 <sys_mkdir+0x50>
80105410:	83 ec 0c             	sub    $0xc,%esp
80105413:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105416:	31 c9                	xor    %ecx,%ecx
80105418:	6a 00                	push   $0x0
8010541a:	ba 01 00 00 00       	mov    $0x1,%edx
8010541f:	e8 2c f7 ff ff       	call   80104b50 <create>
80105424:	83 c4 10             	add    $0x10,%esp
80105427:	85 c0                	test   %eax,%eax
80105429:	74 15                	je     80105440 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010542b:	83 ec 0c             	sub    $0xc,%esp
8010542e:	50                   	push   %eax
8010542f:	e8 cc c4 ff ff       	call   80101900 <iunlockput>
  end_op();
80105434:	e8 a7 d7 ff ff       	call   80102be0 <end_op>
  return 0;
80105439:	83 c4 10             	add    $0x10,%esp
8010543c:	31 c0                	xor    %eax,%eax
}
8010543e:	c9                   	leave  
8010543f:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80105440:	e8 9b d7 ff ff       	call   80102be0 <end_op>
    return -1;
80105445:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010544a:	c9                   	leave  
8010544b:	c3                   	ret    
8010544c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105450 <sys_mknod>:

int
sys_mknod(void)
{
80105450:	55                   	push   %ebp
80105451:	89 e5                	mov    %esp,%ebp
80105453:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105456:	e8 15 d7 ff ff       	call   80102b70 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010545b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010545e:	83 ec 08             	sub    $0x8,%esp
80105461:	50                   	push   %eax
80105462:	6a 00                	push   $0x0
80105464:	e8 27 f6 ff ff       	call   80104a90 <argstr>
80105469:	83 c4 10             	add    $0x10,%esp
8010546c:	85 c0                	test   %eax,%eax
8010546e:	78 60                	js     801054d0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105470:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105473:	83 ec 08             	sub    $0x8,%esp
80105476:	50                   	push   %eax
80105477:	6a 01                	push   $0x1
80105479:	e8 62 f5 ff ff       	call   801049e0 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
8010547e:	83 c4 10             	add    $0x10,%esp
80105481:	85 c0                	test   %eax,%eax
80105483:	78 4b                	js     801054d0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105485:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105488:	83 ec 08             	sub    $0x8,%esp
8010548b:	50                   	push   %eax
8010548c:	6a 02                	push   $0x2
8010548e:	e8 4d f5 ff ff       	call   801049e0 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105493:	83 c4 10             	add    $0x10,%esp
80105496:	85 c0                	test   %eax,%eax
80105498:	78 36                	js     801054d0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
8010549a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
8010549e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
801054a1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801054a5:	ba 03 00 00 00       	mov    $0x3,%edx
801054aa:	50                   	push   %eax
801054ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
801054ae:	e8 9d f6 ff ff       	call   80104b50 <create>
801054b3:	83 c4 10             	add    $0x10,%esp
801054b6:	85 c0                	test   %eax,%eax
801054b8:	74 16                	je     801054d0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
801054ba:	83 ec 0c             	sub    $0xc,%esp
801054bd:	50                   	push   %eax
801054be:	e8 3d c4 ff ff       	call   80101900 <iunlockput>
  end_op();
801054c3:	e8 18 d7 ff ff       	call   80102be0 <end_op>
  return 0;
801054c8:	83 c4 10             	add    $0x10,%esp
801054cb:	31 c0                	xor    %eax,%eax
}
801054cd:	c9                   	leave  
801054ce:	c3                   	ret    
801054cf:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
801054d0:	e8 0b d7 ff ff       	call   80102be0 <end_op>
    return -1;
801054d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801054da:	c9                   	leave  
801054db:	c3                   	ret    
801054dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054e0 <sys_chdir>:

int
sys_chdir(void)
{
801054e0:	55                   	push   %ebp
801054e1:	89 e5                	mov    %esp,%ebp
801054e3:	56                   	push   %esi
801054e4:	53                   	push   %ebx
801054e5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801054e8:	e8 d3 e2 ff ff       	call   801037c0 <myproc>
801054ed:	89 c6                	mov    %eax,%esi
  
  begin_op();
801054ef:	e8 7c d6 ff ff       	call   80102b70 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801054f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054f7:	83 ec 08             	sub    $0x8,%esp
801054fa:	50                   	push   %eax
801054fb:	6a 00                	push   $0x0
801054fd:	e8 8e f5 ff ff       	call   80104a90 <argstr>
80105502:	83 c4 10             	add    $0x10,%esp
80105505:	85 c0                	test   %eax,%eax
80105507:	78 77                	js     80105580 <sys_chdir+0xa0>
80105509:	83 ec 0c             	sub    $0xc,%esp
8010550c:	ff 75 f4             	pushl  -0xc(%ebp)
8010550f:	e8 ac c9 ff ff       	call   80101ec0 <namei>
80105514:	83 c4 10             	add    $0x10,%esp
80105517:	85 c0                	test   %eax,%eax
80105519:	89 c3                	mov    %eax,%ebx
8010551b:	74 63                	je     80105580 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010551d:	83 ec 0c             	sub    $0xc,%esp
80105520:	50                   	push   %eax
80105521:	e8 4a c1 ff ff       	call   80101670 <ilock>
  if(ip->type != T_DIR){
80105526:	83 c4 10             	add    $0x10,%esp
80105529:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010552e:	75 30                	jne    80105560 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105530:	83 ec 0c             	sub    $0xc,%esp
80105533:	53                   	push   %ebx
80105534:	e8 17 c2 ff ff       	call   80101750 <iunlock>
  iput(curproc->cwd);
80105539:	58                   	pop    %eax
8010553a:	ff 76 68             	pushl  0x68(%esi)
8010553d:	e8 5e c2 ff ff       	call   801017a0 <iput>
  end_op();
80105542:	e8 99 d6 ff ff       	call   80102be0 <end_op>
  curproc->cwd = ip;
80105547:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010554a:	83 c4 10             	add    $0x10,%esp
8010554d:	31 c0                	xor    %eax,%eax
}
8010554f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105552:	5b                   	pop    %ebx
80105553:	5e                   	pop    %esi
80105554:	5d                   	pop    %ebp
80105555:	c3                   	ret    
80105556:	8d 76 00             	lea    0x0(%esi),%esi
80105559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80105560:	83 ec 0c             	sub    $0xc,%esp
80105563:	53                   	push   %ebx
80105564:	e8 97 c3 ff ff       	call   80101900 <iunlockput>
    end_op();
80105569:	e8 72 d6 ff ff       	call   80102be0 <end_op>
    return -1;
8010556e:	83 c4 10             	add    $0x10,%esp
80105571:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105576:	eb d7                	jmp    8010554f <sys_chdir+0x6f>
80105578:	90                   	nop
80105579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct inode *ip;
  struct proc *curproc = myproc();
  
  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
80105580:	e8 5b d6 ff ff       	call   80102be0 <end_op>
    return -1;
80105585:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010558a:	eb c3                	jmp    8010554f <sys_chdir+0x6f>
8010558c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105590 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
80105590:	55                   	push   %ebp
80105591:	89 e5                	mov    %esp,%ebp
80105593:	57                   	push   %edi
80105594:	56                   	push   %esi
80105595:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105596:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
8010559c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801055a2:	50                   	push   %eax
801055a3:	6a 00                	push   $0x0
801055a5:	e8 e6 f4 ff ff       	call   80104a90 <argstr>
801055aa:	83 c4 10             	add    $0x10,%esp
801055ad:	85 c0                	test   %eax,%eax
801055af:	78 7f                	js     80105630 <sys_exec+0xa0>
801055b1:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801055b7:	83 ec 08             	sub    $0x8,%esp
801055ba:	50                   	push   %eax
801055bb:	6a 01                	push   $0x1
801055bd:	e8 1e f4 ff ff       	call   801049e0 <argint>
801055c2:	83 c4 10             	add    $0x10,%esp
801055c5:	85 c0                	test   %eax,%eax
801055c7:	78 67                	js     80105630 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801055c9:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801055cf:	83 ec 04             	sub    $0x4,%esp
801055d2:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
801055d8:	68 80 00 00 00       	push   $0x80
801055dd:	6a 00                	push   $0x0
801055df:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801055e5:	50                   	push   %eax
801055e6:	31 db                	xor    %ebx,%ebx
801055e8:	e8 03 f1 ff ff       	call   801046f0 <memset>
801055ed:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801055f0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801055f6:	83 ec 08             	sub    $0x8,%esp
801055f9:	57                   	push   %edi
801055fa:	8d 04 98             	lea    (%eax,%ebx,4),%eax
801055fd:	50                   	push   %eax
801055fe:	e8 3d f3 ff ff       	call   80104940 <fetchint>
80105603:	83 c4 10             	add    $0x10,%esp
80105606:	85 c0                	test   %eax,%eax
80105608:	78 26                	js     80105630 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
8010560a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105610:	85 c0                	test   %eax,%eax
80105612:	74 2c                	je     80105640 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105614:	83 ec 08             	sub    $0x8,%esp
80105617:	56                   	push   %esi
80105618:	50                   	push   %eax
80105619:	e8 62 f3 ff ff       	call   80104980 <fetchstr>
8010561e:	83 c4 10             	add    $0x10,%esp
80105621:	85 c0                	test   %eax,%eax
80105623:	78 0b                	js     80105630 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80105625:	83 c3 01             	add    $0x1,%ebx
80105628:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
8010562b:	83 fb 20             	cmp    $0x20,%ebx
8010562e:	75 c0                	jne    801055f0 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105630:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80105633:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105638:	5b                   	pop    %ebx
80105639:	5e                   	pop    %esi
8010563a:	5f                   	pop    %edi
8010563b:	5d                   	pop    %ebp
8010563c:	c3                   	ret    
8010563d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105640:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105646:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80105649:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105650:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105654:	50                   	push   %eax
80105655:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010565b:	e8 80 b3 ff ff       	call   801009e0 <exec>
80105660:	83 c4 10             	add    $0x10,%esp
}
80105663:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105666:	5b                   	pop    %ebx
80105667:	5e                   	pop    %esi
80105668:	5f                   	pop    %edi
80105669:	5d                   	pop    %ebp
8010566a:	c3                   	ret    
8010566b:	90                   	nop
8010566c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105670 <sys_pipe>:

int
sys_pipe(void)
{
80105670:	55                   	push   %ebp
80105671:	89 e5                	mov    %esp,%ebp
80105673:	57                   	push   %edi
80105674:	56                   	push   %esi
80105675:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105676:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
80105679:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010567c:	6a 08                	push   $0x8
8010567e:	50                   	push   %eax
8010567f:	6a 00                	push   $0x0
80105681:	e8 aa f3 ff ff       	call   80104a30 <argptr>
80105686:	83 c4 10             	add    $0x10,%esp
80105689:	85 c0                	test   %eax,%eax
8010568b:	78 4a                	js     801056d7 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010568d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105690:	83 ec 08             	sub    $0x8,%esp
80105693:	50                   	push   %eax
80105694:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105697:	50                   	push   %eax
80105698:	e8 63 db ff ff       	call   80103200 <pipealloc>
8010569d:	83 c4 10             	add    $0x10,%esp
801056a0:	85 c0                	test   %eax,%eax
801056a2:	78 33                	js     801056d7 <sys_pipe+0x67>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801056a4:	31 db                	xor    %ebx,%ebx
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801056a6:	8b 7d e0             	mov    -0x20(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801056a9:	e8 12 e1 ff ff       	call   801037c0 <myproc>
801056ae:	66 90                	xchg   %ax,%ax

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
801056b0:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801056b4:	85 f6                	test   %esi,%esi
801056b6:	74 30                	je     801056e8 <sys_pipe+0x78>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801056b8:	83 c3 01             	add    $0x1,%ebx
801056bb:	83 fb 10             	cmp    $0x10,%ebx
801056be:	75 f0                	jne    801056b0 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
801056c0:	83 ec 0c             	sub    $0xc,%esp
801056c3:	ff 75 e0             	pushl  -0x20(%ebp)
801056c6:	e8 55 b7 ff ff       	call   80100e20 <fileclose>
    fileclose(wf);
801056cb:	58                   	pop    %eax
801056cc:	ff 75 e4             	pushl  -0x1c(%ebp)
801056cf:	e8 4c b7 ff ff       	call   80100e20 <fileclose>
    return -1;
801056d4:	83 c4 10             	add    $0x10,%esp
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801056d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
801056da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801056df:	5b                   	pop    %ebx
801056e0:	5e                   	pop    %esi
801056e1:	5f                   	pop    %edi
801056e2:	5d                   	pop    %ebp
801056e3:	c3                   	ret    
801056e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801056e8:	8d 73 08             	lea    0x8(%ebx),%esi
801056eb:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801056ef:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801056f2:	e8 c9 e0 ff ff       	call   801037c0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
801056f7:	31 d2                	xor    %edx,%edx
801056f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105700:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105704:	85 c9                	test   %ecx,%ecx
80105706:	74 18                	je     80105720 <sys_pipe+0xb0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105708:	83 c2 01             	add    $0x1,%edx
8010570b:	83 fa 10             	cmp    $0x10,%edx
8010570e:	75 f0                	jne    80105700 <sys_pipe+0x90>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105710:	e8 ab e0 ff ff       	call   801037c0 <myproc>
80105715:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
8010571c:	00 
8010571d:	eb a1                	jmp    801056c0 <sys_pipe+0x50>
8010571f:	90                   	nop
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105720:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105724:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105727:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105729:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010572c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
8010572f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
80105732:	31 c0                	xor    %eax,%eax
}
80105734:	5b                   	pop    %ebx
80105735:	5e                   	pop    %esi
80105736:	5f                   	pop    %edi
80105737:	5d                   	pop    %ebp
80105738:	c3                   	ret    
80105739:	66 90                	xchg   %ax,%ax
8010573b:	66 90                	xchg   %ax,%ax
8010573d:	66 90                	xchg   %ax,%ax
8010573f:	90                   	nop

80105740 <sys_fork>:
#include "proc.h"
#include "uproc.h"

int
sys_fork(void)
{
80105740:	55                   	push   %ebp
80105741:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105743:	5d                   	pop    %ebp
#include "uproc.h"

int
sys_fork(void)
{
  return fork();
80105744:	e9 87 e2 ff ff       	jmp    801039d0 <fork>
80105749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105750 <sys_exit>:
}

int
sys_exit(void)
{
80105750:	55                   	push   %ebp
80105751:	89 e5                	mov    %esp,%ebp
80105753:	83 ec 08             	sub    $0x8,%esp
  exit();
80105756:	e8 45 e5 ff ff       	call   80103ca0 <exit>
  return 0;  // not reached
}
8010575b:	31 c0                	xor    %eax,%eax
8010575d:	c9                   	leave  
8010575e:	c3                   	ret    
8010575f:	90                   	nop

80105760 <sys_wait>:

int
sys_wait(void)
{
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105763:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80105764:	e9 77 e7 ff ff       	jmp    80103ee0 <wait>
80105769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105770 <sys_kill>:
}

int
sys_kill(void)
{
80105770:	55                   	push   %ebp
80105771:	89 e5                	mov    %esp,%ebp
80105773:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105776:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105779:	50                   	push   %eax
8010577a:	6a 00                	push   $0x0
8010577c:	e8 5f f2 ff ff       	call   801049e0 <argint>
80105781:	83 c4 10             	add    $0x10,%esp
80105784:	85 c0                	test   %eax,%eax
80105786:	78 18                	js     801057a0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105788:	83 ec 0c             	sub    $0xc,%esp
8010578b:	ff 75 f4             	pushl  -0xc(%ebp)
8010578e:	e8 ad e8 ff ff       	call   80104040 <kill>
80105793:	83 c4 10             	add    $0x10,%esp
}
80105796:	c9                   	leave  
80105797:	c3                   	ret    
80105798:	90                   	nop
80105799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
801057a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
801057a5:	c9                   	leave  
801057a6:	c3                   	ret    
801057a7:	89 f6                	mov    %esi,%esi
801057a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057b0 <sys_getpid>:

int
sys_getpid(void)
{
801057b0:	55                   	push   %ebp
801057b1:	89 e5                	mov    %esp,%ebp
801057b3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801057b6:	e8 05 e0 ff ff       	call   801037c0 <myproc>
801057bb:	8b 40 10             	mov    0x10(%eax),%eax
}
801057be:	c9                   	leave  
801057bf:	c3                   	ret    

801057c0 <sys_sbrk>:

int
sys_sbrk(void)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801057c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return myproc()->pid;
}

int
sys_sbrk(void)
{
801057c7:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801057ca:	50                   	push   %eax
801057cb:	6a 00                	push   $0x0
801057cd:	e8 0e f2 ff ff       	call   801049e0 <argint>
801057d2:	83 c4 10             	add    $0x10,%esp
801057d5:	85 c0                	test   %eax,%eax
801057d7:	78 27                	js     80105800 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801057d9:	e8 e2 df ff ff       	call   801037c0 <myproc>
  if(growproc(n) < 0)
801057de:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
801057e1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801057e3:	ff 75 f4             	pushl  -0xc(%ebp)
801057e6:	e8 65 e1 ff ff       	call   80103950 <growproc>
801057eb:	83 c4 10             	add    $0x10,%esp
801057ee:	85 c0                	test   %eax,%eax
801057f0:	78 0e                	js     80105800 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801057f2:	89 d8                	mov    %ebx,%eax
801057f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057f7:	c9                   	leave  
801057f8:	c3                   	ret    
801057f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80105800:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105805:	eb eb                	jmp    801057f2 <sys_sbrk+0x32>
80105807:	89 f6                	mov    %esi,%esi
80105809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105810 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80105810:	55                   	push   %ebp
80105811:	89 e5                	mov    %esp,%ebp
80105813:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105814:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
80105817:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
8010581a:	50                   	push   %eax
8010581b:	6a 00                	push   $0x0
8010581d:	e8 be f1 ff ff       	call   801049e0 <argint>
80105822:	83 c4 10             	add    $0x10,%esp
80105825:	85 c0                	test   %eax,%eax
80105827:	78 44                	js     8010586d <sys_sleep+0x5d>
    return -1;
  //acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105829:	8b 55 f4             	mov    -0xc(%ebp),%edx
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  //acquire(&tickslock);
  ticks0 = ticks;
8010582c:	8b 1d 00 5a 11 80    	mov    0x80115a00,%ebx
  while(ticks - ticks0 < n){
80105832:	85 d2                	test   %edx,%edx
80105834:	75 2b                	jne    80105861 <sys_sleep+0x51>
80105836:	eb 48                	jmp    80105880 <sys_sleep+0x70>
80105838:	90                   	nop
80105839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      //release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105840:	83 ec 08             	sub    $0x8,%esp
80105843:	68 c0 51 11 80       	push   $0x801151c0
80105848:	68 00 5a 11 80       	push   $0x80115a00
8010584d:	e8 ce e5 ff ff       	call   80103e20 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  //acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105852:	a1 00 5a 11 80       	mov    0x80115a00,%eax
80105857:	83 c4 10             	add    $0x10,%esp
8010585a:	29 d8                	sub    %ebx,%eax
8010585c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010585f:	73 1f                	jae    80105880 <sys_sleep+0x70>
    if(myproc()->killed){
80105861:	e8 5a df ff ff       	call   801037c0 <myproc>
80105866:	8b 40 24             	mov    0x24(%eax),%eax
80105869:	85 c0                	test   %eax,%eax
8010586b:	74 d3                	je     80105840 <sys_sleep+0x30>
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
8010586d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  //release(&tickslock);
  return 0;
}
80105872:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105875:	c9                   	leave  
80105876:	c3                   	ret    
80105877:	89 f6                	mov    %esi,%esi
80105879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  //release(&tickslock);
  return 0;
80105880:	31 c0                	xor    %eax,%eax
}
80105882:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105885:	c9                   	leave  
80105886:	c3                   	ret    
80105887:	89 f6                	mov    %esi,%esi
80105889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105890 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105890:	55                   	push   %ebp

  //acquire(&tickslock);
  xticks = ticks;
  //release(&tickslock);
  return xticks;
}
80105891:	a1 00 5a 11 80       	mov    0x80115a00,%eax

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105896:	89 e5                	mov    %esp,%ebp

  //acquire(&tickslock);
  xticks = ticks;
  //release(&tickslock);
  return xticks;
}
80105898:	5d                   	pop    %ebp
80105899:	c3                   	ret    
8010589a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801058a0 <sys_getprocs>:

int sys_getprocs(void)
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	83 ec 20             	sub    $0x20,%esp
  struct uproc *table;
  int zi = sizeof(*table);
  int stack_arg;
  //return failure to retrieve arguments
  if (argint(0, &stack_arg) < 0 || argptr(1, (void *)&table, zi) < 0)
801058a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058a9:	50                   	push   %eax
801058aa:	6a 00                	push   $0x0
801058ac:	e8 2f f1 ff ff       	call   801049e0 <argint>
801058b1:	83 c4 10             	add    $0x10,%esp
801058b4:	85 c0                	test   %eax,%eax
801058b6:	78 30                	js     801058e8 <sys_getprocs+0x48>
801058b8:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058bb:	83 ec 04             	sub    $0x4,%esp
801058be:	6a 64                	push   $0x64
801058c0:	50                   	push   %eax
801058c1:	6a 01                	push   $0x1
801058c3:	e8 68 f1 ff ff       	call   80104a30 <argptr>
801058c8:	83 c4 10             	add    $0x10,%esp
801058cb:	85 c0                	test   %eax,%eax
801058cd:	78 19                	js     801058e8 <sys_getprocs+0x48>
    return -1;
  //we're just a wrapper for getprocs() in proc.c
  return getprocs((uint)stack_arg, table);
801058cf:	83 ec 08             	sub    $0x8,%esp
801058d2:	ff 75 f0             	pushl  -0x10(%ebp)
801058d5:	ff 75 f4             	pushl  -0xc(%ebp)
801058d8:	e8 f3 e8 ff ff       	call   801041d0 <getprocs>
801058dd:	83 c4 10             	add    $0x10,%esp
}
801058e0:	c9                   	leave  
801058e1:	c3                   	ret    
801058e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  struct uproc *table;
  int zi = sizeof(*table);
  int stack_arg;
  //return failure to retrieve arguments
  if (argint(0, &stack_arg) < 0 || argptr(1, (void *)&table, zi) < 0)
    return -1;
801058e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  //we're just a wrapper for getprocs() in proc.c
  return getprocs((uint)stack_arg, table);
}
801058ed:	c9                   	leave  
801058ee:	c3                   	ret    
801058ef:	90                   	nop

801058f0 <sys_setpriority>:

// sets the priority of the calling process
// no list transitions since proc must be in RUNNING
int sys_setpriority(void)
{
801058f0:	55                   	push   %ebp
801058f1:	89 e5                	mov    %esp,%ebp
801058f3:	83 ec 20             	sub    $0x20,%esp
  int pid;
  int priority;
  if (argint(0, &pid) < 0 || argint(1, &priority) < 0)
801058f6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058f9:	50                   	push   %eax
801058fa:	6a 00                	push   $0x0
801058fc:	e8 df f0 ff ff       	call   801049e0 <argint>
80105901:	83 c4 10             	add    $0x10,%esp
80105904:	85 c0                	test   %eax,%eax
80105906:	78 28                	js     80105930 <sys_setpriority+0x40>
80105908:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010590b:	83 ec 08             	sub    $0x8,%esp
8010590e:	50                   	push   %eax
8010590f:	6a 01                	push   $0x1
80105911:	e8 ca f0 ff ff       	call   801049e0 <argint>
80105916:	83 c4 10             	add    $0x10,%esp
80105919:	85 c0                	test   %eax,%eax
8010591b:	78 13                	js     80105930 <sys_setpriority+0x40>
    return -1;

  //access to lists are needed, so call into proc.c
  return setpriority(pid, priority);
8010591d:	83 ec 08             	sub    $0x8,%esp
80105920:	ff 75 f4             	pushl  -0xc(%ebp)
80105923:	ff 75 f0             	pushl  -0x10(%ebp)
80105926:	e8 b5 e9 ff ff       	call   801042e0 <setpriority>
8010592b:	83 c4 10             	add    $0x10,%esp
}
8010592e:	c9                   	leave  
8010592f:	c3                   	ret    
int sys_setpriority(void)
{
  int pid;
  int priority;
  if (argint(0, &pid) < 0 || argint(1, &priority) < 0)
    return -1;
80105930:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

  //access to lists are needed, so call into proc.c
  return setpriority(pid, priority);
}
80105935:	c9                   	leave  
80105936:	c3                   	ret    

80105937 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105937:	1e                   	push   %ds
  pushl %es
80105938:	06                   	push   %es
  pushl %fs
80105939:	0f a0                	push   %fs
  pushl %gs
8010593b:	0f a8                	push   %gs
  pushal
8010593d:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
8010593e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105942:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105944:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105946:	54                   	push   %esp
  call trap
80105947:	e8 c4 00 00 00       	call   80105a10 <trap>
  addl $4, %esp
8010594c:	83 c4 04             	add    $0x4,%esp

8010594f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
8010594f:	61                   	popa   
  popl %gs
80105950:	0f a9                	pop    %gs
  popl %fs
80105952:	0f a1                	pop    %fs
  popl %es
80105954:	07                   	pop    %es
  popl %ds
80105955:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105956:	83 c4 08             	add    $0x8,%esp
  iret
80105959:	cf                   	iret   
8010595a:	66 90                	xchg   %ax,%ax
8010595c:	66 90                	xchg   %ax,%ax
8010595e:	66 90                	xchg   %ax,%ax

80105960 <tvinit>:
struct spinlock tickslock;
uint ticks __attribute__((aligned(4)));

void
tvinit(void)
{
80105960:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105961:	31 c0                	xor    %eax,%eax
struct spinlock tickslock;
uint ticks __attribute__((aligned(4)));

void
tvinit(void)
{
80105963:	89 e5                	mov    %esp,%ebp
80105965:	8d 76 00             	lea    0x0(%esi),%esi
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105968:	8b 14 85 80 a0 10 80 	mov    -0x7fef5f80(,%eax,4),%edx
8010596f:	b9 08 00 00 00       	mov    $0x8,%ecx
80105974:	c6 04 c5 04 52 11 80 	movb   $0x0,-0x7feeadfc(,%eax,8)
8010597b:	00 
8010597c:	66 89 0c c5 02 52 11 	mov    %cx,-0x7feeadfe(,%eax,8)
80105983:	80 
80105984:	c6 04 c5 05 52 11 80 	movb   $0x8e,-0x7feeadfb(,%eax,8)
8010598b:	8e 
8010598c:	66 89 14 c5 00 52 11 	mov    %dx,-0x7feeae00(,%eax,8)
80105993:	80 
80105994:	c1 ea 10             	shr    $0x10,%edx
80105997:	66 89 14 c5 06 52 11 	mov    %dx,-0x7feeadfa(,%eax,8)
8010599e:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
8010599f:	83 c0 01             	add    $0x1,%eax
801059a2:	3d 00 01 00 00       	cmp    $0x100,%eax
801059a7:	75 bf                	jne    80105968 <tvinit+0x8>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059a9:	a1 80 a1 10 80       	mov    0x8010a180,%eax
801059ae:	ba 08 00 00 00       	mov    $0x8,%edx
801059b3:	c6 05 04 54 11 80 00 	movb   $0x0,0x80115404
801059ba:	66 89 15 02 54 11 80 	mov    %dx,0x80115402
801059c1:	c6 05 05 54 11 80 ef 	movb   $0xef,0x80115405

  //initlock(&tickslock, "time");
}
801059c8:	5d                   	pop    %ebp
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059c9:	66 a3 00 54 11 80    	mov    %ax,0x80115400
801059cf:	c1 e8 10             	shr    $0x10,%eax
801059d2:	66 a3 06 54 11 80    	mov    %ax,0x80115406

  //initlock(&tickslock, "time");
}
801059d8:	c3                   	ret    
801059d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801059e0 <idtinit>:

void
idtinit(void)
{
801059e0:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
801059e1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801059e6:	89 e5                	mov    %esp,%ebp
801059e8:	83 ec 10             	sub    $0x10,%esp
801059eb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801059ef:	b8 00 52 11 80       	mov    $0x80115200,%eax
801059f4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801059f8:	c1 e8 10             	shr    $0x10,%eax
801059fb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
801059ff:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105a02:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105a05:	c9                   	leave  
80105a06:	c3                   	ret    
80105a07:	89 f6                	mov    %esi,%esi
80105a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a10 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105a10:	55                   	push   %ebp
80105a11:	89 e5                	mov    %esp,%ebp
80105a13:	57                   	push   %edi
80105a14:	56                   	push   %esi
80105a15:	53                   	push   %ebx
80105a16:	83 ec 1c             	sub    $0x1c,%esp
80105a19:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80105a1c:	8b 47 30             	mov    0x30(%edi),%eax
80105a1f:	83 f8 40             	cmp    $0x40,%eax
80105a22:	0f 84 88 01 00 00    	je     80105bb0 <trap+0x1a0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105a28:	83 e8 20             	sub    $0x20,%eax
80105a2b:	83 f8 1f             	cmp    $0x1f,%eax
80105a2e:	77 10                	ja     80105a40 <trap+0x30>
80105a30:	ff 24 85 a4 7a 10 80 	jmp    *-0x7fef855c(,%eax,4)
80105a37:	89 f6                	mov    %esi,%esi
80105a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105a40:	e8 7b dd ff ff       	call   801037c0 <myproc>
80105a45:	85 c0                	test   %eax,%eax
80105a47:	0f 84 bf 01 00 00    	je     80105c0c <trap+0x1fc>
80105a4d:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105a51:	0f 84 b5 01 00 00    	je     80105c0c <trap+0x1fc>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105a57:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a5a:	8b 57 38             	mov    0x38(%edi),%edx
80105a5d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105a60:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105a63:	e8 38 dd ff ff       	call   801037a0 <cpuid>
80105a68:	8b 77 34             	mov    0x34(%edi),%esi
80105a6b:	8b 5f 30             	mov    0x30(%edi),%ebx
80105a6e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105a71:	e8 4a dd ff ff       	call   801037c0 <myproc>
80105a76:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105a79:	e8 42 dd ff ff       	call   801037c0 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a7e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105a81:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105a84:	51                   	push   %ecx
80105a85:	52                   	push   %edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105a86:	8b 55 e0             	mov    -0x20(%ebp),%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a89:	ff 75 e4             	pushl  -0x1c(%ebp)
80105a8c:	56                   	push   %esi
80105a8d:	53                   	push   %ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105a8e:	83 c2 6c             	add    $0x6c,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a91:	52                   	push   %edx
80105a92:	ff 70 10             	pushl  0x10(%eax)
80105a95:	68 5c 7a 10 80       	push   $0x80107a5c
80105a9a:	e8 c1 ab ff ff       	call   80100660 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105a9f:	83 c4 20             	add    $0x20,%esp
80105aa2:	e8 19 dd ff ff       	call   801037c0 <myproc>
80105aa7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105aae:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ab0:	e8 0b dd ff ff       	call   801037c0 <myproc>
80105ab5:	85 c0                	test   %eax,%eax
80105ab7:	74 0c                	je     80105ac5 <trap+0xb5>
80105ab9:	e8 02 dd ff ff       	call   801037c0 <myproc>
80105abe:	8b 50 24             	mov    0x24(%eax),%edx
80105ac1:	85 d2                	test   %edx,%edx
80105ac3:	75 4b                	jne    80105b10 <trap+0x100>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105ac5:	e8 f6 dc ff ff       	call   801037c0 <myproc>
80105aca:	85 c0                	test   %eax,%eax
80105acc:	74 0b                	je     80105ad9 <trap+0xc9>
80105ace:	e8 ed dc ff ff       	call   801037c0 <myproc>
80105ad3:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105ad7:	74 4f                	je     80105b28 <trap+0x118>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ad9:	e8 e2 dc ff ff       	call   801037c0 <myproc>
80105ade:	85 c0                	test   %eax,%eax
80105ae0:	74 1d                	je     80105aff <trap+0xef>
80105ae2:	e8 d9 dc ff ff       	call   801037c0 <myproc>
80105ae7:	8b 40 24             	mov    0x24(%eax),%eax
80105aea:	85 c0                	test   %eax,%eax
80105aec:	74 11                	je     80105aff <trap+0xef>
80105aee:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105af2:	83 e0 03             	and    $0x3,%eax
80105af5:	66 83 f8 03          	cmp    $0x3,%ax
80105af9:	0f 84 da 00 00 00    	je     80105bd9 <trap+0x1c9>
    exit();
}
80105aff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b02:	5b                   	pop    %ebx
80105b03:	5e                   	pop    %esi
80105b04:	5f                   	pop    %edi
80105b05:	5d                   	pop    %ebp
80105b06:	c3                   	ret    
80105b07:	89 f6                	mov    %esi,%esi
80105b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b10:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105b14:	83 e0 03             	and    $0x3,%eax
80105b17:	66 83 f8 03          	cmp    $0x3,%ax
80105b1b:	75 a8                	jne    80105ac5 <trap+0xb5>
    exit();
80105b1d:	e8 7e e1 ff ff       	call   80103ca0 <exit>
80105b22:	eb a1                	jmp    80105ac5 <trap+0xb5>
80105b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105b28:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105b2c:	75 ab                	jne    80105ad9 <trap+0xc9>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
80105b2e:	e8 9d e2 ff ff       	call   80103dd0 <yield>
80105b33:	eb a4                	jmp    80105ad9 <trap+0xc9>
80105b35:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105b38:	e8 63 dc ff ff       	call   801037a0 <cpuid>
80105b3d:	85 c0                	test   %eax,%eax
80105b3f:	0f 84 ab 00 00 00    	je     80105bf0 <trap+0x1e0>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80105b45:	e8 d6 cb ff ff       	call   80102720 <lapiceoi>
    break;
80105b4a:	e9 61 ff ff ff       	jmp    80105ab0 <trap+0xa0>
80105b4f:	90                   	nop
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105b50:	e8 8b ca ff ff       	call   801025e0 <kbdintr>
    lapiceoi();
80105b55:	e8 c6 cb ff ff       	call   80102720 <lapiceoi>
    break;
80105b5a:	e9 51 ff ff ff       	jmp    80105ab0 <trap+0xa0>
80105b5f:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105b60:	e8 4b 02 00 00       	call   80105db0 <uartintr>
    lapiceoi();
80105b65:	e8 b6 cb ff ff       	call   80102720 <lapiceoi>
    break;
80105b6a:	e9 41 ff ff ff       	jmp    80105ab0 <trap+0xa0>
80105b6f:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105b70:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105b74:	8b 77 38             	mov    0x38(%edi),%esi
80105b77:	e8 24 dc ff ff       	call   801037a0 <cpuid>
80105b7c:	56                   	push   %esi
80105b7d:	53                   	push   %ebx
80105b7e:	50                   	push   %eax
80105b7f:	68 04 7a 10 80       	push   $0x80107a04
80105b84:	e8 d7 aa ff ff       	call   80100660 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80105b89:	e8 92 cb ff ff       	call   80102720 <lapiceoi>
    break;
80105b8e:	83 c4 10             	add    $0x10,%esp
80105b91:	e9 1a ff ff ff       	jmp    80105ab0 <trap+0xa0>
80105b96:	8d 76 00             	lea    0x0(%esi),%esi
80105b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      //release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105ba0:	e8 ab c4 ff ff       	call   80102050 <ideintr>
80105ba5:	eb 9e                	jmp    80105b45 <trap+0x135>
80105ba7:	89 f6                	mov    %esi,%esi
80105ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80105bb0:	e8 0b dc ff ff       	call   801037c0 <myproc>
80105bb5:	8b 58 24             	mov    0x24(%eax),%ebx
80105bb8:	85 db                	test   %ebx,%ebx
80105bba:	75 2c                	jne    80105be8 <trap+0x1d8>
      exit();
    myproc()->tf = tf;
80105bbc:	e8 ff db ff ff       	call   801037c0 <myproc>
80105bc1:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105bc4:	e8 07 ef ff ff       	call   80104ad0 <syscall>
    if(myproc()->killed)
80105bc9:	e8 f2 db ff ff       	call   801037c0 <myproc>
80105bce:	8b 48 24             	mov    0x24(%eax),%ecx
80105bd1:	85 c9                	test   %ecx,%ecx
80105bd3:	0f 84 26 ff ff ff    	je     80105aff <trap+0xef>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80105bd9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bdc:	5b                   	pop    %ebx
80105bdd:	5e                   	pop    %esi
80105bde:	5f                   	pop    %edi
80105bdf:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
80105be0:	e9 bb e0 ff ff       	jmp    80103ca0 <exit>
80105be5:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
80105be8:	e8 b3 e0 ff ff       	call   80103ca0 <exit>
80105bed:	eb cd                	jmp    80105bbc <trap+0x1ac>
80105bef:	90                   	nop
// atom_inc() added to simplify handling of ticks global
static inline void
atom_inc(volatile int *num)
{
  asm volatile("lock incl %0" : "=m"(*num));
80105bf0:	f0 ff 05 00 5a 11 80 	lock incl 0x80115a00
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      //acquire(&tickslock);
      //ticks++;
      atom_inc((int *)&ticks); // guaranteed atomic so no lock necessary
      wakeup(&ticks);
80105bf7:	83 ec 0c             	sub    $0xc,%esp
80105bfa:	68 00 5a 11 80       	push   $0x80115a00
80105bff:	e8 dc e3 ff ff       	call   80103fe0 <wakeup>
80105c04:	83 c4 10             	add    $0x10,%esp
80105c07:	e9 39 ff ff ff       	jmp    80105b45 <trap+0x135>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105c0c:	0f 20 d6             	mov    %cr2,%esi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105c0f:	8b 5f 38             	mov    0x38(%edi),%ebx
80105c12:	e8 89 db ff ff       	call   801037a0 <cpuid>
80105c17:	83 ec 0c             	sub    $0xc,%esp
80105c1a:	56                   	push   %esi
80105c1b:	53                   	push   %ebx
80105c1c:	50                   	push   %eax
80105c1d:	ff 77 30             	pushl  0x30(%edi)
80105c20:	68 28 7a 10 80       	push   $0x80107a28
80105c25:	e8 36 aa ff ff       	call   80100660 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80105c2a:	83 c4 14             	add    $0x14,%esp
80105c2d:	68 9f 7a 10 80       	push   $0x80107a9f
80105c32:	e8 39 a7 ff ff       	call   80100370 <panic>
80105c37:	66 90                	xchg   %ax,%ax
80105c39:	66 90                	xchg   %ax,%ax
80105c3b:	66 90                	xchg   %ax,%ax
80105c3d:	66 90                	xchg   %ax,%ax
80105c3f:	90                   	nop

80105c40 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105c40:	a1 1c a6 10 80       	mov    0x8010a61c,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105c45:	55                   	push   %ebp
80105c46:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105c48:	85 c0                	test   %eax,%eax
80105c4a:	74 1c                	je     80105c68 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105c4c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105c51:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105c52:	a8 01                	test   $0x1,%al
80105c54:	74 12                	je     80105c68 <uartgetc+0x28>
80105c56:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c5b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105c5c:	0f b6 c0             	movzbl %al,%eax
}
80105c5f:	5d                   	pop    %ebp
80105c60:	c3                   	ret    
80105c61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80105c68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
80105c6d:	5d                   	pop    %ebp
80105c6e:	c3                   	ret    
80105c6f:	90                   	nop

80105c70 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80105c70:	55                   	push   %ebp
80105c71:	89 e5                	mov    %esp,%ebp
80105c73:	57                   	push   %edi
80105c74:	56                   	push   %esi
80105c75:	53                   	push   %ebx
80105c76:	89 c7                	mov    %eax,%edi
80105c78:	bb 80 00 00 00       	mov    $0x80,%ebx
80105c7d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105c82:	83 ec 0c             	sub    $0xc,%esp
80105c85:	eb 1b                	jmp    80105ca2 <uartputc.part.0+0x32>
80105c87:	89 f6                	mov    %esi,%esi
80105c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105c90:	83 ec 0c             	sub    $0xc,%esp
80105c93:	6a 0a                	push   $0xa
80105c95:	e8 a6 ca ff ff       	call   80102740 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105c9a:	83 c4 10             	add    $0x10,%esp
80105c9d:	83 eb 01             	sub    $0x1,%ebx
80105ca0:	74 07                	je     80105ca9 <uartputc.part.0+0x39>
80105ca2:	89 f2                	mov    %esi,%edx
80105ca4:	ec                   	in     (%dx),%al
80105ca5:	a8 20                	test   $0x20,%al
80105ca7:	74 e7                	je     80105c90 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105ca9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105cae:	89 f8                	mov    %edi,%eax
80105cb0:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80105cb1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cb4:	5b                   	pop    %ebx
80105cb5:	5e                   	pop    %esi
80105cb6:	5f                   	pop    %edi
80105cb7:	5d                   	pop    %ebp
80105cb8:	c3                   	ret    
80105cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105cc0 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105cc0:	55                   	push   %ebp
80105cc1:	31 c9                	xor    %ecx,%ecx
80105cc3:	89 c8                	mov    %ecx,%eax
80105cc5:	89 e5                	mov    %esp,%ebp
80105cc7:	57                   	push   %edi
80105cc8:	56                   	push   %esi
80105cc9:	53                   	push   %ebx
80105cca:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105ccf:	89 da                	mov    %ebx,%edx
80105cd1:	83 ec 0c             	sub    $0xc,%esp
80105cd4:	ee                   	out    %al,(%dx)
80105cd5:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105cda:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105cdf:	89 fa                	mov    %edi,%edx
80105ce1:	ee                   	out    %al,(%dx)
80105ce2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105ce7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105cec:	ee                   	out    %al,(%dx)
80105ced:	be f9 03 00 00       	mov    $0x3f9,%esi
80105cf2:	89 c8                	mov    %ecx,%eax
80105cf4:	89 f2                	mov    %esi,%edx
80105cf6:	ee                   	out    %al,(%dx)
80105cf7:	b8 03 00 00 00       	mov    $0x3,%eax
80105cfc:	89 fa                	mov    %edi,%edx
80105cfe:	ee                   	out    %al,(%dx)
80105cff:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105d04:	89 c8                	mov    %ecx,%eax
80105d06:	ee                   	out    %al,(%dx)
80105d07:	b8 01 00 00 00       	mov    $0x1,%eax
80105d0c:	89 f2                	mov    %esi,%edx
80105d0e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d0f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d14:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105d15:	3c ff                	cmp    $0xff,%al
80105d17:	74 5a                	je     80105d73 <uartinit+0xb3>
    return;
  uart = 1;
80105d19:	c7 05 1c a6 10 80 01 	movl   $0x1,0x8010a61c
80105d20:	00 00 00 
80105d23:	89 da                	mov    %ebx,%edx
80105d25:	ec                   	in     (%dx),%al
80105d26:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d2b:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
80105d2c:	83 ec 08             	sub    $0x8,%esp
80105d2f:	bb 24 7b 10 80       	mov    $0x80107b24,%ebx
80105d34:	6a 00                	push   $0x0
80105d36:	6a 04                	push   $0x4
80105d38:	e8 63 c5 ff ff       	call   801022a0 <ioapicenable>
80105d3d:	83 c4 10             	add    $0x10,%esp
80105d40:	b8 78 00 00 00       	mov    $0x78,%eax
80105d45:	eb 13                	jmp    80105d5a <uartinit+0x9a>
80105d47:	89 f6                	mov    %esi,%esi
80105d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105d50:	83 c3 01             	add    $0x1,%ebx
80105d53:	0f be 03             	movsbl (%ebx),%eax
80105d56:	84 c0                	test   %al,%al
80105d58:	74 19                	je     80105d73 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
80105d5a:	8b 15 1c a6 10 80    	mov    0x8010a61c,%edx
80105d60:	85 d2                	test   %edx,%edx
80105d62:	74 ec                	je     80105d50 <uartinit+0x90>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105d64:	83 c3 01             	add    $0x1,%ebx
80105d67:	e8 04 ff ff ff       	call   80105c70 <uartputc.part.0>
80105d6c:	0f be 03             	movsbl (%ebx),%eax
80105d6f:	84 c0                	test   %al,%al
80105d71:	75 e7                	jne    80105d5a <uartinit+0x9a>
    uartputc(*p);
}
80105d73:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d76:	5b                   	pop    %ebx
80105d77:	5e                   	pop    %esi
80105d78:	5f                   	pop    %edi
80105d79:	5d                   	pop    %ebp
80105d7a:	c3                   	ret    
80105d7b:	90                   	nop
80105d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d80 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80105d80:	8b 15 1c a6 10 80    	mov    0x8010a61c,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105d86:	55                   	push   %ebp
80105d87:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80105d89:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105d8b:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
80105d8e:	74 10                	je     80105da0 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80105d90:	5d                   	pop    %ebp
80105d91:	e9 da fe ff ff       	jmp    80105c70 <uartputc.part.0>
80105d96:	8d 76 00             	lea    0x0(%esi),%esi
80105d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105da0:	5d                   	pop    %ebp
80105da1:	c3                   	ret    
80105da2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105db0 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105db0:	55                   	push   %ebp
80105db1:	89 e5                	mov    %esp,%ebp
80105db3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105db6:	68 40 5c 10 80       	push   $0x80105c40
80105dbb:	e8 20 aa ff ff       	call   801007e0 <consoleintr>
}
80105dc0:	83 c4 10             	add    $0x10,%esp
80105dc3:	c9                   	leave  
80105dc4:	c3                   	ret    

80105dc5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105dc5:	6a 00                	push   $0x0
  pushl $0
80105dc7:	6a 00                	push   $0x0
  jmp alltraps
80105dc9:	e9 69 fb ff ff       	jmp    80105937 <alltraps>

80105dce <vector1>:
.globl vector1
vector1:
  pushl $0
80105dce:	6a 00                	push   $0x0
  pushl $1
80105dd0:	6a 01                	push   $0x1
  jmp alltraps
80105dd2:	e9 60 fb ff ff       	jmp    80105937 <alltraps>

80105dd7 <vector2>:
.globl vector2
vector2:
  pushl $0
80105dd7:	6a 00                	push   $0x0
  pushl $2
80105dd9:	6a 02                	push   $0x2
  jmp alltraps
80105ddb:	e9 57 fb ff ff       	jmp    80105937 <alltraps>

80105de0 <vector3>:
.globl vector3
vector3:
  pushl $0
80105de0:	6a 00                	push   $0x0
  pushl $3
80105de2:	6a 03                	push   $0x3
  jmp alltraps
80105de4:	e9 4e fb ff ff       	jmp    80105937 <alltraps>

80105de9 <vector4>:
.globl vector4
vector4:
  pushl $0
80105de9:	6a 00                	push   $0x0
  pushl $4
80105deb:	6a 04                	push   $0x4
  jmp alltraps
80105ded:	e9 45 fb ff ff       	jmp    80105937 <alltraps>

80105df2 <vector5>:
.globl vector5
vector5:
  pushl $0
80105df2:	6a 00                	push   $0x0
  pushl $5
80105df4:	6a 05                	push   $0x5
  jmp alltraps
80105df6:	e9 3c fb ff ff       	jmp    80105937 <alltraps>

80105dfb <vector6>:
.globl vector6
vector6:
  pushl $0
80105dfb:	6a 00                	push   $0x0
  pushl $6
80105dfd:	6a 06                	push   $0x6
  jmp alltraps
80105dff:	e9 33 fb ff ff       	jmp    80105937 <alltraps>

80105e04 <vector7>:
.globl vector7
vector7:
  pushl $0
80105e04:	6a 00                	push   $0x0
  pushl $7
80105e06:	6a 07                	push   $0x7
  jmp alltraps
80105e08:	e9 2a fb ff ff       	jmp    80105937 <alltraps>

80105e0d <vector8>:
.globl vector8
vector8:
  pushl $8
80105e0d:	6a 08                	push   $0x8
  jmp alltraps
80105e0f:	e9 23 fb ff ff       	jmp    80105937 <alltraps>

80105e14 <vector9>:
.globl vector9
vector9:
  pushl $0
80105e14:	6a 00                	push   $0x0
  pushl $9
80105e16:	6a 09                	push   $0x9
  jmp alltraps
80105e18:	e9 1a fb ff ff       	jmp    80105937 <alltraps>

80105e1d <vector10>:
.globl vector10
vector10:
  pushl $10
80105e1d:	6a 0a                	push   $0xa
  jmp alltraps
80105e1f:	e9 13 fb ff ff       	jmp    80105937 <alltraps>

80105e24 <vector11>:
.globl vector11
vector11:
  pushl $11
80105e24:	6a 0b                	push   $0xb
  jmp alltraps
80105e26:	e9 0c fb ff ff       	jmp    80105937 <alltraps>

80105e2b <vector12>:
.globl vector12
vector12:
  pushl $12
80105e2b:	6a 0c                	push   $0xc
  jmp alltraps
80105e2d:	e9 05 fb ff ff       	jmp    80105937 <alltraps>

80105e32 <vector13>:
.globl vector13
vector13:
  pushl $13
80105e32:	6a 0d                	push   $0xd
  jmp alltraps
80105e34:	e9 fe fa ff ff       	jmp    80105937 <alltraps>

80105e39 <vector14>:
.globl vector14
vector14:
  pushl $14
80105e39:	6a 0e                	push   $0xe
  jmp alltraps
80105e3b:	e9 f7 fa ff ff       	jmp    80105937 <alltraps>

80105e40 <vector15>:
.globl vector15
vector15:
  pushl $0
80105e40:	6a 00                	push   $0x0
  pushl $15
80105e42:	6a 0f                	push   $0xf
  jmp alltraps
80105e44:	e9 ee fa ff ff       	jmp    80105937 <alltraps>

80105e49 <vector16>:
.globl vector16
vector16:
  pushl $0
80105e49:	6a 00                	push   $0x0
  pushl $16
80105e4b:	6a 10                	push   $0x10
  jmp alltraps
80105e4d:	e9 e5 fa ff ff       	jmp    80105937 <alltraps>

80105e52 <vector17>:
.globl vector17
vector17:
  pushl $17
80105e52:	6a 11                	push   $0x11
  jmp alltraps
80105e54:	e9 de fa ff ff       	jmp    80105937 <alltraps>

80105e59 <vector18>:
.globl vector18
vector18:
  pushl $0
80105e59:	6a 00                	push   $0x0
  pushl $18
80105e5b:	6a 12                	push   $0x12
  jmp alltraps
80105e5d:	e9 d5 fa ff ff       	jmp    80105937 <alltraps>

80105e62 <vector19>:
.globl vector19
vector19:
  pushl $0
80105e62:	6a 00                	push   $0x0
  pushl $19
80105e64:	6a 13                	push   $0x13
  jmp alltraps
80105e66:	e9 cc fa ff ff       	jmp    80105937 <alltraps>

80105e6b <vector20>:
.globl vector20
vector20:
  pushl $0
80105e6b:	6a 00                	push   $0x0
  pushl $20
80105e6d:	6a 14                	push   $0x14
  jmp alltraps
80105e6f:	e9 c3 fa ff ff       	jmp    80105937 <alltraps>

80105e74 <vector21>:
.globl vector21
vector21:
  pushl $0
80105e74:	6a 00                	push   $0x0
  pushl $21
80105e76:	6a 15                	push   $0x15
  jmp alltraps
80105e78:	e9 ba fa ff ff       	jmp    80105937 <alltraps>

80105e7d <vector22>:
.globl vector22
vector22:
  pushl $0
80105e7d:	6a 00                	push   $0x0
  pushl $22
80105e7f:	6a 16                	push   $0x16
  jmp alltraps
80105e81:	e9 b1 fa ff ff       	jmp    80105937 <alltraps>

80105e86 <vector23>:
.globl vector23
vector23:
  pushl $0
80105e86:	6a 00                	push   $0x0
  pushl $23
80105e88:	6a 17                	push   $0x17
  jmp alltraps
80105e8a:	e9 a8 fa ff ff       	jmp    80105937 <alltraps>

80105e8f <vector24>:
.globl vector24
vector24:
  pushl $0
80105e8f:	6a 00                	push   $0x0
  pushl $24
80105e91:	6a 18                	push   $0x18
  jmp alltraps
80105e93:	e9 9f fa ff ff       	jmp    80105937 <alltraps>

80105e98 <vector25>:
.globl vector25
vector25:
  pushl $0
80105e98:	6a 00                	push   $0x0
  pushl $25
80105e9a:	6a 19                	push   $0x19
  jmp alltraps
80105e9c:	e9 96 fa ff ff       	jmp    80105937 <alltraps>

80105ea1 <vector26>:
.globl vector26
vector26:
  pushl $0
80105ea1:	6a 00                	push   $0x0
  pushl $26
80105ea3:	6a 1a                	push   $0x1a
  jmp alltraps
80105ea5:	e9 8d fa ff ff       	jmp    80105937 <alltraps>

80105eaa <vector27>:
.globl vector27
vector27:
  pushl $0
80105eaa:	6a 00                	push   $0x0
  pushl $27
80105eac:	6a 1b                	push   $0x1b
  jmp alltraps
80105eae:	e9 84 fa ff ff       	jmp    80105937 <alltraps>

80105eb3 <vector28>:
.globl vector28
vector28:
  pushl $0
80105eb3:	6a 00                	push   $0x0
  pushl $28
80105eb5:	6a 1c                	push   $0x1c
  jmp alltraps
80105eb7:	e9 7b fa ff ff       	jmp    80105937 <alltraps>

80105ebc <vector29>:
.globl vector29
vector29:
  pushl $0
80105ebc:	6a 00                	push   $0x0
  pushl $29
80105ebe:	6a 1d                	push   $0x1d
  jmp alltraps
80105ec0:	e9 72 fa ff ff       	jmp    80105937 <alltraps>

80105ec5 <vector30>:
.globl vector30
vector30:
  pushl $0
80105ec5:	6a 00                	push   $0x0
  pushl $30
80105ec7:	6a 1e                	push   $0x1e
  jmp alltraps
80105ec9:	e9 69 fa ff ff       	jmp    80105937 <alltraps>

80105ece <vector31>:
.globl vector31
vector31:
  pushl $0
80105ece:	6a 00                	push   $0x0
  pushl $31
80105ed0:	6a 1f                	push   $0x1f
  jmp alltraps
80105ed2:	e9 60 fa ff ff       	jmp    80105937 <alltraps>

80105ed7 <vector32>:
.globl vector32
vector32:
  pushl $0
80105ed7:	6a 00                	push   $0x0
  pushl $32
80105ed9:	6a 20                	push   $0x20
  jmp alltraps
80105edb:	e9 57 fa ff ff       	jmp    80105937 <alltraps>

80105ee0 <vector33>:
.globl vector33
vector33:
  pushl $0
80105ee0:	6a 00                	push   $0x0
  pushl $33
80105ee2:	6a 21                	push   $0x21
  jmp alltraps
80105ee4:	e9 4e fa ff ff       	jmp    80105937 <alltraps>

80105ee9 <vector34>:
.globl vector34
vector34:
  pushl $0
80105ee9:	6a 00                	push   $0x0
  pushl $34
80105eeb:	6a 22                	push   $0x22
  jmp alltraps
80105eed:	e9 45 fa ff ff       	jmp    80105937 <alltraps>

80105ef2 <vector35>:
.globl vector35
vector35:
  pushl $0
80105ef2:	6a 00                	push   $0x0
  pushl $35
80105ef4:	6a 23                	push   $0x23
  jmp alltraps
80105ef6:	e9 3c fa ff ff       	jmp    80105937 <alltraps>

80105efb <vector36>:
.globl vector36
vector36:
  pushl $0
80105efb:	6a 00                	push   $0x0
  pushl $36
80105efd:	6a 24                	push   $0x24
  jmp alltraps
80105eff:	e9 33 fa ff ff       	jmp    80105937 <alltraps>

80105f04 <vector37>:
.globl vector37
vector37:
  pushl $0
80105f04:	6a 00                	push   $0x0
  pushl $37
80105f06:	6a 25                	push   $0x25
  jmp alltraps
80105f08:	e9 2a fa ff ff       	jmp    80105937 <alltraps>

80105f0d <vector38>:
.globl vector38
vector38:
  pushl $0
80105f0d:	6a 00                	push   $0x0
  pushl $38
80105f0f:	6a 26                	push   $0x26
  jmp alltraps
80105f11:	e9 21 fa ff ff       	jmp    80105937 <alltraps>

80105f16 <vector39>:
.globl vector39
vector39:
  pushl $0
80105f16:	6a 00                	push   $0x0
  pushl $39
80105f18:	6a 27                	push   $0x27
  jmp alltraps
80105f1a:	e9 18 fa ff ff       	jmp    80105937 <alltraps>

80105f1f <vector40>:
.globl vector40
vector40:
  pushl $0
80105f1f:	6a 00                	push   $0x0
  pushl $40
80105f21:	6a 28                	push   $0x28
  jmp alltraps
80105f23:	e9 0f fa ff ff       	jmp    80105937 <alltraps>

80105f28 <vector41>:
.globl vector41
vector41:
  pushl $0
80105f28:	6a 00                	push   $0x0
  pushl $41
80105f2a:	6a 29                	push   $0x29
  jmp alltraps
80105f2c:	e9 06 fa ff ff       	jmp    80105937 <alltraps>

80105f31 <vector42>:
.globl vector42
vector42:
  pushl $0
80105f31:	6a 00                	push   $0x0
  pushl $42
80105f33:	6a 2a                	push   $0x2a
  jmp alltraps
80105f35:	e9 fd f9 ff ff       	jmp    80105937 <alltraps>

80105f3a <vector43>:
.globl vector43
vector43:
  pushl $0
80105f3a:	6a 00                	push   $0x0
  pushl $43
80105f3c:	6a 2b                	push   $0x2b
  jmp alltraps
80105f3e:	e9 f4 f9 ff ff       	jmp    80105937 <alltraps>

80105f43 <vector44>:
.globl vector44
vector44:
  pushl $0
80105f43:	6a 00                	push   $0x0
  pushl $44
80105f45:	6a 2c                	push   $0x2c
  jmp alltraps
80105f47:	e9 eb f9 ff ff       	jmp    80105937 <alltraps>

80105f4c <vector45>:
.globl vector45
vector45:
  pushl $0
80105f4c:	6a 00                	push   $0x0
  pushl $45
80105f4e:	6a 2d                	push   $0x2d
  jmp alltraps
80105f50:	e9 e2 f9 ff ff       	jmp    80105937 <alltraps>

80105f55 <vector46>:
.globl vector46
vector46:
  pushl $0
80105f55:	6a 00                	push   $0x0
  pushl $46
80105f57:	6a 2e                	push   $0x2e
  jmp alltraps
80105f59:	e9 d9 f9 ff ff       	jmp    80105937 <alltraps>

80105f5e <vector47>:
.globl vector47
vector47:
  pushl $0
80105f5e:	6a 00                	push   $0x0
  pushl $47
80105f60:	6a 2f                	push   $0x2f
  jmp alltraps
80105f62:	e9 d0 f9 ff ff       	jmp    80105937 <alltraps>

80105f67 <vector48>:
.globl vector48
vector48:
  pushl $0
80105f67:	6a 00                	push   $0x0
  pushl $48
80105f69:	6a 30                	push   $0x30
  jmp alltraps
80105f6b:	e9 c7 f9 ff ff       	jmp    80105937 <alltraps>

80105f70 <vector49>:
.globl vector49
vector49:
  pushl $0
80105f70:	6a 00                	push   $0x0
  pushl $49
80105f72:	6a 31                	push   $0x31
  jmp alltraps
80105f74:	e9 be f9 ff ff       	jmp    80105937 <alltraps>

80105f79 <vector50>:
.globl vector50
vector50:
  pushl $0
80105f79:	6a 00                	push   $0x0
  pushl $50
80105f7b:	6a 32                	push   $0x32
  jmp alltraps
80105f7d:	e9 b5 f9 ff ff       	jmp    80105937 <alltraps>

80105f82 <vector51>:
.globl vector51
vector51:
  pushl $0
80105f82:	6a 00                	push   $0x0
  pushl $51
80105f84:	6a 33                	push   $0x33
  jmp alltraps
80105f86:	e9 ac f9 ff ff       	jmp    80105937 <alltraps>

80105f8b <vector52>:
.globl vector52
vector52:
  pushl $0
80105f8b:	6a 00                	push   $0x0
  pushl $52
80105f8d:	6a 34                	push   $0x34
  jmp alltraps
80105f8f:	e9 a3 f9 ff ff       	jmp    80105937 <alltraps>

80105f94 <vector53>:
.globl vector53
vector53:
  pushl $0
80105f94:	6a 00                	push   $0x0
  pushl $53
80105f96:	6a 35                	push   $0x35
  jmp alltraps
80105f98:	e9 9a f9 ff ff       	jmp    80105937 <alltraps>

80105f9d <vector54>:
.globl vector54
vector54:
  pushl $0
80105f9d:	6a 00                	push   $0x0
  pushl $54
80105f9f:	6a 36                	push   $0x36
  jmp alltraps
80105fa1:	e9 91 f9 ff ff       	jmp    80105937 <alltraps>

80105fa6 <vector55>:
.globl vector55
vector55:
  pushl $0
80105fa6:	6a 00                	push   $0x0
  pushl $55
80105fa8:	6a 37                	push   $0x37
  jmp alltraps
80105faa:	e9 88 f9 ff ff       	jmp    80105937 <alltraps>

80105faf <vector56>:
.globl vector56
vector56:
  pushl $0
80105faf:	6a 00                	push   $0x0
  pushl $56
80105fb1:	6a 38                	push   $0x38
  jmp alltraps
80105fb3:	e9 7f f9 ff ff       	jmp    80105937 <alltraps>

80105fb8 <vector57>:
.globl vector57
vector57:
  pushl $0
80105fb8:	6a 00                	push   $0x0
  pushl $57
80105fba:	6a 39                	push   $0x39
  jmp alltraps
80105fbc:	e9 76 f9 ff ff       	jmp    80105937 <alltraps>

80105fc1 <vector58>:
.globl vector58
vector58:
  pushl $0
80105fc1:	6a 00                	push   $0x0
  pushl $58
80105fc3:	6a 3a                	push   $0x3a
  jmp alltraps
80105fc5:	e9 6d f9 ff ff       	jmp    80105937 <alltraps>

80105fca <vector59>:
.globl vector59
vector59:
  pushl $0
80105fca:	6a 00                	push   $0x0
  pushl $59
80105fcc:	6a 3b                	push   $0x3b
  jmp alltraps
80105fce:	e9 64 f9 ff ff       	jmp    80105937 <alltraps>

80105fd3 <vector60>:
.globl vector60
vector60:
  pushl $0
80105fd3:	6a 00                	push   $0x0
  pushl $60
80105fd5:	6a 3c                	push   $0x3c
  jmp alltraps
80105fd7:	e9 5b f9 ff ff       	jmp    80105937 <alltraps>

80105fdc <vector61>:
.globl vector61
vector61:
  pushl $0
80105fdc:	6a 00                	push   $0x0
  pushl $61
80105fde:	6a 3d                	push   $0x3d
  jmp alltraps
80105fe0:	e9 52 f9 ff ff       	jmp    80105937 <alltraps>

80105fe5 <vector62>:
.globl vector62
vector62:
  pushl $0
80105fe5:	6a 00                	push   $0x0
  pushl $62
80105fe7:	6a 3e                	push   $0x3e
  jmp alltraps
80105fe9:	e9 49 f9 ff ff       	jmp    80105937 <alltraps>

80105fee <vector63>:
.globl vector63
vector63:
  pushl $0
80105fee:	6a 00                	push   $0x0
  pushl $63
80105ff0:	6a 3f                	push   $0x3f
  jmp alltraps
80105ff2:	e9 40 f9 ff ff       	jmp    80105937 <alltraps>

80105ff7 <vector64>:
.globl vector64
vector64:
  pushl $0
80105ff7:	6a 00                	push   $0x0
  pushl $64
80105ff9:	6a 40                	push   $0x40
  jmp alltraps
80105ffb:	e9 37 f9 ff ff       	jmp    80105937 <alltraps>

80106000 <vector65>:
.globl vector65
vector65:
  pushl $0
80106000:	6a 00                	push   $0x0
  pushl $65
80106002:	6a 41                	push   $0x41
  jmp alltraps
80106004:	e9 2e f9 ff ff       	jmp    80105937 <alltraps>

80106009 <vector66>:
.globl vector66
vector66:
  pushl $0
80106009:	6a 00                	push   $0x0
  pushl $66
8010600b:	6a 42                	push   $0x42
  jmp alltraps
8010600d:	e9 25 f9 ff ff       	jmp    80105937 <alltraps>

80106012 <vector67>:
.globl vector67
vector67:
  pushl $0
80106012:	6a 00                	push   $0x0
  pushl $67
80106014:	6a 43                	push   $0x43
  jmp alltraps
80106016:	e9 1c f9 ff ff       	jmp    80105937 <alltraps>

8010601b <vector68>:
.globl vector68
vector68:
  pushl $0
8010601b:	6a 00                	push   $0x0
  pushl $68
8010601d:	6a 44                	push   $0x44
  jmp alltraps
8010601f:	e9 13 f9 ff ff       	jmp    80105937 <alltraps>

80106024 <vector69>:
.globl vector69
vector69:
  pushl $0
80106024:	6a 00                	push   $0x0
  pushl $69
80106026:	6a 45                	push   $0x45
  jmp alltraps
80106028:	e9 0a f9 ff ff       	jmp    80105937 <alltraps>

8010602d <vector70>:
.globl vector70
vector70:
  pushl $0
8010602d:	6a 00                	push   $0x0
  pushl $70
8010602f:	6a 46                	push   $0x46
  jmp alltraps
80106031:	e9 01 f9 ff ff       	jmp    80105937 <alltraps>

80106036 <vector71>:
.globl vector71
vector71:
  pushl $0
80106036:	6a 00                	push   $0x0
  pushl $71
80106038:	6a 47                	push   $0x47
  jmp alltraps
8010603a:	e9 f8 f8 ff ff       	jmp    80105937 <alltraps>

8010603f <vector72>:
.globl vector72
vector72:
  pushl $0
8010603f:	6a 00                	push   $0x0
  pushl $72
80106041:	6a 48                	push   $0x48
  jmp alltraps
80106043:	e9 ef f8 ff ff       	jmp    80105937 <alltraps>

80106048 <vector73>:
.globl vector73
vector73:
  pushl $0
80106048:	6a 00                	push   $0x0
  pushl $73
8010604a:	6a 49                	push   $0x49
  jmp alltraps
8010604c:	e9 e6 f8 ff ff       	jmp    80105937 <alltraps>

80106051 <vector74>:
.globl vector74
vector74:
  pushl $0
80106051:	6a 00                	push   $0x0
  pushl $74
80106053:	6a 4a                	push   $0x4a
  jmp alltraps
80106055:	e9 dd f8 ff ff       	jmp    80105937 <alltraps>

8010605a <vector75>:
.globl vector75
vector75:
  pushl $0
8010605a:	6a 00                	push   $0x0
  pushl $75
8010605c:	6a 4b                	push   $0x4b
  jmp alltraps
8010605e:	e9 d4 f8 ff ff       	jmp    80105937 <alltraps>

80106063 <vector76>:
.globl vector76
vector76:
  pushl $0
80106063:	6a 00                	push   $0x0
  pushl $76
80106065:	6a 4c                	push   $0x4c
  jmp alltraps
80106067:	e9 cb f8 ff ff       	jmp    80105937 <alltraps>

8010606c <vector77>:
.globl vector77
vector77:
  pushl $0
8010606c:	6a 00                	push   $0x0
  pushl $77
8010606e:	6a 4d                	push   $0x4d
  jmp alltraps
80106070:	e9 c2 f8 ff ff       	jmp    80105937 <alltraps>

80106075 <vector78>:
.globl vector78
vector78:
  pushl $0
80106075:	6a 00                	push   $0x0
  pushl $78
80106077:	6a 4e                	push   $0x4e
  jmp alltraps
80106079:	e9 b9 f8 ff ff       	jmp    80105937 <alltraps>

8010607e <vector79>:
.globl vector79
vector79:
  pushl $0
8010607e:	6a 00                	push   $0x0
  pushl $79
80106080:	6a 4f                	push   $0x4f
  jmp alltraps
80106082:	e9 b0 f8 ff ff       	jmp    80105937 <alltraps>

80106087 <vector80>:
.globl vector80
vector80:
  pushl $0
80106087:	6a 00                	push   $0x0
  pushl $80
80106089:	6a 50                	push   $0x50
  jmp alltraps
8010608b:	e9 a7 f8 ff ff       	jmp    80105937 <alltraps>

80106090 <vector81>:
.globl vector81
vector81:
  pushl $0
80106090:	6a 00                	push   $0x0
  pushl $81
80106092:	6a 51                	push   $0x51
  jmp alltraps
80106094:	e9 9e f8 ff ff       	jmp    80105937 <alltraps>

80106099 <vector82>:
.globl vector82
vector82:
  pushl $0
80106099:	6a 00                	push   $0x0
  pushl $82
8010609b:	6a 52                	push   $0x52
  jmp alltraps
8010609d:	e9 95 f8 ff ff       	jmp    80105937 <alltraps>

801060a2 <vector83>:
.globl vector83
vector83:
  pushl $0
801060a2:	6a 00                	push   $0x0
  pushl $83
801060a4:	6a 53                	push   $0x53
  jmp alltraps
801060a6:	e9 8c f8 ff ff       	jmp    80105937 <alltraps>

801060ab <vector84>:
.globl vector84
vector84:
  pushl $0
801060ab:	6a 00                	push   $0x0
  pushl $84
801060ad:	6a 54                	push   $0x54
  jmp alltraps
801060af:	e9 83 f8 ff ff       	jmp    80105937 <alltraps>

801060b4 <vector85>:
.globl vector85
vector85:
  pushl $0
801060b4:	6a 00                	push   $0x0
  pushl $85
801060b6:	6a 55                	push   $0x55
  jmp alltraps
801060b8:	e9 7a f8 ff ff       	jmp    80105937 <alltraps>

801060bd <vector86>:
.globl vector86
vector86:
  pushl $0
801060bd:	6a 00                	push   $0x0
  pushl $86
801060bf:	6a 56                	push   $0x56
  jmp alltraps
801060c1:	e9 71 f8 ff ff       	jmp    80105937 <alltraps>

801060c6 <vector87>:
.globl vector87
vector87:
  pushl $0
801060c6:	6a 00                	push   $0x0
  pushl $87
801060c8:	6a 57                	push   $0x57
  jmp alltraps
801060ca:	e9 68 f8 ff ff       	jmp    80105937 <alltraps>

801060cf <vector88>:
.globl vector88
vector88:
  pushl $0
801060cf:	6a 00                	push   $0x0
  pushl $88
801060d1:	6a 58                	push   $0x58
  jmp alltraps
801060d3:	e9 5f f8 ff ff       	jmp    80105937 <alltraps>

801060d8 <vector89>:
.globl vector89
vector89:
  pushl $0
801060d8:	6a 00                	push   $0x0
  pushl $89
801060da:	6a 59                	push   $0x59
  jmp alltraps
801060dc:	e9 56 f8 ff ff       	jmp    80105937 <alltraps>

801060e1 <vector90>:
.globl vector90
vector90:
  pushl $0
801060e1:	6a 00                	push   $0x0
  pushl $90
801060e3:	6a 5a                	push   $0x5a
  jmp alltraps
801060e5:	e9 4d f8 ff ff       	jmp    80105937 <alltraps>

801060ea <vector91>:
.globl vector91
vector91:
  pushl $0
801060ea:	6a 00                	push   $0x0
  pushl $91
801060ec:	6a 5b                	push   $0x5b
  jmp alltraps
801060ee:	e9 44 f8 ff ff       	jmp    80105937 <alltraps>

801060f3 <vector92>:
.globl vector92
vector92:
  pushl $0
801060f3:	6a 00                	push   $0x0
  pushl $92
801060f5:	6a 5c                	push   $0x5c
  jmp alltraps
801060f7:	e9 3b f8 ff ff       	jmp    80105937 <alltraps>

801060fc <vector93>:
.globl vector93
vector93:
  pushl $0
801060fc:	6a 00                	push   $0x0
  pushl $93
801060fe:	6a 5d                	push   $0x5d
  jmp alltraps
80106100:	e9 32 f8 ff ff       	jmp    80105937 <alltraps>

80106105 <vector94>:
.globl vector94
vector94:
  pushl $0
80106105:	6a 00                	push   $0x0
  pushl $94
80106107:	6a 5e                	push   $0x5e
  jmp alltraps
80106109:	e9 29 f8 ff ff       	jmp    80105937 <alltraps>

8010610e <vector95>:
.globl vector95
vector95:
  pushl $0
8010610e:	6a 00                	push   $0x0
  pushl $95
80106110:	6a 5f                	push   $0x5f
  jmp alltraps
80106112:	e9 20 f8 ff ff       	jmp    80105937 <alltraps>

80106117 <vector96>:
.globl vector96
vector96:
  pushl $0
80106117:	6a 00                	push   $0x0
  pushl $96
80106119:	6a 60                	push   $0x60
  jmp alltraps
8010611b:	e9 17 f8 ff ff       	jmp    80105937 <alltraps>

80106120 <vector97>:
.globl vector97
vector97:
  pushl $0
80106120:	6a 00                	push   $0x0
  pushl $97
80106122:	6a 61                	push   $0x61
  jmp alltraps
80106124:	e9 0e f8 ff ff       	jmp    80105937 <alltraps>

80106129 <vector98>:
.globl vector98
vector98:
  pushl $0
80106129:	6a 00                	push   $0x0
  pushl $98
8010612b:	6a 62                	push   $0x62
  jmp alltraps
8010612d:	e9 05 f8 ff ff       	jmp    80105937 <alltraps>

80106132 <vector99>:
.globl vector99
vector99:
  pushl $0
80106132:	6a 00                	push   $0x0
  pushl $99
80106134:	6a 63                	push   $0x63
  jmp alltraps
80106136:	e9 fc f7 ff ff       	jmp    80105937 <alltraps>

8010613b <vector100>:
.globl vector100
vector100:
  pushl $0
8010613b:	6a 00                	push   $0x0
  pushl $100
8010613d:	6a 64                	push   $0x64
  jmp alltraps
8010613f:	e9 f3 f7 ff ff       	jmp    80105937 <alltraps>

80106144 <vector101>:
.globl vector101
vector101:
  pushl $0
80106144:	6a 00                	push   $0x0
  pushl $101
80106146:	6a 65                	push   $0x65
  jmp alltraps
80106148:	e9 ea f7 ff ff       	jmp    80105937 <alltraps>

8010614d <vector102>:
.globl vector102
vector102:
  pushl $0
8010614d:	6a 00                	push   $0x0
  pushl $102
8010614f:	6a 66                	push   $0x66
  jmp alltraps
80106151:	e9 e1 f7 ff ff       	jmp    80105937 <alltraps>

80106156 <vector103>:
.globl vector103
vector103:
  pushl $0
80106156:	6a 00                	push   $0x0
  pushl $103
80106158:	6a 67                	push   $0x67
  jmp alltraps
8010615a:	e9 d8 f7 ff ff       	jmp    80105937 <alltraps>

8010615f <vector104>:
.globl vector104
vector104:
  pushl $0
8010615f:	6a 00                	push   $0x0
  pushl $104
80106161:	6a 68                	push   $0x68
  jmp alltraps
80106163:	e9 cf f7 ff ff       	jmp    80105937 <alltraps>

80106168 <vector105>:
.globl vector105
vector105:
  pushl $0
80106168:	6a 00                	push   $0x0
  pushl $105
8010616a:	6a 69                	push   $0x69
  jmp alltraps
8010616c:	e9 c6 f7 ff ff       	jmp    80105937 <alltraps>

80106171 <vector106>:
.globl vector106
vector106:
  pushl $0
80106171:	6a 00                	push   $0x0
  pushl $106
80106173:	6a 6a                	push   $0x6a
  jmp alltraps
80106175:	e9 bd f7 ff ff       	jmp    80105937 <alltraps>

8010617a <vector107>:
.globl vector107
vector107:
  pushl $0
8010617a:	6a 00                	push   $0x0
  pushl $107
8010617c:	6a 6b                	push   $0x6b
  jmp alltraps
8010617e:	e9 b4 f7 ff ff       	jmp    80105937 <alltraps>

80106183 <vector108>:
.globl vector108
vector108:
  pushl $0
80106183:	6a 00                	push   $0x0
  pushl $108
80106185:	6a 6c                	push   $0x6c
  jmp alltraps
80106187:	e9 ab f7 ff ff       	jmp    80105937 <alltraps>

8010618c <vector109>:
.globl vector109
vector109:
  pushl $0
8010618c:	6a 00                	push   $0x0
  pushl $109
8010618e:	6a 6d                	push   $0x6d
  jmp alltraps
80106190:	e9 a2 f7 ff ff       	jmp    80105937 <alltraps>

80106195 <vector110>:
.globl vector110
vector110:
  pushl $0
80106195:	6a 00                	push   $0x0
  pushl $110
80106197:	6a 6e                	push   $0x6e
  jmp alltraps
80106199:	e9 99 f7 ff ff       	jmp    80105937 <alltraps>

8010619e <vector111>:
.globl vector111
vector111:
  pushl $0
8010619e:	6a 00                	push   $0x0
  pushl $111
801061a0:	6a 6f                	push   $0x6f
  jmp alltraps
801061a2:	e9 90 f7 ff ff       	jmp    80105937 <alltraps>

801061a7 <vector112>:
.globl vector112
vector112:
  pushl $0
801061a7:	6a 00                	push   $0x0
  pushl $112
801061a9:	6a 70                	push   $0x70
  jmp alltraps
801061ab:	e9 87 f7 ff ff       	jmp    80105937 <alltraps>

801061b0 <vector113>:
.globl vector113
vector113:
  pushl $0
801061b0:	6a 00                	push   $0x0
  pushl $113
801061b2:	6a 71                	push   $0x71
  jmp alltraps
801061b4:	e9 7e f7 ff ff       	jmp    80105937 <alltraps>

801061b9 <vector114>:
.globl vector114
vector114:
  pushl $0
801061b9:	6a 00                	push   $0x0
  pushl $114
801061bb:	6a 72                	push   $0x72
  jmp alltraps
801061bd:	e9 75 f7 ff ff       	jmp    80105937 <alltraps>

801061c2 <vector115>:
.globl vector115
vector115:
  pushl $0
801061c2:	6a 00                	push   $0x0
  pushl $115
801061c4:	6a 73                	push   $0x73
  jmp alltraps
801061c6:	e9 6c f7 ff ff       	jmp    80105937 <alltraps>

801061cb <vector116>:
.globl vector116
vector116:
  pushl $0
801061cb:	6a 00                	push   $0x0
  pushl $116
801061cd:	6a 74                	push   $0x74
  jmp alltraps
801061cf:	e9 63 f7 ff ff       	jmp    80105937 <alltraps>

801061d4 <vector117>:
.globl vector117
vector117:
  pushl $0
801061d4:	6a 00                	push   $0x0
  pushl $117
801061d6:	6a 75                	push   $0x75
  jmp alltraps
801061d8:	e9 5a f7 ff ff       	jmp    80105937 <alltraps>

801061dd <vector118>:
.globl vector118
vector118:
  pushl $0
801061dd:	6a 00                	push   $0x0
  pushl $118
801061df:	6a 76                	push   $0x76
  jmp alltraps
801061e1:	e9 51 f7 ff ff       	jmp    80105937 <alltraps>

801061e6 <vector119>:
.globl vector119
vector119:
  pushl $0
801061e6:	6a 00                	push   $0x0
  pushl $119
801061e8:	6a 77                	push   $0x77
  jmp alltraps
801061ea:	e9 48 f7 ff ff       	jmp    80105937 <alltraps>

801061ef <vector120>:
.globl vector120
vector120:
  pushl $0
801061ef:	6a 00                	push   $0x0
  pushl $120
801061f1:	6a 78                	push   $0x78
  jmp alltraps
801061f3:	e9 3f f7 ff ff       	jmp    80105937 <alltraps>

801061f8 <vector121>:
.globl vector121
vector121:
  pushl $0
801061f8:	6a 00                	push   $0x0
  pushl $121
801061fa:	6a 79                	push   $0x79
  jmp alltraps
801061fc:	e9 36 f7 ff ff       	jmp    80105937 <alltraps>

80106201 <vector122>:
.globl vector122
vector122:
  pushl $0
80106201:	6a 00                	push   $0x0
  pushl $122
80106203:	6a 7a                	push   $0x7a
  jmp alltraps
80106205:	e9 2d f7 ff ff       	jmp    80105937 <alltraps>

8010620a <vector123>:
.globl vector123
vector123:
  pushl $0
8010620a:	6a 00                	push   $0x0
  pushl $123
8010620c:	6a 7b                	push   $0x7b
  jmp alltraps
8010620e:	e9 24 f7 ff ff       	jmp    80105937 <alltraps>

80106213 <vector124>:
.globl vector124
vector124:
  pushl $0
80106213:	6a 00                	push   $0x0
  pushl $124
80106215:	6a 7c                	push   $0x7c
  jmp alltraps
80106217:	e9 1b f7 ff ff       	jmp    80105937 <alltraps>

8010621c <vector125>:
.globl vector125
vector125:
  pushl $0
8010621c:	6a 00                	push   $0x0
  pushl $125
8010621e:	6a 7d                	push   $0x7d
  jmp alltraps
80106220:	e9 12 f7 ff ff       	jmp    80105937 <alltraps>

80106225 <vector126>:
.globl vector126
vector126:
  pushl $0
80106225:	6a 00                	push   $0x0
  pushl $126
80106227:	6a 7e                	push   $0x7e
  jmp alltraps
80106229:	e9 09 f7 ff ff       	jmp    80105937 <alltraps>

8010622e <vector127>:
.globl vector127
vector127:
  pushl $0
8010622e:	6a 00                	push   $0x0
  pushl $127
80106230:	6a 7f                	push   $0x7f
  jmp alltraps
80106232:	e9 00 f7 ff ff       	jmp    80105937 <alltraps>

80106237 <vector128>:
.globl vector128
vector128:
  pushl $0
80106237:	6a 00                	push   $0x0
  pushl $128
80106239:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010623e:	e9 f4 f6 ff ff       	jmp    80105937 <alltraps>

80106243 <vector129>:
.globl vector129
vector129:
  pushl $0
80106243:	6a 00                	push   $0x0
  pushl $129
80106245:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010624a:	e9 e8 f6 ff ff       	jmp    80105937 <alltraps>

8010624f <vector130>:
.globl vector130
vector130:
  pushl $0
8010624f:	6a 00                	push   $0x0
  pushl $130
80106251:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106256:	e9 dc f6 ff ff       	jmp    80105937 <alltraps>

8010625b <vector131>:
.globl vector131
vector131:
  pushl $0
8010625b:	6a 00                	push   $0x0
  pushl $131
8010625d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106262:	e9 d0 f6 ff ff       	jmp    80105937 <alltraps>

80106267 <vector132>:
.globl vector132
vector132:
  pushl $0
80106267:	6a 00                	push   $0x0
  pushl $132
80106269:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010626e:	e9 c4 f6 ff ff       	jmp    80105937 <alltraps>

80106273 <vector133>:
.globl vector133
vector133:
  pushl $0
80106273:	6a 00                	push   $0x0
  pushl $133
80106275:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010627a:	e9 b8 f6 ff ff       	jmp    80105937 <alltraps>

8010627f <vector134>:
.globl vector134
vector134:
  pushl $0
8010627f:	6a 00                	push   $0x0
  pushl $134
80106281:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106286:	e9 ac f6 ff ff       	jmp    80105937 <alltraps>

8010628b <vector135>:
.globl vector135
vector135:
  pushl $0
8010628b:	6a 00                	push   $0x0
  pushl $135
8010628d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106292:	e9 a0 f6 ff ff       	jmp    80105937 <alltraps>

80106297 <vector136>:
.globl vector136
vector136:
  pushl $0
80106297:	6a 00                	push   $0x0
  pushl $136
80106299:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010629e:	e9 94 f6 ff ff       	jmp    80105937 <alltraps>

801062a3 <vector137>:
.globl vector137
vector137:
  pushl $0
801062a3:	6a 00                	push   $0x0
  pushl $137
801062a5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801062aa:	e9 88 f6 ff ff       	jmp    80105937 <alltraps>

801062af <vector138>:
.globl vector138
vector138:
  pushl $0
801062af:	6a 00                	push   $0x0
  pushl $138
801062b1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801062b6:	e9 7c f6 ff ff       	jmp    80105937 <alltraps>

801062bb <vector139>:
.globl vector139
vector139:
  pushl $0
801062bb:	6a 00                	push   $0x0
  pushl $139
801062bd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801062c2:	e9 70 f6 ff ff       	jmp    80105937 <alltraps>

801062c7 <vector140>:
.globl vector140
vector140:
  pushl $0
801062c7:	6a 00                	push   $0x0
  pushl $140
801062c9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801062ce:	e9 64 f6 ff ff       	jmp    80105937 <alltraps>

801062d3 <vector141>:
.globl vector141
vector141:
  pushl $0
801062d3:	6a 00                	push   $0x0
  pushl $141
801062d5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801062da:	e9 58 f6 ff ff       	jmp    80105937 <alltraps>

801062df <vector142>:
.globl vector142
vector142:
  pushl $0
801062df:	6a 00                	push   $0x0
  pushl $142
801062e1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801062e6:	e9 4c f6 ff ff       	jmp    80105937 <alltraps>

801062eb <vector143>:
.globl vector143
vector143:
  pushl $0
801062eb:	6a 00                	push   $0x0
  pushl $143
801062ed:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801062f2:	e9 40 f6 ff ff       	jmp    80105937 <alltraps>

801062f7 <vector144>:
.globl vector144
vector144:
  pushl $0
801062f7:	6a 00                	push   $0x0
  pushl $144
801062f9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801062fe:	e9 34 f6 ff ff       	jmp    80105937 <alltraps>

80106303 <vector145>:
.globl vector145
vector145:
  pushl $0
80106303:	6a 00                	push   $0x0
  pushl $145
80106305:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010630a:	e9 28 f6 ff ff       	jmp    80105937 <alltraps>

8010630f <vector146>:
.globl vector146
vector146:
  pushl $0
8010630f:	6a 00                	push   $0x0
  pushl $146
80106311:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106316:	e9 1c f6 ff ff       	jmp    80105937 <alltraps>

8010631b <vector147>:
.globl vector147
vector147:
  pushl $0
8010631b:	6a 00                	push   $0x0
  pushl $147
8010631d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106322:	e9 10 f6 ff ff       	jmp    80105937 <alltraps>

80106327 <vector148>:
.globl vector148
vector148:
  pushl $0
80106327:	6a 00                	push   $0x0
  pushl $148
80106329:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010632e:	e9 04 f6 ff ff       	jmp    80105937 <alltraps>

80106333 <vector149>:
.globl vector149
vector149:
  pushl $0
80106333:	6a 00                	push   $0x0
  pushl $149
80106335:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010633a:	e9 f8 f5 ff ff       	jmp    80105937 <alltraps>

8010633f <vector150>:
.globl vector150
vector150:
  pushl $0
8010633f:	6a 00                	push   $0x0
  pushl $150
80106341:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106346:	e9 ec f5 ff ff       	jmp    80105937 <alltraps>

8010634b <vector151>:
.globl vector151
vector151:
  pushl $0
8010634b:	6a 00                	push   $0x0
  pushl $151
8010634d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106352:	e9 e0 f5 ff ff       	jmp    80105937 <alltraps>

80106357 <vector152>:
.globl vector152
vector152:
  pushl $0
80106357:	6a 00                	push   $0x0
  pushl $152
80106359:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010635e:	e9 d4 f5 ff ff       	jmp    80105937 <alltraps>

80106363 <vector153>:
.globl vector153
vector153:
  pushl $0
80106363:	6a 00                	push   $0x0
  pushl $153
80106365:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010636a:	e9 c8 f5 ff ff       	jmp    80105937 <alltraps>

8010636f <vector154>:
.globl vector154
vector154:
  pushl $0
8010636f:	6a 00                	push   $0x0
  pushl $154
80106371:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106376:	e9 bc f5 ff ff       	jmp    80105937 <alltraps>

8010637b <vector155>:
.globl vector155
vector155:
  pushl $0
8010637b:	6a 00                	push   $0x0
  pushl $155
8010637d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106382:	e9 b0 f5 ff ff       	jmp    80105937 <alltraps>

80106387 <vector156>:
.globl vector156
vector156:
  pushl $0
80106387:	6a 00                	push   $0x0
  pushl $156
80106389:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010638e:	e9 a4 f5 ff ff       	jmp    80105937 <alltraps>

80106393 <vector157>:
.globl vector157
vector157:
  pushl $0
80106393:	6a 00                	push   $0x0
  pushl $157
80106395:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010639a:	e9 98 f5 ff ff       	jmp    80105937 <alltraps>

8010639f <vector158>:
.globl vector158
vector158:
  pushl $0
8010639f:	6a 00                	push   $0x0
  pushl $158
801063a1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801063a6:	e9 8c f5 ff ff       	jmp    80105937 <alltraps>

801063ab <vector159>:
.globl vector159
vector159:
  pushl $0
801063ab:	6a 00                	push   $0x0
  pushl $159
801063ad:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801063b2:	e9 80 f5 ff ff       	jmp    80105937 <alltraps>

801063b7 <vector160>:
.globl vector160
vector160:
  pushl $0
801063b7:	6a 00                	push   $0x0
  pushl $160
801063b9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801063be:	e9 74 f5 ff ff       	jmp    80105937 <alltraps>

801063c3 <vector161>:
.globl vector161
vector161:
  pushl $0
801063c3:	6a 00                	push   $0x0
  pushl $161
801063c5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801063ca:	e9 68 f5 ff ff       	jmp    80105937 <alltraps>

801063cf <vector162>:
.globl vector162
vector162:
  pushl $0
801063cf:	6a 00                	push   $0x0
  pushl $162
801063d1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801063d6:	e9 5c f5 ff ff       	jmp    80105937 <alltraps>

801063db <vector163>:
.globl vector163
vector163:
  pushl $0
801063db:	6a 00                	push   $0x0
  pushl $163
801063dd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801063e2:	e9 50 f5 ff ff       	jmp    80105937 <alltraps>

801063e7 <vector164>:
.globl vector164
vector164:
  pushl $0
801063e7:	6a 00                	push   $0x0
  pushl $164
801063e9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801063ee:	e9 44 f5 ff ff       	jmp    80105937 <alltraps>

801063f3 <vector165>:
.globl vector165
vector165:
  pushl $0
801063f3:	6a 00                	push   $0x0
  pushl $165
801063f5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801063fa:	e9 38 f5 ff ff       	jmp    80105937 <alltraps>

801063ff <vector166>:
.globl vector166
vector166:
  pushl $0
801063ff:	6a 00                	push   $0x0
  pushl $166
80106401:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106406:	e9 2c f5 ff ff       	jmp    80105937 <alltraps>

8010640b <vector167>:
.globl vector167
vector167:
  pushl $0
8010640b:	6a 00                	push   $0x0
  pushl $167
8010640d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106412:	e9 20 f5 ff ff       	jmp    80105937 <alltraps>

80106417 <vector168>:
.globl vector168
vector168:
  pushl $0
80106417:	6a 00                	push   $0x0
  pushl $168
80106419:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010641e:	e9 14 f5 ff ff       	jmp    80105937 <alltraps>

80106423 <vector169>:
.globl vector169
vector169:
  pushl $0
80106423:	6a 00                	push   $0x0
  pushl $169
80106425:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010642a:	e9 08 f5 ff ff       	jmp    80105937 <alltraps>

8010642f <vector170>:
.globl vector170
vector170:
  pushl $0
8010642f:	6a 00                	push   $0x0
  pushl $170
80106431:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106436:	e9 fc f4 ff ff       	jmp    80105937 <alltraps>

8010643b <vector171>:
.globl vector171
vector171:
  pushl $0
8010643b:	6a 00                	push   $0x0
  pushl $171
8010643d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106442:	e9 f0 f4 ff ff       	jmp    80105937 <alltraps>

80106447 <vector172>:
.globl vector172
vector172:
  pushl $0
80106447:	6a 00                	push   $0x0
  pushl $172
80106449:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010644e:	e9 e4 f4 ff ff       	jmp    80105937 <alltraps>

80106453 <vector173>:
.globl vector173
vector173:
  pushl $0
80106453:	6a 00                	push   $0x0
  pushl $173
80106455:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010645a:	e9 d8 f4 ff ff       	jmp    80105937 <alltraps>

8010645f <vector174>:
.globl vector174
vector174:
  pushl $0
8010645f:	6a 00                	push   $0x0
  pushl $174
80106461:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106466:	e9 cc f4 ff ff       	jmp    80105937 <alltraps>

8010646b <vector175>:
.globl vector175
vector175:
  pushl $0
8010646b:	6a 00                	push   $0x0
  pushl $175
8010646d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106472:	e9 c0 f4 ff ff       	jmp    80105937 <alltraps>

80106477 <vector176>:
.globl vector176
vector176:
  pushl $0
80106477:	6a 00                	push   $0x0
  pushl $176
80106479:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010647e:	e9 b4 f4 ff ff       	jmp    80105937 <alltraps>

80106483 <vector177>:
.globl vector177
vector177:
  pushl $0
80106483:	6a 00                	push   $0x0
  pushl $177
80106485:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010648a:	e9 a8 f4 ff ff       	jmp    80105937 <alltraps>

8010648f <vector178>:
.globl vector178
vector178:
  pushl $0
8010648f:	6a 00                	push   $0x0
  pushl $178
80106491:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106496:	e9 9c f4 ff ff       	jmp    80105937 <alltraps>

8010649b <vector179>:
.globl vector179
vector179:
  pushl $0
8010649b:	6a 00                	push   $0x0
  pushl $179
8010649d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801064a2:	e9 90 f4 ff ff       	jmp    80105937 <alltraps>

801064a7 <vector180>:
.globl vector180
vector180:
  pushl $0
801064a7:	6a 00                	push   $0x0
  pushl $180
801064a9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801064ae:	e9 84 f4 ff ff       	jmp    80105937 <alltraps>

801064b3 <vector181>:
.globl vector181
vector181:
  pushl $0
801064b3:	6a 00                	push   $0x0
  pushl $181
801064b5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801064ba:	e9 78 f4 ff ff       	jmp    80105937 <alltraps>

801064bf <vector182>:
.globl vector182
vector182:
  pushl $0
801064bf:	6a 00                	push   $0x0
  pushl $182
801064c1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801064c6:	e9 6c f4 ff ff       	jmp    80105937 <alltraps>

801064cb <vector183>:
.globl vector183
vector183:
  pushl $0
801064cb:	6a 00                	push   $0x0
  pushl $183
801064cd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801064d2:	e9 60 f4 ff ff       	jmp    80105937 <alltraps>

801064d7 <vector184>:
.globl vector184
vector184:
  pushl $0
801064d7:	6a 00                	push   $0x0
  pushl $184
801064d9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801064de:	e9 54 f4 ff ff       	jmp    80105937 <alltraps>

801064e3 <vector185>:
.globl vector185
vector185:
  pushl $0
801064e3:	6a 00                	push   $0x0
  pushl $185
801064e5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801064ea:	e9 48 f4 ff ff       	jmp    80105937 <alltraps>

801064ef <vector186>:
.globl vector186
vector186:
  pushl $0
801064ef:	6a 00                	push   $0x0
  pushl $186
801064f1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801064f6:	e9 3c f4 ff ff       	jmp    80105937 <alltraps>

801064fb <vector187>:
.globl vector187
vector187:
  pushl $0
801064fb:	6a 00                	push   $0x0
  pushl $187
801064fd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106502:	e9 30 f4 ff ff       	jmp    80105937 <alltraps>

80106507 <vector188>:
.globl vector188
vector188:
  pushl $0
80106507:	6a 00                	push   $0x0
  pushl $188
80106509:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010650e:	e9 24 f4 ff ff       	jmp    80105937 <alltraps>

80106513 <vector189>:
.globl vector189
vector189:
  pushl $0
80106513:	6a 00                	push   $0x0
  pushl $189
80106515:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010651a:	e9 18 f4 ff ff       	jmp    80105937 <alltraps>

8010651f <vector190>:
.globl vector190
vector190:
  pushl $0
8010651f:	6a 00                	push   $0x0
  pushl $190
80106521:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106526:	e9 0c f4 ff ff       	jmp    80105937 <alltraps>

8010652b <vector191>:
.globl vector191
vector191:
  pushl $0
8010652b:	6a 00                	push   $0x0
  pushl $191
8010652d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106532:	e9 00 f4 ff ff       	jmp    80105937 <alltraps>

80106537 <vector192>:
.globl vector192
vector192:
  pushl $0
80106537:	6a 00                	push   $0x0
  pushl $192
80106539:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010653e:	e9 f4 f3 ff ff       	jmp    80105937 <alltraps>

80106543 <vector193>:
.globl vector193
vector193:
  pushl $0
80106543:	6a 00                	push   $0x0
  pushl $193
80106545:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010654a:	e9 e8 f3 ff ff       	jmp    80105937 <alltraps>

8010654f <vector194>:
.globl vector194
vector194:
  pushl $0
8010654f:	6a 00                	push   $0x0
  pushl $194
80106551:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106556:	e9 dc f3 ff ff       	jmp    80105937 <alltraps>

8010655b <vector195>:
.globl vector195
vector195:
  pushl $0
8010655b:	6a 00                	push   $0x0
  pushl $195
8010655d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106562:	e9 d0 f3 ff ff       	jmp    80105937 <alltraps>

80106567 <vector196>:
.globl vector196
vector196:
  pushl $0
80106567:	6a 00                	push   $0x0
  pushl $196
80106569:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010656e:	e9 c4 f3 ff ff       	jmp    80105937 <alltraps>

80106573 <vector197>:
.globl vector197
vector197:
  pushl $0
80106573:	6a 00                	push   $0x0
  pushl $197
80106575:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010657a:	e9 b8 f3 ff ff       	jmp    80105937 <alltraps>

8010657f <vector198>:
.globl vector198
vector198:
  pushl $0
8010657f:	6a 00                	push   $0x0
  pushl $198
80106581:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106586:	e9 ac f3 ff ff       	jmp    80105937 <alltraps>

8010658b <vector199>:
.globl vector199
vector199:
  pushl $0
8010658b:	6a 00                	push   $0x0
  pushl $199
8010658d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106592:	e9 a0 f3 ff ff       	jmp    80105937 <alltraps>

80106597 <vector200>:
.globl vector200
vector200:
  pushl $0
80106597:	6a 00                	push   $0x0
  pushl $200
80106599:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010659e:	e9 94 f3 ff ff       	jmp    80105937 <alltraps>

801065a3 <vector201>:
.globl vector201
vector201:
  pushl $0
801065a3:	6a 00                	push   $0x0
  pushl $201
801065a5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801065aa:	e9 88 f3 ff ff       	jmp    80105937 <alltraps>

801065af <vector202>:
.globl vector202
vector202:
  pushl $0
801065af:	6a 00                	push   $0x0
  pushl $202
801065b1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801065b6:	e9 7c f3 ff ff       	jmp    80105937 <alltraps>

801065bb <vector203>:
.globl vector203
vector203:
  pushl $0
801065bb:	6a 00                	push   $0x0
  pushl $203
801065bd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801065c2:	e9 70 f3 ff ff       	jmp    80105937 <alltraps>

801065c7 <vector204>:
.globl vector204
vector204:
  pushl $0
801065c7:	6a 00                	push   $0x0
  pushl $204
801065c9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801065ce:	e9 64 f3 ff ff       	jmp    80105937 <alltraps>

801065d3 <vector205>:
.globl vector205
vector205:
  pushl $0
801065d3:	6a 00                	push   $0x0
  pushl $205
801065d5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801065da:	e9 58 f3 ff ff       	jmp    80105937 <alltraps>

801065df <vector206>:
.globl vector206
vector206:
  pushl $0
801065df:	6a 00                	push   $0x0
  pushl $206
801065e1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801065e6:	e9 4c f3 ff ff       	jmp    80105937 <alltraps>

801065eb <vector207>:
.globl vector207
vector207:
  pushl $0
801065eb:	6a 00                	push   $0x0
  pushl $207
801065ed:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801065f2:	e9 40 f3 ff ff       	jmp    80105937 <alltraps>

801065f7 <vector208>:
.globl vector208
vector208:
  pushl $0
801065f7:	6a 00                	push   $0x0
  pushl $208
801065f9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801065fe:	e9 34 f3 ff ff       	jmp    80105937 <alltraps>

80106603 <vector209>:
.globl vector209
vector209:
  pushl $0
80106603:	6a 00                	push   $0x0
  pushl $209
80106605:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010660a:	e9 28 f3 ff ff       	jmp    80105937 <alltraps>

8010660f <vector210>:
.globl vector210
vector210:
  pushl $0
8010660f:	6a 00                	push   $0x0
  pushl $210
80106611:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106616:	e9 1c f3 ff ff       	jmp    80105937 <alltraps>

8010661b <vector211>:
.globl vector211
vector211:
  pushl $0
8010661b:	6a 00                	push   $0x0
  pushl $211
8010661d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106622:	e9 10 f3 ff ff       	jmp    80105937 <alltraps>

80106627 <vector212>:
.globl vector212
vector212:
  pushl $0
80106627:	6a 00                	push   $0x0
  pushl $212
80106629:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010662e:	e9 04 f3 ff ff       	jmp    80105937 <alltraps>

80106633 <vector213>:
.globl vector213
vector213:
  pushl $0
80106633:	6a 00                	push   $0x0
  pushl $213
80106635:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010663a:	e9 f8 f2 ff ff       	jmp    80105937 <alltraps>

8010663f <vector214>:
.globl vector214
vector214:
  pushl $0
8010663f:	6a 00                	push   $0x0
  pushl $214
80106641:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106646:	e9 ec f2 ff ff       	jmp    80105937 <alltraps>

8010664b <vector215>:
.globl vector215
vector215:
  pushl $0
8010664b:	6a 00                	push   $0x0
  pushl $215
8010664d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106652:	e9 e0 f2 ff ff       	jmp    80105937 <alltraps>

80106657 <vector216>:
.globl vector216
vector216:
  pushl $0
80106657:	6a 00                	push   $0x0
  pushl $216
80106659:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010665e:	e9 d4 f2 ff ff       	jmp    80105937 <alltraps>

80106663 <vector217>:
.globl vector217
vector217:
  pushl $0
80106663:	6a 00                	push   $0x0
  pushl $217
80106665:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010666a:	e9 c8 f2 ff ff       	jmp    80105937 <alltraps>

8010666f <vector218>:
.globl vector218
vector218:
  pushl $0
8010666f:	6a 00                	push   $0x0
  pushl $218
80106671:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106676:	e9 bc f2 ff ff       	jmp    80105937 <alltraps>

8010667b <vector219>:
.globl vector219
vector219:
  pushl $0
8010667b:	6a 00                	push   $0x0
  pushl $219
8010667d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106682:	e9 b0 f2 ff ff       	jmp    80105937 <alltraps>

80106687 <vector220>:
.globl vector220
vector220:
  pushl $0
80106687:	6a 00                	push   $0x0
  pushl $220
80106689:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010668e:	e9 a4 f2 ff ff       	jmp    80105937 <alltraps>

80106693 <vector221>:
.globl vector221
vector221:
  pushl $0
80106693:	6a 00                	push   $0x0
  pushl $221
80106695:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010669a:	e9 98 f2 ff ff       	jmp    80105937 <alltraps>

8010669f <vector222>:
.globl vector222
vector222:
  pushl $0
8010669f:	6a 00                	push   $0x0
  pushl $222
801066a1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801066a6:	e9 8c f2 ff ff       	jmp    80105937 <alltraps>

801066ab <vector223>:
.globl vector223
vector223:
  pushl $0
801066ab:	6a 00                	push   $0x0
  pushl $223
801066ad:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801066b2:	e9 80 f2 ff ff       	jmp    80105937 <alltraps>

801066b7 <vector224>:
.globl vector224
vector224:
  pushl $0
801066b7:	6a 00                	push   $0x0
  pushl $224
801066b9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801066be:	e9 74 f2 ff ff       	jmp    80105937 <alltraps>

801066c3 <vector225>:
.globl vector225
vector225:
  pushl $0
801066c3:	6a 00                	push   $0x0
  pushl $225
801066c5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801066ca:	e9 68 f2 ff ff       	jmp    80105937 <alltraps>

801066cf <vector226>:
.globl vector226
vector226:
  pushl $0
801066cf:	6a 00                	push   $0x0
  pushl $226
801066d1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801066d6:	e9 5c f2 ff ff       	jmp    80105937 <alltraps>

801066db <vector227>:
.globl vector227
vector227:
  pushl $0
801066db:	6a 00                	push   $0x0
  pushl $227
801066dd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801066e2:	e9 50 f2 ff ff       	jmp    80105937 <alltraps>

801066e7 <vector228>:
.globl vector228
vector228:
  pushl $0
801066e7:	6a 00                	push   $0x0
  pushl $228
801066e9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801066ee:	e9 44 f2 ff ff       	jmp    80105937 <alltraps>

801066f3 <vector229>:
.globl vector229
vector229:
  pushl $0
801066f3:	6a 00                	push   $0x0
  pushl $229
801066f5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801066fa:	e9 38 f2 ff ff       	jmp    80105937 <alltraps>

801066ff <vector230>:
.globl vector230
vector230:
  pushl $0
801066ff:	6a 00                	push   $0x0
  pushl $230
80106701:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106706:	e9 2c f2 ff ff       	jmp    80105937 <alltraps>

8010670b <vector231>:
.globl vector231
vector231:
  pushl $0
8010670b:	6a 00                	push   $0x0
  pushl $231
8010670d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106712:	e9 20 f2 ff ff       	jmp    80105937 <alltraps>

80106717 <vector232>:
.globl vector232
vector232:
  pushl $0
80106717:	6a 00                	push   $0x0
  pushl $232
80106719:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010671e:	e9 14 f2 ff ff       	jmp    80105937 <alltraps>

80106723 <vector233>:
.globl vector233
vector233:
  pushl $0
80106723:	6a 00                	push   $0x0
  pushl $233
80106725:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010672a:	e9 08 f2 ff ff       	jmp    80105937 <alltraps>

8010672f <vector234>:
.globl vector234
vector234:
  pushl $0
8010672f:	6a 00                	push   $0x0
  pushl $234
80106731:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106736:	e9 fc f1 ff ff       	jmp    80105937 <alltraps>

8010673b <vector235>:
.globl vector235
vector235:
  pushl $0
8010673b:	6a 00                	push   $0x0
  pushl $235
8010673d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106742:	e9 f0 f1 ff ff       	jmp    80105937 <alltraps>

80106747 <vector236>:
.globl vector236
vector236:
  pushl $0
80106747:	6a 00                	push   $0x0
  pushl $236
80106749:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010674e:	e9 e4 f1 ff ff       	jmp    80105937 <alltraps>

80106753 <vector237>:
.globl vector237
vector237:
  pushl $0
80106753:	6a 00                	push   $0x0
  pushl $237
80106755:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010675a:	e9 d8 f1 ff ff       	jmp    80105937 <alltraps>

8010675f <vector238>:
.globl vector238
vector238:
  pushl $0
8010675f:	6a 00                	push   $0x0
  pushl $238
80106761:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106766:	e9 cc f1 ff ff       	jmp    80105937 <alltraps>

8010676b <vector239>:
.globl vector239
vector239:
  pushl $0
8010676b:	6a 00                	push   $0x0
  pushl $239
8010676d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106772:	e9 c0 f1 ff ff       	jmp    80105937 <alltraps>

80106777 <vector240>:
.globl vector240
vector240:
  pushl $0
80106777:	6a 00                	push   $0x0
  pushl $240
80106779:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010677e:	e9 b4 f1 ff ff       	jmp    80105937 <alltraps>

80106783 <vector241>:
.globl vector241
vector241:
  pushl $0
80106783:	6a 00                	push   $0x0
  pushl $241
80106785:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010678a:	e9 a8 f1 ff ff       	jmp    80105937 <alltraps>

8010678f <vector242>:
.globl vector242
vector242:
  pushl $0
8010678f:	6a 00                	push   $0x0
  pushl $242
80106791:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106796:	e9 9c f1 ff ff       	jmp    80105937 <alltraps>

8010679b <vector243>:
.globl vector243
vector243:
  pushl $0
8010679b:	6a 00                	push   $0x0
  pushl $243
8010679d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801067a2:	e9 90 f1 ff ff       	jmp    80105937 <alltraps>

801067a7 <vector244>:
.globl vector244
vector244:
  pushl $0
801067a7:	6a 00                	push   $0x0
  pushl $244
801067a9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801067ae:	e9 84 f1 ff ff       	jmp    80105937 <alltraps>

801067b3 <vector245>:
.globl vector245
vector245:
  pushl $0
801067b3:	6a 00                	push   $0x0
  pushl $245
801067b5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801067ba:	e9 78 f1 ff ff       	jmp    80105937 <alltraps>

801067bf <vector246>:
.globl vector246
vector246:
  pushl $0
801067bf:	6a 00                	push   $0x0
  pushl $246
801067c1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801067c6:	e9 6c f1 ff ff       	jmp    80105937 <alltraps>

801067cb <vector247>:
.globl vector247
vector247:
  pushl $0
801067cb:	6a 00                	push   $0x0
  pushl $247
801067cd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801067d2:	e9 60 f1 ff ff       	jmp    80105937 <alltraps>

801067d7 <vector248>:
.globl vector248
vector248:
  pushl $0
801067d7:	6a 00                	push   $0x0
  pushl $248
801067d9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801067de:	e9 54 f1 ff ff       	jmp    80105937 <alltraps>

801067e3 <vector249>:
.globl vector249
vector249:
  pushl $0
801067e3:	6a 00                	push   $0x0
  pushl $249
801067e5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801067ea:	e9 48 f1 ff ff       	jmp    80105937 <alltraps>

801067ef <vector250>:
.globl vector250
vector250:
  pushl $0
801067ef:	6a 00                	push   $0x0
  pushl $250
801067f1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801067f6:	e9 3c f1 ff ff       	jmp    80105937 <alltraps>

801067fb <vector251>:
.globl vector251
vector251:
  pushl $0
801067fb:	6a 00                	push   $0x0
  pushl $251
801067fd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106802:	e9 30 f1 ff ff       	jmp    80105937 <alltraps>

80106807 <vector252>:
.globl vector252
vector252:
  pushl $0
80106807:	6a 00                	push   $0x0
  pushl $252
80106809:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010680e:	e9 24 f1 ff ff       	jmp    80105937 <alltraps>

80106813 <vector253>:
.globl vector253
vector253:
  pushl $0
80106813:	6a 00                	push   $0x0
  pushl $253
80106815:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010681a:	e9 18 f1 ff ff       	jmp    80105937 <alltraps>

8010681f <vector254>:
.globl vector254
vector254:
  pushl $0
8010681f:	6a 00                	push   $0x0
  pushl $254
80106821:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106826:	e9 0c f1 ff ff       	jmp    80105937 <alltraps>

8010682b <vector255>:
.globl vector255
vector255:
  pushl $0
8010682b:	6a 00                	push   $0x0
  pushl $255
8010682d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106832:	e9 00 f1 ff ff       	jmp    80105937 <alltraps>
80106837:	66 90                	xchg   %ax,%ax
80106839:	66 90                	xchg   %ax,%ax
8010683b:	66 90                	xchg   %ax,%ax
8010683d:	66 90                	xchg   %ax,%ax
8010683f:	90                   	nop

80106840 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106840:	55                   	push   %ebp
80106841:	89 e5                	mov    %esp,%ebp
80106843:	57                   	push   %edi
80106844:	56                   	push   %esi
80106845:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106846:	89 d3                	mov    %edx,%ebx
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106848:	89 d7                	mov    %edx,%edi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
8010684a:	c1 eb 16             	shr    $0x16,%ebx
8010684d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106850:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80106853:	8b 06                	mov    (%esi),%eax
80106855:	a8 01                	test   $0x1,%al
80106857:	74 27                	je     80106880 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106859:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010685e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106864:	c1 ef 0a             	shr    $0xa,%edi
}
80106867:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
8010686a:	89 fa                	mov    %edi,%edx
8010686c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106872:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106875:	5b                   	pop    %ebx
80106876:	5e                   	pop    %esi
80106877:	5f                   	pop    %edi
80106878:	5d                   	pop    %ebp
80106879:	c3                   	ret    
8010687a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106880:	85 c9                	test   %ecx,%ecx
80106882:	74 2c                	je     801068b0 <walkpgdir+0x70>
80106884:	e8 07 bc ff ff       	call   80102490 <kalloc>
80106889:	85 c0                	test   %eax,%eax
8010688b:	89 c3                	mov    %eax,%ebx
8010688d:	74 21                	je     801068b0 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
8010688f:	83 ec 04             	sub    $0x4,%esp
80106892:	68 00 10 00 00       	push   $0x1000
80106897:	6a 00                	push   $0x0
80106899:	50                   	push   %eax
8010689a:	e8 51 de ff ff       	call   801046f0 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010689f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801068a5:	83 c4 10             	add    $0x10,%esp
801068a8:	83 c8 07             	or     $0x7,%eax
801068ab:	89 06                	mov    %eax,(%esi)
801068ad:	eb b5                	jmp    80106864 <walkpgdir+0x24>
801068af:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
801068b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
801068b3:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
801068b5:	5b                   	pop    %ebx
801068b6:	5e                   	pop    %esi
801068b7:	5f                   	pop    %edi
801068b8:	5d                   	pop    %ebp
801068b9:	c3                   	ret    
801068ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801068c0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801068c0:	55                   	push   %ebp
801068c1:	89 e5                	mov    %esp,%ebp
801068c3:	57                   	push   %edi
801068c4:	56                   	push   %esi
801068c5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801068c6:	89 d3                	mov    %edx,%ebx
801068c8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801068ce:	83 ec 1c             	sub    $0x1c,%esp
801068d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801068d4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801068d8:	8b 7d 08             	mov    0x8(%ebp),%edi
801068db:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801068e0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801068e3:	8b 45 0c             	mov    0xc(%ebp),%eax
801068e6:	29 df                	sub    %ebx,%edi
801068e8:	83 c8 01             	or     $0x1,%eax
801068eb:	89 45 dc             	mov    %eax,-0x24(%ebp)
801068ee:	eb 15                	jmp    80106905 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
801068f0:	f6 00 01             	testb  $0x1,(%eax)
801068f3:	75 45                	jne    8010693a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
801068f5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
801068f8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801068fb:	89 30                	mov    %esi,(%eax)
    if(a == last)
801068fd:	74 31                	je     80106930 <mappages+0x70>
      break;
    a += PGSIZE;
801068ff:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106905:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106908:	b9 01 00 00 00       	mov    $0x1,%ecx
8010690d:	89 da                	mov    %ebx,%edx
8010690f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106912:	e8 29 ff ff ff       	call   80106840 <walkpgdir>
80106917:	85 c0                	test   %eax,%eax
80106919:	75 d5                	jne    801068f0 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
8010691b:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
8010691e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106923:	5b                   	pop    %ebx
80106924:	5e                   	pop    %esi
80106925:	5f                   	pop    %edi
80106926:	5d                   	pop    %ebp
80106927:	c3                   	ret    
80106928:	90                   	nop
80106929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106930:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80106933:	31 c0                	xor    %eax,%eax
}
80106935:	5b                   	pop    %ebx
80106936:	5e                   	pop    %esi
80106937:	5f                   	pop    %edi
80106938:	5d                   	pop    %ebp
80106939:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
8010693a:	83 ec 0c             	sub    $0xc,%esp
8010693d:	68 2c 7b 10 80       	push   $0x80107b2c
80106942:	e8 29 9a ff ff       	call   80100370 <panic>
80106947:	89 f6                	mov    %esi,%esi
80106949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106950 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106950:	55                   	push   %ebp
80106951:	89 e5                	mov    %esp,%ebp
80106953:	57                   	push   %edi
80106954:	56                   	push   %esi
80106955:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106956:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010695c:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
8010695e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106964:	83 ec 1c             	sub    $0x1c,%esp
80106967:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
8010696a:	39 d3                	cmp    %edx,%ebx
8010696c:	73 66                	jae    801069d4 <deallocuvm.part.0+0x84>
8010696e:	89 d6                	mov    %edx,%esi
80106970:	eb 3d                	jmp    801069af <deallocuvm.part.0+0x5f>
80106972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106978:	8b 10                	mov    (%eax),%edx
8010697a:	f6 c2 01             	test   $0x1,%dl
8010697d:	74 26                	je     801069a5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010697f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106985:	74 58                	je     801069df <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106987:	83 ec 0c             	sub    $0xc,%esp
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
      char *v = P2V(pa);
8010698a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106990:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80106993:	52                   	push   %edx
80106994:	e8 47 b9 ff ff       	call   801022e0 <kfree>
      *pte = 0;
80106999:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010699c:	83 c4 10             	add    $0x10,%esp
8010699f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801069a5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801069ab:	39 f3                	cmp    %esi,%ebx
801069ad:	73 25                	jae    801069d4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
801069af:	31 c9                	xor    %ecx,%ecx
801069b1:	89 da                	mov    %ebx,%edx
801069b3:	89 f8                	mov    %edi,%eax
801069b5:	e8 86 fe ff ff       	call   80106840 <walkpgdir>
    if(!pte)
801069ba:	85 c0                	test   %eax,%eax
801069bc:	75 ba                	jne    80106978 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801069be:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801069c4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801069ca:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801069d0:	39 f3                	cmp    %esi,%ebx
801069d2:	72 db                	jb     801069af <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
801069d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801069d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801069da:	5b                   	pop    %ebx
801069db:	5e                   	pop    %esi
801069dc:	5f                   	pop    %edi
801069dd:	5d                   	pop    %ebp
801069de:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
801069df:	83 ec 0c             	sub    $0xc,%esp
801069e2:	68 06 74 10 80       	push   $0x80107406
801069e7:	e8 84 99 ff ff       	call   80100370 <panic>
801069ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801069f0 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
801069f0:	55                   	push   %ebp
801069f1:	89 e5                	mov    %esp,%ebp
801069f3:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
801069f6:	e8 a5 cd ff ff       	call   801037a0 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801069fb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106a01:	31 c9                	xor    %ecx,%ecx
80106a03:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106a08:	66 89 90 58 28 11 80 	mov    %dx,-0x7feed7a8(%eax)
80106a0f:	66 89 88 5a 28 11 80 	mov    %cx,-0x7feed7a6(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106a16:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106a1b:	31 c9                	xor    %ecx,%ecx
80106a1d:	66 89 90 60 28 11 80 	mov    %dx,-0x7feed7a0(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a24:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106a29:	66 89 88 62 28 11 80 	mov    %cx,-0x7feed79e(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a30:	31 c9                	xor    %ecx,%ecx
80106a32:	66 89 90 68 28 11 80 	mov    %dx,-0x7feed798(%eax)
80106a39:	66 89 88 6a 28 11 80 	mov    %cx,-0x7feed796(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106a40:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106a45:	31 c9                	xor    %ecx,%ecx
80106a47:	66 89 90 70 28 11 80 	mov    %dx,-0x7feed790(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106a4e:	c6 80 5c 28 11 80 00 	movb   $0x0,-0x7feed7a4(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106a55:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106a5a:	c6 80 5d 28 11 80 9a 	movb   $0x9a,-0x7feed7a3(%eax)
80106a61:	c6 80 5e 28 11 80 cf 	movb   $0xcf,-0x7feed7a2(%eax)
80106a68:	c6 80 5f 28 11 80 00 	movb   $0x0,-0x7feed7a1(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106a6f:	c6 80 64 28 11 80 00 	movb   $0x0,-0x7feed79c(%eax)
80106a76:	c6 80 65 28 11 80 92 	movb   $0x92,-0x7feed79b(%eax)
80106a7d:	c6 80 66 28 11 80 cf 	movb   $0xcf,-0x7feed79a(%eax)
80106a84:	c6 80 67 28 11 80 00 	movb   $0x0,-0x7feed799(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a8b:	c6 80 6c 28 11 80 00 	movb   $0x0,-0x7feed794(%eax)
80106a92:	c6 80 6d 28 11 80 fa 	movb   $0xfa,-0x7feed793(%eax)
80106a99:	c6 80 6e 28 11 80 cf 	movb   $0xcf,-0x7feed792(%eax)
80106aa0:	c6 80 6f 28 11 80 00 	movb   $0x0,-0x7feed791(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106aa7:	66 89 88 72 28 11 80 	mov    %cx,-0x7feed78e(%eax)
80106aae:	c6 80 74 28 11 80 00 	movb   $0x0,-0x7feed78c(%eax)
80106ab5:	c6 80 75 28 11 80 f2 	movb   $0xf2,-0x7feed78b(%eax)
80106abc:	c6 80 76 28 11 80 cf 	movb   $0xcf,-0x7feed78a(%eax)
80106ac3:	c6 80 77 28 11 80 00 	movb   $0x0,-0x7feed789(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106aca:	05 50 28 11 80       	add    $0x80112850,%eax
80106acf:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
80106ad3:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106ad7:	c1 e8 10             	shr    $0x10,%eax
80106ada:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80106ade:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106ae1:	0f 01 10             	lgdtl  (%eax)
}
80106ae4:	c9                   	leave  
80106ae5:	c3                   	ret    
80106ae6:	8d 76 00             	lea    0x0(%esi),%esi
80106ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106af0 <switchkvm>:
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106af0:	a1 04 5a 11 80       	mov    0x80115a04,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106af5:	55                   	push   %ebp
80106af6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106af8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106afd:	0f 22 d8             	mov    %eax,%cr3
}
80106b00:	5d                   	pop    %ebp
80106b01:	c3                   	ret    
80106b02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b10 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106b10:	55                   	push   %ebp
80106b11:	89 e5                	mov    %esp,%ebp
80106b13:	57                   	push   %edi
80106b14:	56                   	push   %esi
80106b15:	53                   	push   %ebx
80106b16:	83 ec 1c             	sub    $0x1c,%esp
80106b19:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106b1c:	85 f6                	test   %esi,%esi
80106b1e:	0f 84 cd 00 00 00    	je     80106bf1 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106b24:	8b 46 08             	mov    0x8(%esi),%eax
80106b27:	85 c0                	test   %eax,%eax
80106b29:	0f 84 dc 00 00 00    	je     80106c0b <switchuvm+0xfb>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106b2f:	8b 7e 04             	mov    0x4(%esi),%edi
80106b32:	85 ff                	test   %edi,%edi
80106b34:	0f 84 c4 00 00 00    	je     80106bfe <switchuvm+0xee>
    panic("switchuvm: no pgdir");

  pushcli();
80106b3a:	e8 d1 d9 ff ff       	call   80104510 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106b3f:	e8 dc cb ff ff       	call   80103720 <mycpu>
80106b44:	89 c3                	mov    %eax,%ebx
80106b46:	e8 d5 cb ff ff       	call   80103720 <mycpu>
80106b4b:	89 c7                	mov    %eax,%edi
80106b4d:	e8 ce cb ff ff       	call   80103720 <mycpu>
80106b52:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106b55:	83 c7 08             	add    $0x8,%edi
80106b58:	e8 c3 cb ff ff       	call   80103720 <mycpu>
80106b5d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106b60:	83 c0 08             	add    $0x8,%eax
80106b63:	ba 67 00 00 00       	mov    $0x67,%edx
80106b68:	c1 e8 18             	shr    $0x18,%eax
80106b6b:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106b72:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106b79:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80106b80:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106b87:	83 c1 08             	add    $0x8,%ecx
80106b8a:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106b90:	c1 e9 10             	shr    $0x10,%ecx
80106b93:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106b99:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80106b9e:	e8 7d cb ff ff       	call   80103720 <mycpu>
80106ba3:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106baa:	e8 71 cb ff ff       	call   80103720 <mycpu>
80106baf:	b9 10 00 00 00       	mov    $0x10,%ecx
80106bb4:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106bb8:	e8 63 cb ff ff       	call   80103720 <mycpu>
80106bbd:	8b 56 08             	mov    0x8(%esi),%edx
80106bc0:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80106bc6:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106bc9:	e8 52 cb ff ff       	call   80103720 <mycpu>
80106bce:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80106bd2:	b8 28 00 00 00       	mov    $0x28,%eax
80106bd7:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106bda:	8b 46 04             	mov    0x4(%esi),%eax
80106bdd:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106be2:	0f 22 d8             	mov    %eax,%cr3
  popcli();
}
80106be5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106be8:	5b                   	pop    %ebx
80106be9:	5e                   	pop    %esi
80106bea:	5f                   	pop    %edi
80106beb:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80106bec:	e9 5f d9 ff ff       	jmp    80104550 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80106bf1:	83 ec 0c             	sub    $0xc,%esp
80106bf4:	68 32 7b 10 80       	push   $0x80107b32
80106bf9:	e8 72 97 ff ff       	call   80100370 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80106bfe:	83 ec 0c             	sub    $0xc,%esp
80106c01:	68 5d 7b 10 80       	push   $0x80107b5d
80106c06:	e8 65 97 ff ff       	call   80100370 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80106c0b:	83 ec 0c             	sub    $0xc,%esp
80106c0e:	68 48 7b 10 80       	push   $0x80107b48
80106c13:	e8 58 97 ff ff       	call   80100370 <panic>
80106c18:	90                   	nop
80106c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106c20 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106c20:	55                   	push   %ebp
80106c21:	89 e5                	mov    %esp,%ebp
80106c23:	57                   	push   %edi
80106c24:	56                   	push   %esi
80106c25:	53                   	push   %ebx
80106c26:	83 ec 1c             	sub    $0x1c,%esp
80106c29:	8b 75 10             	mov    0x10(%ebp),%esi
80106c2c:	8b 45 08             	mov    0x8(%ebp),%eax
80106c2f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80106c32:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106c38:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106c3b:	77 49                	ja     80106c86 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
80106c3d:	e8 4e b8 ff ff       	call   80102490 <kalloc>
  memset(mem, 0, PGSIZE);
80106c42:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106c45:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106c47:	68 00 10 00 00       	push   $0x1000
80106c4c:	6a 00                	push   $0x0
80106c4e:	50                   	push   %eax
80106c4f:	e8 9c da ff ff       	call   801046f0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106c54:	58                   	pop    %eax
80106c55:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106c5b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106c60:	5a                   	pop    %edx
80106c61:	6a 06                	push   $0x6
80106c63:	50                   	push   %eax
80106c64:	31 d2                	xor    %edx,%edx
80106c66:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106c69:	e8 52 fc ff ff       	call   801068c0 <mappages>
  memmove(mem, init, sz);
80106c6e:	89 75 10             	mov    %esi,0x10(%ebp)
80106c71:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106c74:	83 c4 10             	add    $0x10,%esp
80106c77:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106c7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c7d:	5b                   	pop    %ebx
80106c7e:	5e                   	pop    %esi
80106c7f:	5f                   	pop    %edi
80106c80:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106c81:	e9 1a db ff ff       	jmp    801047a0 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106c86:	83 ec 0c             	sub    $0xc,%esp
80106c89:	68 71 7b 10 80       	push   $0x80107b71
80106c8e:	e8 dd 96 ff ff       	call   80100370 <panic>
80106c93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ca0 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106ca0:	55                   	push   %ebp
80106ca1:	89 e5                	mov    %esp,%ebp
80106ca3:	57                   	push   %edi
80106ca4:	56                   	push   %esi
80106ca5:	53                   	push   %ebx
80106ca6:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106ca9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106cb0:	0f 85 91 00 00 00    	jne    80106d47 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106cb6:	8b 75 18             	mov    0x18(%ebp),%esi
80106cb9:	31 db                	xor    %ebx,%ebx
80106cbb:	85 f6                	test   %esi,%esi
80106cbd:	75 1a                	jne    80106cd9 <loaduvm+0x39>
80106cbf:	eb 6f                	jmp    80106d30 <loaduvm+0x90>
80106cc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cc8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106cce:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106cd4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106cd7:	76 57                	jbe    80106d30 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106cd9:	8b 55 0c             	mov    0xc(%ebp),%edx
80106cdc:	8b 45 08             	mov    0x8(%ebp),%eax
80106cdf:	31 c9                	xor    %ecx,%ecx
80106ce1:	01 da                	add    %ebx,%edx
80106ce3:	e8 58 fb ff ff       	call   80106840 <walkpgdir>
80106ce8:	85 c0                	test   %eax,%eax
80106cea:	74 4e                	je     80106d3a <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106cec:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106cee:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
80106cf1:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106cf6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106cfb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106d01:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d04:	01 d9                	add    %ebx,%ecx
80106d06:	05 00 00 00 80       	add    $0x80000000,%eax
80106d0b:	57                   	push   %edi
80106d0c:	51                   	push   %ecx
80106d0d:	50                   	push   %eax
80106d0e:	ff 75 10             	pushl  0x10(%ebp)
80106d11:	e8 3a ac ff ff       	call   80101950 <readi>
80106d16:	83 c4 10             	add    $0x10,%esp
80106d19:	39 c7                	cmp    %eax,%edi
80106d1b:	74 ab                	je     80106cc8 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106d1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106d20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106d25:	5b                   	pop    %ebx
80106d26:	5e                   	pop    %esi
80106d27:	5f                   	pop    %edi
80106d28:	5d                   	pop    %ebp
80106d29:	c3                   	ret    
80106d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d30:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80106d33:	31 c0                	xor    %eax,%eax
}
80106d35:	5b                   	pop    %ebx
80106d36:	5e                   	pop    %esi
80106d37:	5f                   	pop    %edi
80106d38:	5d                   	pop    %ebp
80106d39:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106d3a:	83 ec 0c             	sub    $0xc,%esp
80106d3d:	68 8b 7b 10 80       	push   $0x80107b8b
80106d42:	e8 29 96 ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106d47:	83 ec 0c             	sub    $0xc,%esp
80106d4a:	68 2c 7c 10 80       	push   $0x80107c2c
80106d4f:	e8 1c 96 ff ff       	call   80100370 <panic>
80106d54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106d60 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106d60:	55                   	push   %ebp
80106d61:	89 e5                	mov    %esp,%ebp
80106d63:	57                   	push   %edi
80106d64:	56                   	push   %esi
80106d65:	53                   	push   %ebx
80106d66:	83 ec 0c             	sub    $0xc,%esp
80106d69:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106d6c:	85 ff                	test   %edi,%edi
80106d6e:	78 7b                	js     80106deb <allocuvm+0x8b>
    return 0;
  if(newsz < oldsz)
80106d70:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106d73:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
80106d76:	72 75                	jb     80106ded <allocuvm+0x8d>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106d78:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106d7e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106d84:	39 df                	cmp    %ebx,%edi
80106d86:	77 43                	ja     80106dcb <allocuvm+0x6b>
80106d88:	eb 6e                	jmp    80106df8 <allocuvm+0x98>
80106d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106d90:	83 ec 04             	sub    $0x4,%esp
80106d93:	68 00 10 00 00       	push   $0x1000
80106d98:	6a 00                	push   $0x0
80106d9a:	50                   	push   %eax
80106d9b:	e8 50 d9 ff ff       	call   801046f0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106da0:	58                   	pop    %eax
80106da1:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106da7:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106dac:	5a                   	pop    %edx
80106dad:	6a 06                	push   $0x6
80106daf:	50                   	push   %eax
80106db0:	89 da                	mov    %ebx,%edx
80106db2:	8b 45 08             	mov    0x8(%ebp),%eax
80106db5:	e8 06 fb ff ff       	call   801068c0 <mappages>
80106dba:	83 c4 10             	add    $0x10,%esp
80106dbd:	85 c0                	test   %eax,%eax
80106dbf:	78 47                	js     80106e08 <allocuvm+0xa8>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106dc1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106dc7:	39 df                	cmp    %ebx,%edi
80106dc9:	76 2d                	jbe    80106df8 <allocuvm+0x98>
    mem = kalloc();
80106dcb:	e8 c0 b6 ff ff       	call   80102490 <kalloc>
    if(mem == 0){
80106dd0:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106dd2:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106dd4:	75 ba                	jne    80106d90 <allocuvm+0x30>
      cprintf("allocuvm out of memory\n");
80106dd6:	83 ec 0c             	sub    $0xc,%esp
80106dd9:	68 a9 7b 10 80       	push   $0x80107ba9
80106dde:	e8 7d 98 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106de3:	83 c4 10             	add    $0x10,%esp
80106de6:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106de9:	77 4f                	ja     80106e3a <allocuvm+0xda>
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80106deb:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80106ded:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106df0:	5b                   	pop    %ebx
80106df1:	5e                   	pop    %esi
80106df2:	5f                   	pop    %edi
80106df3:	5d                   	pop    %ebp
80106df4:	c3                   	ret    
80106df5:	8d 76 00             	lea    0x0(%esi),%esi
80106df8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106dfb:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106dfd:	5b                   	pop    %ebx
80106dfe:	5e                   	pop    %esi
80106dff:	5f                   	pop    %edi
80106e00:	5d                   	pop    %ebp
80106e01:	c3                   	ret    
80106e02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106e08:	83 ec 0c             	sub    $0xc,%esp
80106e0b:	68 c1 7b 10 80       	push   $0x80107bc1
80106e10:	e8 4b 98 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106e15:	83 c4 10             	add    $0x10,%esp
80106e18:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106e1b:	76 0d                	jbe    80106e2a <allocuvm+0xca>
80106e1d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106e20:	8b 45 08             	mov    0x8(%ebp),%eax
80106e23:	89 fa                	mov    %edi,%edx
80106e25:	e8 26 fb ff ff       	call   80106950 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80106e2a:	83 ec 0c             	sub    $0xc,%esp
80106e2d:	56                   	push   %esi
80106e2e:	e8 ad b4 ff ff       	call   801022e0 <kfree>
      return 0;
80106e33:	83 c4 10             	add    $0x10,%esp
80106e36:	31 c0                	xor    %eax,%eax
80106e38:	eb b3                	jmp    80106ded <allocuvm+0x8d>
80106e3a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106e3d:	8b 45 08             	mov    0x8(%ebp),%eax
80106e40:	89 fa                	mov    %edi,%edx
80106e42:	e8 09 fb ff ff       	call   80106950 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80106e47:	31 c0                	xor    %eax,%eax
80106e49:	eb a2                	jmp    80106ded <allocuvm+0x8d>
80106e4b:	90                   	nop
80106e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106e50 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106e50:	55                   	push   %ebp
80106e51:	89 e5                	mov    %esp,%ebp
80106e53:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e56:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106e59:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106e5c:	39 d1                	cmp    %edx,%ecx
80106e5e:	73 10                	jae    80106e70 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106e60:	5d                   	pop    %ebp
80106e61:	e9 ea fa ff ff       	jmp    80106950 <deallocuvm.part.0>
80106e66:	8d 76 00             	lea    0x0(%esi),%esi
80106e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106e70:	89 d0                	mov    %edx,%eax
80106e72:	5d                   	pop    %ebp
80106e73:	c3                   	ret    
80106e74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106e80 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106e80:	55                   	push   %ebp
80106e81:	89 e5                	mov    %esp,%ebp
80106e83:	57                   	push   %edi
80106e84:	56                   	push   %esi
80106e85:	53                   	push   %ebx
80106e86:	83 ec 0c             	sub    $0xc,%esp
80106e89:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106e8c:	85 f6                	test   %esi,%esi
80106e8e:	74 59                	je     80106ee9 <freevm+0x69>
80106e90:	31 c9                	xor    %ecx,%ecx
80106e92:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106e97:	89 f0                	mov    %esi,%eax
80106e99:	e8 b2 fa ff ff       	call   80106950 <deallocuvm.part.0>
80106e9e:	89 f3                	mov    %esi,%ebx
80106ea0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106ea6:	eb 0f                	jmp    80106eb7 <freevm+0x37>
80106ea8:	90                   	nop
80106ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106eb0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106eb3:	39 fb                	cmp    %edi,%ebx
80106eb5:	74 23                	je     80106eda <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106eb7:	8b 03                	mov    (%ebx),%eax
80106eb9:	a8 01                	test   $0x1,%al
80106ebb:	74 f3                	je     80106eb0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106ebd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106ec2:	83 ec 0c             	sub    $0xc,%esp
80106ec5:	83 c3 04             	add    $0x4,%ebx
  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106ec8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106ecd:	50                   	push   %eax
80106ece:	e8 0d b4 ff ff       	call   801022e0 <kfree>
80106ed3:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106ed6:	39 fb                	cmp    %edi,%ebx
80106ed8:	75 dd                	jne    80106eb7 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106eda:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106edd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ee0:	5b                   	pop    %ebx
80106ee1:	5e                   	pop    %esi
80106ee2:	5f                   	pop    %edi
80106ee3:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106ee4:	e9 f7 b3 ff ff       	jmp    801022e0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106ee9:	83 ec 0c             	sub    $0xc,%esp
80106eec:	68 dd 7b 10 80       	push   $0x80107bdd
80106ef1:	e8 7a 94 ff ff       	call   80100370 <panic>
80106ef6:	8d 76 00             	lea    0x0(%esi),%esi
80106ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f00 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106f00:	55                   	push   %ebp
80106f01:	89 e5                	mov    %esp,%ebp
80106f03:	56                   	push   %esi
80106f04:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106f05:	e8 86 b5 ff ff       	call   80102490 <kalloc>
80106f0a:	85 c0                	test   %eax,%eax
80106f0c:	89 c6                	mov    %eax,%esi
80106f0e:	74 42                	je     80106f52 <setupkvm+0x52>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106f10:	83 ec 04             	sub    $0x4,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f13:	bb 80 a4 10 80       	mov    $0x8010a480,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80106f18:	68 00 10 00 00       	push   $0x1000
80106f1d:	6a 00                	push   $0x0
80106f1f:	50                   	push   %eax
80106f20:	e8 cb d7 ff ff       	call   801046f0 <memset>
80106f25:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
80106f28:	8b 43 04             	mov    0x4(%ebx),%eax
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106f2b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106f2e:	83 ec 08             	sub    $0x8,%esp
80106f31:	8b 13                	mov    (%ebx),%edx
80106f33:	ff 73 0c             	pushl  0xc(%ebx)
80106f36:	50                   	push   %eax
80106f37:	29 c1                	sub    %eax,%ecx
80106f39:	89 f0                	mov    %esi,%eax
80106f3b:	e8 80 f9 ff ff       	call   801068c0 <mappages>
80106f40:	83 c4 10             	add    $0x10,%esp
80106f43:	85 c0                	test   %eax,%eax
80106f45:	78 19                	js     80106f60 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f47:	83 c3 10             	add    $0x10,%ebx
80106f4a:	81 fb c0 a4 10 80    	cmp    $0x8010a4c0,%ebx
80106f50:	75 d6                	jne    80106f28 <setupkvm+0x28>
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80106f52:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106f55:	89 f0                	mov    %esi,%eax
80106f57:	5b                   	pop    %ebx
80106f58:	5e                   	pop    %esi
80106f59:	5d                   	pop    %ebp
80106f5a:	c3                   	ret    
80106f5b:	90                   	nop
80106f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80106f60:	83 ec 0c             	sub    $0xc,%esp
80106f63:	56                   	push   %esi
      return 0;
80106f64:	31 f6                	xor    %esi,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80106f66:	e8 15 ff ff ff       	call   80106e80 <freevm>
      return 0;
80106f6b:	83 c4 10             	add    $0x10,%esp
    }
  return pgdir;
}
80106f6e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106f71:	89 f0                	mov    %esi,%eax
80106f73:	5b                   	pop    %ebx
80106f74:	5e                   	pop    %esi
80106f75:	5d                   	pop    %ebp
80106f76:	c3                   	ret    
80106f77:	89 f6                	mov    %esi,%esi
80106f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f80 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106f80:	55                   	push   %ebp
80106f81:	89 e5                	mov    %esp,%ebp
80106f83:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106f86:	e8 75 ff ff ff       	call   80106f00 <setupkvm>
80106f8b:	a3 04 5a 11 80       	mov    %eax,0x80115a04
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106f90:	05 00 00 00 80       	add    $0x80000000,%eax
80106f95:	0f 22 d8             	mov    %eax,%cr3
void
kvmalloc(void)
{
  kpgdir = setupkvm();
  switchkvm();
}
80106f98:	c9                   	leave  
80106f99:	c3                   	ret    
80106f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106fa0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106fa0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106fa1:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106fa3:	89 e5                	mov    %esp,%ebp
80106fa5:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106fa8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106fab:	8b 45 08             	mov    0x8(%ebp),%eax
80106fae:	e8 8d f8 ff ff       	call   80106840 <walkpgdir>
  if(pte == 0)
80106fb3:	85 c0                	test   %eax,%eax
80106fb5:	74 05                	je     80106fbc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106fb7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106fba:	c9                   	leave  
80106fbb:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80106fbc:	83 ec 0c             	sub    $0xc,%esp
80106fbf:	68 ee 7b 10 80       	push   $0x80107bee
80106fc4:	e8 a7 93 ff ff       	call   80100370 <panic>
80106fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106fd0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106fd0:	55                   	push   %ebp
80106fd1:	89 e5                	mov    %esp,%ebp
80106fd3:	57                   	push   %edi
80106fd4:	56                   	push   %esi
80106fd5:	53                   	push   %ebx
80106fd6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106fd9:	e8 22 ff ff ff       	call   80106f00 <setupkvm>
80106fde:	85 c0                	test   %eax,%eax
80106fe0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106fe3:	0f 84 9f 00 00 00    	je     80107088 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106fe9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106fec:	85 c9                	test   %ecx,%ecx
80106fee:	0f 84 94 00 00 00    	je     80107088 <copyuvm+0xb8>
80106ff4:	31 ff                	xor    %edi,%edi
80106ff6:	eb 4a                	jmp    80107042 <copyuvm+0x72>
80106ff8:	90                   	nop
80106ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107000:	83 ec 04             	sub    $0x4,%esp
80107003:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80107009:	68 00 10 00 00       	push   $0x1000
8010700e:	53                   	push   %ebx
8010700f:	50                   	push   %eax
80107010:	e8 8b d7 ff ff       	call   801047a0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107015:	58                   	pop    %eax
80107016:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010701c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107021:	5a                   	pop    %edx
80107022:	ff 75 e4             	pushl  -0x1c(%ebp)
80107025:	50                   	push   %eax
80107026:	89 fa                	mov    %edi,%edx
80107028:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010702b:	e8 90 f8 ff ff       	call   801068c0 <mappages>
80107030:	83 c4 10             	add    $0x10,%esp
80107033:	85 c0                	test   %eax,%eax
80107035:	78 61                	js     80107098 <copyuvm+0xc8>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107037:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010703d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80107040:	76 46                	jbe    80107088 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107042:	8b 45 08             	mov    0x8(%ebp),%eax
80107045:	31 c9                	xor    %ecx,%ecx
80107047:	89 fa                	mov    %edi,%edx
80107049:	e8 f2 f7 ff ff       	call   80106840 <walkpgdir>
8010704e:	85 c0                	test   %eax,%eax
80107050:	74 61                	je     801070b3 <copyuvm+0xe3>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80107052:	8b 00                	mov    (%eax),%eax
80107054:	a8 01                	test   $0x1,%al
80107056:	74 4e                	je     801070a6 <copyuvm+0xd6>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107058:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
8010705a:	25 ff 0f 00 00       	and    $0xfff,%eax
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
8010705f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80107065:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80107068:	e8 23 b4 ff ff       	call   80102490 <kalloc>
8010706d:	85 c0                	test   %eax,%eax
8010706f:	89 c6                	mov    %eax,%esi
80107071:	75 8d                	jne    80107000 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107073:	83 ec 0c             	sub    $0xc,%esp
80107076:	ff 75 e0             	pushl  -0x20(%ebp)
80107079:	e8 02 fe ff ff       	call   80106e80 <freevm>
  return 0;
8010707e:	83 c4 10             	add    $0x10,%esp
80107081:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107088:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010708b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010708e:	5b                   	pop    %ebx
8010708f:	5e                   	pop    %esi
80107090:	5f                   	pop    %edi
80107091:	5d                   	pop    %ebp
80107092:	c3                   	ret    
80107093:	90                   	nop
80107094:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
      kfree(mem);
80107098:	83 ec 0c             	sub    $0xc,%esp
8010709b:	56                   	push   %esi
8010709c:	e8 3f b2 ff ff       	call   801022e0 <kfree>
      goto bad;
801070a1:	83 c4 10             	add    $0x10,%esp
801070a4:	eb cd                	jmp    80107073 <copyuvm+0xa3>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
801070a6:	83 ec 0c             	sub    $0xc,%esp
801070a9:	68 12 7c 10 80       	push   $0x80107c12
801070ae:	e8 bd 92 ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801070b3:	83 ec 0c             	sub    $0xc,%esp
801070b6:	68 f8 7b 10 80       	push   $0x80107bf8
801070bb:	e8 b0 92 ff ff       	call   80100370 <panic>

801070c0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801070c0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801070c1:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801070c3:	89 e5                	mov    %esp,%ebp
801070c5:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801070c8:	8b 55 0c             	mov    0xc(%ebp),%edx
801070cb:	8b 45 08             	mov    0x8(%ebp),%eax
801070ce:	e8 6d f7 ff ff       	call   80106840 <walkpgdir>
  if((*pte & PTE_P) == 0)
801070d3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801070d5:	c9                   	leave  
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
801070d6:	89 c2                	mov    %eax,%edx
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801070d8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
801070dd:	83 e2 05             	and    $0x5,%edx
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801070e0:	05 00 00 00 80       	add    $0x80000000,%eax
801070e5:	83 fa 05             	cmp    $0x5,%edx
801070e8:	ba 00 00 00 00       	mov    $0x0,%edx
801070ed:	0f 45 c2             	cmovne %edx,%eax
}
801070f0:	c3                   	ret    
801070f1:	eb 0d                	jmp    80107100 <copyout>
801070f3:	90                   	nop
801070f4:	90                   	nop
801070f5:	90                   	nop
801070f6:	90                   	nop
801070f7:	90                   	nop
801070f8:	90                   	nop
801070f9:	90                   	nop
801070fa:	90                   	nop
801070fb:	90                   	nop
801070fc:	90                   	nop
801070fd:	90                   	nop
801070fe:	90                   	nop
801070ff:	90                   	nop

80107100 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107100:	55                   	push   %ebp
80107101:	89 e5                	mov    %esp,%ebp
80107103:	57                   	push   %edi
80107104:	56                   	push   %esi
80107105:	53                   	push   %ebx
80107106:	83 ec 1c             	sub    $0x1c,%esp
80107109:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010710c:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010710f:	8b 7d 10             	mov    0x10(%ebp),%edi
80107112:	85 db                	test   %ebx,%ebx
80107114:	75 40                	jne    80107156 <copyout+0x56>
80107116:	eb 70                	jmp    80107188 <copyout+0x88>
80107118:	90                   	nop
80107119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107120:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107123:	89 f1                	mov    %esi,%ecx
80107125:	29 d1                	sub    %edx,%ecx
80107127:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010712d:	39 d9                	cmp    %ebx,%ecx
8010712f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107132:	29 f2                	sub    %esi,%edx
80107134:	83 ec 04             	sub    $0x4,%esp
80107137:	01 d0                	add    %edx,%eax
80107139:	51                   	push   %ecx
8010713a:	57                   	push   %edi
8010713b:	50                   	push   %eax
8010713c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010713f:	e8 5c d6 ff ff       	call   801047a0 <memmove>
    len -= n;
    buf += n;
80107144:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107147:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
8010714a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80107150:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107152:	29 cb                	sub    %ecx,%ebx
80107154:	74 32                	je     80107188 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107156:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107158:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
8010715b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010715e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107164:	56                   	push   %esi
80107165:	ff 75 08             	pushl  0x8(%ebp)
80107168:	e8 53 ff ff ff       	call   801070c0 <uva2ka>
    if(pa0 == 0)
8010716d:	83 c4 10             	add    $0x10,%esp
80107170:	85 c0                	test   %eax,%eax
80107172:	75 ac                	jne    80107120 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80107174:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80107177:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
8010717c:	5b                   	pop    %ebx
8010717d:	5e                   	pop    %esi
8010717e:	5f                   	pop    %edi
8010717f:	5d                   	pop    %ebp
80107180:	c3                   	ret    
80107181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107188:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
8010718b:	31 c0                	xor    %eax,%eax
}
8010718d:	5b                   	pop    %ebx
8010718e:	5e                   	pop    %esi
8010718f:	5f                   	pop    %edi
80107190:	5d                   	pop    %ebp
80107191:	c3                   	ret    
