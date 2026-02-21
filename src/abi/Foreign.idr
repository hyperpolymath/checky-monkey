||| CHECKY-MONKEY — FFI Bridge Declarations
|||
||| This module defines the formal bridge to the bot's native implementation.
||| It ensures that automation hooks are called with type-safe semantics.

module CHECKY_MONKEY.ABI.Foreign

import CHECKY_MONKEY.ABI.Types
import CHECKY_MONKEY.ABI.Layout

%default total

--------------------------------------------------------------------------------
-- Lifecycle
--------------------------------------------------------------------------------

||| Initializes the Checky-Monkey bot engine.
export
%foreign "C:checky_monkey_init, libchecky_monkey"
prim__init : PrimIO Bits64

||| Safe initialization wrapper.
export
init : IO (Maybe Handle)
init = do
  ptr <- primIO prim__init
  pure (createHandle ptr)

||| Shuts down the bot engine.
export
%foreign "C:checky_monkey_free, libchecky_monkey"
prim__free : Bits64 -> PrimIO ()

||| Safe cleanup wrapper.
export
free : Handle -> IO ()
free h = primIO (prim__free (handlePtr h))
