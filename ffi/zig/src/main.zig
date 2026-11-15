// CHECKY_MONKEY FFI Implementation
//
// This module implements the C-compatible FFI declared in src/abi/Foreign.idr
// All types and layouts must match the Idris2 ABI definitions.
//
// SPDX-License-Identifier: MPL-2.0

const std = @import("std");

// Version information (keep in sync with project)
const VERSION = "0.1.0";
const BUILD_INFO = "CHECKY_MONKEY built with Zig " ++ @import("builtin").zig_version_string;

/// Thread-local error storage
threadlocal var last_error: ?[:0]const u8 = null;

/// Set the last error message
fn setError(msg: [:0]const u8) void {
    last_error = msg;
}

/// Clear the last error
fn clearError() void {
    last_error = null;
}

//==============================================================================
// Core Types (must match src/abi/Types.idr)
//==============================================================================

/// Result codes (must match Idris2 Result type)
pub const Result = enum(c_int) {
    ok = 0,
    @"error" = 1,
    invalid_param = 2,
    out_of_memory = 3,
    null_pointer = 4,
    unsupported = 5,
};

/// Library handle. Exposed to C as an opaque `*Handle` pointer — callers never
/// dereference it, so the field layout stays private in practice. (Declared as
/// a struct rather than `opaque {}` because Zig opaque types cannot carry
/// fields; the previous `opaque { ... fields ... }` form did not compile.)
pub const Handle = struct {
    // Internal state, hidden from C behind the opaque pointer.
    allocator: std.mem.Allocator,
    initialized: bool,
};

//==============================================================================
// Library Lifecycle
//==============================================================================

/// Initialize the library
/// Returns a handle, or null on failure
export fn checky_monkey_init() ?*Handle {
    const allocator = std.heap.c_allocator;

    const handle = allocator.create(Handle) catch {
        setError("Failed to allocate handle");
        return null;
    };

    // Initialize handle
    handle.* = .{
        .allocator = allocator,
        .initialized = true,
    };

    clearError();
    return handle;
}

/// Free the library handle
export fn checky_monkey_free(handle: ?*Handle) void {
    const h = handle orelse return;
    const allocator = h.allocator;

    // Clean up resources
    h.initialized = false;

    allocator.destroy(h);
    clearError();
}

//==============================================================================
// Core Operations
//==============================================================================

/// Process data (example operation)
export fn checky_monkey_process(handle: ?*Handle, input: u32) Result {
    const h = handle orelse {
        setError("Null handle");
        return .null_pointer;
    };

    if (!h.initialized) {
        setError("Handle not initialized");
        return .@"error";
    }

    // The real userscript analysis pipeline does not exist yet.
    // Never report success for an operation that has not been implemented.
    _ = input;
    setError("Processing is not implemented");
    return .unsupported;
}

//==============================================================================
// String Operations
//==============================================================================

/// Get a string result (example)
/// Caller must free the returned string
export fn checky_monkey_get_string(handle: ?*Handle) ?[*:0]const u8 {
    const h = handle orelse {
        setError("Null handle");
        return null;
    };

    if (!h.initialized) {
        setError("Handle not initialized");
        return null;
    }

    // Example: allocate and return a string
    const result = h.allocator.dupeZ(u8, "Example result") catch {
        setError("Failed to allocate string");
        return null;
    };

    clearError();
    return result.ptr;
}

/// Free a string allocated by the library
export fn checky_monkey_free_string(str: ?[*:0]const u8) void {
    const s = str orelse return;
    const allocator = std.heap.c_allocator;

    const slice = std.mem.span(s);
    allocator.free(slice);
}

//==============================================================================
// Array/Buffer Operations
//==============================================================================

/// Process an array of data
export fn checky_monkey_process_array(
    handle: ?*Handle,
    buffer: ?[*]const u8,
    len: u32,
) Result {
    const h = handle orelse {
        setError("Null handle");
        return .null_pointer;
    };

    const buf = buffer orelse {
        setError("Null buffer");
        return .null_pointer;
    };

    if (!h.initialized) {
        setError("Handle not initialized");
        return .@"error";
    }

    // Neither read the caller's raw buffer nor pretend it was processed.
    _ = buf;
    _ = len;
    setError("Array processing is not implemented");
    return .unsupported;
}

//==============================================================================
// Error Handling
//==============================================================================

/// Borrow the last error message from per-thread storage, or null.
/// The returned pointer must NOT be freed; valid until the next operation
/// that sets or clears the error on this thread.
export fn checky_monkey_last_error() ?[*:0]const u8 {
    const err = last_error orelse return null;
    return err.ptr;
}

//==============================================================================
// Version Information
//==============================================================================

/// Get the library version
export fn checky_monkey_version() [*:0]const u8 {
    return VERSION.ptr;
}

/// Get build information
export fn checky_monkey_build_info() [*:0]const u8 {
    return BUILD_INFO.ptr;
}

//==============================================================================
// Callback Support
//==============================================================================

/// Callback function type (C ABI)
pub const Callback = *const fn (u64, u32) callconv(.C) u32;

/// Register a callback
export fn checky_monkey_register_callback(
    handle: ?*Handle,
    callback: ?Callback,
) Result {
    const h = handle orelse {
        setError("Null handle");
        return .null_pointer;
    };

    const cb = callback orelse {
        setError("Null callback");
        return .null_pointer;
    };

    if (!h.initialized) {
        setError("Handle not initialized");
        return .@"error";
    }

    // Callback storage and invocation are not implemented.
    _ = cb;
    setError("Callback registration is not implemented");
    return .unsupported;
}

//==============================================================================
// Utility Functions
//==============================================================================

/// Check if handle is initialized
export fn checky_monkey_is_initialized(handle: ?*Handle) u32 {
    const h = handle orelse return 0;
    return if (h.initialized) 1 else 0;
}

//==============================================================================
// Tests
//==============================================================================

test "lifecycle" {
    const handle = checky_monkey_init() orelse return error.InitFailed;
    defer checky_monkey_free(handle);

    try std.testing.expect(checky_monkey_is_initialized(handle) == 1);
}

test "error handling" {
    const result = checky_monkey_process(null, 0);
    try std.testing.expectEqual(Result.null_pointer, result);

    const err = checky_monkey_last_error();
    try std.testing.expect(err != null);
}

test "version" {
    const ver = checky_monkey_version();
    const ver_str = std.mem.span(ver);
    try std.testing.expectEqualStrings(VERSION, ver_str);
}

test "unimplemented processing never reports success" {
    const handle = checky_monkey_init() orelse return error.InitFailed;
    defer checky_monkey_free(handle);

    try std.testing.expectEqual(Result.unsupported, checky_monkey_process(handle, 42));
    const process_error = checky_monkey_last_error() orelse return error.MissingError;
    try std.testing.expectEqualStrings("Processing is not implemented", std.mem.span(process_error));

    const bytes = [_]u8{ 0x01, 0x02, 0x03 };
    try std.testing.expectEqual(Result.unsupported, checky_monkey_process_array(handle, &bytes, bytes.len));
    try std.testing.expectEqual(Result.unsupported, checky_monkey_register_callback(handle, testCallback));
}

fn testCallback(_: u64, _: u32) callconv(.C) u32 {
    return 0;
}

test "borrowed error message is stable and not heap allocated" {
    try std.testing.expectEqual(Result.null_pointer, checky_monkey_process(null, 0));
    const error_text = checky_monkey_last_error() orelse return error.MissingError;
    try std.testing.expectEqualStrings("Null handle", std.mem.span(error_text));
    const handle = checky_monkey_init() orelse return error.InitFailed;
    defer checky_monkey_free(handle);
    try std.testing.expect(checky_monkey_last_error() == null);
}
