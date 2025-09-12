# run_vsim_sum_prod.tcl
transcript on
if {[file exists work]} { vdel -lib work -all }
vlib work
vmap work work
vlog -sv +acc sum_prod.sv sum_prod_tb.sv
vsim -voptargs=+acc work.sum_prod_tb -do {
    quietly set NumericStdNoWarnings 1
    view wave
    add wave -r /*
    run -all
    wave zoom full
}
