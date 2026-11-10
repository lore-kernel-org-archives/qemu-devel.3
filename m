Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3A9606B2D7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K7Rk3NIg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQlTw-0007x7-07; Tue, 10 Nov 2026 08:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xQlTY-0007l2-Qs
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 08:01:26 -0500
Received: from mail-pj2-x06.google.com ([2607:f8b0:4864:39::6])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xQlTW-0001Nf-Cv
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 08:01:24 -0500
Received: by mail-pj2-x06.google.com with SMTP id
 98e67ed59e1d1-3ad211ad92bso670390a91.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 05:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794315680; x=1794920480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DtQbu7DHPVfK5mMxsHi+xL0wa84jUv7WpME15do7iUY=;
 b=K7Rk3NIgLfwfxWpNXWhqnVo9YYpAQhGIYcaCzLWdcUaInNrFEGRvbxJOSGddmZPuVZ
 qF1k7S+b5Pk6dw+BC0JksY+ws0YsgQnRa0VrdmojXilIfcS6LBR267v6tmeOaLu/nmRo
 2L3PkkSAD3yNl2lrACTgDkLVohinmFj026SNuAn1/4CqOIX9YXhPeR1Bfdbz5wWMUQwW
 zjvzUM3WjC8YjT2gQq1W2bzmYTYbdzKV9lgwyJa73/MHkP3+vomLcAMBo1zOjEBZ7kGE
 c2EnemDbYUom6QzR1vRUnfMzotC4aDax5Ureug25lv3xbzPETDLJvvbc4SoN5yP5jVOR
 +yvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794315680; x=1794920480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DtQbu7DHPVfK5mMxsHi+xL0wa84jUv7WpME15do7iUY=;
 b=bgrdt3mtFgBY5cI6qNWu1xktufHREzdAw6+2cGK0aFJpu5h22p90T0OyMDNloOO9MT
 kjx69blEysu4599SY1f1lccFdKb7TP2biJY2JsO3VEA+AA63keCmIIlbh/vNVpTcWL46
 e6CfIHevagDu4Od9FVhBH4c5Q7lx3O11ICejVAENvfI6KbJkQIjC6+gPEk6vMtF9Y/v1
 yH6mj88qNLNiwafbIJSbO8pKjBhmXYuQOyoL2s1ycT1zdMyA+LJPgu4XE4+9V6xDfHg9
 fTCEpPr/Snz1OmtIOhGz9TuyHYoz0Jjwd1ehf8u4/s7ZP+i9mk0NUcpMHP1RXfkq9k8b
 Yi/w==
X-Gm-Message-State: APuU4Z+zNu1yKvlThrnjUnJP8lhcLmF/dq80FwEwtLiYoxYLNlP2Z2Ly
 bmzclur4t4SA+XsFLznFh6q5wzRTqGOB/tHqGSy85hudykQBUYSitw4k/CqCd+ic
X-Gm-Gg: AYBFou2523/T6JDL4QU21BE4ttuwavwcsWT1GlInZr1e49TzhEjwa9wQr531TgoBw6h
 RyzrcRg7ZEzQmGENeKrIRoLm2fxaKIQED+544aPckXaotrrbTT+69oxpArS2ml4YyRfL2MSbBaX
 ube+bH3RK2mqqxmLNGM+9hi1WSZEhnysdTpLcyP7bqA54LGtlfTHtzvQZqslcy88abpiXnzj7OK
 09aTH9eTQucePcgMBcZqqDUU8DKGMwj6vTb4bHQs5cszmGkpZOoxE+lnXXsxYFTTGbZKARQf4ln
 VEbLASOQ2+kBhLEiUv48LMKCOQTO+U/07MM7qBkn7iUu4LIGbqw2/rFkWMNOHnq62onBiSg8+n8
 GVX097jcYZ2zSZx8EoPLWVFuMFxumndxLNYM5MnIUnmAHl0NgQhNeRZkubanD1GuGCXyb9U/hR+
 fLpbnc0Dvskis1eXjz7QMhhuy+ip1b7XbVc0d+R40fyXv6nTc4uT6UyIgOATtaZxm47nB4gbh4X
 ezyk6LklEoqeO9x93vtxuO3BCJbTiYz8/xHceZftO1utSgDbxYS6k2JtK4e8QPnZTaE7myqlcgC
 KY330e6aYZQHubz4XbflE3LexZP9g3o=
X-Received: by 2002:a17:90b:574e:b0:3a8:c0cd:57f3 with SMTP id
 98e67ed59e1d1-3b166ca2c31mr2540988a91.18.1794315679868; 
 Tue, 10 Nov 2026 05:01:19 -0800 (PST)
Received: from computer ([2604:3d09:98d:800:e939:4613:1d28:dfcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b16769b589sm3765567a91.5.2026.11.10.05.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 05:01:19 -0800 (PST)
From: Tim <mdspan.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, zhao1.liu@intel.com,
 Tim <mdspan.github@gmail.com>
Subject: [PATCH 3/4] target/i386: emulate LAM in TCG
Date: Tue, 10 Nov 2026 13:01:07 +0000
Message-ID: <20261110130108.706228-4-mdspan.github@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110130108.706228-1-mdspan.github@gmail.com>
References: <20261110130108.706228-1-mdspan.github@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::6;
 envelope-from=mdspan.github@gmail.com; helo=mail-pj2-x06.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Linear Address Masking (LAM) lets software keep metadata in bits
62:57 or 62:48 of 64-bit data addresses.  CR3.LAM_U57 and CR3.LAM_U48
enable it for user addresses, and CR4.LAM_SUP for supervisor
addresses.  Implement it in TCG and add it to TCG_7_1_EAX_FEATURES.

get_physical_address() masks the address and runs the canonical check
and the page walk on the result.  Since masking keeps bit 63, this is
the canonical check that the SDM specifies for LAM.  CR2 receives the
masked address on #PF.  The TLB entry is installed under the tagged
address, which is the same way target/arm does it for top-byte-ignore.
Instruction fetches are not masked, so if masking changes the address,
an entry filled by a data access is not executable and one filled by
a fetch is not readable or writable.

Since each tag of a page has its own entry, INVLPG and INVLPGA flush
every tagged alias with tlb_flush_page_bits_by_mmuidx(), and a change
of CR4.LAM_SUP flushes the TLB.

MOV to CR3 and VMRUN accept the CR3 LAM bits if CPUID reports LAM.
Masking checks CPUID too, since RSM and gdbstub load CR3 without
checking reserved bits.

x86_cpu_translate_for_debug() masks addresses as for a data access,
for gdbstub, monitor, and qemu_plugin_translate_vaddr().  With LAM_U48
and 5-level paging, it therefore translates an instruction address at
or above 2^47 differently from a fetch.

Signed-off-by: Tim <mdspan.github@gmail.com>
---
 target/i386/cpu.c                    |  2 +-
 target/i386/cpu.h                    | 46 ++++++++++++++++++++++++++++
 target/i386/helper.c                 |  6 +++-
 target/i386/tcg/system/excp_helper.c | 30 ++++++++++++++++--
 target/i386/tcg/system/misc_helper.c | 24 +++++++++++++--
 target/i386/tcg/system/svm_helper.c  |  3 +-
 6 files changed, 102 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index eab0d5a..ad5d90d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1006,7 +1006,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_7_0_EDX_FEATURES (CPUID_7_0_EDX_FSRM | CPUID_7_0_EDX_KERNEL_FEATURES)
 
 #define TCG_7_1_EAX_FEATURES (CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | \
-          CPUID_7_1_EAX_FSRC | CPUID_7_1_EAX_CMPCCXADD)
+          CPUID_7_1_EAX_FSRC | CPUID_7_1_EAX_CMPCCXADD | CPUID_7_1_EAX_LAM)
 #define TCG_7_1_ECX_FEATURES 0
 #define TCG_7_1_EDX_FEATURES CPUID_7_1_EDX_APXF
 #define TCG_7_2_EDX_FEATURES 0
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3945e90..f196d93 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -260,6 +260,9 @@ typedef enum X86Seg {
 #define CR0_CD_MASK  (1U << 30)
 #define CR0_PG_MASK  (1U << 31)
 
+#define CR3_LAM_U57_MASK (1ULL << 61)
+#define CR3_LAM_U48_MASK (1ULL << 62)
+
 #define CR4_VME_MASK  (1U << 0)
 #define CR4_PVI_MASK  (1U << 1)
 #define CR4_TSD_MASK  (1U << 2)
@@ -3111,6 +3114,49 @@ static inline uint64_t cr4_reserved_bits(CPUX86State *env)
     return reserved_bits;
 }
 
+/* Reserved CR3 bits in IA-32e mode */
+static inline uint64_t cr3_reserved_bits(CPUX86State *env)
+{
+    uint64_t reserved_bits = ~0ULL << env_archcpu(env)->phys_bits;
+
+    if (env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM) {
+        reserved_bits &= ~(CR3_LAM_U57_MASK | CR3_LAM_U48_MASK);
+    }
+    return reserved_bits;
+}
+
+/* LAM width of @addr: 57 or 48, or 64 without LAM. IA-32e mode only. */
+static inline unsigned x86_lam_addr_bits(CPUX86State *env, uint64_t addr)
+{
+    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM)) {
+        return 64;
+    }
+    if (addr >> 63) {
+        if (!(env->cr[4] & CR4_LAM_SUP_MASK)) {
+            return 64;
+        }
+        return env->cr[4] & CR4_LA57_MASK ? 57 : 48;
+    }
+    if (env->cr[3] & CR3_LAM_U57_MASK) {
+        return 57;
+    }
+    if (env->cr[3] & CR3_LAM_U48_MASK) {
+        return 48;
+    }
+    return 64;
+}
+
+/* @addr with its LAM metadata masked, keeping bit 63. IA-32e mode only. */
+static inline uint64_t x86_lam_mask_addr(CPUX86State *env, uint64_t addr)
+{
+    unsigned lam_bits = x86_lam_addr_bits(env, addr);
+
+    if (lam_bits == 64) {
+        return addr;
+    }
+    return deposit64(sextract64(addr, 0, lam_bits), 63, 1, addr >> 63);
+}
+
 static inline bool ctl_has_irq(CPUX86State *env)
 {
     uint32_t int_prio;
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 723e87f..c680e01 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -204,7 +204,8 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
 #endif
     if ((new_cr4 ^ env->cr[4]) &
         (CR4_PGE_MASK | CR4_PAE_MASK | CR4_PSE_MASK |
-         CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_LA57_MASK)) {
+         CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_LA57_MASK |
+         CR4_LAM_SUP_MASK)) {
         tlb_flush(env_cpu(env));
     }
 
@@ -290,6 +291,9 @@ bool x86_cpu_translate_for_debug(CPUState *cs, vaddr addr,
             uint64_t pml4e_addr, pml4e;
             int32_t sext;
 
+            /* LAM: translate as for a data access */
+            addr = x86_lam_mask_addr(env, addr);
+
             /* test virtual address sign extension */
             sext = la57 ? (int64_t)addr >> 56 : (int64_t)addr >> 47;
             if (sext != 0 && sext != -1) {
diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index 6c48ccb..1c18eb7 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -581,15 +581,35 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
         }
 
         if (likely(env->cr[0] & CR0_PG_MASK || use_stage2)) {
+            int lam_prot_mask = 0;
+
             in.cr3 = env->cr[3];
             in.mmu_idx = mmu_idx;
             in.ptw_idx = use_stage2 ? MMU_NESTED_IDX : MMU_PHYS_IDX;
             in.pg_mode = get_pg_mode(env);
 
             if (in.pg_mode & PG_MODE_LMA) {
-                /* test virtual address sign extension */
+                vaddr masked = x86_lam_mask_addr(env, addr);
                 int shift = in.pg_mode & PG_MODE_LA57 ? 56 : 47;
-                int64_t sext = (int64_t)addr >> shift;
+                int64_t sext;
+
+                /*
+                 * LAM masks data addresses but not fetches.  Both install
+                 * the entry under the unmasked address, so if masking
+                 * changes it, keep only the permissions of this access.
+                 */
+                if (masked != addr) {
+                    if (access_type == MMU_INST_FETCH) {
+                        lam_prot_mask = PAGE_READ | PAGE_WRITE;
+                    } else {
+                        lam_prot_mask = PAGE_EXEC;
+                        addr = masked;
+                        in.addr = addr;
+                    }
+                }
+
+                /* test virtual address sign extension */
+                sext = (int64_t)addr >> shift;
                 if (sext != 0 && sext != -1) {
                     *err = (TranslateFault){
                         .exception_index = EXCP0D_GPF,
@@ -599,7 +619,11 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
                     return false;
                 }
             }
-            return mmu_translate(env, &in, out, err, ra);
+            if (!mmu_translate(env, &in, out, err, ra)) {
+                return false;
+            }
+            out->prot &= ~lam_prot_mask;
+            return true;
         }
         break;
     }
diff --git a/target/i386/tcg/system/misc_helper.c b/target/i386/tcg/system/misc_helper.c
index a77da59..be4f553 100644
--- a/target/i386/tcg/system/misc_helper.c
+++ b/target/i386/tcg/system/misc_helper.c
@@ -90,8 +90,7 @@ void HELPER(write_crN)(CPUX86State *env, int reg, target_ulong t0)
         cpu_x86_update_cr0(env, t0);
         break;
     case 3:
-        if ((env->efer & MSR_EFER_LMA) &&
-                (t0 & ((~0ULL) << env_archcpu(env)->phys_bits))) {
+        if ((env->efer & MSR_EFER_LMA) && (t0 & cr3_reserved_bits(env))) {
             cpu_vmexit(env, SVM_EXIT_ERR, 0, GETPC());
         }
         if (!(env->efer & MSR_EFER_LMA)) {
@@ -504,6 +503,27 @@ void HELPER(rdmsr)(CPUX86State *env)
 
 void HELPER(flush_page)(CPUX86State *env, target_ulong addr)
 {
+#ifdef TARGET_X86_64
+    if (env->hflags & HF_LMA_MASK) {
+        int shift = env->cr[4] & CR4_LA57_MASK ? 56 : 47;
+        int64_t sext = (int64_t)addr >> shift;
+        unsigned lam_bits;
+
+        /* no LAM for the operand: non-canonical is a no-op */
+        if (sext != 0 && sext != -1) {
+            return;
+        }
+
+        /* TLB entries are per tag: flush every tagged alias */
+        lam_bits = x86_lam_addr_bits(env, addr);
+        if (lam_bits < 64) {
+            tlb_flush_page_bits_by_mmuidx(env_cpu(env), addr,
+                                          MAKE_64BIT_MASK(0, NB_MMU_MODES),
+                                          lam_bits);
+            return;
+        }
+    }
+#endif
     tlb_flush_page(env_cpu(env), addr);
 }
 
diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/system/svm_helper.c
index 9c04042..0e3cf6f 100644
--- a/target/i386/tcg/system/svm_helper.c
+++ b/target/i386/tcg/system/svm_helper.c
@@ -315,8 +315,7 @@ void HELPER(vmrun)(CPUX86State *env, int aflag, int next_eip_addend)
         cpu_vmexit(env, SVM_EXIT_ERR, 0, GETPC());
     }
     new_cr3 = x86_ldq_phys(cs, env->vm_vmcb + offsetof(struct vmcb, save.cr3));
-    if ((env->efer & MSR_EFER_LMA) &&
-            (new_cr3 & ((~0ULL) << cpu->phys_bits))) {
+    if ((env->efer & MSR_EFER_LMA) && (new_cr3 & cr3_reserved_bits(env))) {
         cpu_vmexit(env, SVM_EXIT_ERR, 0, GETPC());
     }
     new_cr4 = x86_ldq_phys(cs, env->vm_vmcb + offsetof(struct vmcb, save.cr4));
-- 
2.47.3


