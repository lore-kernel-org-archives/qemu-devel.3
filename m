Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B17C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHobu-00075m-K9; Thu, 13 Jun 2024 13:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sHobs-00074s-H0
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:51:40 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sHobp-0002cc-4b
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:51:40 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f6da06ba24so12350275ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 10:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718301095; x=1718905895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K7MN5jO4BGA84KdC4/HCnBMc0WB5DAOHP8ovX5LEdXI=;
 b=OJlxQDGOGlqgQrTqzE3IsTP57DZcuWsBC3l/CtxbdQGTpgigeIEhABTzNi/F3/7R4X
 VylnsDc9Aa+0HHfUdKqxDgP1YkCpELI1v/Je/5gCcJdfyIV20i49cDuB/w0xjtsvGVlp
 ukItl7Ko6CmX5CDiY56LslaNGUSAmWXJ3zo/HQBOfXLX4HclhpcnNprygQ5c5IXA6voa
 cU4IUXn6wHRAk30bBNpDvV+PhRsh2Wb9mSXMqq7Kd+G4smLUxG3gtUyDw9fM0zGy20Qa
 7NbkXwctRXP5lVVOdJ+Q73X3+CuYAWqmaMILM8CG6K+zagxwNtGinlDwpZ78hk/vzmAA
 CmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718301095; x=1718905895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K7MN5jO4BGA84KdC4/HCnBMc0WB5DAOHP8ovX5LEdXI=;
 b=aFIl3CJ3BTEElGbfolEEHsrtOVFRV9yQPVJJECEbud2eM+JjBoKjMtvfbr3dHv3Cv/
 rls40l+PkxQSozwLsoSjKTbEKb/lCVziECboYpfPkY++zeYzJF+COSzKRV7L0Lwgpu+s
 iHmQnZTkfHbcaowy7LHMm3XxrltDjtoLHWfdHo4LF3f8vQ2p5P7Annptka4a7UfaLIAB
 VDMdJ3DCaHJVi4kNcYcz2rnm0Wzr+sYkQFED5L2k1/a0Iry+hQGX0A101okaGx9DjXMF
 hpTgxYJZXNDWeGUD1xvlwBCez/7d6whNS0P1W47dkvK7UWJsW3JLT+I/GOak18ippPN0
 s3tw==
X-Gm-Message-State: AOJu0YzAnoAfGPxT239QOfom31QIRz5YWjgcjbb9iygOIp1G+8iKn3Oh
 2wZiENDrHdFe/s3DRoUazkFbQXPhd+xQjMuL7dCijPDg57UtDPtIQBOG+ItNpDcZdoq6DZWCA4R
 HZqpusEFGwBuXlbz3IAEgAXZBFb1cQaPBf8h68WWOue4mqwkNiIYzXmcIJKvxgDvwgGBerl9hf4
 GEP15FBoKF/Ged/cI1VK4FR1MztBcLxEdMaD3Tew==
X-Google-Smtp-Source: AGHT+IECqhBmzNJvxoS+st0QxOvMXNObBofIoJBbP6lAdSkw+YoZ/gRGX8nI4gVkhEwrNQcD4g+hng==
X-Received: by 2002:a17:903:1c7:b0:1f7:364f:1162 with SMTP id
 d9443c01a7336-1f8627cb650mr3877555ad.31.1718301094671; 
 Thu, 13 Jun 2024 10:51:34 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e55d7dsm16780865ad.14.2024.06.13.10.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 10:51:34 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v4 2/5] target/riscv: rvv: Provide a fast path using
 direct access to host ram for unmasked unit-stride load/store
Date: Fri, 14 Jun 2024 01:51:19 +0800
Message-Id: <20240613175122.1299212-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613175122.1299212-1-max.chou@sifive.com>
References: <20240613175122.1299212-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This commit references the sve_ldN_r/sve_stN_r helper functions in ARM
target to optimize the vector unmasked unit-stride load/store
instructions by following items:

* Get the loose bound of activate elements
* Probing pages/resolving host memory address/handling watchpoint at beginning
* Provide new interface to direct access host memory

The original element load/store interface is replaced by the new element
load/store functions with _tlb & _host postfix that means doing the
element load/store through the original softmmu flow and the direct
access host memory flow.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc |   3 +
 target/riscv/vector_helper.c            | 637 +++++++++++++++++++-----
 target/riscv/vector_internals.h         |  48 ++
 3 files changed, 551 insertions(+), 137 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 3a3896ba06c..14e10568bd7 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -770,6 +770,7 @@ static bool ld_us_mask_op(DisasContext *s, arg_vlm_v *a, uint8_t eew)
     /* Mask destination register are always tail-agnostic */
     data = FIELD_DP32(data, VDATA, VTA, s->cfg_vta_all_1s);
     data = FIELD_DP32(data, VDATA, VMA, s->vma);
+    data = FIELD_DP32(data, VDATA, VM, 1);
     return ldst_us_trans(a->rd, a->rs1, data, fn, s, false);
 }
 
@@ -787,6 +788,7 @@ static bool st_us_mask_op(DisasContext *s, arg_vsm_v *a, uint8_t eew)
     /* EMUL = 1, NFIELDS = 1 */
     data = FIELD_DP32(data, VDATA, LMUL, 0);
     data = FIELD_DP32(data, VDATA, NF, 1);
+    data = FIELD_DP32(data, VDATA, VM, 1);
     return ldst_us_trans(a->rd, a->rs1, data, fn, s, true);
 }
 
@@ -1106,6 +1108,7 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
     TCGv_i32 desc;
 
     uint32_t data = FIELD_DP32(0, VDATA, NF, nf);
+    data = FIELD_DP32(data, VDATA, VM, 1);
     dest = tcg_temp_new_ptr();
     desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
                                       s->cfg_ptr->vlenb, data));
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 1b4d5a8e378..3d284138fb3 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -29,6 +29,7 @@
 #include "tcg/tcg-gvec-desc.h"
 #include "internals.h"
 #include "vector_internals.h"
+#include "hw/core/tcg-cpu-ops.h"
 #include <math.h>
 
 target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
@@ -136,6 +137,270 @@ static void probe_pages(CPURISCVState *env, target_ulong addr,
     }
 }
 
+/*
+ * Find first active element on each page, and a loose bound for the
+ * final element on each page.  Identify any single element that spans
+ * the page boundary. Return true if there are any active elements.
+ */
+static bool vext_cont_ldst_elements(RVVContLdSt *info, target_ulong addr,
+                                    void *v0, uint32_t vstart, uint32_t evl,
+                                    uint32_t desc, uint32_t log2_esz,
+                                    bool is_us_whole)
+{
+    uint32_t vm = vext_vm(desc);
+    uint32_t nf = vext_nf(desc);
+    uint32_t max_elems = vext_max_elems(desc, log2_esz);
+    uint32_t esz = 1 << log2_esz;
+    uint32_t msize = is_us_whole ? esz : nf * esz;
+    int32_t reg_idx_first = -1, reg_idx_last = -1, reg_idx_split;
+    int32_t mem_off_last, mem_off_split;
+    int32_t page_split, elt_split;
+    int32_t i;
+
+    /* Set all of the element indices to -1, and the TLB data to 0. */
+    memset(info, -1, offsetof(RVVContLdSt, page));
+    memset(info->page, 0, sizeof(info->page));
+
+    /* Gross scan over the mask register v0 to find bounds. */
+    if (vm == 0) {
+        for (i = vstart; i < evl; ++i) {
+            if (vext_elem_mask(v0, i)) {
+                reg_idx_last = i;
+                if (reg_idx_first < 0) {
+                    reg_idx_first = i;
+                }
+            }
+        }
+    } else {
+        reg_idx_first = vstart;
+        reg_idx_last = evl - 1;
+    }
+
+    if (unlikely(reg_idx_first < 0)) {
+        /* No active elements, no pages touched. */
+        return false;
+    }
+    tcg_debug_assert(reg_idx_last >= 0 && reg_idx_last < max_elems);
+
+    info->reg_idx_first[0] = reg_idx_first;
+    info->mem_off_first[0] = reg_idx_first * msize;
+    mem_off_last = reg_idx_last * msize;
+
+    page_split = -(addr | TARGET_PAGE_MASK);
+    if (likely(mem_off_last + msize <= page_split)) {
+        /* The entire operation fits within a single page. */
+        info->reg_idx_last[0] = reg_idx_last;
+        return true;
+    }
+
+    info->page_split = page_split;
+    elt_split = page_split / msize;
+    reg_idx_split = elt_split;
+    mem_off_split = elt_split * msize;
+
+    /*
+     * This is the last full element on the first page, but it is not
+     * necessarily active.  If there is no full element, i.e. the first
+     * active element is the one that's split, this value remains -1.
+     * It is useful as iteration bounds.
+     */
+    if (elt_split != 0) {
+        info->reg_idx_last[0] = reg_idx_split - 1;
+    }
+
+    /* Determine if an unaligned element spans the pages.  */
+    if (page_split % msize != 0) {
+        /* It is helpful to know if the split element is active. */
+        if (vm == 1 || (vm == 0 && vext_elem_mask(v0, reg_idx_split))) {
+            info->reg_idx_split = reg_idx_split;
+            info->mem_off_split = mem_off_split;
+
+            if (reg_idx_split == reg_idx_last) {
+                /* The page crossing element is last. */
+                return true;
+            }
+        }
+        reg_idx_split++;
+        mem_off_split += msize;
+    }
+
+    /*
+     * We do want the first active element on the second page, because
+     * this may affect the address reported in an exception.
+     */
+    if (vm == 0) {
+        for (; reg_idx_split < evl; ++reg_idx_split) {
+            if (vext_elem_mask(v0, reg_idx_split)) {
+                break;
+            }
+        }
+    }
+    tcg_debug_assert(reg_idx_split <= reg_idx_last);
+    info->reg_idx_first[1] = reg_idx_split;
+    info->mem_off_first[1] = reg_idx_split * msize;
+    info->reg_idx_last[1] = reg_idx_last;
+    return true;
+}
+
+/*
+ * Resolve the guest virtual address to info->host and info->flags.
+ * If @nofault, return false if the page is invalid, otherwise
+ * exit via page fault exception.
+ */
+static bool vext_probe_page(CPURISCVState *env, RVVHostPage *info,
+                            bool nofault, target_ulong addr, int mem_off,
+                            int size, MMUAccessType access_type, int mmu_idx,
+                            uintptr_t ra)
+{
+    int flags;
+
+    addr += mem_off;
+
+#ifdef CONFIG_USER_ONLY
+    flags = probe_access_flags(env, adjust_addr(env, addr), size, access_type,
+                               mmu_idx, nofault, &info->host, ra);
+#else
+    CPUTLBEntryFull *full;
+    flags = probe_access_full(env, adjust_addr(env, addr), size, access_type,
+                              mmu_idx, nofault, &info->host, &full, ra);
+#endif
+    info->flags = flags;
+
+    if (flags & TLB_INVALID_MASK) {
+        g_assert(nofault);
+        return false;
+    }
+
+#ifdef CONFIG_USER_ONLY
+    memset(&info->attrs, 0, sizeof(info->attrs));
+#else
+    info->attrs = full->attrs;
+#endif
+
+    /* Ensure that info->host[] is relative to addr, not addr + mem_off. */
+    info->host -= mem_off;
+    return true;
+}
+
+/*
+ * Resolve the guest virtual addresses to info->page[].
+ * Control the generation of page faults with @fault.  Return false if
+ * there is no work to do, which can only happen with @fault == FAULT_NO.
+ */
+static bool vext_cont_ldst_pages(CPURISCVState *env, RVVContLdSt *info,
+                                 target_ulong addr, bool is_load,
+                                 uint32_t desc, uint32_t esz, uintptr_t ra,
+                                 bool is_us_whole)
+{
+    uint32_t vm = vext_vm(desc);
+    uint32_t nf = vext_nf(desc);
+    bool nofault = (vm == 1 ? false : true);
+    int mmu_index = riscv_env_mmu_index(env, false);
+    int mem_off = info->mem_off_first[0];
+    int elem_size = is_us_whole ? esz : (nf * esz);
+    int size, last_idx;
+    MMUAccessType access_type = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;
+    bool have_work;
+
+    size = (info->reg_idx_last[0] - info->reg_idx_first[0] + 1) * elem_size;
+
+    have_work = vext_probe_page(env, &info->page[0], nofault, addr, mem_off,
+                                size, access_type, mmu_index, ra);
+    if (!have_work) {
+        /* No work to be done. */
+        return false;
+    }
+
+    if (likely(info->page_split < 0)) {
+        /* The entire operation was on the one page. */
+        return true;
+    }
+
+    /*
+     * If the second page is invalid, then we want the fault address to be
+     * the first byte on that page which is accessed.
+     */
+    if (info->mem_off_split >= 0) {
+        /*
+         * There is an element split across the pages.  The fault address
+         * should be the first byte of the second page.
+         */
+        mem_off = info->page_split;
+        last_idx = info->reg_idx_split + 1;
+    } else {
+        /*
+         * There is no element split across the pages.  The fault address
+         * should be the first active element on the second page.
+         */
+        mem_off = info->mem_off_first[1];
+        last_idx = info->reg_idx_last[1];
+    }
+    size = last_idx * elem_size - mem_off + esz;
+    have_work |= vext_probe_page(env, &info->page[1], nofault, addr, mem_off,
+                                 size, access_type, mmu_index, ra);
+    return have_work;
+}
+
+#ifndef CONFIG_USER_ONLY
+void vext_cont_ldst_watchpoints(CPURISCVState *env, RVVContLdSt *info,
+                                uint64_t *v0, target_ulong addr,
+                                uint32_t esz, bool is_load, uintptr_t ra,
+                                uint32_t desc)
+{
+    int32_t i;
+    intptr_t mem_off, reg_off, reg_last;
+    uint32_t vm = vext_vm(desc);
+    int wp_access = is_load == true ? BP_MEM_READ : BP_MEM_WRITE;
+    int flags0 = info->page[0].flags;
+    int flags1 = info->page[1].flags;
+
+    if (likely(!((flags0 | flags1) & TLB_WATCHPOINT))) {
+        return;
+    }
+
+    /* Indicate that watchpoints are handled. */
+    info->page[0].flags = flags0 & ~TLB_WATCHPOINT;
+    info->page[1].flags = flags1 & ~TLB_WATCHPOINT;
+
+    if (flags0 & TLB_WATCHPOINT) {
+        mem_off = info->mem_off_first[0];
+        reg_off = info->reg_idx_first[0];
+        reg_last = info->reg_idx_last[0];
+
+        for (i = reg_off; i < reg_last; ++i, mem_off += esz) {
+            if (vm == 1 || (vm == 0 && vext_elem_mask(v0, i))) {
+                cpu_check_watchpoint(env_cpu(env),
+                                     adjust_addr(env, addr + mem_off), esz,
+                                     info->page[0].attrs, wp_access, ra);
+            }
+        }
+    }
+
+    mem_off = info->mem_off_split;
+    if (mem_off >= 0) {
+        if (vm == 1 || (vm == 0 && vext_elem_mask(v0, mem_off / esz))) {
+            cpu_check_watchpoint(env_cpu(env),
+                                 adjust_addr(env, addr + mem_off), esz,
+                                 info->page[0].attrs, wp_access, ra);
+        }
+    }
+
+    mem_off = info->mem_off_first[1];
+    if ((flags1 & TLB_WATCHPOINT) && mem_off >= 0) {
+        reg_off = info->reg_idx_first[1];
+        reg_last = info->reg_idx_last[1];
+
+        for (i = reg_off; i < reg_last; ++i, mem_off += esz) {
+            if (vm == 1 || (vm == 0 && vext_elem_mask(v0, i))) {
+                cpu_check_watchpoint(env_cpu(env),
+                                     adjust_addr(env, addr + mem_off), esz,
+                                     info->page[1].attrs, wp_access, ra);
+            }
+        }
+    }
+}
+#endif
+
 static inline void vext_set_elem_mask(void *v0, int index,
                                       uint8_t value)
 {
@@ -146,34 +411,51 @@ static inline void vext_set_elem_mask(void *v0, int index,
 }
 
 /* elements operations for load and store */
-typedef void vext_ldst_elem_fn(CPURISCVState *env, abi_ptr addr,
-                               uint32_t idx, void *vd, uintptr_t retaddr);
+typedef void vext_ldst_elem_fn_tlb(CPURISCVState *env, abi_ptr addr,
+                                   uint32_t idx, void *vd, uintptr_t retaddr);
+typedef void vext_ldst_elem_fn_host(void *vd, uint32_t idx, void *host);
 
-#define GEN_VEXT_LD_ELEM(NAME, ETYPE, H, LDSUF)            \
-static void NAME(CPURISCVState *env, abi_ptr addr,         \
-                 uint32_t idx, void *vd, uintptr_t retaddr)\
-{                                                          \
-    ETYPE *cur = ((ETYPE *)vd + H(idx));                   \
-    *cur = cpu_##LDSUF##_data_ra(env, addr, retaddr);      \
-}                                                          \
-
-GEN_VEXT_LD_ELEM(lde_b, int8_t,  H1, ldsb)
-GEN_VEXT_LD_ELEM(lde_h, int16_t, H2, ldsw)
-GEN_VEXT_LD_ELEM(lde_w, int32_t, H4, ldl)
-GEN_VEXT_LD_ELEM(lde_d, int64_t, H8, ldq)
-
-#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)            \
-static void NAME(CPURISCVState *env, abi_ptr addr,         \
-                 uint32_t idx, void *vd, uintptr_t retaddr)\
-{                                                          \
-    ETYPE data = *((ETYPE *)vd + H(idx));                  \
-    cpu_##STSUF##_data_ra(env, addr, data, retaddr);       \
+#define GEN_VEXT_LD_ELEM(NAME, ETYPE, H, LDSUF)                         \
+static void NAME##_tlb(CPURISCVState *env, abi_ptr addr,                \
+                       uint32_t byte_off, void *vd, uintptr_t retaddr)  \
+{                                                                       \
+    uint8_t *reg = ((uint8_t *)vd + byte_off);                          \
+    ETYPE *cur = ((ETYPE *)reg);                                        \
+    *cur = cpu_##LDSUF##_data_ra(env, addr, retaddr);                   \
+}                                                                       \
+                                                                        \
+static void NAME##_host(void *vd, uint32_t byte_off, void *host)        \
+{                                                                       \
+    ETYPE val = LDSUF##_p(host);                                        \
+    uint8_t *reg = (uint8_t *)(vd + byte_off);                          \
+    *(ETYPE *)(reg) = val;                                              \
+}
+
+GEN_VEXT_LD_ELEM(lde_b, uint8_t,  H1, ldub)
+GEN_VEXT_LD_ELEM(lde_h, uint16_t, H2, lduw)
+GEN_VEXT_LD_ELEM(lde_w, uint32_t, H4, ldl)
+GEN_VEXT_LD_ELEM(lde_d, uint64_t, H8, ldq)
+
+#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)                         \
+static void NAME##_tlb(CPURISCVState *env, abi_ptr addr,                \
+                       uint32_t byte_off, void *vd, uintptr_t retaddr)  \
+{                                                                       \
+    uint8_t *reg = ((uint8_t *)vd + byte_off);                          \
+    ETYPE data = *((ETYPE *)reg);                                       \
+    cpu_##STSUF##_data_ra(env, addr, data, retaddr);                    \
+}                                                                       \
+                                                                        \
+static void NAME##_host(void *vd, uint32_t byte_off, void *host)        \
+{                                                                       \
+    uint8_t *reg = ((uint8_t *)vd + byte_off);                          \
+    ETYPE val = *(ETYPE *)(reg);                                        \
+    STSUF##_p(host, val);                                               \
 }
 
-GEN_VEXT_ST_ELEM(ste_b, int8_t,  H1, stb)
-GEN_VEXT_ST_ELEM(ste_h, int16_t, H2, stw)
-GEN_VEXT_ST_ELEM(ste_w, int32_t, H4, stl)
-GEN_VEXT_ST_ELEM(ste_d, int64_t, H8, stq)
+GEN_VEXT_ST_ELEM(ste_b, uint8_t,  H1, stb)
+GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw)
+GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl)
+GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq)
 
 static void vext_set_tail_elems_1s(target_ulong vl, void *vd,
                                    uint32_t desc, uint32_t nf,
@@ -199,7 +481,7 @@ static void
 vext_ldst_stride(void *vd, void *v0, target_ulong base,
                  target_ulong stride, CPURISCVState *env,
                  uint32_t desc, uint32_t vm,
-                 vext_ldst_elem_fn *ldst_elem,
+                 vext_ldst_elem_fn_tlb *ldst_elem,
                  uint32_t log2_esz, uintptr_t ra)
 {
     uint32_t i, k;
@@ -221,7 +503,8 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
                 continue;
             }
             target_ulong addr = base + stride * i + (k << log2_esz);
-            ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
+            ldst_elem(env, adjust_addr(env, addr),
+                      (i + k * max_elems) << log2_esz, vd, ra);
             k++;
         }
     }
@@ -240,10 +523,10 @@ void HELPER(NAME)(void *vd, void * v0, target_ulong base,               \
                      ctzl(sizeof(ETYPE)), GETPC());                     \
 }
 
-GEN_VEXT_LD_STRIDE(vlse8_v,  int8_t,  lde_b)
-GEN_VEXT_LD_STRIDE(vlse16_v, int16_t, lde_h)
-GEN_VEXT_LD_STRIDE(vlse32_v, int32_t, lde_w)
-GEN_VEXT_LD_STRIDE(vlse64_v, int64_t, lde_d)
+GEN_VEXT_LD_STRIDE(vlse8_v,  int8_t,  lde_b_tlb)
+GEN_VEXT_LD_STRIDE(vlse16_v, int16_t, lde_h_tlb)
+GEN_VEXT_LD_STRIDE(vlse32_v, int32_t, lde_w_tlb)
+GEN_VEXT_LD_STRIDE(vlse64_v, int64_t, lde_d_tlb)
 
 #define GEN_VEXT_ST_STRIDE(NAME, ETYPE, STORE_FN)                       \
 void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
@@ -255,10 +538,10 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
                      ctzl(sizeof(ETYPE)), GETPC());                     \
 }
 
-GEN_VEXT_ST_STRIDE(vsse8_v,  int8_t,  ste_b)
-GEN_VEXT_ST_STRIDE(vsse16_v, int16_t, ste_h)
-GEN_VEXT_ST_STRIDE(vsse32_v, int32_t, ste_w)
-GEN_VEXT_ST_STRIDE(vsse64_v, int64_t, ste_d)
+GEN_VEXT_ST_STRIDE(vsse8_v,  int8_t,  ste_b_tlb)
+GEN_VEXT_ST_STRIDE(vsse16_v, int16_t, ste_h_tlb)
+GEN_VEXT_ST_STRIDE(vsse32_v, int32_t, ste_w_tlb)
+GEN_VEXT_ST_STRIDE(vsse64_v, int64_t, ste_d_tlb)
 
 /*
  * unit-stride: access elements stored contiguously in memory
@@ -267,9 +550,14 @@ GEN_VEXT_ST_STRIDE(vsse64_v, int64_t, ste_d)
 /* unmasked unit-stride load and store operation */
 static void
 vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
-             vext_ldst_elem_fn *ldst_elem, uint32_t log2_esz, uint32_t evl,
-             uintptr_t ra)
+             vext_ldst_elem_fn_tlb *ldst_tlb,
+             vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
+             uint32_t evl, uintptr_t ra, bool is_load)
 {
+    RVVContLdSt info;
+    void *host;
+    int flags;
+    intptr_t reg_start, reg_last;
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
@@ -277,17 +565,88 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 
     VSTART_CHECK_EARLY_EXIT(env);
 
-    /* load bytes from guest memory */
-    for (i = env->vstart; i < evl; env->vstart = ++i) {
+    vext_cont_ldst_elements(&info, base, env->vreg, env->vstart, evl, desc,
+                            log2_esz, false);
+    /* Probe the page(s).  Exit with exception for any invalid page. */
+    vext_cont_ldst_pages(env, &info, base, is_load, desc, esz, ra, false);
+    /* Handle watchpoints for all active elements. */
+    vext_cont_ldst_watchpoints(env, &info, env->vreg, base, esz, is_load, ra,
+                               desc);
+
+    /* Load bytes from guest memory */
+    flags = info.page[0].flags | info.page[1].flags;
+    if (unlikely(flags != 0)) {
+        /* At least one page includes MMIO. */
+        reg_start = info.reg_idx_first[0];
+        reg_last = info.reg_idx_last[1];
+        if (reg_last < 0) {
+            reg_last = info.reg_idx_split;
+            if (reg_last < 0) {
+                reg_last = info.reg_idx_last[0];
+            }
+        }
+        reg_last += 1;
+
+        for (i = reg_start; i < reg_last; ++i) {
+            k = 0;
+            while (k < nf) {
+                target_ulong addr = base + ((i * nf + k) << log2_esz);
+                ldst_tlb(env, adjust_addr(env, addr),
+                         (i + k * max_elems) << log2_esz, vd, ra);
+                k++;
+            }
+        }
+
+        env->vstart = 0;
+        vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
+        return;
+    }
+
+    /* The entire operation is in RAM, on valid pages. */
+    reg_start = info.reg_idx_first[0];
+    reg_last = info.reg_idx_last[0] + 1;
+    host = info.page[0].host;
+
+    for (i = reg_start; i < reg_last; ++i) {
         k = 0;
         while (k < nf) {
-            target_ulong addr = base + ((i * nf + k) << log2_esz);
-            ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
+            ldst_host(vd, (i + k * max_elems) << log2_esz,
+                      host + ((i * nf + k) << log2_esz));
             k++;
         }
     }
-    env->vstart = 0;
 
+    /*
+     * Use the slow path to manage the cross-page misalignment.
+     * But we know this is RAM and cannot trap.
+     */
+    if (unlikely(info.mem_off_split >= 0)) {
+        reg_start = info.reg_idx_split;
+        k = 0;
+        while (k < nf) {
+            target_ulong addr = base + ((reg_start * nf + k) << log2_esz);
+            ldst_tlb(env, adjust_addr(env, addr),
+                     (reg_start + k * max_elems) << log2_esz, vd, ra);
+            k++;
+        }
+    }
+
+    if (unlikely(info.mem_off_first[1] >= 0)) {
+        reg_start = info.reg_idx_first[1];
+        reg_last = info.reg_idx_last[1] + 1;
+        host = info.page[1].host;
+
+        for (i = reg_start; i < reg_last; ++i) {
+            k = 0;
+            while (k < nf) {
+                ldst_host(vd, (i + k * max_elems) << log2_esz,
+                          host + ((i * nf + k) << log2_esz));
+                k++;
+            }
+        }
+    }
+
+    env->vstart = 0;
     vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
 }
 
@@ -296,47 +655,47 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
  * stride, stride = NF * sizeof (ETYPE)
  */
 
-#define GEN_VEXT_LD_US(NAME, ETYPE, LOAD_FN)                            \
-void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,         \
-                         CPURISCVState *env, uint32_t desc)             \
-{                                                                       \
-    uint32_t stride = vext_nf(desc) << ctzl(sizeof(ETYPE));             \
-    vext_ldst_stride(vd, v0, base, stride, env, desc, false, LOAD_FN,   \
-                     ctzl(sizeof(ETYPE)), GETPC());                     \
-}                                                                       \
-                                                                        \
-void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
-                  CPURISCVState *env, uint32_t desc)                    \
-{                                                                       \
-    vext_ldst_us(vd, base, env, desc, LOAD_FN,                          \
-                 ctzl(sizeof(ETYPE)), env->vl, GETPC());                \
+#define GEN_VEXT_LD_US(NAME, ETYPE, LOAD_FN_TLB, LOAD_FN_HOST)      \
+void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,     \
+                         CPURISCVState *env, uint32_t desc)         \
+{                                                                   \
+    uint32_t stride = vext_nf(desc) << ctzl(sizeof(ETYPE));         \
+    vext_ldst_stride(vd, v0, base, stride, env, desc, false,        \
+                     LOAD_FN_TLB, ctzl(sizeof(ETYPE)), GETPC());    \
+}                                                                   \
+                                                                    \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,            \
+                  CPURISCVState *env, uint32_t desc)                \
+{                                                                   \
+    vext_ldst_us(vd, base, env, desc, LOAD_FN_TLB, LOAD_FN_HOST,    \
+                 ctzl(sizeof(ETYPE)), env->vl, GETPC(), true);      \
 }
 
-GEN_VEXT_LD_US(vle8_v,  int8_t,  lde_b)
-GEN_VEXT_LD_US(vle16_v, int16_t, lde_h)
-GEN_VEXT_LD_US(vle32_v, int32_t, lde_w)
-GEN_VEXT_LD_US(vle64_v, int64_t, lde_d)
+GEN_VEXT_LD_US(vle8_v,  int8_t,  lde_b_tlb, lde_b_host)
+GEN_VEXT_LD_US(vle16_v, int16_t, lde_h_tlb, lde_h_host)
+GEN_VEXT_LD_US(vle32_v, int32_t, lde_w_tlb, lde_w_host)
+GEN_VEXT_LD_US(vle64_v, int64_t, lde_d_tlb, lde_d_host)
 
-#define GEN_VEXT_ST_US(NAME, ETYPE, STORE_FN)                            \
+#define GEN_VEXT_ST_US(NAME, ETYPE, STORE_FN_TLB, STORE_FN_HOST)         \
 void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,          \
                          CPURISCVState *env, uint32_t desc)              \
 {                                                                        \
     uint32_t stride = vext_nf(desc) << ctzl(sizeof(ETYPE));              \
-    vext_ldst_stride(vd, v0, base, stride, env, desc, false, STORE_FN,   \
-                     ctzl(sizeof(ETYPE)), GETPC());                      \
+    vext_ldst_stride(vd, v0, base, stride, env, desc, false,             \
+                     STORE_FN_TLB, ctzl(sizeof(ETYPE)), GETPC());        \
 }                                                                        \
                                                                          \
 void HELPER(NAME)(void *vd, void *v0, target_ulong base,                 \
                   CPURISCVState *env, uint32_t desc)                     \
 {                                                                        \
-    vext_ldst_us(vd, base, env, desc, STORE_FN,                          \
-                 ctzl(sizeof(ETYPE)), env->vl, GETPC());                 \
+    vext_ldst_us(vd, base, env, desc, STORE_FN_TLB, STORE_FN_HOST,       \
+                 ctzl(sizeof(ETYPE)), env->vl, GETPC(), false);          \
 }
 
-GEN_VEXT_ST_US(vse8_v,  int8_t,  ste_b)
-GEN_VEXT_ST_US(vse16_v, int16_t, ste_h)
-GEN_VEXT_ST_US(vse32_v, int32_t, ste_w)
-GEN_VEXT_ST_US(vse64_v, int64_t, ste_d)
+GEN_VEXT_ST_US(vse8_v,  int8_t,  ste_b_tlb, ste_b_host)
+GEN_VEXT_ST_US(vse16_v, int16_t, ste_h_tlb, ste_h_host)
+GEN_VEXT_ST_US(vse32_v, int32_t, ste_w_tlb, ste_w_host)
+GEN_VEXT_ST_US(vse64_v, int64_t, ste_d_tlb, ste_d_host)
 
 /*
  * unit stride mask load and store, EEW = 1
@@ -346,8 +705,8 @@ void HELPER(vlm_v)(void *vd, void *v0, target_ulong base,
 {
     /* evl = ceil(vl/8) */
     uint8_t evl = (env->vl + 7) >> 3;
-    vext_ldst_us(vd, base, env, desc, lde_b,
-                 0, evl, GETPC());
+    vext_ldst_us(vd, base, env, desc, lde_b_tlb, lde_b_host,
+                 0, evl, GETPC(), true);
 }
 
 void HELPER(vsm_v)(void *vd, void *v0, target_ulong base,
@@ -355,8 +714,8 @@ void HELPER(vsm_v)(void *vd, void *v0, target_ulong base,
 {
     /* evl = ceil(vl/8) */
     uint8_t evl = (env->vl + 7) >> 3;
-    vext_ldst_us(vd, base, env, desc, ste_b,
-                 0, evl, GETPC());
+    vext_ldst_us(vd, base, env, desc, ste_b_tlb, ste_b_host,
+                 0, evl, GETPC(), false);
 }
 
 /*
@@ -381,7 +740,7 @@ static inline void
 vext_ldst_index(void *vd, void *v0, target_ulong base,
                 void *vs2, CPURISCVState *env, uint32_t desc,
                 vext_get_index_addr get_index_addr,
-                vext_ldst_elem_fn *ldst_elem,
+                vext_ldst_elem_fn_tlb *ldst_elem,
                 uint32_t log2_esz, uintptr_t ra)
 {
     uint32_t i, k;
@@ -405,7 +764,8 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
                 continue;
             }
             abi_ptr addr = get_index_addr(base, i, vs2) + (k << log2_esz);
-            ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
+            ldst_elem(env, adjust_addr(env, addr),
+                      (i + k * max_elems) << log2_esz, vd, ra);
             k++;
         }
     }
@@ -422,22 +782,22 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,                   \
                     LOAD_FN, ctzl(sizeof(ETYPE)), GETPC());                \
 }
 
-GEN_VEXT_LD_INDEX(vlxei8_8_v,   int8_t,  idx_b, lde_b)
-GEN_VEXT_LD_INDEX(vlxei8_16_v,  int16_t, idx_b, lde_h)
-GEN_VEXT_LD_INDEX(vlxei8_32_v,  int32_t, idx_b, lde_w)
-GEN_VEXT_LD_INDEX(vlxei8_64_v,  int64_t, idx_b, lde_d)
-GEN_VEXT_LD_INDEX(vlxei16_8_v,  int8_t,  idx_h, lde_b)
-GEN_VEXT_LD_INDEX(vlxei16_16_v, int16_t, idx_h, lde_h)
-GEN_VEXT_LD_INDEX(vlxei16_32_v, int32_t, idx_h, lde_w)
-GEN_VEXT_LD_INDEX(vlxei16_64_v, int64_t, idx_h, lde_d)
-GEN_VEXT_LD_INDEX(vlxei32_8_v,  int8_t,  idx_w, lde_b)
-GEN_VEXT_LD_INDEX(vlxei32_16_v, int16_t, idx_w, lde_h)
-GEN_VEXT_LD_INDEX(vlxei32_32_v, int32_t, idx_w, lde_w)
-GEN_VEXT_LD_INDEX(vlxei32_64_v, int64_t, idx_w, lde_d)
-GEN_VEXT_LD_INDEX(vlxei64_8_v,  int8_t,  idx_d, lde_b)
-GEN_VEXT_LD_INDEX(vlxei64_16_v, int16_t, idx_d, lde_h)
-GEN_VEXT_LD_INDEX(vlxei64_32_v, int32_t, idx_d, lde_w)
-GEN_VEXT_LD_INDEX(vlxei64_64_v, int64_t, idx_d, lde_d)
+GEN_VEXT_LD_INDEX(vlxei8_8_v,   int8_t,  idx_b, lde_b_tlb)
+GEN_VEXT_LD_INDEX(vlxei8_16_v,  int16_t, idx_b, lde_h_tlb)
+GEN_VEXT_LD_INDEX(vlxei8_32_v,  int32_t, idx_b, lde_w_tlb)
+GEN_VEXT_LD_INDEX(vlxei8_64_v,  int64_t, idx_b, lde_d_tlb)
+GEN_VEXT_LD_INDEX(vlxei16_8_v,  int8_t,  idx_h, lde_b_tlb)
+GEN_VEXT_LD_INDEX(vlxei16_16_v, int16_t, idx_h, lde_h_tlb)
+GEN_VEXT_LD_INDEX(vlxei16_32_v, int32_t, idx_h, lde_w_tlb)
+GEN_VEXT_LD_INDEX(vlxei16_64_v, int64_t, idx_h, lde_d_tlb)
+GEN_VEXT_LD_INDEX(vlxei32_8_v,  int8_t,  idx_w, lde_b_tlb)
+GEN_VEXT_LD_INDEX(vlxei32_16_v, int16_t, idx_w, lde_h_tlb)
+GEN_VEXT_LD_INDEX(vlxei32_32_v, int32_t, idx_w, lde_w_tlb)
+GEN_VEXT_LD_INDEX(vlxei32_64_v, int64_t, idx_w, lde_d_tlb)
+GEN_VEXT_LD_INDEX(vlxei64_8_v,  int8_t,  idx_d, lde_b_tlb)
+GEN_VEXT_LD_INDEX(vlxei64_16_v, int16_t, idx_d, lde_h_tlb)
+GEN_VEXT_LD_INDEX(vlxei64_32_v, int32_t, idx_d, lde_w_tlb)
+GEN_VEXT_LD_INDEX(vlxei64_64_v, int64_t, idx_d, lde_d_tlb)
 
 #define GEN_VEXT_ST_INDEX(NAME, ETYPE, INDEX_FN, STORE_FN)       \
 void HELPER(NAME)(void *vd, void *v0, target_ulong base,         \
@@ -448,22 +808,22 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,         \
                     GETPC());                                    \
 }
 
-GEN_VEXT_ST_INDEX(vsxei8_8_v,   int8_t,  idx_b, ste_b)
-GEN_VEXT_ST_INDEX(vsxei8_16_v,  int16_t, idx_b, ste_h)
-GEN_VEXT_ST_INDEX(vsxei8_32_v,  int32_t, idx_b, ste_w)
-GEN_VEXT_ST_INDEX(vsxei8_64_v,  int64_t, idx_b, ste_d)
-GEN_VEXT_ST_INDEX(vsxei16_8_v,  int8_t,  idx_h, ste_b)
-GEN_VEXT_ST_INDEX(vsxei16_16_v, int16_t, idx_h, ste_h)
-GEN_VEXT_ST_INDEX(vsxei16_32_v, int32_t, idx_h, ste_w)
-GEN_VEXT_ST_INDEX(vsxei16_64_v, int64_t, idx_h, ste_d)
-GEN_VEXT_ST_INDEX(vsxei32_8_v,  int8_t,  idx_w, ste_b)
-GEN_VEXT_ST_INDEX(vsxei32_16_v, int16_t, idx_w, ste_h)
-GEN_VEXT_ST_INDEX(vsxei32_32_v, int32_t, idx_w, ste_w)
-GEN_VEXT_ST_INDEX(vsxei32_64_v, int64_t, idx_w, ste_d)
-GEN_VEXT_ST_INDEX(vsxei64_8_v,  int8_t,  idx_d, ste_b)
-GEN_VEXT_ST_INDEX(vsxei64_16_v, int16_t, idx_d, ste_h)
-GEN_VEXT_ST_INDEX(vsxei64_32_v, int32_t, idx_d, ste_w)
-GEN_VEXT_ST_INDEX(vsxei64_64_v, int64_t, idx_d, ste_d)
+GEN_VEXT_ST_INDEX(vsxei8_8_v,   int8_t,  idx_b, ste_b_tlb)
+GEN_VEXT_ST_INDEX(vsxei8_16_v,  int16_t, idx_b, ste_h_tlb)
+GEN_VEXT_ST_INDEX(vsxei8_32_v,  int32_t, idx_b, ste_w_tlb)
+GEN_VEXT_ST_INDEX(vsxei8_64_v,  int64_t, idx_b, ste_d_tlb)
+GEN_VEXT_ST_INDEX(vsxei16_8_v,  int8_t,  idx_h, ste_b_tlb)
+GEN_VEXT_ST_INDEX(vsxei16_16_v, int16_t, idx_h, ste_h_tlb)
+GEN_VEXT_ST_INDEX(vsxei16_32_v, int32_t, idx_h, ste_w_tlb)
+GEN_VEXT_ST_INDEX(vsxei16_64_v, int64_t, idx_h, ste_d_tlb)
+GEN_VEXT_ST_INDEX(vsxei32_8_v,  int8_t,  idx_w, ste_b_tlb)
+GEN_VEXT_ST_INDEX(vsxei32_16_v, int16_t, idx_w, ste_h_tlb)
+GEN_VEXT_ST_INDEX(vsxei32_32_v, int32_t, idx_w, ste_w_tlb)
+GEN_VEXT_ST_INDEX(vsxei32_64_v, int64_t, idx_w, ste_d_tlb)
+GEN_VEXT_ST_INDEX(vsxei64_8_v,  int8_t,  idx_d, ste_b_tlb)
+GEN_VEXT_ST_INDEX(vsxei64_16_v, int16_t, idx_d, ste_h_tlb)
+GEN_VEXT_ST_INDEX(vsxei64_32_v, int32_t, idx_d, ste_w_tlb)
+GEN_VEXT_ST_INDEX(vsxei64_64_v, int64_t, idx_d, ste_d_tlb)
 
 /*
  * unit-stride fault-only-fisrt load instructions
@@ -471,7 +831,7 @@ GEN_VEXT_ST_INDEX(vsxei64_64_v, int64_t, idx_d, ste_d)
 static inline void
 vext_ldff(void *vd, void *v0, target_ulong base,
           CPURISCVState *env, uint32_t desc,
-          vext_ldst_elem_fn *ldst_elem,
+          vext_ldst_elem_fn_tlb *ldst_elem,
           uint32_t log2_esz, uintptr_t ra)
 {
     void *host;
@@ -537,7 +897,8 @@ ProbeSuccess:
                 continue;
             }
             addr = base + ((i * nf + k) << log2_esz);
-            ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
+            ldst_elem(env, adjust_addr(env, addr),
+                      (i + k * max_elems) << log2_esz, vd, ra);
             k++;
         }
     }
@@ -554,10 +915,10 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,  \
               ctzl(sizeof(ETYPE)), GETPC());              \
 }
 
-GEN_VEXT_LDFF(vle8ff_v,  int8_t,  lde_b)
-GEN_VEXT_LDFF(vle16ff_v, int16_t, lde_h)
-GEN_VEXT_LDFF(vle32ff_v, int32_t, lde_w)
-GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d)
+GEN_VEXT_LDFF(vle8ff_v,  int8_t,  lde_b_tlb)
+GEN_VEXT_LDFF(vle16ff_v, int16_t, lde_h_tlb)
+GEN_VEXT_LDFF(vle32ff_v, int32_t, lde_w_tlb)
+GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d_tlb)
 
 #define DO_SWAP(N, M) (M)
 #define DO_AND(N, M)  (N & M)
@@ -574,7 +935,8 @@ GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d)
  */
 static void
 vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
-                vext_ldst_elem_fn *ldst_elem, uint32_t log2_esz, uintptr_t ra)
+                vext_ldst_elem_fn_tlb *ldst_elem, uint32_t log2_esz,
+                uintptr_t ra)
 {
     uint32_t i, k, off, pos;
     uint32_t nf = vext_nf(desc);
@@ -593,8 +955,8 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
         /* load/store rest of elements of current segment pointed by vstart */
         for (pos = off; pos < max_elems; pos++, env->vstart++) {
             target_ulong addr = base + ((pos + k * max_elems) << log2_esz);
-            ldst_elem(env, adjust_addr(env, addr), pos + k * max_elems, vd,
-                      ra);
+            ldst_elem(env, adjust_addr(env, addr),
+                      (pos + k * max_elems) << log2_esz, vd, ra);
         }
         k++;
     }
@@ -603,7 +965,8 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     for (; k < nf; k++) {
         for (i = 0; i < max_elems; i++, env->vstart++) {
             target_ulong addr = base + ((i + k * max_elems) << log2_esz);
-            ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
+            ldst_elem(env, adjust_addr(env, addr),
+                      (i + k * max_elems) << log2_esz, vd, ra);
         }
     }
 
@@ -618,22 +981,22 @@ void HELPER(NAME)(void *vd, target_ulong base,       \
                     ctzl(sizeof(ETYPE)), GETPC());   \
 }
 
-GEN_VEXT_LD_WHOLE(vl1re8_v,  int8_t,  lde_b)
-GEN_VEXT_LD_WHOLE(vl1re16_v, int16_t, lde_h)
-GEN_VEXT_LD_WHOLE(vl1re32_v, int32_t, lde_w)
-GEN_VEXT_LD_WHOLE(vl1re64_v, int64_t, lde_d)
-GEN_VEXT_LD_WHOLE(vl2re8_v,  int8_t,  lde_b)
-GEN_VEXT_LD_WHOLE(vl2re16_v, int16_t, lde_h)
-GEN_VEXT_LD_WHOLE(vl2re32_v, int32_t, lde_w)
-GEN_VEXT_LD_WHOLE(vl2re64_v, int64_t, lde_d)
-GEN_VEXT_LD_WHOLE(vl4re8_v,  int8_t,  lde_b)
-GEN_VEXT_LD_WHOLE(vl4re16_v, int16_t, lde_h)
-GEN_VEXT_LD_WHOLE(vl4re32_v, int32_t, lde_w)
-GEN_VEXT_LD_WHOLE(vl4re64_v, int64_t, lde_d)
-GEN_VEXT_LD_WHOLE(vl8re8_v,  int8_t,  lde_b)
-GEN_VEXT_LD_WHOLE(vl8re16_v, int16_t, lde_h)
-GEN_VEXT_LD_WHOLE(vl8re32_v, int32_t, lde_w)
-GEN_VEXT_LD_WHOLE(vl8re64_v, int64_t, lde_d)
+GEN_VEXT_LD_WHOLE(vl1re8_v,  int8_t,  lde_b_tlb)
+GEN_VEXT_LD_WHOLE(vl1re16_v, int16_t, lde_h_tlb)
+GEN_VEXT_LD_WHOLE(vl1re32_v, int32_t, lde_w_tlb)
+GEN_VEXT_LD_WHOLE(vl1re64_v, int64_t, lde_d_tlb)
+GEN_VEXT_LD_WHOLE(vl2re8_v,  int8_t,  lde_b_tlb)
+GEN_VEXT_LD_WHOLE(vl2re16_v, int16_t, lde_h_tlb)
+GEN_VEXT_LD_WHOLE(vl2re32_v, int32_t, lde_w_tlb)
+GEN_VEXT_LD_WHOLE(vl2re64_v, int64_t, lde_d_tlb)
+GEN_VEXT_LD_WHOLE(vl4re8_v,  int8_t,  lde_b_tlb)
+GEN_VEXT_LD_WHOLE(vl4re16_v, int16_t, lde_h_tlb)
+GEN_VEXT_LD_WHOLE(vl4re32_v, int32_t, lde_w_tlb)
+GEN_VEXT_LD_WHOLE(vl4re64_v, int64_t, lde_d_tlb)
+GEN_VEXT_LD_WHOLE(vl8re8_v,  int8_t,  lde_b_tlb)
+GEN_VEXT_LD_WHOLE(vl8re16_v, int16_t, lde_h_tlb)
+GEN_VEXT_LD_WHOLE(vl8re32_v, int32_t, lde_w_tlb)
+GEN_VEXT_LD_WHOLE(vl8re64_v, int64_t, lde_d_tlb)
 
 #define GEN_VEXT_ST_WHOLE(NAME, ETYPE, STORE_FN)     \
 void HELPER(NAME)(void *vd, target_ulong base,       \
@@ -643,10 +1006,10 @@ void HELPER(NAME)(void *vd, target_ulong base,       \
                     ctzl(sizeof(ETYPE)), GETPC());   \
 }
 
-GEN_VEXT_ST_WHOLE(vs1r_v, int8_t, ste_b)
-GEN_VEXT_ST_WHOLE(vs2r_v, int8_t, ste_b)
-GEN_VEXT_ST_WHOLE(vs4r_v, int8_t, ste_b)
-GEN_VEXT_ST_WHOLE(vs8r_v, int8_t, ste_b)
+GEN_VEXT_ST_WHOLE(vs1r_v, int8_t, ste_b_tlb)
+GEN_VEXT_ST_WHOLE(vs2r_v, int8_t, ste_b_tlb)
+GEN_VEXT_ST_WHOLE(vs4r_v, int8_t, ste_b_tlb)
+GEN_VEXT_ST_WHOLE(vs8r_v, int8_t, ste_b_tlb)
 
 /*
  * Vector Integer Arithmetic Instructions
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 9e1e15b5750..f59d7d5c19f 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -233,4 +233,52 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
 #define WOP_UUU_H uint32_t, uint16_t, uint16_t, uint32_t, uint32_t
 #define WOP_UUU_W uint64_t, uint32_t, uint32_t, uint64_t, uint64_t
 
+typedef struct {
+    void *host;
+    int flags;
+    MemTxAttrs attrs;
+} RVVHostPage;
+
+typedef struct {
+    /*
+     * First and last element wholly contained within the two pages.
+     * mem_off_first[0] and reg_idx_first[0] are always set >= 0.
+     * reg_idx_last[0] may be < 0 if the first element crosses pages.
+     * All of mem_off_first[1], reg_idx_first[1] and reg_idx_last[1]
+     * are set >= 0 only if there are complete elements on a second page.
+     */
+    int16_t mem_off_first[2];
+    int16_t reg_idx_first[2];
+    int16_t reg_idx_last[2];
+
+    /*
+     * One element that is misaligned and spans both pages,
+     * or -1 if there is no such active element.
+     */
+    int16_t mem_off_split;
+    int16_t reg_idx_split;
+
+    /*
+     * The byte offset at which the entire operation crosses a page boundary.
+     * Set >= 0 if and only if the entire operation spans two pages.
+     */
+    int16_t page_split;
+
+    /* TLB data for the two pages. */
+    RVVHostPage page[2];
+} RVVContLdSt;
+
+#ifdef CONFIG_USER_ONLY
+static inline void
+vext_cont_ldst_watchpoints(CPURISCVState *env, RVVContLdSt *info, uint64_t *v0,
+                           target_ulong addr, uint32_t log2_esz, bool is_load,
+                           uintptr_t ra, uint32_t desc)
+{}
+#else
+void vext_cont_ldst_watchpoints(CPURISCVState *env, RVVContLdSt *info,
+                                uint64_t *v0, target_ulong addr,
+                                uint32_t log2_esz, bool is_load, uintptr_t ra,
+                                uint32_t desc);
+#endif
+
 #endif /* TARGET_RISCV_VECTOR_INTERNALS_H */
-- 
2.34.1


