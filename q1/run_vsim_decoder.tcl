# run_vsim_decoder.tcl
transcript on
if {[file exists work]} { vdel -lib work -all }
vlib work
vmap work work

vlog -sv +acc decoder.sv decoder_tb.sv

vsim -voptargs=+acc work.decoder_tb -do {
    quietly set NumericStdNoWarnings 1
    view wave
    add wave -r /*
    run -all
    wave zoom full
}
