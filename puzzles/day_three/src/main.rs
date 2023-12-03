use std::collections::BTreeMap;

fn analyze_input(input_text: &str) -> BTreeMap<(usize, usize), Vec<u32>> {
    let input_lines = input_text.split_terminator('\n').collect::<Vec<_>>();
    let mut coordinates_map = BTreeMap::new();

    for (line_index, current_line) in input_lines.iter().enumerate() {
        let mut horizontal_position = 0;
        let mut substring = *current_line;
        while let Some(offset) = substring.find(|c: char| c.is_ascii_digit()) {
            let temp_str = &substring[offset..];
            let (number_str, remaining) = temp_str.split_at(temp_str.find(|c: char| !c.is_ascii_digit()).unwrap_or(temp_str.len()));
            let parsed_number = number_str.parse::<u32>().expect("Expected digit");
            process_substring(&input_lines, line_index, horizontal_position + offset, number_str.len(), parsed_number, &mut coordinates_map);
            horizontal_position += offset + number_str.len();
            substring = remaining;
        }
    }
    coordinates_map
}

fn process_substring(input_lines: &[&str], current_line_index: usize, start_pos: usize, str_len: usize, digit_value: u32, map: &mut BTreeMap<(usize, usize), Vec<u32>>) {
    for (index_offset, current_line) in input_lines
        .iter()
        .enumerate()
        .take(current_line_index.saturating_add(2))
        .skip(current_line_index.saturating_sub(1))
    {
        let left_bound = start_pos.saturating_sub(1);
        let right_bound = (start_pos + str_len).saturating_add(1).min(current_line.len());
        for (offset, char) in current_line[left_bound..right_bound].char_indices() {
            if !(char == '.' || char.is_ascii_whitespace() || char.is_ascii_digit()) {
                map.entry((left_bound + offset, index_offset))
                    .and_modify(|values| values.push(digit_value))
                    .or_insert_with(|| vec![digit_value]);
            }
        }
    }
}

pub fn compute_part1(input_text: &str) -> u32 {
    analyze_input(input_text).values().flatten().sum()
}

pub fn compute_part2(input_text: &str) -> u32 {
    analyze_input(input_text)
        .values()
        .filter(|values| values.len() == 2)
        .map(|values| values.iter().product::<u32>())
        .sum()
}

fn main() {
    let input_data = include_str!("input.txt");
    println!("part1: {}", compute_part1(input_data));
    println!("part2: {}", compute_part2(input_data));
}
