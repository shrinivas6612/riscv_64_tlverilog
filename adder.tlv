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
      logic [31:0] instr[0:31];
      assign instr[0] = 32'b0;
      assign instr[1] = 32'ha004e;//addi R1,R0,10
      assign instr[2] = 32'h14008e;//ADDI R2,R0,20
      assign instr[3] = 32'h1900ce;//ADDI R3,R0,25
      assign instr[4] = 32'h23010e;//ADDI R4,R0,35
      assign instr[5] = 32'h7014e;//ADDI R5,R0,7
      assign instr[6] = 32'h4282099f;//ADD R6,R1,R2
      assign instr[7] = 32'h428331df;//ADD R7,R6,R3
      assign instr[8] = 32'h42843a1f;//ADD R8,R7,R4
      assign instr[9] = 32'h4285425f;//ADD R9,R8, R5
   $inst = instr[$pc];

\TLV rf(_entries, _width, $_reset, $port1_en, $port1_index, $port1_data, $port2_en, $port2_index, $port2_data, $port3_en, $port3_index, $port3_data)
   $rf1_wr_en = $port1_en;
   $rf1_wr_index[\$clog2(_entries)-1:0]  = $port1_index;
   $rf1_wr_data[_width-1:0] = $port1_data;
   
   $rf1_rd_en1 = $port2_en;
   $rf1_rd_index1[\$clog2(_entries)-1:0] = $port2_index;
   
   $rf1_rd_en2 = $port3_en;
   $rf1_rd_index2[\$clog2(_entries)-1:0] = $port3_index;
   
   /xreg[m4_eval(_entries-1):0]
      $wr = /top$rf1_wr_en && (/top$rf1_wr_index == #xreg);
      <<1$value[_width-1:0] = /top$_reset ? #xreg :
                                 $wr      ? /top$rf1_wr_data :
                                            $RETAIN;
   
   $port2_data[_width-1:0]  =  $rf1_rd_en1 ? /xreg[$rf1_rd_index1]$value : 'X;
   $port3_data[_width-1:0]  =  $rf1_rd_en2 ? /xreg[$rf1_rd_index2]$value : 'X;

\TLV dmem(_entries, _width, $reset, $addr, $port1_en, $port1_data, $port2_en, $port2_data)
   // Allow expressions for most inputs, so define input signals.
   $dmem1_wr_en = $port1_en;
   $dmem1_addr[\$clog2(_entries)-1:0] = $addr;
   $dmem1_wr_data[_width-1:0] = $port1_data;
   
   $dmem1_rd_en = $port2_en;
   
   /dmem[m4_eval(_entries-1):0]
      $wr = /top$dmem1_wr_en && (/top$dmem1_addr == #dmem);
      <<1$value[_width-1:0] = /top$reset ? 0 :
                              $wr         ? /top$dmem1_wr_data :
                                            $RETAIN;
   
   $port2_data[_width-1:0] = $dmem1_rd_en ? /dmem[$dmem1_addr]$value : 'X;
