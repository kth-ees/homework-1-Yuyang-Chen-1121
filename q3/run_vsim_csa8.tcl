#run_vsim_csa8.tcl
transcript on
if {[file exists work]} { vdel -lib work -all }
vlib work
vmap work work
vlog -sv +acc adder_4.sv csa_8.sv csa_8_tb.sv
vsim -voptargs=+acc work.csa_8_tb -do {
    quietly set NumericStdNoWarnings 1
    view wave
    add wave -r /*
    run -all
    wave zoom full
}
