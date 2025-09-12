# run_vsim_count1.tcl
transcript on
if {[file exists work]} { vdel -lib work -all }
vlib work
vmap work work
vlog -sv +acc count_1.sv count_1_tb.sv
vsim -voptargs=+acc work.count_1_tb -do {
    quietly set NumericStdNoWarnings 1
    view wave
    add wave -r /*
    run -all
    wave zoom full
}
