# Assembler for Microprocessor

# write as
# add R1 R2 R3

import sys

def assemble(command):
    l_command=command.split(' ')

    if l_command[0]=='add':
        opcode='0000'
        func='000'
        rd='{0:03b}'.format(int(l_command[1][1:]))
        ra='{0:03b}'.format(int(l_command[2][1:]))
        rb='{0:03b}'.format(int(l_command[3][1:]))
        instruction=opcode+rd+ra+rb+func

    elif l_command[0]=='sub':
        opcode='0000'
        func='001'
        rd='{0:03b}'.format(int(l_command[1][1:]))
        ra='{0:03b}'.format(int(l_command[2][1:]))
        rb='{0:03b}'.format(int(l_command[3][1:]))
        instruction=opcode+rd+ra+rb+func

    elif l_command[0]=='inv':
        opcode='0000'
        func='010'
        rd='{0:03b}'.format(int(l_command[1][1:]))
        ra='{0:03b}'.format(int(l_command[2][1:]))
        rb='{0:03b}'.format(int(l_command[3][1:]))
        instruction=opcode+rd+ra+rb+func

    elif l_command[0]=='lsl':
        opcode='0000'
        func='011'
        rd='{0:03b}'.format(int(l_command[1][1:]))
        ra='{0:03b}'.format(int(l_command[2][1:]))
        rb='{0:03b}'.format(int(l_command[3][1:]))
        instruction=opcode+rd+ra+rb+func

    elif l_command[0]=='lsr':
        opcode='0000'
        func='100'
        rd='{0:03b}'.format(int(l_command[1][1:]))
        ra='{0:03b}'.format(int(l_command[2][1:]))
        rb='{0:03b}'.format(int(l_command[3][1:]))
        instruction=opcode+rd+ra+rb+func

    elif l_command[0]=='and':
        opcode='0000'
        func='101'
        rd='{0:03b}'.format(int(l_command[1][1:]))
        ra='{0:03b}'.format(int(l_command[2][1:]))
        rb='{0:03b}'.format(int(l_command[3][1:]))
        instruction=opcode+rd+ra+rb+func

    elif l_command[0]=='or':
        opcode='0000'
        func='110'
        rd='{0:03b}'.format(int(l_command[1][1:]))
        ra='{0:03b}'.format(int(l_command[2][1:]))
        rb='{0:03b}'.format(int(l_command[3][1:]))
        instruction=opcode+rd+ra+rb+func

    elif l_command[0]=='cmp':
        opcode='0000'
        func='111'
        rd='{0:03b}'.format(int(l_command[1][1:]))
        ra='{0:03b}'.format(int(l_command[2][1:]))
        rb='{0:03b}'.format(int(l_command[3][1:]))
        instruction=opcode+rd+ra+rb+func

    elif l_command[0]=='addi':
        opcode='0100'
        imm_string='{0:06b}'.format(int(l_command[3]))
        ra='{0:03b}'.format(int(l_command[2][1:]))
        rb='{0:03b}'.format(int(l_command[1][1:]))
        imm_1=imm_string[:3] #3 from MSB
        imm_2=imm_string[3:] #3 from LSB
        instruction=opcode+imm_1+ra+rb+imm_2

    elif l_command[0]=='lw':
        opcode='1011'
        imm_string='{0:06b}'.format(int(l_command[3]))
        ra='{0:03b}'.format(int(l_command[2][1:]))
        rb='{0:03b}'.format(int(l_command[1][1:]))
        imm_1=imm_string[:3] #3 from MSB
        imm_2=imm_string[3:] #3 from LSB
        instruction=opcode+imm_1+ra+rb+imm_2

    elif l_command[0]=='sw':
        opcode='1111'
        imm_string='{0:06b}'.format(int(l_command[3]))
        ra='{0:03b}'.format(int(l_command[2][1:]))
        rb='{0:03b}'.format(int(l_command[1][1:]))
        imm_1=imm_string[:3] #3 from MSB
        imm_2=imm_string[3:] #3 from LSB
        instruction=opcode+imm_1+ra+rb+imm_2

    elif l_command[0]=='beq':
        opcode='1000'
        imm_string='{0:06b}'.format(int(l_command[3]))
        ra='{0:03b}'.format(int(l_command[2][1:]))
        rb='{0:03b}'.format(int(l_command[1][1:]))
        imm_1=imm_string[:3] #3 from MSB
        imm_2=imm_string[3:] #3 from LSB
        instruction=opcode+imm_1+ra+rb+imm_2

    elif l_command[0]=='bne':
        opcode='1001'
        imm_string='{0:06b}'.format(int(l_command[3]))
        ra='{0:03b}'.format(int(l_command[2][1:]))
        rb='{0:03b}'.format(int(l_command[1][1:]))
        imm_1=imm_string[:3] #3 from MSB
        imm_2=imm_string[3:] #3 from LSB
        instruction=opcode+imm_1+ra+rb+imm_2

    elif l_command[0]=='j':
        opcode='0010'
        addr='{0:07b}'.format(int(l_command[1]))
        instruction=opcode+'0'*5+addr

    elif l_command[0]=='mov':
        opcode='0011'
        ra='{0:03b}'.format(int(l_command[1][1:]))
        rb='{0:03b}'.format(int(l_command[2][1:]))
        instruction=opcode+ra+rb+'0'*6

    elif l_command[0]=='eop':
        opcode='0111'
        instruction=opcode+'0'*12

    return instruction


def compile(source=sys.argv[1], destination=sys.argv[2]):
    try:
      with open(source, 'r') as a , open(destination, 'w') as b:
          lines=a.read().splitlines()
          print (lines)
          for line in lines:
              try:
                  w_inst=assemble(line)
              except:
                  print (line)
              b.write(w_inst+'\n')

    except IOError as e:
      print ('Operation failed: %s' % e.strerror)

if __name__=='__main__':
    compile()
