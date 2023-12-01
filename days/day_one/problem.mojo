# On each line, the calibration value can be found by combining the 
# first digit and the last digit (in that order) to 
# form a single two-digit number.

fn day_one() raises -> Int32:
    # Read the input file has to be nested in a try catch - also if we call from main we need to pass in the file path        
    let input_file_str = open("./days/day_one/input.txt", "r")
    let input = input_file_str.read()
    
    var first_num = String()
    var second_num = String()

    var first_set = False
    var second_set = False

    var part_one = 0

    for idx in range(len(input)):
        let char = input[idx]
        if char == "\n" or idx == len(input) - 1:
            let second = second_num if second_set else first_num
            let num = atol(first_num + second)
            first_set = False
            second_set = False
            part_one += num
        if isdigit(ord(char)):
            if first_set:
                second_num = char
                second_set = True
            else:
                first_num = char
                first_set = True
    return part_one
    