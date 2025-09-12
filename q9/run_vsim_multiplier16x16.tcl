# run_vsim_multiplier16x16.tcl
transcript on
if {[file exists work]} { vdel -lib work -all }
vlib work
vmap work work
vlog -sv +acc multiplier.sv multiplier_tb.sv
vsim -voptargs=+acc work.multiplier_tb -do {
    quietly set NumericStdNoWarnings 1
    view wave
    add wave -r /*
    run -all
    wave zoom full
}
