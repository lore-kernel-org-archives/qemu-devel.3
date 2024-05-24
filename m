Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58DAC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 17:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAYPJ-0008EO-4D; Fri, 24 May 2024 13:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sAYPF-0008Dh-VG
 for qemu-devel@nongnu.org; Fri, 24 May 2024 13:08:38 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sAYP1-0007ZY-8c
 for qemu-devel@nongnu.org; Fri, 24 May 2024 13:08:37 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-792ce7a1febso302876585a.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 10:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1716570500; x=1717175300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m81ihihXbX3dByguU9U1kCLKTPvRq+pYAv8JMDaNtfI=;
 b=lDjHxtdo37VGpiRGcxZTiKY2H6/IIovmSt5z5j5THJN5ZRdIZjIfuu3VWm4DvC22Cs
 CaG1INUdqKDfA5L417PpEhcBX9KdhOjkfl3v2wQ2AjmSvdz8oYLjuLMpVrVfPxTgfi/e
 oDypGmyY5wu1rbtlX0csTPRIiOctYkOCLaz+hpP7fCPf6nyFJCViQyjFIcsz3PMDPJKx
 0HBzHImcpgbzNjmadMVN7EV4gdNsQ7QzU6DSqbJ+tg96TeWx2IvgUI3MKEw52RyEcZK6
 AqsrLWD2r3+MmIavmE3AkKHz32SDdXXb8K/+OXvz7Bd6EugpSIHwDd+W3KAyx5/GwyJG
 VPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716570500; x=1717175300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m81ihihXbX3dByguU9U1kCLKTPvRq+pYAv8JMDaNtfI=;
 b=oCRcwvEjs6DbPiIj/kvEI+Fwwkr2Ly4xLosj1HvUjB8H3+jHyZGCbMJAWnwKJd9XR7
 lezk7abNa5QidEt7CMfzIb0Y9rPT6kqj2pNuWeKd7nWcoCAfGv1kXs3i9DBqouywtSAV
 Larz1J1xlvm05jBbcJcQhGh4Y+FDa+cT1rQtShuuqGazjVsa5WReE+Zkno3Xk66l+aon
 wKWwUfHtvV+0rMyvuulHklF0lhXysprBEpe9ReQjFzBBD4ZVblfm2wbFfF5VxgbVqm+z
 dkiW4QaerHeKhb/gr/tcjzmaI07p3Ht6ZP0uMLdFuaaPcANZZhhd8T2I6kFqhbiewj/j
 c/Vg==
X-Gm-Message-State: AOJu0Ywuun+U6Zn+TM/SY7VNrNAA+7qedPSpLcNbSN5vV+ohFNgGUsWE
 /1GdB5z2vm53MShfdQpUHAJIMWUUb+LeR2W+jmap4L0Iv6uErFIl5Ow9Ok3ugtoSoIbhZAK673m
 QfGfdYEuLV+1FMrAfe87/uN0plCfuDOPg3mhmHvlAwKVmvGsGS/kCJ7Rhkk17/G6QdTSSKdo4mu
 vwMZCSRH/hECedwyEm/re/jvONjlXP
X-Google-Smtp-Source: AGHT+IGLBU+ZWY5gA2oRUcMCo7SpAXOG50Pz6Zevh0sIkShivp2aubSlilcR3VNwqmfbon9kwtjfYg==
X-Received: by 2002:a05:620a:c4b:b0:792:c2b7:5fd6 with SMTP id
 af79cd13be357-794ab110c21mr339397885a.50.1716570500099; 
 Fri, 24 May 2024 10:08:20 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc0f0fsm79816585a.38.2024.05.24.10.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 10:08:19 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org, Don Porter <porter@cs.unc.edu>
Subject: [PATCH v2 6/6] Convert x86_mmu_translate() to use common code.
Date: Fri, 24 May 2024 13:07:48 -0400
Message-Id: <20240524170748.1842030-7-porter@cs.unc.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524170748.1842030-1-porter@cs.unc.edu>
References: <ZiKkWCjreGOMFX5p@gallifrey>
 <20240524170748.1842030-1-porter@cs.unc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=porter@cs.unc.edu; helo=mail-qk1-x72d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Don Porter <porter@cs.unc.edu>
---
 target/i386/arch_memory_mapping.c    |  37 ++-
 target/i386/cpu.h                    |  11 +-
 target/i386/helper.c                 | 371 ++++++---------------------
 target/i386/tcg/sysemu/excp_helper.c |   2 +-
 4 files changed, 128 insertions(+), 293 deletions(-)

diff --git a/target/i386/arch_memory_mapping.c b/target/i386/arch_memory_mapping.c
index 040464dd34..9ea5aeff16 100644
--- a/target/i386/arch_memory_mapping.c
+++ b/target/i386/arch_memory_mapping.c
@@ -33,7 +33,7 @@
  * Returns a hardware address on success.  Should not fail (i.e., caller is
  * responsible to ensure that a page table is actually present).
  */
-static hwaddr mmu_page_table_root(CPUState *cs, int *height)
+hwaddr mmu_page_table_root(CPUState *cs, int *height)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
@@ -228,6 +228,35 @@ static void _mmu_decode_va_parameters(CPUState *cs, int height,
     }
 }
 
+/**
+ * mmu_virtual_to_pte_index - Given a virtual address and height in the
+ *       page table radix tree, return the index that should be used
+ *       to look up the next page table entry (pte) in translating an
+ *       address.
+ *
+ * @cs - CPU state
+ * @vaddr - The virtual address to translate
+ * @height - height of node within the tree (leaves are 1, not 0).
+ *
+ * Example: In 32-bit x86 page tables, the virtual address is split
+ * into 10 bits at height 2, 10 bits at height 1, and 12 offset bits.
+ * So a call with VA and height 2 would return the first 10 bits of va,
+ * right shifted by 22.
+ */
+
+int mmu_virtual_to_pte_index(CPUState *cs, target_ulong vaddr, int height)
+{
+    int shift = 0;
+    int width = 0;
+    int mask = 0;
+
+    _mmu_decode_va_parameters(cs, height, &shift, &width);
+
+    mask = (1 << width) - 1;
+
+    return (vaddr >> shift) & mask;
+}
+
 /**
  * get_pte - Copy the contents of the page table entry at node[i] into pt_entry.
  *           Optionally, add the relevant bits to the virtual address in
@@ -247,7 +276,7 @@ static void _mmu_decode_va_parameters(CPUState *cs, int height,
  *              Optional parameter.
  */
 
-static void
+void
 get_pte(CPUState *cs, hwaddr node, int i, int height,
         PTE_t *pt_entry, target_ulong vaddr_parent, target_ulong *vaddr_pte,
         hwaddr *pte_paddr)
@@ -284,7 +313,7 @@ get_pte(CPUState *cs, hwaddr node, int i, int height,
 }
 
 
-static bool
+bool
 mmu_pte_check_bits(CPUState *cs, PTE_t *pte, int64_t mask)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -300,7 +329,7 @@ mmu_pte_check_bits(CPUState *cs, PTE_t *pte, int64_t mask)
  * mmu_pte_presetn - Return true if the pte is
  *                   marked 'present'
  */
-static bool
+bool
 mmu_pte_present(CPUState *cs, PTE_t *pte)
 {
     return mmu_pte_check_bits(cs, pte, PG_PRESENT_MASK);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 39ce49e61f..51d4a55e6b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2151,15 +2151,23 @@ int x86_cpu_write_elf64_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
 int x86_cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
                                  DumpState *s);
 
+hwaddr mmu_page_table_root(CPUState *cs, int *height);
+bool mmu_pte_check_bits(CPUState *cs, PTE_t *pte, int64_t mask);
+bool mmu_pte_present(CPUState *cs, PTE_t *pte);
 bool mmu_pte_leaf(CPUState *cs, int height, PTE_t *pte);
 target_ulong mmu_pte_leaf_page_size(CPUState *cs, int height);
 hwaddr mmu_pte_child(CPUState *cs, PTE_t *pte, int height);
 int mmu_page_table_entries_per_node(CPUState *cs, int height);
+int mmu_virtual_to_pte_index(CPUState *cs, target_ulong vaddr, int height);
 bool for_each_pte(CPUState *cs,
                   int (*fn)(CPUState *cs, void *data, PTE_t *pte,
                             target_ulong vaddr, int height, int offset),
                   void *data, bool visit_interior_nodes,
                   bool visit_not_present);
+void get_pte(CPUState *cs, hwaddr node, int i, int height, PTE_t *pt_entry,
+             target_ulong vaddr_parent, target_ulong *vaddr_pte,
+             hwaddr *pte_paddr);
+
 
 bool x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
                                 Error **errp);
@@ -2176,7 +2184,8 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env);
 bool x86_cpu_get_physical_address(CPUX86State *env, vaddr addr,
                                   MMUAccessType access_type, int mmu_idx,
                                   X86TranslateResult *out,
-                                  X86TranslateFault *err, uint64_t ra);
+                                  X86TranslateFault *err, uint64_t ra,
+                                  bool read_only);
 
 hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 21445e84b2..17ffba200d 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -304,7 +304,8 @@ static bool ptw_translate(X86PTETranslate *inout, hwaddr addr, uint64_t ra)
 
 static bool x86_mmu_translate(CPUX86State *env, const X86TranslateParams *in,
                               X86TranslateResult *out,
-                              X86TranslateFault *err, uint64_t ra)
+                              X86TranslateFault *err, uint64_t ra,
+                              bool read_only)
 {
     const target_ulong addr = in->addr;
     const int pg_mode = in->pg_mode;
@@ -320,6 +321,9 @@ static bool x86_mmu_translate(CPUX86State *env, const X86TranslateParams *in,
     uint32_t pkr;
     int page_size;
     int error_code;
+    CPUState *cs = env_cpu(env);
+    int height;
+    bool pae_enabled = env->cr[4] & CR4_PAE_MASK;
 
  restart_all:
     rsvd_mask = ~MAKE_64BIT_MASK(0, env_archcpu(env)->phys_bits);
@@ -328,194 +332,85 @@ static bool x86_mmu_translate(CPUX86State *env, const X86TranslateParams *in,
         rsvd_mask |= PG_NX_MASK;
     }
 
-    if (pg_mode & PG_MODE_PAE) {
-#ifdef TARGET_X86_64
-        if (pg_mode & PG_MODE_LMA) {
-            if (pg_mode & PG_MODE_LA57) {
-                /*
-                 * Page table level 5
-                 */
-                pte_addr = (in->cr3 & ~0xfff) + (((addr >> 48) & 0x1ff) << 3);
-                if (!ptw_translate(&pte_trans, pte_addr, ra)) {
-                    return false;
-                }
-            restart_5:
-                pte = ptw_ldq(&pte_trans, ra);
-                if (!(pte & PG_PRESENT_MASK)) {
-                    goto do_fault;
-                }
-                if (pte & (rsvd_mask | PG_PSE_MASK)) {
-                    goto do_fault_rsvd;
-                }
-                if (!ptw_setl(&pte_trans, pte, PG_ACCESSED_MASK)) {
-                    goto restart_5;
-                }
-                ptep = pte ^ PG_NX_MASK;
-            } else {
-                pte = in->cr3;
-                ptep = PG_NX_MASK | PG_USER_MASK | PG_RW_MASK;
-            }
+    /* Get the root of the page table */
 
-            /*
-             * Page table level 4
-             */
-            pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 39) & 0x1ff) << 3);
-            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
-                return false;
-            }
-        restart_4:
-            pte = ptw_ldq(&pte_trans, ra);
-            if (!(pte & PG_PRESENT_MASK)) {
-                goto do_fault;
-            }
-            if (pte & (rsvd_mask | PG_PSE_MASK)) {
-                goto do_fault_rsvd;
-            }
-            if (!ptw_setl(&pte_trans, pte, PG_ACCESSED_MASK)) {
-                goto restart_4;
-            }
-            ptep &= pte ^ PG_NX_MASK;
+    /*
+     * ptep is really an accumulator for the permission bits.
+     * Thus, the xor-ing totally trashes the high bits, and that is
+     * ok - we only care about the low ones.
+     */
+    ptep = PG_NX_MASK | PG_USER_MASK | PG_RW_MASK;
+    hwaddr pt_node = mmu_page_table_root(cs, &height);
 
-            /*
-             * Page table level 3
-             */
-            pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 30) & 0x1ff) << 3);
-            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
-                return false;
-            }
-        restart_3_lma:
-            pte = ptw_ldq(&pte_trans, ra);
-            if (!(pte & PG_PRESENT_MASK)) {
-                goto do_fault;
-            }
-            if (pte & rsvd_mask) {
-                goto do_fault_rsvd;
-            }
-            if (!ptw_setl(&pte_trans, pte, PG_ACCESSED_MASK)) {
-                goto restart_3_lma;
-            }
-            ptep &= pte ^ PG_NX_MASK;
-            if (pte & PG_PSE_MASK) {
-                /* 1 GB page */
-                page_size = 1024 * 1024 * 1024;
-                goto do_check_protect;
-            }
-        } else
-#endif
-        {
-            /*
-             * Page table level 3
-             */
-            pte_addr = (in->cr3 & 0xffffffe0ULL) + ((addr >> 27) & 0x18);
-            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
-                return false;
-            }
-            rsvd_mask |= PG_HI_USER_MASK;
-        restart_3_nolma:
-            pte = ptw_ldq(&pte_trans, ra);
-            if (!(pte & PG_PRESENT_MASK)) {
-                goto do_fault;
-            }
-            if (pte & (rsvd_mask | PG_NX_MASK)) {
-                goto do_fault_rsvd;
-            }
-            if (!ptw_setl(&pte_trans, pte, PG_ACCESSED_MASK)) {
-                goto restart_3_nolma;
-            }
-            ptep = PG_NX_MASK | PG_USER_MASK | PG_RW_MASK;
-        }
+    /* Special case for PAE paging */
+    if (height == 3 && pg_mode & PG_MODE_PAE) {
+        rsvd_mask |= PG_HI_USER_MASK;
+    }
 
-        /*
-         * Page table level 2
-         */
-        pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 21) & 0x1ff) << 3);
+    int i = height;
+    do {
+        int index = mmu_virtual_to_pte_index(cs, addr, i);
+        PTE_t pt_entry;
+        uint64_t my_rsvd_mask = rsvd_mask;
+
+        get_pte(cs, pt_node, index, i, &pt_entry, 0, NULL, &pte_addr);
+        /* Check that we can access the page table entry */
         if (!ptw_translate(&pte_trans, pte_addr, ra)) {
             return false;
         }
-    restart_2_pae:
-        pte = ptw_ldq(&pte_trans, ra);
-        if (!(pte & PG_PRESENT_MASK)) {
+
+    restart:
+        if (!mmu_pte_present(cs, &pt_entry)) {
             goto do_fault;
         }
-        if (pte & rsvd_mask) {
-            goto do_fault_rsvd;
-        }
-        if (pte & PG_PSE_MASK) {
-            /* 2 MB page */
-            page_size = 2048 * 1024;
-            ptep &= pte ^ PG_NX_MASK;
-            goto do_check_protect;
-        }
-        if (!ptw_setl(&pte_trans, pte, PG_ACCESSED_MASK)) {
-            goto restart_2_pae;
-        }
-        ptep &= pte ^ PG_NX_MASK;
 
-        /*
-         * Page table level 1
-         */
-        pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 12) & 0x1ff) << 3);
-        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
-            return false;
-        }
-        pte = ptw_ldq(&pte_trans, ra);
-        if (!(pte & PG_PRESENT_MASK)) {
-            goto do_fault;
+        /* For height > 3, check and reject PSE mask */
+        if (i > 3) {
+            my_rsvd_mask |= PG_PSE_MASK;
         }
-        if (pte & rsvd_mask) {
+
+        if (mmu_pte_check_bits(cs, &pt_entry, my_rsvd_mask)) {
             goto do_fault_rsvd;
         }
-        /* combine pde and pte nx, user and rw protections */
-        ptep &= pte ^ PG_NX_MASK;
-        page_size = 4096;
-    } else {
-        /*
-         * Page table level 2
-         */
-        pte_addr = (in->cr3 & 0xfffff000ULL) + ((addr >> 20) & 0xffc);
-        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
-            return false;
-        }
-    restart_2_nopae:
-        pte = ptw_ldl(&pte_trans, ra);
-        if (!(pte & PG_PRESENT_MASK)) {
-            goto do_fault;
-        }
-        ptep = pte | PG_NX_MASK;
 
-        /* if PSE bit is set, then we use a 4MB page */
-        if ((pte & PG_PSE_MASK) && (pg_mode & PG_MODE_PSE)) {
-            page_size = 4096 * 1024;
-            /*
-             * Bits 20-13 provide bits 39-32 of the address, bit 21 is reserved.
-             * Leave bits 20-13 in place for setting accessed/dirty bits below.
-             */
-            pte = (uint32_t)pte | ((pte & 0x1fe000LL) << (32 - 13));
-            rsvd_mask = 0x200000;
-            goto do_check_protect_pse36;
-        }
-        if (!ptw_setl(&pte_trans, pte, PG_ACCESSED_MASK)) {
-            goto restart_2_nopae;
-        }
+        pte = pt_entry.pte64_t;
 
-        /*
-         * Page table level 1
-         */
-        pte_addr = (pte & ~0xfffu) + ((addr >> 10) & 0xffc);
-        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
-            return false;
+        /* Check if we have hit a leaf.  Won't happen (yet) at heights > 3. */
+        if (mmu_pte_leaf(cs, i, &pt_entry)) {
+            assert(i < 4);
+            page_size = mmu_pte_leaf_page_size(cs, i);
+            ptep &= pte ^ PG_NX_MASK;
+
+            if (!pae_enabled) {
+                if (i == 2) {
+                    /*
+                     * Bits 20-13 provide bits 39-32 of the address,
+                     * bit 21 is reserved.  Leave bits 20-13 in place
+                     * for setting accessed/dirty bits below.
+                     */
+                    pte = (uint32_t)pte | ((pte & 0x1fe000LL) << (32 - 13));
+                    rsvd_mask = 0x200000;
+                    goto do_check_protect_pse36;
+                } else if (i == 1) {
+                    rsvd_mask = 0;
+                }
+            }
+            break; /* goto do_check_protect; */
         }
-        pte = ptw_ldl(&pte_trans, ra);
-        if (!(pte & PG_PRESENT_MASK)) {
-            goto do_fault;
+
+        if ((!read_only) &&
+            (!ptw_setl(&pte_trans, pte, PG_ACCESSED_MASK))) {
+            goto restart;
         }
-        /* combine pde and pte user and rw protections */
-        ptep &= pte | PG_NX_MASK;
-        page_size = 4096;
-        rsvd_mask = 0;
-    }
 
-do_check_protect:
+        ptep &= pte ^ PG_NX_MASK;
+
+        /* Move to the child node */
+        assert(i > 1);
+        pt_node = mmu_pte_child(cs, &pt_entry, i - 1);
+        i--;
+    } while (i > 0);
+
     rsvd_mask |= (page_size - 1) & PG_ADDRESS_MASK & ~PG_PSE_PAT_MASK;
 do_check_protect_pse36:
     if (pte & rsvd_mask) {
@@ -675,10 +570,16 @@ do_check_protect_pse36:
     return false;
 }
 
+/**
+ * The read-only argument indicates whether this access should
+ * trigger exceptions or otherwise disrupt TLB/MMU state.
+ * It should be true for monitor access, and false for tcg access.
+ */
 bool x86_cpu_get_physical_address(CPUX86State *env, vaddr addr,
                                   MMUAccessType access_type, int mmu_idx,
                                   X86TranslateResult *out,
-                                  X86TranslateFault *err, uint64_t ra)
+                                  X86TranslateFault *err, uint64_t ra,
+                                  bool read_only)
 {
     X86TranslateParams in;
     bool use_stage2 = env->hflags2 & HF2_NPT_MASK;
@@ -699,7 +600,7 @@ bool x86_cpu_get_physical_address(CPUX86State *env, vaddr addr,
                 MMU_USER64_IDX : MMU_USER32_IDX;
             in.ptw_idx = MMU_PHYS_IDX;
 
-            if (!x86_mmu_translate(env, &in, out, err, ra)) {
+            if (!x86_mmu_translate(env, &in, out, err, ra, read_only)) {
                 err->stage2 = S2_GPA;
                 return false;
             }
@@ -730,7 +631,7 @@ bool x86_cpu_get_physical_address(CPUX86State *env, vaddr addr,
                     return false;
                 }
             }
-            return x86_mmu_translate(env, &in, out, err, ra);
+            return x86_mmu_translate(env, &in, out, err, ra, read_only);
         }
         break;
     }
@@ -747,123 +648,19 @@ hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
-    target_ulong pde_addr, pte_addr;
-    uint64_t pte;
-    int32_t a20_mask;
-    uint32_t page_offset;
-    int page_size;
+    X86TranslateResult out;
+    X86TranslateFault err;
 
     *attrs = cpu_get_mem_attrs(env);
 
-    a20_mask = x86_get_a20_mask(env);
-    if (!(env->cr[0] & CR0_PG_MASK)) {
-        pte = addr & a20_mask;
-        page_size = 4096;
-    } else if (env->cr[4] & CR4_PAE_MASK) {
-        target_ulong pdpe_addr;
-        uint64_t pde, pdpe;
-
-#ifdef TARGET_X86_64
-        if (env->hflags & HF_LMA_MASK) {
-            bool la57 = env->cr[4] & CR4_LA57_MASK;
-            uint64_t pml5e_addr, pml5e;
-            uint64_t pml4e_addr, pml4e;
-            int32_t sext;
-
-            /* test virtual address sign extension */
-            sext = la57 ? (int64_t)addr >> 56 : (int64_t)addr >> 47;
-            if (sext != 0 && sext != -1) {
-                return -1;
-            }
-
-            if (la57) {
-                pml5e_addr = ((env->cr[3] & ~0xfff) +
-                        (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
-                pml5e = x86_ldq_phys(cs, pml5e_addr);
-                if (!(pml5e & PG_PRESENT_MASK)) {
-                    return -1;
-                }
-            } else {
-                pml5e = env->cr[3];
-            }
-
-            pml4e_addr = ((pml5e & PG_ADDRESS_MASK) +
-                    (((addr >> 39) & 0x1ff) << 3)) & a20_mask;
-            pml4e = x86_ldq_phys(cs, pml4e_addr);
-            if (!(pml4e & PG_PRESENT_MASK)) {
-                return -1;
-            }
-            pdpe_addr = ((pml4e & PG_ADDRESS_MASK) +
-                         (((addr >> 30) & 0x1ff) << 3)) & a20_mask;
-            pdpe = x86_ldq_phys(cs, pdpe_addr);
-            if (!(pdpe & PG_PRESENT_MASK)) {
-                return -1;
-            }
-            if (pdpe & PG_PSE_MASK) {
-                page_size = 1024 * 1024 * 1024;
-                pte = pdpe;
-                goto out;
-            }
-
-        } else
-#endif
-        {
-            pdpe_addr = ((env->cr[3] & ~0x1f) + ((addr >> 27) & 0x18)) &
-                a20_mask;
-            pdpe = x86_ldq_phys(cs, pdpe_addr);
-            if (!(pdpe & PG_PRESENT_MASK))
-                return -1;
-        }
-
-        pde_addr = ((pdpe & PG_ADDRESS_MASK) +
-                    (((addr >> 21) & 0x1ff) << 3)) & a20_mask;
-        pde = x86_ldq_phys(cs, pde_addr);
-        if (!(pde & PG_PRESENT_MASK)) {
-            return -1;
-        }
-        if (pde & PG_PSE_MASK) {
-            /* 2 MB page */
-            page_size = 2048 * 1024;
-            pte = pde;
-        } else {
-            /* 4 KB page */
-            pte_addr = ((pde & PG_ADDRESS_MASK) +
-                        (((addr >> 12) & 0x1ff) << 3)) & a20_mask;
-            page_size = 4096;
-            pte = x86_ldq_phys(cs, pte_addr);
-        }
-        if (!(pte & PG_PRESENT_MASK)) {
-            return -1;
-        }
-    } else {
-        uint32_t pde;
-
-        /* page directory entry */
-        pde_addr = ((env->cr[3] & ~0xfff) + ((addr >> 20) & 0xffc)) & a20_mask;
-        pde = x86_ldl_phys(cs, pde_addr);
-        if (!(pde & PG_PRESENT_MASK))
-            return -1;
-        if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
-            pte = pde | ((pde & 0x1fe000LL) << (32 - 13));
-            page_size = 4096 * 1024;
-        } else {
-            /* page directory entry */
-            pte_addr = ((pde & ~0xfff) + ((addr >> 10) & 0xffc)) & a20_mask;
-            pte = x86_ldl_phys(cs, pte_addr);
-            if (!(pte & PG_PRESENT_MASK)) {
-                return -1;
-            }
-            page_size = 4096;
-        }
-        pte = pte & a20_mask;
+    /* This function merges the offset bits for us */
+    if (!x86_cpu_get_physical_address(env, addr, MMU_DATA_LOAD,
+                                      cpu_mmu_index(cs, false),
+                                      &out, &err, 0, true)) {
+        return -1;
     }
 
-#ifdef TARGET_X86_64
-out:
-#endif
-    pte &= PG_ADDRESS_MASK & ~(page_size - 1);
-    page_offset = (addr & TARGET_PAGE_MASK) & (page_size - 1);
-    return pte | page_offset;
+    return out.paddr;
 }
 
 typedef struct MCEInjectionParams {
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 4c48e5a68b..c85db11f05 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -56,7 +56,7 @@ bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     X86TranslateFault err;
 
     if (x86_cpu_get_physical_address(env, addr, access_type, mmu_idx, &out,
-                                     &err, retaddr)) {
+                                     &err, retaddr, false)) {
         /*
          * Even if 4MB pages, we map only one 4KB page in the cache to
          * avoid filling it too fast.
-- 
2.34.1


