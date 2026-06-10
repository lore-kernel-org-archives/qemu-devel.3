Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F31ACD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYh-0003VL-5M; Wed, 10 Jun 2026 12:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYZ-0002tt-Iw
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:31 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYV-0006II-Th
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490b12270b3so42010995e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781108005; x=1781712805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iV9BhUAkHyum6y/+0DZPA+Yoeu0JG4SEWLcnWiBX2uU=;
 b=gMcyMyYd+vDlYtIBPWlrPms4deHBwRaqQsxOwaKjYwklDQpW3GkktUEnH5tMfLLcQa
 7r2JVdSUsi8MDbnTLmfO73rZRiCWewbJpK1AP7ydAEwYZQsc1/TDTiqRvrGI7f1760w2
 bCqcnKQY2qroP2vrFwda3fsHh3H8vF4ljlkXjLphG7E9050Nh1npU5Y1OP2SflJbrgbj
 B9WyEa6rJlnZbpXbsXuOv+y5iOOGTgrbj3mdWCoIp44duhln7OId5u+a6pFquQyJiHDI
 eteqwwko5t8wVhSqD3E9YkgG30ZChob6TIv1PoMGSh5Pn02aRNQ23By168JS5ig94YJj
 r0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781108005; x=1781712805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iV9BhUAkHyum6y/+0DZPA+Yoeu0JG4SEWLcnWiBX2uU=;
 b=kYu0Etrhb+H6ljHRCQEN585mroL3b1yMZRbkg0jeXUozP8MlL9uReD4ikp+E2M8Jk0
 PaHC8V/lfT4jo0Q+6SJ0FJKeP2nPka2kid91C30mvE6D5aTVPqP2srzlvhhPF/QpRCgD
 z023HR2dgaDk5F0H+vkX7toGs87DJwIT06Dk8/fQsXf/hBCcozdkjP35MJKiw1ItKN1q
 +k9IjkZ1Vd8o4P/E/tSrF4PFXB9aThkMRTG+DSAgmokcjsItuikue8eaIu4CWDe1sisU
 umKBbBH6oUz+xu3RNScaOgiSJq/WBKIZ+4yXBlZDaqW83s/BE3SolYRlJ/nH4N6VDNd6
 uUoA==
X-Gm-Message-State: AOJu0YycCXur93/EuwwIe4aAZ/X15cjjjvphz6M1DX2ZrivHlVaZUWLR
 jWg8XlbQlLRKHuLNAT7RQ/mixq/jHX5cFjTKBLmhxiLn+M0ha7AF87loK54aJpScD+GsuWKzgbD
 j5cfN
X-Gm-Gg: Acq92OHWLfwD5TWdispVY5UW4DucWlCwqfzaoQBuayETIRj6ciGMHl35pDgst278DNR
 8aEGnlGBNpwRFeIgY/6xusOYGTUv/MgvBym8dAYdmZfW0odkvkSp6ITynwDXKL5UUOcvhWVvWfw
 LvFzVsmkrSC0h7PHl0ZG/bUuAQLyy2dpNpZb8g98H8oafh2ATWutexd+qFGn7yW9cP88PJSgCAP
 AvWynZNog6Eo+JAffuPr/VeSvQciYcvE2VxfOvma63zyOKE+uOyL7DirugkLNQI0QEQ/CSoT5an
 EltrGp2+bINYvGvVdlXtacwp8OM71n3lGCe13eJBr7cZuX4b1iqt1QoAq45UfomVYBh4y/4wZ5t
 aupn0k6ztnIRs1gozaKFNj9Fi4mEaqfWgPkBE8ZtGtC7nbcXtselowxOzU/4gseImLaUFeeFMY/
 G+COORvXodvRZVpgt2t3Vb//5MQqFhSNn2g3U3t3HA4WzWOIIduALYCwaz30JGgwlRTPbRBsK+Y
 mz9+PcAyfrRI//z1Hn11pOSU1E7XuhUCuHUCg7gxTA=
X-Received: by 2002:a05:600c:3515:b0:490:b5d0:598e with SMTP id
 5b1f17b1804b1-490c2604783mr393476155e9.21.1781108004830; 
 Wed, 10 Jun 2026 09:13:24 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 59/71] target/arm: Enable FEAT_FP8FMA,
 FEAT_SSVE_FP8FMA for -cpu max
Date: Wed, 10 Jun 2026 17:11:50 +0100
Message-ID: <20260610161202.2235298-60-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
Message-id: 20260609192110.752384-34-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 2 ++
 linux-user/aarch64/elfload.c  | 2 ++
 target/arm/tcg/cpu64.c        | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 9ff4473154..e46f5fdcd1 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -76,6 +76,7 @@ the following architecture extensions:
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
 - FEAT_FP8 (FP8 convert instructions)
+- FEAT_FP8FMA (FP8 multiply-accumulate to half-precision and single-precision instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
@@ -166,6 +167,7 @@ the following architecture extensions:
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
 - FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 06c14e82ea..a82d65a681 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -226,6 +226,8 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_f8cvt, ARM_HWCAP2_A64_F8CVT |
                                ARM_HWCAP2_A64_F8E4M3 |
                                ARM_HWCAP2_A64_F8E5M2);
+    GET_FEATURE_ID(aa64_f8fma, ARM_HWCAP2_A64_F8FMA);
+    GET_FEATURE_ID(aa64_ssve_f8fma, ARM_HWCAP2_A64_SME_SF8FMA);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 7f79ee645b..38c0f0eafd 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1383,6 +1383,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, BI32I32, 1);  /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, B16F32, 1);   /* FEAT_SME */
@@ -1401,6 +1402,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
     SET_IDREG(isar, ID_AA64FPFR0, t);
 
-- 
2.43.0


