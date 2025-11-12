# sim.do - универсальный симулятор

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
vsim work.$top_module
add wave sim:/test/*
run $run_time