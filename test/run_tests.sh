#!/bin/bash

# Check if the number of processes is provided as a command line argument
if [ $# -ne 2 ] || [ "$1" != "-n" ]; then
    echo "Usage: $0 -n <num_processes>"
    exit 1
fi

num_processes=$2

TIME_CMD="command time -v"
[[ "$OSTYPE" == "darwin"* ]] && TIME_CMD="command gtime -v"

# Run the jobs serially
$TIME_CMD mpiexec -n $num_processes ./FANS input_files/test_LinearThermal.json test_LinearThermal.h5 > test_LinearThermal.log 2>&1

$TIME_CMD mpiexec -n $num_processes ./FANS input_files/test_LinearElastic.json test_LinearElastic.h5 > test_LinearElastic.log 2>&1

$TIME_CMD mpiexec -n $num_processes ./FANS input_files/test_PseudoPlastic.json test_PseudoPlastic.h5 > test_PseudoPlastic.log 2>&1

$TIME_CMD mpiexec -n $num_processes ./FANS input_files/test_J2Plasticity.json test_J2Plasticity.h5 > test_J2Plasticity.log 2>&1

$TIME_CMD mpiexec -n $num_processes ./FANS input_files/test_MixedBCs.json test_MixedBCs.h5 > test_MixedBCs.log 2>&1
