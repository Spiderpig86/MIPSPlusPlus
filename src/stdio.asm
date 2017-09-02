#################################
# Standard macro functions.
# All used registers are saved and restored automatically.
#################################

# Data section carried over
    log_msg .asciiz "Console log - "

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
        li $v0, PRINT_STRING
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
        li $v0, PRINT_STRING
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

        move $a0, %src
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

        move $a0, %src
        li $v0, %code
        syscall

        li $a0, 11
        li $v0, PRINT_STRING
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
    .macro push(%reg)
        lw %reg, ($sp)
        addi $sp, $sp, 4
    .end_macro