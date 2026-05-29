Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDDACD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3Gk-0005PV-9N; Fri, 29 May 2026 15:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wT3GW-00050D-BR
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:53:11 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wT3GS-0005YS-Hu
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:53:07 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-69d694cecd2so2815729eaf.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780084383; x=1780689183; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=72eQJ6ePVe7hWJEJ8TUxs48y/b4PbTrVDSDol9yPiFw=;
 b=RzieFgAblU4bamCCw95r+/l7hWEUXWQBk69J734K0tVp16D7st9MOW5ZSt9+PihrYU
 iiqrWVe1al/hhHgC3EnmEwrOxt5ea70p/2tFzqIwDR7leM9IR6VxBwGAMM8p4XOL1BTW
 48rSoKqRMMi2KbGj+fHTKRIanK1gMXdYKRNLUyb8S2RokX9WxWH8dGQlo9/W+k33Ytvc
 MhNGK9vd6SXEHLbZRMi7bjtbOh3WfuITSnHNT85GDFeCg6hS8BugCE/wXoJeXljLLCwo
 GxRwg/L/aOrj5v7ELKuIvOlCbHYOU/k3XUczJyLwBGB0seIzoRCqJw3dCNvoieeJx2+K
 RH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084383; x=1780689183;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=72eQJ6ePVe7hWJEJ8TUxs48y/b4PbTrVDSDol9yPiFw=;
 b=Ko/JhkL6RHk5RdxTB5caX62X8yvEZiYLnuHw42GWhpYKNOlYHJzzhDMJxDFxoWr4T0
 ZXXLvJ/rb8hpRtiL1VjjPS4aYKJJEdmfDMncIOyhkgnhPQPO1nd2Qn5QidJpvWhTy1Rb
 hnHRtPiLg5W2Ocbq5zCweFirwHXfUptyoFTDFRtwrZ6I+nyAh9szDUfi4v0/5lt/y7M9
 SUNUdLn3Cdkl7BsbSucrwsEPBPgTYAh9htPoBSr1N1Cs+jmAgdUHkd2MCzujs72bQw/7
 1YAq201/MU0dmUv6pZkrcSwx6xQ7SP4Jt7pkL7gJTgUPX4YXYM2JPz9DbPxYyoGWstN7
 QQZg==
X-Gm-Message-State: AOJu0YxUByF0G4E89bxpqfT/O7uqBgxXfZPqwBQFcdKh6Y516VFOFHSF
 QlqlwV6CTwI6WrjF57K2GBmHkFSNlrxqvVF5+kpI3emoR9R7q4BXkV6U
X-Gm-Gg: Acq92OGGpoXptdHupheYqAocSzWL1qrSQcifd61KyUFBQ6Dc0hWiwTKBzgoUlmO7Oyr
 6hiHuBTaGCzo3KUVWZWh1aiF/cf9l4TTcdyGzJU438maDA+sIKssowWWSaYSRP1An4/rqzfeyH5
 4J69BcgJTBOP1t26M8nNked0tzQTsc3MM6lf3y6ESPoT7elNGFgiSXYKgianLWgfwNBHgEz8Ezr
 XXzv6Gx4db2r9L7tvpT1bW4HvMs4e7lynrErrWJorapnorpvaFSiIHqqzhTO/PB8HAKA9w6TUw7
 vY69ZeGuE4d1fSD3GYT0/H+q5bQCqgeU/MnyJMq1KCEVbKbVGGEzl4qJMp6SgB2VG14roo8xsrp
 pd9XxAsXeqHbFCMPKfOJKX/nxGlzu2RE8cnx7PWpzxiktU2V+OwwbDeuxTzmJbfw8o31YttHQ0C
 Tq0ZP0guh2KhIG0NU2gGGcvFuOKhtRGZVhgunhHKTj+eU=
X-Received: by 2002:a05:6820:4d0b:b0:69d:889d:4ed2 with SMTP id
 006d021491bc7-69e105d1f1dmr352805eaf.48.1780084383064; 
 Fri, 29 May 2026 12:53:03 -0700 (PDT)
Received: from [10.21.163.79] ([146.74.94.63])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e06587eecsm1626692eaf.0.2026.05.29.12.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 12:53:02 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Fri, 29 May 2026 12:52:45 -0700
Subject: [PATCH v7 05/15] target/arm: emit tag check when MTX without TBI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-feat-mte4-v7-5-ccbd3c14eb3c@gmail.com>
References: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
In-Reply-To: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780084373; l=10628;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=90fcYYNlCci8iZmGU/HSK7SfJ6HJ+1rxP3CNwl6XUxE=;
 b=V6hKC/iFWnJk8DJ1XEFpOarnLWtQ1a6/xYqQ7alsOyes4JP4lkSUY+6V66tFzx8vFt8V89pYW
 GbUKjjJuHGiBqGc6usdevN/WDlLJq6LnTw+CyERw+8JX2tTzQX7qqos
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=brookmangabriel@gmail.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Previously, the TBI bit was used to mediate whether tag checks happened.
With MTE4, if the MTX bits are enabled, then tag checking happens even
if TBI is disabled. See AccessIsTagChecked.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h   |  5 +++++
 target/arm/helper.c         | 10 ++++++++++
 target/arm/internals.h      | 13 ++++++++-----
 target/arm/tcg/helper-a64.c |  7 ++++---
 target/arm/tcg/hflags.c     | 11 +++++++----
 target/arm/tcg/mte_helper.c |  9 ++++++---
 target/arm/tcg/sme_helper.c |  4 ++--
 target/arm/tcg/sve_helper.c |  6 +++---
 8 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 0708e4c7d6..ebdc1e2855 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1191,6 +1191,11 @@ static inline bool isar_feature_aa64_mte_store_only(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTESTOREONLY) == 1;
 }
 
+static inline bool isar_feature_aa64_mte_mtx(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR1, MTEX) != 0;
+}
+
 static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, SME) != 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6210e3abec..902eac767b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9613,6 +9613,16 @@ uint64_t arm_sctlr(CPUARMState *env, int el)
     return env->cp15.sctlr_el[el];
 }
 
+int aa64_va_parameter_mtx(uint64_t tcr, ARMMMUIdx mmu_idx)
+{
+    if (regime_has_2_ranges(mmu_idx)) {
+        return extract64(tcr, 60, 2);
+    } else {
+        /* Replicate the single MTX bit so we always have 2 bits.  */
+        return extract64(tcr, 33, 1) * 3;
+    }
+}
+
 int aa64_va_parameter_tbi(uint64_t tcr, ARMMMUIdx mmu_idx)
 {
     if (regime_has_2_ranges(mmu_idx)) {
diff --git a/target/arm/internals.h b/target/arm/internals.h
index ae5afc5362..2abef67e03 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1435,6 +1435,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
                                    ARMMMUIdx mmu_idx, bool data,
                                    bool el1_is_aa32);
 
+int aa64_va_parameter_mtx(uint64_t tcr, ARMMMUIdx mmu_idx);
 int aa64_va_parameter_tbi(uint64_t tcr, ARMMMUIdx mmu_idx);
 int aa64_va_parameter_tbid(uint64_t tcr, ARMMMUIdx mmu_idx);
 int aa64_va_parameter_tcma(uint64_t tcr, ARMMMUIdx mmu_idx);
@@ -1576,7 +1577,8 @@ FIELD(MTEDESC, TBI,   4, 2)
 FIELD(MTEDESC, TCMA,  6, 2)
 FIELD(MTEDESC, WRITE, 8, 1)
 FIELD(MTEDESC, ALIGN, 9, 3)
-FIELD(MTEDESC, SIZEM1, 12, 32 - 12)  /* size - 1 */
+FIELD(MTEDESC, MTX,   12, 2)
+FIELD(MTEDESC, SIZEM1, 14, 32 - 14)  /* size - 1 */
 
 bool mte_probe(CPUARMState *env, uint32_t desc, uint64_t ptr);
 uint64_t mte_check(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra);
@@ -1646,10 +1648,11 @@ static inline uint64_t address_with_allocation_tag(uint64_t ptr, int rtag)
     return deposit64(ptr, 56, 4, rtag);
 }
 
-/* Return true if tbi bits mean that the access is checked.  */
-static inline bool tbi_check(uint32_t desc, int bit55)
+/* Return true if tbi or mtx bits mean that the access is tag checked.  */
+static inline bool tbi_or_mtx_check(uint32_t desc, int bit55)
 {
-    return (desc >> (R_MTEDESC_TBI_SHIFT + bit55)) & 1;
+    uint32_t mask = (1u << R_MTEDESC_TBI_SHIFT) | (1u << R_MTEDESC_MTX_SHIFT);
+    return desc & (mask << bit55);
 }
 
 /* Return true if tcma bits mean that the access is unchecked.  */
@@ -1683,7 +1686,7 @@ static inline uint64_t useronly_maybe_clean_ptr(uint32_t desc, uint64_t ptr)
 {
 #ifdef CONFIG_USER_ONLY
     int64_t clean_ptr = sextract64(ptr, 0, 56);
-    if (tbi_check(desc, clean_ptr < 0)) {
+    if (tbi_or_mtx_check(desc, clean_ptr < 0)) {
         ptr = clean_ptr;
     }
 #endif
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 6505ee3c94..020ebf26a2 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -1054,7 +1054,7 @@ static int mops_sizereg(uint32_t syndrome)
 }
 
 /*
- * Return true if TCMA and TBI bits mean we need to do MTE checks.
+ * Return true if the TCMA, TBI, and MTX bits mean we need to do MTE checks.
  * We only need to do this once per MOPS insn, not for every page.
  */
 static bool mte_checks_needed(uint64_t ptr, uint32_t desc)
@@ -1062,12 +1062,13 @@ static bool mte_checks_needed(uint64_t ptr, uint32_t desc)
     int bit55 = extract64(ptr, 55, 1);
 
     /*
-     * Note that tbi_check() returns true for "access checked" but
+     * Note that tbi_or_mtx_check() return true for "access checked", but
      * tcma_check() returns true for "access unchecked".
      */
-    if (!tbi_check(desc, bit55)) {
+    if (!tbi_or_mtx_check(desc, bit55)) {
         return false;
     }
+
     return !tcma_check(desc, bit55, allocation_tag_from_addr(ptr));
 }
 
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 6be84b68ab..d9d783489c 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -283,13 +283,16 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     uint64_t tcr = regime_tcr(env, mmu_idx);
     uint64_t hcr = arm_hcr_el2_eff(env);
     uint64_t sctlr;
-    int tbii, tbid;
+    int tbii, tbid, mtx;
 
     DP_TBFLAG_ANY(flags, AARCH64_STATE, 1);
 
     /* Get control bits for tagged addresses.  */
     tbid = aa64_va_parameter_tbi(tcr, mmu_idx);
     tbii = tbid & ~aa64_va_parameter_tbid(tcr, mmu_idx);
+    mtx = cpu_isar_feature(aa64_mte_mtx, env_archcpu(env)) ?
+          aa64_va_parameter_mtx(tcr, mmu_idx) :
+          0;
 
     DP_TBFLAG_A64(flags, TBII, tbii);
     DP_TBFLAG_A64(flags, TBID, tbid);
@@ -441,14 +444,14 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         /*
          * Set MTE_ACTIVE if any access may be Checked, and leave clear
          * if all accesses must be Unchecked:
-         * 1) If no TBI, then there are no tags in the address to check,
+         * 1) If TBI and MTX are both unset, accesses are Unchecked.
          * 2) If Tag Check Override, then all accesses are Unchecked,
          * 3) If Tag Check Fail == 0, then Checked access have no effect,
          * 4) If no Allocation Tag Access, then all accesses are Unchecked.
          */
         if (allocation_tag_access_enabled(env, el, sctlr)) {
             DP_TBFLAG_A64(flags, ATA, 1);
-            if (tbid
+            if ((tbid || mtx)
                 && !(env->pstate & PSTATE_TCO)
                 && (sctlr & (el == 0 ? SCTLR_TCF0 : SCTLR_TCF))) {
                 DP_TBFLAG_A64(flags, MTE_ACTIVE, 1);
@@ -474,7 +477,7 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
         /* And again for unprivileged accesses, if required.  */
         if (EX_TBFLAG_A64(flags, UNPRIV)
-            && tbid
+            && (tbid || mtx)
             && !(env->pstate & PSTATE_TCO)
             && (sctlr & SCTLR_TCF0)
             && allocation_tag_access_enabled(env, 0, sctlr)) {
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index bf35dc10ce..61cdf92c54 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -823,8 +823,11 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
     bit55 = extract64(ptr, 55, 1);
     *fault = ptr;
 
-    /* If TBI is disabled, the access is unchecked, and ptr is not dirty. */
-    if (unlikely(!tbi_check(desc, bit55))) {
+    /*
+     * If TBI and MTX are disabled, the access is unchecked, and ptr is not
+     * dirty.
+     */
+    if (unlikely(!tbi_or_mtx_check(desc, bit55))) {
         return -1;
     }
 
@@ -965,7 +968,7 @@ uint64_t HELPER(mte_check_zva)(CPUARMState *env, uint32_t desc, uint64_t ptr)
     bit55 = extract64(ptr, 55, 1);
 
     /* If TBI is disabled, the access is unchecked, and ptr is not dirty. */
-    if (unlikely(!tbi_check(desc, bit55))) {
+    if (unlikely(!tbi_or_mtx_check(desc, bit55))) {
         return ptr;
     }
 
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 0055e97a2b..2bfb12c086 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -674,7 +674,7 @@ void sme_ld1_mte(CPUARMState *env, void *za, uint64_t *vg,
     int bit55 = extract64(addr, 55, 1);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(mtedesc, bit55) ||
+    if (!tbi_or_mtx_check(mtedesc, bit55) ||
         tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
@@ -856,7 +856,7 @@ void sme_st1_mte(CPUARMState *env, void *za, uint64_t *vg, target_ulong addr,
     int bit55 = extract64(addr, 55, 1);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(mtedesc, bit55) ||
+    if (!tbi_or_mtx_check(mtedesc, bit55) ||
         tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index a002006ea5..d05d8addfd 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -6388,7 +6388,7 @@ void sve_ldN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
     int bit55 = extract64(addr, 55, 1);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(mtedesc, bit55) ||
+    if (!tbi_or_mtx_check(mtedesc, bit55) ||
         tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
@@ -6750,7 +6750,7 @@ void sve_ldnfff1_r_mte(CPUARMState *env, void *vg, target_ulong addr,
     int bit55 = extract64(addr, 55, 1);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(mtedesc, bit55) ||
+    if (!tbi_or_mtx_check(mtedesc, bit55) ||
         tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
@@ -7005,7 +7005,7 @@ void sve_stN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
     int bit55 = extract64(addr, 55, 1);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(mtedesc, bit55) ||
+    if (!tbi_or_mtx_check(mtedesc, bit55) ||
         tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }

-- 
2.54.0


