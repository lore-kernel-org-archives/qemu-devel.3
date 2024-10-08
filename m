Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3479CED24E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyt0-0008PT-Ui; Mon, 07 Oct 2024 21:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3g4gEZwUKCuQZGbOVMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--tavip.bounces.google.com>)
 id 1sxysT-0007ho-MG
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:06 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3g4gEZwUKCuQZGbOVMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--tavip.bounces.google.com>)
 id 1sxysR-00007M-8F
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:05 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-690404fd230so29853237b3.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 18:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728350340; x=1728955140; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=mOjYfJjVDbekrSS0dJ0e0WrdZI53XB9lrt52zwVXgdE=;
 b=sGyscZBvjMn8mHYUvroZ7MhL/wGAbDcDA8xQP0KsuzCzGssc8MWlpeZuqCyR68uh4r
 R3S0cJ8GYlzqbXdMFuNTtvOhUIwfFEZrYxV2yiNhHTG62qBdDCwspzAczEpotJPYjh7/
 0N7Bmss8EDN4AO9sdWPgVWFd52g+LQsZkMIGhoWvjYnddexxcfMit2A/jzdzrQ1+XW5M
 W86TRatIO5v3B97PpGLn8Ah85vb53O8+//MCYIGr7iRSvLQsIx8HWG7QGFusvS6b9C5j
 8o1fxuiGAyvcHreJuhBpk3ePcPAwxpDbmNm5sWMWzzZUfTCUU3YmclQp5L5PzIiJmYms
 X2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350340; x=1728955140;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mOjYfJjVDbekrSS0dJ0e0WrdZI53XB9lrt52zwVXgdE=;
 b=TWF8zr2/Xq2SrYMYOPoXYoXiqqKWfKrX14BZaKvqu0i3IE3GE7cLHY6iBnzSuNkK1O
 EIIPRlNw1gYrFB5iuLPsKnWzrdPNCUKW3abB0YH8ijRpO+jRmLRjtVUTMK9z7v87ekCv
 oW1GIvP1+Au6GtbzwiBMt3HlGtZ7xMBEJU2iLuN7MOviNsUtkjTJg2H0EMmw/rk5w7bp
 sP0yxO7mwnY70BYlDFQVU5HXX1husETpnRq5mXlWcqCHzP6qERfgUekwVrk0hnjX2nrM
 cP+N9AV46amOP5CBeI1DBfgIYJ70Ey8Ry3im3xjuwT1aKJe3eXRIAvZKkQ16f/xEPt7p
 0/sQ==
X-Gm-Message-State: AOJu0YwitT7ibLwZyJB6kgVDfrg99W3SWSb110ChW2gw4MtGP3MEQvIG
 Usoil5FpyFmG7A2fYqLWn+wIIF6vvpVuxcZ9yc+Kld8NfjnMNdW6tauqmRZg4etCfiCN7ymEYbF
 av6uvTSTYFE9yUIdeIXUAlX9yexFvtGo/5M66pciynHeUPLdSEUdhg0WcLhp5talBun5VlQ1Eb4
 SjLRzmns/cTwA2l7QZSE+QRWGIYA==
X-Google-Smtp-Source: AGHT+IFXNoRKMbcr5g2Ch81E0fEb4jgg81eW3pnVWasxIKvPPjCZ2FzJEeKEMLdRIVBw6AvbjS4oRQIz9g==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a25:68ca:0:b0:e28:8f2c:73e6 with
 SMTP id
 3f1490d57ef6-e289391ea39mr8605276.7.1728350339603; Mon, 07 Oct 2024 18:18:59
 -0700 (PDT)
Date: Mon,  7 Oct 2024 18:18:29 -0700
In-Reply-To: <20241008011852.1439154-1-tavip@google.com>
Mime-Version: 1.0
References: <20241008011852.1439154-1-tavip@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008011852.1439154-4-tavip@google.com>
Subject: [PATCH v2 03/25] scripts: add script to generate C header files from
 SVD XML files
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3g4gEZwUKCuQZGbOVMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--tavip.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.024,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
  /* No peripheral selected. */
  #define FLEXCOMM_PSELID_PERSEL_NO_PERIPH_SELECTED 0
  /* USART function selected */
  #define FLEXCOMM_PSELID_PERSEL_USART 1
  /* SPI function selected */
  #define FLEXCOMM_PSELID_PERSEL_SPI 2
  /* I2C */
  #define FLEXCOMM_PSELID_PERSEL_I2C 3
  /* I2S Transmit */
  #define FLEXCOMM_PSELID_PERSEL_I2S_TRANSMIT 4
  /* I2S Receive */
  #define FLEXCOMM_PSELID_PERSEL_I2S_RECEIVE 5
  ...

  #define FLEXCOMM_REGISTER_ACCESS_INFO_ARRAY(_name) \
    struct RegisterAccessInfo _name[FLEXCOMM_REGS_NO] = { \
      [0 ... FLEXCOMM_REGS_NO -1] = { \
        .name = "", \
        .addr = -1, \
      }, \
      [0x3FE] = { \
        .name = "PSELID", \
        .addr = 0xFF8, \
        .ro = 0xFFFFFFF0, \
        .reset = 0x101000, \
      }, \
      [0x3FF] = { \
        .name = "PID", \
        .addr = 0xFFC, \
        .ro = 0xFFFFFFFF, \
        .reset = 0x0, \
      }, \
    }

The script has options to control which registers and fields should be
generated.

Board specific headers contains information about peripheral base
register addresses.

Signed-off-by: Stefan Stanacar <stefanst@google.com>
[tavip: pylint fixes, generate layout with qemu register fields
instead of bitfields, generate register names, romask and reset values,
add options to control which register and fields are generated]
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 meson.build               |   4 +
 scripts/svd-gen-header.py | 415 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 419 insertions(+)
 create mode 100755 scripts/svd-gen-header.py

diff --git a/meson.build b/meson.build
index 33954b3eba..5127e67d93 100644
--- a/meson.build
+++ b/meson.build
@@ -3330,6 +3330,10 @@ tracetool_depends = files(
   'scripts/tracetool/__init__.py',
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
index 0000000000..7befa75421
--- /dev/null
+++ b/scripts/svd-gen-header.py
@@ -0,0 +1,415 @@
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
+import fnmatch
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
+def get_fields(reg, dictionary):
+    """Return a list of fields from a register indexed dictionary.
+
+    The dictionary keys may contain wildcards.
+
+    """
+
+    for key in dictionary.keys():
+        if fnmatch.fnmatch(reg, key):
+            return dictionary[key]
+    return None
+
+
+def generate_reg(reg, dictionary):
+    """Check if the register should be generated"""
+
+    if get_fields(reg, dictionary):
+        return True
+    return False
+
+
+def skip_reg(reg, dictionary):
+    """Check if the register should be skipped"""
+
+    for key in dictionary.keys():
+        if fnmatch.fnmatch(reg, key) and dictionary[key] is None:
+            return True
+    return False
+
+
+def match_field(reg, field, dictionary):
+    """Match a register and field in a dictionary indexed by registers
+    that contains a list of fields.
+
+    Both the dictionary keys and the list of fields may contain wildcards.
+
+    """
+    fields = get_fields(reg, dictionary)
+    if not fields:
+        return False
+    for f in fields:
+        if fnmatch.fnmatch(field, f):
+            return True
+    return False
+
+
+def generate_field(name, reg_name, field, shared):
+    """Generate register field."""
+
+    out = generate_comment(0, field.description)
+    if shared:
+        out += "SHARED_"
+    out += f"FIELD({name}_{reg_name}, {field.name}, "
+    out += f"{field.bitOffset}, {field.bitWidth});\n"
+    if hasattr(field, "enumeratedValues") and field.bitWidth > 1:
+        for enum in field.enumeratedValues.enumeratedValues:
+            enum_name = f"{name}_{reg_name}_{field.name}_{enum.name}"
+            out += generate_comment(0, enum.description)
+            out += f"#define {enum_name} {enum.value}\n"
+    return out
+
+
+def generate_registers(name, periph, generate, skip):
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
+        reg_name, reg_array_size = get_register_array_name_and_size(reg)
+        if not generate_reg(reg_name, generate):
+            continue
+        if skip_reg(reg_name, skip):
+            continue
+        out += generate_comment(0, reg.description)
+        if reg_array_size > 1:
+            for idx in range(0, reg_array_size):
+                addr = reg.addressOffset + idx * reg.size // 8
+                out += f"REG32({name}_{reg_name}{idx}, 0x{addr:X});\n"
+        else:
+            addr = reg.addressOffset
+            out += f"REG32({name}_{reg_name}, 0x{addr:X});\n"
+        for field in reg.fields:
+            if not match_field(reg_name, field.name, generate):
+                continue
+            if match_field(reg_name, field.name, skip):
+                continue
+            out += generate_field(
+                name, reg_name, field, True if reg_array_size > 1 else False
+            )
+        out += "\n"
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
+                addr = reg.addressOffset + idx * reg.size // 8
+                out += f"        [0x{addr // 4:X}] = {{ \\\n"
+                out += f'            .name = "{reg_name}{idx}", \\\n'
+                out += f"            .addr = 0x{addr:X}, \\\n"
+                out += f"            .ro = 0x{create_romask(reg):X}, \\\n"
+                out += f"            .reset = 0x{reg.resetValue:X}, \\\n"
+                out += "        }, \\\n"
+        else:
+            out += f"        [0x{reg.addressOffset // 4:X}] = {{ \\\n"
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
+def generate_peripheral_header(periph, name, args):
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
+    generate = {}
+    for reg in args.fields.split():
+        if reg.find(":") > 0:
+            reg, fields = reg.split(":")
+            generate[reg] = fields.split(",")
+        else:
+            generate[reg] = ["*"]
+
+    skip = {}
+    for reg in args.no_fields.split():
+        if reg.find(":") > 0:
+            reg, fields = reg.split(":")
+            skip[reg] = fields.split(",")
+        else:
+            skip[reg] = None
+
+    out = generate_registers(name, periph, generate, skip)
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
+    parser.add_argument(
+        "--fields",
+        help="list of registers and fields that should be generated "
+        "in the following format 'REG[:FIELDS] ...' "
+        "where FIELDS is a list of comma separated fields that can be "
+        "empty; both regsiters and fields can be matched with wildcards; "
+        "'REG' is an alias for 'REG:*';",
+        required=False,
+        default="*:*",
+    )
+    parser.add_argument(
+        "--no-fields",
+        type=str,
+        help="list of register and fields that should not be generated "
+        "in the following format 'REG[:FIELDS] ...' "
+        "where FIELDS is a list of comma separated fields that can be "
+        "empty; both regsiters and fields can be matched with wildcards; "
+        "note that 'REG' will not generate neither the register nor its "
+        "fields while REG: will generate the register but none of its fields",
+        required=False,
+        default=":",
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
+                out += generate_peripheral_header(
+                    periph,
+                    args.type_name if args.type_name else periph.name,
+                    args,
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
2.47.0.rc0.187.ge670bccf7e-goog


