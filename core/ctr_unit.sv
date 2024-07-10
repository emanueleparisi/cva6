// Copyright 2024 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Author: Emanuele Parisi, University of Bologna
// Description: Control Transfer Records unit.


module ctr_unit
  import ariane_pkg::*;
#(
    parameter config_pkg::cva6_cfg_t CVA6Cfg = config_pkg::cva6_cfg_empty
) (
    // Subsystem clock - SUBSYSTEM
    input logic clk_i,
    // Asynchronous reset active low - SUBSYSTEM
    input logic rstn_i,
    // - COMMIT_STAGE
    input riscv::xlen_t [CVA6Cfg.NrCommitPorts-1:0] ctr_source_i,
    // - COMMIT_STAGE
    input riscv::ctr_type_t [CVA6Cfg.NrCommitPorts-1:0] ctr_type_i,
    // - COMMIT_STAGE
    input logic [CVA6Cfg.NrCommitPorts-1:0] ctr_valid_i
);

  riscv::ctrsource_rv_t [CVA6Cfg.NrCommitPorts-1:0] emitter_source;
  riscv::ctrtarget_rv_t [CVA6Cfg.NrCommitPorts-1:0] emitter_target;
  riscv::ctrdata_rv_t [CVA6Cfg.NrCommitPorts-1:0] emitter_data;

  ctr_emitter #(
      .CVA6Cfg(CVA6Cfg)
  ) i_ctr_emitter (
      .clk_i    (clk_i),
      .rstn_i   (rstn_i),
      .source_i (ctr_source_i),
      .type_i   (ctr_type_i),
      .valid_i  (ctr_valid_i),
      .source_o (emitter_source),
      .target_o (emitter_target),
      .data_o   (emitter_data)
  );

endmodule
