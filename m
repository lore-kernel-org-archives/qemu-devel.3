Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C58CD342F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 15:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJvZq-0000wW-3h; Mon, 04 May 2026 11:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wJvZn-0000uP-LB
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:51:19 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wJvZl-0006CQ-C0
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:51:19 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-50e5c5033f6so33800881cf.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 08:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777909876; x=1778514676; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tctzP2FcPQ+gfsuFfPKCecvWe96h/9pOlhOMG2Joq/8=;
 b=shahjymQKTcnR9vXwJmkJlrJqegJ44w0BjURwlVHfrHKNdkAoV73WNLIypgplrqnCi
 0gn5C+K6pCBrEEUBGtsZhQ9E9qgn3cMFP/U288ayDnZ5+kIax1kJNhm0nhg5yQc5C9fU
 Pwhx0QWismtCiHdvFml4RVbBdJW5AqRvawV1px5rW9a+BSO5JBJQWcIdtkwARa6MWTIQ
 yHdcIjs+1LT+NyHjsRu0SDl4bgZJyWEiULBvELFQRU3lK2vWzJIs85jnJ6wEXOz36X1W
 +HJW+5ngbjwVfzJqYgIJ31pzR3WpKTBn/WGPiOQPlytQDOG36JGB19CoDuZ7VzxBhCIJ
 348Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777909876; x=1778514676;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tctzP2FcPQ+gfsuFfPKCecvWe96h/9pOlhOMG2Joq/8=;
 b=FcEb2vK8UXflzv/x91LTjnlQn7Z5//3xW53ibnV8H6elotDwv+LbKBCGSiLL8cHaGH
 hhkm5QRsANNLgHlE85r+OyYWqoBXn8CtYvhfigrV515W5G3vjFtbI35A11IGnSpTxVFm
 IzeU8VFg3z7D0DBsiT+dDgaRU3H5DrIWXzHuYF/BA3NgDWad8nKy6ifjOe9/uHwzCmIb
 LqDrPNojEhpceyVyexwjSGhyUlgdSAjqrYOej6KGdeUhmVvi7UZeuj502v42QU5Ka6SM
 NS1uK5Ch10qD2210TLvy4L6OYnHmUT5OxTWULWc54Y4oQ1NAPi8SDWpVeae8vLZGgi4z
 TVMA==
X-Gm-Message-State: AOJu0YyK458M+y2RgbgnfSXWdjkTlaqX7uOvtf8m1iGFC37Os5PGCu0R
 E1hPnLvgxtf1EPtRMZ3egILJOy6y8NWtvdzubuhD3eNxwBAojnLvxh4r
X-Gm-Gg: AeBDietscR9p4VBERcqLXM1e6LYSOQL+ERfGtEd7q8HTUzaG6MtqdKifzLcI3s6exEL
 BBzR6Fhx/Ka7NKSmKcPiLDnNoue3JcZMgWLSgtoyDR+SocGnJuTIBT8uOWwsdLw+JcV30F4FnHw
 qSnAYvQt4YCARJmWh8truVzTJvxpW28QTjwILRwSoYUyiOpzlATqV0lHGPVixty5ry4C0l6ZNcc
 T76uShxu178g1xQWPXv7YV3IykJj0rK6kVU2UQctaEPjHjgAg/Is2yhLjsCbjW1dYZtAy7OX6g5
 QskYEaeB9Qy8g7ahNrOtx1dfRH3cImj0h2JdlaKLWigPBkvY9QdMZQLBxem2cyntXWoVFrWhIxZ
 uzxMxCOl6n5MnG6z48vYd14wJVx3MU1MFMcf4fYvv3aoIcc2lDfafrl4FoQD7eDBrweUvbo09y5
 7IuCtjGDhUrLuYdWcAMUdZMFexAxPcZFKncyRhXdYZjEf0OLkIWpU=
X-Received: by 2002:a05:622a:1e8c:b0:50d:edcd:4f39 with SMTP id
 d75a77b69052e-5104bfcd698mr143284311cf.40.1777909876032; 
 Mon, 04 May 2026 08:51:16 -0700 (PDT)
Received: from [192.168.1.164] ([2600:1009:a021:c665:5296:905f:3e4a:eb90])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51040931552sm99599011cf.12.2026.05.04.08.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 08:51:15 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 04 May 2026 11:50:38 -0400
Subject: [PATCH v5 05/15] target/arm: emit tag check when MTX without TBI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-feat-mte4-v5-5-232a648e63c6@gmail.com>
References: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
In-Reply-To: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777909867; l=9819;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=v+7vHbPDhPrfGr1GkwHZhaMnYJPZJitNx9Vnfe3PjoY=;
 b=NaZtGl0Pm9liG5JteV5wlh/AKOs0wj6oRzIC1Jm7LHmQfHaLsFePB5pbs5z9Zx+mjeuMTz/lY
 0nS4hV0msbODdrm20ZxRAZi0KfZ6g3CQfChqhawyTQl/7UwyU2wNoDX
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qt1-x831.google.com
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
---
 target/arm/helper.c         | 10 ++++++++++
 target/arm/internals.h      | 13 ++++++++-----
 target/arm/tcg/helper-a64.c |  7 ++++---
 target/arm/tcg/hflags.c     |  9 +++++----
 target/arm/tcg/mte_helper.c |  9 ++++++---
 target/arm/tcg/sme_helper.c |  4 ++--
 target/arm/tcg/sve_helper.c |  6 +++---
 7 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ddf44f4306..18352bd186 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9559,6 +9559,16 @@ uint64_t arm_sctlr(CPUARMState *env, int el)
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
index a632584a4e..6df2c547c5 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1422,6 +1422,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
                                    ARMMMUIdx mmu_idx, bool data,
                                    bool el1_is_aa32);
 
+int aa64_va_parameter_mtx(uint64_t tcr, ARMMMUIdx mmu_idx);
 int aa64_va_parameter_tbi(uint64_t tcr, ARMMMUIdx mmu_idx);
 int aa64_va_parameter_tbid(uint64_t tcr, ARMMMUIdx mmu_idx);
 int aa64_va_parameter_tcma(uint64_t tcr, ARMMMUIdx mmu_idx);
@@ -1557,7 +1558,8 @@ FIELD(MTEDESC, TBI,   4, 2)
 FIELD(MTEDESC, TCMA,  6, 2)
 FIELD(MTEDESC, WRITE, 8, 1)
 FIELD(MTEDESC, ALIGN, 9, 3)
-FIELD(MTEDESC, SIZEM1, 12, 32 - 12)  /* size - 1 */
+FIELD(MTEDESC, MTX,   12, 2)
+FIELD(MTEDESC, SIZEM1, 14, 32 - 14)  /* size - 1 */
 
 bool mte_probe(CPUARMState *env, uint32_t desc, uint64_t ptr);
 uint64_t mte_check(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra);
@@ -1627,10 +1629,11 @@ static inline uint64_t address_with_allocation_tag(uint64_t ptr, int rtag)
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
@@ -1664,7 +1667,7 @@ static inline uint64_t useronly_maybe_clean_ptr(uint32_t desc, uint64_t ptr)
 {
 #ifdef CONFIG_USER_ONLY
     int64_t clean_ptr = sextract64(ptr, 0, 56);
-    if (tbi_check(desc, clean_ptr < 0)) {
+    if (tbi_or_mtx_check(desc, clean_ptr < 0)) {
         ptr = clean_ptr;
     }
 #endif
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index dd1f9c6dc6..9eef2f7e6d 100644
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
index 75c55b1a6d..e753124c4c 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -245,13 +245,14 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     uint64_t tcr = regime_tcr(env, mmu_idx);
     uint64_t hcr = arm_hcr_el2_eff(env);
     uint64_t sctlr;
-    int tbii, tbid;
+    int tbii, tbid, mtx;
 
     DP_TBFLAG_ANY(flags, AARCH64_STATE, 1);
 
     /* Get control bits for tagged addresses.  */
     tbid = aa64_va_parameter_tbi(tcr, mmu_idx);
     tbii = tbid & ~aa64_va_parameter_tbid(tcr, mmu_idx);
+    mtx = aa64_va_parameter_mtx(tcr, mmu_idx);
 
     DP_TBFLAG_A64(flags, TBII, tbii);
     DP_TBFLAG_A64(flags, TBID, tbid);
@@ -403,14 +404,14 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
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
@@ -436,7 +437,7 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
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
index ab5999c592..68684d1f87 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -680,7 +680,7 @@ void sme_ld1_mte(CPUARMState *env, void *za, uint64_t *vg,
     int bit55 = extract64(addr, 55, 1);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(mtedesc, bit55) ||
+    if (!tbi_or_mtx_check(mtedesc, bit55) ||
         tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
@@ -862,7 +862,7 @@ void sme_st1_mte(CPUARMState *env, void *za, uint64_t *vg, target_ulong addr,
     int bit55 = extract64(addr, 55, 1);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(mtedesc, bit55) ||
+    if (!tbi_or_mtx_check(mtedesc, bit55) ||
         tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 062d8881bd..c5e6d58a7e 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -6375,7 +6375,7 @@ void sve_ldN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
     int bit55 = extract64(addr, 55, 1);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(mtedesc, bit55) ||
+    if (!tbi_or_mtx_check(mtedesc, bit55) ||
         tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
@@ -6737,7 +6737,7 @@ void sve_ldnfff1_r_mte(CPUARMState *env, void *vg, target_ulong addr,
     int bit55 = extract64(addr, 55, 1);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(mtedesc, bit55) ||
+    if (!tbi_or_mtx_check(mtedesc, bit55) ||
         tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
@@ -6992,7 +6992,7 @@ void sve_stN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
     int bit55 = extract64(addr, 55, 1);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(mtedesc, bit55) ||
+    if (!tbi_or_mtx_check(mtedesc, bit55) ||
         tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }

-- 
2.54.0


