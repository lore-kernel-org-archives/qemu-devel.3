Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6367DCD98FA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 04:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa4Ap-0005u5-8i; Thu, 18 Jun 2026 00:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa4AB-0005Wc-NU
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:15:37 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa4A9-0005dO-8H
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:15:35 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2c6bb8a5980so3502135ad.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 21:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781756132; x=1782360932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUNjCEnZVPJxl7l4Mb3NlRKiXdWTuIzMooDXzb9Pf7o=;
 b=tXH/W5RbgPnZWS4urOh8SxqJRuwHyCf1je+UrQhoiGabopdR/5k8zSW5m73OyzZVcQ
 6T1h5XExbzLAFPm2GjGP3Bz64g7XlVL3blkrz02/860cjtDzmdNsOcKCcYxw6yOpsNrI
 l9EOYzPPAZuIJ2u1ZCyCPM86wZXsAWMBSns41Lm/kh3khNMhQoYLlJDkhKp+NS3gJvnX
 9mMINJCXBqJxndNpCaeRuEqb+N7993pobk3M4eoSSktbpM5gK5AeHEEZk58yA8ANXazR
 e1Wb5ngpornUF2grCAdfjMMycycMoX5HtR75KaxHDMSgY4M2tWmY0Ev7/109uJSmbw9x
 BVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781756132; x=1782360932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QUNjCEnZVPJxl7l4Mb3NlRKiXdWTuIzMooDXzb9Pf7o=;
 b=d2pc3avWEAtuyq6Tu3IWs6D1IdBVhqygKHX2y365nDVNz5YzZzFxdUblBtftQJfWI4
 o727WOl4BGJzh80iX01KKMDPYNqDsyYQQtGwdRIZ//azhmvBreYbWYH0RS11gQaofIC+
 3MfvU//KUCBs4SFJC7putOIFRjdScKvggyJpssXZ+TOBUmjrRYn5JiiOR3xq0p1Hv5I8
 8/qKpWIEOJ2xKrDuiTcUyiaWwZhAh70jYrNSPBPfnb9GGrfZ1oqL8fpZNpaz8AbAczPr
 eXFdtTX1ZnVAO4aV5+7McR6fEzWmSRRCkCdlfP6NcZxN/k93PAyI5zOpqTifuXoddtPB
 wdUw==
X-Gm-Message-State: AOJu0YxmtIiScSaYl3FarhHo7nYXxEjm4eiiUa/B8dtPSNBGu8azjmVq
 uFNWD9GhJL03XRxPGgXfDZCWoBmkN8n451xqXz3nOXXie9gB8Jx+9290e/mv+YHp8MH0lJaOvEP
 0S8LO
X-Gm-Gg: Acq92OFzmuVtlN0meXgjs3mrb0f5wlAvStnBT+ULjl3TZ/VoIP2pYkd5EFKGxe63NsF
 Wuhi/zl8kazoxJvZB3hrx+G63gb93v/12UuzL7suNpvTVOuakxoBre9DPypp8bjDtEgeF9gLFRW
 crov2MwmgQmw1v/KzBBy47uEh6hbPF7aXQhcJDTkebY2tUgDPT1fIpqM2bOAiwgD52LdeYWCuiB
 LtZgTbizaSbOBP405Wpw/8NverJ7hDHdtIKuG+H4B7CEYR1vzSi/bVi/NaJaFkZPf3OTeDLhpkl
 pZ1QJZNFSgaahUWDwYYmK4XZil/3q8SL+EAAzDGXJM6Ixp5u+WR+XXg8iYwc/pldglN0TIhWUO0
 AMZOlEhykSJj7rQPLEXh1hDWSL9Eg2bBMzpTDTM0C4ukivsktaAmxd03M/aPQlWfpOSJqsq8uDB
 y9tL21ogtKO4QcS+kiEfOkqWzbRrLXv7d7v4ancFzIL75kP+eU+Q==
X-Received: by 2002:a17:902:ced0:b0:2c0:c625:400d with SMTP id
 d9443c01a7336-2c6e52debf1mr18166045ad.37.1781756131763; 
 Wed, 17 Jun 2026 21:15:31 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f2e535csm173905935ad.6.2026.06.17.21.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 21:15:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 10/10] target/arm: Enable FEAT_SME_F8F32 for -cpu max
Date: Wed, 17 Jun 2026 21:15:17 -0700
Message-ID: <20260618041517.573469-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618041517.573469-1-richard.henderson@linaro.org>
References: <20260618041517.573469-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 3 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 0f96bbe70b..20b9838520 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -235,6 +235,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_ssve_f8fma, ARM_HWCAP2_A64_SME_SF8FMA);
     GET_FEATURE_ID(aa64_ssve_f8dp4, ARM_HWCAP2_A64_SME_SF8DP4);
     GET_FEATURE_ID(aa64_ssve_f8dp2, ARM_HWCAP2_A64_SME_SF8DP2);
+    GET_FEATURE_ID(aa64_sme_f8f32, ARM_HWCAP2_A64_SME_F8F32);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index e4a8d7a2f6..e9eda8fbf1 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1392,6 +1392,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, B16F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, F16F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, I8I32, 0xf);  /* FEAT_SME */
+    t = FIELD_DP64(t, ID_AA64SMFR0, F8F32, 1);    /* FEAT_SME_F8F32 */
     t = FIELD_DP64(t, ID_AA64SMFR0, F16F16, 1);   /* FEAT_SME_F16F16 */
     t = FIELD_DP64(t, ID_AA64SMFR0, B16B16, 1);   /* FEAT_SME_B16B16 */
     t = FIELD_DP64(t, ID_AA64SMFR0, I16I32, 5);   /* FEAT_SME2 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 0b4623139a..a3a1607ff9 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -169,6 +169,7 @@ the following architecture extensions:
 - FEAT_SME_FA64 (Full A64 instruction set in Streaming SVE mode)
 - FEAT_SME_F16F16 (Non-widening half-precision FP16 arithmetic for SME2)
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
+- FEAT_SME_F8F32 (SME2 ZA-targeting FP8 multiply-accumulate, dot product, and outer product to single-precision instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
 - FEAT_SSVE_AES (Streaming SVE Mode Advanced Encryption Standard and 128-bit polynomial multiply long instructions)
-- 
2.43.0


