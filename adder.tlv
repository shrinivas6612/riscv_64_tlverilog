
\TLV adder($a, $b, $cin, $out, $carryout)
   $temp1 = $a ^ $b;
   $out = $temp1 ^ $cin;
   $temp2 = $temp1 && $cin;
   $temp3 = $a && $b;
   $carryout = $temp2 || $temp3;

