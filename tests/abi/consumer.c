/* SPDX-License-Identifier: MPL-2.0 */
/* Non-vacuous, linked C consumer for the Zig library's public contract.
 * Source-of-truth harness: proven-tests-and-benches/integrations/contract/c-abi.
 * This does not claim userscript analysis, Idris2 proofs, or concurrency safety.
 */
#include "checky_monkey.h"
#include <stdint.h>
#include <stdio.h>
#include <string.h>

_Static_assert(CHECKY_MONKEY_OK == 0, "ABI result OK drift");
_Static_assert(CHECKY_MONKEY_ERROR == 1, "ABI result ERROR drift");
_Static_assert(CHECKY_MONKEY_INVALID_PARAM == 2, "ABI result INVALID_PARAM drift");
_Static_assert(CHECKY_MONKEY_OUT_OF_MEMORY == 3, "ABI result OOM drift");
_Static_assert(CHECKY_MONKEY_NULL_POINTER == 4, "ABI result NULL drift");
_Static_assert(CHECKY_MONKEY_UNSUPPORTED == 5, "ABI result UNSUPPORTED drift");

#define CHECK(cond, detail) do { \
    if (!(cond)) { fprintf(stderr, "contract failed: %s\n", detail); return 1; } \
} while (0)

static uint32_t callback(uint64_t id, uint32_t value) {
    return (uint32_t)id + value;
}

int main(void) {
    /* Null handles and absent pointers must be rejected before use. */
    CHECK(checky_monkey_is_initialized(NULL) == 0, "null handle appears initialized");
    CHECK(checky_monkey_process(NULL, 3) == CHECKY_MONKEY_NULL_POINTER,
          "null process handle did not fail closed");
    const char *error = checky_monkey_last_error();
    CHECK(error && strcmp(error, "Null handle") == 0, "borrowed last_error unavailable");
    CHECK(checky_monkey_get_string(NULL) == NULL, "null handle produced a string");
    checky_monkey_free(NULL);
    checky_monkey_free_string(NULL);

    checky_monkey_handle *a = checky_monkey_init();
    CHECK(a != NULL, "initialization failed");
    checky_monkey_handle *b = checky_monkey_init();
    CHECK(b != NULL && a != b, "independent live handles alias");
    CHECK(checky_monkey_last_error() == NULL, "init did not clear prior error");
    CHECK(checky_monkey_is_initialized(a) == 1, "live handle not initialized");
    CHECK(checky_monkey_is_initialized(b) == 1, "second handle not initialized");

    /* No real product pipeline exists; every such operation MUST refuse. */
    CHECK(checky_monkey_process(a, 42) == CHECKY_MONKEY_UNSUPPORTED,
          "unimplemented process produced an apparent pass");
    CHECK(checky_monkey_last_error() != NULL, "unsupported process lost reason");
    CHECK(checky_monkey_process_array(a, NULL, 0) == CHECKY_MONKEY_NULL_POINTER,
          "null array buffer accepted");
    const uint8_t bytes[] = { 0, 1, 255 };
    CHECK(checky_monkey_process_array(a, bytes, 3) == CHECKY_MONKEY_UNSUPPORTED,
          "unimplemented array process produced an apparent pass");
    CHECK(checky_monkey_register_callback(a, NULL) == CHECKY_MONKEY_NULL_POINTER,
          "null callback accepted");
    CHECK(checky_monkey_register_callback(a, callback) == CHECKY_MONKEY_UNSUPPORTED,
          "unimplemented callback registration produced an apparent pass");

    /* Owned strings have a deallocator; errors and version are borrowed. */
    const char *owned = checky_monkey_get_string(a);
    CHECK(owned != NULL && strcmp(owned, "Example result") == 0,
          "string result contract changed without update");
    CHECK(checky_monkey_last_error() == NULL, "successful getter did not clear error");
    checky_monkey_free_string(owned);
    CHECK(strcmp(checky_monkey_version(), "0.1.0") == 0, "version contract drift");
    CHECK(strstr(checky_monkey_build_info(), "Zig") != NULL, "build metadata missing");

    checky_monkey_free(a);
    CHECK(checky_monkey_is_initialized(b) == 1, "freeing a corrupted other live handle");
    checky_monkey_free(b);
    return 0;
}
