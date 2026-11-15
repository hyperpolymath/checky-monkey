// SPDX-License-Identifier: MPL-2.0
// C-ABI integration tests linked against the actual static Zig library.
// This suite exercises exported symbols, not simulated kernel behaviour.
const std = @import("std");
const testing = std.testing;

extern fn checky_monkey_init() ?*anyopaque;
extern fn checky_monkey_free(?*anyopaque) void;
extern fn checky_monkey_is_initialized(?*anyopaque) u32;
extern fn checky_monkey_process(?*anyopaque, u32) c_int;
extern fn checky_monkey_last_error() ?[*:0]const u8;
extern fn checky_monkey_get_string(?*anyopaque) ?[*:0]const u8;
extern fn checky_monkey_free_string(?[*:0]const u8) void;
extern fn checky_monkey_version() [*:0]const u8;

test "C ABI: library handle lifecycle" {
    const handle = checky_monkey_init() orelse return error.InitFailed;
    defer checky_monkey_free(handle);
    try testing.expectEqual(@as(u32, 1), checky_monkey_is_initialized(handle));
    try testing.expectEqual(@as(u32, 0), checky_monkey_is_initialized(null));
}

test "C ABI: independent session handles" {
    const first = checky_monkey_init() orelse return error.InitFailed;
    defer checky_monkey_free(first);
    const second = checky_monkey_init() orelse return error.InitFailed;
    defer checky_monkey_free(second);
    try testing.expect(first != second);
}

test "C ABI: unimplemented processing is not a pass" {
    const handle = checky_monkey_init() orelse return error.InitFailed;
    defer checky_monkey_free(handle);

    try testing.expectEqual(@as(c_int, 5), checky_monkey_process(handle, 42));
    const message = checky_monkey_last_error() orelse return error.NoErrorMessage;
    try testing.expectEqualStrings("Processing is not implemented", std.mem.span(message));
    try testing.expectEqual(@as(c_int, 4), checky_monkey_process(null, 42));
}

test "C ABI: allocated strings have a matching deallocator" {
    const handle = checky_monkey_init() orelse return error.InitFailed;
    defer checky_monkey_free(handle);
    const result = checky_monkey_get_string(handle) orelse return error.NoString;
    defer checky_monkey_free_string(result);
    try testing.expectEqualStrings("Example result", std.mem.span(result));
    try testing.expectEqualStrings("0.1.0", std.mem.span(checky_monkey_version()));
}
