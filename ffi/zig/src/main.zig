// CHECKY-MONKEY — Zig FFI Implementation
//
// This module implements the binary interface for the Checky-Monkey bot.
// It provides the low-level hooks for system interaction and automation.

const std = @import("std");

const VERSION = "0.1.0";
const BUILD_INFO = "Checky-Monkey (Zig) - Automation Kernel";

/// THREAD-LOCAL ERRORS: Stores the last error message.
threadlocal var last_error: ?[]const u8 = null;

//==============================================================================
// CORE TYPES: ABI-Stable Representations
//==============================================================================

/// RESULT CODES: Must match the `Result` type in `ABI/Types.idr`.
pub const Result = enum(c_int) {
    ok = 0,
    @"error" = 1,
    invalid_param = 2,
    out_of_memory = 3,
    null_pointer = 4,
};

/// OPAQUE HANDLE: Internal bot state.
pub const Handle = opaque {
    allocator: std.mem.Allocator,
    initialized: bool,
};

//==============================================================================
// LIFECYCLE: Setup & Teardown
//==============================================================================

/// INITIALIZATION: Prepares the bot kernel.
export fn checky_monkey_init() ?*Handle {
    const allocator = std.heap.c_allocator;

    const handle = allocator.create(Handle) catch {
        last_error = "FFI: Memory allocation failed";
        return null;
    };

    handle.* = .{
        .allocator = allocator,
        .initialized = true,
    };

    return handle;
}

/// CLEANUP: Stops the bot kernel and releases resources.
export fn checky_monkey_free(handle: ?*Handle) void {
    const h = handle orelse return;
    const allocator = h.allocator;
    h.initialized = false;
    allocator.destroy(h);
}
