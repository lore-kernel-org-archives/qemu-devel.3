Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC269C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdpP-0005mc-Ru; Mon, 24 Feb 2025 14:09:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdot-0005e2-2F
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:08:49 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdoq-0004nr-4W
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:08:46 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-220e6028214so104180045ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 11:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740424121; x=1741028921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y00TMw2vSZi5W2xAmzPCeeztV06fpu0c/uIoObcPADo=;
 b=mhD70UbeAQ6Y8hFiQ5nArPUZyQAEdai4MubaZwbNXmxOeSCcWthHReHY+ylgAtS0JA
 wQecAV4SZ5PAXLJ4JpEXviw5+ZuakTwTb+skFrwW+AHw5q1ck+w5pyzE13DpSdDsfc/r
 /InxpoB8KBbPiaqS8vSwZgb0uw1uMJgL/s7hmJ2rpRXrBG7GbPfUNxg8Q2uHTpAFezMd
 1o1cpF2QJ4YI10WIy7j8lcdyxeY+gpBzgBMBC8il+/70ltlBXpKxI98AcAz8wIBmzNzs
 zf6m+9oujdTGgzc5+nNe5ozS1MQDfGqOb2u3itOBWbEmd/i5vSIdtxB89TawYLcRPJZs
 oUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740424121; x=1741028921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y00TMw2vSZi5W2xAmzPCeeztV06fpu0c/uIoObcPADo=;
 b=rjXe5In3pxk3J1xeQTNUgxDBMOailLPzivHaHhsF2OXh6VmZkBRWmE5VtPk2t+ymbv
 WlA9X8LPYS7XiQ86mhpTYHcuYrACFQ5VY5cR2DkqzTXeBQwYc6TZq07LLzmmvWOXUVfM
 zxJ1gNoktug5V6UcEAYsRocLhU0P8kyCHy4M4UcDI3gdTAyIx3lgvZnaqDYga7T9UU5C
 6ahZKlE0p2x5Jiqx7GPgldevt7v1wRswXv8BvDojQ1vmxy36b0kMUhkpiS5QjAMVgZuB
 SmL8mWgoFgRQArKsz8zrFH4gdeu0+DtTVPG+HVaLHLJmfDs9CHwfZ1j8k+ABfXQDWdqO
 L45w==
X-Gm-Message-State: AOJu0YyQuhYtow46GH1GwIht+HgAA2yfMSGnHJmGw94u1PGwpykg9Qdc
 nglpY1mKgWQ6+C9n2R+fYJ6FXaVujaRUL7JT3CrozU06vt1WLJMcE4rzM3ictJPRrNwrltdBtEZ
 y
X-Gm-Gg: ASbGncs8zFRL++YzonrMKiSdINfdBcB0iEI27h5bDjCHCZ+Xe1HJWsM5888TzbUDfMa
 8yQKp+WlBpcK1Fgs7whhfdmefpvazXmF6/bq1GruVE13U1pRDSARGz+rsfdYDDLQ3nvlZqjE8WP
 vYmogWno2hDtOhfD27lR5X8qEudqR+pqr3JzoSaOwImWZU8LuxIm/FPAN3nE7oWkN47+5o8Vf2R
 VT5anw4icSNFVq2pAwaItfziAk9mKiLK+hq6D2oylhnPGyZfC63oDv0ywD8CemTaJ38MyaR8xSm
 h+t0x0pkm2FpzqLwIjXTaeIEn9J6hQ==
X-Google-Smtp-Source: AGHT+IHZNxLhuq6IbT4egGK+sPGlkME5fcwkKPSrljUHnL5eJpsGBN+nRqLJ8JVkTS8PCNC8oJqybQ==
X-Received: by 2002:a17:903:2f03:b0:220:f7bb:842 with SMTP id
 d9443c01a7336-221a00211cdmr232171835ad.42.1740424121024; 
 Mon, 24 Feb 2025 11:08:41 -0800 (PST)
Received: from grind.. ([2804:7f0:bcc0:6edb:f473:a9df:d551:443b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545df28sm183583155ad.153.2025.02.24.11.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 11:08:40 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 03/11] hw/riscv/riscv-iommu: add riscv-iommu-hpm file
Date: Mon, 24 Feb 2025 16:08:18 -0300
Message-ID: <20250224190826.1858473-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
References: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

The HPM (Hardware Performance Monitor) support consists of almost 7
hundred lines that would be put on top of the base riscv-iommu
emulation.

To avoid clogging riscv-iommu.c, add a separated riscv-iommu-hpm file
that will contain HPM specific code.

We'll start by adding riscv_iommu_hpmcycle_read(), a helper that will be
called during the riscv_iommu_mmio_read() callback.

This change will have no effect on the existing emulation since we're
not declaring HPM feature support.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/meson.build       |  3 ++-
 hw/riscv/riscv-iommu-hpm.c | 54 ++++++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu-hpm.h | 27 +++++++++++++++++++
 hw/riscv/riscv-iommu.c     | 24 ++++++++++++++++-
 hw/riscv/riscv-iommu.h     |  4 +++
 5 files changed, 110 insertions(+), 2 deletions(-)
 create mode 100644 hw/riscv/riscv-iommu-hpm.c
 create mode 100644 hw/riscv/riscv-iommu-hpm.h

diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 3c7e083aca..c22f3a7216 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -10,7 +10,8 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
 riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
 riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
 riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
-riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
+	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
 
 hw_arch += {'riscv': riscv_ss}
diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
new file mode 100644
index 0000000000..5833ab8956
--- /dev/null
+++ b/hw/riscv/riscv-iommu-hpm.c
@@ -0,0 +1,54 @@
+/*
+ * RISC-V IOMMU - Hardware Performance Monitor (HPM) helpers
+ *
+ * Copyright (C) 2022-2023 Rivos Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "cpu_bits.h"
+#include "riscv-iommu-hpm.h"
+#include "riscv-iommu.h"
+#include "riscv-iommu-bits.h"
+#include "trace.h"
+
+/* For now we assume IOMMU HPM frequency to be 1GHz so 1-cycle is of 1-ns. */
+static inline uint64_t get_cycles(void)
+{
+    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+}
+
+uint64_t riscv_iommu_hpmcycle_read(RISCVIOMMUState *s)
+{
+    const uint64_t cycle = riscv_iommu_reg_get64(
+        s, RISCV_IOMMU_REG_IOHPMCYCLES);
+    const uint32_t inhibit = riscv_iommu_reg_get32(
+        s, RISCV_IOMMU_REG_IOCOUNTINH);
+    const uint64_t ctr_prev = s->hpmcycle_prev;
+    const uint64_t ctr_val = s->hpmcycle_val;
+
+    if (get_field(inhibit, RISCV_IOMMU_IOCOUNTINH_CY)) {
+        /*
+         * Counter should not increment if inhibit bit is set. We can't really
+         * stop the QEMU_CLOCK_VIRTUAL, so we just return the last updated
+         * counter value to indicate that counter was not incremented.
+         */
+        return (ctr_val & RISCV_IOMMU_IOHPMCYCLES_COUNTER) |
+               (cycle & RISCV_IOMMU_IOHPMCYCLES_OVF);
+    }
+
+    return (ctr_val + get_cycles() - ctr_prev) |
+        (cycle & RISCV_IOMMU_IOHPMCYCLES_OVF);
+}
diff --git a/hw/riscv/riscv-iommu-hpm.h b/hw/riscv/riscv-iommu-hpm.h
new file mode 100644
index 0000000000..231c110ff2
--- /dev/null
+++ b/hw/riscv/riscv-iommu-hpm.h
@@ -0,0 +1,27 @@
+/*
+ * RISC-V IOMMU - Hardware Performance Monitor (HPM) helpers
+ *
+ * Copyright (C) 2022-2023 Rivos Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_RISCV_IOMMU_HPM_H
+#define HW_RISCV_IOMMU_HPM_H
+
+#include "qom/object.h"
+#include "hw/riscv/riscv-iommu.h"
+
+uint64_t riscv_iommu_hpmcycle_read(RISCVIOMMUState *s);
+
+#endif
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index e7568ca227..0fbd50bb52 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -29,6 +29,7 @@
 #include "cpu_bits.h"
 #include "riscv-iommu.h"
 #include "riscv-iommu-bits.h"
+#include "riscv-iommu-hpm.h"
 #include "trace.h"
 
 #define LIMIT_CACHE_CTX               (1U << 7)
@@ -2153,7 +2154,28 @@ static MemTxResult riscv_iommu_mmio_read(void *opaque, hwaddr addr,
         return MEMTX_ACCESS_ERROR;
     }
 
-    ptr = &s->regs_rw[addr];
+    /* Compute cycle register value. */
+    if ((addr & ~7) == RISCV_IOMMU_REG_IOHPMCYCLES) {
+        val = riscv_iommu_hpmcycle_read(s);
+        ptr = (uint8_t *)&val + (addr & 7);
+    } else if ((addr & ~3) == RISCV_IOMMU_REG_IOCOUNTOVF) {
+        /*
+         * Software can read RISCV_IOMMU_REG_IOCOUNTOVF before timer
+         * callback completes. In which case CY_OF bit in
+         * RISCV_IOMMU_IOHPMCYCLES_OVF would be 0. Here we take the
+         * CY_OF bit state from RISCV_IOMMU_REG_IOHPMCYCLES register as
+         * it's not dependent over the timer callback and is computed
+         * from cycle overflow.
+         */
+        val = ldq_le_p(&s->regs_rw[addr]);
+        val |= (riscv_iommu_hpmcycle_read(s) & RISCV_IOMMU_IOHPMCYCLES_OVF)
+                   ? RISCV_IOMMU_IOCOUNTOVF_CY
+                   : 0;
+        ptr = (uint8_t *)&val + (addr & 3);
+    } else {
+        ptr = &s->regs_rw[addr];
+    }
+
     val = ldn_le_p(ptr, size);
 
     *data = val;
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index d2608d2f9b..59db3fd02a 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -81,6 +81,10 @@ struct RISCVIOMMUState {
 
     QLIST_ENTRY(RISCVIOMMUState) iommus;
     QLIST_HEAD(, RISCVIOMMUSpace) spaces;
+
+    /* HPM cycle counter */
+    uint64_t hpmcycle_val;      /* Current value of cycle register */
+    uint64_t hpmcycle_prev;     /* Saved value of QEMU_CLOCK_VIRTUAL clock */
 };
 
 void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
-- 
2.48.1


