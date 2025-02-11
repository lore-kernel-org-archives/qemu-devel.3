Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AEDC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht5V-0006SO-3N; Tue, 11 Feb 2025 11:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5N-0006Pb-Vj
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:10 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5M-00034B-4M
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:09 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4394a823036so17351885e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291167; x=1739895967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yFFYGk2z6wncJvqMPz/0PChB0KSd0ypiZMRnDwsxBYI=;
 b=icpvYeFV1kowMT4TJE2oAU/lmyoNTNzil5qQhahMlngUwQsAAU7xswBxpdpCtxS9+4
 Y0cn+MHzEG86BBhfVKy0oDsgy8/qqW6TTQ00dXx5ThX7VQsUW+jc/m9vi5CuvmfRWG8B
 728Oy6xJBIKpgN8LBDx13/VjPVjc4BszVLOvDxN1setON1JwXaPwNZ0zIh5D2NK9YkFk
 2ZSIJxCclAeNFCoSATwGkMRdHG9DodGbMZAEK2fgoEtrDvDeTHlQPInQ6N6ExefzLxca
 W+LzQuEdjkre3Tq8HuBbLOUId50bYYPC1u4FIrmYohBZMqW1Sviuj078u5DeV6AwerkC
 Kp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291167; x=1739895967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yFFYGk2z6wncJvqMPz/0PChB0KSd0ypiZMRnDwsxBYI=;
 b=IBOAcBquvnZcYEcpVtRQKvUzuyci+EHvGvwSERJZSwNOz88YZ6pMhq29wpoyBI+Its
 QlhDrWFuzQakMG2B9gzLnWqwI+HQpnckFTUj9bisDafUgfiz96w6lKeGaYVQ6Wwmy/zb
 gH6Rfx2Uo5spDCJoPstlNjGjHyhNKkI1vzGx9AC1sFCb3JZC4EnXbJW2OBtSvaYkR1+Q
 mxFkN3sVs9Pax+X7mQHIEZ0OY7QHt/Nw0ZHof/B4ZiB2/PjLkaxFs9m0vVeAhXw+ldx+
 GaUoyiruGb/XNgsj74laNwqKx1/lAjXCZTa4I9sVWyvoZLK21GuZ4Mr1jZzsOe8dEAk/
 n66Q==
X-Gm-Message-State: AOJu0YwD8BX/0NU7YQ/fnecMWjWOE0TPm6x3bnxR7kx4KVzYkbf5uvnt
 dphpxOBMHkxixsZbGTCd5w75gmuL4o7JGIGpD6vFxhi0qWk80Q0PPcKIark6sSu7hsnmd0iwUIS
 w
X-Gm-Gg: ASbGncuhPG7IJmIqGx42L7XPwigfoMd3Zr2hoGj1etAveM9Vigh069ungj58B9fNksm
 5veVeT5ihjzRHiD9FFMqlnr1ZLDwgj5qNZ6ks2o7/wrrnAgZa7Gy5cIUC49LHGvDzBmezrrSXLL
 sNUjwNQqZal8aLYK7FEkdXG6wEog+5i8xTx94hFJn2stqMaOC09QdOjiFTvn+4ANDvf/IFTWRry
 TIAz/hmKgzFzEQqzVF5fjB2+AUIQiVsleZqxW04qhgh4yhk+v14xAW24oCaU0dpFK8+QS4JzT6K
 lGYU2958n1P6ph1Hm9Ov
X-Google-Smtp-Source: AGHT+IHcMuOWlOGV7BeEdxEI+KqujNH3OcI52ZVr4ubsWymI/ruwTfFW14E3SFr3rs2vNh05C/+Sdg==
X-Received: by 2002:a05:600c:8410:b0:439:5512:ba0d with SMTP id
 5b1f17b1804b1-4395512bd2emr27454245e9.24.1739291166538; 
 Tue, 11 Feb 2025 08:26:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/68] target/arm: Add FPCR.AH to tbflags
Date: Tue, 11 Feb 2025 16:24:55 +0000
Message-Id: <20250211162554.4135349-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

We are going to need to generate different code in some cases when
FPCR.AH is 1.  For example:
 * Floating point neg and abs must not flip the sign bit of NaNs
 * some insns (FRECPE, FRECPS, FRECPX, FRSQRTE, FRSQRTS, and various
   BFCVT and BFM bfloat16 ops) need to use a different float_status
   to the usual one

Encode FPCR.AH into the A64 tbflags, so we can refer to it at
translate time.

Because we now have a bit in FPCR that affects codegen, we can't mark
the AArch64 FPCR register as being SUPPRESS_TB_END any more; writes
to it will now end the TB and trigger a regeneration of hflags.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               | 1 +
 target/arm/tcg/translate.h     | 2 ++
 target/arm/helper.c            | 2 +-
 target/arm/tcg/hflags.c        | 4 ++++
 target/arm/tcg/translate-a64.c | 1 +
 5 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1c91b1f50f2..a71f848cc51 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3198,6 +3198,7 @@ FIELD(TBFLAG_A64, NV2, 34, 1)
 FIELD(TBFLAG_A64, NV2_MEM_E20, 35, 1)
 /* Set if FEAT_NV2 RAM accesses are big-endian */
 FIELD(TBFLAG_A64, NV2_MEM_BE, 36, 1)
+FIELD(TBFLAG_A64, AH, 37, 1)   /* FPCR.AH */
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 084ee63d990..1fc4fdd7794 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -155,6 +155,8 @@ typedef struct DisasContext {
     bool nv2_mem_e20;
     /* True if NV2 enabled and NV2 RAM accesses are big-endian */
     bool nv2_mem_be;
+    /* True if FPCR.AH is 1 (alternate floating point handling) */
+    bool fpcr_ah;
     /*
      * >= 0, a copy of PSTATE.BTYPE, which will be 0 without v8.5-BTI.
      *  < 0, set by the current instruction.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 40bdfc851a5..7d95eae9971 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4848,7 +4848,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .writefn = aa64_daif_write, .resetfn = arm_cp_reset_ignore },
     { .name = "FPCR", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .opc2 = 0, .crn = 4, .crm = 4,
-      .access = PL0_RW, .type = ARM_CP_FPU | ARM_CP_SUPPRESS_TB_END,
+      .access = PL0_RW, .type = ARM_CP_FPU,
       .readfn = aa64_fpcr_read, .writefn = aa64_fpcr_write },
     { .name = "FPSR", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .opc2 = 1, .crn = 4, .crm = 4,
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index f03977b4b00..b3a78564ec1 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -404,6 +404,10 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         DP_TBFLAG_A64(flags, TCMA, aa64_va_parameter_tcma(tcr, mmu_idx));
     }
 
+    if (env->vfp.fpcr & FPCR_AH) {
+        DP_TBFLAG_A64(flags, AH, 1);
+    }
+
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
 }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d6ac2ed418a..be3f4489e5e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9655,6 +9655,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->nv2 = EX_TBFLAG_A64(tb_flags, NV2);
     dc->nv2_mem_e20 = EX_TBFLAG_A64(tb_flags, NV2_MEM_E20);
     dc->nv2_mem_be = EX_TBFLAG_A64(tb_flags, NV2_MEM_BE);
+    dc->fpcr_ah = EX_TBFLAG_A64(tb_flags, AH);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.34.1


