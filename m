Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D79C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 06:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sipxZ-0002gf-4p; Tue, 27 Aug 2024 02:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3EHbNZgUKCm8gNiVcTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--tavip.bounces.google.com>)
 id 1sipxX-0002bR-R9
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:45:43 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3EHbNZgUKCm8gNiVcTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--tavip.bounces.google.com>)
 id 1sipxU-000641-37
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:45:43 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-1fc58790766so59592895ad.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 23:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1724741136; x=1725345936; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=lAh/CBS4B9KfA0v7xRIzjxZuLwU+4zechPyuqw1fJdc=;
 b=fhnAa3sOl+3ZQVeyO9KMuMDqm4YHlIH5xKzzBDgkhtx6LvAit0DKKeylDaJMF9+h0H
 1OUBd8HbXeFePOvaNcugYq4K+gLgMXR6lUrWy6WWI+0XbD4h/KqDCqA/uzfj2E8kkzys
 QCGWoi7xdkK/xggxS/uhy2+WwT12E4oWd05ssorLhUj+1t8tmY1I2ncIzXbirtbX/qv2
 DMhsrvTj2FDF6o5pBZmqQ9ps9PHyDCA7ZnEvRPgIdO5RVUev2tAbLhVsginN5vdwpudW
 5skAVPXowFefifkZnmR2JNWtlXT/JPrr7ADPtMdAnmpIwbBZsDWgP+xASoixlh2IS6Dv
 fvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724741136; x=1725345936;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lAh/CBS4B9KfA0v7xRIzjxZuLwU+4zechPyuqw1fJdc=;
 b=mq9Oo1gNUDTkr4fyJHQqPj3sd9rBL7UHJymUspFrsySlyglkt95tNmtUIWkwGug4p5
 RNOK0FwWcISRMwsC9sn3ovCW0BnwHWraVDZmJNfdJjOFfCro7iy/HE7i7jWnF5BJFqWX
 JgI05POOjO/wtaOcVQetE8eX2yXmhqLBV3KNpFEHjL9JP+IBfFQ3XxyftqJnY0XIBDGk
 h8SR0K64gtPYgKguWDh8ivKJ5zNb/b4M/d6RSyz+YkkDeLLCbWiIjDUxZ1GuFTZGGsrk
 Y+7v4aB49zWdtfP3vVUDZoh+Znh74GIkr7PsNh47JSNevibnJpUQkuNs8T99iWGGxnje
 fJKw==
X-Gm-Message-State: AOJu0YzzPbvC0sU5pP/12OIO9jlUXIqxMnzFBVOU6LmvI3m5mFs+dj5Q
 nbWksg0g9nUU006/JfCXDTmkKGuwv8Kv+D6ukc7HGzRGMkeBdPBO5hVobfWyl+hEdqBwUJMVCTO
 XNk0/WXoXNBtuqf6vDJIdtk3syrrJALCiu1arld3kYg3nR8+ENulxKXc8fZYUpighAq++J9n49G
 ++jcvYp5h4++br2sOayEgNlbRWCg==
X-Google-Smtp-Source: AGHT+IG3HkFXp6vtXiuyhiA4nxX6kmE+kth1d1rBKeeaemX+5N5lTzh3xmpNbWP9kfR7QAsicSjoPa+UXA==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:902:c401:b0:1fc:2e36:5112
 with SMTP id
 d9443c01a7336-2039e4a6ce7mr11982345ad.2.1724741136009; Mon, 26 Aug 2024
 23:45:36 -0700 (PDT)
Date: Mon, 26 Aug 2024 23:45:07 -0700
In-Reply-To: <20240827064529.1246786-1-tavip@google.com>
Mime-Version: 1.0
References: <20240827064529.1246786-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827064529.1246786-4-tavip@google.com>
Subject: [RFC PATCH v3 03/24] scripts: add script to generate C header files
 from SVD XML files
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3EHbNZgUKCm8gNiVcTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--tavip.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Stefan Stanacar <stefanst@google.com>

The CMSIS System View Description format(CMSIS-SVD) is an XML based
description of Arm Cortex-M microcontrollers provided and maintained
by sillicon vendors. It includes details such as peripherals registers
(down to bitfields), peripheral register block addresses, reset
values, etc.

This script uses this information to create header files that makes it
easier to emulate peripherals.

The script can be used to create either peripheral specific headers or
board / system specific information.

Peripheral specific headers contains information such as register
layout (using the qemu register fields infrastructure), register
names, register write masks and register reset values, the latter
using RegisterAccessInfo.

Here is an excerpt from a generated header:

  #pragma once

  #include "hw/registerfields.h"

  /* Flexcomm */
  #define FLEXCOMM_REGS_NO (1024)

  /* Peripheral Select and Flexcomm module ID */
  REG32(FLEXCOMM_PSELID, 4088);
  /* Peripheral Select */
  FIELD(FLEXCOMM_PSELID, PERSEL, 0, 3);
  /* Lock the peripheral select */
  FIELD(FLEXCOMM_PSELID, LOCK, 3, 1);
  /* USART present indicator */
  FIELD(FLEXCOMM_PSELID, USARTPRESENT, 4, 1);
  ...

  typedef enum {                /* FLEXCOMM_PSELID_LOCK */
    /* Peripheral select can be changed by software. */
    FLEXCOMM_PSELID_LOCK_UNLOCKED = 0,
    /* Peripheral select is locked and cannot be changed until this
     * Flexcomm module or the entire device is reset. */
    FLEXCOMM_PSELID_LOCK_LOCKED = 1,
  } FLEXCOMM_PSELID_LOCK_Enum;
  ...

  #define FLEXCOMM_REGISTER_ACCESS_INFO_ARRAY(_name) \
    struct RegisterAccessInfo _name[FLEXCOMM_REGS_NO] = { \
      [0 ... FLEXCOMM_REGS_NO -1] = { \
        .name = "", \
        .addr = -1, \
      }, \
      [R_FLEXCOMM_PSELID] = { \
        .name = "PSELID", \
        .addr = 0xFF8, \
        .ro = 0xFFFFFFF0, \
        .reset = 0x101000, \
      }, \
      [R_FLEXCOMM_PID] = { \
        .name = "PID", \
        .addr = 0xFFC, \
        .ro = 0xFFFFFFFF, \
        .reset = 0x0, \
      }, \
    }

Board specific headers contains information about peripheral base
register addresses.

Signed-off-by: Stefan Stanacar <stefanst@google.com>
[tavip: pylint fixes, generate layout with qemu register fields
instead of bitfields, generate register names, romask and reset values]
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 meson.build               |   4 +
 scripts/svd-gen-header.py | 330 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 334 insertions(+)
 create mode 100755 scripts/svd-gen-header.py

diff --git a/meson.build b/meson.build
index ec59effca2..dee587483b 100644
--- a/meson.build
+++ b/meson.build
@@ -3235,6 +3235,10 @@ tracetool_depends = files(
   'scripts/tracetool/vcpu.py'
 )
 
+svd_gen_header = [
+  python, files('scripts/svd-gen-header.py')
+]
+
 qemu_version_cmd = [find_program('scripts/qemu-version.sh'),
                     meson.current_source_dir(),
                     get_option('pkgversion'), meson.project_version()]
diff --git a/scripts/svd-gen-header.py b/scripts/svd-gen-header.py
new file mode 100755
index 0000000000..f24fc4335e
--- /dev/null
+++ b/scripts/svd-gen-header.py
@@ -0,0 +1,330 @@
+#!/usr/bin/env python3
+
+# Copyright 2024 Google LLC
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+#
+# Use this script to generate a C header file from an SVD xml
+#
+# Two mode of operations are supported: peripheral and system.
+#
+# When running in peripheral mode a header for a specific peripheral
+# is going to be generated. It will define a type and structure with
+# all of the available registers at the bitfield level. An array that
+# contains the reigster names indexed by address is also going to be
+# generated as well as a function to initialize registers to their
+# reset values.
+#
+# Invocation example:
+#
+# svd_gen_header -i MIMXRT595S_cm33.xml -o flexcomm.h -p FLEXCOMM0 -t FLEXCOMM
+#
+# When running in system mode a header for a specific system /
+# platform will be generated. It will define register base addresses
+# and interrupt numbers for selected peripherals.
+#
+# Invocation example:
+#
+# svd_gen_header -i MIMXRT595S_cm33.xml -o rt500.h -s RT500 -p FLEXCOMM0 \
+#                -p CLKCTL0 -p CLKCTL1
+#
+
+import argparse
+import re
+import os
+import sys
+import xml.etree.ElementTree
+import pysvd
+
+data_type_by_bits = {
+    8: "uint8_t",
+    16: "uint16_t",
+    32: "uint32_t",
+}
+
+
+def get_register_array_name_and_size(reg):
+    """Return register name and register array size.
+
+    The SVD can define register arrays and pysvd encodes the whole set
+    as as regular register with their name prepended by [<array size>].
+
+    Returns a tuple with the register name and the size of the array or
+    zero if this is not a register set.
+
+    """
+
+    split = re.split(r"[\[\]]", reg.name)
+    return (split[0], int(split[1]) if len(split) > 1 else 0)
+
+
+def generate_comment(indent, text):
+    """Generate a comment block with for the given text with the given
+    indentation level.
+
+    If possible, use a single line /* */ comment block, otherwise use
+    a multiline comment block.
+
+    Newlines are preseved but tabs are not.
+
+    """
+
+    # preserve new lines
+    text = text.replace("\n", " \n ")
+    text = text.replace("  ", " ")
+
+    if len(text) + len("/*  */") + len(" " * indent) <= 80 and "\n" not in text:
+        return f"{' '* indent}/* {text} */\n"
+
+    out = " " * indent + "/*\n"
+    line = " " * indent + " *"
+    for word in re.split(r"[ ]", text):
+        if len(line) + len(word) >= 79 or word == "\n":
+            out += line + "\n"
+            line = " " * indent + " *"
+            if word != "\n":
+                line += " " + word
+        else:
+            line += " " + word
+
+    out += line + "\n"
+
+    out += " " * indent + " */\n"
+    return out
+
+
+def generate_registers(name, periph):
+    """Generate register offsets and fields
+
+    Use registerfield macros to define register offsets and fields for
+    a given peripheral.
+
+    """
+
+    regs = sorted(periph.registers, key=lambda reg: reg.addressOffset)
+    out = generate_comment(0, periph.description)
+    out += f"#define {name}_REGS_NO ({regs[-1].addressOffset // 4 + 1})\n\n"
+    for reg in regs:
+        out += generate_comment(0, reg.description)
+        reg_name, reg_array_size = get_register_array_name_and_size(reg)
+        if reg_array_size > 1:
+            for idx in range(0, reg_array_size):
+                addr = reg.addressOffset + idx * reg.size // 8
+                out += f"REG32({name}_{reg_name}{idx}, {addr});\n"
+        else:
+            addr = reg.addressOffset
+            out += f"REG32({name}_{reg_name}, {addr});\n"
+        for field in reg.fields:
+            out += generate_comment(0, field.description)
+            if reg_array_size > 1:
+                out += f"SHARED_FIELD({name}_{reg_name}_{field.name}, "
+                out += f"{field.bitOffset}, {field.bitWidth});\n"
+            else:
+                out += f"FIELD({name}_{reg_name}, {field.name}, "
+                out += f"{field.bitOffset}, {field.bitWidth});\n"
+        out += "\n"
+
+    return out
+
+
+def generate_enum_values(name, periph):
+    """Generate enum values"""
+
+    out = "\n"
+    for reg in periph.registers:
+        reg_name, _ = get_register_array_name_and_size(reg)
+        for field in reg.fields:
+            if hasattr(field, "enumeratedValues"):
+                out += "typedef enum {\n"
+                for enum in field.enumeratedValues.enumeratedValues:
+                    enum_name = f"{name}_{reg_name}_{field.name}_{enum.name}"
+                    out += generate_comment(4, enum.description)
+                    out += f"    {enum_name} = {enum.value},\n"
+                out += f"}} {name}_{reg_name}_{field.name}_Enum;\n"
+                out += "\n"
+
+    return out
+
+
+def create_wmask(reg):
+    """Generate write mask for a register.
+
+    Generate a mask with all bits that are writable set to 1
+    """
+
+    wmask = 0
+    fields = sorted(reg.fields, key=lambda field: field.bitOffset)
+    if len(fields) > 0:
+        for field in fields:
+            if field.access != pysvd.type.access.read_only:
+                wmask |= ((1 << field.bitWidth) - 1) << field.bitOffset
+    else:
+        if reg.access != pysvd.type.access.read_only:
+            wmask = 0xFFFFFFFF
+    return wmask
+
+
+def create_romask(reg):
+    """Generate write mask for a register.
+
+    Generate a mask with all bits that are readonly set to 1
+    """
+
+    return ~create_wmask(reg) & 0xFFFFFFFF
+
+
+def generate_register_access_info(name, periph):
+    """Generate RegisterAccessInfo array macro"""
+
+    out = f"\n#define {name}_REGISTER_ACCESS_INFO_ARRAY(_name) \\\n"
+    out += f"    struct RegisterAccessInfo _name[{name}_REGS_NO] = {{ \\\n"
+    out += f"        [0 ... {name}_REGS_NO - 1] = {{ \\\n"
+    out += '            .name = "", \\\n'
+    out += "            .addr = -1, \\\n"
+    out += "        }, \\\n"
+    for reg in periph.registers:
+        reg_name, reg_array_size = get_register_array_name_and_size(reg)
+        if reg_array_size > 1:
+            for idx in range(0, reg_array_size):
+                out += f"        [R_{name}_{reg_name}{idx}] = {{ \\\n"
+                addr = reg.addressOffset + idx * reg.size // 8
+                out += f'            .name = "{reg_name}{idx}", \\\n'
+                out += f"            .addr = 0x{addr:X}, \\\n"
+                out += f"            .ro = 0x{create_romask(reg):X}, \\\n"
+                out += f"            .reset = 0x{reg.resetValue:X}, \\\n"
+                out += "        }, \\\n"
+        else:
+            out += f"        [R_{name}_{reg_name}] = {{ \\\n"
+            out += f'            .name = "{reg_name}", \\\n'
+            out += f"            .addr = 0x{reg.addressOffset:X}, \\\n"
+            out += f"            .ro = 0x{create_romask(reg):X}, \\\n"
+            out += f"            .reset = 0x{reg.resetValue:X}, \\\n"
+            out += "        }, \\\n"
+    out += "    }\n"
+
+    return out
+
+
+def generate_peripheral_header(periph, name):
+    """Generate peripheral header
+
+    The following information is generated:
+
+    * typedef with all of the available registers and register fields,
+    position and mask defines for register fields.
+
+    * enum values that encode register fields options.
+
+    * a macro that defines the register names indexed by the relative
+    address of the register.
+
+    * a function that sets the registers to their reset values
+
+    """
+
+    out = generate_registers(name, periph)
+
+    out += generate_enum_values(name, periph)
+
+    out += generate_register_access_info(name, periph)
+
+    return out
+
+
+def get_same_class_peripherals(svd, periph):
+    """Get a list of peripherals that are instances of the same class."""
+
+    return [periph] + [
+        p
+        for p in svd.peripherals
+        if p.derivedFrom and p.derivedFrom.name == periph.name
+    ]
+
+
+def generate_system_header(system, svd, periph):
+    """Generate base and irq defines for given list of peripherals"""
+
+    out = ""
+
+    for p in get_same_class_peripherals(svd, periph):
+        out += f"#define {system}_{p.name}_BASE 0x{p.baseAddress:X}UL\n"
+    out += "\n"
+
+    for p in get_same_class_peripherals(svd, periph):
+        for irq in p.interrupts:
+            out += f"#define {system}_{irq.name}_IRQn 0x{irq.value}UL\n"
+    out += "\n"
+
+    return out
+
+
+def main():
+    """Script to generate C header file from an SVD file"""
+
+    parser = argparse.ArgumentParser()
+    parser.add_argument(
+        "-i", "--input", type=str, help="Input SVD file", required=True
+    )
+    parser.add_argument(
+        "-o", "--output", type=str, help="Output .h file", required=True
+    )
+    parser.add_argument(
+        "-p",
+        "--peripheral",
+        action="append",
+        help="peripheral name from the SVD file",
+        required=True,
+    )
+    parser.add_argument(
+        "-t",
+        "--type-name",
+        type=str,
+        help="name to be used for peripheral definitions",
+        required=False,
+    )
+    parser.add_argument(
+        "-s",
+        "--system",
+        type=str,
+        help="name to be used for the system definitions",
+        required=False,
+    )
+
+    args = parser.parse_args()
+
+    node = xml.etree.ElementTree.parse(args.input).getroot()
+    svd = pysvd.element.Device(node)
+
+    # Write license header
+    header = svd.licenseText.strip()
+    header += f"\n\nAutomatically generated by {os.path.basename(__file__)} "
+    header += f"from {os.path.basename(args.input)}"
+    out = generate_comment(0, header)
+
+    # Write some generic defines
+    out += "#pragma once\n\n"
+
+    for name in args.peripheral:
+        periph = svd.find(name)
+        if periph:
+            if args.system:
+                out += generate_system_header(args.system, svd, periph)
+            else:
+                out += '#include "hw/register.h"\n\n'
+                out += '#include "hw/registerfields.h"\n\n'
+                out += generate_peripheral_header(
+                    periph, args.type_name if args.type_name else periph.name
+                )
+        else:
+            print(f"No such peripheral: {name}")
+            return 1
+
+    with open(args.output, "w", encoding="ascii") as output:
+        output.write(out)
+
+    return 0
+
+
+if __name__ == "__main__":
+    sys.exit(main())
-- 
2.46.0.295.g3b9ea8a38a-goog


