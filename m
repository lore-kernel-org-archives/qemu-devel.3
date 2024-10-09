Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757F6CEDDA4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJU-0001Yt-6O; Wed, 09 Oct 2024 11:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJR-0001X5-7k
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:17 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJP-0007za-8n
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:16 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71e15fe56c9so1476756b3a.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486554; x=1729091354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s/iMv5B425r44+NF+z2djHWwBwMWohkmdSTVLek2FyE=;
 b=VMC4GgeTRgMmmb76P0yNO/SStyfX4zrIRvpRu2tVmH6SmS8QGcmztKaK650Uj2Q+Sn
 dp+lCGk0q5HbzxW0DiNaPNLSKAK4U7025bm+4Y9rfWcDSl63nZvFxdPpgTd9NZPN7N48
 08A7nrez8iJshIvO8FFknb7PT8GHZXKWFslNIpyyeCc0OH3GBw1whEBm63r7j10x8uHO
 dv8wz2nDjlqu/svmSOBzfazwDvJCgWv6TE2Y8cd9+YyhBBYYjQbAj3TKf1IqfV0+N/+h
 L5YmHrHsNI1i5wnV0VX3DooeSsWoD6CEDQY2hnoAYenqeLUvU/+oIrJuUuzMLECXVd7n
 HeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486554; x=1729091354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s/iMv5B425r44+NF+z2djHWwBwMWohkmdSTVLek2FyE=;
 b=T2CFe8Bs55DXjfQqe5+staq7moaMAasDgM8luIuOFp8G/DZFiZ2y9f+QIIWpR3rs6J
 lzIHL8faRTHvI2C7S5lSP7/D0y1XAug6Ii7CmSBoOEuBlSYW4M5V1J3rWMiK5b+7P8PQ
 0fJfqSOnr55iEOqoBop6mnGTqX4DcQ+SNgJfzZaGBWiMVY45MXRBzxLvCwFExJYCUc8W
 l6W4ydqkPWPaSEF77xHZHoT9IaQwnzUwt8CvcOm+OtCfXTetO1tKyedLamx9VAQtG9HG
 5XiC8FXiL8HDtT1M6Tu2cSCbkiHQ7dWv/TQqeMbNtdyYV2rGNX3hxZ26RoI1h08ux7S4
 8stQ==
X-Gm-Message-State: AOJu0YzBZY65O4cOIIz7xAlSViko3dHWsmIenBJWINbu280GPKGWHvlL
 EsWVGJ5aetai9k6TXvArpkVrPMB7ZG9sS+CMKBthQyFhZE5CfMag5KQWjfuBJFDmKkUyDn7ZZ2x
 p
X-Google-Smtp-Source: AGHT+IH+iKe/vWUjIGIl67j9gr5GVnLt4pGcHwj1L/Zoo51/5oM/67QtZTtGSjejYmidColmMY07JA==
X-Received: by 2002:a05:6a21:114f:b0:1c1:61a9:de4a with SMTP id
 adf61e73a8af0-1d8ad7dd77cmr434700637.24.1728486553843; 
 Wed, 09 Oct 2024 08:09:13 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.09.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:09:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/23] accel/tcg: Always use IntervalTree for code lookups
Date: Wed,  9 Oct 2024 08:08:51 -0700
Message-ID: <20241009150855.804605-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Because translation is special, we don't need the speed
of the direct-mapped softmmu tlb.  We cache a lookups in
DisasContextBase within the translator loop anyway.

Drop the addr_code comparator from CPUTLBEntry.
Go directly to the IntervalTree for MMU_INST_FETCH.
Derive exec flags from read flags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h    |   3 +
 include/exec/tlb-common.h |   5 +-
 accel/tcg/cputlb.c        | 138 +++++++++++++++++++++++++++++---------
 3 files changed, 110 insertions(+), 36 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 6f09b86e7f..7f5a10962a 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -326,6 +326,9 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
     (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO \
     | TLB_FORCE_SLOW | TLB_DISCARD_WRITE)
 
+/* Filter read flags to exec flags. */
+#define TLB_EXEC_FLAGS_MASK  (TLB_MMIO)
+
 /*
  * Flags stored in CPUTLBEntryFull.slow_flags[x].
  * TLB_FORCE_SLOW must be set in CPUTLBEntry.addr_idx[x].
diff --git a/include/exec/tlb-common.h b/include/exec/tlb-common.h
index 300f9fae67..feaa471299 100644
--- a/include/exec/tlb-common.h
+++ b/include/exec/tlb-common.h
@@ -26,7 +26,6 @@ typedef union CPUTLBEntry {
     struct {
         uint64_t addr_read;
         uint64_t addr_write;
-        uint64_t addr_code;
         /*
          * Addend to virtual address to get host address.  IO accesses
          * use the corresponding iotlb value.
@@ -35,7 +34,7 @@ typedef union CPUTLBEntry {
     };
     /*
      * Padding to get a power of two size, as well as index
-     * access to addr_{read,write,code}.
+     * access to addr_{read,write}.
      */
     uint64_t addr_idx[(1 << CPU_TLB_ENTRY_BITS) / sizeof(uint64_t)];
 } CPUTLBEntry;
@@ -92,7 +91,7 @@ struct CPUTLBEntryFull {
      * Additional tlb flags for use by the slow path. If non-zero,
      * the corresponding CPUTLBEntry comparator must have TLB_FORCE_SLOW.
      */
-    uint8_t slow_flags[MMU_ACCESS_COUNT];
+    uint8_t slow_flags[2];
 
     /*
      * Allow target-specific additions to this structure.
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 61daa89e06..7c8308355d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -114,8 +114,9 @@ static inline uint64_t tlb_read_idx(const CPUTLBEntry *entry,
                       MMU_DATA_LOAD * sizeof(uint64_t));
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_write) !=
                       MMU_DATA_STORE * sizeof(uint64_t));
-    QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_code) !=
-                      MMU_INST_FETCH * sizeof(uint64_t));
+
+    tcg_debug_assert(access_type == MMU_DATA_LOAD ||
+                     access_type == MMU_DATA_STORE);
 
 #if TARGET_LONG_BITS == 32
     /* Use qatomic_read, in case of addr_write; only care about low bits. */
@@ -490,8 +491,7 @@ static bool tlb_hit_page_mask_anyprot(CPUTLBEntry *tlb_entry,
     mask &= TARGET_PAGE_MASK | TLB_INVALID_MASK;
 
     return (page == (tlb_entry->addr_read & mask) ||
-            page == (tlb_addr_write(tlb_entry) & mask) ||
-            page == (tlb_entry->addr_code & mask));
+            page == (tlb_addr_write(tlb_entry) & mask));
 }
 
 static inline bool tlb_hit_page_anyprot(CPUTLBEntry *tlb_entry, vaddr page)
@@ -1061,15 +1061,13 @@ static inline void tlb_set_compare(CPUTLBEntryFull *full, CPUTLBEntry *ent,
                                    vaddr address, int flags,
                                    MMUAccessType access_type, bool enable)
 {
-    if (enable) {
-        address |= flags & TLB_FLAGS_MASK;
-        flags &= TLB_SLOW_FLAGS_MASK;
-        if (flags) {
-            address |= TLB_FORCE_SLOW;
-        }
-    } else {
-        address = -1;
-        flags = 0;
+    if (!enable) {
+	address = TLB_INVALID_MASK;
+    }
+    address |= flags & TLB_FLAGS_MASK;
+    flags &= TLB_SLOW_FLAGS_MASK;
+    if (flags) {
+        address |= TLB_FORCE_SLOW;
     }
     ent->addr_idx[access_type] = address;
     full->slow_flags[access_type] = flags;
@@ -1215,9 +1213,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     /* Now calculate the new entry */
     node->copy.addend = addend - addr_page;
 
-    tlb_set_compare(full, &node->copy, addr_page, read_flags,
-                    MMU_INST_FETCH, prot & PAGE_EXEC);
-
     if (wp_flags & BP_MEM_READ) {
         read_flags |= TLB_WATCHPOINT;
     }
@@ -1392,21 +1387,52 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
     }
 }
 
-static int probe_access_internal(CPUState *cpu, vaddr addr,
-                                 int fault_size, MMUAccessType access_type,
-                                 int mmu_idx, bool nonfault,
-                                 void **phost, CPUTLBEntryFull **pfull,
-                                 uintptr_t retaddr, bool check_mem_cbs)
+static int probe_access_internal_code(CPUState *cpu, vaddr addr,
+                                      int fault_size, int mmu_idx,
+                                      bool nonfault,
+                                      void **phost, CPUTLBEntryFull **pfull,
+                                      uintptr_t retaddr)
+{
+    CPUTLBEntryTree *t = tlbtree_lookup_addr(&cpu->neg.tlb.d[mmu_idx], addr);
+    int flags;
+
+    if (!t || !(t->full.prot & PAGE_EXEC)) {
+        if (!tlb_fill_align(cpu, addr, MMU_INST_FETCH, mmu_idx,
+                            0, fault_size, nonfault, retaddr)) {
+            /* Non-faulting page table read failed.  */
+            *phost = NULL;
+            *pfull = NULL;
+            return TLB_INVALID_MASK;
+        }
+        t = tlbtree_lookup_addr(&cpu->neg.tlb.d[mmu_idx], addr);
+    }
+    flags = t->copy.addr_read & TLB_EXEC_FLAGS_MASK;
+    *pfull = &t->full;
+
+    if (flags) {
+        *phost = NULL;
+        return TLB_MMIO;
+    }
+
+    /* Everything else is RAM. */
+    *phost = (void *)((uintptr_t)addr + t->copy.addend);
+    return flags;
+}
+
+static int probe_access_internal_data(CPUState *cpu, vaddr addr,
+                                      int fault_size, MMUAccessType access_type,
+                                      int mmu_idx, bool nonfault,
+                                      void **phost, CPUTLBEntryFull **pfull,
+                                      uintptr_t retaddr, bool check_mem_cbs)
 {
     uintptr_t index = tlb_index(cpu, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(cpu, mmu_idx, addr);
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
-    vaddr page_addr = addr & TARGET_PAGE_MASK;
     int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
     CPUTLBEntryFull *full;
 
-    if (!tlb_hit_page(tlb_addr, page_addr)) {
-        if (!tlbtree_hit(cpu, mmu_idx, access_type, page_addr)) {
+    if (!tlb_hit(tlb_addr, addr)) {
+        if (!tlbtree_hit(cpu, mmu_idx, access_type, addr)) {
             if (!tlb_fill_align(cpu, addr, access_type, mmu_idx,
                                 0, fault_size, nonfault, retaddr)) {
                 /* Non-faulting page table read failed.  */
@@ -1450,6 +1476,21 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
     return flags;
 }
 
+static int probe_access_internal(CPUState *cpu, vaddr addr,
+                                 int fault_size, MMUAccessType access_type,
+                                 int mmu_idx, bool nonfault,
+                                 void **phost, CPUTLBEntryFull **pfull,
+                                 uintptr_t retaddr, bool check_mem_cbs)
+{
+    if (access_type == MMU_INST_FETCH) {
+        return probe_access_internal_code(cpu, addr, fault_size, mmu_idx,
+                                          nonfault, phost, pfull, retaddr);
+    }
+    return probe_access_internal_data(cpu, addr, fault_size, access_type,
+                                      mmu_idx, nonfault, phost, pfull,
+                                      retaddr, check_mem_cbs);
+}
+
 int probe_access_full(CPUArchState *env, vaddr addr, int size,
                       MMUAccessType access_type, int mmu_idx,
                       bool nonfault, void **phost, CPUTLBEntryFull **pfull,
@@ -1582,9 +1623,9 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
     CPUTLBEntryFull *full;
     void *p;
 
-    (void)probe_access_internal(env_cpu(env), addr, 1, MMU_INST_FETCH,
-                                cpu_mmu_index(env_cpu(env), true), false,
-                                &p, &full, 0, false);
+    (void)probe_access_internal_code(env_cpu(env), addr, 1,
+                                     cpu_mmu_index(env_cpu(env), true),
+                                     false, &p, &full, 0);
     if (p == NULL) {
         return -1;
     }
@@ -1678,8 +1719,31 @@ typedef struct MMULookupLocals {
  * tlb_fill_align will longjmp out.  Return true if the softmmu tlb for
  * @mmu_idx may have resized.
  */
-static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
-                        int mmu_idx, MMUAccessType access_type, uintptr_t ra)
+static bool mmu_lookup1_code(CPUState *cpu, MMULookupPageData *data,
+                             MemOp memop, int mmu_idx, uintptr_t ra)
+{
+    vaddr addr = data->addr;
+    CPUTLBEntryTree *t = tlbtree_lookup_addr(&cpu->neg.tlb.d[mmu_idx], addr);
+    bool maybe_resized = true;
+
+    if (!t || !(t->full.prot & PAGE_EXEC)) {
+        tlb_fill_align(cpu, addr, MMU_INST_FETCH, mmu_idx,
+                       memop, data->size, false, ra);
+        maybe_resized = true;
+        t = tlbtree_lookup_addr(&cpu->neg.tlb.d[mmu_idx], addr);
+    }
+
+    data->full = &t->full;
+    data->flags = t->copy.addr_read & TLB_EXEC_FLAGS_MASK;
+    /* Compute haddr speculatively; depending on flags it might be invalid. */
+    data->haddr = (void *)((uintptr_t)addr + t->copy.addend);
+
+    return maybe_resized;
+}
+
+static bool mmu_lookup1_data(CPUState *cpu, MMULookupPageData *data,
+                             MemOp memop, int mmu_idx,
+                             MMUAccessType access_type, uintptr_t ra)
 {
     vaddr addr = data->addr;
     uintptr_t index = tlb_index(cpu, mmu_idx, addr);
@@ -1738,6 +1802,15 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
     return maybe_resized;
 }
 
+static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
+                        int mmu_idx, MMUAccessType access_type, uintptr_t ra)
+{
+    if (access_type == MMU_INST_FETCH) {
+        return mmu_lookup1_code(cpu, data, memop, mmu_idx, ra);
+    }
+    return mmu_lookup1_data(cpu, data, memop, mmu_idx, access_type, ra);
+}
+
 /**
  * mmu_watch_or_dirty
  * @cpu: generic cpu state
@@ -1885,13 +1958,13 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         }
     }
 
+    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
+
     /*
      * Let the guest notice RMW on a write-only page.
      * We have just verified that the page is writable.
-     * Subpage lookups may have left TLB_INVALID_MASK set,
-     * but addr_read will only be -1 if PAGE_READ was unset.
      */
-    if (unlikely(tlbe->addr_read == -1)) {
+    if (unlikely(!(full->prot & PAGE_READ))) {
         tlb_fill_align(cpu, addr, MMU_DATA_LOAD, mmu_idx,
                        0, size, false, retaddr);
         /*
@@ -1929,7 +2002,6 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     }
 
     hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
-    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
 
     if (unlikely(flags & TLB_NOTDIRTY)) {
         notdirty_write(cpu, addr, size, full, retaddr);
-- 
2.43.0


