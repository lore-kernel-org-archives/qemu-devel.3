Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAD2CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUfG-0007bZ-Kb; Tue, 29 Sep 2026 06:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfB-0007VP-Vd
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:18 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUf9-0008E1-T6
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:17 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d3920so29747055e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676134; x=1791280934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IUgvG5wXyuxPwvGGjWMik6bOpv8TU6Nj/fKQdsvfpEg=;
 b=e6fpmGjdQVIpLNvm/lP/sIH04NQRvMHHQW8j92CLJk1OLKNmOMEcq56vo7I3jnWxE+
 cikEYhsDHEsF6398kRrSzBR6LTcNLvhAyzJ97RWHo5uEg/lt+nReAEDRtAV8KrGSiowj
 ZVFpmylCDcDIkTX95xezhYKMjzKDJ90eb12GI7xDE4PPYRYW4TUP6s5tLZ4y02ER4kDB
 qwkgF2UZI+/Retrw/NWdVsmfjl+6RB4Ju++nThwvoNPRWyJqOBjzRGiv/i5dhCf69kqP
 TgLkwCGC2LUimPCHXhU7ACvGwnn6xu/doFb0KwM4Hi5RAx4IbobKCN7rNrvsJTVEObYs
 nc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676134; x=1791280934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IUgvG5wXyuxPwvGGjWMik6bOpv8TU6Nj/fKQdsvfpEg=;
 b=WdL/Z2BdF/sXkwjVmNUI5iSjECL39QJ1JLMq3zHX1JBiAHf1j9IB+L5UQ4/Y6dRC32
 GlW4OOZb8qcP631J1IZD2qlphtDSsXDt0j7Bt8vNxhT0O3WLeNRXULrYbVLMRzySCi66
 XM599dJPhG83Mnz+O09yIc7y62BT8A7JIYqyuHrFQdvWTkQiNQST3/eyRf5UUhvDGQOo
 F3YNJsEM0V3XQl4Q0ePHUR90CGyCXX/ao//RA/AAnz8Iabw9D30qHo/IYR2f01PUaNLh
 OTOCeKTqVO5kZClTf9Rzbs1MPHw9QX+hP+P98roz94xNgi+jAFj0rh+oSA8LXGYTo3Xe
 CbHg==
X-Gm-Message-State: AFuF++m7Bo1+h/4VQfFSG3B6fyjqp+ytYFdXBw5G0FV9tgjAj04O1adN
 xcAaeop6ONvGcr4E7wf+iv5R1pTsaB5U5lGYAbx7brqefCtMMWK26v4M5kH6zDm45TvfITLR19o
 oVY0u
X-Gm-Gg: AYBFou3drShsywZVKCnHTQZSbyXLtY73NSc3ExgZ3MahkSz9EpkmWG7Ernthxn2zSe+
 0HeepgBeTdVQ9FkMySiqODLRpscsxv1U/pM2uOeMp157PwuhkBOSnYOdB8hQPlJlnx1dQ8TVdco
 6455/VJtilKOtJaygy3OrQ84++JUYk5kjYdOoZ2pndeMNbmxiQIrsowMEMDkxSfaduQ9zdTX4TN
 oxMGQgWZyB0Ts4pTvV9mcP1g26802m0loOEegkn9ck3fQHiNe5jtxfurg7c567CMaI8ydGWMHvB
 fTH9hBL1eBzM+gaZ9IxT8Kl0ByVutr4NdGFGcYYi4/4SS4ebuWRbeH8ndGc3kTfqb4KlnTUWf4h
 vgy6X4CAF2mp0NOaLwqEhEGUWvG/FOgZ8QVd2p6WM/fN6Z1DMW8BPaXleYegSJKBo++V3BBCytU
 LP+d4Rk7f3L8zunBncyQZ2NxILz3c6cvKHIUjUivAx9CP+cgbB22Sf8zXJLQC4ylo3SAYHaHxIT
 hTPOiTKQ2TmjPzhPoDAfpXjYSdATcyOT30ccpSEOWjt7Eoi87BYgRnQwAlEQfgxfEwW/2S7euR9
 zyto
X-Received: by 2002:a05:600c:198a:b0:49f:fbf1:3f7e with SMTP id
 5b1f17b1804b1-49ffbf13ffbmr144775065e9.9.1790676133889; 
 Tue, 29 Sep 2026 03:02:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.02.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:02:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/37] target/arm: Split out rebuild_hflags_common_aprofile
Date: Tue, 29 Sep 2026 11:01:19 +0100
Message-ID: <20260929100133.2598676-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Richard Henderson <richard.henderson@linaro.org>

Alignment, FGT, and IL are common to a32 and a64, though the
latter comes from different places.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260925215004.456336-4-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/hflags.c | 65 +++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 35 deletions(-)

diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index eb1aff91d5f..8da02ae1ecf 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -114,6 +114,24 @@ static void rebuild_hflags_common_32(CPUARMTBFlags *flags, CPUARMState *env)
     DP_TBFLAG_A32(*flags, NS, !access_secure_reg(env));
 }
 
+static void rebuild_hflags_common_aprofile(CPUARMTBFlags *flags,
+                                           CPUARMState *env, int el,
+                                           uint64_t sctlr, bool il)
+{
+    if (il) {
+        DP_TBFLAG_ANY(*flags, PSTATE__IL, 1);
+    }
+    if (aprofile_require_alignment(env, el, sctlr)) {
+        DP_TBFLAG_ANY(*flags, ALIGN_MEM, 1);
+    }
+    if (arm_fgt_active(env, el)) {
+        DP_TBFLAG_ANY(*flags, FGT_ACTIVE, 1);
+        if (fgt_svc(env, el)) {
+            DP_TBFLAG_ANY(*flags, FGT_SVC, 1);
+        }
+    }
+}
+
 static CPUARMTBFlags rebuild_hflags_m32(CPUARMState *env, int fp_el,
                                         ARMMMUIdx mmu_idx)
 {
@@ -284,9 +302,8 @@ static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
 
     el = arm_current_el(env);
     sctlr = arm_sctlr(env, el);
-    if (aprofile_require_alignment(env, el, sctlr)) {
-        DP_TBFLAG_ANY(flags, ALIGN_MEM, 1);
-    }
+    rebuild_hflags_common_aprofile(&flags, env, el, sctlr,
+                                   env->uncached_cpsr & CPSR_IL);
 
     if (arm_el_is_aa64(env, 1)) {
         DP_TBFLAG_A32(flags, VFPEN, 1);
@@ -297,17 +314,6 @@ static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
         DP_TBFLAG_A32(flags, HSTR_ACTIVE, 1);
     }
 
-    if (arm_fgt_active(env, el)) {
-        DP_TBFLAG_ANY(flags, FGT_ACTIVE, 1);
-        if (fgt_svc(env, el)) {
-            DP_TBFLAG_ANY(flags, FGT_SVC, 1);
-        }
-    }
-
-    if (env->uncached_cpsr & CPSR_IL) {
-        DP_TBFLAG_ANY(flags, PSTATE__IL, 1);
-    }
-
     /*
      * The SME exception we are testing for is raised via
      * AArch64.CheckFPAdvSIMDEnabled(), as called from
@@ -397,14 +403,17 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
 {
     CPUARMTBFlags flags = rebuild_hflags_common(env, fp_el, mmu_idx);
     ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
-    uint64_t tcr = regime_tcr(env, mmu_idx);
-    uint64_t hcr = arm_hcr_el2_eff(env);
-    uint64_t sctlr;
+    uint64_t sctlr = regime_sctlr(env, stage1);
+    uint64_t tcr, hcr;
     int tbii, tbid, mtx;
 
+    rebuild_hflags_common_aprofile(&flags, env, el, sctlr,
+                                   env->pstate & PSTATE_IL);
+
     DP_TBFLAG_ANY(flags, AARCH64_STATE, 1);
 
     /* Get control bits for tagged addresses.  */
+    tcr = regime_tcr(env, mmu_idx);
     tbid = aa64_va_parameter_tbi(tcr, mmu_idx);
     tbii = tbid & ~aa64_va_parameter_tbid(tcr, mmu_idx);
     mtx = cpu_isar_feature(aa64_mte_mtx, env_archcpu(env)) ?
@@ -415,6 +424,7 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     DP_TBFLAG_A64(flags, TBID, tbid);
 
     /* E2H is used by both VHE and NV2. */
+    hcr = arm_hcr_el2_eff(env);
     if (hcr & HCR_E2H) {
         DP_TBFLAG_A64(flags, E2H, 1);
     }
@@ -465,12 +475,6 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
     }
 
-    sctlr = regime_sctlr(env, stage1);
-
-    if (aprofile_require_alignment(env, el, sctlr)) {
-        DP_TBFLAG_ANY(flags, ALIGN_MEM, 1);
-    }
-
     if (arm_cpu_data_is_big_endian_a64(el, sctlr)) {
         DP_TBFLAG_ANY(flags, BE_DATA, 1);
     }
@@ -525,18 +529,9 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
     }
 
-    if (env->pstate & PSTATE_IL) {
-        DP_TBFLAG_ANY(flags, PSTATE__IL, 1);
-    }
-
-    if (arm_fgt_active(env, el)) {
-        DP_TBFLAG_ANY(flags, FGT_ACTIVE, 1);
-        if (FIELD_EX64(env->cp15.fgt_exec[FGTREG_HFGITR], HFGITR_EL2, ERET)) {
-            DP_TBFLAG_A64(flags, TRAP_ERET, 1);
-        }
-        if (fgt_svc(env, el)) {
-            DP_TBFLAG_ANY(flags, FGT_SVC, 1);
-        }
+    if (EX_TBFLAG_ANY(flags, FGT_ACTIVE) &&
+        FIELD_EX64(env->cp15.fgt_exec[FGTREG_HFGITR], HFGITR_EL2, ERET)) {
+        DP_TBFLAG_A64(flags, TRAP_ERET, 1);
     }
 
     /*
-- 
2.43.0


