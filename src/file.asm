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