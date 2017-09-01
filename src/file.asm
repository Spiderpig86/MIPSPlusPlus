#################################
# File IO Macros
# Contains helpful macros.
#################################

#################################
# Open the file in the OS so it can be accessed (reading/writing)
# Type: String
# Arguments:
#   %s = name of file we want to open
#   %flags = flags for opening up the file
#   %mode = mode for opening the file (read only, read/write, etc)
#   %buffer = the space or input buffer we want to load the file contents to
#   %max_chars = the maximum number of characters to read
#################################
.macro read_file(%s, %flags, %mode, %buffer, %max_chars)
    addi $sp, $sp, -12
    sw $a0, 0($sp)
    sw $a1, 4($sp)
    sw $a2, 8($sp)

    la $a0, %s # Load the file name
    move $a1, %flags # Copy the flags
    move $a2, %mode # Copy the file open mode
    li $v0, 13 

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

