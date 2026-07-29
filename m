Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62BCC53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp2rk-0006BA-EX; Wed, 29 Jul 2026 07:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xinxie908@gmail.com>)
 id 1wp20f-000176-89
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:59:38 -0400
Received: from mail-pj2-x00.google.com ([2607:f8b0:4864:39::])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xinxie908@gmail.com>)
 id 1wp20c-0004D7-Of
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:59:37 -0400
Received: by mail-pj2-x00.google.com with SMTP id
 d9443c01a7336-2cc7a345f51so6685225ad.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 03:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785322772; x=1785927572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gQ5aFS2k3+LUcEAitcHN9BjMTSfVp18rofu2I0RU+Cw=;
 b=fatFcBc/AasBu5t9zv4X3KfMG9QzjQMMSeRBI/g5NkG2B9InjPDqPDXX8Nhracg0eH
 b6a+Shzv9aFlNSQXNHawPmg1TUnNDO/6mddXgEbDZb5WQMdynt80a4UXNnF871LDqSY0
 3usPb6pckTJe2iqohLpEa4X8+CXPQp43LuHDVag1l42Lb28Gv1syMyTb3KF8oxrMucg9
 61blWiEsgP6JIXC12SrhV2Jy1P87ljdO+fBt7grTSEldkjIkvInnKb3rkDD57rjVTJ17
 DAhD8G7Wb/do0V3p5Yu7yqHxR7U3ClZpeh4JlevfFyZJw8MdGCwflGXITKivpJUIZ+pZ
 kSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785322772; x=1785927572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gQ5aFS2k3+LUcEAitcHN9BjMTSfVp18rofu2I0RU+Cw=;
 b=tFvSTmEc9m3l5xIbJ4n2VeTq6nRElFg3rnje2EB2BHPLRwVzMyKzr6zELyslQIzuql
 mSU3NlMlyk1ofvFwrzaBdQcHzakPbI7+TWQLQnfFG55cLmhX7ACQY26Ciutw+tk3I8Wd
 dNOllvnVM9C+LJNjNCa9IZ4Bc8mM2zO39vJObZE448SsqApTx4+5QiqXcXoiu9iQ6IJb
 ew2C1uetMA37go3yvWdUinq5g4euNZxGnSqJWEB/kB3UJ3vvtPErq/nP7Rvq0MhhxJji
 PQ5tQXfZcNcVhNG6p6uW/xMpqsOsvVXNi7w9Rse6gR11OadJ3WugK4S339ciwPK5nH8T
 w9TQ==
X-Gm-Message-State: AOJu0Yy7wiw/EbDti1m0/aBfD6ZOgU9kmKnbDzNImIjMnb6D0sIAS63G
 ivcLpPtYmI+d0BU71xrtMuXTltKgdqUynSvAr8gAN9kkAEGiRqg7CPeRUzJein3E4knprw==
X-Gm-Gg: AR+sD112ID3+zFDlVKnP7ZxRez751yUCPJt3tQUpwctPAhDOF9ibR2VlOFNoHKAAJtT
 OU4FE3gI7/jvdf+KiyLc85K6VPKgxLSxCxPZYDraonw583ZV2zoF7DWX+Hvk65kCHDjO2E0CmwN
 BSVWXalmaGWQNBy678QcLJSRsLxpJq3HcDQdOjcDNlLaF4To/rwXknr9FwJRw67LNLTOJdm6a/J
 aFfx1lLAut7iCRvtVkPHTVOSJhzwToxX9aSmTM3bxj6tLSS/c00hTsZuLGC5OLznJsHE/pcK6f6
 lwh7NUpgqJli3EA+tHV3ZyJbpqrYuqxmabNkW4c8CZY7wOAU4xASEoRjGzRCE4Ox3g7qDMevtqw
 G7RhQauL6OffLX1SIRb3ZcE+hqR+m4dtgh1vRqDJffIhxJ29MvBqh9fI9Zb1qRaS5I1MsKlZ2rt
 CrOE41eKex53UYpKOhdnLRy7AuhMQn3Zeb51WYZZGYlp6kBxviiYf+fH7VEUlsRmGUE5dDZzqDP
 ysJXpLomg==
X-Received: by 2002:a17:903:3583:b0:2c9:c991:3bf0 with SMTP id
 d9443c01a7336-2d015b148d4mr68977195ad.8.1785322772229; 
 Wed, 29 Jul 2026 03:59:32 -0700 (PDT)
Received: from LAPTOP-LOCIFOSI.localdomain ([123.127.39.254])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bfa240sm9627135ad.65.2026.07.29.03.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 03:59:31 -0700 (PDT)
From: Xin Xie <xinxie908@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Xin Xie <xinxie908@gmail.com>
Subject: [PATCH v1 1/3] hw/sd: add Kendryte K230 SDHCI controller
Date: Wed, 29 Jul 2026 18:59:01 +0800
Message-ID: <20260729105904.272939-2-xinxie908@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729105904.272939-1-xinxie908@gmail.com>
References: <20260729105904.272939-1-xinxie908@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::;
 envelope-from=xinxie908@gmail.com; helo=mail-pj2-x00.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Jul 2026 07:54:22 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a minimal K230 SDHCI model based on the generic SDHCI model. Reuse
the generic commands and data paths while providing the extended register
layout and documented reset values.

K230 SDHCI controller contains the standard SDHCI register block followed
by preset, extension pointer, PHY and vendor-specific registers. This model
implements the preset and extension pointer registers as read-only, retain
writes to most PHY and vendor-specific registers, and keep PHY_PWRGOOD
asserted so that the K230 SDK reset sequence can complete.

The SDHCI version is set to 3 due to the absence of ADMA3 support in the
generic model.

Signed-off-by: Xin Xie <xinxie908@gmail.com>
---
 MAINTAINERS                |   2 +
 hw/sd/Kconfig              |   4 +
 hw/sd/k230_sdhci.c         | 311 +++++++++++++++++++++++++++++++++++++
 hw/sd/meson.build          |   1 +
 include/hw/sd/k230_sdhci.h |  82 ++++++++++
 5 files changed, 400 insertions(+)
 create mode 100644 hw/sd/k230_sdhci.c
 create mode 100644 include/hw/sd/k230_sdhci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6171cc7494..06285352c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1826,8 +1826,10 @@ S: Maintained
 F: docs/system/riscv/k230.rst
 F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
+F: hw/sd/k230_sdhci.c
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
+F: include/hw/sd/k230_sdhci.h
 F: tests/qtest/k230-wdt-test.c
 
 RX Machines
diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
index 633b9afec9..e9a5d63b4d 100644
--- a/hw/sd/Kconfig
+++ b/hw/sd/Kconfig
@@ -23,3 +23,7 @@ config SDHCI_PCI
 config CADENCE_SDHCI
     bool
     select SDHCI
+
+config K230_SDHCI
+    bool
+    select SDHCI
diff --git a/hw/sd/k230_sdhci.c b/hw/sd/k230_sdhci.c
new file mode 100644
index 0000000000..34c972a2f7
--- /dev/null
+++ b/hw/sd/k230_sdhci.c
@@ -0,0 +1,311 @@
+/*
+ * Kendryte K230 SDHCI controller
+ *
+ * Copyright (c) 2026 Xin Xie <xinxie908@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/sd/k230_sdhci.h"
+#include "hw/sd/sdhci-internal.h"
+#include "migration/vmstate.h"
+
+/*
+ * The TRM describes an SDHCI v4.20 DWC MSHC, including the v4 block-count
+ * mode, ADMA3, and extension-area registers.  QEMU's generic controller
+ * supports up to v3 and does not implement those v4 transfer semantics.
+ */
+#define K230_SDHCI_SPEC_VERSION 3
+
+/*
+ * K230's Capabilities registers describe more functionality than the generic
+ * QEMU SDHCI data path currently implements.  Do not expose the following TRM
+ * capabilities to the guest:
+ *
+ * - ASYNC_INT requires an SDIO card-interrupt input and asynchronous interrupt
+ *   signalling while the SD clock is stopped.  SDBus has no such input.
+ * - TIMER_RETUNING and RETUNING_MODE require a re-tuning timer and generation
+ *   of a re-tuning request.  The generic controller only completes an initial
+ *   command-based tuning operation; it never schedules periodic re-tuning.
+ * - ADMA3 requires the SDHCI v4.20 ADMA3 descriptor and command semantics,
+ *   whereas the generic controller implements SDMA and ADMA2 only.
+ */
+#define K230_SDHCI_CAPABILITIES_UNSUPPORTED \
+    (R_SDHC_CAPAB_ASYNC_INT_MASK | \
+     R_SDHC_CAPAB_TIMER_RETUNING_MASK | \
+     R_SDHC_CAPAB_RETUNING_MODE_MASK | \
+     R_SDHC_CAPAB_ADMA3_MASK)
+#define K230_SDHCI_CAPAREG_IMPLEMENTED \
+    (K230_SDHCI_CAPAREG_RESET & ~K230_SDHCI_CAPABILITIES_UNSUPPORTED)
+
+#define K230_LO8(value)     ((value) & 0xff)
+#define K230_HI8(value)     (((value) >> 8) & 0xff)
+
+static const uint8_t k230_sdhci_preset_reset[K230_SDHCI_PRESET_SIZE] = {
+    [K230_SDHCI_PRESET_INIT - K230_SDHCI_PRESET_BASE] =
+        K230_LO8(K230_SDHCI_PRESET_INIT_RESET),
+    [K230_SDHCI_PRESET_INIT - K230_SDHCI_PRESET_BASE + 1] =
+        K230_HI8(K230_SDHCI_PRESET_INIT_RESET),
+    [K230_SDHCI_PRESET_DEFAULT_SPEED - K230_SDHCI_PRESET_BASE] =
+        K230_LO8(K230_SDHCI_PRESET_DEFAULT_SPEED_RESET),
+    [K230_SDHCI_PRESET_DEFAULT_SPEED - K230_SDHCI_PRESET_BASE + 1] =
+        K230_HI8(K230_SDHCI_PRESET_DEFAULT_SPEED_RESET),
+    [K230_SDHCI_PRESET_HIGH_SPEED - K230_SDHCI_PRESET_BASE] =
+        K230_LO8(K230_SDHCI_PRESET_HIGH_SPEED_RESET),
+    [K230_SDHCI_PRESET_HIGH_SPEED - K230_SDHCI_PRESET_BASE + 1] =
+        K230_HI8(K230_SDHCI_PRESET_HIGH_SPEED_RESET),
+    [K230_SDHCI_PRESET_SDR12 - K230_SDHCI_PRESET_BASE] =
+        K230_LO8(K230_SDHCI_PRESET_SDR12_RESET),
+    [K230_SDHCI_PRESET_SDR12 - K230_SDHCI_PRESET_BASE + 1] =
+        K230_HI8(K230_SDHCI_PRESET_SDR12_RESET),
+    [K230_SDHCI_PRESET_SDR25 - K230_SDHCI_PRESET_BASE] =
+        K230_LO8(K230_SDHCI_PRESET_SDR25_RESET),
+    [K230_SDHCI_PRESET_SDR25 - K230_SDHCI_PRESET_BASE + 1] =
+        K230_HI8(K230_SDHCI_PRESET_SDR25_RESET),
+    [K230_SDHCI_PRESET_SDR50 - K230_SDHCI_PRESET_BASE] =
+        K230_LO8(K230_SDHCI_PRESET_SDR50_RESET),
+    [K230_SDHCI_PRESET_SDR50 - K230_SDHCI_PRESET_BASE + 1] =
+        K230_HI8(K230_SDHCI_PRESET_SDR50_RESET),
+    [K230_SDHCI_PRESET_SDR104 - K230_SDHCI_PRESET_BASE] =
+        K230_LO8(K230_SDHCI_PRESET_SDR104_RESET),
+    [K230_SDHCI_PRESET_SDR104 - K230_SDHCI_PRESET_BASE + 1] =
+        K230_HI8(K230_SDHCI_PRESET_SDR104_RESET),
+    [K230_SDHCI_PRESET_DDR50 - K230_SDHCI_PRESET_BASE] =
+        K230_LO8(K230_SDHCI_PRESET_DDR50_RESET),
+    [K230_SDHCI_PRESET_DDR50 - K230_SDHCI_PRESET_BASE + 1] =
+        K230_HI8(K230_SDHCI_PRESET_DDR50_RESET),
+};
+
+static uint64_t k230_sdhci_preset_read(void *opaque, hwaddr addr,
+                                      unsigned int size)
+{
+    return ldn_le_p(&k230_sdhci_preset_reset[addr], size);
+}
+
+static void k230_sdhci_preset_write(void *opaque, hwaddr addr, uint64_t value,
+                                   unsigned int size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "K230 SDHCI: write to read-only Preset Value register "
+                  "0x%03" HWADDR_PRIx "\n",
+                  K230_SDHCI_PRESET_BASE + addr);
+}
+
+static const MemoryRegionOps k230_sdhci_preset_ops = {
+    .read = k230_sdhci_preset_read,
+    .write = k230_sdhci_preset_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static const uint8_t k230_sdhci_pointer_reset[K230_SDHCI_POINTER_SIZE] = {
+    [K230_SDHCI_P_UHS2_SETTINGS - K230_SDHCI_POINTER_BASE] =
+        K230_LO8(K230_SDHCI_P_UHS2_SETTINGS_RESET),
+    [K230_SDHCI_P_UHS2_SETTINGS - K230_SDHCI_POINTER_BASE + 1] =
+        K230_HI8(K230_SDHCI_P_UHS2_SETTINGS_RESET),
+    [K230_SDHCI_P_UHS2_HOST_CAPAB - K230_SDHCI_POINTER_BASE] =
+        K230_LO8(K230_SDHCI_P_UHS2_HOST_CAPAB_RESET),
+    [K230_SDHCI_P_UHS2_HOST_CAPAB - K230_SDHCI_POINTER_BASE + 1] =
+        K230_HI8(K230_SDHCI_P_UHS2_HOST_CAPAB_RESET),
+    [K230_SDHCI_P_UHS2_TEST - K230_SDHCI_POINTER_BASE] =
+        K230_LO8(K230_SDHCI_P_UHS2_TEST_RESET),
+    [K230_SDHCI_P_UHS2_TEST - K230_SDHCI_POINTER_BASE + 1] =
+        K230_HI8(K230_SDHCI_P_UHS2_TEST_RESET),
+    [K230_SDHCI_P_EMBEDDED_CNTRL - K230_SDHCI_POINTER_BASE] =
+        K230_LO8(K230_SDHCI_P_EMBEDDED_CNTRL_RESET),
+    [K230_SDHCI_P_EMBEDDED_CNTRL - K230_SDHCI_POINTER_BASE + 1] =
+        K230_HI8(K230_SDHCI_P_EMBEDDED_CNTRL_RESET),
+    [K230_SDHCI_P_VENDOR_AREA1 - K230_SDHCI_POINTER_BASE] =
+        K230_LO8(K230_SDHCI_P_VENDOR_AREA1_RESET),
+    [K230_SDHCI_P_VENDOR_AREA1 - K230_SDHCI_POINTER_BASE + 1] =
+        K230_HI8(K230_SDHCI_P_VENDOR_AREA1_RESET),
+    [K230_SDHCI_P_VENDOR_AREA2 - K230_SDHCI_POINTER_BASE] =
+        K230_LO8(K230_SDHCI_P_VENDOR_AREA2_RESET),
+    [K230_SDHCI_P_VENDOR_AREA2 - K230_SDHCI_POINTER_BASE + 1] =
+        K230_HI8(K230_SDHCI_P_VENDOR_AREA2_RESET),
+};
+
+static uint64_t k230_sdhci_pointer_read(void *opaque, hwaddr addr,
+                                       unsigned int size)
+{
+    return ldn_le_p(&k230_sdhci_pointer_reset[addr], size);
+}
+
+static void k230_sdhci_pointer_write(void *opaque, hwaddr addr, uint64_t value,
+                                    unsigned int size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "K230 SDHCI: write to read-only pointer register "
+                  "0x%03" HWADDR_PRIx "\n",
+                  K230_SDHCI_POINTER_BASE + addr);
+}
+
+static const MemoryRegionOps k230_sdhci_pointer_ops = {
+    .read = k230_sdhci_pointer_read,
+    .write = k230_sdhci_pointer_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+/*
+ * K230 uses the standard SDHCI register set at offset zero, followed by
+ * UHS-II, DWC MSHC PHY, Embedded Control, and vendor-specific blocks. Most
+ * side effects of analogue PHY behaviors not simulated.
+ *
+ * PHY_PWRGOOD is the sole synthesized status bit.  Real hardware asserts it
+ * after PHY power and reset sequencing; the SDK driver polls it during every
+ * full controller reset.  A virtual PHY has no settling interval or failure
+ * condition, so the bit is permanently asserted and cannot be cleared by a
+ * guest write.
+ */
+static uint64_t k230_sdhci_fallback_read(void *opaque, hwaddr addr,
+                                        unsigned int size)
+{
+    K230SDHCIState *s = opaque;
+    uint64_t value = ldn_le_p(&s->fallback_regs[addr], size);
+
+    if (ranges_overlap(addr, size, K230_SDHCI_PHY_CNFG,
+                       sizeof(uint32_t)) && addr <= K230_SDHCI_PHY_CNFG) {
+        unsigned int shift = (K230_SDHCI_PHY_CNFG - addr) * 8;
+
+        value |= (uint64_t)K230_SDHCI_PHY_CNFG_PWRGOOD << shift;
+    }
+
+    return value;
+}
+
+static void k230_sdhci_fallback_write(void *opaque, hwaddr addr,
+                                     uint64_t value, unsigned int size)
+{
+    K230SDHCIState *s = opaque;
+
+    stn_le_p(&s->fallback_regs[addr], size, value);
+
+    /* PWRGOOD reflects PHY state and is not software writable. */
+    s->fallback_regs[K230_SDHCI_PHY_CNFG] |=
+        K230_SDHCI_PHY_CNFG_PWRGOOD;
+}
+
+static const MemoryRegionOps k230_sdhci_fallback_ops = {
+    .read = k230_sdhci_fallback_read,
+    .write = k230_sdhci_fallback_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void k230_sdhci_reset(DeviceState *dev)
+{
+    K230SDHCIState *s = K230_SDHCI(dev);
+
+    memset(s->fallback_regs, 0, sizeof(s->fallback_regs));
+    s->fallback_regs[K230_SDHCI_PHY_CNFG] =
+        K230_SDHCI_PHY_CNFG_PWRGOOD;
+    device_cold_reset(DEVICE(&s->sdhci));
+}
+
+static void k230_sdhci_realize(DeviceState *dev, Error **errp)
+{
+    K230SDHCIState *s = K230_SDHCI(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    SysBusDevice *sdhci_sbd = SYS_BUS_DEVICE(&s->sdhci);
+
+    memory_region_init(&s->container, OBJECT(s), "k230.sdhci-container",
+                       K230_SDHCI_REG_SIZE);
+    sysbus_init_mmio(sbd, &s->container);
+
+    memory_region_init_io(&s->iomem_fallback, OBJECT(s),
+                          &k230_sdhci_fallback_ops, s,
+                          "k230.sdhci-fallback",
+                          K230_SDHCI_REG_SIZE);
+    memory_region_add_subregion(&s->container, 0, &s->iomem_fallback);
+
+    if (!sysbus_realize(sdhci_sbd, errp)) {
+        return;
+    }
+    memory_region_add_subregion_overlap(
+        &s->container, 0, sysbus_mmio_get_region(sdhci_sbd, 0), 1);
+
+    memory_region_init_io(&s->iomem_preset, OBJECT(s),
+                          &k230_sdhci_preset_ops, s,
+                          "k230.sdhci-preset", K230_SDHCI_PRESET_SIZE);
+    memory_region_add_subregion_overlap(&s->container,
+                                        K230_SDHCI_PRESET_BASE,
+                                        &s->iomem_preset, 2);
+
+    memory_region_init_io(&s->iomem_pointer, OBJECT(s),
+                          &k230_sdhci_pointer_ops, s,
+                          "k230.sdhci-pointers", K230_SDHCI_POINTER_SIZE);
+    memory_region_add_subregion_overlap(&s->container,
+                                        K230_SDHCI_POINTER_BASE,
+                                        &s->iomem_pointer, 2);
+
+    sysbus_pass_irq(sbd, sdhci_sbd);
+    s->bus = qdev_get_child_bus(DEVICE(sdhci_sbd), "sd-bus");
+}
+
+static const VMStateDescription vmstate_k230_sdhci = {
+    .name = TYPE_K230_SDHCI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(fallback_regs, K230SDHCIState,
+                            K230_SDHCI_REG_SIZE),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void k230_sdhci_instance_init(Object *obj)
+{
+    K230SDHCIState *s = K230_SDHCI(obj);
+
+    object_initialize_child(obj, "generic-sdhci", &s->sdhci,
+                            TYPE_SYSBUS_SDHCI);
+
+    object_property_set_uint(OBJECT(&s->sdhci), "sd-spec-version",
+                             K230_SDHCI_SPEC_VERSION,
+                             &error_abort);
+    object_property_set_uint(OBJECT(&s->sdhci), "capareg",
+                             K230_SDHCI_CAPAREG_IMPLEMENTED,
+                             &error_abort);
+    object_property_set_uint(OBJECT(&s->sdhci), "uhs", UHS_I, &error_abort);
+}
+
+static void k230_sdhci_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "Kendryte K230 SDHCI Controller";
+    dc->realize = k230_sdhci_realize;
+    device_class_set_legacy_reset(dc, k230_sdhci_reset);
+    dc->vmsd = &vmstate_k230_sdhci;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+}
+
+static const TypeInfo k230_sdhci_type_info = {
+    .name = TYPE_K230_SDHCI,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(K230SDHCIState),
+    .instance_init = k230_sdhci_instance_init,
+    .class_init = k230_sdhci_class_init,
+};
+
+static void k230_sdhci_register_types(void)
+{
+    type_register_static(&k230_sdhci_type_info);
+}
+
+type_init(k230_sdhci_register_types)
diff --git a/hw/sd/meson.build b/hw/sd/meson.build
index b43d45bc56..a109635233 100644
--- a/hw/sd/meson.build
+++ b/hw/sd/meson.build
@@ -10,3 +10,4 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sdhci.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sdhost.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_sdhci.c'))
 system_ss.add(when: 'CONFIG_CADENCE_SDHCI', if_true: files('cadence_sdhci.c'))
+system_ss.add(when: 'CONFIG_K230_SDHCI', if_true: files('k230_sdhci.c'))
diff --git a/include/hw/sd/k230_sdhci.h b/include/hw/sd/k230_sdhci.h
new file mode 100644
index 0000000000..a8389f1de4
--- /dev/null
+++ b/include/hw/sd/k230_sdhci.h
@@ -0,0 +1,82 @@
+/*
+ * Kendryte K230 SDHCI controller
+ *
+ * Copyright (c) 2026 Xin Xie <xinxie908@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_SD_K230_SDHCI_H
+#define HW_SD_K230_SDHCI_H
+
+#include "qemu/bitops.h"
+#include "hw/sd/sdhci.h"
+#include "qom/object.h"
+
+#define TYPE_K230_SDHCI "k230.sdhci"
+OBJECT_DECLARE_SIMPLE_TYPE(K230SDHCIState, K230_SDHCI)
+
+#define K230_SDHCI_REG_SIZE             0x1000
+
+/* K230 TRM reset values for Capabilities Registers 1 and 2. */
+#define K230_SDHCI_CAPABILITIES1_RESET  0x256ec881ULL
+#define K230_SDHCI_CAPABILITIES2_RESET  0x0800a177ULL
+#define K230_SDHCI_CAPAREG_RESET \
+    ((K230_SDHCI_CAPABILITIES2_RESET << 32) \
+    | K230_SDHCI_CAPABILITIES1_RESET)
+
+/* SDHCI Preset Value registers. */
+#define K230_SDHCI_PRESET_BASE           0x060
+#define K230_SDHCI_PRESET_SIZE           0x010
+#define K230_SDHCI_PRESET_INIT           0x060
+#define K230_SDHCI_PRESET_DEFAULT_SPEED  0x062
+#define K230_SDHCI_PRESET_HIGH_SPEED     0x064
+#define K230_SDHCI_PRESET_SDR12          0x066
+#define K230_SDHCI_PRESET_SDR25          0x068
+#define K230_SDHCI_PRESET_SDR50          0x06a
+#define K230_SDHCI_PRESET_SDR104         0x06c
+#define K230_SDHCI_PRESET_DDR50          0x06e
+#define K230_SDHCI_PRESET_INIT_RESET          0x00fa
+#define K230_SDHCI_PRESET_DEFAULT_SPEED_RESET 0x0004
+#define K230_SDHCI_PRESET_HIGH_SPEED_RESET    0x0002
+#define K230_SDHCI_PRESET_SDR12_RESET         0x0004
+#define K230_SDHCI_PRESET_SDR25_RESET         0x0002
+#define K230_SDHCI_PRESET_SDR50_RESET         0x0001
+#define K230_SDHCI_PRESET_SDR104_RESET        0x0000
+#define K230_SDHCI_PRESET_DDR50_RESET         0x0002
+
+/* SDHCI v4 extension-area pointer registers. */
+#define K230_SDHCI_POINTER_BASE         0x0e0
+#define K230_SDHCI_POINTER_SIZE         0x00c
+#define K230_SDHCI_P_UHS2_SETTINGS      0x0e0
+#define K230_SDHCI_P_UHS2_HOST_CAPAB    0x0e2
+#define K230_SDHCI_P_UHS2_TEST          0x0e4
+#define K230_SDHCI_P_EMBEDDED_CNTRL     0x0e6
+#define K230_SDHCI_P_VENDOR_AREA1       0x0e8
+#define K230_SDHCI_P_VENDOR_AREA2       0x0ea
+#define K230_SDHCI_P_UHS2_SETTINGS_RESET    0x0000
+#define K230_SDHCI_P_UHS2_HOST_CAPAB_RESET  0x0f58
+#define K230_SDHCI_P_UHS2_TEST_RESET        0x0f68
+#define K230_SDHCI_P_EMBEDDED_CNTRL_RESET   0x0f6c
+#define K230_SDHCI_P_VENDOR_AREA1_RESET     0x0500
+#define K230_SDHCI_P_VENDOR_AREA2_RESET     0x0384
+
+/* DWC MSHC PHY register block. */
+#define K230_SDHCI_PHY_CNFG             0x300
+#define K230_SDHCI_PHY_CNFG_RSTN        BIT(0)
+#define K230_SDHCI_PHY_CNFG_PWRGOOD     BIT(1)
+
+struct K230SDHCIState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion container;
+    MemoryRegion iomem_fallback;
+    MemoryRegion iomem_preset;
+    MemoryRegion iomem_pointer;
+    BusState *bus;
+    uint8_t fallback_regs[K230_SDHCI_REG_SIZE];
+
+    SDHCIState sdhci;
+};
+
+#endif
-- 
2.43.0


