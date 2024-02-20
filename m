Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3948FC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 04:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcHbh-0001fh-Ai; Mon, 19 Feb 2024 23:19:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rcHbe-0001f8-Fm; Mon, 19 Feb 2024 23:19:46 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rcHbb-0006EG-Sg; Mon, 19 Feb 2024 23:19:46 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso4108933a12.3; 
 Mon, 19 Feb 2024 20:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708402782; x=1709007582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FFZNdh+B8F0CK+ODcoo3/h5v6oqUz7dYUbqoB5SHAvs=;
 b=jrFyPlYFEYRPpxxbyadPT7MKfyvqtIsn7JfWB8fEJAASboaGIbH4cLhpa5rJHUt9fl
 PqNMArTU8i9fd2CwFrv+EMT3sxzl4DGRCRggOU2kTk9BfNbym5UXmi4UYudpb1a1UNNs
 cypvChah17brIcW5kMRt8ifRqEG+orYZ8JsCYQVjrA6siHOrflcL6xEOz0Xmz4XURvam
 c/w10bjLTgGecRCyYa6C+G0j4VhDgbI0DtYuQUxix/N3eNVKbMas3z6SrUNbYQVhd6r4
 AqylJeSvr1Xj6RORJ+C1hWpmGbUiNxfZC/4sClWzTvBMy4gP6QaaU1DL3+hl3UVAPkqA
 Nd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708402782; x=1709007582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FFZNdh+B8F0CK+ODcoo3/h5v6oqUz7dYUbqoB5SHAvs=;
 b=cmF/yYP1wNySx/LTDqYBbvt8kz5yRNfryXbH9j5p0RdlMxl1Oa6t9z8njLt+THK9UY
 qJF4xngYCzVzSauMYP5CXlTbvmv0yiKPiyHzFJfurpGFbQGlaQ0Ri0s5h36dTz/Dk+fe
 wEGir06eoROgH9yXtIvJTIKr2tgPC7ckMm7LkChImPpu74Y4n9MBB4qsWMue4eiEyvsM
 U6EYN5MRmCvWi9j2ObO34QeB/aKtNZqZnOmbM/uXaiUMxzresA/GPeWFEWxl9lFZWA/A
 QnxaEhozONiB+HrKuGOS5nzFefnY1p+A/xbR6VtpwNWpj9jOvuY5LW0HmqHMsagdj2xh
 J2Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsoUDv/wC+AfyRTYYWpPNq6T2auebgSQTRSgDcG+vw+hVX+BtLwhN4Ta8SG5p1oUalXYW91Tu07f3U3rolrd8pEIl4+ec=
X-Gm-Message-State: AOJu0Yy9Wivd3U4pVRrh97cPrrZA9Hv4ZNXtUnyfXKu+RDoVg3Lm6Jjw
 mBBhcn6e9Za+p4co+08/eozQfbzyEwuBUBYZdV0Rqq3pwn0HueaSxV2H3KUR
X-Google-Smtp-Source: AGHT+IHSeADdr7oae2dwf7a9wC4VokcmfdTAlMXU7YhbyF38XFOtygJ341wXXOB0MBuYFx4FdJ4TpA==
X-Received: by 2002:a17:90a:7d13:b0:299:3550:9fda with SMTP id
 g19-20020a17090a7d1300b0029935509fdamr9041674pjl.6.1708402777946; 
 Mon, 19 Feb 2024 20:19:37 -0800 (PST)
Received: from wheely.local0.net (123-243-155-241.static.tpgi.com.au.
 [123.243.155.241]) by smtp.gmail.com with ESMTPSA id
 pl6-20020a17090b268600b00297138f0496sm6232621pjb.31.2024.02.19.20.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 20:19:37 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH 2/3] tcg: add a ll/sc protection facility
Date: Tue, 20 Feb 2024 14:19:21 +1000
Message-ID: <20240220041922.373029-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240220041922.373029-1-npiggin@gmail.com>
References: <20240220041922.373029-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x529.google.com
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

This uses the cpu physical memory dirty mechanism to provide a LL/SC
protection system, so that a CPU can set llsc protection on a block of
memory, and it can check whether any other CPUs have stored to that
memory in a way that can be done race-free to perform a store
conditional on that check.

QEMU TCG implements LL/SC conditional store with an atomic cmpxchg that
only checks that the value of memory is the same as the value returned
by the LL. This works well in practice, but it does not faithfully
emulate LL/SC. Among the issues are:

1. cmpxchg incorrectly succeeds in the case that stores were performed
   by other CPUs, but the observed value is the same. Also known as the
   ABA problem.

2. Some implementations (e.g., IBM POWER) provide a protection block
   (reservation granule) size that is larger than the load. A store
   from another CPU to anywhere in the granule should cause a loss of
   protection. A conditional store from this CPU to anywhere in the
   granule could also succeed. Some IBM firmware relies on this
   implementation detail.

3. Some (e.g., ppc, arm) implementations of LL/SC work on physical
   memory. It could succeed if the store is performed at a different
   virtual address than the load, if they alias to the same physical
   memory.

4. Some implementations allow the CPU that performed the load to store
   a different value at that memory location with a simple store, and
   have the conditional-store succeed.

These can cause varying degrees of problems. 2. was observed to cause
a real problem. Although most open source code doesn't seem to have
a problem. And I think the more restrictie pseudo-LLSC encourages
software to be clean :)

The ABA problem *almost* has an interesting memory ordering problem
vs Linux spinlocks:

lock:
   larx
   cmp
   bne   busy
   stcx.
   bne-  lock
   lwsync

The lwsync barrier permits loads to be performed ahead of earleir stores
so a load in the critical section can see a result before the stcx. store
to set the lock is visible to other CPUs. This works because lwsync does
prevent those loads being performed before the earlier larx, so they must
be performed with a valid reservation that results in the lock being taken.

If another CPU could come between the larx and stcx. and take the lock,
perform a critical section, and then release the lock, then if the stcx.
succeeds, the lwsync would not prevent loads in the critical section
being performed before it. The saving grace here is that a cmpxchg-based
stcx. itself has to be implemented with a larx on the host, so it does
end up ordering correctly. Maybe that is inherent in any similar kind of
issue and so it's not really very interesting, but I thought it showed
possible subtle issues (one of our firmware engineers spotted it).
---
 include/exec/cputlb.h    |   7 ++
 include/exec/ram_addr.h  |  42 ++++++++-
 include/exec/ramlist.h   |  10 +++
 include/hw/core/cpu.h    |   5 ++
 accel/tcg/cputlb.c       | 188 ++++++++++++++++++++++++++++++++++++++-
 hw/core/cpu-common.c     |   5 ++
 hw/vfio/common.c         |   2 +-
 hw/virtio/vhost.c        |   1 +
 system/memory.c          |   3 +
 system/physmem.c         |   7 ++
 system/memory_ldst.c.inc |   3 +-
 11 files changed, 266 insertions(+), 7 deletions(-)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 6da1462c4f..8c590b34a7 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -27,4 +27,11 @@
 void tlb_protect_code(ram_addr_t ram_addr);
 void tlb_unprotect_code(ram_addr_t ram_addr);
 #endif
+
+void cpu_set_llsc_prot(CPUState *cpu, ram_addr_t addr);
+bool cpu_resolve_llsc_begin(CPUState *cpu);
+void cpu_resolve_llsc_abort(CPUState *cpu);
+bool cpu_resolve_llsc_check(CPUState *cpu, ram_addr_t addr);
+void cpu_resolve_llsc_success(CPUState *cpu);
+
 #endif
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index dadb2deb11..4776921c49 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -147,7 +147,13 @@ static inline void qemu_ram_block_writeback(RAMBlock *block)
 }
 
 #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
-#define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
+
+/*
+ * Migration and VGA just want to see the dirty bit set, hence "oneshot".
+ * As opposed to code and llsc_prot which want to be called on every store.
+ */
+#define DIRTY_CLIENTS_ONESHOT ((1 << DIRTY_MEMORY_VGA) |        \
+                               (1 << DIRTY_MEMORY_MIGRATION))
 
 static inline bool cpu_physical_memory_get_dirty(ram_addr_t start,
                                                  ram_addr_t length,
@@ -240,7 +246,13 @@ static inline bool cpu_physical_memory_is_clean(ram_addr_t addr)
     bool code = cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_CODE);
     bool migration =
         cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_MIGRATION);
-    return !(vga && code && migration);
+    bool llsc_prot =
+#ifdef TARGET_HAS_LLSC_PROT
+        cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_LLSC_PROT);
+#else
+        false;
+#endif
+    return !(vga && code && migration && llsc_prot);
 }
 
 static inline uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t start,
@@ -261,6 +273,12 @@ static inline uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t start,
         !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_MIGRATION)) {
         ret |= (1 << DIRTY_MEMORY_MIGRATION);
     }
+#ifdef TARGET_HAS_LLSC_PROT
+    if (mask & (1 << DIRTY_MEMORY_LLSC_PROT) &&
+        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_LLSC_PROT)) {
+        ret |= (1 << DIRTY_MEMORY_LLSC_PROT);
+    }
+#endif
     return ret;
 }
 
@@ -322,6 +340,12 @@ static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
                 bitmap_set_atomic(blocks[DIRTY_MEMORY_CODE]->blocks[idx],
                                   offset, next - page);
             }
+#ifdef TARGET_HAS_LLSC_PROT
+            if (unlikely(mask & (1 << DIRTY_MEMORY_LLSC_PROT))) {
+                bitmap_set_atomic(blocks[DIRTY_MEMORY_LLSC_PROT]->blocks[idx],
+                                  offset, next - page);
+            }
+#endif
 
             page = next;
             idx++;
@@ -355,6 +379,8 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
     unsigned long hpratio = qemu_real_host_page_size() / TARGET_PAGE_SIZE;
     unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
 
+    assert(0);
+
     /* start address is aligned at the start of a word? */
     if ((((page * BITS_PER_LONG) << TARGET_PAGE_BITS) == start) &&
         (hpratio == 1)) {
@@ -396,6 +422,12 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
                     if (tcg_enabled()) {
                         qatomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset],
                                    temp);
+#ifdef TARGET_HAS_LLSC_PROT
+			/* XXX? */
+                        qatomic_or(&blocks[DIRTY_MEMORY_LLSC_PROT][idx][offset],
+                                   temp);
+#endif
+			assert(0);
                     }
                 }
 
@@ -408,7 +440,8 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
 
         xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
     } else {
-        uint8_t clients = tcg_enabled() ? DIRTY_CLIENTS_ALL : DIRTY_CLIENTS_NOCODE;
+        uint8_t clients = tcg_enabled() ? DIRTY_CLIENTS_ALL :
+                                          DIRTY_CLIENTS_ONESHOT;
 
         if (!global_dirty_tracking) {
             clients &= ~(1 << DIRTY_MEMORY_MIGRATION);
@@ -470,6 +503,9 @@ static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
     cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_MIGRATION);
     cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_VGA);
     cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_CODE);
+#ifdef TARGET_HAS_LLSC_PROT
+    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_LLSC_PROT);
+#endif
 }
 
 
diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
index 2ad2a81acc..e6523bf25c 100644
--- a/include/exec/ramlist.h
+++ b/include/exec/ramlist.h
@@ -8,10 +8,20 @@
 
 typedef struct RAMBlockNotifier RAMBlockNotifier;
 
+/* XXX: hack, need to work out how to do this */
+#ifndef TARGET_HAS_LLSC_PROT
+#define TARGET_HAS_LLSC_PROT
+#endif
+
 #define DIRTY_MEMORY_VGA       0
 #define DIRTY_MEMORY_CODE      1
 #define DIRTY_MEMORY_MIGRATION 2
+#ifdef TARGET_HAS_LLSC_PROT
+#define DIRTY_MEMORY_LLSC_PROT 3
+#define DIRTY_MEMORY_NUM       4        /* num of dirty bits */
+#else
 #define DIRTY_MEMORY_NUM       3        /* num of dirty bits */
+#endif
 
 /* The dirty memory bitmap is split into fixed-size blocks to allow growth
  * under RCU.  The bitmap for a block can be accessed as follows:
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 4385ce54c9..f1da94771e 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -489,6 +489,11 @@ struct CPUState {
     uint64_t random_seed;
     sigjmp_buf jmp_env;
 
+    int llsc_prot_block_size;
+    bool llsc_prot_active;
+    bool llsc_resolving;
+    hwaddr llsc_prot_address; /* ram_addr_t physical address of reservation */
+
     QemuMutex work_mutex;
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 078f4ef166..d27053cadc 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -274,11 +274,18 @@ static inline void tlb_n_used_entries_dec(CPUState *cpu, uintptr_t mmu_idx)
     cpu->neg.tlb.d[mmu_idx].n_used_entries--;
 }
 
+#ifdef TARGET_HAS_LLSC_PROT
+static QemuMutex llsc_prot_mutex;
+#endif
+
 void tlb_init(CPUState *cpu)
 {
     int64_t now = get_clock_realtime();
     int i;
 
+#ifdef TARGET_HAS_LLSC_PROT
+    qemu_mutex_init(&llsc_prot_mutex);
+#endif
     qemu_spin_init(&cpu->neg.tlb.c.lock);
 
     /* All tlbs are initialized flushed. */
@@ -1408,6 +1415,176 @@ static bool victim_tlb_hit(CPUState *cpu, size_t mmu_idx, size_t index,
     return false;
 }
 
+#ifdef TARGET_HAS_LLSC_PROT
+/*
+ * Remove a particular address from being watched by LLSC if it is
+ * no longer actively protected by any CPU.
+ */
+static void cpu_teardown_llsc_prot(ram_addr_t addr)
+{
+    CPUState *cpu;
+
+    addr &= TARGET_PAGE_MASK;
+
+    CPU_FOREACH(cpu) {
+        if ((cpu->llsc_prot_address & TARGET_PAGE_MASK) == addr) {
+            if (cpu->llsc_prot_active) {
+                return;
+            }
+            cpu->llsc_prot_address = -1ULL;
+        }
+    }
+    cpu_physical_memory_set_dirty_flag(addr, DIRTY_MEMORY_LLSC_PROT);
+}
+
+/*
+ * Start protection of an address. cpu_resolve_llsc_begin() and
+ * cpu_resolve_llsc_check() will return true so long as another
+ * actor has not modified the line.
+ */
+void cpu_set_llsc_prot(CPUState *cpu, ram_addr_t addr)
+{
+    ram_addr_t old;
+
+    addr &= ~(cpu->llsc_prot_block_size - 1);
+
+    qemu_mutex_lock(&llsc_prot_mutex);
+    old = cpu->llsc_prot_address;
+    if ((addr & TARGET_PAGE_MASK) == (old & TARGET_PAGE_MASK)) {
+        old = -1ULL;
+        goto out;
+    }
+    cpu_physical_memory_test_and_clear_dirty(addr & TARGET_PAGE_MASK,
+                                             TARGET_PAGE_SIZE,
+                                             DIRTY_MEMORY_LLSC_PROT);
+out:
+    cpu->llsc_prot_address = addr;
+    cpu->llsc_prot_active = true;
+    if (old != -1ULL) {
+        cpu_teardown_llsc_prot(old);
+    }
+
+    qemu_mutex_unlock(&llsc_prot_mutex);
+}
+
+/*
+ * The store for store-conditional must be performed under the llsc_prot_mutex,
+ * but it must not go ahead if protection has been lost. The point of resolving
+ * conflicts happens at TLB probe time, so this can be achieved by taking the
+ * lock here, then checking our protection has not been invalidated and probing
+ * the TLB, then performing the store.
+ *
+ * The TLB probe must be non-faulting (to avoid problems with lock recursion).
+ * If the non-faulting probe fails then cpu_resolve_llsc_abort() must be called
+ * (and either perform a full probe and then retry, or perhaps could just fail
+ * the store-conditional).
+ *
+ * The TLB probe while holding the mutex may have to check and invalidate the
+ * protection on other CPUs and therefore it must hold the lock. If
+ * llsc_resolving is true then the lock is held and not acquired again.
+ */
+bool cpu_resolve_llsc_begin(CPUState *cpu)
+{
+    if (!cpu->llsc_prot_active) {
+        return false;
+    }
+    qemu_mutex_lock(&llsc_prot_mutex);
+    if (!cpu->llsc_prot_active) {
+        qemu_mutex_unlock(&llsc_prot_mutex);
+        return false;
+    }
+
+    g_assert(!cpu->llsc_resolving);
+    cpu->llsc_resolving = true;
+
+    return true;
+}
+
+void cpu_resolve_llsc_abort(CPUState *cpu)
+{
+    cpu->llsc_resolving = false;
+    qemu_mutex_unlock(&llsc_prot_mutex);
+}
+
+bool cpu_resolve_llsc_check(CPUState *cpu, ram_addr_t addr)
+{
+    g_assert(cpu->llsc_resolving);
+    g_assert(cpu->llsc_prot_active);
+
+    addr &= ~(cpu->llsc_prot_block_size - 1);
+    if (cpu->llsc_prot_address != addr) {
+        cpu->llsc_prot_active = false;
+        cpu->llsc_resolving = false;
+        qemu_mutex_unlock(&llsc_prot_mutex);
+        return false;
+    }
+
+    return true;
+}
+
+void cpu_resolve_llsc_success(CPUState *cpu)
+{
+    ram_addr_t addr;
+
+    addr = cpu->llsc_prot_address;
+    g_assert(addr != -1ULL);
+    assert(cpu->llsc_prot_active);
+    cpu->llsc_prot_active = false;
+
+    /* Leave the llsc_prot_address under active watch, for performance */
+//    cpu->llsc_prot_address = -1ULL;
+//    cpu_teardown_llsc_prot(addr);
+    g_assert(cpu->llsc_resolving);
+    cpu->llsc_resolving = false;
+
+    qemu_mutex_unlock(&llsc_prot_mutex);
+}
+
+static void other_cpus_clear_llsc_prot(CPUState *cpu, ram_addr_t addr,
+                                              unsigned size)
+{
+    CPUState *c;
+    ram_addr_t end;
+    bool teardown = false;
+
+    end = (addr + size - 1) & ~(cpu->llsc_prot_block_size - 1);
+    addr &= ~(cpu->llsc_prot_block_size - 1);
+
+    if (!cpu->llsc_resolving) {
+        qemu_mutex_lock(&llsc_prot_mutex);
+    }
+
+    CPU_FOREACH(c) {
+        ram_addr_t a = c->llsc_prot_address;
+
+        if (c == cpu) {
+            continue;
+        }
+        if (a == -1ULL) {
+            assert(!c->llsc_prot_active);
+            continue;
+        }
+	if (a == addr || a == end) {
+            if (c->llsc_prot_active) {
+                c->llsc_prot_active = false;
+            } else {
+                teardown = true;
+            }
+        }
+    }
+    if (teardown) {
+        cpu_teardown_llsc_prot(addr);
+        if (end != addr) {
+            cpu_teardown_llsc_prot(end);
+        }
+    }
+
+    if (!cpu->llsc_resolving) {
+        qemu_mutex_unlock(&llsc_prot_mutex);
+    }
+}
+#endif
+
 static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
                            CPUTLBEntryFull *full, uintptr_t retaddr)
 {
@@ -1419,11 +1596,18 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
         tb_invalidate_phys_range_fast(ram_addr, size, retaddr);
     }
 
+#ifdef TARGET_HAS_LLSC_PROT
+    if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_LLSC_PROT)) {
+        other_cpus_clear_llsc_prot(cpu, ram_addr, size);
+    }
+#endif
+
     /*
      * Set both VGA and migration bits for simplicity and to remove
-     * the notdirty callback faster.
+     * the notdirty callback faster. Code and llsc_prot don't get set
+     * because we always want callbacks for them.
      */
-    cpu_physical_memory_set_dirty_range(ram_addr, size, DIRTY_CLIENTS_NOCODE);
+    cpu_physical_memory_set_dirty_range(ram_addr, size, DIRTY_CLIENTS_ONESHOT);
 
     /* We remove the notdirty callback only if the code has been flushed. */
     if (!cpu_physical_memory_is_clean(ram_addr)) {
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 67db07741d..edfbffb705 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -250,6 +250,11 @@ static void cpu_common_initfn(Object *obj)
     cpu->nr_cores = 1;
     cpu->nr_threads = 1;
     cpu->cflags_next_tb = -1;
+#ifdef TARGET_HAS_LLSC_PROT
+    cpu->llsc_prot_active = false;
+    cpu->llsc_prot_address = -1ULL;
+    cpu->llsc_resolving = false;
+#endif
 
     qemu_mutex_init(&cpu->work_mutex);
     qemu_lockcnt_init(&cpu->in_ioctl_lock);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 059bfdc07a..f50ff712cf 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1174,7 +1174,7 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
     if (!bcontainer->dirty_pages_supported && !all_device_dirty_tracking) {
         cpu_physical_memory_set_dirty_range(ram_addr, size,
                                             tcg_enabled() ? DIRTY_CLIENTS_ALL :
-                                            DIRTY_CLIENTS_NOCODE);
+                                            DIRTY_CLIENTS_ONESHOT);
         return 0;
     }
 
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2c9ac79468..a57b153505 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -520,6 +520,7 @@ static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
          */
         handled_dirty = (1 << DIRTY_MEMORY_MIGRATION) |
             (1 << DIRTY_MEMORY_CODE);
+        /* XXX: llsc? */
 
         if (dirty_mask & ~handled_dirty) {
             trace_vhost_reject_section(mr->name, 1);
diff --git a/system/memory.c b/system/memory.c
index a229a79988..b2bac2d3b5 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1863,6 +1863,9 @@ uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
     if (tcg_enabled() && rb) {
         /* TCG only cares about dirty memory logging for RAM, not IOMMU.  */
         mask |= (1 << DIRTY_MEMORY_CODE);
+#ifdef TARGET_HAS_LLSC_PROT
+        mask |= (1 << DIRTY_MEMORY_LLSC_PROT);
+#endif
     }
     return mask;
 }
diff --git a/system/physmem.c b/system/physmem.c
index dc0d8b16aa..aac227f0d2 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2591,6 +2591,13 @@ static void invalidate_and_set_dirty(MemoryRegion *mr, hwaddr addr,
         dirty_log_mask =
             cpu_physical_memory_range_includes_clean(addr, length, dirty_log_mask);
     }
+#ifdef TARGET_HAS_LLSC_PROT
+    if (dirty_log_mask & (1 << DIRTY_MEMORY_LLSC_PROT)) {
+        assert(tcg_enabled());
+        /* XXX should invalidate CPU's llsc_prot protections here? */
+        dirty_log_mask &= ~(1 << DIRTY_MEMORY_LLSC_PROT);
+    }
+#endif
     if (dirty_log_mask & (1 << DIRTY_MEMORY_CODE)) {
         assert(tcg_enabled());
         tb_invalidate_phys_range(addr, addr + length - 1);
diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index 0e6f3940a9..c9730de37b 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -286,7 +286,8 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
         stl_p(ptr, val);
 
         dirty_log_mask = memory_region_get_dirty_log_mask(mr);
-        dirty_log_mask &= ~(1 << DIRTY_MEMORY_CODE);
+//        dirty_log_mask &= ~((1 << DIRTY_MEMORY_CODE) | (1 << DIRTY_MEMORY_LLSC_PROT));
+        dirty_log_mask &= DIRTY_CLIENTS_ONESHOT;
         cpu_physical_memory_set_dirty_range(memory_region_get_ram_addr(mr) + addr,
                                             4, dirty_log_mask);
         r = MEMTX_OK;
-- 
2.42.0


