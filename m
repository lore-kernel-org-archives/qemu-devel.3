Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02E7CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYg-0003Ss-Kz; Wed, 10 Jun 2026 12:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYb-0002yM-C0
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:35 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYZ-0006Os-9n
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:32 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-45fd461e4a5so4870066f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781108009; x=1781712809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CsdapmLJLhWd2MDdk10cC2103vtPb24RpNzidwLXLgw=;
 b=ptzyekVE6dHKZrTpmjcTYAjoewWWwV32jDPSWDnwIprWK1N9uGJSvbDBkU8PR+1hUI
 akhSEAutkfZxY+E6RV4+/GyYL5VvTKmVQLtIrhtNt0IDYKw+lkUVVK2nu+8INOAIUB8I
 kWe/6k9ptfx76yRkzSD1f5kjWJp/LpWHD/JnndhM3TTPWob7F/s4dDKR0ZrZkzNh1XPE
 rEQ97j9e3w36Pj1tsa/qt3GNzWgBExWy7Y6hSnt/kDwste1zbONMq0cyuLZdcjzwcPOc
 MxiQI8TbXK/JQNs8OS5Bb7Cbp4lTfXgekLu+ZiojyvjlHSWGMgOb8dmGW/KQddDn81dR
 kzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781108009; x=1781712809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CsdapmLJLhWd2MDdk10cC2103vtPb24RpNzidwLXLgw=;
 b=SrA7XS9IcbU5lnTJpxzxVrwxyzpvbFz1+Oe8Gs1vfX06OFi4etM0SlpfqvznfQ8BRk
 tsKBDLZnoQ3OUvFAM4MA9jhOK2IYDr5/utaM4pg365MfyE09sbOyINIFVeDx52GwpliX
 ckmsOuRihvrZRzN8d1QiDfnB/chi82QshVpuWO3rCtylEV9F+8j17/54XghgjKcKoyma
 VaUUA1YHoLNB3aTFi1uLLT8Wn9BVlitkCyjO022ld50GZz9pnajFeBiDTjYPbrzmkjPa
 2qsYuUcXEPNnBqCQUIzzL4yfptq6lRn7Yy1l/RyNLIkE1coO8x2ZDpfpUgUEnZ8abnVV
 nl/Q==
X-Gm-Message-State: AOJu0Yz8QQct0qJ7Sf5O3UOjX6CeY0xfJehfvukaTre7c1yPjKMLeOmV
 cxXkVrJBppdw5rUCKpZNxK8WGGf+Mk9/khtLiYafoofTMr6v9fQsVXtA5ShhsUI8J4skHf5hViV
 P9Q5n
X-Gm-Gg: Acq92OEGDZtqJPvXqNXkb/5rzQQAYbjOqIaGlimeDoax7BI7KrpuN3Ly+GkliFPZ7aX
 2qvDTcZWuT6AxdVsVazW6h58Wl4PuLLypdai4qHhDeRrhWvxGFNHOtQzTYj/2WFrx7F1Hrz9bz0
 E7WNhomj/9hGamCpVlnFsFEKVHIMZN79VhVQykWe+8/8JFWbT7Jr7DV4NVNmP735ibsPhjM4ngP
 /wbfj1TOuFPiC/WFlMjAg7txRss9gVAEkpu6fg7qciWrTepmZlzdbvT508jg6mw+2N5IiHlhRLi
 gCUvqTnT9VmMm5vwNShtbSrrtVIoOLCRBWOCCbOeqVMNoY/c4yuvCNUtvm9VrTLOx1Xaqdi564S
 ArHbFaCqyrgqHAFvl7WUg6l6ayz64GAbTLqQ7N+P9hZxgWJ2lJhRLmIp31bMmfrp0QUmYP3wy3Q
 iLmW0BEC/bob7u8Vj14hAptqmkX9scnSe3xWeYh5R3UtsBhQ2FgkfHe7sToavP1Z22f7r31/ETb
 6pxlVlsBEVuQNSD7Nw5DM+r8Fm4RqZ158dZzo/dACA=
X-Received: by 2002:adf:f911:0:b0:460:24c1:db8 with SMTP id
 ffacd0b85a97d-46030777545mr32435528f8f.38.1781108008926; 
 Wed, 10 Jun 2026 09:13:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 62/71] target/arm: Enable FEAT_FP8DOT4,
 FEAT_SSVE_FP8DOT4 for -cpu max
Date: Wed, 10 Jun 2026 17:11:53 +0100
Message-ID: <20260610161202.2235298-63-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
Message-id: 20260609192110.752384-37-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 2 ++
 linux-user/aarch64/elfload.c  | 2 ++
 target/arm/tcg/cpu64.c        | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index e46f5fdcd1..f13721c327 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -76,6 +76,7 @@ the following architecture extensions:
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
 - FEAT_FP8 (FP8 convert instructions)
+- FEAT_FP8DOT4 (FP8 4-way dot product to single-precision instructions)
 - FEAT_FP8FMA (FP8 multiply-accumulate to half-precision and single-precision instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
@@ -167,6 +168,7 @@ the following architecture extensions:
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index a82d65a681..be33fede6b 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -227,7 +227,9 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
                                ARM_HWCAP2_A64_F8E4M3 |
                                ARM_HWCAP2_A64_F8E5M2);
     GET_FEATURE_ID(aa64_f8fma, ARM_HWCAP2_A64_F8FMA);
+    GET_FEATURE_ID(aa64_f8dp4, ARM_HWCAP2_A64_F8DP4);
     GET_FEATURE_ID(aa64_ssve_f8fma, ARM_HWCAP2_A64_SME_SF8FMA);
+    GET_FEATURE_ID(aa64_ssve_f8dp4, ARM_HWCAP2_A64_SME_SF8DP4);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 38c0f0eafd..831b190b21 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1383,6 +1383,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, BI32I32, 1);  /* FEAT_SME2 */
@@ -1402,6 +1403,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
     SET_IDREG(isar, ID_AA64FPFR0, t);
-- 
2.43.0


