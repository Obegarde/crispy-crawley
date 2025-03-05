const std = @import("std");
const normURL = @import("normalizeURL.zig");
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    //const url = "http://www.ietf.org/rfc/rfc2396.txt";
    const parsedURI = normURL.normalizeURL("");
    try stdout.print("{any}", .{parsedURI});
}
