const std = @import("std");
const stdout = std.io.getStdOut().writer();
const mem = std.mem;
const Allocator = mem.Allocator;
const Uri = std.Uri;

pub const NormalizeURLError = error{
    EmptyURL,
    InvalidFormat,
};
pub fn main() !void {
    var arena_instance = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena_instance.deinit();
    const arena = arena_instance.allocator();
    const baseURL = "http://www.dmi.dk ";
    const inputURL = "https://www.dmi.dk/presse-OG-medier/";
    const normiURL = try normalizeURL(arena, baseURL, inputURL);
    try stdout.print("{s}\n", .{normiURL});
}

pub fn normalizeURL(allocator: std.mem.Allocator, baseURL: []const u8, inputURL: []const u8) ![]const u8 {
    if (inputURL.len == 0) {
        return NormalizeURLError.EmptyURL;
    }
    const lowerURL = try std.ascii.allocLowerString(allocator, inputURL);
    defer allocator.free(lowerURL);
    var noSlashURL = try allocator.alloc(u8, lowerURL.len);
    defer allocator.free(noSlashURL);
    if (std.mem.eql(u8, lowerURL[lowerURL.len - 1 ..], "/")) {
        noSlashURL = lowerURL[0 .. lowerURL.len - 1];
    } else {
        noSlashURL = lowerURL[0..];
    }
    const parsedBase = try Uri.parse(baseURL);
    var buffer = try allocator.alloc(u8, baseURL.len + noSlashURL.len + 1);
    const parsedURL = try Uri.resolve_inplace(parsedBase, noSlashURL, &buffer);
    const host = parsedURL.host.?.percent_encoded;
    const path = parsedURL.path.percent_encoded;
    const result = try std.fmt.allocPrint(allocator, "{s}{s}", .{ host, path });
    return result;
}
