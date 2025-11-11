module test;
    reg clk;
    reg D;
    reg rst;
    wire Q, Qn;

    d_trigger uut (
        .clk(clk), 
        .rst(rst),
        .D(D), 
        .Q(Q), 
        .Qn(Qn)
    );
    always #10 clk = ~clk;

    initial begin
        clk = 0;
        D = 0;
        rst = 1;    // Изначально сброс неактивен
        
        $display("=== Starting D Trigger Tests with Async Reset ===");
        $display("Time\tCLK\tRST\tD\tQ\tQn");
        $display("----------------------------------------");
        print_status(); // Начальное состояние
        
        // Test sequence с асинхронным сбросом
        #15 D = 1;  print_status(); // Перед фронтом
        #5;         print_status(); // После фронта (захват D=1)
        
        // Тест асинхронного сброса
        #5 rst = 0; print_status(); // АКТИВИРУЕМ СБРОС - Q должен сразу стать 0
        #5 D = 0;   print_status(); // Меняем D во время сброса
        #5 rst = 1; print_status(); // Отключаем сброс
        #5 D = 1;   print_status(); // Готовим новые данные
        
        // Продолжаем нормальную работу
        #5;         print_status(); // После фронта (захват D=1)
        #5 D = 0;   print_status(); // Быстрое изменение
        #5;         print_status(); // После фронта (захват D=0)
        
        // Еще один тест асинхронного сброса
        #5 rst = 0; print_status(); // Сброс во время стабильной работы
        #10 D = 1;  print_status(); // Меняем D - не должно влиять
        #5 rst = 1; print_status(); // Отключаем сброс
        #10;        print_status(); // Ждем фронт (должен захватить D=1)
        
        #10 D = 0;  print_status(); // Финальное изменение
        #15;        print_status(); // Финальное состояние
        
        $display("=== Tests Completed ===");
    end
    
    task print_status;
        begin
             $display("%0t\t%b\t%b\t%b\t%b\t%b", $time, clk, rst, D, Q, Qn);
        end
    endtask
endmodule