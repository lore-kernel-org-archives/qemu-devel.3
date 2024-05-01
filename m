Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AE7C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 23:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Jbo-0002LQ-Q5; Wed, 01 May 2024 19:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s2Jbk-0002HA-TW; Wed, 01 May 2024 19:43:28 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s2Jbj-00052A-2X; Wed, 01 May 2024 19:43:28 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 92E2E4E602F;
 Thu, 02 May 2024 01:43:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Q21O1jzRNDS8; Thu,  2 May 2024 01:43:23 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9E21B4E6041; Thu, 02 May 2024 01:43:23 +0200 (CEST)
Message-Id: <d8ec88b4c583bfbf5f084ff43067620ede3d6552.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1714606359.git.balaton@eik.bme.hu>
References: <cover.1714606359.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 17/28] target/ppc/mmu_common.c: Fix misindented
 qemu_log_mask() calls
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 02 May 2024 01:43:23 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Fix several qemu_log_mask() calls that are misindented.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 42 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index ebf18a751c..28847c32f2 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -297,8 +297,8 @@ static int ppc6xx_tlb_get_bat(CPUPPCState *env, mmu_ctx_t *ctx,
     int ret = -1;
     bool ifetch = access_type == MMU_INST_FETCH;
 
-     qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT v " TARGET_FMT_lx "\n", __func__,
-             ifetch ? 'I' : 'D', virtual);
+    qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT v " TARGET_FMT_lx "\n", __func__,
+                  ifetch ? 'I' : 'D', virtual);
     if (ifetch) {
         BATlt = env->IBAT[1];
         BATut = env->IBAT[0];
@@ -312,9 +312,9 @@ static int ppc6xx_tlb_get_bat(CPUPPCState *env, mmu_ctx_t *ctx,
         BEPIu = *BATu & 0xF0000000;
         BEPIl = *BATu & 0x0FFE0000;
         bat_size_prot(env, &bl, &valid, &prot, BATu, BATl);
-         qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v " TARGET_FMT_lx " BATu "
-                       TARGET_FMT_lx " BATl " TARGET_FMT_lx "\n", __func__,
-                       ifetch ? 'I' : 'D', i, virtual, *BATu, *BATl);
+        qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v " TARGET_FMT_lx " BATu "
+                      TARGET_FMT_lx " BATl " TARGET_FMT_lx "\n", __func__,
+                      ifetch ? 'I' : 'D', i, virtual, *BATu, *BATl);
         if ((virtual & 0xF0000000) == BEPIu &&
             ((virtual & 0x0FFE0000) & ~bl) == BEPIl) {
             /* BAT matches */
@@ -346,12 +346,11 @@ static int ppc6xx_tlb_get_bat(CPUPPCState *env, mmu_ctx_t *ctx,
                 BEPIu = *BATu & 0xF0000000;
                 BEPIl = *BATu & 0x0FFE0000;
                 bl = (*BATu & 0x00001FFC) << 15;
-                 qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v "
-                               TARGET_FMT_lx " BATu " TARGET_FMT_lx
-                               " BATl " TARGET_FMT_lx "\n\t" TARGET_FMT_lx " "
-                               TARGET_FMT_lx " " TARGET_FMT_lx "\n",
-                               __func__, ifetch ? 'I' : 'D', i, virtual,
-                               *BATu, *BATl, BEPIu, BEPIl, bl);
+                qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v " TARGET_FMT_lx
+                              " BATu " TARGET_FMT_lx " BATl " TARGET_FMT_lx
+                              "\n\t" TARGET_FMT_lx " " TARGET_FMT_lx " "
+                              TARGET_FMT_lx "\n", __func__, ifetch ? 'I' : 'D',
+                              i, virtual, *BATu, *BATl, BEPIu, BEPIl, bl);
             }
         }
     }
@@ -400,9 +399,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     hash = vsid ^ pgidx;
     ctx->ptem = (vsid << 7) | (pgidx >> 10);
 
-    qemu_log_mask(CPU_LOG_MMU,
-            "pte segment: key=%d ds %d nx %d vsid " TARGET_FMT_lx "\n",
-            ctx->key, ds, ctx->nx, vsid);
+    qemu_log_mask(CPU_LOG_MMU, "pte segment: key=%d ds %d nx %d vsid "
+                  TARGET_FMT_lx "\n", ctx->key, ds, ctx->nx, vsid);
     ret = -1;
     if (!ds) {
         /* Check if instruction fetch is allowed, if needed */
@@ -599,9 +597,9 @@ static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
             return 0;
         }
     }
-     qemu_log_mask(CPU_LOG_MMU, "%s: access refused " TARGET_FMT_lx
-                   " => " HWADDR_FMT_plx
-                   " %d %d\n", __func__, address, raddr, ctx->prot, ret);
+    qemu_log_mask(CPU_LOG_MMU, "%s: access refused " TARGET_FMT_lx
+                  " => " HWADDR_FMT_plx " %d %d\n",
+                  __func__, address, raddr, ctx->prot, ret);
 
     return ret;
 }
@@ -713,11 +711,11 @@ int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp,
     }
 
     mask = ~(booke206_tlb_to_page_size(env, tlb) - 1);
-     qemu_log_mask(CPU_LOG_MMU, "%s: TLB ADDR=0x" TARGET_FMT_lx
-                   " PID=0x%x MAS1=0x%x MAS2=0x%" PRIx64 " mask=0x%"
-                   HWADDR_PRIx " MAS7_3=0x%" PRIx64 " MAS8=0x%" PRIx32 "\n",
-                   __func__, address, pid, tlb->mas1, tlb->mas2, mask,
-                   tlb->mas7_3, tlb->mas8);
+    qemu_log_mask(CPU_LOG_MMU, "%s: TLB ADDR=0x" TARGET_FMT_lx
+                  " PID=0x%x MAS1=0x%x MAS2=0x%" PRIx64 " mask=0x%"
+                  HWADDR_PRIx " MAS7_3=0x%" PRIx64 " MAS8=0x%" PRIx32 "\n",
+                  __func__, address, pid, tlb->mas1, tlb->mas2, mask,
+                  tlb->mas7_3, tlb->mas8);
 
     /* Check PID */
     tlb_pid = (tlb->mas1 & MAS1_TID_MASK) >> MAS1_TID_SHIFT;
-- 
2.30.9


