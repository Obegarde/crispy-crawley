const std = @import("std");
const normURL = @import("normalizeURL.zig");
const expectEqualStrings = std.testing.expectEqualStrings;
const expectError = std.testing.expectError;

test "remove scheme" {
    var arena_instance = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena_instance.deinit();
    const arena = arena_instance.allocator();
    try expectEqualStrings("blog.boot.dev/path", try normURL.normalizeURL(arena, "https://blog.boot.dev", "https://blog.boot.dev/path"));
}
test "remove slash at end" {
    var arena_instance = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena_instance.deinit();
    const arena = arena_instance.allocator();
    try expectEqualStrings("blog.boot.dev/path", try normURL.normalizeURL(arena, "https://blog.boot.dev", "https://blog.boot.dev/path/"));
}
test "remove http" {
    var arena_instance = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena_instance.deinit();
    const arena = arena_instance.allocator();
    try expectEqualStrings("blog.boot.dev/path", try normURL.normalizeURL(arena, "https://blog.boot.dev", "http://blog.boot.dev/path"));
}
test "remove slash and http" {
    var arena_instance = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena_instance.deinit();
    const arena = arena_instance.allocator();
    try expectEqualStrings("blog.boot.dev/path", try normURL.normalizeURL(arena, "https://blog.boot.dev", "http://blog.boot.dev/path/"));
}
test "lowercase capital letter" {
    var arena_instance = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena_instance.deinit();
    const arena = arena_instance.allocator();
    try expectEqualStrings("blog.boot.dev/path", try normURL.normalizeURL(arena, "https://blog.boot.dev", "https://BLOG.boot.dev/PATH"));
}
test "remove scheme and capitals and trailing slash" {
    var arena_instance = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena_instance.deinit();
    const arena = arena_instance.allocator();
    try expectEqualStrings("blog.boot.dev/path", try normURL.normalizeURL(arena, "https://blog.boot.dev", "http://BLOG.boot.dev/path/"));
}
//test "handle invalid URL" {
//    var arena_instance = std.heap.ArenaAllocator.init(std.heap.page_allocator);
//  defer arena_instance.deinit();
//const arena = arena_instance.allocator();
//try expectError(std.Uri.ParseError.InvalidFormat, try normURL.normalizeURL(arena, "https://blog.boot.dev", ":\\invalidURL"));
//}

//test "handle empty URL" {
//    var arena_instance = std.heap.ArenaAllocator.init(std.heap.page_allocator);
//  defer arena_instance.deinit();
// const arena = arena_instance.allocator();
//try expectError(normURL.NormalizeURLError.EmptyURL, try normURL.normalizeURL(arena, "https://blog.boot.dev", ""));
//}
