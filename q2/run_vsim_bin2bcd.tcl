# run_vsim_bin2bcd.tcl

transcript on
if {[file exists work]} { vdel -lib work -all }
vlib work
vmap work work

vlog -sv +acc bin2bcd.sv bin2bcd_tb.sv

vsim -voptargs=+acc work.bin2bcd_tb -do {
    quietly set NumericStdNoWarnings 1
    view wave
    add wave -r /*
    run -all
    wave zoom full
}
