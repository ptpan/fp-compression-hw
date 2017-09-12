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

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param gui.test TreeTableDev
  debug::add_scope template.lib 1
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.cache/wt [current_project]
  set_property parent.project_path /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.xpr [current_project]
  set_property ip_repo_paths {
  /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.cache/ip
  /home/ppan/DUT/small_data_compression
  /home/ppan/Desktop/small_data_compression/small_data_compression.srcs
} [current_project]
  set_property ip_output_repo /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.cache/ip [current_project]
  add_files -quiet /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.runs/synth_1/xt_connectivity_trd.dcp
  add_files -quiet /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.runs/dma_back_end_axi_synth_1/dma_back_end_axi.dcp
  set_property netlist_only true [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.runs/dma_back_end_axi_synth_1/dma_back_end_axi.dcp]
  add_files -quiet /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.runs/fp_adder_synth_1/fp_adder.dcp
  set_property netlist_only true [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.runs/fp_adder_synth_1/fp_adder.dcp]
  add_files -quiet /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.runs/fp_div_synth_1/fp_div.dcp
  set_property netlist_only true [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.runs/fp_div_synth_1/fp_div.dcp]
  add_files -quiet /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.runs/fp2fixed_synth_1/fp2fixed.dcp
  set_property netlist_only true [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.runs/fp2fixed_synth_1/fp2fixed.dcp]
  add_files -quiet /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.runs/compression_synth_1/compression.dcp
  set_property netlist_only true [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.runs/compression_synth_1/compression.dcp]
  read_xdc -ref pcie3_x8_ip -cells inst /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/pcie3_x8_ip/source/pcie3_x8_ip-PCIE_X0Y1.xdc
  set_property processing_order EARLY [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/pcie3_x8_ip/source/pcie3_x8_ip-PCIE_X0Y1.xdc]
  read_xdc -ref axis_async_fifo -cells U0 /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/axis_async_fifo/axis_async_fifo/axis_async_fifo.xdc
  set_property processing_order EARLY [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/axis_async_fifo/axis_async_fifo/axis_async_fifo.xdc]
  read_xdc -ref cmd_fifo_xgemac_rxif -cells U0 /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/cmd_fifo_xgemac_rxif/cmd_fifo_xgemac_rxif/cmd_fifo_xgemac_rxif.xdc
  set_property processing_order EARLY [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/cmd_fifo_xgemac_rxif/cmd_fifo_xgemac_rxif/cmd_fifo_xgemac_rxif.xdc]
  read_xdc -ref ten_gig_eth_mac_axi_st_ip -cells inst /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/ten_gig_eth_mac_axi_st_ip/synth/ten_gig_eth_mac_axi_st_ip.xdc
  set_property processing_order EARLY [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/ten_gig_eth_mac_axi_st_ip/synth/ten_gig_eth_mac_axi_st_ip.xdc]
  read_xdc -ref ten_gig_eth_pcs_pma_ip -cells inst /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/ten_gig_eth_pcs_pma_ip/synth/ten_gig_eth_pcs_pma_ip.xdc
  set_property processing_order EARLY [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/ten_gig_eth_pcs_pma_ip/synth/ten_gig_eth_pcs_pma_ip.xdc]
  read_xdc -ref ten_gig_eth_pcs_pma_ip_shared_logic_in_core -cells inst /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/ten_gig_eth_pcs_pma_ip_shared_logic_in_core/synth/ten_gig_eth_pcs_pma_ip_shared_logic_in_core.xdc
  set_property processing_order EARLY [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/ten_gig_eth_pcs_pma_ip_shared_logic_in_core/synth/ten_gig_eth_pcs_pma_ip_shared_logic_in_core.xdc]
  read_xdc -mode out_of_context -ref fp_adder -cells U0 /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.srcs/sources_1/ip/fp_adder/fp_adder_ooc.xdc
  set_property processing_order EARLY [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.srcs/sources_1/ip/fp_adder/fp_adder_ooc.xdc]
  read_xdc -mode out_of_context -ref fp_div -cells U0 /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.srcs/sources_1/ip/fp_div/fp_div_ooc.xdc
  set_property processing_order EARLY [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.srcs/sources_1/ip/fp_div/fp_div_ooc.xdc]
  read_xdc -mode out_of_context -ref fp2fixed -cells U0 /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.srcs/sources_1/ip/fp2fixed/fp2fixed_ooc.xdc
  set_property processing_order EARLY [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.srcs/sources_1/ip/fp2fixed/fp2fixed_ooc.xdc]
  read_xdc -ref DMA -cells U0 /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.srcs/sources_1/ip/compression_4/sources_1/ip/DMA/DMA.xdc
  set_property processing_order EARLY [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.srcs/sources_1/ip/compression_4/sources_1/ip/DMA/DMA.xdc]
  read_xdc /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/constraints/v7_xt_xgemac_xphy.xdc
  read_xdc /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/constraints/v7_xt_conn_trd_noddr3.xdc
  read_xdc /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/constraints/v7_xt_conn_bit_rev1_0.xdc
  read_xdc -mode out_of_context -ref dma_back_end_axi /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/constraints/dma_back_end_axi_ooc.xdc
  read_xdc -ref axis_async_fifo -cells U0 /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/axis_async_fifo/axis_async_fifo/axis_async_fifo_clocks.xdc
  set_property processing_order LATE [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/axis_async_fifo/axis_async_fifo/axis_async_fifo_clocks.xdc]
  read_xdc -ref axis_ic_wr -cells inst /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/axis_ic_wr/axis_ic_wr_clocks.xdc
  set_property processing_order LATE [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/axis_ic_wr/axis_ic_wr_clocks.xdc]
  read_xdc -ref axis_ic_rd -cells inst /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/axis_ic_rd/axis_ic_rd_clocks.xdc
  set_property processing_order LATE [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/axis_ic_rd/axis_ic_rd_clocks.xdc]
  read_xdc -ref ten_gig_eth_mac_axi_st_ip -cells inst /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/ten_gig_eth_mac_axi_st_ip/synth/ten_gig_eth_mac_axi_st_ip_clocks.xdc
  set_property processing_order LATE [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/ten_gig_eth_mac_axi_st_ip/synth/ten_gig_eth_mac_axi_st_ip_clocks.xdc]
  read_xdc -ref ten_gig_eth_pcs_pma_ip -cells inst /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/ten_gig_eth_pcs_pma_ip/synth/ten_gig_eth_pcs_pma_ip_clocks.xdc
  set_property processing_order LATE [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/ten_gig_eth_pcs_pma_ip/synth/ten_gig_eth_pcs_pma_ip_clocks.xdc]
  read_xdc -ref ten_gig_eth_pcs_pma_ip_shared_logic_in_core -cells inst /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/ten_gig_eth_pcs_pma_ip_shared_logic_in_core/synth/ten_gig_eth_pcs_pma_ip_shared_logic_in_core_clocks.xdc
  set_property processing_order LATE [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/ip_catalog/ten_gig_eth_pcs_pma_ip_shared_logic_in_core/synth/ten_gig_eth_pcs_pma_ip_shared_logic_in_core_clocks.xdc]
  read_xdc -ref DMA -cells U0 /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.srcs/sources_1/ip/compression_4/sources_1/ip/DMA/DMA_clocks.xdc
  set_property processing_order LATE [get_files /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.srcs/sources_1/ip/compression_4/sources_1/ip/DMA/DMA_clocks.xdc]
  link_design -top xt_connectivity_trd -part xc7vx690tffg1761-2
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
  write_checkpoint -force xt_connectivity_trd_opt.dcp
  catch {report_drc -file xt_connectivity_trd_drc_opted.rpt}
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
  write_checkpoint -force xt_connectivity_trd_placed.dcp
  catch { report_io -file xt_connectivity_trd_io_placed.rpt }
  catch { report_clock_utilization -file xt_connectivity_trd_clock_utilization_placed.rpt }
  catch { report_utilization -file xt_connectivity_trd_utilization_placed.rpt -pb xt_connectivity_trd_utilization_placed.pb }
  catch { report_control_sets -verbose -file xt_connectivity_trd_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step phys_opt_design
set rc [catch {
  create_msg_db phys_opt_design.pb
  phys_opt_design -directive AggressiveExplore
  write_checkpoint -force xt_connectivity_trd_physopt.dcp
  close_msg_db -file phys_opt_design.pb
} RESULT]
if {$rc} {
  step_failed phys_opt_design
  return -code error $RESULT
} else {
  end_step phys_opt_design
}

  set_msg_config -id {Route 35-39} -severity "critical warning" -new_severity warning
start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design -directive Explore -tns_cleanup
  write_checkpoint -force xt_connectivity_trd_routed.dcp
  catch { report_drc -file xt_connectivity_trd_drc_routed.rpt -pb xt_connectivity_trd_drc_routed.pb }
  catch { report_timing_summary -max_paths 10 -file xt_connectivity_trd_timing_summary_routed.rpt -rpx xt_connectivity_trd_timing_summary_routed.rpx }
  catch { report_power -file xt_connectivity_trd_power_routed.rpt -pb xt_connectivity_trd_power_summary_routed.pb }
  catch { report_route_status -file xt_connectivity_trd_route_status.rpt -pb xt_connectivity_trd_route_status.pb }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step post_route_phys_opt_design
set rc [catch {
  create_msg_db post_route_phys_opt_design.pb
  phys_opt_design -directive AggressiveExplore
  write_checkpoint -force xt_connectivity_trd_postroute_physopt.dcp
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file xt_connectivity_trd_timing_summary_postroute_physopted.rpt -rpx xt_connectivity_trd_timing_summary_postroute_physopted.rpx }
  close_msg_db -file post_route_phys_opt_design.pb
} RESULT]
if {$rc} {
  step_failed post_route_phys_opt_design
  return -code error $RESULT
} else {
  end_step post_route_phys_opt_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  write_bitstream -force xt_connectivity_trd.bit 
  if { [file exists /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.runs/synth_1/xt_connectivity_trd.hwdef] } {
    catch { write_sysdef -hwdef /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.runs/synth_1/xt_connectivity_trd.hwdef -bitfile xt_connectivity_trd.bit -meminfo xt_connectivity_trd.mmi -file xt_connectivity_trd.sysdef }
  }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

