\m4_TLV_version 1d: tl-x.org
\SV

   // =========================================
   // Welcome!  Try the tutorials via the menu.
   // =========================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV adder($a, $b, $cin, $out, $carryout)
   $temp1 = $a ^ $b;
   $out = $temp1 ^ $cin;
   $temp2 = $temp1 && $cin;
   $temp3 = $a && $b;
   $carryout = $temp2 || $temp3;

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


