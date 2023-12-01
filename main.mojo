# import days.day_one.problem
from puzzles.day_one.problem import day_one_part_one, day_one_part_two

fn main() raises:
    let day_one_sol: Int32 = day_one_part_one()
    print("Day one: ", day_one_sol)
    let day_two_sol: Int32 = day_one_part_two()
    print("Day two: ", day_two_sol)
    