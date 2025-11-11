# sim.do - универсальный симулятор

set project_dir "1.3_async/src"
set bench_dir "1.3_async/bench"
set run_time "120ns"

if {[file exists work]} { vdel -all }
if {[file exists vsim.wlf]} { file delete vsim.wlf }

vlib work
vmap work work

# Компиляция всех файлов
foreach f [glob $project_dir/*.v] {
    vlog $f
}
foreach f [glob $bench_dir/*.v] {
    vlog $f
}

# Тестбенч
set top_module "test"
vsim work.$top_module
add wave sim:/test/*
run $run_time