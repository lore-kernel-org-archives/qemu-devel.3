Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35E4CFA742
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 15:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx6fY-00024n-Hg; Sat, 05 Oct 2024 11:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fT-00021L-BC
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:03 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fR-0002MQ-52
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:03 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20aff65aa37so26630865ad.1
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728141960; x=1728746760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aSpIks7wgvzrdGiSzq/HYW4dr1jFM7gjMRozlRGemJM=;
 b=P8fmzQyeMDcLVoycbC6o8Mqpq1LXwy/30TTRbNRe3YLaFtctGnC90F9ThWA6EYrKeG
 iM3BzR6zUTGywG2hwOugYYH924z+i09BjbPY+ktP5taPf0P9yRnepwpGnY/Aa5K98Q38
 oGxiH4pDbMx0qnyXb/LCKzW7r0RWoac642u6AcAUr8o1KfXGYmcnmHpANH4K0Xpbdvkc
 NBjgFdhK4MypahJcgyAKAy7pKIuNQf7A9gLJZoCdvcSUETYRwD3wADybHljtjETiOQDL
 Z8m/I6j8U5CMdefK2tX4OSH+beS5zjvLGZN4amBzO9Mq5Lv59Dx9Sg1dBi21p8NmNlcr
 VKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728141960; x=1728746760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSpIks7wgvzrdGiSzq/HYW4dr1jFM7gjMRozlRGemJM=;
 b=uZJij62gIje3Uc5WcvN2U6acWEhFhzzuKoOw2Nkk32akexcOyFjcPxBVJkxB2rlMUO
 D7Ortfcl6JVu8Kfl5gBPkApap97Tzuf/jkYzMa8pkfJWaw2fdw7pREUCd+K1dvuDfxfR
 nI0Li02BTwiMkTMGLDw5O520UEiJcQLflxp3OzrfTDB9aPCzKnL98ZpkST7BMeM8cUqt
 2yPuGyQhAU78UYzrsG7DJvJTg+Iw6O2RrtFIBQlRbibOgUATv+6MD/CRsdjBpFbR+VMw
 RJt5otRkUz7kRZbnanEh6zBN4EUvQFToeK2LGGSv7BQHE3D0HthfYIIChjhLvGJMbBvZ
 eOBQ==
X-Gm-Message-State: AOJu0YwIWuO0F/iBb4mpyuKMonsb2c2+APB0zzPypwTW72aKxuXhXr5c
 3nA8q6EPJXCbrRjGp1ntD7nPOHsJw32DpzSX7/JN/6UOzGWkCzvRYdiErMGGgzjIHHnj5O7X8x8
 4
X-Google-Smtp-Source: AGHT+IHHBcTpm+lN7YnCUB3+U4K5he75In85ERBx3pFwVufluTULuz7p5KPxpM3Bc//CGD+sBFjKUg==
X-Received: by 2002:a17:902:ec89:b0:20b:982e:73d6 with SMTP id
 d9443c01a7336-20bff043851mr82009865ad.49.1728141959618; 
 Sat, 05 Oct 2024 08:25:59 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1396948dsm14351765ad.225.2024.10.05.08.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 08:25:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH 07/20] accel/tcg: Use the tlb_fill_align hook
Date: Sat,  5 Oct 2024 08:25:38 -0700
Message-ID: <20241005152551.307923-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005152551.307923-1-richard.henderson@linaro.org>
References: <20241005152551.307923-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

When we have a tlb miss, defer the alignment check to
the new tlb_fill_align hook.  Move the existing alignment
check so that we only perform it with a tlb hit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 89 +++++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 40 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 4bc34c8a37..0e6ae65a39 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1616,14 +1616,14 @@ typedef struct MMULookupLocals {
  * tlb_fill will longjmp out.  Return true if the softmmu tlb for
  * @mmu_idx may have resized.
  */
-static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data,
+static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
                         int mmu_idx, MMUAccessType access_type, uintptr_t ra)
 {
     vaddr addr = data->addr;
     uintptr_t index = tlb_index(cpu, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(cpu, mmu_idx, addr);
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
-    bool maybe_resized = false;
+    bool did_tlb_fill = false;
     CPUTLBEntryFull *full;
     int flags;
 
@@ -1631,17 +1631,26 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data,
     if (!tlb_hit(tlb_addr, addr)) {
         if (!victim_tlb_hit(cpu, mmu_idx, index, access_type,
                             addr & TARGET_PAGE_MASK)) {
-            bool ok = cpu->cc->tcg_ops->tlb_fill(cpu, addr, data->size,
-                                                 access_type, mmu_idx,
-                                                 false, ra);
+            bool ok = cpu->cc->tcg_ops->tlb_fill_align(cpu, addr, memop,
+                                                       data->size, access_type,
+                                                       mmu_idx, false, ra);
             assert(ok);
-            maybe_resized = true;
+            did_tlb_fill = true;
             index = tlb_index(cpu, mmu_idx, addr);
             entry = tlb_entry(cpu, mmu_idx, addr);
         }
         tlb_addr = tlb_read_idx(entry, access_type) & ~TLB_INVALID_MASK;
     }
 
+    if (!did_tlb_fill) {
+        /* We didn't use tlb_fill_align, so alignment not yet checked. */
+        unsigned a_bits = memop_alignment_bits(memop);
+
+        if (unlikely(addr & ((1 << a_bits) - 1))) {
+            cpu_unaligned_access(cpu, addr, access_type, mmu_idx, ra);
+        }
+    }
+
     full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
     flags = tlb_addr & (TLB_FLAGS_MASK & ~TLB_FORCE_SLOW);
     flags |= full->slow_flags[access_type];
@@ -1651,7 +1660,7 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data,
     /* Compute haddr speculatively; depending on flags it might be invalid. */
     data->haddr = (void *)((uintptr_t)addr + entry->addend);
 
-    return maybe_resized;
+    return did_tlb_fill;
 }
 
 /**
@@ -1702,7 +1711,6 @@ static void mmu_watch_or_dirty(CPUState *cpu, MMULookupPageData *data,
 static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
                        uintptr_t ra, MMUAccessType type, MMULookupLocals *l)
 {
-    unsigned a_bits;
     bool crosspage;
     int flags;
 
@@ -1711,12 +1719,6 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
 
     tcg_debug_assert(l->mmu_idx < NB_MMU_MODES);
 
-    /* Handle CPU specific unaligned behaviour */
-    a_bits = memop_alignment_bits(l->memop);
-    if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(cpu, addr, type, l->mmu_idx, ra);
-    }
-
     l->page[0].addr = addr;
     l->page[0].size = memop_size(l->memop);
     l->page[1].addr = (addr + l->page[0].size - 1) & TARGET_PAGE_MASK;
@@ -1724,7 +1726,7 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     crosspage = (addr ^ l->page[1].addr) & TARGET_PAGE_MASK;
 
     if (likely(!crosspage)) {
-        mmu_lookup1(cpu, &l->page[0], l->mmu_idx, type, ra);
+        mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
 
         flags = l->page[0].flags;
         if (unlikely(flags & (TLB_WATCHPOINT | TLB_NOTDIRTY))) {
@@ -1743,8 +1745,8 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
          * Lookup both pages, recognizing exceptions from either.  If the
          * second lookup potentially resized, refresh first CPUTLBEntryFull.
          */
-        mmu_lookup1(cpu, &l->page[0], l->mmu_idx, type, ra);
-        if (mmu_lookup1(cpu, &l->page[1], l->mmu_idx, type, ra)) {
+        mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
+        if (mmu_lookup1(cpu, &l->page[1], 0, l->mmu_idx, type, ra)) {
             uintptr_t index = tlb_index(cpu, l->mmu_idx, addr);
             l->page[0].full = &cpu->neg.tlb.d[l->mmu_idx].fulltlb[index];
         }
@@ -1770,7 +1772,7 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
      * Device memory type require alignment.
      */
     if (unlikely(flags & TLB_CHECK_ALIGNED)) {
-        a_bits = memop_atomicity_bits(l->memop);
+        unsigned a_bits = memop_atomicity_bits(l->memop);
         if (addr & ((1 << a_bits) - 1)) {
             cpu_unaligned_access(cpu, addr, type, l->mmu_idx, ra);
         }
@@ -1788,34 +1790,18 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     MemOp mop = get_memop(oi);
-    int a_bits = memop_alignment_bits(mop);
     uintptr_t index;
     CPUTLBEntry *tlbe;
     vaddr tlb_addr;
     void *hostaddr;
     CPUTLBEntryFull *full;
+    bool did_tlb_fill = false;
 
     tcg_debug_assert(mmu_idx < NB_MMU_MODES);
 
     /* Adjust the given return address.  */
     retaddr -= GETPC_ADJ;
 
-    /* Enforce guest required alignment.  */
-    if (unlikely(a_bits > 0 && (addr & ((1 << a_bits) - 1)))) {
-        /* ??? Maybe indicate atomic op to cpu_unaligned_access */
-        cpu_unaligned_access(cpu, addr, MMU_DATA_STORE,
-                             mmu_idx, retaddr);
-    }
-
-    /* Enforce qemu required alignment.  */
-    if (unlikely(addr & (size - 1))) {
-        /* We get here if guest alignment was not requested,
-           or was not enforced by cpu_unaligned_access above.
-           We might widen the access and emulate, but for now
-           mark an exception and exit the cpu loop.  */
-        goto stop_the_world;
-    }
-
     index = tlb_index(cpu, mmu_idx, addr);
     tlbe = tlb_entry(cpu, mmu_idx, addr);
 
@@ -1824,10 +1810,11 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     if (!tlb_hit(tlb_addr, addr)) {
         if (!victim_tlb_hit(cpu, mmu_idx, index, MMU_DATA_STORE,
                             addr & TARGET_PAGE_MASK)) {
-            bool ok = cpu->cc->tcg_ops->tlb_fill(cpu, addr, size,
-                                                 MMU_DATA_STORE, mmu_idx,
-                                                 false, retaddr);
+            bool ok = cpu->cc->tcg_ops->tlb_fill_align(cpu, addr, mop, size,
+                                                       MMU_DATA_STORE, mmu_idx,
+                                                       false, retaddr);
             assert(ok);
+            did_tlb_fill = true;
             index = tlb_index(cpu, mmu_idx, addr);
             tlbe = tlb_entry(cpu, mmu_idx, addr);
         }
@@ -1841,8 +1828,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
      * but addr_read will only be -1 if PAGE_READ was unset.
      */
     if (unlikely(tlbe->addr_read == -1)) {
-        cpu->cc->tcg_ops->tlb_fill(cpu, addr, size, MMU_DATA_LOAD,
-                                   mmu_idx, false, retaddr);
+        cpu->cc->tcg_ops->tlb_fill_align(cpu, addr, mop, size, MMU_DATA_LOAD,
+                                         mmu_idx, false, retaddr);
         /*
          * Since we don't support reads and writes to different
          * addresses, and we do have the proper page loaded for
@@ -1850,6 +1837,28 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
          */
         g_assert_not_reached();
     }
+
+    /* Enforce guest required alignment, if not handled by tlb_fill_align. */
+    if (!did_tlb_fill) {
+        int a_bits = memop_alignment_bits(mop);
+        if (unlikely(a_bits > 0 && (addr & ((1 << a_bits) - 1)))) {
+            /* ??? Maybe indicate atomic op to cpu_unaligned_access */
+            cpu_unaligned_access(cpu, addr, MMU_DATA_STORE,
+                                 mmu_idx, retaddr);
+        }
+    }
+
+    /* Enforce qemu required alignment.  */
+    if (unlikely(addr & (size - 1))) {
+        /*
+         * We get here if guest alignment was not requested,
+         * or was not enforced by cpu_unaligned_access above.
+         * We might widen the access and emulate, but for now
+         * mark an exception and exit the cpu loop.
+         */
+        goto stop_the_world;
+    }
+
     /* Collect tlb flags for read. */
     tlb_addr |= tlbe->addr_read;
 
-- 
2.43.0


