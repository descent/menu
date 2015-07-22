#
# Makefile for Menu Program
# make arm=1, generate test.arm

CC_PTHREAD_FLAGS			 = -lpthread
CC_FLAGS                     = -c 
CC_OUTPUT_FLAGS				 = -o
CC                           = gcc
CFLAGS=-m32 -static
RM                           = rm
RM_FLAGS                     = -f
TARGET  =   test

ifdef arm
CC = arm-none-linux-gnueabi-gcc
CFLAGS=-static
TARGET  =   test.arm
endif


OBJS    =   linktable.o  menu.o test.o

all:	$(OBJS)
	$(CC) $(CC_OUTPUT_FLAGS) $(TARGET) $(OBJS) $(CFLAGS) -lpthread
rootfs:
	$(CC) -o init linktable.c menu.c test.c $(CFLAGS) -lpthread
	$(CC) -o hello hello.c $(CFLAGS)
	cp hello ../rootfs/
	cp init ../rootfs/
	find init hello | cpio -o -Hnewc |gzip -9 > ../rootfs.img
	qemu -kernel ../linux-3.18.6/arch/x86/boot/bzImage -initrd ../rootfs.img
.c.o:
	$(CC) $(CC_FLAGS) $(CFLAGS) $<

clean:
	$(RM) $(RM_FLAGS)  $(OBJS) $(TARGET) *.bak test.arm test
