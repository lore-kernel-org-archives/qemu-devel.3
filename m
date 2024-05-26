Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C25C41513
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 23:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN5G-00067z-VU; Sun, 26 May 2024 19:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN5D-0005ox-Qs; Sun, 26 May 2024 19:15:20 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN57-0003os-46; Sun, 26 May 2024 19:15:19 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5D0D14E6428;
 Mon, 27 May 2024 01:13:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 4S8-mECnrmcQ; Mon, 27 May 2024 01:12:59 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6AF6F4E62C1; Mon, 27 May 2024 01:12:59 +0200 (CEST)
Message-Id: <f09e49e0e0e400e67ac0c61164ca3937ee8cc335.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 23/43] target/ppc/mmu_common.c: Rename function parameter
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:12:59 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Rename parameter of get_bat_6xx_tlb() from virtual to eaddr to match
other functions.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index ede409eb99..110936ca83 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -221,7 +221,7 @@ static inline void bat_size_prot(CPUPPCState *env, target_ulong *blp,
 }
 
 static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
-                           target_ulong virtual, MMUAccessType access_type)
+                           target_ulong eaddr, MMUAccessType access_type)
 {
     target_ulong *BATlt, *BATut, *BATu, *BATl;
     target_ulong BEPIl, BEPIu, bl;
@@ -230,7 +230,7 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
     bool ifetch = access_type == MMU_INST_FETCH;
 
     qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT v " TARGET_FMT_lx "\n", __func__,
-                  ifetch ? 'I' : 'D', virtual);
+                  ifetch ? 'I' : 'D', eaddr);
     if (ifetch) {
         BATlt = env->IBAT[1];
         BATut = env->IBAT[0];
@@ -246,15 +246,15 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
         bat_size_prot(env, &bl, &valid, &prot, BATu, BATl);
         qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v " TARGET_FMT_lx " BATu "
                       TARGET_FMT_lx " BATl " TARGET_FMT_lx "\n", __func__,
-                      ifetch ? 'I' : 'D', i, virtual, *BATu, *BATl);
-        if ((virtual & 0xF0000000) == BEPIu &&
-            ((virtual & 0x0FFE0000) & ~bl) == BEPIl) {
+                      ifetch ? 'I' : 'D', i, eaddr, *BATu, *BATl);
+        if ((eaddr & 0xF0000000) == BEPIu &&
+            ((eaddr & 0x0FFE0000) & ~bl) == BEPIl) {
             /* BAT matches */
             if (valid != 0) {
                 /* Get physical address */
                 ctx->raddr = (*BATl & 0xF0000000) |
-                    ((virtual & 0x0FFE0000 & bl) | (*BATl & 0x0FFE0000)) |
-                    (virtual & 0x0001F000);
+                    ((eaddr & 0x0FFE0000 & bl) | (*BATl & 0x0FFE0000)) |
+                    (eaddr & 0x0001F000);
                 /* Compute access rights */
                 ctx->prot = prot;
                 if (check_prot_access_type(ctx->prot, access_type)) {
@@ -273,7 +273,7 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
     if (ret < 0) {
         if (qemu_log_enabled()) {
             qemu_log_mask(CPU_LOG_MMU, "no BAT match for "
-                          TARGET_FMT_lx ":\n", virtual);
+                          TARGET_FMT_lx ":\n", eaddr);
             for (i = 0; i < 4; i++) {
                 BATu = &BATut[i];
                 BATl = &BATlt[i];
@@ -284,7 +284,7 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
                               " BATu " TARGET_FMT_lx " BATl " TARGET_FMT_lx
                               "\n\t" TARGET_FMT_lx " " TARGET_FMT_lx " "
                               TARGET_FMT_lx "\n", __func__, ifetch ? 'I' : 'D',
-                              i, virtual, *BATu, *BATl, BEPIu, BEPIl, bl);
+                              i, eaddr, *BATu, *BATl, BEPIu, BEPIl, bl);
             }
         }
     }
-- 
2.30.9


