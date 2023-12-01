# On each line, the calibration value can be found by combining the 
# first digit and the last digit (in that order) to 
# form a single two-digit number.

fn day_one_part_one() raises -> Int32:    
    let input_file_str: FileHandle = open("./puzzles/day_one/input.txt", "r")
    let input_file: String = input_file_str.read()
    
    var first_num: String = ""
    var second_num: String = ""
    var first_set: Bool = False
    var second_set: Bool = False
    var part_one: Int32 = 0

    for idx in range(len(input_file)):
        let char: String = input_file[idx]
        if (char == "\n" or idx == len(input_file) - 1):

            let second_str: String = second_num if second_set else first_num
            let num: Int32 = atol(first_num + second_str)

            first_set = False
            second_set = False
            part_one += num

        let result_digit: Bool = isdigit(c=ord(s=char))

        if (result_digit):
            if (first_set):
                second_num = char
                second_set = True

            else:
                first_num = char
                first_set = True

    return part_one

fn day_one_part_two() raises -> Int32:
    let input_file_str = open("./puzzles/day_one/input_two.txt", "r")
    let input_file = input_file_str.read()
    
    var first_number: String = ""
    var second_number: String = ""
    var first_set: Bool = False
    var second_set: Bool = False
    var part_two: Int32 = 0

    for idx in range(len(input_file)):
        let char: String = input_file[idx]
        if (char == "\n" or idx == len(input_file) - 1):
            let second_str = second_number if second_set else first_number
            let num = atol(first_number + second_str)
            first_set = False
            second_set = False
            part_two += num
        let x_str = input_file[idx : idx + 5]
        let int_str = string_to_int(input_str=x_str)
        if (int_str > 0):
            if first_set:
                second_number = int_str
                second_set = True
            else:
                first_number = int_str
                first_set = True
        if (isdigit(ord(char))):
            if first_set:
                second_number = char
                second_set = True
            else:
                first_number = char
                first_set = True
    return part_two




fn string_to_int(input_str: String) -> Int32:
    # Mojo does not yet have a standard dictionary type. 
    # This is a workaround to get the same functionality
    if input_str[0:3] == "one":
        return 1
    elif input_str[0:3] == "two":
        return 2
    elif input_str[0:5] == "three":
        return 3
    elif input_str[0:4] == "four":
        return 4
    elif input_str[0:4] == "five":
        return 5
    elif input_str[0:3] == "six":
        return 6
    elif input_str[0:5] == "seven":
        return 7
    elif input_str[0:5] == "eight":
        return 8
    elif input_str[0:4] == "nine":
        return 9
    else:
        return 0