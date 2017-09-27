# Functions called by macros

.text
    #################################
    # Gets the length of null-terminated string.
    #
    # Arguments:
    #   $a0 = (string) the string we want the length of by memory address
    #
    # Returns:
    #   $v0 = length of string
    #
    # Overrides:
    #   $t0
    #################################
    func_str_len:
        li $t0, 0 # Use as the counter

        func_str_len_loop:
            lb $t1, 0($a0) # Load char
            beqz $t1, func_str_len_loop_end # Reached null terminator
            beq $t1, 10, func_str_len_loop_end # Reached \n for strings entered in memory with syscall 5

            addi $a0, $a0, 1 # Shift the string
            addi $t0, $t0, 1 # Increment the counter

            j func_str_len_loop
        func_str_len_loop_end:

        # Return the value
        move $v0, $t0
        jr $ra
