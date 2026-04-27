K9!
# SPDX-License-Identifier: PMPL-1.0-or-later
# K9 Kennel Template — Restricted Data Configuration.
#
# SECURITY LEVEL: 'Kennel'
# This module is restricted to pure data evaluation. It is forbidden 
# from performing execution, network access, or filesystem writes.

{
  pedigree = {
    schema_version = "1.0.0",
    # ATTENUATION: Explicitly denies all side-effect capabilities.
    security = {
      leash = 'Kennel,
      trust_level = "data-only",
      allow_network = false,
      allow_filesystem_write = false,
      allow_subprocess = false,
    },
    metadata = {
      name = "Base Configuration Template",
      version = "1.0.0",
      description = "Foundational template for kennel-restricted components.",
    },
  },

  # CONFIGURATION: Declarative data values only.
  config = {
    setting_1 = "value",
    setting_2 = 42,
    setting_3 = true,
  },

  # EXPORT: Defines the target format for serialization.
  export = {
    format = "json",
    destination = "output.json",
  },
}
