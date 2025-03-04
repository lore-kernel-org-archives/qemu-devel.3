Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE7CC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 23:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpbYX-0002H8-L8; Tue, 04 Mar 2025 18:20:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpbYV-0002GR-4C
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 18:20:07 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpbYR-0005on-2E
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 18:20:05 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38f403edb4eso3718720f8f.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 15:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741130399; x=1741735199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cDmsLECyh1lWtnAcqmQINo04yHjsZIx/j//AFNZo4aE=;
 b=DvShwWMkHdLnLOzMiXK5kmOI8+CouqNz8G4M2cqd2Wbcsd/Chd+rVR1IgP8jquhJeB
 jF7nZj//r34w5HZPOfJXHWLWYzysYWWQBRD1CF1RmkfJaaszaUHVKk+s1s52z7FpXspv
 LV/reYb/AiixSRfsfdlhb89ux68AyYWlNztCij5I5XaDFa/ya2NY+ILyTKNdRykH1mCX
 sEN9JXuLjY8ir2oEYqGe3k5aOtAbqSQQe6Mv7rmf89mCZe4EqnX7+lRLbPL38MFvr/0K
 f3FpHnQiukSxzOWkYayCvjnG73iCwSxf8BgxQe54fRSZ+qFVcaXGdfstjIhWz0DgJ2Si
 lGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741130399; x=1741735199;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cDmsLECyh1lWtnAcqmQINo04yHjsZIx/j//AFNZo4aE=;
 b=rE2ebo5saEW+mKXDERoQgqHUwkuPp3748IrzAdUKp9IfC9U4BVtohQWXnGR4Rf7nLI
 TmCO7tJv1gsH1V2FrvB3oa4LALftpwm/5mzeD8m0zvo5WS5ot4+WJ9+MGB0RbBWiXmrb
 0XtFfSDcDpII2Zdsl5ToPsd6TJ+fqzR3v3UDwnIGuzXa1SgrQ7Qddx2gJILjvRSeIWgX
 WHUELMo1rWsVAasPUBuaaNO8ARE84oDpwNjYFUsoIYdYHNlsS+A0znolTHh7lws++ZJw
 RUgqNisk7jW6zb27eUI3M/gCky2H3FxU3hfGSJu7l/1J0nbkPzrXbfMbdT4h8VunehhY
 zMig==
X-Gm-Message-State: AOJu0Yzp3lLbXIdYfXNXMteM17TFl0Mn/Hb2ifDcrB9U7mHMcpV7RacI
 gIPKE8KW9mKrzpjHziMqDBMDv7+KOlPHnAuGCFjWpkw3JnYZ57y2PcDkMM2bGzoBZPiBIGn0ECq
 3HFg=
X-Gm-Gg: ASbGncuChsDs7KvIZC21S7AuHv7JeQsAnSvl2nq0KG4TLpg+xSZf3KLZRb7tI2KPNjP
 LjVMT9eRTyJ0GrUiMaX9pvnKChkbuCHCQNsF4uDaRm8lhzvRmX2wui+zN9hLJix+M0t/2gC7CKL
 KpV7ap2tqIcnO9Soa5pRVsQzKvrE6Re/pxVYSgvzAqenExYvIizRrfgYU4ddfGMuj2rq9HTJ/fl
 4SRJP4JV9aE3yciRnfwn2wlVEHs4pXWvABqU7sNg2jaUcpjJtLUarJYz8NkSJT+zwTieGM51Mv8
 uW1/g2DaTJ3LqYtUzjpTDhXu+AHR6TvvYfEaon3yBp6tQzeUOTftiO+qXawT6jzf3Fh+njcre3s
 BOvkg3gqrUJo4q/NnV0E=
X-Google-Smtp-Source: AGHT+IGjgXkehsg2ZYkMcZ/jfreXBKgemzzI56u1y0hIUSZi/BLhlEv4GJ+zMIL0KfdUKl8qM10+xg==
X-Received: by 2002:a5d:6487:0:b0:38f:3b9b:6f91 with SMTP id
 ffacd0b85a97d-3911f74009fmr421470f8f.12.1741130398771; 
 Tue, 04 Mar 2025 15:19:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bbf2edf84sm99190215e9.40.2025.03.04.15.19.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 15:19:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/riscv/riscv-iommu: Get target page info using runtime
 helpers
Date: Wed,  5 Mar 2025 00:19:56 +0100
Message-ID: <20250304231956.34396-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Prefer runtime helpers to get target page size / mask / bits
rather than compile time definitions. This will help to build
these files once for all RISC-V binaries.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/riscv-iommu-pci.c |  4 +++-
 hw/riscv/riscv-iommu.c     | 29 +++++++++++++++--------------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
index 12451869e41..e2b893c5898 100644
--- a/hw/riscv/riscv-iommu-pci.c
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -23,6 +23,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/riscv/riscv_hart.h"
 #include "migration/vmstate.h"
+#include "exec/target_page.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/host-utils.h"
@@ -102,7 +103,8 @@ static void riscv_iommu_pci_realize(PCIDevice *dev, Error **errp)
     qdev_realize(DEVICE(iommu), NULL, errp);
 
     memory_region_init(&s->bar0, OBJECT(s), "riscv-iommu-bar0",
-        QEMU_ALIGN_UP(memory_region_size(&iommu->regs_mr), TARGET_PAGE_SIZE));
+                       QEMU_ALIGN_UP(memory_region_size(&iommu->regs_mr),
+                                     qemu_target_page_size()));
     memory_region_add_subregion(&s->bar0, 0, &iommu->regs_mr);
 
     pcie_endpoint_cap_init(dev, 0);
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index e7568ca227a..8bbb33b8b53 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -23,6 +23,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/riscv/riscv_hart.h"
 #include "migration/vmstate.h"
+#include "exec/target_page.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
 
@@ -300,14 +301,14 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
         iotlb->target_as = &s->trap_as;
         iotlb->translated_addr = iotlb->iova;
-        iotlb->addr_mask = ~TARGET_PAGE_MASK;
+        iotlb->addr_mask = ~qemu_target_page_mask();
         return 0;
     }
 
     /* Exit early for pass-through mode. */
     if (!(en_s || en_g)) {
         iotlb->translated_addr = iotlb->iova;
-        iotlb->addr_mask = ~TARGET_PAGE_MASK;
+        iotlb->addr_mask = ~qemu_target_page_mask();
         /* Allow R/W in pass-through mode */
         iotlb->perm = IOMMU_RW;
         return 0;
@@ -390,7 +391,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     do {
         const unsigned widened = (pass && !sc[pass].step) ? 2 : 0;
         const unsigned va_bits = widened + sc[pass].ptidxbits;
-        const unsigned va_skip = TARGET_PAGE_BITS + sc[pass].ptidxbits *
+        const unsigned va_skip = qemu_target_page_bits() + sc[pass].ptidxbits *
                                  (sc[pass].levels - 1 - sc[pass].step);
         const unsigned idx = (addr >> va_skip) & ((1 << va_bits) - 1);
         const dma_addr_t pte_addr = base + idx * sc[pass].ptesize;
@@ -448,7 +449,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             break;                /* Reserved leaf PTE flags: PTE_W */
         } else if ((pte & (PTE_R | PTE_W | PTE_X)) == (PTE_W | PTE_X)) {
             break;                /* Reserved leaf PTE flags: PTE_W + PTE_X */
-        } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1)) {
+        } else if (ppn & ((1ULL << (va_skip - qemu_target_page_bits())) - 1)) {
             break;                /* Misaligned PPN */
         } else if ((iotlb->perm & IOMMU_RO) && !(pte & PTE_R)) {
             break;                /* Read access check failed */
@@ -480,7 +481,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
                 riscv_iommu_msi_check(s, ctx, base)) {
                 /* Trap MSI writes and return GPA address. */
                 iotlb->target_as = &s->trap_as;
-                iotlb->addr_mask = ~TARGET_PAGE_MASK;
+                iotlb->addr_mask = ~qemu_target_page_mask();
                 return 0;
             }
 
@@ -950,7 +951,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
          *   device index: [23:16][15:7][6:0]
          */
         const int split = depth * 9 + 6 + dc_fmt;
-        addr |= ((ctx->devid >> split) << 3) & ~TARGET_PAGE_MASK;
+        addr |= ((ctx->devid >> split) << 3) & ~qemu_target_page_mask();
         if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
                             MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
             return RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT;
@@ -968,7 +969,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
     }
 
     /* index into device context entry page */
-    addr |= (ctx->devid * dc_len) & ~TARGET_PAGE_MASK;
+    addr |= (ctx->devid * dc_len) & ~qemu_target_page_mask();
 
     memset(&dc, 0, sizeof(dc));
     if (dma_memory_read(s->target_as, addr, &dc, dc_len,
@@ -1037,7 +1038,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
          * level. See IOMMU Specification, 2.2. Process-Directory-Table.
          */
         const int split = depth * 9 + 8;
-        addr |= ((ctx->process_id >> split) << 3) & ~TARGET_PAGE_MASK;
+        addr |= ((ctx->process_id >> split) << 3) & ~qemu_target_page_mask();
         if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
                             MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
             return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
@@ -1050,7 +1051,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
     }
 
     /* Leaf entry in PDT */
-    addr |= (ctx->process_id << 4) & ~TARGET_PAGE_MASK;
+    addr |= (ctx->process_id << 4) & ~qemu_target_page_mask();
     if (dma_memory_read(s->target_as, addr, &dc.ta, sizeof(uint64_t) * 2,
                         MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
         return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
@@ -1440,7 +1441,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     perm = iot ? iot->perm : IOMMU_NONE;
     if (perm != IOMMU_NONE) {
         iotlb->translated_addr = PPN_PHYS(iot->phys);
-        iotlb->addr_mask = ~TARGET_PAGE_MASK;
+        iotlb->addr_mask = ~qemu_target_page_mask();
         iotlb->perm = perm;
         fault = 0;
         goto done;
@@ -1481,7 +1482,7 @@ done:
                                RISCV_IOMMU_PREQ_HDR_PID, ctx->process_id);
         }
         pr.hdr = set_field(pr.hdr, RISCV_IOMMU_PREQ_HDR_DID, ctx->devid);
-        pr.payload = (iotlb->iova & TARGET_PAGE_MASK) |
+        pr.payload = (iotlb->iova & qemu_target_page_mask()) |
                      RISCV_IOMMU_PREQ_PAYLOAD_M;
         riscv_iommu_pri(s, &pr);
         return fault;
@@ -1683,7 +1684,7 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
                                        RISCV_IOMMU_CMD_IOTINVAL_GSCID);
             uint32_t pscid = get_field(cmd.dword0,
                                        RISCV_IOMMU_CMD_IOTINVAL_PSCID);
-            hwaddr iova = (cmd.dword1 << 2) & TARGET_PAGE_MASK;
+            hwaddr iova = (cmd.dword1 << 2) & qemu_target_page_mask();
 
             if (pscv) {
                 /* illegal command arguments IOTINVAL.GVMA & PSCV == 1 */
@@ -1715,7 +1716,7 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
                                        RISCV_IOMMU_CMD_IOTINVAL_GSCID);
             uint32_t pscid = get_field(cmd.dword0,
                                        RISCV_IOMMU_CMD_IOTINVAL_PSCID);
-            hwaddr iova = (cmd.dword1 << 2) & TARGET_PAGE_MASK;
+            hwaddr iova = (cmd.dword1 << 2) & qemu_target_page_mask();
             RISCVIOMMUTransTag transtag;
 
             if (gv) {
@@ -1928,7 +1929,7 @@ static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
             iova = RISCV_IOMMU_TR_RESPONSE_FAULT | (((uint64_t) fault) << 10);
         } else {
             iova = iotlb.translated_addr & ~iotlb.addr_mask;
-            iova >>= TARGET_PAGE_BITS;
+            iova >>= qemu_target_page_bits();
             iova &= RISCV_IOMMU_TR_RESPONSE_PPN;
 
             /* We do not support superpages (> 4kbs) for now */
-- 
2.47.1


