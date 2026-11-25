Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819DF606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=bivRgrDf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW2te-0000Oh-QB; Tue, 24 Nov 2026 21:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xW2t9-0000E5-1G
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:37:42 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xW2t5-00075j-6g
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:37:38 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8b0dba37a7fso42646877b3.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795574251; x=1796179051; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=15ZiMIlKWSXfjh2bljs8N9XPSIeZkVSaqHO+BLmCJrw=;
 b=bivRgrDfq0TYdVxIg2yrKdNz+aQ2jr4JSNu/lvUMAj4bOJYu15n62joOomPFVs7iof
 lmkBrXZDna7FJDe/PJyqlA0RGivaAA88C7efQZykQRMYcI2P4y2rhseGE5p9HcJEXnM1
 MxBxrq742x0B3HOM4HdyUVtdpYolKFuNwGOu174HrHpeq4L1NVzUeSdFsTluRmXAdsyt
 EyilQSkzaG4KfHBekv8ht12GPJ4TziISBceEwkNhNZJyLx+mwYFZ4+CG//peCcFAb9Ku
 LrW9n05oeusdXRzkcX4GwoE2jWDFY4L0Tcdw5VobqXJRlK8HWo6o9OWcJcdIppV7RAdg
 G80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795574251; x=1796179051;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=15ZiMIlKWSXfjh2bljs8N9XPSIeZkVSaqHO+BLmCJrw=;
 b=FfeLj7hdMfN/u0sBvb59A8lyTOc/rnfhm7jom8akbby7Q5UkqZqjfKsh1kEWpXFndY
 5+C5CKPTQ4bd3FkLaaKJWpBIJm2cNoOrd21tDBeLPMn656ZTbBSOSmw63Hrj91yB1YK6
 bt4wZyPbeMCK+hGPWSVV+nohJhuYD5BWGivYpTrGBL20Zv37Cqgvz87Z/NNfP/aFz3ds
 CwwEAGEFHoV8Pc/sM5pCAPFD2WCztDxCX7F2jkDlmRY8pJE5s3XRkYy83dxaqY30nXe/
 ALHevfFZKObhCHYvBTlSI69wKyHzn1X2vF+YauCswpm9iqiDzmdYCJ1SM3z0EhpvyfKs
 PRSg==
X-Gm-Message-State: APuU4Z/0pDisKuMW6RGCGSlzCJb/OqwjoKgu6tsHb1hbXHos2+haosRR
 Rae9EUYiXfBFyPtQj08PyuEGI7PUz6gVBn2ynJ4Ro18RxQIz4MdvVmMG2zQexEzXCtU=
X-Gm-Gg: AZFdTZfauUPw0R7UlCsf1H20TE8E7mizOlKIViI9aeLH5S4tFawne680UEl+Eqrxr66
 os9qpK1BmOy7/AvuSkfawXquvtvYTQ8h4gVtAn9VlxVwecWx7/uZSXAftjJYmOt3HfLJDvA0Xty
 7sp8nS85njfYXAW7vHw0vk5WFA5dxhzX4VnhBbu29xBDtcOM0E+ddGMAY56C/TjOIM2Ce2QNrFB
 3q6LVIYMp/6FpjSTYXPfAAMQ0A0mzXszoxwOZ8cUDdG6YbTCB9Wz1hxxikQJmsXl/sDnYaGWAos
 CmRWmcEEzNQYU1dNcWPOsFBucSv0jLV6gOI7zWm+uiWptjTQ1o2br4u1x5gwAwFY/DdSp0t8ZRX
 UiRi7QwrQpE4wRv03Jf6wZ9j3FOeEgYLLCd+hIh8Y+9aMo673LlFPKnI8+YmN+oSl6BMaP7DOJk
 7tN/AS2bw2MBTP7inV1LVCGy6X+VBqEqPKn4CMfkUYiNubey0tr99eUfWJZwKXCoKiuYCsPBSG9
 q2FMqgLl2Yr+B/sng7U2TsMI7VE31AYog42Arzhe0kzv6Gyi7NY86v9rMY6fNO9QWn+QbfAdgM3
 CMBHyvE9oIJjmR/C1uB/Oma3PilNj5pl45QU4tlpdyWxcJZiuvx0uEa2i3fCIsumgTaLYXq63br
 X87mPh/Qx
X-Received: by 2002:a05:690c:688e:b0:8b1:813e:91b0 with SMTP id
 00721157ae682-8b52031ab68mr56858307b3.9.1795574251303; 
 Tue, 24 Nov 2026 18:37:31 -0800 (PST)
Received: from [192.168.2.129] ([2600:1700:220:59e0:ea8f:7897:2f4d:9891])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b52028d628sm65626717b3.8.2026.11.24.18.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 18:37:30 -0800 (PST)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Tue, 24 Nov 2026 20:37:23 -0600
Subject: [PATCH 4/8] hw/misc: Add a model for Spacemit K3 syscons
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-spacemit_k3-v1-4-e911d6e88542@oss.tenstorrent.com>
References: <20261124-spacemit_k3-v1-0-e911d6e88542@oss.tenstorrent.com>
In-Reply-To: <20261124-spacemit_k3-v1-0-e911d6e88542@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Jeuk Kim <jeuk20.kim@samsung.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a model for syscons in the Spacemit K3 SoC that implement Clocks,
Reset, DDR Control and other mischallaneous functionality.

Minimal functionality is implemented for each device so that the
spacemit-k3 machine can boot up till U-Boot/EDK2.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 MAINTAINERS                          |   2 +
 hw/misc/meson.build                  |   1 +
 hw/misc/spacemit_k3_syscon.c         | 338 +++++++++++++++++++++++++++++++++++
 hw/misc/trace-events                 |   8 +
 include/hw/misc/spacemit_k3_syscon.h |  80 +++++++++
 5 files changed, 429 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 52a9ffbb33..7dfae9f40d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1858,8 +1858,10 @@ Spacemit Machines
 M: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
 L: qemu-riscv@nongnu.org
 S: Supported
+F: hw/misc/spacemit_*.c
 F: hw/ssi/spacemit_*.c
 F: hw/ufs/spacemit_*.c
+F: include/hw/misc/spacemit_*.h
 F: include/hw/ssi/spacemit_*.h
 F: target/riscv/tcg/spacemit_csr.c
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 7a071af82b..558fde8ff5 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -169,6 +169,7 @@ specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
 
 specific_ss.add(when: 'CONFIG_RISCV_MIPS_CMGCR', if_true: files('riscv_cmgcr.c'))
 specific_ss.add(when: 'CONFIG_RISCV_MIPS_CPC', if_true: files('riscv_cpc.c'))
+specific_ss.add(when: 'CONFIG_SPACEMIT', if_true: files('spacemit_k3_syscon.c'))
 if igvm.found()
    system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmlaunchupdate.c'))
 endif
diff --git a/hw/misc/spacemit_k3_syscon.c b/hw/misc/spacemit_k3_syscon.c
new file mode 100644
index 0000000000..03a826495a
--- /dev/null
+++ b/hw/misc/spacemit_k3_syscon.c
@@ -0,0 +1,338 @@
+/*
+ * Spacemit K3 Syscons
+ *
+ * Control clocks, resets, ddr and misc functionality
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright 2026 Anirudh Srinivasan
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/qdev-properties.h"
+#include "system/address-spaces.h"
+#include "system/dma.h"
+#include "crypto/hash.h"
+#include "hw/core/cpu.h"
+#include "hw/misc/spacemit_k3_syscon.h"
+#include "trace.h"
+
+#define TO_REG(offset) (offset >> 2)
+
+#define BOOT_MODE_VALUE_NOR 0x10000200
+#define BOOT_MODE_VALUE_EMMC 0x10000000
+#define BOOT_MODE_VALUE_NAND 0x10000400
+#define BOOT_MODE_VALUE_UFS 0x10000600
+#define BOOT_MODE_VALUE_USB 0x10001000
+#define BOOT_MODE_VALUE_UART 0x10001800
+
+/* CPU Config register offsets */
+#define BOOT_PIN_SELECT 0x20
+
+/* Syscon APMU register offsets */
+#define APMU_RCPU_CLK_RES_CTRL 0x14c
+
+/* Syscon MPMU register offsets */
+#define MPMU_POSR 0x10
+
+static uint64_t spacemit_k3_syscon_mpmu_read(void *opaque, hwaddr offset,
+                                             unsigned size)
+{
+    uint64_t ret = 0;
+
+    switch (offset) {
+    case MPMU_POSR:
+        ret = 0xff0000;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented read (size %u, offset 0x%"
+                      HWADDR_PRIx ")\n", TYPE_SPACEMIT_K3_SYSCON_MPMU_UNIT,
+                      size, offset);
+        break;
+    }
+
+    trace_spacemit_k3_syscon_mpmu_read(offset, size, ret);
+    return ret;
+}
+
+static void spacemit_k3_syscon_mpmu_write(void *opaque, hwaddr offset,
+                                  uint64_t value, unsigned size)
+{
+    trace_spacemit_k3_syscon_mpmu_write(offset, size, value);
+    qemu_log_mask(LOG_UNIMP, "%s: unimplemented write (size %u, offset 0x%"
+                  HWADDR_PRIx ", value 0x%" PRIx64 ")\n",
+                  TYPE_SPACEMIT_K3_SYSCON_MPMU_UNIT, size, offset, value);
+}
+
+static uint64_t spacemit_k3_syscon_apmu_read(void *opaque, hwaddr offset,
+                                             unsigned size)
+{
+    uint64_t ret = 0;
+
+    switch (offset) {
+    case APMU_RCPU_CLK_RES_CTRL:
+        ret = BIT(23);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented read (size %u, offset 0x%"
+                      HWADDR_PRIx ")\n", TYPE_SPACEMIT_K3_SYSCON_APMU_UNIT,
+                      size, offset);
+        break;
+    }
+
+    trace_spacemit_k3_syscon_apmu_read(offset, size, ret);
+    return ret;
+}
+
+static void spacemit_k3_syscon_apmu_write(void *opaque, hwaddr offset,
+                                  uint64_t value, unsigned size)
+{
+    trace_spacemit_k3_syscon_apmu_write(offset, size, value);
+}
+
+static uint64_t spacemit_k3_ddrc_read(void *opaque, hwaddr offset,
+                                      unsigned size)
+{
+    SpacemitK3DDRCState *s = opaque;
+    uint64_t ret;
+
+    /*
+     * Register offsets and names are not known
+     * Values here are set based on what
+     * DDR fw polls for and what bits it expects
+     * to be set.
+     */
+    switch (offset) {
+    case 0x10014:
+        ret = 1;
+        break;
+    case 0x10514:
+        ret = 1;
+        break;
+    case 0x10c84:
+        ret = 1;
+        break;
+    case 0x60001c:
+        ret = 1;
+        break;
+    case 0xb40010:
+        ret = s->b40010;
+        break;
+    case 0xb400c8:
+        ret = 7;
+        break;
+    default:
+        ret = 0;
+        break;
+    }
+
+    return ret;
+}
+
+static void spacemit_k3_ddrc_write(void *opaque, hwaddr offset,
+                                  uint64_t value, unsigned size)
+{
+    SpacemitK3DDRCState *s = opaque;
+
+    switch (offset) {
+    case 0xb400c4:
+        s->b40010 = value == 0 ? 1 : 0;
+        break;
+    }
+}
+
+static uint64_t spacemit_k3_cpu_config_read(void *opaque, hwaddr offset,
+                                            unsigned size)
+{
+    SpacemitK3CPUConfigState *s = SPACEMIT_K3_CPU_CONFIG(opaque);
+    uint64_t ret = s->regs[TO_REG(offset)];
+
+    trace_spacemit_k3_cpu_config_read(offset, size, ret);
+    return ret;
+}
+
+static void spacemit_k3_cpu_config_write(void *opaque, hwaddr offset,
+                                  uint64_t value, unsigned size)
+{
+    SpacemitK3CPUConfigState *s = SPACEMIT_K3_CPU_CONFIG(opaque);
+
+    trace_spacemit_k3_cpu_config_write(offset, size, value);
+
+    s->regs[TO_REG(offset)] = value;
+}
+
+static uint32_t spacemit_k3_boot_mode_value(int boot_mode)
+{
+    static const uint32_t boot_mode_values[] = {
+      [SPACEMIT_K3_BOOT_MODE_EMMC] = BOOT_MODE_VALUE_EMMC,
+      [SPACEMIT_K3_BOOT_MODE_NOR] = BOOT_MODE_VALUE_NOR,
+      [SPACEMIT_K3_BOOT_MODE_NAND] = BOOT_MODE_VALUE_NAND,
+      [SPACEMIT_K3_BOOT_MODE_UFS] = BOOT_MODE_VALUE_UFS,
+      [SPACEMIT_K3_BOOT_MODE_USB] = BOOT_MODE_VALUE_USB,
+      [SPACEMIT_K3_BOOT_MODE_UART] = BOOT_MODE_VALUE_UART,
+    };
+
+    if (boot_mode < 0 || boot_mode >= ARRAY_SIZE(boot_mode_values)) {
+        return BOOT_MODE_VALUE_NOR;
+    }
+
+    return boot_mode_values[boot_mode];
+}
+
+static const MemoryRegionOps spacemit_k3_syscon_mpmu_ops = {
+    .read = spacemit_k3_syscon_mpmu_read,
+    .write = spacemit_k3_syscon_mpmu_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static const MemoryRegionOps spacemit_k3_syscon_apmu_ops = {
+    .read = spacemit_k3_syscon_apmu_read,
+    .write = spacemit_k3_syscon_apmu_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static const MemoryRegionOps spacemit_k3_ddrc_ops = {
+    .read = spacemit_k3_ddrc_read,
+    .write = spacemit_k3_ddrc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static const MemoryRegionOps spacemit_k3_cpu_config_ops = {
+    .read = spacemit_k3_cpu_config_read,
+    .write = spacemit_k3_cpu_config_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void spacemit_k3_syscon_mpmu_init(Object *obj)
+{
+    SpacemitK3SysconMPMUState *s = SPACEMIT_K3_SYSCON_MPMU_UNIT(obj);
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->mmio, obj, &spacemit_k3_syscon_mpmu_ops, s,
+                          TYPE_SPACEMIT_K3_SYSCON_MPMU_UNIT,
+                          SPACEMIT_K3_SYSCON_MPMU_SIZE);
+    sysbus_init_mmio(dev, &s->mmio);
+}
+
+static void spacemit_k3_syscon_apmu_init(Object *obj)
+{
+    SpacemitK3SysconAPMUState *s = SPACEMIT_K3_SYSCON_APMU_UNIT(obj);
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->mmio, obj, &spacemit_k3_syscon_apmu_ops, s,
+                          TYPE_SPACEMIT_K3_SYSCON_APMU_UNIT,
+                          SPACEMIT_K3_SYSCON_APMU_SIZE);
+    sysbus_init_mmio(dev, &s->mmio);
+}
+
+static void spacemit_k3_ddrc_init(Object *obj)
+{
+    SpacemitK3DDRCState *s = SPACEMIT_K3_DDRC(obj);
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->mmio, obj, &spacemit_k3_ddrc_ops, s,
+                          TYPE_SPACEMIT_K3_DDRC, SPACEMIT_K3_DDRC_SIZE);
+    sysbus_init_mmio(dev, &s->mmio);
+
+    s->b40010 = 0;
+}
+
+static void spacemit_k3_cpu_config_init(Object *obj)
+{
+    SpacemitK3CPUConfigState *s = SPACEMIT_K3_CPU_CONFIG(obj);
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->mmio, obj, &spacemit_k3_cpu_config_ops, s,
+                          TYPE_SPACEMIT_K3_CPU_CONFIG,
+                          SPACEMIT_K3_CPU_CONFIG_SIZE);
+    sysbus_init_mmio(dev, &s->mmio);
+}
+
+static void spacemit_k3_ddrc_reset_hold(Object *obj, ResetType type)
+{
+    SpacemitK3DDRCState *s = SPACEMIT_K3_DDRC(obj);
+
+    s->b40010 = 0;
+}
+
+static void spacemit_k3_ddrc_class_init(ObjectClass *oc,
+                                               const void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+
+    rc->phases.hold = spacemit_k3_ddrc_reset_hold;
+}
+
+static void spacemit_k3_cpu_config_reset_hold(Object *obj, ResetType type)
+{
+    SpacemitK3CPUConfigState *s = SPACEMIT_K3_CPU_CONFIG(obj);
+
+    memset(s->regs, 0, sizeof(s->regs));
+    s->regs[TO_REG(BOOT_PIN_SELECT)] =
+        spacemit_k3_boot_mode_value(s->boot_mode);
+}
+
+static const Property spacemit_k3_cpu_config_properties[] = {
+    DEFINE_PROP_INT32("boot-mode", SpacemitK3CPUConfigState, boot_mode,
+                      SPACEMIT_K3_BOOT_MODE_NOR),
+};
+
+static void spacemit_k3_cpu_config_class_init(ObjectClass *klass,
+                                              const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    device_class_set_props(dc, spacemit_k3_cpu_config_properties);
+    rc->phases.hold = spacemit_k3_cpu_config_reset_hold;
+}
+
+static const TypeInfo spacemit_k3_syscon_types[] = {
+    {
+        .name = TYPE_SPACEMIT_K3_SYSCON_MPMU_UNIT,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(SpacemitK3SysconMPMUState),
+        .instance_init = spacemit_k3_syscon_mpmu_init,
+    },
+    {
+        .name = TYPE_SPACEMIT_K3_SYSCON_APMU_UNIT,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(SpacemitK3SysconAPMUState),
+        .instance_init = spacemit_k3_syscon_apmu_init,
+    },
+    {
+        .name = TYPE_SPACEMIT_K3_DDRC,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(SpacemitK3DDRCState),
+        .instance_init = spacemit_k3_ddrc_init,
+        .class_init = spacemit_k3_ddrc_class_init,
+    },
+    {
+        .name = TYPE_SPACEMIT_K3_CPU_CONFIG,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(SpacemitK3CPUConfigState),
+        .instance_init = spacemit_k3_cpu_config_init,
+        .class_init = spacemit_k3_cpu_config_class_init,
+    },
+};
+DEFINE_TYPES(spacemit_k3_syscon_types);
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 6c425ce8da..ec7072f309 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -474,3 +474,11 @@ restore_host_x86_igvm(void) ""
 # tt_atlantis_prcm.c
 tt_atlantis_prcm_read(uint32_t domain, uint64_t offset, uint64_t data) "domain 0x%02x offset 0x%" PRIx64 " data 0x%" PRIx64
 tt_atlantis_prcm_write(uint32_t domain, uint64_t offset, uint64_t data) "domain 0x%02x offset 0x%" PRIx64 " data 0x%" PRIx64
+
+# spacemit_k3_syscon.c
+spacemit_k3_syscon_apmu_read(uint64_t offset, unsigned size, uint64_t value) "offset 0x%04" PRIx64 " size %u value 0x%08" PRIx64
+spacemit_k3_syscon_apmu_write(uint64_t offset, unsigned size, uint64_t value) "offset 0x%04" PRIx64 " size %u value 0x%08" PRIx64
+spacemit_k3_syscon_mpmu_read(uint64_t offset, unsigned size, uint64_t value) "offset 0x%04" PRIx64 " size %u value 0x%08" PRIx64
+spacemit_k3_syscon_mpmu_write(uint64_t offset, unsigned size, uint64_t value) "offset 0x%04" PRIx64 " size %u value 0x%08" PRIx64
+spacemit_k3_cpu_config_read(uint64_t offset, unsigned size, uint64_t value) "offset 0x%04" PRIx64 " size %u value 0x%08" PRIx64
+spacemit_k3_cpu_config_write(uint64_t offset, unsigned size, uint64_t value) "offset 0x%04" PRIx64 " size %u value 0x%08" PRIx64
diff --git a/include/hw/misc/spacemit_k3_syscon.h b/include/hw/misc/spacemit_k3_syscon.h
new file mode 100644
index 0000000000..873f2c08e1
--- /dev/null
+++ b/include/hw/misc/spacemit_k3_syscon.h
@@ -0,0 +1,80 @@
+/*
+ * Spacemit K3 Syscons
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright 2026 Anirudh Srinivasan
+ */
+
+#ifndef HW_MISC_SPACEMIT_K3_SYSCON_H
+#define HW_MISC_SPACEMIT_K3_SYSCON_H
+
+#include "qom/object.h"
+#include "hw/core/sysbus.h"
+#include "system/memory.h"
+#include <stdint.h>
+
+#define SPACEMIT_K3_CPU_CONFIG_SIZE 0x400
+#define SPACEMIT_K3_SYSCON_MPMU_SIZE 0x10000
+#define SPACEMIT_K3_SYSCON_APMU_SIZE 0x400
+#define SPACEMIT_K3_DDRC_SIZE 0x1000000
+
+#define TYPE_SPACEMIT_K3_SYSCON_MPMU_UNIT "spacemit-k3-syscon-mpmu"
+OBJECT_DECLARE_SIMPLE_TYPE(SpacemitK3SysconMPMUState,
+                           SPACEMIT_K3_SYSCON_MPMU_UNIT)
+#define TYPE_SPACEMIT_K3_SYSCON_APMU_UNIT "spacemit-k3-syscon-apmu"
+OBJECT_DECLARE_SIMPLE_TYPE(SpacemitK3SysconAPMUState,
+                           SPACEMIT_K3_SYSCON_APMU_UNIT)
+#define TYPE_SPACEMIT_K3_DDRC "spacemit-k3-ddrc"
+OBJECT_DECLARE_SIMPLE_TYPE(SpacemitK3DDRCState, SPACEMIT_K3_DDRC)
+#define TYPE_SPACEMIT_K3_CPU_CONFIG "spacemit-k3-cpu-config"
+OBJECT_DECLARE_SIMPLE_TYPE(SpacemitK3CPUConfigState, SPACEMIT_K3_CPU_CONFIG)
+
+
+struct SpacemitK3SysconMPMUState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion mmio;
+};
+
+struct SpacemitK3SysconAPMUState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion mmio;
+};
+
+struct SpacemitK3DDRCState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion mmio;
+
+    /* Register at offset 0xb40010 that stores some state */
+    uint32_t b40010;
+};
+
+struct SpacemitK3CPUConfigState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion mmio;
+    uint32_t regs[SPACEMIT_K3_CPU_CONFIG_SIZE >> 2];
+    int boot_mode;
+};
+
+enum {
+    SPACEMIT_K3_BOOT_MODE_EMMC,
+    SPACEMIT_K3_BOOT_MODE_NOR,
+    SPACEMIT_K3_BOOT_MODE_NAND,
+    SPACEMIT_K3_BOOT_MODE_UFS,
+    SPACEMIT_K3_BOOT_MODE_USB,
+    SPACEMIT_K3_BOOT_MODE_UART,
+};
+
+#endif /* HW_MISC_SPACEMIT_K3_SYSCON_H */

-- 
2.43.0


