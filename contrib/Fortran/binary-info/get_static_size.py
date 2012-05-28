#!/usr/bin/env python

import subprocess
import sys
import os

binary = sys.argv[1]

if not os.path.isfile(binary):
    print('binary does not exist')
    sys.exit()

command = "size %s 2> /dev/null | grep %s" % (binary, binary)
process = subprocess.Popen(command, stdout=subprocess.PIPE, shell=True)
output = process.stdout.read().strip()

total_size = float(output.split()[2])/(1024*1024)
print('total static size of %s: %10.1f MB' % (binary, total_size))

command = "readelf -s %s 2> /dev/null || echo 'cannot be determined, readelf not present'" % binary
process = subprocess.Popen(command, stdout=subprocess.PIPE, shell=True)

l = []
for line in process.stdout.readlines():
    if 'DEFAULT' in line:
        size = int(line.split()[2], 16)
        name = line.split()[-1]
        l.append([size, name])

l.sort(reverse=True)

print ('top 10 consumers')
for i in range(10):
    print('%10i MB %s' % (l[i][0]/(1024*1024), l[i][1]))
