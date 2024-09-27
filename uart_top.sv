module uart_top #(
	parameter CLK_FRE 		= 25,
	parameter UART_RATE 	= 115200,
	parameter SEND_FRE 		= 1
	)(
	input 		clk,    // 
	
	input [31:0] io_data, //�?要发送的IO编号

	output		uart_tx
);

enum {SEND,WAIT}STATE_LOOP;
reg [1:0] state;

reg  [31:0] wait_cnt;
reg  [ 7:0] send_cnt;
reg  [ 7:0] send_data;
reg  	    send_en;


//发�?�寄存器
parameter 	ENG_NUM  = 4;//非中文字符数
parameter 	DATA_NUM = ENG_NUM + 1; 
wire [ DATA_NUM * 8 - 1:0] char_data = {io_data,"\n"};
	
//仲裁机制
always@(posedge clk)
	case(state)
		SEND:begin // 主动发�??
			if(send_cnt == DATA_NUM + 1)begin 
				send_en 	<= 'b0;
				send_cnt 	<=  0;
				state 		<= WAIT;
			end
			else if(!send_busy)begin
				send_en 	<= 'b1;
				send_data 	<= char_data[ (DATA_NUM - 1 - send_cnt) * 8 +: 8];
				send_cnt 	<= send_cnt + 1;
			end
		end

		WAIT:// 回环测试发�??
			if(wait_cnt == CLK_FRE * 1000_000 / SEND_FRE)begin 
				wait_cnt <= 0;
				state <= SEND;
			end
			else begin
				wait_cnt <= wait_cnt + 1;
			end
	endcase

//发�?�模�?
uart_tx #(
	.CLK_FRE 	(CLK_FRE 	),
	.UART_RATE 	(UART_RATE 	)
	)uart_tx_m0(
	.clk 		(clk 		),

	.send_en 	(send_en 	),
	.send_busy 	(send_busy 	),
	.send_data 	(send_data 	),

	.tx_pin 	(uart_tx 	)
	);

// ila_0 ila_0_m0(
//     .clk        (clk       		),

//     .probe0     (send_en        ),
// 	.probe1     (uart_tx      	),
// 	.probe2     (send_data      )
// );

endmodule