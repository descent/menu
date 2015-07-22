#!/bin/sh
#CC=gcc
CC=arm-none-linux-gnueabi-gcc
$CC -static -o init linktable.c menu.c test.c -lpthread
