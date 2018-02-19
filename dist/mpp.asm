#
# MIPS++ 0.0.1
# Stanley Lim, Copyright 2017
# https://spiderpig86.github.io/MIPSPlusPlus
#
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
    # BOUND VALUES
    #################################
    MAX_WORD: .word 0xf0000000
    MIN_WORD: .word 0x0fffffff
#################################
# File IO Macros
# Contains helpful macros.
#################################

# Data section carried over
    #################################
    # Open the file in the OS so it can be accessed (reading/writing)
    # Type: int
    # Arguments:
    #   %s = name of file we want to open
    #   %mode = mode for opening the file (read only, read/write, etc) Default 0
    #   %buffer = the space or input buffer we want to load the file contents to
    #   %max_chars = the maximum number of characters to read
    #################################
    .macro read_file(%s, %flags, %mode, %buffer, %max_chars)
        addi $sp, $sp, -12
        sw $a0, 0($sp)
        sw $a1, 4($sp)
        sw $a2, 8($sp)

        la $a0, %s # Load the file name
        li $a1, 0 # Flag 0 for reading
        move $a2, %mode # Copy the file open mode
        li $v0, 13 
        syscall # File descripter now $v0

        # Read the file
        move $a0, $v0 # Get the file descripter
        la $a1, %buffer
        move $a2, %max_chars
        li $v0, 14
        syscall

        # $v0 will store the number of chars we read.

        lw $a0, 0($sp)
        lw $a1, 4($sp)
        lw $a2, 8($sp)
        addi $sp, $sp, 12
    .end_macro

    #################################
    # Writes content from memory buffer to file by overwriting existing file.
    # Type: void
    # Arguments:
    #   %s = the name of the file
    #   %mode = open file mode (Default 0)
    #   %text = the memory address (label) of the text we want to write
    #   %text_len = the length of the text
    #################################
    .macro write_file(%s, %mode, %text, %text_len)
        addi $sp, $sp, -12
        sw $a0, 0($sp)
        sw $a1, 4($sp)
        sw $a2, 8($sp)
        
        la $a0, %s # Load the file name
        li $a1, 1
        move $a2, %mode # Copy the file open mode
        li $v0, 13 
        syscall

        move $a0, $v0
        la $a1, %text
        move $a2, %text_len
        li $v0, 15
        syscall

        lw $a0, 0($sp)
        lw $a1, 4($sp)
        lw $a2, 8($sp)
        addi $sp, $sp, 12
    .end_macro
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
    .macro push(%reg)
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