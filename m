Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E92C282D9
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdzj-00022e-PZ; Tue, 04 Mar 2025 20:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyh-0006vf-KC
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:25 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyf-0000PE-70
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:19 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso2337975ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139715; x=1741744515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MuoPRm7oJhyjx8pmnjodkk7DZxmD/8R71thvj8Act8=;
 b=ca24bDgXIXPpR5vAZ9/JYQN8rS7lu5MvCD46rExrbTyq4v1nGL9EajnfLBZ1Uq0h70
 fZJBMEiaLtBIGYSolr2Dk2vZ7XmlC7lRGfs9b9/p/Rbq8L/vSNmb9ab9sMRslwIpBCdo
 f6TAQod6ychviEO7oNPQqIXOuUVVJqVu8hBASf/QXAN/OQ66vDWx5hD8NyDtZz+YCzoc
 UB6Lncvm914SphCEChQDBlxMu8v5RbZrnRLvaNeR8IdTKqf8uTkYLdobwqODYyaxYjwc
 FMjSQUlT4b9QJJovLlsPH2f97zSrt53Uk1ifD+TWtj/AyG+QQdb/dJDCJnCnu4LO0ED+
 mPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139715; x=1741744515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2MuoPRm7oJhyjx8pmnjodkk7DZxmD/8R71thvj8Act8=;
 b=QNwAlluvG4Y8myvBiUzihHDsY8iUtALOyy6TzKcKRCp+z5BkgDFcuCWc/Dyk6lB2Gi
 V0J2P465x8+kVHn7nO0rL6WCzmsJT0fy7INORpD4DSRBAxQq4Gvxr1cqzHucsfpPpHjd
 UPYs+nMUjCkYtHjdMqplzhFDBTHAFVMr6ELD8vEXiHh2RBOTh626OcWkjEFr5ENomNSL
 yVfRzX9v6V3sQhs3fq7aXl8NSwxrevRk3a2DXiEmDpsA1dXOdmMTWZG5gy+6U2Y3HxVO
 3Gfc7Xd0z1fYWUA+B1PH85mLZE8rukL2EP0EShb8/EL6EwQzdUQRH6foG5GGSuQD0ZfA
 JnuQ==
X-Gm-Message-State: AOJu0Yz9EUbMS5UvEElXLn6ZcrBUANC/9iBTpA5XikPKopG5DZc18Qav
 CNLyhYab2xQGCRh22CLB9OaBAPz17i8YSd4ygHUWTkFA7qVqO7hmY8cz1PONhdc=
X-Gm-Gg: ASbGncuG8ZmMyRha/YwNq/34UTCwS1ISVJq8tTmqgUJhK5YSfOGpS20y7YwzywXg5Ls
 4m73XRjOKUQACRcpDNpHWy+asDjRWGqi6N3Z/OWzaL4G3e3fCZyhgScOmkXaHzeGLYsl2nHozaw
 M61OJtHgJ9vkXPilmzCyy8cEbfISDOVbjAekwdZCK49SQvkWX+ZrggKVPQhU/C+/VpI+PNUtnSc
 XEOuh+TJrCtQp1dcxJoLv1fZmplwYi24eAXWA4onwL54tAltvAayiD7NKGzNHNzpEG+7QPvf2tC
 kJHJGv7Q6NSjzCXVeZJ/NG5oVgRK8XTCC5k5QdnfmwhZ0n9iQhAsqs6ZtThWR6B05prwipN2im+
 KouCUn9TMQLGP1DtYJopsPdD1Tunv9IvTeAALBg1LRVgZKHDQW+g=
X-Google-Smtp-Source: AGHT+IG2E8FUakRmatVkGEQSTEBOrh8rv1r4nmSTWyMgaf9apXYBXfLr1Tw0+ujxGzzPSn0JQMi9mw==
X-Received: by 2002:a17:902:f54d:b0:21f:3823:482b with SMTP id
 d9443c01a7336-223d97c0029mr84963165ad.25.1741139714427; 
 Tue, 04 Mar 2025 17:55:14 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:55:13 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 41/59] hw/riscv/riscv-iommu: add riscv-iommu-hpm file
Date: Wed,  5 Mar 2025 11:52:49 +1000
Message-ID: <20250305015307.1463560-42-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Message-ID: <20250224190826.1858473-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-hpm.h | 27 +++++++++++++++++++
 hw/riscv/riscv-iommu.h     |  4 +++
 hw/riscv/riscv-iommu-hpm.c | 54 ++++++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu.c     | 24 ++++++++++++++++-
 hw/riscv/meson.build       |  3 ++-
 5 files changed, 110 insertions(+), 2 deletions(-)
 create mode 100644 hw/riscv/riscv-iommu-hpm.h
 create mode 100644 hw/riscv/riscv-iommu-hpm.c

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
-- 
2.48.1


