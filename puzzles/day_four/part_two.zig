const std = @import("std");

fn main() !void {
    const allocator = std.heap.page_allocator;
    const file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    var cards: [][2][]u32 = null;

    const reader = file.reader();
    while (true) {
        const lineOpt = try reader.readLine();
        if (lineOpt == null) break;

        const line = try lineOpt;
        const parts = line.split("|", 0);
        if (parts.len != 2) continue;

        const winningNumbers = try parseNumbers(parts[0]);
        const yourNumbers = try parseNumbers(parts[1]);

        cards |= &[_][2]{winningNumbers, yourNumbers};
    }

    var totalCards: u64 = 0;

    while (cards.len > 0) {
        var newCards: [][2][]u32 = null;

        for (cards) |card| {
            const matches = calculateMatches(card[0], card[1]);

            if (matches > 0) {
                var j: u32 = 1;
                for (j <= matches) {
                    newCards |= &[_][2]{ card[0], card[1] };
                    ; j += 1
                }
            }

            totalCards += 1;
        }

        cards = newCards;
    }

    const result: u64 = countTotalCards(cards);

    std.debug.print("Total Cards: {}\n", .{result});
}

fn calculateMatches(winningNumbers: []const u32, yourNumbers: []const u32) u32 {
    var matches: u32 = 0;
    for (yourNumbers) |yn| {
        for (winningNumbers) |wn| {
            if (yn == wn) {
                matches += 1;
                break;
            }
        }
    }
    return matches;
}

fn isAllDigits(s: []const u8) bool {
    for (s) |char| {
        if (!std.ascii.isDigit(char)) return false;
    }
    return true;
}

fn parseNumbers(s: []const u8) ![]u32 {
    var numbers = std.ArrayList(u32).init(std.heap.page_allocator.*);

    const trimmed = std.mem.trim(s, " \n\r\t");
    const tokenizer = std.mem.tokenize(trimmed, " ");
    while (tokenizer.next()) |num_str| {
        if (isAllDigits(num_str)) {
            const num = try std.fmt.parseInt(u32, num_str, 10);
            try numbers.append(num);
        }
    }

    return numbers.toOwnedSlice();
}

fn countTotalCards(cardCounts: [][_][]u32) u64 {
    var total: u64 = 0;
    for (cardCounts) |count| {
        for (count) |_card| {
            total += 1;
        }
    }
    return total;
}
