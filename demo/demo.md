# Demo Logs

Task: Add two numbers present in R0,R1

Code: ./demo/prog.txt

Data: ./demo/data.txt

### Interpretation:

0000_0100_0000_0000 // load R0 <- Mem(R2 + 0)
0000_0100_0100_0001 // load R1 <- Mem(R2 + 1)
0010_0000_0101_0000 // Add R2 <- R0 + R1
0001_0110_1000_0000 // Store Mem(R3 + 0) <- R2

### Note:

Here , Rs correspond to registers created internally in memory. 
They are initially zeros.
Hence, R3 would have value 0. (You can change this in the initial begin of Register.v)
Expected output therefore is :
>> Mem[0]=Mem[0]+Mem[1]

which holds true.
