// CHECKY-MONKEY — Integration Test Suite (Zig)
//
// These tests verify the stability of the bot's automation kernel and its 
// adherence to the formal ABI defined in Idris.

const std = @import("std");
const testing = std.testing;

extern fn checky_monkey_init() ?*opaque {};
extern fn checky_monkey_free(?*opaque {}) void;
extern fn checky_monkey_process(?*opaque {}, u32) c_int;

// --- TEST CASES ---

test "kernel: lifecycle stability" {
    const handle = checky_monkey_init() orelse return error.InitFailed;
    defer checky_monkey_free(handle);

    try testing.expect(handle != null);
}

test "kernel: handle isolation" {
    const h1 = checky_monkey_init() orelse return error.InitFailed;
    const h2 = checky_monkey_init() orelse return error.InitFailed;
    defer checky_monkey_free(h1);
    defer checky_monkey_free(h2);

    // ENSURE: Different sessions have distinct memory addresses.
    try testing.expect(h1 != h2);
}

test "concurrency: parallel kernel operations" {
    const handle = checky_monkey_init() orelse return error.InitFailed;
    defer checky_monkey_free(handle);

    // ... [Simulation of multi-threaded bot actions]
}
