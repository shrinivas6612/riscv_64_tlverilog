\m4_TLV_version 1d: tl-x.org
\SV
    m4_include_lib(['https://raw.githubusercontent.com/stevehoover/warp-v_includes/1d1023ccf8e7b0a8cf8e8fc4f0a823ebb61008e3/risc-v_defs.tlv'])
   // =========================================
   // Welcome!  Try the tutorials via the menu.
   // =========================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV inst($pc, $inst)
   \SV_plus
      logic [31:0] instr[0:32];
      assign instr[0] = 32'h00a00093;//addi R1,R0,10
      assign instr[1] = 32'h01400113;//ADDI R2,R0,20
      assign instr[2] = 32'h01900193;//ADDI R3,R0,25
      assign instr[3] = 32'h02300213;//ADDI R4,R0,35
      assign instr[4] = 32'h00700293;//ADDI R5,R0,7
      assign instr[5] = 32'h00208333;//ADD R6,R1,R2
      assign instr[6] = 32'h003303b3;//ADD R7,R6,R3
      assign instr[7] = 32'h00438433;//ADD R8,R7,R4
      assign instr[8] = 32'h005404B3;//ADD R9,R8,R5
   $inst = instr[$pc];

\TLV rf(_entries, _width, $_reset, $_port1_en, $_port1_index, $_port1_data, $_port2_en, $_port2_index, $_port2_data, $_port3_en, $_port3_index, $_port3_data)
   $rf1_wr_en = m4_argn(4, $@);
   $rf1_wr_index[\$clog2(_entries)-1:0]  = m4_argn(5, $@);
   $rf1_wr_data[_width-1:0] = m4_argn(6, $@);
   
   $rf1_rd_en1 = m4_argn(7, $@);
   $rf1_rd_index1[\$clog2(_entries)-1:0] = m4_argn(8, $@);
   
   $rf1_rd_en2 = m4_argn(10, $@);
   $rf1_rd_index2[\$clog2(_entries)-1:0] = m4_argn(11, $@);
   
   /xreg[m4_eval(_entries-1):0]
      $wr = /top$rf1_wr_en && (/top$rf1_wr_index == #xreg);
      <<1$value[_width-1:0] = /top$_reset ? #xreg              :
                                 $wr      ? /top$rf1_wr_data :
                                            $RETAIN;
   
   $_port2_data[_width-1:0]  =  $rf1_rd_en1 ? /xreg[$rf1_rd_index1]$value : 'X;
   $_port3_data[_width-1:0]  =  $rf1_rd_en2 ? /xreg[$rf1_rd_index2]$value : 'X;
