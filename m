Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA0DFCA197
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vziep-00036y-Ld; Mon, 09 Mar 2026 18:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vzieh-00031M-CJ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:51 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vzief-0004X7-IT
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:51 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-79863ab8478so113964587b3.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 15:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773093648; x=1773698448; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O2wD4jjOup2pu4XAtQtAoP+ZT1vD3Nez690bv2gJQuc=;
 b=GOGUCpetvdCu0WZiVXE4G816QcgCX240nGmSbBsxP3i/OG8FYA0epfqyxy3ZsbZpCI
 6r9fL0a4xg+SyJbyu8+hmeSiKeilmqmPBjIpI9WEXcZ+rTySZRIwu6m6YqsOH0IKeTm3
 Y1MmJK30ZFxnbWvpawn5La0BOgpRTAW+bPKjZZgYWNT8F9JdvlYL6E2sgaqLYK6KQpkb
 lk3ZbK8kAFxu50S4UTGwt5FGgyWTBaO/6wlQ+TBlUvfC+oYM5a2Wawu4DTb+74FfFSmY
 UUWTUjvRxvzqNg88x7O4phsmISMGyG0lzXEZAAWgTRApxZuNOH9B+rX9ax42pENOuRQ3
 NxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773093648; x=1773698448;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=O2wD4jjOup2pu4XAtQtAoP+ZT1vD3Nez690bv2gJQuc=;
 b=bYIXEO5WTWmv/dPYubPjmQFgL5QdgKEl9NfflSvi6maNt0iLgJRpjPEKb1+NvjgI22
 /mlqidyqCCkraDyCyvRzDQWBJASYhgNzvPLCFt+xqx2OpIyyYsPqejreVAfEauSXA8e9
 32sEHW7Jg1Vr97AlclPITOglB5OEiN4aUH9swupP9sySADcZcwaavAAPuc7bvG6/tCnl
 riQrdyvA06EagRLUJujfHnVlDXoUZEA9QhzvlHmhjbwjUqWnIZujslurWCIxE2rNXu1f
 h2ntuiN2gOfGVY+URE8mdWkNici4edthQ4dqX+ozdraTbsxjwKbLapbRdoUNDjjbdHH5
 b84A==
X-Gm-Message-State: AOJu0YwnJswV0nPlXYGEQzvzJCzbq+J5zkfGrcyII1PJnkzbtly3tB63
 js1AvVZiAKf2PwjQkfI8wXF4e1LDh2O5rlC4tC9fEMAcJiKapXNGiwxF
X-Gm-Gg: ATEYQzx2oZFpMNRmAZiDo354ZhIkkI4MSyPRgSZ7rLqSoROsButTifB8ofXZiHwZ7Kh
 9aEe1WUJuCRmuz9OeaPF81M17AvoUktFXEJIRcyjQBS+VDEl5U4PUOXo9UXp7gB7upUgF9t11PE
 Bh0U4q4luzJMaITgMbjEhx7ngVoKgoC8yVHUAZ0scwGPJr1hj1wQZJh9dnkDJ4wKc6OWsUZKbt+
 1Oug/S2M9i3NLSZ5nbIgdPMVESLWipfKUKJWZ3Tk5p51ejqOMXSmh/GJp54SXHUHQGKHUZX8l4g
 wrRQgdu6u8juhGdziDw2XG8jR7t5fNp5gmYNNtltYHP9jFJPxHoesNx7VIK1vJIklTYqiwO9xcF
 rHRU9Sp+KMUZmPAcin6qkHlFqtf1/D9qjBC+S3Tfv+owxXX9ra2cplhbATIcIxRjA8lTodO90YF
 uN2xB5jhmNTt9D7DdafagP46WOKFezS2IXh7eDE8bJDA8OIA==
X-Received: by 2002:a05:690c:c4f1:b0:798:5333:ce0d with SMTP id
 00721157ae682-798dd6735a3mr121144487b3.4.1773093648151; 
 Mon, 09 Mar 2026 15:00:48 -0700 (PDT)
Received: from [172.26.74.149] ([185.213.193.97])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7990a54ba7csm5218437b3.19.2026.03.09.15.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 15:00:47 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 09 Mar 2026 17:59:37 -0400
Subject: [PATCH v4 05/13] target/arm: tag check emitted when MTX and not
 TBI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-feat-mte4-v4-5-daaf0375620d@gmail.com>
References: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
In-Reply-To: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773093641; l=7132;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=CvQdHFZlrw02ARvaH7I9xm2g7R5bSAJQDhaj0sc+Ih4=;
 b=yGlZLynh66TNZDUJR5znUhIZHxIrPzjrs1tfbSKKxy/VmG86dq4Xsiv87IMSL1QHtBFwEUK+q
 Z6FSmNE70+7Ce6ASZ1BHm8F2woOu+H0x92PNcZWyuQ/4eWvmy6f31YM
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=brookmangabriel@gmail.com; helo=mail-yw1-x112b.google.com
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
 target/arm/internals.h      | 10 +++++++++-
 target/arm/tcg/helper-a64.c |  9 +++++----
 target/arm/tcg/hflags.c     |  9 +++++----
 target/arm/tcg/mte_helper.c |  9 ++++++---
 5 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 987539524a..56858367fd 100644
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
index 8ec2750847..a45119caa2 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1411,6 +1411,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
                                    ARMMMUIdx mmu_idx, bool data,
                                    bool el1_is_aa32);
 
+int aa64_va_parameter_mtx(uint64_t tcr, ARMMMUIdx mmu_idx);
 int aa64_va_parameter_tbi(uint64_t tcr, ARMMMUIdx mmu_idx);
 int aa64_va_parameter_tbid(uint64_t tcr, ARMMMUIdx mmu_idx);
 int aa64_va_parameter_tcma(uint64_t tcr, ARMMMUIdx mmu_idx);
@@ -1546,7 +1547,8 @@ FIELD(MTEDESC, TBI,   4, 2)
 FIELD(MTEDESC, TCMA,  6, 2)
 FIELD(MTEDESC, WRITE, 8, 1)
 FIELD(MTEDESC, ALIGN, 9, 3)
-FIELD(MTEDESC, SIZEM1, 12, 32 - 12)  /* size - 1 */
+FIELD(MTEDESC, MTX,   12, 2)
+FIELD(MTEDESC, SIZEM1, 14, 32 - 14)  /* size - 1 */
 
 bool mte_probe(CPUARMState *env, uint32_t desc, uint64_t ptr);
 uint64_t mte_check(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra);
@@ -1622,6 +1624,12 @@ static inline bool tbi_check(uint32_t desc, int bit55)
     return (desc >> (R_MTEDESC_TBI_SHIFT + bit55)) & 1;
 }
 
+/* Return true if mtx bits mean that the access is canonically checked.  */
+static inline bool mtx_check(uint32_t desc, int bit55)
+{
+    return (desc >> (R_MTEDESC_MTX_SHIFT + bit55)) & 1;
+}
+
 /* Return true if tcma bits mean that the access is unchecked.  */
 static inline bool tcma_check(uint32_t desc, int bit55, int ptr_tag)
 {
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 2dec587d38..5f739d999c 100644
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
-     * tcma_check() returns true for "access unchecked".
+     * Note that tbi_check() and mtx_check() return true for "access checked",
+     * but tcma_check() returns true for "access unchecked".
      */
-    if (!tbi_check(desc, bit55)) {
+    if (!tbi_check(desc, bit55) && !mtx_check(desc, bit55)) {
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
index 4deec80208..1484087a19 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -819,8 +819,11 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
     bit55 = extract64(ptr, 55, 1);
     *fault = ptr;
 
-    /* If TBI is disabled, the access is unchecked, and ptr is not dirty. */
-    if (unlikely(!tbi_check(desc, bit55))) {
+    /*
+     * If TBI and MTX are disabled, the access is unchecked, and ptr is not
+     * dirty.
+     */
+    if (unlikely(!tbi_check(desc, bit55) && !mtx_check(desc, bit55))) {
         return -1;
     }
 
@@ -961,7 +964,7 @@ uint64_t HELPER(mte_check_zva)(CPUARMState *env, uint32_t desc, uint64_t ptr)
     bit55 = extract64(ptr, 55, 1);
 
     /* If TBI is disabled, the access is unchecked, and ptr is not dirty. */
-    if (unlikely(!tbi_check(desc, bit55))) {
+    if (unlikely(!tbi_check(desc, bit55) && !mtx_check(desc, bit55))) {
         return ptr;
     }
 

-- 
2.52.0


