/* SPDX-License-Identifier: MPL-2.0 */
/* Checky Monkey public C ABI, v0.1: declarations are intentionally
 * limited to the symbols actually exported by ffi/zig/src/main.zig.
 * The header describes a native library, not a working script validator.
 */
#ifndef CHECKY_MONKEY_H
#define CHECKY_MONKEY_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct checky_monkey_handle checky_monkey_handle;

/* Results: 0 success, 1 error, 2 invalid input, 3 out of memory,
 * 4 null pointer, 5 operation not implemented. */
typedef enum checky_monkey_result {
    CHECKY_MONKEY_OK = 0,
    CHECKY_MONKEY_ERROR = 1,
    CHECKY_MONKEY_INVALID_PARAM = 2,
    CHECKY_MONKEY_OUT_OF_MEMORY = 3,
    CHECKY_MONKEY_NULL_POINTER = 4,
    CHECKY_MONKEY_UNSUPPORTED = 5
} checky_monkey_result;

typedef uint32_t (*checky_monkey_callback)(uint64_t, uint32_t);

checky_monkey_handle *checky_monkey_init(void);
void checky_monkey_free(checky_monkey_handle *handle);
checky_monkey_result checky_monkey_process(checky_monkey_handle *handle, uint32_t input);
checky_monkey_result checky_monkey_process_array(
    checky_monkey_handle *handle, const uint8_t *buffer, uint32_t length);
checky_monkey_result checky_monkey_register_callback(
    checky_monkey_handle *handle, checky_monkey_callback callback);
uint32_t checky_monkey_is_initialized(checky_monkey_handle *handle);

/* Owned NUL-terminated data: release with checky_monkey_free_string(). */
const char *checky_monkey_get_string(checky_monkey_handle *handle);
void checky_monkey_free_string(const char *value);

/* Borrowed, thread-local error text, cleared on successful operations.
 * Never free; valid until the next operation on the same thread. */
const char *checky_monkey_last_error(void);

/* Borrowed process-lifetime constant strings; never free. */
const char *checky_monkey_version(void);
const char *checky_monkey_build_info(void);

#ifdef __cplusplus
}
#endif
#endif
