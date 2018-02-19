# Test file for new MARS updates by Anthony Roy
.include "dist\mpp.asm"

.data
    test_str: .asciiz "50.3"
    test_str_2: .asciiz "1.5"
    a_to_i: .asciiz "a to i: "
    a_to_f: .asciiz "a to f: "
.text
    # Test ASCII to int
    la $a0, test_str
    li $v0, 84
    syscall
    
    print_mem_str(a_to_i)

    println($v0, PRINT_INT)

    # Test ASCII to float
    la $a0, test_str_2
    li $v0, 85
    syscall

    print_mem_str(a_to_f)

    println($v0, PRINT_HEX)
    
    quit()

.include "dist\mppf.asm"
