Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6DBCD6E7B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHoO-0006wb-7M; Thu, 04 Jun 2026 19:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHoI-0006sK-Lc
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:14 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHoG-0007zr-Fp
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:14 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2bf22d29dabso9414275ad.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780616951; x=1781221751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+L/AvZa0gLJ2Kl37DyNIwhexBKjBiOGoa6I6mtkDLA=;
 b=ed9UfvpLClHYHx2bLhN+9tXMsQvdUpjUpUR30yVgHdfjQ0pYL3HbhtbhR0OGapib9d
 VbfDpLCIY8nh4PLNNeyZK2tCaIHLx9IP5xawE9/cRjeCpEoQ7tZ+JM3Aii08ijBq1xON
 +hz3M9otse+qPHCsQnOwIieCTKFphNVyizKIhDRHNZxM49iOYlbU7waHktoeEP037pkI
 6dP1aRmRB3hywZBNtSRso21ban2MI1oSa7/rMm5VB9CaOVL36fhrDZ7r/dN13QQRXkmO
 HvWj840eAcsDgL7us+TnfTa4QhsDzQv3rCSI37T+rVJAz+UNU1U9NsM0O5BKeigo6Iea
 +Ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780616951; x=1781221751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k+L/AvZa0gLJ2Kl37DyNIwhexBKjBiOGoa6I6mtkDLA=;
 b=lwUknH77Ecg2ZP9MFObpz7/iZ4Vm4hZKi+5BzVWT2NM2V2X+GyUm1snvrrCy1ICMg3
 A9zoCDScX0aMnPW42b39FJVnarPXvRRk8GXzAGH3YO/l/XHnNryEvZh8lvbE3ikVxZal
 LZRJ01mz7nsFkWqquh+AJe6uHVfeo08oTr8hAhacshdj6N7IpKC7rH6+LkEVEctbwlQT
 59BFqUMff5D4tLnTEJvV6PyTtR7jMrjPCiD9Mf1gXMZ56ysXAE+b+afZ9DikXDrkdn22
 ij+3kWqazn5S4rHTRuWwKM8DslN00JUrJbE/dgGT0/XhmDX+AnqGnEY7FjXyBRwImFad
 yzfQ==
X-Gm-Message-State: AOJu0YxNpF5n7MqdP1Qy3LXwHv2axqXNTg2kYcAD382pE6wVAelYXafQ
 jriHAq5lK0gfQCkcsJwkLpUIUAlx4UoGuo0D79yDDXdU5STBUe+oUm2kOwseSdZabFcxSWao4Mz
 yErt7d/U=
X-Gm-Gg: Acq92OEdcw89H9IS7uwqHgCXuII+wMrmr3xq5qHf/OHCPisI79wBjGCqWzLbm8qgqJj
 RMVCUx5ju8t/AMnHc/mMMpdWt8HeCuRN3lAZ+WqU/+OedqwtI2uc6grn6pQaqw0Z5aSexg81ofe
 HkDUIsCy9GyjIvyfJ7jYdETqbnI/lj9zUvTz1gc7ZexjHmnO6C7j0wi38ycXT4wy7WYgfMPsIcO
 3us9htkgpBVBfNFauwWShs3oklxSwCQS3Hn0wcD6E6/1i96GUxGjJF5ByOebqJuD9wtF3APHyT2
 nbrfUjeZgWm7olO9qkYIXVQlZWxV/OkYHSfQVoiH45Z467h98fX4vvbNmBzdwmcUwUmfGK2bT9H
 zwOsfSpmUkjR4N1S6zDP6wmU/L9ftQDowmQgHV6kvdptwgDVr0Ajkx5pZGYOLwl4GpTgSi1Us9z
 S3rFqXu6GAZ/T7UhYBiAfrREGE7bUb8u7L0KJyhU5UvuPYtY2cNA==
X-Received: by 2002:a17:902:cf03:b0:2c1:e9f8:758d with SMTP id
 d9443c01a7336-2c1e9f87925mr4762735ad.22.1780616950958; 
 Thu, 04 Jun 2026 16:49:10 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1664950aesm66541465ad.69.2026.06.04.16.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:49:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 24/25] target/arm: Implement FEAT_SSVE_AES
Date: Thu,  4 Jun 2026 16:48:51 -0700
Message-ID: <20260604234852.573178-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604234852.573178-1-richard.henderson@linaro.org>
References: <20260604234852.573178-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Enable FEAT_SVE_AES instructions in streaming mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 linux-user/aarch64/elfload.c   |  1 +
 target/arm/tcg/cpu64.c         |  1 +
 target/arm/tcg/translate-sve.c | 20 +++++++++++---------
 docs/system/arm/emulation.rst  |  1 +
 5 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 49c8606809..a2c7fa90aa 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1560,6 +1560,11 @@ static inline bool isar_feature_aa64_sve_b16b16(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, B16B16);
 }
 
+static inline bool isar_feature_aa64_ssve_aes(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, AES);
+}
+
 static inline bool isar_feature_aa64_ssve_f8fma(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SF8FMA);
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index c4d2d35741..5bb4a2a3d7 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -174,6 +174,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_f8mm8, ARM_HWCAP_A64_F8MM8);
     GET_FEATURE_ID(aa64_f8mm4, ARM_HWCAP_A64_F8MM4);
     GET_FEATURE_ID(aa64_sve2p2, ARM_HWCAP_A64_SVE2P2);
+    GET_FEATURE_ID(aa64_ssve_aes, ARM_HWCAP_A64_SME_AES);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 38e5a8d912..106feb28ca 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1378,6 +1378,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, AES, 1);      /* FEAT_SSVE_AES */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* FEAT_SSVE_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 912290f460..ff7ff0bc82 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7169,7 +7169,7 @@ static bool do_trans_pmull(DisasContext *s, arg_rrr_esz *a, bool sel)
         if (!dc_isar_feature(aa64_sve2_pmull128, s)) {
             return false;
         }
-        s->is_nonstreaming = true;
+        s->is_nonstreaming = !dc_isar_feature(aa64_ssve_aes, s);
     }
     return gen_gvec_ool_arg_zzz(s, fns[a->esz], a, sel);
 }
@@ -8174,15 +8174,17 @@ TRANS_FEAT(SDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
 TRANS_FEAT(UDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
            gen_helper_gvec_udot_2h, a, 0)
 
-TRANS_FEAT_NONSTREAMING(AESMC, aa64_sve2_aes, gen_gvec_ool_zz,
-                        gen_helper_crypto_aesmc, a->rd, a->rd, 0)
-TRANS_FEAT_NONSTREAMING(AESIMC, aa64_sve2_aes, gen_gvec_ool_zz,
-                        gen_helper_crypto_aesimc, a->rd, a->rd, 0)
+TRANS_FEAT_STREAMING_IF(AESMC, aa64_sve2_aes, aa64_ssve_aes,
+                        gen_gvec_ool_zz, gen_helper_crypto_aesmc,
+                        a->rd, a->rd, 0)
+TRANS_FEAT_STREAMING_IF(AESIMC, aa64_sve2_aes, aa64_ssve_aes,
+                        gen_gvec_ool_zz, gen_helper_crypto_aesimc,
+                        a->rd, a->rd, 0)
 
-TRANS_FEAT_NONSTREAMING(AESE, aa64_sve2_aes, gen_gvec_ool_arg_zzz,
-                        gen_helper_crypto_aese, a, 0)
-TRANS_FEAT_NONSTREAMING(AESD, aa64_sve2_aes, gen_gvec_ool_arg_zzz,
-                        gen_helper_crypto_aesd, a, 0)
+TRANS_FEAT_STREAMING_IF(AESE, aa64_sve2_aes, aa64_ssve_aes,
+                        gen_gvec_ool_arg_zzz, gen_helper_crypto_aese, a, 0)
+TRANS_FEAT_STREAMING_IF(AESD, aa64_sve2_aes, aa64_ssve_aes,
+                        gen_gvec_ool_arg_zzz, gen_helper_crypto_aesd, a, 0)
 
 TRANS_FEAT_NONSTREAMING(SM4E, aa64_sve2_sm4, gen_gvec_ool_arg_zzz,
                         gen_helper_crypto_sm4e, a, 0)
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 868ba37e3a..a42cfeae47 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -166,6 +166,7 @@ the following architecture extensions:
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SSVE_AES (Streaming SVE Mode Advanced Encryption Standard and 128-bit polynomial multiply long instructions)
 - FEAT_SSVE_FP8DOT2 (SVE2 FP8 2-way dot product to half-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
-- 
2.43.0


