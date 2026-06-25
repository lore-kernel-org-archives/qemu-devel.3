Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24434CDE00C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcsr7-0006e7-1N; Thu, 25 Jun 2026 18:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcsr2-0006a3-HY
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:47:30 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcsr0-0005zq-QO
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:47:28 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-37e0d09be07so228688a91.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 15:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782427645; x=1783032445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xAFphcdMcc4nMg6ZvlPlH0PadArCbX+n0WGGKJ8VtZY=;
 b=eLSBnmSfFftejt4DwznZ9PxpilUpKdvktQa7H3JqdnbOuZe3LfoVgwjhkWvV59sU7M
 TotslOJeSki6zhHu2M0pk8qk2MYeTn4545jfFDrx9tH1I7CwdBfU3zOjj8FkdCxtK+db
 EA3kGXmRk9UHXpYsFON9oVzdJWlCtitY4w36TK3Ke4/LTKJHhvWMi6Loj168ZwRHyw7A
 hXknD9QdcK+lhCA6I5TCStPFVpQpjNdif468/gz5lYBobnr9jS/X/hWlkUkqXoOVBF2W
 Hrm5wiU5FPkrOB6+AaFU36skmJgHU3+q++z5umZjsE65Os7cdOLkBWhwgwFNfEmx6J6f
 7tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782427645; x=1783032445;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xAFphcdMcc4nMg6ZvlPlH0PadArCbX+n0WGGKJ8VtZY=;
 b=aLb11XWMLOISx4jhswDYROcuA1sAfe5vSp24XYstcUumHVDLAVbWIPQyERN/FLHaKh
 CLVB0zp/1Un+yKBDM1ywEbPfrQA0HMCzI+hr6rKCMI0SInSUP/9o6p2r6hbcbX9s8zb6
 kJbmaRlwdglu+y6ww7qDsCuL6R7XDNH0GanfQiums3va0JCY8IIqyhEvn4UW92ABnOWt
 qCOM11obYuMDZrkMRRVdeo/s3bsq9Q0xWxYRouBfSLROxKiK90iwR5rOc0HUoedfJBeb
 aX2kr3LCtSFdFcTTTAhD6skt9UUy4Li9wonbsBvi4svb4si/GMsHDg9Ej/fq+3Uf0wi7
 TFMw==
X-Gm-Message-State: AOJu0YxteYRB0frjLhv65ksKaRQUOwD0l4h51vADJrhx6K9Ym+untsN4
 SJQaqrz88fr3oB+ow34WMphbUaF5FuT/XtwMD1xSLJl/dh+67ViA6sgaKGTJViZqaSLjjYBjT24
 8Lw+J
X-Gm-Gg: AfdE7cnNqTca+kK6Hdgu7/Ab+Vk4AcskVBPs5POmWHu9kCJl2DUy+Qv4C+CnaFiB2Xc
 C4k1RNThu93UNnrhg3QVKEuhWBRXAgL8kZNr3GcSULA39X2Nw9cuB+BiTzz/gLabUp4eVtHbCnr
 IuPJIkAcDlX+cZjuognA03Yb6ckBSIgcqscHzEGNw8hAtw33JcxaDTFXs2QxSI3F2v+cQds5vJG
 +sC0J50h1VyllI5bBCWauPPzPKuxdG0cnIA+Po83eMN4s6E1AGL3GOs/JPylA8u/mQ9Feg0YhFy
 Waf4Tx/ora06FLf+QqumxxAFCJz5BhHzixI/7bTQ2Y9DvZyawOp4fMzWuRKIzToErCGETTPu/If
 JxOf/g6Cg7b+9HVkVTL2JI6fYfc3heTXLrX6GjBnGnLyndDz1M2jNtG4aQu8xAhh4rSiqsqngy8
 44dL4G7ekj7EwbO0HZGHF2ElH6TpDFiGNeAomlJxyczzReCDFzQg==
X-Received: by 2002:a17:90b:1fc4:b0:36d:63cb:cf63 with SMTP id
 98e67ed59e1d1-37dfa2551b9mr4278523a91.20.1782427644959; 
 Thu, 25 Jun 2026 15:47:24 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37df400ba0bsm2762834a91.15.2026.06.25.15.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:47:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH] target/arm: Implement and enable FEAT_SSVE_FEXPA for -cpu max
Date: Thu, 25 Jun 2026 15:47:23 -0700
Message-ID: <20260625224723.766270-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      | 5 +++++
 linux-user/aarch64/elfload.c   | 1 +
 target/arm/tcg/cpu64.c         | 1 +
 target/arm/tcg/translate-sve.c | 2 +-
 docs/system/arm/emulation.rst  | 1 +
 5 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index c3eeecbea9..bdeb72bd77 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1580,6 +1580,11 @@ static inline bool isar_feature_aa64_sme_mop4(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SMOP4);
 }
 
+static inline bool isar_feature_aa64_ssve_fexpa(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SFEXPA);
+}
+
 static inline bool isar_feature_aa64_ssve_aes(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, AES);
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 9b93969850..cea286cce0 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -174,6 +174,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_f8mm8, ARM_HWCAP_A64_F8MM8);
     GET_FEATURE_ID(aa64_f8mm4, ARM_HWCAP_A64_F8MM4);
     GET_FEATURE_ID(aa64_ssve_aes, ARM_HWCAP_A64_SME_AES);
+    GET_FEATURE_ID(aa64_ssve_fexpa, ARM_HWCAP_A64_SME_SFEXPA);
     GET_FEATURE_ID(aa64_sme_mop4, ARM_HWCAP_A64_SME_SMOP4);
     GET_FEATURE_ID(aa64_sve2p2, ARM_HWCAP_A64_SVE2P2);
 
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 2cf335c956..7151c509f9 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1384,6 +1384,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
     t = FIELD_DP64(t, ID_AA64SMFR0, SMOP4, 1);    /* FEAT_SME_MOP4 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SFEXPA, 1);   /* FEAT_SSVE_FEXPA */
     t = FIELD_DP64(t, ID_AA64SMFR0, AES, 1);      /* FEAT_SSVE_AES */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* FEAT_SSVE_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 79e8e16b24..5de9ee7d4f 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -1373,7 +1373,7 @@ static gen_helper_gvec_2 * const fexpa_fns[4] = {
     NULL,                   gen_helper_sve_fexpa_h,
     gen_helper_sve_fexpa_s, gen_helper_sve_fexpa_d,
 };
-TRANS_FEAT_NONSTREAMING(FEXPA, aa64_sve, gen_gvec_ool_zz,
+TRANS_FEAT_STREAMING_IF(FEXPA, aa64_sve, aa64_ssve_fexpa, gen_gvec_ool_zz,
                         fexpa_fns[a->esz], a->rd, a->rn, s->fpcr_ah)
 
 static gen_helper_gvec_3 * const ftssel_fns[4] = {
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 3ef5b53e8a..a12471aafe 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -175,6 +175,7 @@ the following architecture extensions:
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
 - FEAT_SME_MOP4 (Quarter-tile outer product instructions)
 - FEAT_SSVE_AES (Streaming SVE Mode Advanced Encryption Standard and 128-bit polynomial multiply long instructions)
+- FEAT_SSVE_FEXPA (Streaming FEXPA instruction)
 - FEAT_SSVE_FP8DOT2 (SVE2 FP8 2-way dot product to half-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
-- 
2.43.0


