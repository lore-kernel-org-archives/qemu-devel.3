Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C38CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYi-0003fp-9d; Wed, 10 Jun 2026 12:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYe-0003Ct-A9
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:36 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYc-0006TG-3s
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:36 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490acbb0f89so47930775e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781108013; x=1781712813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iDPdEWHqioHS0+4B0OAcasCOaGgwox4adJImPH+v6jM=;
 b=Ii+s+QrssE0u27hr/QNtFASJAfFplvWO9OQv1E282idqGek4s0gpVnu2oJr0Xgx0Hu
 LQHtjX2Ou3KYTxg5nE4uPsPhUyqK4p3/V61bOr8xNU4miNZigcVuuIPsN82Z8lNVRn02
 EDFw64ANxv4roUc1v+4apwiV+XgBYuL5w6k8MVtfWLwgbv1nznQGzwfEdWkn4Xl1ydFI
 NmIfRr2LAyhKHzr9mC+Ng+ArvhmimDr+o9qbgBK/dhm0ZVhLHuT9mVlyip2mIyMvOMiJ
 Cij5uY2GYp0OLikaVXATB/igLhZ3GBy0+si1qY/qg2H773ZCLtEKAVbpRrTkJHxI60Og
 gOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781108013; x=1781712813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iDPdEWHqioHS0+4B0OAcasCOaGgwox4adJImPH+v6jM=;
 b=Gxl2XtNmukRBdP9pg0pqCrGZB9wGkbTv5ipQv5UBWIu0EoucYazdhJ8N6imeHFVuDd
 KSzC/roJkVwODRR9t9eoK3JtiMsfayG8m7ZN9o5xo37Bx4y9eNlBHNeTCF4BlirA02fb
 yltqvrcMyUWPDNTehUz3W3i4ZW+5YyGpKZ4S2tUJrK3yVc9VTwixrI8QZDSc1D5a2TUl
 pqr555H61Jxp3aXdRnI0qN5D/Zyp6xeEQ7R5gb1zGKM22E8ikZKcVzZOPE26NOHrW6Lv
 EdQW5J6CniaeYjFtI6+buLqaO/DFM9CAvMJOARKFzyq9e0HMg/Ymavd7wWoMiNMc4dpA
 XlQg==
X-Gm-Message-State: AOJu0YwL6JTtoJ18yv0ujMBgmUdBGniIqKjnCEM0L2JBvQnn5Mk/gODb
 RHWwTDsl5yhnrpEHlYJZhWnvvDEg08+dOdILCF9aVtmBa0kBWKA8IwkoW+cla72igKFp8ovUnoN
 na7Yi
X-Gm-Gg: Acq92OEiJzKkDSwYJq9C/RwroO/pnhiSYeW7pafJs/CrFywG5zz7x4cR19b0tYEXBl2
 ygaiSkTHJbZychicebfNQKCqmKqS8ADXDObK/C5ulMNZx9sb6gXC89vQpMa/bCMdmEB+jAq/jah
 ZPNxrbi0DAjUINLMGXzVWu0W/kCOTcj28hIHHBAv3ScdDFNjBi+Y9PQhTL77vrF+HS199hEbWYm
 ppYYlxlAPjeWytTdx0zlj+AQ9BzYBh+IYzVOK/V8ux/2Leg6wnir9Wr6ihNujXstJl0x9dIt+3r
 ZeUP8TnuEQIGo1aEQkI5nNDrAAaQbuzBE/sQaIxiQr7ZSbdhdOtxxiGmvQmba9R2cuiwNRukmfp
 EapvcRoA4XwKOfrRq0rDhZcBjSEOLTnhvyuq98PrAVNuvv03phFZabMzP7yePWQoM35NTrzVCzt
 p7ZoMIjg3o0JTN2uZSlrJjBIQXZ0LcUPRyBePIc85FfDDxlQd/SgbZRbyMM5ANjeS8lugdkajtQ
 qUHW57KcDWYQNqcCb9sfq5G2YP+rrM+vU5ozTFhbZxI4zn9UfxDYw==
X-Received: by 2002:a5d:4a4e:0:b0:452:75ca:3fab with SMTP id
 ffacd0b85a97d-4603063a3c1mr23859072f8f.38.1781108012592; 
 Wed, 10 Jun 2026 09:13:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 65/71] target/arm: Enable FEAT_FP8DOT2,
 FEAT_SSVE_FP8DOT2 for -cpu max
Date: Wed, 10 Jun 2026 17:11:56 +0100
Message-ID: <20260610161202.2235298-66-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-40-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 2 ++
 linux-user/aarch64/elfload.c  | 2 ++
 target/arm/tcg/cpu64.c        | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index f13721c327..0bcd707fc1 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -76,6 +76,7 @@ the following architecture extensions:
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
 - FEAT_FP8 (FP8 convert instructions)
+- FEAT_FP8DOT2 (FP8 2-way dot product to half-precision instructions)
 - FEAT_FP8DOT4 (FP8 4-way dot product to single-precision instructions)
 - FEAT_FP8FMA (FP8 multiply-accumulate to half-precision and single-precision instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
@@ -168,6 +169,7 @@ the following architecture extensions:
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SSVE_FP8DOT2 (SVE2 FP8 2-way dot product to half-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
 - FEAT_SVE (Scalable Vector Extension)
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index be33fede6b..d40e39169b 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -228,8 +228,10 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
                                ARM_HWCAP2_A64_F8E5M2);
     GET_FEATURE_ID(aa64_f8fma, ARM_HWCAP2_A64_F8FMA);
     GET_FEATURE_ID(aa64_f8dp4, ARM_HWCAP2_A64_F8DP4);
+    GET_FEATURE_ID(aa64_f8dp2, ARM_HWCAP2_A64_F8DP2);
     GET_FEATURE_ID(aa64_ssve_f8fma, ARM_HWCAP2_A64_SME_SF8FMA);
     GET_FEATURE_ID(aa64_ssve_f8dp4, ARM_HWCAP2_A64_SME_SF8DP4);
+    GET_FEATURE_ID(aa64_ssve_f8dp2, ARM_HWCAP2_A64_SME_SF8DP2);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 831b190b21..3d73977f1e 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1383,6 +1383,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* FEAT_SSVE_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
@@ -1403,6 +1404,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* FEAT_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
-- 
2.43.0


