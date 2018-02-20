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
    MAX_WORD: .word 0x80000000
    MIN_WORD: .word 0x7fffffff