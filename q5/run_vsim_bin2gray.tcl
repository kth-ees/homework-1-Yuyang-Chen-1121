# run_vsim_bin2gray.tcl
transcript on
if {[file exists work]} { vdel -lib work -all }
vlib work
vmap work work
vlog -sv +acc bin2gray.sv bin2gray_tb.sv
vsim -voptargs=+acc work.bin2gray_tb -do {
    quietly set NumericStdNoWarnings 1
    view wave
    add wave -r /*
    run -all
    wave zoom full
}
