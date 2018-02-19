#################################
# Standard macro functions.
# All used registers are saved and restored automatically.
#################################

# Data section carried over
    log_msg: .asciiz "Console log - "
    new_line: .asciiz "\n"

    #################################
    # Logs parameter in console.
    # Type: Void
    # Arguments:
    #   %s = string to log
    #################################
    .macro log(%s)
        addi $sp, $sp, -8
        sw $a0, ($sp)
        sw $v0, 4($sp)

        la $a0, log_msg
        li $v0, PRINT_STR
        syscall

        li $a0, %s
        syscall

        lw $a0, ($sp)
        lw $v0, 4($sp)
        addi $sp, $sp, 8
    .end_macro

    #################################
    # Ends program
    # Type: Void
    #################################
    .macro quit
        li $v0, END
        syscall
    .end_macro

    #################################
    # Prints string at %label
    # Type: Void
    # Arguments:
    #   %label = label in data section
    #################################
    .macro print_mem_str(%label)
        addi $sp, $sp, -8
        sw $a0, ($sp)
        sw $v0, 4($sp)

        la $a0, %label
        li $v0, PRINT_STR
        syscall

        lw $a0, ($sp)
        lw $v0, 4($sp)
        addi $sp, $sp, 8
    .end_macro

    #################################
    # Prints int at %label
    # Type: Void
    # Arguments:
    #   %label = label in data section
    #################################
    .macro print_mem_word(%label)
        addi $sp, $sp, -8
        sw $a0, ($sp)
        sw $v0, 4($sp)

        lw $a0, %label
        li $v0, PRINT_INT
        syscall

        lw $a0, ($sp)
        lw $v0, 4($sp)
        addi $sp, $sp, 8
    .end_macro

    #################################
    # Prints int at %label
    # Type: Void
    # Arguments:
    #   %label = label in data section
    #################################
    .macro print_mem_double(%label)
        addi $sp, $sp, -12
        sw $f0, ($sp)
        sw $f1, 4($sp)
        sw $v0, 8($sp)

        ldc1 $f0, %label
        add.d $f12, $f2, $0
        syscall

        sw $f0, ($sp)
        sw $f1, 4($sp)
        sw $v0, 8($sp)
        addi $sp, $sp, 12
    .end_macro

    #################################
    # Prints chars, strings, floats, integers, octal and hex values based on code given.
    # Type: Void
    # Arguments:
    #   %reg = register with content
    #   %code = code for associated data-type
    #################################
    .macro printf(%reg, %code)
        addi $sp, $sp, -8
        sw $a0, ($sp)
        sw $v0, 4($sp)

        move $a0, %reg
        li $v0, %code
        syscall

        lw $a0, ($sp)
        lw $v0, 4($sp)
        addi $sp, $sp, 8
    .end_macro

    #################################
    # Prints chars, strings, floats, integers, octal and hex values based on code given with a new line terminator
    # Type: Void
    # Arguments:
    #   %reg = register with content
    #   %code = print code for associated data-type
    #################################
    .macro println(%reg, %code)
        addi $sp, $sp, -8
        sw $a0, ($sp)
        sw $v0, 4($sp)

        move $a0, %reg
        li $v0, %code
        syscall

        la $a0, new_line
        li $v0, PRINT_STR
        syscall

        lw $a0, ($sp)
        lw $v0, 4($sp)
        addi $sp, $sp, 8
    .end_macro

    #################################
    # Push register value onto the stack.
    # Type: Void
    # Arguments:
    #   %reg = register
    #################################
    .macro push(%reg)
        addi $sp, $sp, -4
        sw %reg, ($sp)
    .end_macro

    #################################
    # Pops register value onto the stack.
    # Type: Void
    # Arguments:
    #   %reg = register
    #################################
    .macro pop(%reg)
        lw %reg, ($sp)
        addi $sp, $sp, 4
    .end_macro

    #################################
    # Gets length of string
    # Type: int
    # Arguments:
    #   %str = string address from register
    # Returns:
    #   $v0 = length of string
    # @requires mppf.asm
    #################################
    .macro str_len(%str)
        addi $sp, $sp, -8
        sw $a0, ($sp) # Overrided by function
        sw $t0, 4($sp)

        move $a0, %str
        jal func_str_len

        lw $a0, ($sp)
        lw $t0, 4($sp)
        addi $sp, $sp, 8
    .end_macro

    #################################
    # Gets length of string from memory
    # Type: int
    # Arguments:
    #   %str = string from memory
    # Returns:
    #   $v0 = length of string
    # @requires mppf.asm
    #################################
    .macro str_len_mem(%str)
        addi $sp, $sp, -8
        sw $a0, ($sp) # Overrided by function
        sw $t0, 4($sp)

        la $a0, %str
        jal func_str_len

        lw $a0, ($sp)
        lw $t0, 4($sp)
        addi $sp, $sp, 8
    .end_macro

    #################################
    # Calls function while preserving $ra
    # Type: void
    # Arguments:
    #   %func = label to function
    #################################
    .macro call(%func)
        addi $sp, $sp, -4 # Allocate space to store $ra
        sw $ra, 0($sp)
        jal %func

        lw $ra, 0($sp)
        addi $sp, $sp, 4
    .end_macro