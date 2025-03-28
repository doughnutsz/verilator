// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2023 by Antmicro Ltd.
// SPDX-License-Identifier: CC0-1.0

`define stop $stop
`define checkh(gotv,expv) do if ((gotv) !== (expv)) begin $write("%%Error: %s:%0d:  got='h%x exp='h%x\n", `__FILE__,`__LINE__, (gotv), (expv)); `stop; end while(0);

class MyInt;
   int x;
   function new(int a);
      x = a;
   endfunction
endclass

function int get_val_set_5(ref int x);
   automatic int y = x;
   x = 5;
   return y;
endfunction

module t (/*AUTOARG*/);
   int b;
   int arr[1];
   MyInt mi;

   task update_inout(inout int flag, input bit upflag);
      flag = upflag ? 1 + flag : flag;
   endtask
   task update_ref(ref int flag, input bit upflag);
      flag = upflag ? 1 + flag : flag;
   endtask

   int my_flag;

   initial begin
      mi = new(1);
      b = get_val_set_5(mi.x);
      `checkh(mi.x, 5);
      `checkh(b, 1);

      arr[0] = 10;
      b = get_val_set_5(arr[0]);
      `checkh(arr[0], 5);
      `checkh(b, 10);

      update_ref(my_flag, 1);
      if (my_flag !== 1) $stop;
      update_ref(my_flag, 0);
      if (my_flag !== 1) $stop;
      update_inout(my_flag, 1);
      if (my_flag !== 2) $stop;
      update_inout(my_flag, 0);
      if (my_flag !== 2) $stop;

      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule
