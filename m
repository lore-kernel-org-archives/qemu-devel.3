Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D62CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY2F-0007lw-3E; Fri, 22 May 2026 18:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1L-0006qM-Dg
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:13 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1D-0002fG-2m
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:03 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b45cb89f7eso53327315ad.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487617; x=1780092417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HSbz0rz1Vzev+MKaGO1lYcCzTIBBWb6RJtlaZ74LNDs=;
 b=Dfeu6lCLMcy9nj9zrOr33IOCMCv6/RVzITnzOvsGNgCkv3pnl4++3tpMLPSfDC8QSs
 TEIIqNMFShtOo1e6RxPOwRry99908FUQBYcbi8OF29G1h9CjXDz4oV2iPGhP+BCCXob4
 zSpJ+nZyI6gdlwqyeNTm+hM5664k10KZcrFSbzhlKA1jUBHhLsK1yZvTreK6y//R02cb
 3db0em2iPFlUnEF8esg3liVGFS82jjYudQKCxotsxdU1MuDWCmZ76cmEYExCtdkRtWfq
 QxZfDkE0gREURl+981q1HzDOEV9s+FXjnA6zS8d2KaO3m+hGbmPNXyeMBRZxFSZqR6MP
 qFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487617; x=1780092417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HSbz0rz1Vzev+MKaGO1lYcCzTIBBWb6RJtlaZ74LNDs=;
 b=LDxco7phnEzXamvZXzO0YPcoYMnlMuad9+bnvYwr/sMes6AFolZ1TMMeowdmCrn+h/
 UJnAf7FDfuXzLLZEZdDDKt7GkDp2BPPFYo4sXlQalwoNWUFpndaIJguqgMjbpa8RFPkb
 Fh4nq+LstYxR805jlEmOrFtSppdlDlEo1mKDzOCXnG2mk18F0UM4ka/qVhlTvjzYdnYT
 O5tO6QiL2Crbhg+9iaZsIQkD3N0683AA732BMkGvtyEFGzFZd8xbsdC+jB22F9rp7y0M
 uDPcn8TQQVpM8ybPtGpy3xUmIDnsPYGPTN5DZ85F8wBarB+SLCqUasJypfIJ/LkgWSVy
 Ucww==
X-Gm-Message-State: AOJu0YyOLJqphNSmsLykp3sNIRyAZ6RLUZPBAEERLQSnZ/RhBxqLtE75
 hx/emt7WL1ej6GF00TomH4Xu0iqxmYWAUh44mviepH6PsBaM3X2eEOJgVII3bemY7mxbt3HT/ew
 OTycx
X-Gm-Gg: Acq92OEH+YTaaCQtFYWDw7g8Nm3kmxYyCGW/8PbhaMmFV/AUqYClhn9rtZBtCp4ysXd
 I/qoP3gURzrkITIov2Q21T78e9zeiu4VYIXX4vtv+3Jh6YRZ5vb2L0xZAX1UXWwiFg0KokqFxKm
 O0LDXdiFrPIBETLy+oMD5k8Y5SGMxWbDI34lKs1aZ4X/g3MDA5S2OVoXw95e5jRAIf4yNFUj6gI
 A/1bAt2Kqo1/wSsEkeFJ7I+Czcfci7qMk2BmnCoT4CODfpfz7LIAMPlE/FywWsUOrWqFhgW3GPC
 lbRTvhJGc57YfIkrA7y5lCcVfjTIR/389mnhur5WtRWpT0WxL5XxydjOr7xuzM2C5hvL6MHvLgZ
 Vih3bf/+N44h7FUb+80Pnj+JW/yjPIaf64/sxoWAt1luJEswS9gagVzSQMRwCc9ZhmleIY2MifJ
 hgTGj8bgUHZ6isAwYXvZSoSf0Wqm6K
X-Received: by 2002:a17:902:da88:b0:2b7:ca38:975f with SMTP id
 d9443c01a7336-2beb05b57c8mr59728445ad.23.1779487617396; 
 Fri, 22 May 2026 15:06:57 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56b7920sm27835745ad.21.2026.05.22.15.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:06:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 52/64] target/arm: Enable FEAT_FP8FMA,
 FEAT_SSVE_FP8FMA for -cpu max
Date: Fri, 22 May 2026 15:02:54 -0700
Message-ID: <20260522220306.235200-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c  | 2 ++
 target/arm/tcg/cpu64.c        | 2 ++
 docs/system/arm/emulation.rst | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 08ee5fd192..2fb43d51e1 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -225,6 +225,8 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_f8cvt, ARM_HWCAP2_A64_F8CVT |
                                ARM_HWCAP2_A64_F8E4M3 |
                                ARM_HWCAP2_A64_F8E5M2);
+    GET_FEATURE_ID(aa64_f8fma, ARM_HWCAP2_A64_F8FMA);
+    GET_FEATURE_ID(aa64_ssve_f8fma, ARM_HWCAP2_A64_SME_SF8FMA);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 90214a355a..93cd7ee1a6 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1377,6 +1377,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, BI32I32, 1);  /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, B16F32, 1);   /* FEAT_SME */
@@ -1395,6 +1396,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
     SET_IDREG(isar, ID_AA64FPFR0, t);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 9c82df136d..c7128f1cec 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -75,6 +75,7 @@ the following architecture extensions:
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
 - FEAT_FP8 (FP8 convert instructions)
+- FEAT_FP8FMA (FP8 multiply-accumulate to half-precision and single-precision instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
@@ -159,6 +160,7 @@ the following architecture extensions:
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
 - FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
-- 
2.43.0


