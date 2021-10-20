          .data
ask:     .asciiz "Enter an integer : "

res:     .asciiz "You have entered "
numb:    .asciiz " numbers.\n"
min:     .asciiz "Minimal number = "
max:     .asciiz "Maximal number = "
bye:     .asciiz "Press enter to exit..."
sorted:  .asciiz "Sorted:\n"
primes:  .asciiz "primes are :\n"
ac:  .asciiz "aculmulated sums of two digits numbers is:\n"
 my_massege: .asciiz "\n ahamd hamdan droobi \n 11714797 "
nl:      .asciiz "\n"
array:   .word 0                # the array starts here
prime:   .word 0                # the array starts here  
   
     .text
         .globl __start

__start:  la $s0, array         # set $s0 to point array[0]
          
          li $s1, 0   
          
          addi $t4,$t4,0          # $s1 = 0 (for counting the array elements)
          addi $t5,$t5,12
          addi $t6,$t6,0
    
            
loop1:    li $v0, 4
          la $a0, ask
          syscall               # Ask for a number
          li $v0, 5
          syscall  
          blez $v0 ,loop1             # Read an integer in $v0
          addi $t4,$t4,1
     acum: bleu $v0,99 ,TwoDig
     
     
     
     ab :   beq $t4, $t5, loop22    # if $v0 = endmark then exit loop
            sw $v0, 0($s0)        # store $v0 into the current element of the array
          addi $s0, $s0, 4      # move to the next element
          addi $s1, $s1, 1
           move $t8,$v0
         # b isprime      # increment the counter
          b loop1
          
        TwoDig : bleu $v0,9,ab  
        add $t6 ,$t6,$v0    
         beq $t4, $t5, loop22    # if $v0 = endmark then exit loop
          sw $v0, 0($s0)        # store $v0 into the current element of the array
          addi $s0, $s0, 4      # move to the next element
          addi $s1, $s1, 1   
        
           j loop1
   
  

  
   
   
   
          
          exit:    li $v0, 4
         la $a0, res            # Print "You have entered "
         syscall

         add $a0, $0, $s1
         li $v0, 1
         syscall                # Print the number of elements entered

         li $v0, 4
         la $a0, numb           # Print " numbers.\n"
         syscall

                # initialize max ($t1) to array[0]

loop2:   lw $t3, 0($s0)         # $t3 = current element

         bge $t3, $t0, notmin   # skip if current element >= min
         add $t0, $0, $t3       # update min ($t0)

notmin:  ble $t3, $t1, notmax   # skip if current element <= max
         add $t1, $0, $t3       # update max ($t1)

notmax:  add $s0, $s0, 4        # move to the next element
         addi $s1, $s1, -1      # decrement element counter
         bne $s1, $0, loop2

        
       
          
       #########################   
loop22:  la $s0, array           # set $s0 to point to array[0]
        add $s2, $0, $s1        # $s2 = $s1 (the number of elements)
        add $s2, $s2, -1        # number of swaps = number of elements - 1
        add $t3, $0, $0         # number of swaps ($t3) = 0

loop3:  lw $t0, 0($s0)          # $t0 = current element
        lw $t1, 4($s0)         # $t1 = next element
        slt $t2, $t1, $t0       # if $t1 < $t0 then $t2 = 1
        beq $t2, $0, skip       # if $t2 = 0 the go to skip

        sw $t0, 4($s0)          # swap the current element and
        sw $t1, 0($s0)          # the next element
        addi $t3, $t3, 1        # increment $t3 (number of swaps)

skip:   add $s0, $s0, 4         # move to the next element
        addi $s2, $s2, -1       # decrement the element counter
        bgt $s2, $0, loop3      # if $s2 > 0 then go to loop3

        bne $t3, $0, loop22     # if number of swaps > 0 then go to loop2

# Print the sorted array

         li $v0, 4
         la $a0, sorted         # Print "Sorted: "
         syscall
         la $s0, array
loop4:   lw $a0, 0($s0)
         li $v0, 1
         syscall
         li $v0, 4
         la $a0, nl
         syscall
         add $s0, $s0, 4
         addi $s1, $s1, -1
         bne $s1, $0, loop4
         
          la $s0, array          # set $s0 to point to array[0]
         lw $t0, 0($s0)         # initialize min ($t0) to array[0]
         lw $t1, 40($s0) 
        
         
          li $v0, 4
         la $a0, bye            # Print the end message
         syscall
                  
                  
                   li $v0, 4
         la $a0, min            # Print "Minimal number = "
         syscall

         add $a0, $0, $t0
         li $v0, 1              # Print the value of min
         syscall

         li $v0, 4
         la $a0, nl
         syscall
 

         li $v0, 4
         la $a0, max            # Print "Maximal number = "
         syscall

         add $a0, $0, $t1
         li $v0, 1              # Print the value of max
         syscall

         li $v0, 4
         la $a0, nl
         syscall

         
                       # wait for Enter

       
           li $v0,4
        la $a0,my_massege
        syscall
          
         
         li $v0, 4
         la $a0, nl
         syscall
 
          
         li $v0, 4
         la $a0, ac            # Print "acomulated sum number = "
         syscall

         add $a0, $0, $t6
         li $v0, 1              # Print the value of acumulated sum
         syscall



         li $v0, 4
         la $a0, primes         # Print "Sorted: "
         syscall
         la $s0, array
         li $s1,12   
       
          
loop5:   lw $a0, 0($s0)
       #  move $t8,$a0
         addi $t9,$0 ,2 
         b isprime
cc:   add $s0, $s0, 4
         addi $s1, $s1, -1
         bne $s1, $0, loop5



isprime :
beq $t9 ,$a0 ,printprime
div $a0,$t9 
mfhi $10
beq $10 ,$0, cc
addi $t9,$t9 ,1
b isprime

printprime :
  li $v0, 1
         syscall
         li $v0, 4
         la $a0, nl
         syscall
b cc