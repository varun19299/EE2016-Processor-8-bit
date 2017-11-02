# Demo Logs

Task: Add two numbers present in R0,R1

Code: ./demo/prog.txt

Data: ./demo/data.txt

________

### Interpretation: (of 1)

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


________

### Interpretation: (of 2)

0000_0000_0000_0000 // load R0 <- Mem(R0 + 0)
0000_0010_0100_0001 // load R1 <- Mem(R1 + 1)
0000_0110_1100_0011 // load R3 <- Mem(R3 + 3)
0010_0000_0101_0000 // Add R2 <- R0 + R1
0001_0110_1000_0000 // Store Mem(R3 + 0) <- R2

Here, R1,R2, R3 are initially zero.
Mem[3] contains 2.
Mem[1], Mem[0] contains the numbers we wish to add.
Hence, Mem[2]=Mem[1]+Mem[0].
