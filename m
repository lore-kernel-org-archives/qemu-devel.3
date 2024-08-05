Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAD9C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb498-000229-Po; Mon, 05 Aug 2024 16:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3VTOxZgUKCrwvcxkriqqing.eqosgow-fgxgnpqpipw.qti@flex--tavip.bounces.google.com>)
 id 1sb497-0001vq-4S
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:33 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3VTOxZgUKCrwvcxkriqqing.eqosgow-fgxgnpqpipw.qti@flex--tavip.bounces.google.com>)
 id 1sb493-0001Op-Kd
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:32 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e0b3d35ccfbso14931894276.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 13:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722889047; x=1723493847; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZwJD/lgjO5kdqyhD8RpYuIvdatMPOMP/3LVoVmWvMSk=;
 b=hT7tLvCBrX28weZ43Gh3Vrt5LtM3k3GY0L6PUfG4xBpf/WMA3KA3C4TjRy1CFOtzBs
 n+TFcHbCu1vgguOSFvn/AqABMbZ7aGyRs9SmqFAgl1ZA2bUiyHtxE/6MFfzrHVO7iad/
 Mn6WOnSGKkai/ltSNtYE1IvUovjiCYGm0P1wDNjX61UyaUDVQDZf+BY5rYxyDkmq+puj
 3tShcmo01NoajcTa+kO2dBMtek2ePeMeon8iQKBxlby3rwy7wTRhD7q1mtkggoi6b3Jm
 lhJby44J26ad3dCvtu2I3oeCjNidRRmMy+Fji6Qbz7FDf48CSN0Mkpy+d6RpvhxtyQsJ
 psug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722889047; x=1723493847;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZwJD/lgjO5kdqyhD8RpYuIvdatMPOMP/3LVoVmWvMSk=;
 b=UefI3HGcmG3bE412czofCKsYO373cKjfQEVnSD0mQX15DZE9i11bGo2DUlxWz/kTB/
 XMqX7NQzYOXVvzBLvCAH4c1pc5Yhwrbx6m1OgwTaHIgiRz5I1yhlVJmYeNBfCoPxGfD2
 Fxgs7en/g6IalZpyOEjK0cLtM7Bu4Tm4uylyQkLFPPZ6rgKOtfhQ29rnSo38ivS3/B9X
 bbYNXVGOiFlDUUYJa5KlLYX+k9jb0+wPcQIiQgUFoZrqYFUUmPhVaeQiJ5WnRSwm8ogx
 vdhKOjlz1BCq+HRLIXS4w871mcPzjFexmOs2w5RHcdIoe7/Mr1jcmfCPZIPZKEUylPX3
 5NmA==
X-Gm-Message-State: AOJu0YwdON3h762IL9H4Wcv1LsfvCcs+pEtuAa07l+Lmcbms4DwrVL7u
 gcL5LZcAKNRNVRz0uR8DO1VDjbjdB+Wy7LPFsEXnXeGZOJ3SscMYGORgd76Gu5gzp5DlpOw1FWD
 50wUjmvZ56KYFM55Xik2jCUvbn1V2z6sb9i9ghoB/X4qD9VBk+rha+tMAb6kPnmMjtO1Xkswynl
 3TEtRPUDrLDov1rwH69+T1GnhjUA==
X-Google-Smtp-Source: AGHT+IHPWqYjn9MimH1P+Pyv+53F84pwYNK/yl/0rbjY4BL7b9DkAH4O74JY5ubkLMkSpdZVYH0QgxujeQ==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6902:2b8a:b0:e03:2217:3c8f
 with SMTP id
 3f1490d57ef6-e0bde21f848mr21913276.2.1722889045783; Mon, 05 Aug 2024 13:17:25
 -0700 (PDT)
Date: Mon,  5 Aug 2024 13:16:58 -0700
In-Reply-To: <20240805201719.2345596-1-tavip@google.com>
Mime-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201719.2345596-4-tavip@google.com>
Subject: [RFC PATCH 03/23] scripts: add script to generate C header files from
 SVD XML files
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3VTOxZgUKCrwvcxkriqqing.eqosgow-fgxgnpqpipw.qti@flex--tavip.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Stefan Stanacar <stefanst@google.com>

The CMSIS System View Description format(CMSIS-SVD) is an XML based
description of Arm Cortex-M microcontrollers provided and maintained
by sillicon vendors. It includes details such as peripherals registers
(down to bitfields), peripheral register block addresses, reset
values, etc.

This script uses this information to create header files that makes it
easier to emulate peripherals.

The script can be used to create either peripheral specific headers or
board / system specific information. The script generated headers are
similar to the SVDConv utility.

Peripheral specific headers contains information such as register
layout, register names and reset values for registers:

  typedef struct {
    ...
    union {
      uint32_t PSELID;              /* 0x00000FF8 Peripheral Select and
                                     * Flexcomm module ID */
      struct {
        uint32_t PERSEL : 3;        /* [2..0] Peripheral Select */
        uint32_t LOCK : 1;          /* [3..3] Lock the peripheral select */
        uint32_t USARTPRESENT : 1;  /* [4..4] USART present indicator */
        uint32_t SPIPRESENT : 1;    /* [5..5] SPI present indicator */
        uint32_t I2CPRESENT : 1;    /* [6..6] I2C present indicator */
        uint32_t I2SPRESENT : 1;    /* [7..7] I2S Present */
        uint32_t : 4;
        uint32_t ID : 20;           /* [31..12] Flexcomm ID */
      } PSELID_b;
    };
    ...
  } FLEXCOMM_Type;                  /* Size = 4096 (0x1000) */

  #define FLEXCOMM_PSELID_PERSEL_Pos (0UL)
  #define FLEXCOMM_PSELID_PERSEL_Msk (0x7UL)
  #define FLEXCOMM_PSELID_LOCK_Pos (3UL)
  #define FLEXCOMM_PSELID_LOCK_Msk (0x8UL)
  ...

  typedef enum {                /* FLEXCOMM_PSELID_LOCK */
    /* Peripheral select can be changed by software. */
    FLEXCOMM_PSELID_LOCK_UNLOCKED = 0,
    /* Peripheral select is locked and cannot be changed until this
     * Flexcomm module or the entire device is reset. */
    FLEXCOMM_PSELID_LOCK_LOCKED = 1,
  } FLEXCOMM_PSELID_LOCK_Enum;
  ...

  #define FLEXCOMM_REGISTER_NAMES_ARRAY(_name) \
    const char *_name[sizeof(FLEXCOMM_Type)] = { \
        [4088 ... 4091] = "PSELID", \
        [4092 ... 4095] = "PID", \
    }

Board specific headers contains information about peripheral base
register addresses.

Signed-off-by: Stefan Stanacar <stefanst@google.com>
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 configure                 |   2 +-
 meson.build               |   4 +
 python/setup.cfg          |   1 +
 python/tests/minreqs.txt  |   3 +
 pythondeps.toml           |   3 +
 scripts/svd-gen-header.py | 342 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 354 insertions(+), 1 deletion(-)
 create mode 100755 scripts/svd-gen-header.py

diff --git a/configure b/configure
index 5ad1674ca5..811bfa5d54 100755
--- a/configure
+++ b/configure
@@ -956,7 +956,7 @@ mkvenv="$python ${source_path}/python/scripts/mkvenv.py"
 # Finish preparing the virtual environment using vendored .whl files
 
 $mkvenv ensuregroup --dir "${source_path}/python/wheels" \
-     ${source_path}/pythondeps.toml meson || exit 1
+     ${source_path}/pythondeps.toml meson svd-gen-header || exit 1
 
 # At this point, we expect Meson to be installed and available.
 # We expect mkvenv or pip to have created pyvenv/bin/meson for us.
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
diff --git a/python/setup.cfg b/python/setup.cfg
index 48668609d3..bc830c541a 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -45,6 +45,7 @@ devel =
     urwid >= 2.1.2
     urwid-readline >= 0.13
     Pygments >= 2.9.0
+    pysvd >= 0.2.3
 
 # Provides qom-fuse functionality
 fuse =
diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index a3f423efd8..7993fcd23c 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -22,6 +22,9 @@ distlib==0.3.6
 # Dependencies for FUSE support for qom-fuse
 fusepy==2.0.4
 
+# Dependencies for svd-gen-regs
+pysvd==0.2.3
+
 # Test-runners, utilities, etc.
 avocado-framework==90.0
 
diff --git a/pythondeps.toml b/pythondeps.toml
index 9c16602d30..8416b17650 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -32,3 +32,6 @@ sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.1.1" }
 # avocado-framework, for example right now the limit is 92.x.
 avocado-framework = { accepted = "(>=88.1, <93.0)", installed = "88.1", canary = "avocado" }
 pycdlib = { accepted = ">=1.11.0" }
+
+[svd-gen-header]
+pysvd = { accepted = ">=0.2.3.", installed = "0.2.3" }
diff --git a/scripts/svd-gen-header.py b/scripts/svd-gen-header.py
new file mode 100755
index 0000000000..ab8cb4b665
--- /dev/null
+++ b/scripts/svd-gen-header.py
@@ -0,0 +1,342 @@
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
+import datetime
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
+def get_register_array_name_and_size(register):
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
+    split = re.split(r"[\[\]]", register.name)
+    return (split[0], int(split[1]) if len(split) > 1 else 0)
+
+
+def generate_register(register):
+    """Generate register data.
+
+    This include a field for accessing the full 32bits as we as
+    bitfield based register fields.
+
+    """
+
+    data_type = data_type_by_bits[register.size]
+
+    out = f"    /* 0x{register.addressOffset:08X} {register.description} */\n"
+    out += "    union {\n"
+    out += f"        {data_type} {register.name};\n"
+    out += "        struct {\n"
+
+    fields = sorted(register.fields, key=lambda field: field.bitOffset)
+    last_msb = -1
+    for field in fields:
+        reserve_bits = 0
+        lsb = field.bitOffset
+        msb = field.bitWidth + lsb - 1
+
+        if last_msb == -1 and lsb > 0:
+            reserve_bits = lsb
+
+        if last_msb != -1 and (lsb - last_msb) > 1:
+            reserve_bits = lsb - last_msb - 1
+
+        if reserve_bits > 0:
+            out += f"            {data_type}:{reserve_bits};\n"
+
+        out += f"            /* [{msb}..{lsb}] {field.description} */\n"
+        out += f"            {data_type} {field.name} : {field.bitWidth};\n"
+
+        last_msb = msb
+
+    if register.size - last_msb > 1:
+        out += f"            {data_type}:{register.size - last_msb - 1};\n"
+
+    reg_name, reg_array_size = get_register_array_name_and_size(register)
+    if reg_array_size > 0:
+        out += f"        }} {reg_name}_b[{reg_array_size}];\n"
+    else:
+        out += f"        }} {reg_name}_b;\n"
+    out += "    };\n\n"
+
+    return out
+
+
+def generate_pos_and_msk_defines(name, periph):
+    """Generate Pos and Msk defines"""
+
+    out = "\n"
+    for reg in periph.registers:
+        for field in reg.fields:
+            reg_name, _ = get_register_array_name_and_size(reg)
+            field_name = f"{name}_{reg_name}_{field.name}"
+            out += f"#define {field_name}_Pos ({field.bitOffset}UL)\n"
+            mask = ((1 << field.bitWidth) - 1) << field.bitOffset
+            out += f"#define {field_name}_Msk (0x{mask:x}UL)\n"
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
+                out += "\n"
+                out += "typedef enum {\n"
+                for enum in field.enumeratedValues.enumeratedValues:
+                    enum_name = f"{name}_{reg_name}_{field.name}_{enum.name}"
+                    out += f"    /* {enum.description} */\n"
+                    out += f"    {enum_name} = {enum.value},\n"
+                out += f"}} {name}_{reg_name}_{field.name}_Enum;\n"
+
+    return out
+
+
+def generate_register_names_array_macro(name, periph):
+    """Generate register names array macro"""
+
+    out = f"#define {name}_REGISTER_NAMES_ARRAY(_name) \\\n"
+    out += f"    const char *_name[sizeof({name}_Type)] = {{ \\\n"
+    for reg in periph.registers:
+        reg_name, reg_array_size = get_register_array_name_and_size(reg)
+        if reg_array_size > 0:
+            for i in range(0, reg_array_size):
+                start = reg.addressOffset + i * reg.size // 8
+                stop = reg.addressOffset + (i + 1) * reg.size // 8 - 1
+                out += f'        [{start} ... {stop}] = "{reg_name}{i}", \\\n'
+        else:
+            start = reg.addressOffset
+            stop = reg.addressOffset + reg.size // 8 - 1
+            out += f'        [{start} ... {stop}] = "{reg.name}", \\\n'
+    out += "    }\n"
+
+    return out
+
+
+def generate_reset_registers_function(name, periph):
+    """Generate reset registers function"""
+
+    out = "\n"
+    fname = f"{name.lower()}_reset_registers"
+    out += f"static inline void {fname}({name}_Type *regs)\n"
+    out += "{\n"
+    for reg in periph.registers:
+        reg_name, reg_array_size = get_register_array_name_and_size(reg)
+        if reg_array_size > 0:
+            for i in range(0, int(reg_array_size)):
+                out += f"    regs->{reg_name}[{i}] = {hex(reg.resetValue)};\n"
+        else:
+            out += f"    regs->{reg_name} = {hex(reg.resetValue)};\n"
+    out += "}\n"
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
+    out = f"/* {name} - {periph.description} */\n\n"
+    out += "typedef struct {\n"
+
+    last_reg_offset = 0
+    cnt = 0
+    for reg in periph.registers:
+        reserved_words = 0
+        if (reg.addressOffset - last_reg_offset) > 0:
+            reserved_words = int((reg.addressOffset - last_reg_offset) // 4)
+            cnt += 1
+
+        if cnt:
+            show_count = cnt
+        else:
+            show_count = ""
+
+        if reserved_words == 1:
+            out += f"    uint32_t RESERVED{show_count};\n\n"
+        elif reserved_words > 1:
+            out += f"    uint32_t RESERVED{show_count}[{reserved_words}];\n\n"
+
+        out += generate_register(reg)
+        last_reg_offset = reg.addressOffset + reg.size // 8
+
+    size = periph.addressBlocks[0].size
+    out += f"}} {name}_Type; /* Size = {size} (0x{size:X}) */\n"
+
+    out += "\n\n"
+
+    out += generate_pos_and_msk_defines(name, periph)
+
+    out += generate_enum_values(name, periph)
+
+    out += generate_register_names_array_macro(name, periph)
+
+    out += generate_reset_registers_function(name, periph)
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
+    out = "/*\n"
+    license_text = svd.licenseText.split("\\n")
+    for line in license_text:
+        sline = f" * {line.strip()}"
+        out += f"{sline.rstrip()}\n"
+
+    now = datetime.datetime.utcnow().strftime("%Y-%m-%d %H:%M:%S")
+    out += f" * @note Automatically generated by {os.path.basename(__file__)}"
+    out += f" on {now} UTC from {os.path.basename(args.input)}.\n"
+    out += " *\n */\n\n"
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
2.46.0.rc2.264.g509ed76dc8-goog


