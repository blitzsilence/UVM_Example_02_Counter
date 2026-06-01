module counter(
    input clk,
    input rst_n,
    input cnt_en,
    output reg [7:0] cnt_out
);
    always @(posedge clk or negedge rst_n)
    begin
        if(~rst_n) begin
            cnt_out <= 8'b0;
        end
        else if(cnt_en) begin
            if(cnt_out != 10) begin
		        cnt_out <= cnt_out + 1'b1;
            end
            else begin
                cnt_out <=8'b0;
            end
        end
        else begin
            cnt_out <= 8'b0;
        end
    end
endmodule
