Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E651C25B77
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 01:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5bpm-0007vY-Hh; Fri, 10 May 2024 21:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5bpX-0006C3-0d; Fri, 10 May 2024 21:47:19 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5bpG-0003t4-QL; Fri, 10 May 2024 21:47:18 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5360E4E6792;
 Sat, 11 May 2024 03:46:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id LRrOzgfBKSOt; Sat, 11 May 2024 03:46:27 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 663C24E6793; Sat, 11 May 2024 03:46:27 +0200 (CEST)
Message-Id: <9555f71ccb02d1fc634568602e83492a87d606e6.1715390232.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715390232.git.balaton@eik.bme.hu>
References: <cover.1715390232.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 46/48] target/ppc/mmu_common.c: Convert local variable to
 bool
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Sat, 11 May 2024 03:46:27 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

In mmu6xx_get_physical_address() ds is used as bool, declare it as
such. Also use constant instead of hex value.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index e7431b904f..d15683e3e4 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -321,8 +321,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     PowerPCCPU *cpu = env_archcpu(env);
     hwaddr hash;
     target_ulong vsid, sr, pgidx;
-    int ds, target_page_bits;
-    bool pr, nx;
+    int target_page_bits;
+    bool pr, ds, nx;
 
     /* First try to find a BAT entry if there are any */
     if (env->nb_BATs && get_bat_6xx_tlb(env, ctx, eaddr, access_type) == 0) {
@@ -335,7 +335,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     sr = env->sr[eaddr >> 28];
     ctx->key = (((sr & 0x20000000) && pr) ||
                 ((sr & 0x40000000) && !pr)) ? 1 : 0;
-    ds = sr & 0x80000000 ? 1 : 0;
+    ds = sr & SR32_T;
     nx = sr & SR32_NX;
     vsid = sr & 0x00FFFFFF;
     target_page_bits = TARGET_PAGE_BITS;
-- 
2.30.9


