// SPDX-License-Identifier: MPL-2.0
// Checky Monkey native C-ABI library build. Tested toolchain target: Zig 0.13.0.
const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const shared = b.addSharedLibrary(.{
        .name = "checky_monkey",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
        .version = .{ .major = 0, .minor = 1, .patch = 0 },
    });
    shared.linkLibC();
    b.installArtifact(shared);

    const static_lib = b.addStaticLibrary(.{
        .name = "checky_monkey",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    static_lib.linkLibC();
    b.installArtifact(static_lib);

    const unit_tests = b.addTest(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    unit_tests.linkLibC();
    const run_unit_tests = b.addRunArtifact(unit_tests);

    const integration_tests = b.addTest(.{
        .root_source_file = b.path("test/integration_test.zig"),
        .target = target,
        .optimize = optimize,
    });
    integration_tests.linkLibrary(static_lib);
    integration_tests.linkLibC();
    const run_integration_tests = b.addRunArtifact(integration_tests);

    const test_step = b.step("test", "Run native unit and C-ABI integration tests");
    test_step.dependOn(&run_unit_tests.step);
    test_step.dependOn(&run_integration_tests.step);

    const integration_step = b.step("test-integration", "Run native C-ABI integration tests");
    integration_step.dependOn(&run_integration_tests.step);
}
