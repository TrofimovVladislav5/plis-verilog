module test;
    reg clk;
    reg D;
    wire Q, Qn;

    d_trigger uut (
        .clk(clk), 
        .D(D), 
        .Q(Q), 
        .Qn(Qn)
    );
    always #10 clk = ~clk;

    initial begin
        clk = 0;
        D = 0;
        
        $display("=== Starting D Trigger Tests ===");
        $display("Time\tCLK\tD\tQ\tQn");
        $display("----------------------------");
        print_status(); // Начальное состояние
        
        // Test sequence с выводами в ключевые моменты
        #15 D = 1;  print_status(); // Перед фронтом
        #5;         print_status(); // После фронта (захват)
        #15 D = 0;  print_status(); // После фронта
        #5;         print_status(); // Следующий фронт
        #5 D = 1;   print_status(); // Перед фронтом
        #5;         print_status(); // После фронта
        #5 D = 0;   print_status(); // Быстрое изменение
        #5;         print_status(); // После фронта
        #10 D = 1;  print_status(); // Стабильная 1
        #20;        print_status(); // После нескольких тактов
        #5 D = 0;   print_status(); // Стабильная 0
        #25;        print_status(); // Финальное состояние
        
        $display("=== Tests Completed ===");
    end
    
    task print_status;
        begin
            $display("%0t\t%b\t%b\t%b\t%b", $time, clk, D, Q, Qn);
        end
    endtask
endmodule