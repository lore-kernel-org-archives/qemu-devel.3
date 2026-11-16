Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A978606A332
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BT/YhZjp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSrWr-00036N-HS; Mon, 16 Nov 2026 02:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xSrWo-0002so-DA
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 02:53:26 -0500
Received: from mail-pj2-x02.google.com ([2607:f8b0:4864:39::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xSrWl-0006Td-Mp
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 02:53:26 -0500
Received: by mail-pj2-x02.google.com with SMTP id
 98e67ed59e1d1-3b196fefa1fso1512007a91.1
 for <qemu-devel@nongnu.org>; Sun, 15 Nov 2026 23:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794815602; x=1795420402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t8MMnDqot1SowKtbk3GWRs6afUCmGfGIuFgIQIPOXCQ=;
 b=BT/YhZjpvoKjzvAJtVIdVVhEvAJcU3Y69jYLK/s2tozgOvspB69G60dOtHIZi9H/Il
 MQELQlFIDghNgvJLtadt+qH85LdpwvFrr0AbThWbMQDUK/UPr0yUsvBMTyitrWtOjGDd
 1OmoGFOGsATJkRDTLZA93xkMdZmzhcaNznS5+u6F6g4XcpIDRMHf7QzFMC5KdHWN8KSE
 LWb4rEq+hM76+soJD2V+YGSTWfnJwIiRzGZ8ubGLbNt4Z7AfOZEL9W9PJwTv2mYvQHS8
 rl3ATgdBtzaMqrNuLAzeaj7nmPD5XGwtTWWASsacNPVR85THjX1XXZ4K+ufHZcFg2ZY2
 294A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794815602; x=1795420402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=t8MMnDqot1SowKtbk3GWRs6afUCmGfGIuFgIQIPOXCQ=;
 b=H3nzxlnXgbgCf7gcsPIdYiic513UIEJnpbPP/ZhEcASQKq3iFtQX7fhq4v3Yz2y7Jn
 AuUv/FeeuOsDZqnjy4cAxU8/v10DBvfXJr0A+1MOLU97m1uDehmw1XI/5dnwTMN1kBwF
 0NPiEs3zEi5Vc21jYwfIYl5eWBxdOCHqPbDMVTT2lWau9p4T1hkZbJGcAn6f8EQOiOVO
 cNYiiaAa4Z/K2Q1XVje9/CclO+JF/VC+s+bGSbh69UxVnkBADDFDL5G5RNGQ8ZYCFupU
 uey7rFobtbI0AT5dzRS/EEgedjM67ntHXMBBVjmZ/X1HRldG3y/ZrQU4ABxtH7ChyWHR
 fktw==
X-Gm-Message-State: APuU4Z+taeRH316bi0TsiMVGKdZSMXViSZZ3Vfx66Zy9iyAeOtb+h/19
 y5XHZpQfQ47N9JGhEvdQBmq8CzFhx/Af8BpBNeVhE3u2auT2omnEKLWporP9/nqdlzeCV4wIEW8
 =
X-Gm-Gg: AZFdTZd+mm1mjHCoflrO2y1mYPe4TX404Nl8V9WUpHHTQ5iYdkSwDyzkh9IrJmQ2saE
 FVGZvB+7BBnmvDH6ZaUDu4qBn0ppPTeVnEjwKQ8Ud4YJZ9fKt4kmdcFaLOyThlVC7qNYZmdLFy7
 bF/pE4mxr8xKWqL+Et224A34LOhviZm6PVzFQiVfpZLNr5hKUg279OUQIVuQb6mK9BJUsg5NUZq
 PoCvAh7clTReSxkmfEnfj9Ra4qmUtGaiKStAY3SYQ7VmTL7hpzCnUVvxT2ZS5Lho/E1/aIyXwFV
 wqV3/GPU1eJ2NBmMGEsEm/s+4aUj10x53QsUn3PQuhzqG6ltMSFH+u9AmsYoh+5TkEMYHPG0748
 zijKEftlu5uSHE2ros8+dfEi37QwaTP8f6JHFT1zEv2dOauA+DqlshS3n/9pSIAan1hwRisvs3B
 Lwom6QstjzpXkA4/pveooH0Bb7VssQdrdIMW8xsMR1vgR4nQjU90jzwQciZRMIBOHtcMaWt7Anb
 kuJYb9H322PNeESqMdHUiyc369qktcpbokWBkOyHBjyrwDDGsyCnsuVwqgRnThT+REgdpF8O48V
 bUKO7I4+0tXokGM4GceocJjzdZwDuMLksO7U/cnWneDhqSOWTe6oSU7Q
X-Received: by 2002:a17:90a:da86:b0:3a4:b0f3:6597 with SMTP id
 98e67ed59e1d1-3b1b05b9444mr9861461a91.0.1794815601658; 
 Sun, 15 Nov 2026 23:53:21 -0800 (PST)
Received: from Dell-WorkStation.localdomain ([152.175.67.81])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197d0f6e0sm20745622a91.9.2026.11.15.23.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 23:53:21 -0800 (PST)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-riscv@nongnu.org, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH 3/3] hw/riscv/riscv-iommu: Add unit tests for MSI trap handling
Date: Mon, 16 Nov 2026 15:51:41 +0800
Message-ID: <20261116075141.167317-4-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116075141.167317-1-fritchleybohrer@gmail.com>
References: <20261116075141.167317-1-fritchleybohrer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::2;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-pj2-x02.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The recovery-fault and ordinary-DMA fallback paths are difficult to
exercise deterministically with a qtest that updates page tables between
the initial translation and the synchronous trap callback.

Move the private callback into an implementation fragment shared with a
unit test. Use real QEMU types and replace the callback dependencies
only in the test translation unit, without exporting a new API or adding
runtime test hooks.

Cover rejected attributes, missing contexts, MSI forwarding, recovery
faults, and 4/8-byte fallback writes with success and error returns.
Check the addresses, little-endian bytes, transaction attributes,
context release, single-fault behavior, and disabled replay HPM
accounting. The PV assertions describe the existing callback policy, not
complete request-PID validity handling.

Register the test for system builds and add it to the RISC-V MAINTAINERS
entry. Use the usual pointer declaration in the moved callback. The
production behavior is unchanged.

Use a distinct opaque reference in the context stub so the
cleanup checks distinguish the returned context from its
cache-lifetime reference.

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 MAINTAINERS                        |   1 +
 hw/riscv/riscv-iommu-trap.c.inc    |  69 ++++++++
 hw/riscv/riscv-iommu.c             |  61 +------
 tests/unit/meson.build             |   1 +
 tests/unit/test-riscv-iommu-trap.c | 266 +++++++++++++++++++++++++++++
 5 files changed, 338 insertions(+), 60 deletions(-)
 create mode 100644 hw/riscv/riscv-iommu-trap.c.inc
 create mode 100644 tests/unit/test-riscv-iommu-trap.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d53e104c5..75de9034b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -387,6 +387,7 @@ F: tests/functional/riscv64
 F: tests/tcg/riscv32/
 F: tests/tcg/riscv64/
 F: tests/qtest/iommu-riscv-test.c
+F: tests/unit/test-riscv-iommu-trap.c
 
 RISC-V XThead* extensions
 M: Christoph Muellner <christoph.muellner@vrull.eu>
diff --git a/hw/riscv/riscv-iommu-trap.c.inc b/hw/riscv/riscv-iommu-trap.c.inc
new file mode 100644
index 0000000000..1e3eaee930
--- /dev/null
+++ b/hw/riscv/riscv-iommu-trap.c.inc
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Private RISC-V IOMMU MSI trap callback
+ *
+ * Copyright (C) 2021-2023, Rivos Inc.
+ */
+
+/* Shared privately with the deterministic trap callback unit tests. */
+
+/*
+ * Translations matching MSI pattern check are redirected to "riscv-iommu-trap"
+ * memory region as untranslated address, for additional MSI/MRIF interception
+ * by IOMMU interrupt remapping implementation.
+ * Note: Device emulation code generating an MSI is expected to provide a valid
+ * memory transaction attributes with requested_id set.
+ */
+static MemTxResult riscv_iommu_trap_write(void *opaque, hwaddr addr,
+    uint64_t data, unsigned size, MemTxAttrs attrs)
+{
+    RISCVIOMMUState *s = opaque;
+    RISCVIOMMUContext *ctx;
+    MemTxResult res;
+    void *ref;
+    uint32_t devid = attrs.requester_id;
+    IOMMUTLBEntry iotlb = {
+        .iova = addr,
+        .target_as = s->target_as,
+        .addr_mask = ~0ULL,
+        .perm = IOMMU_WO,
+    };
+    int cause;
+
+    if (attrs.unspecified) {
+        return MEMTX_ACCESS_ERROR;
+    }
+
+    /* FIXME: PCIe bus remapping for attached endpoints. */
+    devid |= s->bus << 8;
+
+    ctx = riscv_iommu_ctx(s, devid, attrs.pid, IOMMU_WO, addr, &ref);
+    if (ctx == NULL) {
+        res = MEMTX_ACCESS_ERROR;
+    } else {
+        /*
+         * The trap address is the original IOVA. Resolve the MSI GPA
+         * without consulting or updating the translation cache.
+         * Exclude this internal replay from the modeled HPM events.
+         */
+        cause = riscv_iommu_spa_fetch(s, ctx, &iotlb, false);
+        if (cause) {
+            riscv_iommu_report_fault(s, ctx,
+                RISCV_IOMMU_FQ_TTYPE_UADDR_WR, cause,
+                !!(ctx->tc & RISCV_IOMMU_DC_TC_PDTV),
+                addr, iotlb.translated_addr);
+            res = MEMTX_ACCESS_ERROR;
+        } else if (iotlb.target_as == &s->trap_as) {
+            res = riscv_iommu_msi_write(s, ctx, addr,
+                                       iotlb.translated_addr, data,
+                                       size, attrs);
+        } else {
+            /* The mapping may have changed since the original walk. */
+            data = cpu_to_le64(data);
+            res = dma_memory_write(iotlb.target_as, iotlb.translated_addr,
+                                   &data, size, attrs);
+        }
+    }
+    riscv_iommu_ctx_put(s, ref);
+    return res;
+}
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 5752a4776b..cb98840121 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2599,66 +2599,7 @@ static const MemoryRegionOps riscv_iommu_mmio_ops = {
     }
 };
 
-/*
- * Translations matching MSI pattern check are redirected to "riscv-iommu-trap"
- * memory region as untranslated address, for additional MSI/MRIF interception
- * by IOMMU interrupt remapping implementation.
- * Note: Device emulation code generating an MSI is expected to provide a valid
- * memory transaction attributes with requested_id set.
- */
-static MemTxResult riscv_iommu_trap_write(void *opaque, hwaddr addr,
-    uint64_t data, unsigned size, MemTxAttrs attrs)
-{
-    RISCVIOMMUState* s = (RISCVIOMMUState *)opaque;
-    RISCVIOMMUContext *ctx;
-    MemTxResult res;
-    void *ref;
-    uint32_t devid = attrs.requester_id;
-    IOMMUTLBEntry iotlb = {
-        .iova = addr,
-        .target_as = s->target_as,
-        .addr_mask = ~0ULL,
-        .perm = IOMMU_WO,
-    };
-    int cause;
-
-    if (attrs.unspecified) {
-        return MEMTX_ACCESS_ERROR;
-    }
-
-    /* FIXME: PCIe bus remapping for attached endpoints. */
-    devid |= s->bus << 8;
-
-    ctx = riscv_iommu_ctx(s, devid, attrs.pid, IOMMU_WO, addr, &ref);
-    if (ctx == NULL) {
-        res = MEMTX_ACCESS_ERROR;
-    } else {
-        /*
-         * The trap address is the original IOVA. Resolve the MSI GPA
-         * without consulting or updating the translation cache.
-         * Exclude this internal replay from the modeled HPM events.
-         */
-        cause = riscv_iommu_spa_fetch(s, ctx, &iotlb, false);
-        if (cause) {
-            riscv_iommu_report_fault(s, ctx,
-                RISCV_IOMMU_FQ_TTYPE_UADDR_WR, cause,
-                !!(ctx->tc & RISCV_IOMMU_DC_TC_PDTV),
-                addr, iotlb.translated_addr);
-            res = MEMTX_ACCESS_ERROR;
-        } else if (iotlb.target_as == &s->trap_as) {
-            res = riscv_iommu_msi_write(s, ctx, addr,
-                                       iotlb.translated_addr, data,
-                                       size, attrs);
-        } else {
-            /* The mapping may have changed since the original walk. */
-            data = cpu_to_le64(data);
-            res = dma_memory_write(iotlb.target_as, iotlb.translated_addr,
-                                   &data, size, attrs);
-        }
-    }
-    riscv_iommu_ctx_put(s, ref);
-    return res;
-}
+#include "riscv-iommu-trap.c.inc"
 
 static MemTxResult riscv_iommu_trap_read(void *opaque, hwaddr addr,
     uint64_t *data, unsigned size, MemTxAttrs attrs)
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 37b561d4a7..e4c425fbad 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -132,6 +132,7 @@ if have_system
     'test-iov': [],
     'test-opts-visitor': [testqapi],
     'test-xs-node': [qom],
+    'test-riscv-iommu-trap': [],
     'test-virtio-dmabuf': [meson.project_source_root() / 'hw/display/virtio-dmabuf.c'],
     'test-qmp-cmds': [testqapi],
     'test-xbzrle': [migration],
diff --git a/tests/unit/test-riscv-iommu-trap.c b/tests/unit/test-riscv-iommu-trap.c
new file mode 100644
index 0000000000..d4753c7f31
--- /dev/null
+++ b/tests/unit/test-riscv-iommu-trap.c
@@ -0,0 +1,266 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Deterministic tests of the private RISC-V IOMMU MSI trap callback. */
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "hw/riscv/riscv-iommu.h"
+
+#define TEST_IOVA       0x400040ull
+#define TEST_GPA        0x28000040ull
+#define TEST_DATA       0x1122334455667788ull
+
+static struct {
+    RISCVIOMMUState state;
+    RISCVIOMMUContext ctx;
+    unsigned ref_cookie;
+    AddressSpace physical_as;
+    AddressSpace changed_as;
+    MemTxAttrs attrs;
+    bool missing_ctx;
+    int walk_fault;
+    AddressSpace *walk_as;
+    hwaddr walk_addr;
+    MemTxResult msi_result;
+    MemTxResult dma_result;
+    unsigned size;
+    unsigned ctx_calls;
+    unsigned put_calls;
+    unsigned walk_calls;
+    unsigned msi_calls;
+    unsigned fault_calls;
+    unsigned dma_calls;
+} test;
+
+static void assert_attrs(MemTxAttrs attrs)
+{
+    g_assert_cmpuint(attrs.requester_id, ==, test.attrs.requester_id);
+    g_assert_cmpuint(attrs.pid, ==, test.attrs.pid);
+    g_assert_cmpuint(attrs.secure, ==, test.attrs.secure);
+    g_assert_cmpuint(attrs.space, ==, test.attrs.space);
+    g_assert_cmpuint(attrs.user, ==, test.attrs.user);
+    g_assert_cmpuint(attrs.memory, ==, test.attrs.memory);
+    g_assert_cmpuint(attrs.debug, ==, test.attrs.debug);
+    g_assert_cmpuint(attrs.address_type, ==, test.attrs.address_type);
+    g_assert_cmpuint(attrs.unspecified, ==, test.attrs.unspecified);
+}
+
+static RISCVIOMMUContext *test_ctx(RISCVIOMMUState *s, unsigned devid,
+                                 unsigned pid, IOMMUAccessFlags perm,
+                                 uint64_t iova, void **ref)
+{
+    g_assert_true(s == &test.state);
+    g_assert_cmpuint(devid, ==,
+                     test.attrs.requester_id | (test.state.bus << 8));
+    g_assert_cmpuint(pid, ==, test.attrs.pid);
+    g_assert_cmpuint(perm, ==, IOMMU_WO);
+    g_assert_cmphex(iova, ==, TEST_IOVA);
+    test.ctx_calls++;
+    /* Cached contexts return a separate reference for ctx_put(). */
+    *ref = test.missing_ctx ? NULL : &test.ref_cookie;
+    return test.missing_ctx ? NULL : &test.ctx;
+}
+
+static void test_ctx_put(RISCVIOMMUState *s, void *ref)
+{
+    g_assert_true(s == &test.state);
+    g_assert_true(ref == (test.missing_ctx ? NULL : &test.ref_cookie));
+    test.put_calls++;
+}
+
+static int test_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
+                          IOMMUTLBEntry *iotlb, bool update_hpm)
+{
+    g_assert_true(s == &test.state);
+    g_assert_true(ctx == &test.ctx);
+    g_assert_cmphex(iotlb->iova, ==, TEST_IOVA);
+    g_assert_true(iotlb->target_as == &test.physical_as);
+    g_assert_cmphex(iotlb->addr_mask, ==, UINT64_MAX);
+    g_assert_cmpuint(iotlb->perm, ==, IOMMU_WO);
+    g_assert_false(update_hpm);
+    test.walk_calls++;
+    iotlb->target_as = test.walk_as;
+    iotlb->translated_addr = test.walk_addr;
+    return test.walk_fault;
+}
+
+static MemTxResult test_msi_write(RISCVIOMMUState *s,
+                                  RISCVIOMMUContext *ctx, uint64_t iova,
+                                  uint64_t gpa, uint64_t data, unsigned size,
+                                  MemTxAttrs attrs)
+{
+    g_assert_true(s == &test.state);
+    g_assert_true(ctx == &test.ctx);
+    g_assert_cmphex(iova, ==, TEST_IOVA);
+    g_assert_cmphex(gpa, ==, test.walk_addr);
+    g_assert_cmphex(iova, !=, gpa);
+    g_assert_cmphex(data, ==, TEST_DATA);
+    g_assert_cmpuint(size, ==, test.size);
+    assert_attrs(attrs);
+    test.msi_calls++;
+    return test.msi_result;
+}
+
+static void test_report_fault(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
+                              uint32_t ttype, uint32_t cause, bool pv,
+                              uint64_t iotval, uint64_t iotval2)
+{
+    g_assert_true(s == &test.state);
+    g_assert_true(ctx == &test.ctx);
+    g_assert_cmpuint(ttype, ==, RISCV_IOMMU_FQ_TTYPE_UADDR_WR);
+    g_assert_cmpuint(cause, ==, test.walk_fault);
+    /* Check the existing callback policy, not the complete PID/DPE model. */
+    g_assert_cmpuint(pv, ==, !!(test.ctx.tc & RISCV_IOMMU_DC_TC_PDTV));
+    g_assert_cmphex(iotval, ==, TEST_IOVA);
+    g_assert_cmphex(iotval2, ==, test.walk_addr);
+    test.fault_calls++;
+}
+
+static MemTxResult test_dma_write(AddressSpace *as, dma_addr_t addr,
+                                  const void *buf, dma_addr_t len,
+                                  MemTxAttrs attrs)
+{
+    static const uint8_t expected[] = {
+        0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22, 0x11,
+    };
+
+    g_assert_true(as == &test.changed_as);
+    g_assert_cmphex(addr, ==, test.walk_addr);
+    g_assert_cmpuint(len, ==, test.size);
+    g_assert_cmpmem(buf, len, expected, len);
+    assert_attrs(attrs);
+    test.dma_calls++;
+    return test.dma_result;
+}
+
+/* Redirect dependencies only while compiling the private implementation. */
+#define riscv_iommu_ctx test_ctx
+#define riscv_iommu_ctx_put test_ctx_put
+#define riscv_iommu_spa_fetch test_spa_fetch
+#define riscv_iommu_msi_write test_msi_write
+#define riscv_iommu_report_fault test_report_fault
+#define dma_memory_write test_dma_write
+#include "hw/riscv/riscv-iommu-trap.c.inc"
+#undef riscv_iommu_ctx
+#undef riscv_iommu_ctx_put
+#undef riscv_iommu_spa_fetch
+#undef riscv_iommu_msi_write
+#undef riscv_iommu_report_fault
+#undef dma_memory_write
+
+static void reset_test(void)
+{
+    memset(&test, 0, sizeof(test));
+    test.state.target_as = &test.physical_as;
+    test.state.bus = 0x80;
+    test.attrs = (MemTxAttrs) {
+        .requester_id = 0x3456,
+        .pid = 0x5a,
+        .secure = true,
+        .space = 1,
+        .user = true,
+        .memory = true,
+        .debug = true,
+        .address_type = 1,
+    };
+    test.ctx.process_id = test.attrs.pid;
+    test.walk_as = &test.state.trap_as;
+    test.walk_addr = TEST_GPA;
+    test.size = 4;
+}
+
+static MemTxResult trap_write(void)
+{
+    return riscv_iommu_trap_write(&test.state, TEST_IOVA, TEST_DATA,
+                                  test.size, test.attrs);
+}
+
+static void assert_calls(unsigned ctx, unsigned walk, unsigned msi,
+                         unsigned fault, unsigned dma)
+{
+    g_assert_cmpuint(test.ctx_calls, ==, ctx);
+    g_assert_cmpuint(test.put_calls, ==, ctx);
+    g_assert_cmpuint(test.walk_calls, ==, walk);
+    g_assert_cmpuint(test.msi_calls, ==, msi);
+    g_assert_cmpuint(test.fault_calls, ==, fault);
+    g_assert_cmpuint(test.dma_calls, ==, dma);
+}
+
+static void test_unspecified(void)
+{
+    reset_test();
+    test.attrs.unspecified = true;
+    g_assert_cmpuint(trap_write(), ==, MEMTX_ACCESS_ERROR);
+    assert_calls(0, 0, 0, 0, 0);
+}
+
+static void test_missing_context(void)
+{
+    reset_test();
+    test.missing_ctx = true;
+    g_assert_cmpuint(trap_write(), ==, MEMTX_ACCESS_ERROR);
+    assert_calls(1, 0, 0, 0, 0);
+}
+
+static void test_msi_forward(void)
+{
+    reset_test();
+    test.size = 8;
+    test.msi_result = MEMTX_ERROR;
+    g_assert_cmpuint(trap_write(), ==, MEMTX_ERROR);
+    assert_calls(1, 1, 1, 0, 0);
+}
+
+static void test_rewalk_fault(gconstpointer data)
+{
+    reset_test();
+    test.attrs.pid = 0;
+    test.ctx.process_id = 0;
+    test.ctx.tc = data ? RISCV_IOMMU_DC_TC_PDTV : 0;
+    test.walk_fault = RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS;
+    g_assert_cmpuint(trap_write(), ==, MEMTX_ACCESS_ERROR);
+    assert_calls(1, 1, 0, 1, 0);
+}
+
+typedef struct FallbackCase {
+    const char *name;
+    unsigned size;
+    MemTxResult result;
+} FallbackCase;
+
+static void test_fallback(gconstpointer data)
+{
+    const FallbackCase *cfg = data;
+
+    reset_test();
+    test.size = cfg->size;
+    test.walk_as = &test.changed_as;
+    test.walk_addr = 0x90000040;
+    test.dma_result = cfg->result;
+    g_assert_cmpuint(trap_write(), ==, cfg->result);
+    assert_calls(1, 1, 0, 0, 1);
+}
+
+int main(int argc, char **argv)
+{
+    static const FallbackCase fallback_cases[] = {
+        { "fallback-4-success", 4, MEMTX_OK },
+        { "fallback-4-error", 4, MEMTX_ERROR },
+        { "fallback-8-success", 8, MEMTX_OK },
+        { "fallback-8-error", 8, MEMTX_ERROR },
+    };
+
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/riscv-iommu/trap/unspecified", test_unspecified);
+    g_test_add_func("/riscv-iommu/trap/missing-context", test_missing_context);
+    g_test_add_func("/riscv-iommu/trap/msi-forward", test_msi_forward);
+    g_test_add_data_func("/riscv-iommu/trap/rewalk-fault-pdtv-off", NULL,
+                         test_rewalk_fault);
+    g_test_add_data_func("/riscv-iommu/trap/rewalk-fault-pdtv-on",
+                         GUINT_TO_POINTER(1), test_rewalk_fault);
+    for (unsigned i = 0; i < G_N_ELEMENTS(fallback_cases); i++) {
+        g_autofree char *path = g_strdup_printf("/riscv-iommu/trap/%s",
+                                               fallback_cases[i].name);
+
+        g_test_add_data_func(path, &fallback_cases[i], test_fallback);
+    }
+    return g_test_run();
+}
-- 
2.43.0


