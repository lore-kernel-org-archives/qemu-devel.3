Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5F5C3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Nt-0001yH-9A; Thu, 25 Jul 2024 20:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8NE-0006CH-2n; Thu, 25 Jul 2024 19:59:53 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8NC-00023V-68; Thu, 25 Jul 2024 19:59:51 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70d399da0b5so389172b3a.3; 
 Thu, 25 Jul 2024 16:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951988; x=1722556788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ITmPyk2E76hiDCN3lwNEogZo41oLGG4A+4EUjpfljA=;
 b=cl8mH0hlPqztgSrKhHeErPNb8We70tgEF6L57u8GCzrn5NoY5BPgLV4DeIN0jg4gdy
 gxQS84oFX1SGhHOEFdBmem7BxvnRnS45hOKE3HssgCbkPAbL1R89BAORovXG+bsRsXII
 VCw+AyFKv05klVYI2ArcxHZh1zL9Z2cD0jyWCz3nmYxcdunN/boAb8Z4ESn9Aa4lLGvj
 5cZfXyuZoUc1+1fgAcQ+K9sFm+aGgyT1TtycnSKswHiG2TPxqaLm/Ihn93kRCFSHRh24
 ZM8tyS+OM0b/HQZjOqCCOjxFBJTzG+1vrox+EGLq7dCratIAypm0VXc48yrJZdLrbi/n
 O4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951988; x=1722556788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ITmPyk2E76hiDCN3lwNEogZo41oLGG4A+4EUjpfljA=;
 b=LZw8OFWoVrsBuPtGCc9WMUx/zeOBXp8Htq+pKS/IRL5/kU9o1LIH23LknYC8tMKyH0
 FoqEZX0Zhci9ta/+Y3oMjnizMO9ImpK89DvyGIEafhgEGXU1ZB5z+bHNFz3DUufZbwvU
 tAZ0BB+0c8O0ZjmWqtwfcXxzoiqVChqUWLcisENGWk5YIFl3GYZoaXhl6/xlV3Caip+v
 eu7hFeJXcpVyNll/xw8U/QjpkWBGHrei0Px4Q5FBMfQ0TUL0I3Ku9fyRRvY6hsZsmcbX
 HpB5GtQvE3rqHJ7xa43pEKoviX0DFa0MrKGzJKL2kPBRHY2F1qaAl/bUKDoiQY9FSG5y
 Ee1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNhBjrsnlqZduuc5zOPyQxY12r75NkoPFMU3AW8qHZWwTIRU2hciltQhOVoqAsHmN4ahUjlSjd0d+1xWhZHSaNvYTV
X-Gm-Message-State: AOJu0YxGGRDlp6URgisF1tWgZBl9TxTsrAz49IH4r9A1XIH1mZ8EbEkV
 7xklJRB8E2sQZM5AXLkVCr1mT+vgHa4AyIUeh7tixPAvtF9LFX96WXWagg==
X-Google-Smtp-Source: AGHT+IFhb5x8x85ONKywTG11o8OfdbZ7Crde+Cr8hMG0QJcCe6aeLS0W4MLcyE6iV+hHikWWxQUyeg==
X-Received: by 2002:a05:6a20:3955:b0:1c4:2132:e205 with SMTP id
 adf61e73a8af0-1c47b43dfa9mr3937493637.48.1721951988218; 
 Thu, 25 Jul 2024 16:59:48 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:59:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 94/96] target/ppc: Unexport some functions from mmu-book3s-v3.h
Date: Fri, 26 Jul 2024 09:54:07 +1000
Message-ID: <20240725235410.451624-95-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The ppc_hash64_hpt_base() and ppc_hash64_hpt_mask() functions are
mostly used by mmu-hash64.c only but there is one call to
ppc_hash64_hpt_mask() in hw/ppc/spapr_vhyp_mmu.c.in a helper function
that can be moved to mmu-hash64.c which allows these functions to be
removed from the header.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_vhyp_mmu.c    | 21 ++++------------
 target/ppc/mmu-book3s-v3.h | 40 -------------------------------
 target/ppc/mmu-hash64.c    | 49 ++++++++++++++++++++++++++++++++++++++
 target/ppc/mmu-hash64.h    |  1 +
 4 files changed, 54 insertions(+), 57 deletions(-)

diff --git a/hw/ppc/spapr_vhyp_mmu.c b/hw/ppc/spapr_vhyp_mmu.c
index b3dd8b3a59..2d41d7f77b 100644
--- a/hw/ppc/spapr_vhyp_mmu.c
+++ b/hw/ppc/spapr_vhyp_mmu.c
@@ -15,19 +15,6 @@
 #include "helper_regs.h"
 #include "hw/ppc/spapr.h"
 #include "mmu-hash64.h"
-#include "mmu-book3s-v3.h"
-
-
-static inline bool valid_ptex(PowerPCCPU *cpu, target_ulong ptex)
-{
-    /*
-     * hash value/pteg group index is normalized by HPT mask
-     */
-    if (((ptex & ~7ULL) / HPTES_PER_GROUP) & ~ppc_hash64_hpt_mask(cpu)) {
-        return false;
-    }
-    return true;
-}
 
 static target_ulong h_enter(PowerPCCPU *cpu, SpaprMachineState *spapr,
                             target_ulong opcode, target_ulong *args)
@@ -70,7 +57,7 @@ static target_ulong h_enter(PowerPCCPU *cpu, SpaprMachineState *spapr,
 
     pteh &= ~0x60ULL;
 
-    if (!valid_ptex(cpu, ptex)) {
+    if (!ppc_hash64_valid_ptex(cpu, ptex)) {
         return H_PARAMETER;
     }
 
@@ -119,7 +106,7 @@ static RemoveResult remove_hpte(PowerPCCPU *cpu
     const ppc_hash_pte64_t *hptes;
     target_ulong v, r;
 
-    if (!valid_ptex(cpu, ptex)) {
+    if (!ppc_hash64_valid_ptex(cpu, ptex)) {
         return REMOVE_PARM;
     }
 
@@ -250,7 +237,7 @@ static target_ulong h_protect(PowerPCCPU *cpu, SpaprMachineState *spapr,
     const ppc_hash_pte64_t *hptes;
     target_ulong v, r;
 
-    if (!valid_ptex(cpu, ptex)) {
+    if (!ppc_hash64_valid_ptex(cpu, ptex)) {
         return H_PARAMETER;
     }
 
@@ -287,7 +274,7 @@ static target_ulong h_read(PowerPCCPU *cpu, SpaprMachineState *spapr,
     int i, ridx, n_entries = 1;
     const ppc_hash_pte64_t *hptes;
 
-    if (!valid_ptex(cpu, ptex)) {
+    if (!ppc_hash64_valid_ptex(cpu, ptex)) {
         return H_PARAMETER;
     }
 
diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index f3f7993958..263ce55c1f 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -83,46 +83,6 @@ static inline bool ppc64_v3_radix(PowerPCCPU *cpu)
     return !!(cpu->env.spr[SPR_LPCR] & LPCR_HR);
 }
 
-static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
-{
-    uint64_t base;
-
-    if (cpu->vhyp) {
-        return 0;
-    }
-    if (cpu->env.mmu_model == POWERPC_MMU_3_00) {
-        ppc_v3_pate_t pate;
-
-        if (!ppc64_v3_get_pate(cpu, cpu->env.spr[SPR_LPIDR], &pate)) {
-            return 0;
-        }
-        base = pate.dw0;
-    } else {
-        base = cpu->env.spr[SPR_SDR1];
-    }
-    return base & SDR_64_HTABORG;
-}
-
-static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
-{
-    uint64_t base;
-
-    if (cpu->vhyp) {
-        return cpu->vhyp_class->hpt_mask(cpu->vhyp);
-    }
-    if (cpu->env.mmu_model == POWERPC_MMU_3_00) {
-        ppc_v3_pate_t pate;
-
-        if (!ppc64_v3_get_pate(cpu, cpu->env.spr[SPR_LPIDR], &pate)) {
-            return 0;
-        }
-        base = pate.dw0;
-    } else {
-        base = cpu->env.spr[SPR_SDR1];
-    }
-    return (1ULL << ((base & SDR_64_HTABSIZE) + 18 - 7)) - 1;
-}
-
 #endif /* TARGET_PPC64 */
 
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index cbc8efa0c3..7bc0323f26 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -508,6 +508,46 @@ static int ppc_hash64_amr_prot(PowerPCCPU *cpu, ppc_hash_pte64_t pte)
     return prot;
 }
 
+static hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
+{
+    uint64_t base;
+
+    if (cpu->vhyp) {
+        return 0;
+    }
+    if (cpu->env.mmu_model == POWERPC_MMU_3_00) {
+        ppc_v3_pate_t pate;
+
+        if (!ppc64_v3_get_pate(cpu, cpu->env.spr[SPR_LPIDR], &pate)) {
+            return 0;
+        }
+        base = pate.dw0;
+    } else {
+        base = cpu->env.spr[SPR_SDR1];
+    }
+    return base & SDR_64_HTABORG;
+}
+
+static hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
+{
+    uint64_t base;
+
+    if (cpu->vhyp) {
+        return cpu->vhyp_class->hpt_mask(cpu->vhyp);
+    }
+    if (cpu->env.mmu_model == POWERPC_MMU_3_00) {
+        ppc_v3_pate_t pate;
+
+        if (!ppc64_v3_get_pate(cpu, cpu->env.spr[SPR_LPIDR], &pate)) {
+            return 0;
+        }
+        base = pate.dw0;
+    } else {
+        base = cpu->env.spr[SPR_SDR1];
+    }
+    return (1ULL << ((base & SDR_64_HTABSIZE) + 18 - 7)) - 1;
+}
+
 const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCCPU *cpu,
                                              hwaddr ptex, int n)
 {
@@ -545,6 +585,15 @@ void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const ppc_hash_pte64_t *hptes,
                         false, n * HASH_PTE_SIZE_64);
 }
 
+bool ppc_hash64_valid_ptex(PowerPCCPU *cpu, target_ulong ptex)
+{
+    /* hash value/pteg group index is normalized by HPT mask */
+    if (((ptex & ~7ULL) / HPTES_PER_GROUP) & ~ppc_hash64_hpt_mask(cpu)) {
+        return false;
+    }
+    return true;
+}
+
 static unsigned hpte_page_shift(const PPCHash64SegmentPageSizes *sps,
                                 uint64_t pte0, uint64_t pte1)
 {
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index de653fcae5..ae8d4b37ae 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -120,6 +120,7 @@ const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCCPU *cpu,
                                              hwaddr ptex, int n);
 void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const ppc_hash_pte64_t *hptes,
                             hwaddr ptex, int n);
+bool ppc_hash64_valid_ptex(PowerPCCPU *cpu, target_ulong ptex);
 
 static inline uint64_t ppc_hash64_hpte0(PowerPCCPU *cpu,
                                         const ppc_hash_pte64_t *hptes, int i)
-- 
2.45.2


