Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07C5C5DF67
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvL8g-0008CJ-6X; Sat, 15 Aug 2026 16:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8c-00088B-UM
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:37:55 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8R-0008DG-A0
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:37:46 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so2298915a91.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786826262; x=1787431062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eV7TgD7exsKP95UC/n8h4naw41ahKSdAn16sZErXcgc=;
 b=MsBjZnKfXGQHdkEkmRiw23ZWhmBl7AqT7AsajjdKMUz6VI34bdWik60T5h9g3MQPZE
 E3+hokLUSKyBGeEA00c+j7elTwBYkFrlzF8m2TADmKIiVvGcweitQl8/FaPr3/itPe3V
 ql8pwgTq1b/qgXLvsch14u8C26deb0ycip9QTtRXm2QK6ieDCsV/+0VER0W7zB8NShEg
 gyNX4C12ulebu1w8NCA28MAoLFHCOxiFbcwNnHsuDQIr8O60bjJw8FOeEMGJ73/yGf2v
 gwiIYQ84upWo8BNcW0m7BH5nWHmTz6jANTgCht837/iFA8ZtBUE+y6fP3fTU/3MkFJT5
 XdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786826262; x=1787431062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eV7TgD7exsKP95UC/n8h4naw41ahKSdAn16sZErXcgc=;
 b=Vi/fK4Cv7ZzVjatn+gs1lHN027QfYYI4wF/pmdhkYHuhlaMZMc4sbf/rZ8TjRidz5X
 MJzVxg51aAu8sXIkzvX7Y48D2Ze91SVleTqjL6apDAZz8C/UKr/mMTqaDbzzrlyOm0Jc
 FLA+VCoM71FwW5fSGbpFt4w0GZfS+fgSwpERAkbHF1p0/fpeN8gVqqeeea637DD4KBbq
 hqQ+ybZANbeVtdYo9SIY8hVukRW9giBSH0qYNDT7SOAdVYEwwEhSHdL7Jy8YWQ2bEAd2
 bM5OtQOb9pVsxu6PG/0EQBw8KpLcGxIhjm6NP5rwc8Kht5XE3jLLMwQ8wW72Db4wWfst
 3XNQ==
X-Gm-Message-State: AOJu0YwhtLtf/ZNbXFLHz+MB3PmwS7Z1qPNzq5+3ilyhQC7gmTRrL1VI
 qmlBPoq+h2gR3bVQbaJa6HmWpZ6uVZG6hBKP8B0NBOIkmg8aWWOEjNdUKZa5/r14RMvJ/sd2aVu
 5mURH
X-Gm-Gg: AR+sD10vx0Rj3/Oh+yUouwQBBoFkGhV4KR/yG8khAScMCBGtmmWeZVUVV7K0f69EJr7
 ewqtmbHBLyr3KoxyooPNDIHfiUHwKxzdJSCut5nGBwVygc1eteIl00DOb+KEknd6ayV48o5iHRa
 xDmIxSEwP7FhHih4bpMUXMaDJDf0g2xwSWtQnIoppHAkeoAdEf5+c48TPz0mtQfmBqa4tB/I+Ff
 0sIMePTF9UyX3knr7iLbLvdK3FpXnmK9SHCySiBPSh4uXaS6gxvOVQkaI3PK5Dawoa85ZMQxHK5
 OEUmHueS5qAr+rR8JBOC7Ad72yNQPLH3k0dQrumcN6wfqjO0akrwowhCrmGU6k6pzEjHNpUgdUE
 q5rmkMMqO+yyCG3Xj2DAGJi4LqXvysgC04EH48gr6hQZDX0yd4zs3jZ3osWjGu9Z9/NUayL8UZk
 8aWZOCJf9e/VDdjWSrTS3SwSCTBvj6JME+cmNL2AwgvwC36v4dWoMWHVUQsMIzT1NBIJRXxZJkB
 8/siLTA0oTmLNCdReBs
X-Received: by 2002:a17:90b:528f:b0:381:cef1:11ac with SMTP id
 98e67ed59e1d1-3933e5d202amr15857958a91.10.1786826261761; 
 Sat, 15 Aug 2026 13:37:41 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-394ea97207fsm7066853a91.1.2026.08.15.13.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 13:37:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC PATCH 04/18] target/arm: Generalize probe argument to
 allocation_tag_mem_internal
Date: Sat, 15 Aug 2026 13:37:16 -0700
Message-ID: <20260815203730.1468365-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815203730.1468365-1-richard.henderson@linaro.org>
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We had a confusing relationship between 'probe' and 'ra == 0'.
Make this explicit via an enumeration.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mte_helper.c | 130 ++++++++++++++++++++++--------------
 1 file changed, 80 insertions(+), 50 deletions(-)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index dd4c10ef4f..31bf58c937 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -87,28 +87,48 @@ typedef struct AllocationTagMem {
     MemTxAttrs attrs;
 } AllocationTagMem;
 
+typedef enum {
+    /* Trap on missing pages, invalid tag access, or watchpoints. */
+    ATM_NORMAL,
+    /* Gracefully return no tag memory for invalid pages. */
+    ATM_PROBE_PAGES,
+    /*
+     * Basic page access has already been checked,
+     * so a missing tlb entry is some sort of bug.
+     * Assert the tlb entry is present, but gracefully fail if tag
+     * access is not permitted to the page.
+     */
+    ATM_ASSERT_PAGES,
+} AllocationTagMemKind;
+
 static AllocationTagMem
 allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
                             vaddr ptr, MMUAccessType ptr_access,
                             int ptr_size, MMUAccessType tag_access,
-                            bool probe, uintptr_t ra)
+                            uintptr_t ra, AllocationTagMemKind atm_kind)
 {
     AllocationTagMem ret = {
         .flags = TLB_INVALID_MASK,
         .attrs = MEMTXATTRS_UNSPECIFIED,
     };
 
+    assert((atm_kind >= ATM_PROBE_PAGES) == (ra == 0));
+
 #ifdef CONFIG_USER_ONLY
     vaddr clean_ptr = useronly_clean_ptr(ptr);
     int flags = page_get_flags(clean_ptr);
     int req_flags = ptr_access == MMU_DATA_STORE ? PAGE_WRITE_ORG : PAGE_READ;
 
     if (unlikely(!(flags & req_flags))) {
-        if (probe) {
+        switch (atm_kind) {
+        case ATM_PROBE_PAGES:
             goto fini;
+        case ATM_NORMAL:
+            cpu_loop_exit_sigsegv(env_cpu(env), ptr, ptr_access,
+                                  !(flags & PAGE_VALID), ra);
+        default:
+            g_assert_not_reached();
         }
-        cpu_loop_exit_sigsegv(env_cpu(env), ptr, ptr_access,
-                              !(flags & PAGE_VALID), ra);
     }
 
     /* Require both MAP_ANON and PROT_MTE for the page. */
@@ -124,7 +144,6 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
     ret.flags = 0;
 #else
     CPUTLBEntryFull *full;
-    int in_page;
     hwaddr ptr_paddr, tag_paddr, xlat;
     MemoryRegion *mr;
     ARMASIdx tag_asi;
@@ -134,16 +153,12 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
      * Probe the first byte of the virtual address.  This raises an
      * exception for inaccessible pages, and resolves the virtual address
      * into the softmmu tlb.
-     *
-     * When RA == 0, this is either a pure probe or a no-fault-expected probe.
-     * Indicate to probe_access_flags no-fault, then either return NULL
-     * for the pure probe, or assert that we received a valid page for the
-     * no-fault-expected probe.
      */
     ret.flags = probe_access_full(env, ptr, 0, ptr_access, ptr_mmu_idx,
-                                  ra == 0, &ret.ptr_mem, &full, ra);
+                                  atm_kind >= ATM_PROBE_PAGES,
+                                  &ret.ptr_mem, &full, ra);
     if (unlikely(ret.flags & TLB_INVALID_MASK)) {
-        assert(probe);
+        assert(atm_kind == ATM_PROBE_PAGES);
         goto fini;
     }
     ret.attrs = full->attrs;
@@ -154,12 +169,11 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
 
     case 0xe0: /* NoTagAccess */
         if (cpu_isar_feature(aa64_mteperm, env_archcpu(env))) {
-            if (probe) {
+            if (atm_kind >= ATM_PROBE_PAGES) {
                 ret.ptr_mem = NULL;
                 ret.flags = TLB_INVALID_MASK;
                 goto fini;
             }
-            assert(ra);
             mte_perm_check_fail(env, ptr, ra, tag_access == MMU_DATA_STORE);
         }
         /* fall through */
@@ -191,22 +205,21 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
      * tag on the first page.
      * Any page access exception has priority over tag check exception.
      */
-    in_page = -(ptr | TARGET_PAGE_MASK);
-    if (unlikely(ptr_size > in_page)) {
-        void *discard_mem;
-        int flags2 = probe_access_full(env, ptr + in_page, 0, ptr_access,
-                                       ptr_mmu_idx, ra == 0,
-                                       &discard_mem, &full, ra);
+    if (atm_kind == ATM_NORMAL) {
+        int in_page = -(ptr | TARGET_PAGE_MASK);
+        if (unlikely(ptr_size > in_page)) {
+            void *discard_mem;
+            ret.flags |= probe_access_full(env, ptr + in_page, 0, ptr_access,
+                                           ptr_mmu_idx, false,
+                                           &discard_mem, &full, ra);
+        }
 
-        assert(!(flags2 & TLB_INVALID_MASK));
-        ret.flags |= flags2;
-    }
-
-    /* Any debug exception has priority over a tag check exception. */
-    if (!probe && unlikely(ret.flags & TLB_WATCHPOINT)) {
-        int wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ : BP_MEM_WRITE;
-        assert(ra != 0);
-        cpu_check_watchpoint(env_cpu(env), ptr, ptr_size, ret.attrs, wp, ra);
+        /* Any debug exception has priority over a tag check exception. */
+        if (unlikely(ret.flags & TLB_WATCHPOINT)) {
+            int wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ : BP_MEM_WRITE;
+            cpu_check_watchpoint(env_cpu(env), ptr, ptr_size,
+                                 ret.attrs, wp, ra);
+        }
     }
 
     /* Convert to the physical address in tag space.  */
@@ -267,8 +280,8 @@ static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
                                    uintptr_t ra)
 {
     return allocation_tag_mem_internal(env, ptr_mmu_idx, ptr, ptr_access,
-                                       ptr_size, tag_access, false, ra)
-           .tag_mem;
+                                       ptr_size, tag_access,
+                                       ra, ATM_NORMAL).tag_mem;
 }
 
 uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
@@ -276,8 +289,8 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
                                   int ptr_size, MMUAccessType tag_access)
 {
     return allocation_tag_mem_internal(env, ptr_mmu_idx, ptr, ptr_access,
-                                       ptr_size, tag_access, true, 0)
-           .tag_mem;
+                                       ptr_size, tag_access,
+                                       0, ATM_PROBE_PAGES).tag_mem;
 }
 
 uint64_t HELPER(irg)(CPUARMState *env, uint64_t rn, uint64_t rm)
@@ -881,6 +894,7 @@ static int checkNrev(uint8_t *mem, int odd, int cmp, int count)
  * @desc: MTEDESC descriptor
  * @ptr: virtual address of the base of the access
  * @fault: return virtual address of the first check failure
+ * @kind: per allocation_tag_mem_internal
  *
  * Internal routine for both mte_probe and mte_check.
  * Return zero on failure, filling in *fault.
@@ -888,13 +902,14 @@ static int checkNrev(uint8_t *mem, int odd, int cmp, int count)
  * Return positive on success with tbi enabled.
  */
 static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
-                         uintptr_t ra, uint64_t *fault)
+                         uintptr_t ra, uint64_t *fault,
+                         AllocationTagMemKind atm_kind)
 {
     int mmu_idx, ptr_tag, bit55;
     uint64_t ptr_last, prev_page, next_page;
     uint64_t tag_first, tag_last;
     uint32_t sizem1, tag_count, n, c;
-    uint8_t *mem1, *mem2;
+    AllocationTagMem r1, r2;
     MMUAccessType type;
 
     bit55 = extract64(ptr, 55, 1);
@@ -932,9 +947,14 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
 
     if (likely(tag_last - prev_page < TARGET_PAGE_SIZE)) {
         /* Memory access stays on one page. */
-        mem1 = allocation_tag_mem(env, mmu_idx, ptr, type, sizem1 + 1,
-                                  MMU_DATA_LOAD, ra);
-        if (!mem1) {
+        r1 = allocation_tag_mem_internal(env, mmu_idx, ptr, type, sizem1 + 1,
+                                           MMU_DATA_LOAD, ra, atm_kind);
+        if (unlikely(r1.flags & TLB_INVALID_MASK)) {
+            /* Tag access disabled on an otherwise accessible page. */
+            assert(atm_kind == ATM_ASSERT_PAGES);
+            return 0;
+        }
+        if (r1.tag_mem == NULL) {
             /*
              * If mtx is enabled, then the access is MemTag_CanonicallyTagged,
              * otherwise it is Untagged. See AArch64.S1DecodeMemAttrs and
@@ -946,15 +966,22 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
             return 1;
         }
         /* Perform all of the comparisons. */
-        n = checkN(mem1, ptr & TAG_GRANULE, ptr_tag, tag_count);
+        n = checkN(r1.tag_mem, ptr & TAG_GRANULE, ptr_tag, tag_count);
     } else {
         /* Memory access crosses to next page. */
-        mem1 = allocation_tag_mem(env, mmu_idx, ptr, type, next_page - ptr,
-                                  MMU_DATA_LOAD, ra);
+        r1 = allocation_tag_mem_internal(env, mmu_idx, ptr, type,
+                                         next_page - ptr, MMU_DATA_LOAD,
+                                         ra, atm_kind);
 
-        mem2 = allocation_tag_mem(env, mmu_idx, next_page, type,
-                                  ptr_last - next_page + 1,
-                                  MMU_DATA_LOAD, ra);
+        if (r1.flags & TLB_INVALID_MASK) {
+            /* Tag access disabled on an otherwise accessible page. */
+            assert(atm_kind == ATM_ASSERT_PAGES);
+            return 0;
+        }
+
+        r2 = allocation_tag_mem_internal(env, mmu_idx, next_page, type,
+                                         ptr_last - next_page + 1,
+                                         MMU_DATA_LOAD, ra, atm_kind);
 
         /*
          * Perform all of the comparisons.
@@ -963,15 +990,18 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
          * happen with or without mtx (canonical tagging) enabled.
          */
         n = c = (next_page - tag_first) / TAG_GRANULE;
-        if (mem1) {
-            n = checkN(mem1, ptr & TAG_GRANULE, ptr_tag, c);
+        if (r1.tag_mem) {
+            n = checkN(r1.tag_mem, ptr & TAG_GRANULE, ptr_tag, c);
         } else if (mtx_check(desc, bit55) &&
                    !tag_is_canonical(ptr_tag, bit55)) {
             return 0;
         }
         if (n == c) {
-            if (mem2) {
-                n += checkN(mem2, 0, ptr_tag, tag_count - c);
+            if (r2.flags & TLB_INVALID_MASK) {
+                /* Tag access disabled on an otherwise accessible page. */
+                assert(atm_kind == ATM_ASSERT_PAGES);
+            } else if (r2.tag_mem) {
+                n += checkN(r2.tag_mem, 0, ptr_tag, tag_count - c);
             } else if (!mtx_check(desc, bit55) ||
                        tag_is_canonical(ptr_tag, bit55)) {
                 return 1;
@@ -997,7 +1027,7 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
 uint64_t mte_check(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra)
 {
     uint64_t fault;
-    int ret = mte_probe_int(env, desc, ptr, ra, &fault);
+    int ret = mte_probe_int(env, desc, ptr, ra, &fault, ATM_NORMAL);
 
     if (unlikely(ret == 0)) {
         mte_check_fail(env, desc, fault, ra);
@@ -1039,7 +1069,7 @@ uint64_t HELPER(mte_check)(CPUARMState *env, uint32_t desc, uint64_t ptr)
 bool mte_probe(CPUARMState *env, uint32_t desc, uint64_t ptr)
 {
     uint64_t fault;
-    int ret = mte_probe_int(env, desc, ptr, 0, &fault);
+    int ret = mte_probe_int(env, desc, ptr, 0, &fault, ATM_ASSERT_PAGES);
 
     return ret != 0;
 }
-- 
2.43.0


