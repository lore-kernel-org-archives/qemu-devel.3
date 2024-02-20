Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B18DC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 04:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcHbd-0001eX-Bc; Mon, 19 Feb 2024 23:19:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rcHbb-0001eE-J7; Mon, 19 Feb 2024 23:19:43 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rcHbZ-0006DW-Rq; Mon, 19 Feb 2024 23:19:43 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-299ea1f1989so30707a91.0; 
 Mon, 19 Feb 2024 20:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708402780; x=1709007580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4UtSR/3s4YP7V03Ktlw6YWmKCvZaG6tEV1kVd5CEnc0=;
 b=MYqDsGgDX4IiYPeiZkH0fZWh2BONAzNPco1XpAzDbRPuOZ7O4HSKPb++Qbsf7k0O31
 lCziZBDgNP/A1AvVA6LHwOcYlvG/nnPMgPyfKsGs73ri2YyCunJrKK6mMBP5vjlU7BFp
 t5EJHFhqPhoafrviTjgyavYD2Isg42OQXJ+gaeVh4rvh05BmP3nYCk9q1o1SJO+2FRvD
 T9xPhL00F5LVggc3YgR0nRhooC/loJZHPRfWVBAzgv7ajSr/zEB5Y+mk0gIumJoN3aAr
 8FpFaGsWWM4Kza+0l7V3W+Cd0E2dKJfewuh4WdgXBsDiC0ZUPWoS31MBzsPykc9vwMRQ
 y9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708402780; x=1709007580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4UtSR/3s4YP7V03Ktlw6YWmKCvZaG6tEV1kVd5CEnc0=;
 b=rWt3NCUS4H/ZenOdWGIR2WmXjTkPSFrFkITgBeOe1MlIGk87dv5xIbVj9bF8Qls7Nj
 4Ou/cmIuWxUXQuE8sHYFAVvYwGUrLb0wbLRTTiTtuZdv+SomXLEe6SqLNltXWAvo6py1
 sUnZcUuA4r0LDJUwxYxzNbIXv93037JvneOoQxZ6vKAgTIA/B1Z0FHIGKYtJQMdKIckl
 y4B+DggBcaPFRuIvPV0QDyPy47eXvLkEvdW3etp4OLa68WbJNGijX49rwBIhkyBZOQw8
 XKPXpziPdUdcrvT8TjVeEXRBS6hM1nw8x4zLl92NEInStpvcrIiIep5m9ISRJ2RXE6ye
 /gwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcyd3i4qzsfBm7eYKVLHKJkFacSAiuy9s/g+I7lM8mhT3f8STmm3LuakafIIj8Q9bGUFk3ZhoU7j0S0qYurPBBcLuYEFk=
X-Gm-Message-State: AOJu0YyZkRnMlRG2r3K3gz8EWNkE+corEQyjH0j2Fwjtj4NwjJiEfzD7
 TFJ3Iceu2ICKh+seHbcH9F+1S8ruIGH+7qWAw7g1YJIxPK+zjPKtRK8Y/KI/
X-Google-Smtp-Source: AGHT+IFspeXXeXTTa2VqypNi6kxQNzkGsnp7hsL3WOFuSvT1cfroLZONuokkjXiX7bpSKrsLETLffg==
X-Received: by 2002:a17:90b:3118:b0:299:1d33:846c with SMTP id
 gc24-20020a17090b311800b002991d33846cmr9759990pjb.39.1708402774917; 
 Mon, 19 Feb 2024 20:19:34 -0800 (PST)
Received: from wheely.local0.net (123-243-155-241.static.tpgi.com.au.
 [123.243.155.241]) by smtp.gmail.com with ESMTPSA id
 pl6-20020a17090b268600b00297138f0496sm6232621pjb.31.2024.02.19.20.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 20:19:34 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH 1/3] accel/tcg: Fix TCG TLB coherency race with physical
 dirty bit clearing
Date: Tue, 20 Feb 2024 14:19:20 +1000
Message-ID: <20240220041922.373029-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240220041922.373029-1-npiggin@gmail.com>
References: <20240220041922.373029-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The TCG TLB keeps a TLB_NOTDIRTY bit that must be kept coherent
with the cpu physical dirty memory bitmaps. If any bits are clear,
TLB_NOTDIRTY *must* be set in all CPUs so that the nodirty_write()
slowpath is guaranteed to be called on a write access.

TLB_NOTDIRTY may be set if none of the bits are clear, it just
results in a superfluous nodirty_write() call (which should remove
the bit).

There is a race with clearing physical dirty bits and setting
TLB_NOTDIRTY vs setting or creating TLB entries without the
TLB_NOTDIRTY bit, that can cause the bit to get lost and
notdirty_write() updates to be missed.

nodirty_write()
1. cpu_physical_memory_set_dirty_range()
2. if (!cpu_physical_memory_is_clean())
3.    tlb_set_dirty()

vs

cpu_physical_memory_test_and_clear_dirty()
A. dirty = bitmap_test_and_clear_atomic()
   if (dirty)
B.     tlb_reset_dirty_range_all()

1 executes, then 2 finds no bits clean, then A clears the dirty bit
and runs B to set TLB_NOTDIRTY on the TLB entries, then 3 clears the
TLB_NOTDIRTY bits from the TLB entries.

This results in the physical dirty bitmap having a clear bit with a
TLB entry pointing to it without TLB_NOTDIRTY, which means stores
through that TLB are performed without the notdirty_write() call to
set dirty bits (or invalidate tb).

Fix this by checking the physical dirty bitmap while holding the TLB
lock that also covers TLB entry insertion / TLB_NOTDIRTY clearing.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Hi Thomas,

This is the other dirty bitmap race I saw, if you are hunting
migration bugs...

Thanks,
Nick

 include/exec/exec-all.h |  1 -
 accel/stubs/tcg-stub.c  |  4 ----
 accel/tcg/cputlb.c      | 47 +++++++++++++++++++++++++++++------------
 3 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index ce36bb10d4..ade81b25f0 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -654,7 +654,6 @@ static inline void mmap_unlock(void) {}
 #define WITH_MMAP_LOCK_GUARD()
 
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
-void tlb_set_dirty(CPUState *cpu, vaddr addr);
 
 MemoryRegionSection *
 address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 8a496a2a6f..dd890d6cf6 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -18,10 +18,6 @@ void tb_flush(CPUState *cpu)
 {
 }
 
-void tlb_set_dirty(CPUState *cpu, vaddr vaddr)
-{
-}
-
 int probe_access_flags(CPUArchState *env, vaddr addr, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool nonfault, void **phost, uintptr_t retaddr)
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 047cd2cc0a..078f4ef166 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1001,10 +1001,17 @@ static inline void copy_tlb_helper_locked(CPUTLBEntry *d, const CPUTLBEntry *s)
     *d = *s;
 }
 
-/* This is a cross vCPU call (i.e. another vCPU resetting the flags of
+/*
+ * This is a cross vCPU call (i.e. another vCPU resetting the flags of
  * the target vCPU).
  * We must take tlb_c.lock to avoid racing with another vCPU update. The only
  * thing actually updated is the target TLB entry ->addr_write flags.
+ *
+ * This can race between the physical memory dirty bits becoming all set and
+ * tlb_set_page_full or tlb_try_set_dirty creating dirty entries: it is
+ * harmless to set TLB_NOTDIRTY on a !clean physical page, it might just
+ * cause a notdirty_write() slowpath on the next write which clears out the
+ * spurious TLB_NOTDIRTY.
  */
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
 {
@@ -1037,9 +1044,11 @@ static inline void tlb_set_dirty1_locked(CPUTLBEntry *tlb_entry,
     }
 }
 
-/* update the TLB corresponding to virtual page vaddr
-   so that it is no longer dirty */
-void tlb_set_dirty(CPUState *cpu, vaddr addr)
+/*
+ * Update the TLB corresponding to virtual page vaddr if it no longer
+ * requires the TLB_NOTDIRTY bit.
+ */
+static void tlb_try_set_dirty(CPUState *cpu, vaddr addr, ram_addr_t ram_addr)
 {
     int mmu_idx;
 
@@ -1047,6 +1056,12 @@ void tlb_set_dirty(CPUState *cpu, vaddr addr)
 
     addr &= TARGET_PAGE_MASK;
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
+    if (cpu_physical_memory_is_clean(ram_addr)) {
+        /* Must be checked under lock, like tlb_set_page_full */
+        qemu_spin_unlock(&cpu->neg.tlb.c.lock);
+        return;
+    }
+
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         tlb_set_dirty1_locked(tlb_entry(cpu, mmu_idx, addr), addr);
     }
@@ -1165,6 +1180,19 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
         addend = 0;
     }
 
+    /*
+     * Hold the TLB lock for the rest of the function. We could acquire/release
+     * the lock several times in the function, but it is faster to amortize the
+     * acquisition cost by acquiring it just once. Note that this leads to
+     * a longer critical section, but this is not a concern since the TLB lock
+     * is unlikely to be contended.
+     *
+     * The TLB lock must be held over checking cpu_physical_memory_is_clean
+     * and inserting the entry into the TLB, so clearing phsyical memory
+     * dirty status can find and set TLB_NOTDIRTY on the entries.
+     */
+    qemu_spin_lock(&tlb->c.lock);
+
     write_flags = read_flags;
     if (is_ram) {
         iotlb = memory_region_get_ram_addr(section->mr) + xlat;
@@ -1200,15 +1228,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     index = tlb_index(cpu, mmu_idx, addr_page);
     te = tlb_entry(cpu, mmu_idx, addr_page);
 
-    /*
-     * Hold the TLB lock for the rest of the function. We could acquire/release
-     * the lock several times in the function, but it is faster to amortize the
-     * acquisition cost by acquiring it just once. Note that this leads to
-     * a longer critical section, but this is not a concern since the TLB lock
-     * is unlikely to be contended.
-     */
-    qemu_spin_lock(&tlb->c.lock);
-
     /* Note that the tlb is no longer clean.  */
     tlb->c.dirty |= 1 << mmu_idx;
 
@@ -1409,7 +1428,7 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
     /* We remove the notdirty callback only if the code has been flushed. */
     if (!cpu_physical_memory_is_clean(ram_addr)) {
         trace_memory_notdirty_set_dirty(mem_vaddr);
-        tlb_set_dirty(cpu, mem_vaddr);
+        tlb_try_set_dirty(cpu, mem_vaddr, ram_addr);
     }
 }
 
-- 
2.42.0


