/*
* MIPS++ 0.0.1
* Stanley Lim, Copyright 2017
* https://spiderpig86.github.io/MIPS-
*/
.data

    #################################
    # DEFINE CONSTANTS
    #################################
    .eqv PRINT_INT 1
    .eqv PRINT_FLOAT 2
    .eqv PRINT_DOUBLE 3
    .eqv PRINT_STR 4

    .eqv INPUT_INT 5
    .eqv INPUT_FLOAT 6
    .eqv INPUT_DOUBLE 7
    .eqv INPUT_STR 8

    .eqv END 10
    .eqv PRINT_CHAR 11

    .eqv FILE_OPEN 13
    .eqv FILE_READ 14
    .eqv FILE_WRITE 15
    .eqv FILE_CLOSE 16

    .eqv PRINT_HEX 34
    .eqv PRINT_IEEE 35
#################################
# Standard macro functions.
#################################

.data
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
    .macro print_lbl_str(%label)
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
    .macro print_lbl_word(%label)
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
    .macro print_lbl_double(%label)
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
    #   %code = what needs to be printed
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
    #   %code = what needs to be printed
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