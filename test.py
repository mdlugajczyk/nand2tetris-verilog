#!/usr/local/bin/python3.6

import os
import re
import sys
import time
from subprocess import check_output, call, CalledProcessError


class bcolors:
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'


class TestBenchRunner(object):
    def __init__(self, filename):
        self.name = filename


def simulate(filename):
    simulation_command = ["/home/jegor/intelFPGA/18.1/modelsim_ase/bin/vsim", "-c"]
    simulation_command.append(filename)
    simulation_command = simulation_command + ["-do", "run", "-do", "quit"]

    try:
        output = check_output(simulation_command).decode("utf-8")
        assertion_errors = len(re.findall(r'Error: Assertion error.', output))
        print(output)
        color = bcolors.FAIL if assertion_errors > 0 else bcolors.OKGREEN
        print(color + "Found", assertion_errors, "assertion errors", "in", filename, bcolors.ENDC, "\n")
        return {"assertion_errors": assertion_errors, "run_errors": 0}
    except CalledProcessError as e:
        return_code = e.returncode
        print(bcolors.FAIL + "Error while running", filename, return_code, bcolors.ENDC, "\n")
        return {"assertion_errors": 0, "run_errors": 1}


if __name__ == '__main__':
    os.chdir(sys.argv[1])
    verilog_files = [f for f in os.listdir("./") if re.search(r'.*\.sv$', f)]
    test_files = [f for f in os.listdir("./") if re.search(r'.*_tb\.sv$', f)]

    compile_command = ["/home/jegor/intelFPGA/18.1/modelsim_ase/bin/vlog"]
    for filename in verilog_files:
        compile_command.append(filename)
    call(compile_command)

    assertion_errors = 0
    run_errors = 0
    successful_test_benches = 0
    unsuccessful_test_benches = 0
    test_benches_with_assertion_errors = 0
    for filename in test_files:
        errors = simulate(filename[0:-3])
        assertion_errors += errors["assertion_errors"]
        run_errors += errors["run_errors"]

        if errors["assertion_errors"] > 0:
            test_benches_with_assertion_errors += 1

        if errors["run_errors"] > 0 or errors["assertion_errors"] > 0:
            unsuccessful_test_benches += 1
        else:
            successful_test_benches += 1

    color = bcolors.FAIL if unsuccessful_test_benches > 0 else bcolors.OKGREEN
    print(color + "Finished testing\n")
    print(bcolors.OKGREEN + str(successful_test_benches), "test benches ran without any errors")
    if unsuccessful_test_benches > 0:
        print(bcolors.FAIL+str(unsuccessful_test_benches), "test benches had errors, of which:",
            "\n"+str(test_benches_with_assertion_errors), "ran, but had a total of ",assertion_errors,"assertion errors",
            "\n"+str(run_errors), "testbenches failed to run", bcolors.ENDC)
