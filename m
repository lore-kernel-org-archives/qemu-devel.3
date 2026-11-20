Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CAF60A380A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vsy/gzML
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUM75-0004GH-9q; Fri, 20 Nov 2026 05:45:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xUM6r-0004FB-Fr
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:44:49 -0500
Received: from mail-pi2-x08.google.com ([2607:f8b0:4864:3a::8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xUM6p-0007k0-CY
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:44:49 -0500
Received: by mail-pi2-x08.google.com with SMTP id
 41be03b00d2f7-cd8cb23d52eso376050a12.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 02:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795171485; x=1795776285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+UoU5QGcaotjvsepXF1A8PIf180c3dE6d4S8P/5wX1Q=;
 b=vsy/gzMLQ/6RdvUxPdSxBdH4WaHg5LteijN5r6rDd47SUwwYxxA9gEPKLBwql5JTQo
 mYPySAG00S3rrLDfVy6D4U+0VRK7jfUPair6eeMWTmUeNHXECCmH580kmyL9wO3TT9qK
 ECQDKTvYY2//A0VpkaZauNh8UMKWdX4m8F/5vPqAjHnBaA0tFJTWo5uiV0T8zjnVOIf9
 N1xokrcMsAg31APP1Wz/vvTTiq9woDgtBpQYN9uTJCZAn/5w33QcNgdS70dqGL5zD2OK
 H8O+ofOy6NliNjoKAg2eyhky69I7y7dVK1CSiZ2BipNqI+KQYPKyZaOsR53QO0lp4ynR
 5aPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795171485; x=1795776285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+UoU5QGcaotjvsepXF1A8PIf180c3dE6d4S8P/5wX1Q=;
 b=jf0KN0bcZfZTEbKOuP0vQFgWid3GNSbCv53qapE9dQUc2AIzlgV1MWi0XDi6tUuuwL
 iOyXA9bynhw7erL35k/zlvn5dXSwq7NsbnpNYf+JehVJyC1SPnbEc7GV0L/GzQ2/w92Z
 mt3ZLwrOpOwmYtayi0O71ruHW+mbtfkuKlcKzFC/V5dr+xy7oYnKOgAmuLKUx2mUE1US
 yyN0gTXvhLJSLlQxnvBbgezig2Qkj33+m+K+1yiOgWzFj9EOBci7QGvA72flpmYoeDq6
 pUd/ePn4hQGcxRvNA+7grlEzqKav5E4EQYW+b75Q5cZ64ouMt56r7kSatWIympN+dHjl
 sxMQ==
X-Gm-Message-State: APuU4Z91OiG6hExdCMVKthFqxJfSbLyz3Gf60vcHm1YP3ZkVIpr4O+wK
 QulmSIGXH/BJJ6PQ5MYEzJm3x6h7tSzcj8rAqIJ544/Mb+LAD6MWOGK0Z8vp3r6oNr4=
X-Gm-Gg: AYBFou3dYeGY+Yb0rFKFP8rur1/HE7NlmZugEcjau679Ax4flJ+dcwD1EylIgMkrKx/
 dru+HaZsOFSbLuqk/YzOVZ3QzJ2Wsg7vdg9LwCNj+fVuC2Kjn9xh+Z7+a6i5DNDb5N6ABr6Eizw
 oODSDb9lM/GlNEtcdLX/yI9I89ddql1MmK4T9XhiIO3CrXuVADsytdEK/cmB/wjq2SWo7giq8PM
 8+WUa1xbNGu/egoAG18Ti2SyNSOW0fCvq/wHf23jqMUSRap2VBk59HVOTbpghQEmMEnGOtZCvTI
 SbFS4as7oxTOHVQ4lqOHoWCxAbERK8ObKyGKihJoCcTO1NMwvjPECDOeYCQ9pGntT8z64fPKtHB
 aeluqf35bSnp1Gx/V1dGgTJnQdpr7Y/66W6q5+R4vRGh6qqA75Dx7yHB1I4McBD8c8lixOIuOGQ
 icHzv/bkeWrMTIJ1SnBlxwEmbb1nVM3krQlRoPwOOQu81qfVoeb1AO8DWGZTOI7uLX5YuOO4LJY
 Qqowg90fivkhFc2Nw1YO8QeDWryTxmUEYsd4kQJT+LPwmuu7kBPi+UMgpW8VpE3PT7gN+AM6k0r
 WJdZ5QvKtMhklrsSZcX2UtLwvRHzX1Yl0Mb5+ELLiiR/K3PfQmqT
X-Received: by 2002:a05:6a21:6e04:b0:3e8:b7fd:6288 with SMTP id
 adf61e73a8af0-4014d159070mr2970670637.41.1795171485257; 
 Fri, 20 Nov 2026 02:44:45 -0800 (PST)
Received: from computer ([2604:3d09:98d:800:cd94:7b9e:bb89:3491])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6cfc80d4sm1151506a12.6.2026.11.20.02.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:44:44 -0800 (PST)
From: Tim <mdspan.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, zhao1.liu@intel.com,
 Tim <mdspan.github@gmail.com>
Subject: [PATCH v2 4/5] target/i386: emulate LAM in TCG
Date: Fri, 20 Nov 2026 10:44:30 +0000
Message-ID: <20261120104431.733136-5-mdspan.github@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120104431.733136-1-mdspan.github@gmail.com>
References: <20261120104431.733136-1-mdspan.github@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3a::8;
 envelope-from=mdspan.github@gmail.com; helo=mail-pi2-x08.google.com
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
Instruction fetches are not masked.  They use their own MMU indexes, so
fetch and data entries for a tagged address do not share a TLB.

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
v2: mask only for non-fetch MMU indexes.

 target/i386/cpu.c                    |  2 +-
 target/i386/cpu.h                    | 52 ++++++++++++++++++++++++++++
 target/i386/helper.c                 |  6 +++-
 target/i386/tcg/system/excp_helper.c | 12 +++++--
 target/i386/tcg/system/misc_helper.c | 24 +++++++++++--
 target/i386/tcg/system/svm_helper.c  |  3 +-
 6 files changed, 91 insertions(+), 8 deletions(-)

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
index 5bc19d5e..cbab41c2 100644
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
@@ -2864,6 +2867,12 @@ static inline bool is_mmu_index_user(int mmu_index)
            (mmu_index & ~1) == MMU_UFETCH64_IDX;
 }
 
+static inline bool is_mmu_index_fetch(int mmu_index)
+{
+    return (mmu_index & ~1) == MMU_KFETCH64_IDX ||
+           (mmu_index & ~1) == MMU_UFETCH64_IDX;
+}
+
 static inline bool is_mmu_index_32(int mmu_index)
 {
     assert(mmu_index < MMU_PHYS_IDX);
@@ -3116,6 +3125,49 @@ static inline uint64_t cr4_reserved_bits(CPUX86State *env)
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
index 723e87fe..c680e01a 100644
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
index 6c48ccbd..c8c9c701 100644
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
+                if (!is_mmu_index_fetch(mmu_idx)) {
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


