# run_vsim_arithmetic_right_shifter.tcl
transcript on
if {[file exists work]} { vdel -lib work -all }
vlib work
vmap work work
vlog -sv +acc arithmetic_right_shifter.sv arithmetic_right_shifter_tb.sv
vsim -voptargs=+acc work.arithmetic_right_shifter_tb -do {
    quietly set NumericStdNoWarnings 1
    view wave
    add wave -r /*
    run -all
    wave zoom full
}
