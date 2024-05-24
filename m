Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8876EC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 17:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAYPF-0008De-Iu; Fri, 24 May 2024 13:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sAYPD-0008Au-Pp
 for qemu-devel@nongnu.org; Fri, 24 May 2024 13:08:35 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sAYP0-0007ZJ-9M
 for qemu-devel@nongnu.org; Fri, 24 May 2024 13:08:34 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5b970e90ab8so545702eaf.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 10:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1716570500; x=1717175300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZ8Olop5o69sFhCXF1Pjbx8bqbvvoRclKjZlHZw/Olk=;
 b=Nofx2K8eVtVzcMPdZKlblefuEWoHwpxljcm7mQdHjRbSwDlN2hzUZbj0QdSvK5Rqf+
 54PAybrbQ0FBKnDJTQ6eyrMupTggAZRyuQS6nRUpUL5LPjlxtjFzAX9+ntwtEmfXFxv2
 qkfYpVvlKhV5eq051WnJQ8AEuZGUGHAureG9kHKQLZZb6J3Xsoql8nhVMCmWAjsxXcjd
 MZ1vn8cX4L8gcidyZGQvc8wSjXHAD0S6cYbjL02B5rKmVmS00evWgXqvBaHM1v6uua7r
 XeIkzgvFaPQLpjN/ffp1bUFsAsjAhAzS5jkteXWKWT5bhp85/dyRtVD0migMwZ0QkmZu
 xLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716570500; x=1717175300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZ8Olop5o69sFhCXF1Pjbx8bqbvvoRclKjZlHZw/Olk=;
 b=AXSKn083DrY4HTi+zd3kjNM2oz0cJQzcNCtR3XHul2FBtR5ER1pD3U+H/+B7k2uCay
 mMbidHZUpU/sY9nhsDCKwQUZAkAshSXPM4YMRYi37OFqVxRqezAjQ5ngMRwOu3Id9mA7
 jEdG9r58mBbaG2yR2l/gY6/rP+94EsdvogYM8NhsC8uV6TFOOfs5t54KwUBhJdf2butZ
 uisIczCzRGbC5CVc/Fhedg3w4pgKvMzVQgvzDuBHThWKRYVsnflmUI//2aZh1x3n6zfe
 Zt8LYayrG/30eDLZdr/TQFgRw9IjrG+UjyckFt+QHYI8IQUKYgdEDfBYsvUSjPaI3B1A
 ro6g==
X-Gm-Message-State: AOJu0YzjUXuSE7oZgpOjwYlbuQvetL82pCajNSZx5CMJiZ5rPD5lCkS3
 0jiyUszzMbGkYiAIX+5q6xkfnp3hQYv9wLjB2vamKJrg67HQ/Mbu79tAHS03qoy496U917envBY
 i9NcHErXekeAo4lkZ66FwE2s73amiOBKONld8fmnJSCHMkVoW8RlsCkVBgjyTTuLj4foxjXTDxj
 yAawNMajt27c/7Sp6AydYxYAyLW2pt
X-Google-Smtp-Source: AGHT+IFpZbYWaGtT8DCg7Sxrq7kn4BgI01hLZGnadnHCOMddJqfq4RD1tOyGvmh5PLIOOaR40kxV0A==
X-Received: by 2002:a05:6359:684:b0:17f:7206:fd81 with SMTP id
 e5c5f4694b2df-197e545496bmr341488055d.20.1716570499125; 
 Fri, 24 May 2024 10:08:19 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc0f0fsm79816585a.38.2024.05.24.10.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 10:08:18 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org, Don Porter <porter@cs.unc.edu>
Subject: [PATCH v2 5/6] Move tcg implementation of x86 get_physical_address
 into common helper code.
Date: Fri, 24 May 2024 13:07:47 -0400
Message-Id: <20240524170748.1842030-6-porter@cs.unc.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524170748.1842030-1-porter@cs.unc.edu>
References: <ZiKkWCjreGOMFX5p@gallifrey>
 <20240524170748.1842030-1-porter@cs.unc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=porter@cs.unc.edu; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 target/i386/cpu.h                    |  41 ++
 target/i386/helper.c                 | 515 +++++++++++++++++++++++++
 target/i386/tcg/sysemu/excp_helper.c | 555 +--------------------------
 3 files changed, 561 insertions(+), 550 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index fc3ae55213..39ce49e61f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2094,6 +2094,42 @@ struct X86CPUClass {
     ResettablePhases parent_phases;
 };
 
+typedef struct X86TranslateParams {
+    target_ulong addr;
+    target_ulong cr3;
+    int pg_mode;
+    int mmu_idx;
+    int ptw_idx;
+    MMUAccessType access_type;
+} X86TranslateParams;
+
+typedef struct X86TranslateResult {
+    hwaddr paddr;
+    int prot;
+    int page_size;
+} X86TranslateResult;
+
+typedef enum X86TranslateFaultStage2 {
+    S2_NONE,
+    S2_GPA,
+    S2_GPT,
+} X86TranslateFaultStage2;
+
+typedef struct X86TranslateFault {
+    int exception_index;
+    int error_code;
+    target_ulong cr2;
+    X86TranslateFaultStage2 stage2;
+} X86TranslateFault;
+
+typedef struct X86PTETranslate {
+    CPUX86State *env;
+    X86TranslateFault *err;
+    int ptw_idx;
+    void *haddr;
+    hwaddr gaddr;
+} X86PTETranslate;
+
 /* Intended to become a generic PTE type */
 typedef union PTE {
     uint64_t pte64_t;
@@ -2137,6 +2173,11 @@ void x86_cpu_list(void);
 int cpu_x86_support_mca_broadcast(CPUX86State *env);
 
 #ifndef CONFIG_USER_ONLY
+bool x86_cpu_get_physical_address(CPUX86State *env, vaddr addr,
+                                  MMUAccessType access_type, int mmu_idx,
+                                  X86TranslateResult *out,
+                                  X86TranslateFault *err, uint64_t ra);
+
 hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
 int cpu_get_pic_interrupt(CPUX86State *s);
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 48d1513a35..21445e84b2 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -26,6 +26,7 @@
 #include "sysemu/hw_accel.h"
 #include "monitor/monitor.h"
 #include "kvm/kvm_i386.h"
+#include "exec/cpu_ldst.h"
 #endif
 #include "qemu/log.h"
 #ifdef CONFIG_TCG
@@ -227,6 +228,520 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
 }
 
 #if !defined(CONFIG_USER_ONLY)
+
+static inline uint32_t ptw_ldl(const X86PTETranslate *in, uint64_t ra)
+{
+    if (likely(in->haddr)) {
+        return ldl_p(in->haddr);
+    }
+    return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
+}
+
+static inline uint64_t ptw_ldq(const X86PTETranslate *in, uint64_t ra)
+{
+    if (likely(in->haddr)) {
+        return ldq_p(in->haddr);
+    }
+    return cpu_ldq_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
+}
+/*
+ * Note that we can use a 32-bit cmpxchg for all page table entries,
+ * even 64-bit ones, because PG_PRESENT_MASK, PG_ACCESSED_MASK and
+ * PG_DIRTY_MASK are all in the low 32 bits.
+ */
+static bool ptw_setl_slow(const X86PTETranslate *in, uint32_t old, uint32_t new)
+{
+    uint32_t cmp;
+
+    /* Does x86 really perform a rmw cycle on mmio for ptw? */
+    start_exclusive();
+    cmp = cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
+    if (cmp == old) {
+        cpu_stl_mmuidx_ra(in->env, in->gaddr, new, in->ptw_idx, 0);
+    }
+    end_exclusive();
+    return cmp == old;
+}
+
+static inline bool ptw_setl(const X86PTETranslate *in, uint32_t old,
+                            uint32_t set)
+{
+    if (set & ~old) {
+        uint32_t new = old | set;
+        if (likely(in->haddr)) {
+            old = cpu_to_le32(old);
+            new = cpu_to_le32(new);
+            return qatomic_cmpxchg((uint32_t *)in->haddr, old, new) == old;
+        }
+        return ptw_setl_slow(in, old, new);
+    }
+    return true;
+}
+
+
+static bool ptw_translate(X86PTETranslate *inout, hwaddr addr, uint64_t ra)
+{
+    CPUTLBEntryFull *full;
+    int flags;
+
+    inout->gaddr = addr;
+    flags = probe_access_full(inout->env, addr, 0, MMU_DATA_STORE,
+                              inout->ptw_idx, true, &inout->haddr, &full, ra);
+
+    if (unlikely(flags & TLB_INVALID_MASK)) {
+        X86TranslateFault *err = inout->err;
+
+        assert(inout->ptw_idx == MMU_NESTED_IDX);
+        *err = (X86TranslateFault){
+            .error_code = inout->env->error_code,
+            .cr2 = addr,
+            .stage2 = S2_GPT,
+        };
+        return false;
+    }
+    return true;
+}
+
+static bool x86_mmu_translate(CPUX86State *env, const X86TranslateParams *in,
+                              X86TranslateResult *out,
+                              X86TranslateFault *err, uint64_t ra)
+{
+    const target_ulong addr = in->addr;
+    const int pg_mode = in->pg_mode;
+    const bool is_user = is_mmu_index_user(in->mmu_idx);
+    const MMUAccessType access_type = in->access_type;
+    uint64_t ptep, pte, rsvd_mask;
+    X86PTETranslate pte_trans = {
+        .env = env,
+        .err = err,
+        .ptw_idx = in->ptw_idx,
+    };
+    hwaddr pte_addr, paddr;
+    uint32_t pkr;
+    int page_size;
+    int error_code;
+
+ restart_all:
+    rsvd_mask = ~MAKE_64BIT_MASK(0, env_archcpu(env)->phys_bits);
+    rsvd_mask &= PG_ADDRESS_MASK;
+    if (!(pg_mode & PG_MODE_NXE)) {
+        rsvd_mask |= PG_NX_MASK;
+    }
+
+    if (pg_mode & PG_MODE_PAE) {
+#ifdef TARGET_X86_64
+        if (pg_mode & PG_MODE_LMA) {
+            if (pg_mode & PG_MODE_LA57) {
+                /*
+                 * Page table level 5
+                 */
+                pte_addr = (in->cr3 & ~0xfff) + (((addr >> 48) & 0x1ff) << 3);
+                if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+                    return false;
+                }
+            restart_5:
+                pte = ptw_ldq(&pte_trans, ra);
+                if (!(pte & PG_PRESENT_MASK)) {
+                    goto do_fault;
+                }
+                if (pte & (rsvd_mask | PG_PSE_MASK)) {
+                    goto do_fault_rsvd;
+                }
+                if (!ptw_setl(&pte_trans, pte, PG_ACCESSED_MASK)) {
+                    goto restart_5;
+                }
+                ptep = pte ^ PG_NX_MASK;
+            } else {
+                pte = in->cr3;
+                ptep = PG_NX_MASK | PG_USER_MASK | PG_RW_MASK;
+            }
+
+            /*
+             * Page table level 4
+             */
+            pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 39) & 0x1ff) << 3);
+            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+                return false;
+            }
+        restart_4:
+            pte = ptw_ldq(&pte_trans, ra);
+            if (!(pte & PG_PRESENT_MASK)) {
+                goto do_fault;
+            }
+            if (pte & (rsvd_mask | PG_PSE_MASK)) {
+                goto do_fault_rsvd;
+            }
+            if (!ptw_setl(&pte_trans, pte, PG_ACCESSED_MASK)) {
+                goto restart_4;
+            }
+            ptep &= pte ^ PG_NX_MASK;
+
+            /*
+             * Page table level 3
+             */
+            pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 30) & 0x1ff) << 3);
+            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+                return false;
+            }
+        restart_3_lma:
+            pte = ptw_ldq(&pte_trans, ra);
+            if (!(pte & PG_PRESENT_MASK)) {
+                goto do_fault;
+            }
+            if (pte & rsvd_mask) {
+                goto do_fault_rsvd;
+            }
+            if (!ptw_setl(&pte_trans, pte, PG_ACCESSED_MASK)) {
+                goto restart_3_lma;
+            }
+            ptep &= pte ^ PG_NX_MASK;
+            if (pte & PG_PSE_MASK) {
+                /* 1 GB page */
+                page_size = 1024 * 1024 * 1024;
+                goto do_check_protect;
+            }
+        } else
+#endif
+        {
+            /*
+             * Page table level 3
+             */
+            pte_addr = (in->cr3 & 0xffffffe0ULL) + ((addr >> 27) & 0x18);
+            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+                return false;
+            }
+            rsvd_mask |= PG_HI_USER_MASK;
+        restart_3_nolma:
+            pte = ptw_ldq(&pte_trans, ra);
+            if (!(pte & PG_PRESENT_MASK)) {
+                goto do_fault;
+            }
+            if (pte & (rsvd_mask | PG_NX_MASK)) {
+                goto do_fault_rsvd;
+            }
+            if (!ptw_setl(&pte_trans, pte, PG_ACCESSED_MASK)) {
+                goto restart_3_nolma;
+            }
+            ptep = PG_NX_MASK | PG_USER_MASK | PG_RW_MASK;
+        }
+
+        /*
+         * Page table level 2
+         */
+        pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 21) & 0x1ff) << 3);
+        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+            return false;
+        }
+    restart_2_pae:
+        pte = ptw_ldq(&pte_trans, ra);
+        if (!(pte & PG_PRESENT_MASK)) {
+            goto do_fault;
+        }
+        if (pte & rsvd_mask) {
+            goto do_fault_rsvd;
+        }
+        if (pte & PG_PSE_MASK) {
+            /* 2 MB page */
+            page_size = 2048 * 1024;
+            ptep &= pte ^ PG_NX_MASK;
+            goto do_check_protect;
+        }
+        if (!ptw_setl(&pte_trans, pte, PG_ACCESSED_MASK)) {
+            goto restart_2_pae;
+        }
+        ptep &= pte ^ PG_NX_MASK;
+
+        /*
+         * Page table level 1
+         */
+        pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 12) & 0x1ff) << 3);
+        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+            return false;
+        }
+        pte = ptw_ldq(&pte_trans, ra);
+        if (!(pte & PG_PRESENT_MASK)) {
+            goto do_fault;
+        }
+        if (pte & rsvd_mask) {
+            goto do_fault_rsvd;
+        }
+        /* combine pde and pte nx, user and rw protections */
+        ptep &= pte ^ PG_NX_MASK;
+        page_size = 4096;
+    } else {
+        /*
+         * Page table level 2
+         */
+        pte_addr = (in->cr3 & 0xfffff000ULL) + ((addr >> 20) & 0xffc);
+        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+            return false;
+        }
+    restart_2_nopae:
+        pte = ptw_ldl(&pte_trans, ra);
+        if (!(pte & PG_PRESENT_MASK)) {
+            goto do_fault;
+        }
+        ptep = pte | PG_NX_MASK;
+
+        /* if PSE bit is set, then we use a 4MB page */
+        if ((pte & PG_PSE_MASK) && (pg_mode & PG_MODE_PSE)) {
+            page_size = 4096 * 1024;
+            /*
+             * Bits 20-13 provide bits 39-32 of the address, bit 21 is reserved.
+             * Leave bits 20-13 in place for setting accessed/dirty bits below.
+             */
+            pte = (uint32_t)pte | ((pte & 0x1fe000LL) << (32 - 13));
+            rsvd_mask = 0x200000;
+            goto do_check_protect_pse36;
+        }
+        if (!ptw_setl(&pte_trans, pte, PG_ACCESSED_MASK)) {
+            goto restart_2_nopae;
+        }
+
+        /*
+         * Page table level 1
+         */
+        pte_addr = (pte & ~0xfffu) + ((addr >> 10) & 0xffc);
+        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+            return false;
+        }
+        pte = ptw_ldl(&pte_trans, ra);
+        if (!(pte & PG_PRESENT_MASK)) {
+            goto do_fault;
+        }
+        /* combine pde and pte user and rw protections */
+        ptep &= pte | PG_NX_MASK;
+        page_size = 4096;
+        rsvd_mask = 0;
+    }
+
+do_check_protect:
+    rsvd_mask |= (page_size - 1) & PG_ADDRESS_MASK & ~PG_PSE_PAT_MASK;
+do_check_protect_pse36:
+    if (pte & rsvd_mask) {
+        goto do_fault_rsvd;
+    }
+    ptep ^= PG_NX_MASK;
+
+    /* can the page can be put in the TLB?  prot will tell us */
+    if (is_user && !(ptep & PG_USER_MASK)) {
+        goto do_fault_protect;
+    }
+
+    int prot = 0;
+    if (!is_mmu_index_smap(in->mmu_idx) || !(ptep & PG_USER_MASK)) {
+        prot |= PAGE_READ;
+        if ((ptep & PG_RW_MASK) || !(is_user || (pg_mode & PG_MODE_WP))) {
+            prot |= PAGE_WRITE;
+        }
+    }
+    if (!(ptep & PG_NX_MASK) &&
+        (is_user ||
+         !((pg_mode & PG_MODE_SMEP) && (ptep & PG_USER_MASK)))) {
+        prot |= PAGE_EXEC;
+    }
+
+    if (ptep & PG_USER_MASK) {
+        pkr = pg_mode & PG_MODE_PKE ? env->pkru : 0;
+    } else {
+        pkr = pg_mode & PG_MODE_PKS ? env->pkrs : 0;
+    }
+    if (pkr) {
+        uint32_t pk = (pte & PG_PKRU_MASK) >> PG_PKRU_BIT;
+        uint32_t pkr_ad = (pkr >> pk * 2) & 1;
+        uint32_t pkr_wd = (pkr >> pk * 2) & 2;
+        uint32_t pkr_prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+
+        if (pkr_ad) {
+            pkr_prot &= ~(PAGE_READ | PAGE_WRITE);
+        } else if (pkr_wd && (is_user || (pg_mode & PG_MODE_WP))) {
+            pkr_prot &= ~PAGE_WRITE;
+        }
+        if ((pkr_prot & (1 << access_type)) == 0) {
+            goto do_fault_pk_protect;
+        }
+        prot &= pkr_prot;
+    }
+
+    if ((prot & (1 << access_type)) == 0) {
+        goto do_fault_protect;
+    }
+
+    /* yes, it can! */
+    {
+        uint32_t set = PG_ACCESSED_MASK;
+        if (access_type == MMU_DATA_STORE) {
+            set |= PG_DIRTY_MASK;
+        } else if (!(pte & PG_DIRTY_MASK)) {
+            /*
+             * Only set write access if already dirty...
+             * otherwise wait for dirty access.
+             */
+            prot &= ~PAGE_WRITE;
+        }
+        if (!ptw_setl(&pte_trans, pte, set)) {
+            /*
+             * We can arrive here from any of 3 levels and 2 formats.
+             * The only safe thing is to restart the entire lookup.
+             */
+            goto restart_all;
+        }
+    }
+
+    /* merge offset within page */
+    paddr = (pte & PG_ADDRESS_MASK & ~(page_size - 1)) |
+        (addr & (page_size - 1));
+
+    /*
+     * Note that NPT is walked (for both paging structures and final guest
+     * addresses) using the address with the A20 bit set.
+     */
+    if (in->ptw_idx == MMU_NESTED_IDX) {
+        CPUTLBEntryFull *full;
+        int flags, nested_page_size;
+
+        flags = probe_access_full(env, paddr, 0, access_type,
+                                  MMU_NESTED_IDX, true,
+                                  &pte_trans.haddr, &full, 0);
+        if (unlikely(flags & TLB_INVALID_MASK)) {
+            *err = (X86TranslateFault){
+                .error_code = env->error_code,
+                .cr2 = paddr,
+                .stage2 = S2_GPA,
+            };
+            return false;
+        }
+
+        /* Merge stage1 & stage2 protection bits. */
+        prot &= full->prot;
+
+        /* Re-verify resulting protection. */
+        if ((prot & (1 << access_type)) == 0) {
+            goto do_fault_protect;
+        }
+
+        /* Merge stage1 & stage2 addresses to final physical address. */
+        nested_page_size = 1 << full->lg_page_size;
+        paddr = (full->phys_addr & ~(nested_page_size - 1))
+              | (paddr & (nested_page_size - 1));
+
+        /*
+         * Use the larger of stage1 & stage2 page sizes, so that
+         * invalidation works.
+         */
+        if (nested_page_size > page_size) {
+            page_size = nested_page_size;
+        }
+    }
+
+    out->paddr = paddr & x86_get_a20_mask(env);
+    out->prot = prot;
+    out->page_size = page_size;
+    return true;
+
+ do_fault_rsvd:
+    error_code = PG_ERROR_RSVD_MASK;
+    goto do_fault_cont;
+ do_fault_protect:
+    error_code = PG_ERROR_P_MASK;
+    goto do_fault_cont;
+ do_fault_pk_protect:
+    assert(access_type != MMU_INST_FETCH);
+    error_code = PG_ERROR_PK_MASK | PG_ERROR_P_MASK;
+    goto do_fault_cont;
+ do_fault:
+    error_code = 0;
+ do_fault_cont:
+    if (is_user) {
+        error_code |= PG_ERROR_U_MASK;
+    }
+    switch (access_type) {
+    case MMU_DATA_LOAD:
+        break;
+    case MMU_DATA_STORE:
+        error_code |= PG_ERROR_W_MASK;
+        break;
+    case MMU_INST_FETCH:
+        if (pg_mode & (PG_MODE_NXE | PG_MODE_SMEP)) {
+            error_code |= PG_ERROR_I_D_MASK;
+        }
+        break;
+    }
+    *err = (X86TranslateFault){
+        .exception_index = EXCP0E_PAGE,
+        .error_code = error_code,
+        .cr2 = addr,
+    };
+    return false;
+}
+
+bool x86_cpu_get_physical_address(CPUX86State *env, vaddr addr,
+                                  MMUAccessType access_type, int mmu_idx,
+                                  X86TranslateResult *out,
+                                  X86TranslateFault *err, uint64_t ra)
+{
+    X86TranslateParams in;
+    bool use_stage2 = env->hflags2 & HF2_NPT_MASK;
+
+    in.addr = addr;
+    in.access_type = access_type;
+
+    switch (mmu_idx) {
+    case MMU_PHYS_IDX:
+        break;
+
+    case MMU_NESTED_IDX:
+        if (likely(use_stage2)) {
+            in.cr3 = env->nested_cr3;
+            in.pg_mode = env->nested_pg_mode;
+            in.mmu_idx =
+                env->nested_pg_mode & PG_MODE_LMA ?
+                MMU_USER64_IDX : MMU_USER32_IDX;
+            in.ptw_idx = MMU_PHYS_IDX;
+
+            if (!x86_mmu_translate(env, &in, out, err, ra)) {
+                err->stage2 = S2_GPA;
+                return false;
+            }
+            return true;
+        }
+        break;
+
+    default:
+        if (is_mmu_index_32(mmu_idx)) {
+            addr = (uint32_t)addr;
+        }
+
+        if (likely(env->cr[0] & CR0_PG_MASK)) {
+            in.cr3 = env->cr[3];
+            in.mmu_idx = mmu_idx;
+            in.ptw_idx = use_stage2 ? MMU_NESTED_IDX : MMU_PHYS_IDX;
+            in.pg_mode = get_pg_mode(env);
+
+            if (in.pg_mode & PG_MODE_LMA) {
+                /* test virtual address sign extension */
+                int shift = in.pg_mode & PG_MODE_LA57 ? 56 : 47;
+                int64_t sext = (int64_t)addr >> shift;
+                if (sext != 0 && sext != -1) {
+                    *err = (X86TranslateFault){
+                        .exception_index = EXCP0D_GPF,
+                        .cr2 = addr,
+                    };
+                    return false;
+                }
+            }
+            return x86_mmu_translate(env, &in, out, err, ra);
+        }
+        break;
+    }
+
+    /* No translation needed. */
+    out->paddr = addr & x86_get_a20_mask(env);
+    out->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+    out->page_size = TARGET_PAGE_SIZE;
+    return true;
+}
+
 hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
                                          MemTxAttrs *attrs)
 {
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 8fb05b1f53..4c48e5a68b 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -24,487 +24,7 @@
 #include "exec/page-protection.h"
 #include "tcg/helper-tcg.h"
 
-typedef struct TranslateParams {
-    target_ulong addr;
-    target_ulong cr3;
-    int pg_mode;
-    int mmu_idx;
-    int ptw_idx;
-    MMUAccessType access_type;
-} TranslateParams;
-
-typedef struct TranslateResult {
-    hwaddr paddr;
-    int prot;
-    int page_size;
-} TranslateResult;
-
-typedef enum TranslateFaultStage2 {
-    S2_NONE,
-    S2_GPA,
-    S2_GPT,
-} TranslateFaultStage2;
-
-typedef struct TranslateFault {
-    int exception_index;
-    int error_code;
-    target_ulong cr2;
-    TranslateFaultStage2 stage2;
-} TranslateFault;
-
-typedef struct PTETranslate {
-    CPUX86State *env;
-    TranslateFault *err;
-    int ptw_idx;
-    void *haddr;
-    hwaddr gaddr;
-} PTETranslate;
-
-static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)
-{
-    CPUTLBEntryFull *full;
-    int flags;
-
-    inout->gaddr = addr;
-    flags = probe_access_full(inout->env, addr, 0, MMU_DATA_STORE,
-                              inout->ptw_idx, true, &inout->haddr, &full, ra);
-
-    if (unlikely(flags & TLB_INVALID_MASK)) {
-        TranslateFault *err = inout->err;
-
-        assert(inout->ptw_idx == MMU_NESTED_IDX);
-        *err = (TranslateFault){
-            .error_code = inout->env->error_code,
-            .cr2 = addr,
-            .stage2 = S2_GPT,
-        };
-        return false;
-    }
-    return true;
-}
-
-static inline uint32_t ptw_ldl(const PTETranslate *in, uint64_t ra)
-{
-    if (likely(in->haddr)) {
-        return ldl_p(in->haddr);
-    }
-    return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
-}
-
-static inline uint64_t ptw_ldq(const PTETranslate *in, uint64_t ra)
-{
-    if (likely(in->haddr)) {
-        return ldq_p(in->haddr);
-    }
-    return cpu_ldq_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
-}
-
-/*
- * Note that we can use a 32-bit cmpxchg for all page table entries,
- * even 64-bit ones, because PG_PRESENT_MASK, PG_ACCESSED_MASK and
- * PG_DIRTY_MASK are all in the low 32 bits.
- */
-static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
-{
-    uint32_t cmp;
-
-    /* Does x86 really perform a rmw cycle on mmio for ptw? */
-    start_exclusive();
-    cmp = cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
-    if (cmp == old) {
-        cpu_stl_mmuidx_ra(in->env, in->gaddr, new, in->ptw_idx, 0);
-    }
-    end_exclusive();
-    return cmp == old;
-}
-
-static inline bool ptw_setl(const PTETranslate *in, uint32_t old, uint32_t set)
-{
-    if (set & ~old) {
-        uint32_t new = old | set;
-        if (likely(in->haddr)) {
-            old = cpu_to_le32(old);
-            new = cpu_to_le32(new);
-            return qatomic_cmpxchg((uint32_t *)in->haddr, old, new) == old;
-        }
-        return ptw_setl_slow(in, old, new);
-    }
-    return true;
-}
-
-static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
-                          TranslateResult *out, TranslateFault *err,
-                          uint64_t ra)
-{
-    const target_ulong addr = in->addr;
-    const int pg_mode = in->pg_mode;
-    const bool is_user = is_mmu_index_user(in->mmu_idx);
-    const MMUAccessType access_type = in->access_type;
-    uint64_t ptep, pte, rsvd_mask;
-    PTETranslate pte_trans = {
-        .env = env,
-        .err = err,
-        .ptw_idx = in->ptw_idx,
-    };
-    hwaddr pte_addr, paddr;
-    uint32_t pkr;
-    int page_size;
-    int error_code;
-
- restart_all:
-    rsvd_mask = ~MAKE_64BIT_MASK(0, env_archcpu(env)->phys_bits);
-    rsvd_mask &= PG_ADDRESS_MASK;
-    if (!(pg_mode & PG_MODE_NXE)) {
-        rsvd_mask |= PG_NX_MASK;
-    }
-
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
-
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
-
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
-
-        /*
-         * Page table level 2
-         */
-        pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 21) & 0x1ff) << 3);
-        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
-            return false;
-        }
-    restart_2_pae:
-        pte = ptw_ldq(&pte_trans, ra);
-        if (!(pte & PG_PRESENT_MASK)) {
-            goto do_fault;
-        }
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
-
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
-        }
-        if (pte & rsvd_mask) {
-            goto do_fault_rsvd;
-        }
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
-
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
-
-        /*
-         * Page table level 1
-         */
-        pte_addr = (pte & ~0xfffu) + ((addr >> 10) & 0xffc);
-        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
-            return false;
-        }
-        pte = ptw_ldl(&pte_trans, ra);
-        if (!(pte & PG_PRESENT_MASK)) {
-            goto do_fault;
-        }
-        /* combine pde and pte user and rw protections */
-        ptep &= pte | PG_NX_MASK;
-        page_size = 4096;
-        rsvd_mask = 0;
-    }
-
-do_check_protect:
-    rsvd_mask |= (page_size - 1) & PG_ADDRESS_MASK & ~PG_PSE_PAT_MASK;
-do_check_protect_pse36:
-    if (pte & rsvd_mask) {
-        goto do_fault_rsvd;
-    }
-    ptep ^= PG_NX_MASK;
-
-    /* can the page can be put in the TLB?  prot will tell us */
-    if (is_user && !(ptep & PG_USER_MASK)) {
-        goto do_fault_protect;
-    }
-
-    int prot = 0;
-    if (!is_mmu_index_smap(in->mmu_idx) || !(ptep & PG_USER_MASK)) {
-        prot |= PAGE_READ;
-        if ((ptep & PG_RW_MASK) || !(is_user || (pg_mode & PG_MODE_WP))) {
-            prot |= PAGE_WRITE;
-        }
-    }
-    if (!(ptep & PG_NX_MASK) &&
-        (is_user ||
-         !((pg_mode & PG_MODE_SMEP) && (ptep & PG_USER_MASK)))) {
-        prot |= PAGE_EXEC;
-    }
-
-    if (ptep & PG_USER_MASK) {
-        pkr = pg_mode & PG_MODE_PKE ? env->pkru : 0;
-    } else {
-        pkr = pg_mode & PG_MODE_PKS ? env->pkrs : 0;
-    }
-    if (pkr) {
-        uint32_t pk = (pte & PG_PKRU_MASK) >> PG_PKRU_BIT;
-        uint32_t pkr_ad = (pkr >> pk * 2) & 1;
-        uint32_t pkr_wd = (pkr >> pk * 2) & 2;
-        uint32_t pkr_prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-
-        if (pkr_ad) {
-            pkr_prot &= ~(PAGE_READ | PAGE_WRITE);
-        } else if (pkr_wd && (is_user || (pg_mode & PG_MODE_WP))) {
-            pkr_prot &= ~PAGE_WRITE;
-        }
-        if ((pkr_prot & (1 << access_type)) == 0) {
-            goto do_fault_pk_protect;
-        }
-        prot &= pkr_prot;
-    }
-
-    if ((prot & (1 << access_type)) == 0) {
-        goto do_fault_protect;
-    }
-
-    /* yes, it can! */
-    {
-        uint32_t set = PG_ACCESSED_MASK;
-        if (access_type == MMU_DATA_STORE) {
-            set |= PG_DIRTY_MASK;
-        } else if (!(pte & PG_DIRTY_MASK)) {
-            /*
-             * Only set write access if already dirty...
-             * otherwise wait for dirty access.
-             */
-            prot &= ~PAGE_WRITE;
-        }
-        if (!ptw_setl(&pte_trans, pte, set)) {
-            /*
-             * We can arrive here from any of 3 levels and 2 formats.
-             * The only safe thing is to restart the entire lookup.
-             */
-            goto restart_all;
-        }
-    }
-
-    /* merge offset within page */
-    paddr = (pte & PG_ADDRESS_MASK & ~(page_size - 1)) | (addr & (page_size - 1));
-
-    /*
-     * Note that NPT is walked (for both paging structures and final guest
-     * addresses) using the address with the A20 bit set.
-     */
-    if (in->ptw_idx == MMU_NESTED_IDX) {
-        CPUTLBEntryFull *full;
-        int flags, nested_page_size;
-
-        flags = probe_access_full(env, paddr, 0, access_type,
-                                  MMU_NESTED_IDX, true,
-                                  &pte_trans.haddr, &full, 0);
-        if (unlikely(flags & TLB_INVALID_MASK)) {
-            *err = (TranslateFault){
-                .error_code = env->error_code,
-                .cr2 = paddr,
-                .stage2 = S2_GPA,
-            };
-            return false;
-        }
-
-        /* Merge stage1 & stage2 protection bits. */
-        prot &= full->prot;
-
-        /* Re-verify resulting protection. */
-        if ((prot & (1 << access_type)) == 0) {
-            goto do_fault_protect;
-        }
-
-        /* Merge stage1 & stage2 addresses to final physical address. */
-        nested_page_size = 1 << full->lg_page_size;
-        paddr = (full->phys_addr & ~(nested_page_size - 1))
-              | (paddr & (nested_page_size - 1));
-
-        /*
-         * Use the larger of stage1 & stage2 page sizes, so that
-         * invalidation works.
-         */
-        if (nested_page_size > page_size) {
-            page_size = nested_page_size;
-        }
-    }
-
-    out->paddr = paddr & x86_get_a20_mask(env);
-    out->prot = prot;
-    out->page_size = page_size;
-    return true;
-
- do_fault_rsvd:
-    error_code = PG_ERROR_RSVD_MASK;
-    goto do_fault_cont;
- do_fault_protect:
-    error_code = PG_ERROR_P_MASK;
-    goto do_fault_cont;
- do_fault_pk_protect:
-    assert(access_type != MMU_INST_FETCH);
-    error_code = PG_ERROR_PK_MASK | PG_ERROR_P_MASK;
-    goto do_fault_cont;
- do_fault:
-    error_code = 0;
- do_fault_cont:
-    if (is_user) {
-        error_code |= PG_ERROR_U_MASK;
-    }
-    switch (access_type) {
-    case MMU_DATA_LOAD:
-        break;
-    case MMU_DATA_STORE:
-        error_code |= PG_ERROR_W_MASK;
-        break;
-    case MMU_INST_FETCH:
-        if (pg_mode & (PG_MODE_NXE | PG_MODE_SMEP)) {
-            error_code |= PG_ERROR_I_D_MASK;
-        }
-        break;
-    }
-    *err = (TranslateFault){
-        .exception_index = EXCP0E_PAGE,
-        .error_code = error_code,
-        .cr2 = addr,
-    };
-    return false;
-}
-
-static G_NORETURN void raise_stage2(CPUX86State *env, TranslateFault *err,
+static G_NORETURN void raise_stage2(CPUX86State *env, X86TranslateFault *err,
                                     uintptr_t retaddr)
 {
     uint64_t exit_info_1 = err->error_code;
@@ -526,82 +46,17 @@ static G_NORETURN void raise_stage2(CPUX86State *env, TranslateFault *err,
     cpu_vmexit(env, SVM_EXIT_NPF, exit_info_1, retaddr);
 }
 
-static bool get_physical_address(CPUX86State *env, vaddr addr,
-                                 MMUAccessType access_type, int mmu_idx,
-                                 TranslateResult *out, TranslateFault *err,
-                                 uint64_t ra)
-{
-    TranslateParams in;
-    bool use_stage2 = env->hflags2 & HF2_NPT_MASK;
-
-    in.addr = addr;
-    in.access_type = access_type;
-
-    switch (mmu_idx) {
-    case MMU_PHYS_IDX:
-        break;
-
-    case MMU_NESTED_IDX:
-        if (likely(use_stage2)) {
-            in.cr3 = env->nested_cr3;
-            in.pg_mode = env->nested_pg_mode;
-            in.mmu_idx =
-                env->nested_pg_mode & PG_MODE_LMA ? MMU_USER64_IDX : MMU_USER32_IDX;
-            in.ptw_idx = MMU_PHYS_IDX;
-
-            if (!mmu_translate(env, &in, out, err, ra)) {
-                err->stage2 = S2_GPA;
-                return false;
-            }
-            return true;
-        }
-        break;
-
-    default:
-        if (is_mmu_index_32(mmu_idx)) {
-            addr = (uint32_t)addr;
-        }
-
-        if (likely(env->cr[0] & CR0_PG_MASK)) {
-            in.cr3 = env->cr[3];
-            in.mmu_idx = mmu_idx;
-            in.ptw_idx = use_stage2 ? MMU_NESTED_IDX : MMU_PHYS_IDX;
-            in.pg_mode = get_pg_mode(env);
-
-            if (in.pg_mode & PG_MODE_LMA) {
-                /* test virtual address sign extension */
-                int shift = in.pg_mode & PG_MODE_LA57 ? 56 : 47;
-                int64_t sext = (int64_t)addr >> shift;
-                if (sext != 0 && sext != -1) {
-                    *err = (TranslateFault){
-                        .exception_index = EXCP0D_GPF,
-                        .cr2 = addr,
-                    };
-                    return false;
-                }
-            }
-            return mmu_translate(env, &in, out, err, ra);
-        }
-        break;
-    }
-
-    /* No translation needed. */
-    out->paddr = addr & x86_get_a20_mask(env);
-    out->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-    out->page_size = TARGET_PAGE_SIZE;
-    return true;
-}
 
 bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
                       MMUAccessType access_type, int mmu_idx,
                       bool probe, uintptr_t retaddr)
 {
     CPUX86State *env = cpu_env(cs);
-    TranslateResult out;
-    TranslateFault err;
+    X86TranslateResult out;
+    X86TranslateFault err;
 
-    if (get_physical_address(env, addr, access_type, mmu_idx, &out, &err,
-                             retaddr)) {
+    if (x86_cpu_get_physical_address(env, addr, access_type, mmu_idx, &out,
+                                     &err, retaddr)) {
         /*
          * Even if 4MB pages, we map only one 4KB page in the cache to
          * avoid filling it too fast.
-- 
2.34.1


