@echo off

if "%1"=="" goto usage

set PROJECT_DIR_ARG=%1
set BENCH_DIR_ARG=%2
set RUN_TIME_ARG=%3
set TOP_MODULE_ARG=%4

vsim -do "set project_dir %PROJECT_DIR_ARG%; set bench_dir %BENCH_DIR_ARG%; set run_time %RUN_TIME_ARG%; set top_module %TOP_MODULE_ARG%; do sim.do"

:usage
echo.
echo Usage: run_sim.bat ^<project_dir^> ^<bench_dir^> ^<run_time^> ^<top_module^>
echo Example: run_sim.bat 1.1/src 1.1/bench 50ns test