Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4257FC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtje-0001Y3-Du; Wed, 19 Aug 2026 23:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjd-0001Uk-7Z
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:33 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjb-00044J-9D
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:32 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cbee846deecso1821362a12.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197590; x=1787802390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EDFMUC4WDu3hg73sBA3d+xAHHiRETvA/OxfHKXKbHcA=;
 b=phYotmFeGYlk02Hief/gCfH4LsDgdDoacE7iTHdqRxbxSsAoKo2qKXWsGhnsEFFpLo
 FOB2qvz9ZzH9C1L16a5Yh2jduWQmvHPvaCo/2Ivpq9ytoVkx1+m/yxgvyOEY50/5qWYm
 4SPg3JN3Au25UhYpqe+H4nsyqLylwYFZrqmAJhkXSf7Fne1alU+/Puie2PWqKANwqzGK
 rWho9ico8DILDKAjRPGBj2XJyOAMO4lGJ1Qykljrf5RB4jy92D0FS9ILv+4RKzT3DLCT
 kjtz9WtLgELTNloHvGKqnIyEYkrSRi3bmoAMyyx1ExDoTMqiSz51veTv6pSitmmYEIWw
 r+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197590; x=1787802390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EDFMUC4WDu3hg73sBA3d+xAHHiRETvA/OxfHKXKbHcA=;
 b=rDcccNqBEm7SA43cbyMU45y88Zd1wNBZMTBaWPwfZKEut3ae2L42BNEzJB+bQbzO5D
 VK8gh8IwSzDZIp6DFri3jExU2nNFkgmX9sn9X8434zqewYR1JWXxMUMw7ccji8I7fjAV
 KP0AlNuFY58sV1HLlEGYGhLLlnIAWvW9kcIy0EWUDjwEJ5fEaVC8GJPCJEUHjkCBEAec
 V4zpai9ASaMX6aoZniRqKeqsc5NmyuuXpIaGTQk8H34GvOEpQxQxWEcheTvHntgUPYtt
 X3zt0DxBXLFsmone3pnZ0UK3ghxIFzF20C1UJy3pwOmkaO5gBePsO2rhM7/RKTDgwLBE
 vAwA==
X-Gm-Message-State: AOJu0YxEsUP3LjS5eAxKQCYeLMXXbFSoQPfXeLXilRWaIJKLbo5WEXv6
 ozmFPN+Dj3S6puCm9U76pGchEmyG4AEfOriTFDMrDX+lHJf+7NiAOnB0v20DrQ==
X-Gm-Gg: AR+sD12UyAo4pxVZBo+c35d8hWrpacgrJf1vC1UUaB8HE17U3I8bshWQo1vk6YF+cA0
 HliuGOVys3t/q+dzpzSBSo7exHrlbrLC8QPxMFBre1hWVYQEx9fh9loJ8TMMVgaCCTwrbqHPryr
 82C6JaQx7S6pJZU5PY6gTHtXoXWAGXewZy9u9zwjOPX8umnH22XEnCCPDz1r5lQgsz2BH+Sxlmo
 vvCGqBWh7X4lDEVV/49bawakxSzbTs479xXFoSogdqr1kNr4oQJ+ZDyZ9Wf9rUkDBF4QMF1WgtX
 /TLGlpQq3pNhkbXK80GZE1Q+aIrh6fZwbCo5blJbmKlfJatDGrxW5Q0JnfsYHJ7cxCcCpatnzbv
 6jFtUbmrzwzd4rUnoJEmud6NLuC3aNNm8kyUS7N9eP4vkmL3ey7EcsWGjFVdqh3vSbRESC2Gu5I
 dInZ1QfaGZTwT2+R7w6ho4Tt53RGDtJS1M3ZtCZI5cnRwCJz0L9FRSyLfg5yk88qRrQ+Dns/DrU
 Ocpw8Y=
X-Received: by 2002:a05:6a20:3d19:b0:3bf:b1d3:393e with SMTP id
 adf61e73a8af0-3cd00dcb3dfmr19006012637.2.1787197589554; 
 Wed, 19 Aug 2026 20:46:29 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:46:29 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 35/93] hw/riscv/riscv-iommu: preserve requested perm in
 spa_fetch()
Date: Thu, 20 Aug 2026 13:43:32 +1000
Message-ID: <20260820034430.1186695-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
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

From: Andrew Jones <andrew.jones@oss.qualcomm.com>

b18e3f0e2d0f fixed spa_fetch() faults whose TTYP used the leaf PTE
permission instead of the original request permission.  However, it kept
that request-narrowed value in iotlb->perm after a successful walk, and
riscv_iommu_translate() caches iotlb->perm for later accesses to the same
IOVA.

That means a write to an RW mapping can cache the entry as write-only.
A later read then hits the cache and faults even though the mapping allows
it, which showed up in NVMe testing as bogus completions and controller
timeouts.

Keep the requested permission in a separate req_perm and use it for all
permission checks and fault-type decisions.  Accumulate the leaf
permissions separately and copy them to iotlb->perm only after the full
walk succeeds, so cached entries describe the mapping rather than the
current request.  Since faults leave iotlb->perm as the original request,
the S-stage and G-stage TTYP fixes remain intact.

Fixes: b18e3f0e2d0f ("hw/riscv/riscv-iommu.c: fix fault type for spa_fetch() faults")
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260717144525.1154204-1-andrew.jones@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 50 ++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 462087f401..f611c10c59 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -281,7 +281,7 @@ static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwaddr *out)
 static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     IOMMUTLBEntry *iotlb)
 {
-    IOMMUAccessFlags pte_perm;
+    IOMMUAccessFlags trans_perm = IOMMU_NONE;
     dma_addr_t addr, base;
     uint64_t satp, gatp, pte;
     bool en_s, en_g;
@@ -298,6 +298,14 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     } pass;
     MemTxResult ret;
     bool pv = !!ctx->process_id;
+    /*
+     * Keep the request permission separate from iotlb->perm.  G-stage
+     * walks translate S-stage PTE addresses before the real leaf is
+     * reached, but permission checks and fault types must still use the
+     * original request.  A successful walk leaves iotlb->perm with the
+     * effective leaf permission for the translation cache.
+     */
+    const IOMMUAccessFlags req_perm = iotlb->perm;
 
     satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
     gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
@@ -316,7 +324,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
      * means we can't do an early MSI check unless we have
      * strictly !en_s.
      */
-    if (!en_s && (iotlb->perm & IOMMU_WO) &&
+    if (!en_s && (req_perm & IOMMU_WO) &&
         riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
         iotlb->target_as = &s->trap_as;
         iotlb->translated_addr = iotlb->iova;
@@ -434,13 +442,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
                 masked_msbs = (addr >> (va_len - 1)) & mask;
 
                 if (masked_msbs != 0 && masked_msbs != mask) {
-                    return (iotlb->perm & IOMMU_WO) ?
+                    return (req_perm & IOMMU_WO) ?
                                 RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S :
                                 RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S;
                 }
             } else {
                 if ((addr & va_mask) != addr) {
-                    return (iotlb->perm & IOMMU_WO) ?
+                    return (req_perm & IOMMU_WO) ?
                                 RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
                                 RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS;
                 }
@@ -465,8 +473,8 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
                              MEMTXATTRS_UNSPECIFIED);
         }
         if (ret != MEMTX_OK) {
-            return (iotlb->perm & IOMMU_WO) ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT
-                                            : RISCV_IOMMU_FQ_CAUSE_RD_FAULT;
+            return (req_perm & IOMMU_WO) ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT
+                                         : RISCV_IOMMU_FQ_CAUSE_RD_FAULT;
         }
 
         sc[pass].step++;
@@ -491,13 +499,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
              * non-user mode leaf PTE and !pv we need to fault.
              */
             break;
-        } else if ((iotlb->perm & IOMMU_RO) && !(pte & PTE_R)) {
+        } else if ((req_perm & IOMMU_RO) && !(pte & PTE_R)) {
             break;                /* Read access check failed */
-        } else if ((iotlb->perm & IOMMU_WO) && !(pte & PTE_W)) {
+        } else if ((req_perm & IOMMU_WO) && !(pte & PTE_W)) {
             break;                /* Write access check failed */
         } else if (!ade && !(pte & PTE_A)) {
             break;                /* Access bit not set */
-        } else if ((iotlb->perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
+        } else if ((req_perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
             break;                /* Dirty bit not set */
         } else if (pass == G_STAGE && !(pte & PTE_U)) {
             /*
@@ -532,21 +540,20 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
                 addr = iotlb->iova;
                 continue;
             }
+
+            /* Cache the effective permission, not this request's subset. */
+            IOMMUAccessFlags leaf_perm = (pte & PTE_W) ?
+                                         ((pte & PTE_R) ? IOMMU_RW : IOMMU_WO) :
+                                         IOMMU_RO;
+
+            trans_perm = trans_perm == IOMMU_NONE ?
+                         leaf_perm : trans_perm & leaf_perm;
+
             /* Translation phase completed (GPA or SPA) */
             iotlb->translated_addr = base;
 
-            /*
-             * Do a bit_and between the PTE bits and the original
-             * request flags to determine the exact permission we
-             * need, i.e. if the original request is RO and the
-             * PTE has RW flags the actual perm is RO.
-             */
-            pte_perm = (pte & PTE_W) ? ((pte & PTE_R) ? IOMMU_RW : IOMMU_WO)
-                                     : IOMMU_RO;
-            iotlb->perm &= pte_perm;
-
             /* Check MSI GPA address match */
-            if (pass == S_STAGE && (iotlb->perm & IOMMU_WO) &&
+            if (pass == S_STAGE && (req_perm & IOMMU_WO) &&
                 riscv_iommu_msi_check(s, ctx, base)) {
                 /* Trap MSI writes and return GPA address. */
                 iotlb->target_as = &s->trap_as;
@@ -563,6 +570,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
                 continue;
             }
 
+            iotlb->perm = trans_perm;
             return 0;
         }
 
@@ -587,7 +595,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
      */
     iotlb->translated_addr = addr;
 
-    return (iotlb->perm & IOMMU_WO) ?
+    return (req_perm & IOMMU_WO) ?
                 (pass ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
                         RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S) :
                 (pass ? RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS :
-- 
2.54.0


