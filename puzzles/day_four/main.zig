const std = @import("std");

fn isAllDigits(s: []const u8) bool {
    for (s) |char| {
        if (!std.ascii.isDigit(char)) return false;
    }
    return true;
}

pub fn parseNumbers(allocator: *std.mem.Allocator, s: []const u8) ![]u32 {
    //https://stackoverflow.com/questions/76535068/how-can-i-parse-an-integer-from-a-string-in-zig
    var numbers = std.ArrayList(u32).init(allocator.*);
    defer numbers.deinit();

    // Trim leading and trailing whitespaces
    const trimmed = std.mem.trim(u8, s, " \n\r\t");

    // Parse numbers from string
    var tokenizer = std.mem.tokenize(u8, trimmed, " ");
    while (tokenizer.next()) |num_str| {
        if (isAllDigits(num_str)) {
            const num = try std.fmt.parseInt(u32, num_str, 10);
            try numbers.append(num);
        }
    }

    return numbers.toOwnedSlice();
}

pub fn calculatePoints(winningNumbers: []const u32, yourNumbers: []const u32) u32 {
    var points: u32 = 0;

    for (yourNumbers) |yn| {
        for (winningNumbers) |wn| {
            if (yn == wn) {
                if (points == 0) {
                    points = 1;
                } else {
                    points *= 2;
                }
                break; // Break after the first match to avoid counting a number multiple times
            }
        }
    }

    return points;
}

pub fn main() !void {
    var allocator = std.heap.page_allocator;
    const file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    const reader = file.reader();
    var totalPoints: u32 = 0;

    while (true) {
        const lineOpt = try reader.readUntilDelimiterOrEofAlloc(allocator, '\n', std.math.maxInt(usize));
        if (lineOpt == null) break;

        if (lineOpt) |line| {
            defer allocator.free(line);

            var tokenizer = std.mem.tokenize(u8, line, "|");
            var part = tokenizer.next();

            if (part == null) continue;
            const winningNumbers = try parseNumbers(&allocator, part.?);
            defer allocator.free(winningNumbers);

            part = tokenizer.next();
            if (part == null) continue;
            const yourNumbers = try parseNumbers(&allocator, part.?);
            defer allocator.free(yourNumbers);

            const points = calculatePoints(winningNumbers, yourNumbers);
            totalPoints += points; // Add points for this card to the total
        }
    }

    std.debug.print("Total Points: {}\n", .{totalPoints});
}
