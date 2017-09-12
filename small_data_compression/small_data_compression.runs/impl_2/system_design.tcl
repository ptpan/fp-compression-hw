proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {Common-41} -limit 4294967295
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param gui.test TreeTableDev
  debug::add_scope template.lib 1
  create_project -in_memory -part xc7vx690tffg1761-2
  set_property board_part xilinx.com:vc709:part0:1.4 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir /home/ppan/Desktop/small_data_compression/small_data_compression.cache/wt [current_project]
  set_property parent.project_path /home/ppan/Desktop/small_data_compression/small_data_compression.xpr [current_project]
  set_property ip_repo_paths {
  /home/ppan/Desktop/small_data_compression/small_data_compression.cache/ip
  /home/ppan/Desktop/small_data_compression/small_data_compression.srcs
  /home/ppan/DUT/small_data_compression
} [current_project]
  set_property ip_output_repo /home/ppan/Desktop/small_data_compression/small_data_compression.cache/ip [current_project]
  add_files -quiet /home/ppan/Desktop/small_data_compression/small_data_compression.runs/synth_1/system_design.dcp
  add_files -quiet /home/ppan/Desktop/small_data_compression/small_data_compression.runs/dout_bram_synth_1/dout_bram.dcp
  set_property netlist_only true [get_files /home/ppan/Desktop/small_data_compression/small_data_compression.runs/dout_bram_synth_1/dout_bram.dcp]
  add_files -quiet /home/ppan/Desktop/small_data_compression/small_data_compression.runs/controller_synth_1/controller.dcp
  set_property netlist_only true [get_files /home/ppan/Desktop/small_data_compression/small_data_compression.runs/controller_synth_1/controller.dcp]
  add_files -quiet /home/ppan/Desktop/small_data_compression/small_data_compression.runs/DMA_synth_1/DMA.dcp
  set_property netlist_only true [get_files /home/ppan/Desktop/small_data_compression/small_data_compression.runs/DMA_synth_1/DMA.dcp]
  add_files -quiet /home/ppan/Desktop/small_data_compression/small_data_compression.runs/sg_bram_controller_synth_1/sg_bram_controller.dcp
  set_property netlist_only true [get_files /home/ppan/Desktop/small_data_compression/small_data_compression.runs/sg_bram_controller_synth_1/sg_bram_controller.dcp]
  add_files -quiet /home/ppan/Desktop/small_data_compression/small_data_compression.runs/sg_bram_synth_1/sg_bram.dcp
  set_property netlist_only true [get_files /home/ppan/Desktop/small_data_compression/small_data_compression.runs/sg_bram_synth_1/sg_bram.dcp]
  read_xdc -mode out_of_context -ref dout_bram -cells U0 /home/ppan/Desktop/small_data_compression/small_data_compression.srcs/sources_1/ip/dout_bram/dout_bram_ooc.xdc
  set_property processing_order EARLY [get_files /home/ppan/Desktop/small_data_compression/small_data_compression.srcs/sources_1/ip/dout_bram/dout_bram_ooc.xdc]
  read_xdc -mode out_of_context -ref controller -cells U0 /home/ppan/Desktop/small_data_compression/small_data_compression.srcs/sources_1/ip/controller/controller_ooc.xdc
  set_property processing_order EARLY [get_files /home/ppan/Desktop/small_data_compression/small_data_compression.srcs/sources_1/ip/controller/controller_ooc.xdc]
  read_xdc -mode out_of_context -ref DMA -cells U0 /home/ppan/Desktop/small_data_compression/small_data_compression.srcs/sources_1/ip/DMA/DMA_ooc.xdc
  set_property processing_order EARLY [get_files /home/ppan/Desktop/small_data_compression/small_data_compression.srcs/sources_1/ip/DMA/DMA_ooc.xdc]
  read_xdc -ref DMA -cells U0 /home/ppan/Desktop/small_data_compression/small_data_compression.srcs/sources_1/ip/DMA/DMA.xdc
  set_property processing_order EARLY [get_files /home/ppan/Desktop/small_data_compression/small_data_compression.srcs/sources_1/ip/DMA/DMA.xdc]
  read_xdc -mode out_of_context -ref sg_bram_controller -cells U0 /home/ppan/Desktop/small_data_compression/small_data_compression.srcs/sources_1/ip/sg_bram_controller/sg_bram_controller_ooc.xdc
  set_property processing_order EARLY [get_files /home/ppan/Desktop/small_data_compression/small_data_compression.srcs/sources_1/ip/sg_bram_controller/sg_bram_controller_ooc.xdc]
  read_xdc -mode out_of_context -ref sg_bram -cells U0 /home/ppan/Desktop/small_data_compression/small_data_compression.srcs/sources_1/ip/sg_bram/sg_bram_ooc.xdc
  set_property processing_order EARLY [get_files /home/ppan/Desktop/small_data_compression/small_data_compression.srcs/sources_1/ip/sg_bram/sg_bram_ooc.xdc]
  read_xdc /home/ppan/Desktop/small_data_compression/small_data_compression.srcs/constrs_1/new/system_design.xdc
  read_xdc -ref DMA -cells U0 /home/ppan/Desktop/small_data_compression/small_data_compression.srcs/sources_1/ip/DMA/DMA_clocks.xdc
  set_property processing_order LATE [get_files /home/ppan/Desktop/small_data_compression/small_data_compression.srcs/sources_1/ip/DMA/DMA_clocks.xdc]
  link_design -top system_design -part xc7vx690tffg1761-2
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design -directive Explore
  write_checkpoint -force system_design_opt.dcp
  catch {report_drc -file system_design_drc_opted.rpt}
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  place_design -directive Explore
  write_checkpoint -force system_design_placed.dcp
  catch { report_io -file system_design_io_placed.rpt }
  catch { report_clock_utilization -file system_design_clock_utilization_placed.rpt }
  catch { report_utilization -file system_design_utilization_placed.rpt -pb system_design_utilization_placed.pb }
  catch { report_control_sets -verbose -file system_design_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design -directive Explore
  write_checkpoint -force system_design_routed.dcp
  catch { report_drc -file system_design_drc_routed.rpt -pb system_design_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file system_design_timing_summary_routed.rpt -rpx system_design_timing_summary_routed.rpx }
  catch { report_power -file system_design_power_routed.rpt -pb system_design_power_summary_routed.pb }
  catch { report_route_status -file system_design_route_status.rpt -pb system_design_route_status.pb }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

