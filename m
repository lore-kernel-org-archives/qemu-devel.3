Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28238CD3445
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 15:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slVdb-0002EZ-Dm; Tue, 03 Sep 2024 11:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slVda-0002AG-9p
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:40:10 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slVdX-0006Mo-TC
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:40:10 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42c2e50ec13so29708375e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 08:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725378006; x=1725982806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YmFP7qxHZAeN5GH61EDlt1S9+An3S8nE9csQzpz0GyQ=;
 b=j8jAWLEadcwMWgaYAX/vDyOZdWOVRwql0Q+CqRexklAvMY9R/lf+NDblVqcX2ykQR7
 xO0eGAgFMZINU3TlWAVMnG6RZX5AQvyJ4OgCi+UFkwVqiAh1BuMyMpEUH+CGoV6oi9yX
 2hd7vyOOxqXtOZ3hr3sA0iviFcclUusOOuzWdMkdHY2vTG99OJ45WrXSj6a7hqKE7C3o
 fWxY//unCg9WSCH5JxOAhGy8i66EKvg58tkseL7U0tAbsT5L1wcILtGUVHo60/esD0w8
 3itPiVF4TtLGlvfXR+gXEF9DbWl9hys4zoa+O8NQ3PPOg0Onw7iqPTlQZHQ97p8EO4pi
 kIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725378006; x=1725982806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YmFP7qxHZAeN5GH61EDlt1S9+An3S8nE9csQzpz0GyQ=;
 b=WMTVfXasOFPD63yb60kPn/ZjLIgWCHkRXJNqr7Walyuk2Gk5zR7zQr+St9QrddX2l3
 IXdn6QqSy55/wcp5TL1JUEMPyfFlP6YsLbpHzkQSLSCAjISWT2X9wPyTMPyUXjgU1nRp
 uMYcYFc9afd8OADRsCVUqz7BQxprHaw6BroD/3Blv9YwBQ85lIOPwoZqEWFOphV8djzD
 rAQnnWI49478MT0ivobl8c0SpxK39vFOoD271Q4DvlAIsQRRk2DzgAUBZGhakCv++j+Y
 S6oFDgTnLFUg19ssUJkpxdtdbIOdyRLYIMWL892NJgyhMhkyjKV29Edn456CrHYipuhe
 dfew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFbHQZWJBYHq6rRUbh9UT0VA8+g2HnCf3z6coo3agwn0zRsUcHcU+3qFN7/cXqj3KuVQlalJSXuV5x@nongnu.org
X-Gm-Message-State: AOJu0YzWQbctvgbRmsUCy0Y6l1QB726cMjKHUoUZHNx+RkRmVoOiaNld
 iU35hSVESlrSYRSQ9+67nxmvNchSgmj25EuFlYpMBSgRjxHklqjgVIwuPM8OlSo=
X-Google-Smtp-Source: AGHT+IFTriD7h+oHIYpEIeNtLSMNe24G1bCrHy5prf7RaKqK2Dvwz4cWCPU4sohKbKVSF7z6lUtFWQ==
X-Received: by 2002:a05:600c:4683:b0:427:ac40:d4b1 with SMTP id
 5b1f17b1804b1-42bbb436e2emr107038485e9.27.1725378005915; 
 Tue, 03 Sep 2024 08:40:05 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df0f36sm175700385e9.16.2024.09.03.08.40.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Sep 2024 08:40:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Samuel Tardieu <sam@rfc1149.net>,
	qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Magnus Damm <magnus.damm@gmail.com>,
 qemu-block@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] hw/sh4: Remove the deprecated SHIX machine
Date: Tue,  3 Sep 2024 17:39:57 +0200
Message-ID: <20240903153959.18392-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240903153959.18392-1-philmd@linaro.org>
References: <20240903153959.18392-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 URIBL_SBL_A=0.1 autolearn=unavailable autolearn_force=no
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

The SHIX machine is deprecated since v9.0 (commit
322b038c94 "target/sh4: Deprecate the shix machine").
Time to remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                             |  7 +-
 docs/about/deprecated.rst               |  6 --
 docs/about/removed-features.rst         |  5 ++
 configs/devices/sh4-softmmu/default.mak |  1 -
 hw/sh4/shix.c                           | 86 -------------------------
 hw/sh4/Kconfig                          |  7 --
 hw/sh4/meson.build                      |  1 -
 7 files changed, 6 insertions(+), 107 deletions(-)
 delete mode 100644 hw/sh4/shix.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3584d6a6c6..c8e4e3329c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1676,16 +1676,11 @@ F: hw/timer/sh_timer.c
 F: include/hw/sh4/sh_intc.h
 F: include/hw/timer/tmu012.h
 
-Shix
+TC58128 NAND EEPROM
 R: Yoshinori Sato <ysato@users.sourceforge.jp>
 R: Magnus Damm <magnus.damm@gmail.com>
 S: Odd Fixes
 F: hw/block/tc58128.c
-F: hw/char/sh_serial.c
-F: hw/sh4/shix.c
-F: hw/intc/sh_intc.c
-F: hw/timer/sh_timer.c
-F: include/hw/sh4/sh_intc.h
 
 SPARC Machines
 --------------
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 88f0f03786..2020542a6b 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -232,12 +232,6 @@ These old machine types are quite neglected nowadays and thus might have
 various pitfalls with regards to live migration. Use a newer machine type
 instead.
 
-``shix`` (since 9.0)
-''''''''''''''''''''
-
-The machine is no longer in existence and has been long unmaintained
-in QEMU. This also holds for the TC51828 16MiB flash that it uses.
-
 ``pseries-2.1`` up to ``pseries-2.12`` (since 9.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index fc7b28e637..9eaf864004 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -978,6 +978,11 @@ Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (removed in 9.1)
 
 The Nios II architecture was orphan.
 
+``shix`` (removed in 9.2)
+'''''''''''''''''''''''''
+
+The machine was unmaintained.
+
 linux-user mode CPUs
 --------------------
 
diff --git a/configs/devices/sh4-softmmu/default.mak b/configs/devices/sh4-softmmu/default.mak
index c06a427053..aa821e4b60 100644
--- a/configs/devices/sh4-softmmu/default.mak
+++ b/configs/devices/sh4-softmmu/default.mak
@@ -7,4 +7,3 @@
 
 # Boards are selected by default, uncomment to keep out of the build.
 # CONFIG_R2D=n
-# CONFIG_SHIX=n
diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
deleted file mode 100644
index eb3150b5bc..0000000000
--- a/hw/sh4/shix.c
+++ /dev/null
@@ -1,86 +0,0 @@
-/*
- * SHIX 2.0 board description
- *
- * Copyright (c) 2005 Samuel Tardieu
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-/*
- * Shix 2.0 board by Alexis Polti, described at
- * https://web.archive.org/web/20070917001736/perso.enst.fr/~polti/realisations/shix20
- *
- * More information in target/sh4/README.sh4
- */
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "cpu.h"
-#include "hw/sh4/sh.h"
-#include "sysemu/qtest.h"
-#include "hw/boards.h"
-#include "hw/loader.h"
-#include "qemu/error-report.h"
-
-#define BIOS_FILENAME "shix_bios.bin"
-#define BIOS_ADDRESS 0xA0000000
-
-static void shix_init(MachineState *machine)
-{
-    int ret;
-    SuperHCPU *cpu;
-    struct SH7750State *s;
-    MemoryRegion *sysmem = get_system_memory();
-    MemoryRegion *rom = g_new(MemoryRegion, 1);
-    MemoryRegion *sdram = g_new(MemoryRegion, 2);
-    const char *bios_name = machine->firmware ?: BIOS_FILENAME;
-
-    cpu = SUPERH_CPU(cpu_create(machine->cpu_type));
-
-    /* Allocate memory space */
-    memory_region_init_rom(rom, NULL, "shix.rom", 0x4000, &error_fatal);
-    memory_region_add_subregion(sysmem, 0x00000000, rom);
-    memory_region_init_ram(&sdram[0], NULL, "shix.sdram1", 0x01000000,
-                           &error_fatal);
-    memory_region_add_subregion(sysmem, 0x08000000, &sdram[0]);
-    memory_region_init_ram(&sdram[1], NULL, "shix.sdram2", 0x01000000,
-                           &error_fatal);
-    memory_region_add_subregion(sysmem, 0x0c000000, &sdram[1]);
-
-    /* Load BIOS in 0 (and access it through P2, 0xA0000000) */
-    ret = load_image_targphys(bios_name, 0, 0x4000);
-    if (ret < 0 && !qtest_enabled()) {
-        error_report("Could not load SHIX bios '%s'", bios_name);
-        exit(1);
-    }
-
-    /* Register peripherals */
-    s = sh7750_init(cpu, sysmem);
-    /* XXXXX Check success */
-    tc58128_init(s, "shix_linux_nand.bin", NULL);
-}
-
-static void shix_machine_init(MachineClass *mc)
-{
-    mc->desc = "shix card";
-    mc->init = shix_init;
-    mc->is_default = true;
-    mc->default_cpu_type = TYPE_SH7750R_CPU;
-    mc->deprecation_reason = "old and unmaintained";
-}
-
-DEFINE_MACHINE("shix", shix_machine_init)
diff --git a/hw/sh4/Kconfig b/hw/sh4/Kconfig
index 99a76a94c3..1660d292d5 100644
--- a/hw/sh4/Kconfig
+++ b/hw/sh4/Kconfig
@@ -13,13 +13,6 @@ config R2D
     select SH7750
     select SH_PCI
 
-config SHIX
-    bool
-    default y
-    depends on SH4
-    select SH7750
-    select TC58128
-
 config SH7750
     bool
     select SH_INTC
diff --git a/hw/sh4/meson.build b/hw/sh4/meson.build
index 70e814c3a2..7d27839fee 100644
--- a/hw/sh4/meson.build
+++ b/hw/sh4/meson.build
@@ -4,6 +4,5 @@ sh4_ss.add(when: 'CONFIG_SH7750', if_true: files(
   'sh7750_regnames.c',
 ))
 sh4_ss.add(when: 'CONFIG_R2D', if_true: files('r2d.c'))
-sh4_ss.add(when: 'CONFIG_SHIX', if_true: files('shix.c'))
 
 hw_arch += {'sh4': sh4_ss}
-- 
2.45.2


