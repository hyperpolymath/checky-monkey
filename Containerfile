# SPDX-License-Identifier: MPL-2.0
# Copyright (c) 2026 Jonathan D.A. Jewell (hyperpolymath) <j.d.a.jewell@open.ac.uk>
#
# Checky-Monkey — distribution image for the Zig FFI library.
#
# checky-monkey is currently an Idris2 ABI + Zig C-ABI library
# (libchecky_monkey.{so,a}), not a running service. This image is a
# distribution artifact carrying the compiled library (and its source) for
# downstream FFI consumers to `COPY --from`. The in-tree build.zig is a
# not-yet-instantiated scaffold template (its `{{project}}` placeholders and a
# missing include/ header break `zig build`), so the library is built directly
# with `zig build-lib`, which only needs the self-contained src/main.zig.
FROM cgr.dev/chainguard/wolfi-base:latest AS builder
RUN apk add --no-cache zig
WORKDIR /build
COPY ffi/zig/src/ ./src/
# Build the shared (.so) and static (.a) libraries directly from the
# self-contained source (src/main.zig imports only std + builtin). -lc links
# libc, which std.heap.c_allocator requires.
RUN zig build-lib src/main.zig -dynamic -O ReleaseSafe --name checky_monkey -lc \
    && zig build-lib src/main.zig -O ReleaseSafe --name checky_monkey -lc \
    && ls -l libchecky_monkey.so libchecky_monkey.a

FROM cgr.dev/chainguard/wolfi-base:latest
RUN apk add --no-cache libgcc \
    && addgroup -g 1000 checky \
    && adduser -D -u 1000 -G checky checky
WORKDIR /app
COPY --from=builder --chown=checky:checky /build/libchecky_monkey.so /build/libchecky_monkey.a ./lib/
COPY --chown=checky:checky ffi/zig/src/ ./src/
USER checky
# A library image — no server, so no EXPOSE / no service HEALTHCHECK.
LABEL org.opencontainers.image.title="Checky-Monkey" \
      org.opencontainers.image.description="Idris2 ABI + Zig FFI library for userscript verification (libchecky_monkey.{so,a})" \
      org.opencontainers.image.source="https://github.com/hyperpolymath/checky-monkey" \
      org.opencontainers.image.licenses="MPL-2.0" \
      org.opencontainers.image.authors="Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>"
