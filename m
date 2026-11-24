Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F01606A336
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Idy1/H5N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnal-0001ry-PQ; Tue, 24 Nov 2026 05:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xVnaj-0001qj-23
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:17:37 -0500
Received: from mail-pj2-x09.google.com ([2607:f8b0:4864:39::9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xVnag-0004Xv-U7
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:17:36 -0500
Received: by mail-pj2-x09.google.com with SMTP id
 98e67ed59e1d1-3b3fa8df5c4so2095608a91.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 02:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795515453; x=1796120253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zMpaEscxKPbTPmtI2BRHefK4YkqR6gJfr/SCIzxGkeY=;
 b=Idy1/H5NT8NNaJS4TE30quOgp+Ho1qQ3yFf4pIOy1zigloaQd41sVvQdkHK9NPwZcK
 utZz6W8s83vD01/NHS/cihaCBwKw54UD0em7XBEi+tKGcONykR6pbZtSS0CYtoQ9vRa+
 J9y5CaNL+fgA7KD1bW3MRBuck1rW0AdTprY+b0jzUl/yHICpXq5QYVT60vBVtm+IVOMz
 u06ZT5LMDyqHC1t0NSCW09kgNdBkofwG0WFbOq0ZVczawe3kY59u+TQjnvaxv8713/Lv
 lgoLquXTv/Dkix3PGVKJlFW8mY0oFetgAnhwrlBubGnj0CWnYNcAgmXkB/IQuB4dv7zm
 UA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795515453; x=1796120253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zMpaEscxKPbTPmtI2BRHefK4YkqR6gJfr/SCIzxGkeY=;
 b=WuABh8EY7GlyUWg/04FPW6jmTBt+ut4OngdjN+J5PE1CcDbT21MI8U7lfn2BvFaIph
 vwwQ2kfdLe2As8m4ciaUjiI1QYEOa0395RRLB7o9xrAa+V4yxh8KtdzBuQfRhacIHKlq
 Tx4cOoFslLZoOGpLR3mqWq6mh7MsqO3XtISG5lLlDLpWrjsOGOz5R9lKzWt1vIMYKiUC
 hCRa1CDupcWPF2vzy21VG1MzprGRRJKI2ywK2uxLjW41KMiulCnhXsZZHXkbjrI3jNJr
 PD0OpXDxolcjmMCfiX+A9ojG+uBfsXsiTHmCmISEFecnpxgRCCViQi7AfwAdk/2okUzE
 z8Ng==
X-Gm-Message-State: APuU4Z/NiPSLWAuIHI8ZNucGDagjtVqA0snBZE5+EwmP3PWAFY0p519k
 q4Sov57kBvYDxVku1qiEtdxHIehJj6HVT0oTmodfHBxCqu6CsnQov1zOzfWGLVBrdhM=
X-Gm-Gg: AZFdTZdSj+pSK1pbS5gsj0vwsqfT6PrsWgn2s88H+5OzlVxZGxS/MFKJSe23d+UdClC
 5KHgJqWsjERqq3DMYYSa88iqnvsa1AcHQEcGFIDo2TRhbhHPwgH2YeKB0A4QmdNWzeoTDVBeopd
 n1VBiiAiH2h7iZsNRTsXoYLIOS7k/NUCSD/cT9snJm7yC2psQSdJnvy7HhnNFLWQULAip1VXeFC
 IrsKM2MPv62JTGya//MUlBmxpwaSz2Xw+H1GX3l/3MhwGDA/iPsH+77OjWSDnc59JqC9DM88CSU
 8b4t44atrTJ6ExtpU1JZqjUGQDvT5EewaG/kC067yg9FMGe1HuIpmt2cY+BtfiVORLjUDJAxdrh
 /3yQ22H3cIEV7GF+ZVIx5iwpjfvJn7LmOrwQNJ7GeKnF6L+ee1RjL6iRbfRi5Z6e0TYK7Qd1m3L
 YhYyA4WSWH8w4kBpuzP4FI0FuppvnEfOIJYa3rkxvvsgnp/Yi/BZwvj1fI2GOjXJIxCvYNXKG1S
 Zbs2QaCTbWOzvK8CCScOvQr4EKmHjRroubMX7OCa46+UIMnUbVaiEnhs1gLtzFrnU/sU+xFahBK
 aZc0n0m9UCibhi/IW0EJQFIc5Xwb850=
X-Received: by 2002:a05:6a20:2448:b0:3dd:a197:ede6 with SMTP id
 adf61e73a8af0-4014dd64312mr16195396637.53.1795515453390; 
 Tue, 24 Nov 2026 02:17:33 -0800 (PST)
Received: from computer ([2604:3d09:98d:800:e939:4613:1d28:dfcc])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6cea748csm6627920a12.4.2026.11.24.02.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 02:17:33 -0800 (PST)
From: Tim <mdspan.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, zhao1.liu@intel.com,
 Tim <mdspan.github@gmail.com>
Subject: [PATCH v3 4/5] target/i386: emulate LAM in TCG
Date: Tue, 24 Nov 2026 10:16:53 +0000
Message-ID: <20261124101655.2269531-5-mdspan.github@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124101655.2269531-1-mdspan.github@gmail.com>
References: <20261124101655.2269531-1-mdspan.github@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::9;
 envelope-from=mdspan.github@gmail.com; helo=mail-pj2-x09.google.com
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
Only accesses with the LAM MMU indexes are masked.  Instruction fetches
always use the normal indexes, and data accesses use the LAM indexes
while LAM is enabled, so fetch and data entries for a tagged address do
not share a TLB.

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
v3: mask only for the LAM MMU indexes.
v2: mask only for non-fetch MMU indexes.

 target/i386/cpu.c                    |  2 +-
 target/i386/cpu.h                    | 43 ++++++++++++++++++++++++++++
 target/i386/helper.c                 |  6 +++-
 target/i386/tcg/system/excp_helper.c | 12 ++++++--
 target/i386/tcg/system/misc_helper.c | 24 ++++++++++++++--
 target/i386/tcg/system/svm_helper.c  |  3 +-
 6 files changed, 82 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index eab0d5a4..ad5d90d5 100644
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
index 0923ab4f..fe32a434 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -3147,6 +3147,49 @@ static inline uint64_t cr4_reserved_bits(CPUX86State *env)
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
index e116ae27..3ff00b10 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -216,7 +216,8 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
 #endif
     if ((new_cr4 ^ env->cr[4]) &
         (CR4_PGE_MASK | CR4_PAE_MASK | CR4_PSE_MASK |
-         CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_LA57_MASK)) {
+         CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_LA57_MASK |
+         CR4_LAM_SUP_MASK)) {
         tlb_flush(env_cpu(env));
     }
 
@@ -303,6 +304,9 @@ bool x86_cpu_translate_for_debug(CPUState *cs, vaddr addr,
             uint64_t pml4e_addr, pml4e;
             int32_t sext;
 
+            /* LAM: translate as for a data access */
+            addr = x86_lam_mask_addr(env, addr);
+
             /* test virtual address sign extension */
             sext = la57 ? (int64_t)addr >> 56 : (int64_t)addr >> 47;
             if (sext != 0 && sext != -1) {
diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index 6c48ccbd..9c204ded 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -587,9 +587,17 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
             in.pg_mode = get_pg_mode(env);
 
             if (in.pg_mode & PG_MODE_LMA) {
-                /* test virtual address sign extension */
                 int shift = in.pg_mode & PG_MODE_LA57 ? 56 : 47;
-                int64_t sext = (int64_t)addr >> shift;
+                int64_t sext;
+
+                /* LAM masks data addresses but not instruction fetches */
+                if (is_mmu_index_lam(mmu_idx)) {
+                    addr = x86_lam_mask_addr(env, addr);
+                    in.addr = addr;
+                }
+
+                /* test virtual address sign extension */
+                sext = (int64_t)addr >> shift;
                 if (sext != 0 && sext != -1) {
                     *err = (TranslateFault){
                         .exception_index = EXCP0D_GPF,
diff --git a/target/i386/tcg/system/misc_helper.c b/target/i386/tcg/system/misc_helper.c
index a77da599..be4f553c 100644
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
index 9c040422..0e3cf6fe 100644
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


