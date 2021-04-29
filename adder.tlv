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

   
\SV
   endmodule
