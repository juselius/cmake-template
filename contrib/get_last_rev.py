#!/usr/bin/env python

import sys

if len(sys.argv) == 1:
    sys.exit('call script with argument (source dir)')

last_commit_rev = 'unknown'

if sys.version >= '2.4':
    import re
    import string
    import subprocess
    import os
    command = 'cd %s; git show' % sys.argv[1]
    p = subprocess.Popen(command, shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = p.communicate()
    if stderr:
        last_commit_rev = 'unknown'
    else:
        last_commit_rev = string.replace(stdout.splitlines()[0], 'commit ', '')

print(last_commit_rev)
