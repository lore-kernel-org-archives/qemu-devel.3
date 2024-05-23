Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FED2C25B7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHZq-0003V3-Vv; Thu, 23 May 2024 19:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZc-0002Wh-Lj; Thu, 23 May 2024 19:10:15 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZa-00064r-8p; Thu, 23 May 2024 19:10:12 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f850ff30c0so996195b3a.0; 
 Thu, 23 May 2024 16:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505807; x=1717110607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wl9n/5mTUsA0Kpi5faa5nkP1+AzmiCWua0ztWpXQSbw=;
 b=GV9qmkXzGoT9+U+1fc1f72wVfqrhAqs7Z0yZYJuiaO4ltBwk7Z8OHPgPFb1JcSSnoS
 1jXK1weoR4jO4YuMCwanW/uJ3VW7vVwKm++o9pEv5bh/Fs51AsOjD7nww4hXsvLJlo8Z
 9ClO8k9M7ZsxarZ5oAITdfQ4jb+ZuUReVjYJD/tFkuacxYU+kAtYfzVYhDcUpcmbNFjz
 5zfOKTPXo1n7s8Ug3N57gAOdyM/O6LgS1CcV5e0Jwu39L9/gkxsetBQHoxAgtjNZjIfh
 0/GBtz/vwSkiAFiz/ly5x1BoRaATOpm4ClgkssrkAbkXg9Ld/wNnWzFE9Hqh7QhyUltV
 5H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505807; x=1717110607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wl9n/5mTUsA0Kpi5faa5nkP1+AzmiCWua0ztWpXQSbw=;
 b=BKSvppjgbJoq58Vq62NbAr18M3fnTGwD+15esMhYdauOX2o7cCUl5A1Jwd73/nNWUF
 EGnG4StuSnRD1ru50WfIYKyDQovuSAVWXmV1cg1D77UfnUUpXOnZEFrfRXsNL0VjGlyX
 S9ttM3P4fjwkO1tMHFBjA3nPoBrrFjEOg8oZ6VaEbEcHC1q7xDRbOXdqanXWDIH9zSrK
 YijqQcwra5ssDoqIv2tm7iQHMwosesyzB4SqJIouQUo229DkmfWDydTV8xzBFVz4/hd+
 zeeTx9r3B3o990KzqCi3YW1h9qnv27ZPA8dHEc2F2EXy9h9wxgZgqr1ftkpcYn87esw2
 j6cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAwVwQXt5POIbKALOD64CfxSKXBqUNkoOsKVVqPN4HnfG2/tKf7GqxuK0NnPQ2G+oXuT02WUIpuK2wfpJof+rNUO4u
X-Gm-Message-State: AOJu0Yx/+k5i/+L/IAAdTgZDaPr6WfQ8YtI6Q+KN03fkMyEt4ApX0GdS
 7g6Xrth8dn1175xKEm4rfnQP7MMFuXdak4mu1qX3BpXt/g+aAqZmVY8yYw==
X-Google-Smtp-Source: AGHT+IEajgW+L1/7wUY/hgEy9YIzsuC6l3BeSIQFInm2G0yBWleRGa9R1I+NAQ1QyGeFLRH8Srhncg==
X-Received: by 2002:a17:902:f686:b0:1f2:f3dc:43ee with SMTP id
 d9443c01a7336-1f4486b95d9mr9087215ad.3.1716505807530; 
 Thu, 23 May 2024 16:10:07 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:10:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 42/72] target/ppc/mmu_common.c: Remove unneeded local variable
Date: Fri, 24 May 2024 09:07:15 +1000
Message-ID: <20240523230747.45703-43-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

In mmubooke_check_tlb() and mmubooke206_check_tlb() we can assign the
value of prot2 directly to the destination, no need to have a separate
local variable for it.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index f79e390306..09cbeb0052 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -628,8 +628,6 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
                               hwaddr *raddr, int *prot, target_ulong address,
                               MMUAccessType access_type, int i)
 {
-    int prot2;
-
     if (!mmubooke_check_pid(env, tlb, raddr, address, i)) {
         qemu_log_mask(CPU_LOG_MMU, "%s: TLB entry not found\n", __func__);
         return -1;
@@ -644,17 +642,16 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
     }
 
     if (FIELD_EX64(env->msr, MSR, PR)) {
-        prot2 = tlb->prot & 0xF;
+        *prot = tlb->prot & 0xF;
     } else {
-        prot2 = (tlb->prot >> 4) & 0xF;
+        *prot = (tlb->prot >> 4) & 0xF;
     }
-    *prot = prot2;
-    if (prot2 & prot_for_access_type(access_type)) {
+    if (*prot & prot_for_access_type(access_type)) {
         qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
         return 0;
     }
 
-    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, prot2);
+    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, *prot);
     return access_type == MMU_INST_FETCH ? -3 : -2;
 }
 
@@ -795,7 +792,6 @@ static int mmubooke206_check_tlb(CPUPPCState *env, ppcmas_tlb_t *tlb,
                                  target_ulong address,
                                  MMUAccessType access_type, int mmu_idx)
 {
-    int prot2 = 0;
     uint32_t epid;
     bool as, pr;
     bool use_epid = mmubooke206_get_as(env, mmu_idx, &epid, &as, &pr);
@@ -841,34 +837,34 @@ found_tlb:
         return -1;
     }
 
+    *prot = 0;
     if (pr) {
         if (tlb->mas7_3 & MAS3_UR) {
-            prot2 |= PAGE_READ;
+            *prot |= PAGE_READ;
         }
         if (tlb->mas7_3 & MAS3_UW) {
-            prot2 |= PAGE_WRITE;
+            *prot |= PAGE_WRITE;
         }
         if (tlb->mas7_3 & MAS3_UX) {
-            prot2 |= PAGE_EXEC;
+            *prot |= PAGE_EXEC;
         }
     } else {
         if (tlb->mas7_3 & MAS3_SR) {
-            prot2 |= PAGE_READ;
+            *prot |= PAGE_READ;
         }
         if (tlb->mas7_3 & MAS3_SW) {
-            prot2 |= PAGE_WRITE;
+            *prot |= PAGE_WRITE;
         }
         if (tlb->mas7_3 & MAS3_SX) {
-            prot2 |= PAGE_EXEC;
+            *prot |= PAGE_EXEC;
         }
     }
-    *prot = prot2;
-    if (prot2 & prot_for_access_type(access_type)) {
+    if (*prot & prot_for_access_type(access_type)) {
         qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
         return 0;
     }
 
-    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, prot2);
+    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, *prot);
     return access_type == MMU_INST_FETCH ? -3 : -2;
 }
 
-- 
2.43.0


