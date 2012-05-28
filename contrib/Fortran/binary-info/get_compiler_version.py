#!/usr/bin/env python

import sys
import os
import subprocess

if len(sys.argv) == 1:
    sys.exit('call script with argument')

compiler_name = os.path.split(sys.argv[1])[-1]

command_d = {}

command_d['mpif90']       = 'mpif90       --version'
command_d['gfortran']     = 'gfortran     --version'
command_d['gfortran.exe'] = 'gfortran.exe --version'
command_d['gfortran44']   = 'gfortran44   --version'
command_d['f95']          = 'f95          --version'
command_d['ifort']        = 'ifort        --version'
command_d['pgf90']        = 'pgf90        -V'
command_d['xlf']          = 'xlf          -qversion'

command_d['mpicc']        = 'mpicc        --version'
command_d['gcc']          = 'gcc          --version'
command_d['gcc.exe']      = 'gcc.exe      --version'
command_d['gcc44']        = 'gcc44        --version'
command_d['icc']          = 'icc          --version'
command_d['pgcc']         = 'pgcc         -V'
command_d['xlc']          = 'xlc          -qversion'
command_d['g++']          = 'g++          --version'
command_d['iCC']          = 'iCC          --version'
command_d['pgCC']         = 'pgCC         -V'
command_d['xlCC']         = 'xlCC         -qversion'

version = 'unknown'

if sys.version >= '2.4':
    if compiler_name in command_d:
        p = subprocess.Popen(command_d[compiler_name], shell=True, \
                             stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        out = p.communicate()[0]
        if out != '':
            # use only first line, not the copyright stuff
            version = out.split('\n')[0]

print(version)
