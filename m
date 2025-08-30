Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374CBCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNt9-0006Fl-GN; Sat, 30 Aug 2025 11:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usDXd-00030O-Br
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 00:50:17 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usDXa-0005wZ-SQ
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 00:50:17 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7720f23123dso2686988b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 21:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756529413; x=1757134213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1+E0sT64Si6q7WTKew70AWBHsFaX0xXqXClRuhIA5/w=;
 b=i34NTYYnqRj75ICOu/Rst900eXYRlMP+hvxazdUOv2+sTSKKmV0dSWBlUsT1djjgxG
 1d8gbqRcPKKvmdLG3VSuWnXLeMDhsYNxwE1AmYJANlDOpehOG+ojwAnP9siUcnbaQMh5
 ujeHsLzE/ISN2CC2l8C9ujiwTsTxdy/+dIJcg4q1jNl345CSzXoJtynZ8F3tKNYAjC2f
 ZcFXu4E8K+D1m7uEC1I8zR0+Bz+WaH7RhxX7nBiDbFjN/MG6iJlgeVkm03M5DhE8WoKN
 TfrhvH2qhgP25v3L/riRZp5Et/5CS89MFvOk8LZD9w1maJV5WRtTIV7S2/EWJzRW+V3Y
 VNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756529413; x=1757134213;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1+E0sT64Si6q7WTKew70AWBHsFaX0xXqXClRuhIA5/w=;
 b=fH6Zb0/MoFGiXGHxtjEbZ6f6gezXbm/aGNKg2CLVAcPQbl5xREFqUEjn+YApJ0SQyw
 Pn3p5W4io/UGPBrAk+ZlnxpRB4IuhsbCdnllTwYBZaYK1mdegvFMEjWvzdOTyFrHTQ+I
 Ve0Xs2Jpc/umX78XO61G9cbeYouGzxMDjFLq1swgVoJBiQObFWMsACZACiySjLG20vp0
 joyEddBtGXgUk0NT9e4/owExVa+WP2PjYe2Xq59ntsmeUYJDeE9wOGf8gPrKzoHCAeh6
 ImgKdUEiQH+6rphxdKkTzHZrpAisyfDJqqj2AKhm3Z/4U4EaC4yqTTOcolr/6LmD8Lmu
 lVeg==
X-Gm-Message-State: AOJu0Yye6jfeWT6vhi502lOCDQ1rL4mfPzWXqanncF8Ai9VAY5uCa1pL
 xWTAtoeu97t4+KuJIUViIWRojucBm3yCAFZZavpRMSmmAAaxZHGmrkJlkH3PBXB86q3FU6+Kh1W
 plrsFD9s=
X-Gm-Gg: ASbGnctD0MOg0HvmOBFCV5GCIWTMI0tOZgFC+gYLj2IB1Y8tzcn6dMrdRhVJk5rsZu5
 BDLxHA2wFXwkYlVz4I4UBpRsno+voRwlJ3csBtFtmQg5ejsUaqnvFX7MwGcMlqT2XV1z0DEPuAq
 byNsdwJCpz+jXDAXS6/lp4toZ2cS+6AGTRXmYpdb4EsGqC6p/zSeorgzVsZq+kh3PoTo7PzcSXg
 ltaVgFKTNtCy1rPo76ezw9VNrZr3w1ri2QtJslFYy0MOVY/AUtTw6/xTTt8o3dU82/Mco+zJee9
 1DTqQ3Dv9YhmwgQZvdvtD1gjYqX/ua31MOMSNIWZWahoi//GtMLOh37blW2iBc2kTxdy0nZfQyV
 goA58BJ2vKIKEqXSUw2EifvROhTKnWlnTR29T8Bpi+zxjyRo46s0bIzH9dKk6nRM=
X-Google-Smtp-Source: AGHT+IHmSzfik2cJBSaivK0/RcLK4B1eLYG0piTssjGmUFcaigMx1Hcp9hj0/EmQDSspjr+kQNjbNA==
X-Received: by 2002:a05:6a00:1789:b0:76b:d67b:2ee0 with SMTP id
 d2e1a72fcca58-7723e21a70bmr1478615b3a.6.1756529412848; 
 Fri, 29 Aug 2025 21:50:12 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3978123b3a.55.2025.08.29.21.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 21:50:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2] target/arm: Rename isar_feature_aa64_atomics
Date: Sat, 30 Aug 2025 14:50:06 +1000
Message-ID: <20250830045006.380393-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

This is FEAT_LSE -- rename the predicate to match.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250815122653.701782-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---

Hi Peter, this is to replace the version in your recent PR,
updating bsd-user properly.  Sorry about that.


r~

---
 bsd-user/aarch64/target_arch_elf.h |  2 +-
 target/arm/cpu-features.h          |  2 +-
 linux-user/aarch64/elfload.c       |  2 +-
 target/arm/tcg/translate-a64.c     | 24 ++++++++++++------------
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/bsd-user/aarch64/target_arch_elf.h b/bsd-user/aarch64/target_arch_elf.h
index cc87f475b3..cec254f88b 100644
--- a/bsd-user/aarch64/target_arch_elf.h
+++ b/bsd-user/aarch64/target_arch_elf.h
@@ -114,7 +114,7 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_sm3, ARM_HWCAP_A64_SM3);
     GET_FEATURE_ID(aa64_sm4, ARM_HWCAP_A64_SM4);
     GET_FEATURE_ID(aa64_fp16, ARM_HWCAP_A64_FPHP | ARM_HWCAP_A64_ASIMDHP);
-    GET_FEATURE_ID(aa64_atomics, ARM_HWCAP_A64_ATOMICS);
+    GET_FEATURE_ID(aa64_lse, ARM_HWCAP_A64_ATOMICS);
     GET_FEATURE_ID(aa64_rdm, ARM_HWCAP_A64_ASIMDRDM);
     GET_FEATURE_ID(aa64_dp, ARM_HWCAP_A64_ASIMDDP);
     GET_FEATURE_ID(aa64_fcma, ARM_HWCAP_A64_FCMA);
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index d48754bcf2..451b37b5b3 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -406,7 +406,7 @@ static inline bool isar_feature_aa64_crc32(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ISAR0, CRC32) != 0;
 }
 
-static inline bool isar_feature_aa64_atomics(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_lse(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ISAR0, ATOMIC) >= 2;
 }
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index dd5f34398a..8bf39c4730 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -154,7 +154,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_sm3, ARM_HWCAP_A64_SM3);
     GET_FEATURE_ID(aa64_sm4, ARM_HWCAP_A64_SM4);
     GET_FEATURE_ID(aa64_fp16, ARM_HWCAP_A64_FPHP | ARM_HWCAP_A64_ASIMDHP);
-    GET_FEATURE_ID(aa64_atomics, ARM_HWCAP_A64_ATOMICS);
+    GET_FEATURE_ID(aa64_lse, ARM_HWCAP_A64_ATOMICS);
     GET_FEATURE_ID(aa64_lse2, ARM_HWCAP_A64_USCAT);
     GET_FEATURE_ID(aa64_rdm, ARM_HWCAP_A64_ASIMDRDM);
     GET_FEATURE_ID(aa64_dp, ARM_HWCAP_A64_ASIMDDP);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 259aa70a36..0ba537268c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3237,7 +3237,7 @@ static bool trans_LDXP(DisasContext *s, arg_stxr *a)
 
 static bool trans_CASP(DisasContext *s, arg_CASP *a)
 {
-    if (!dc_isar_feature(aa64_atomics, s)) {
+    if (!dc_isar_feature(aa64_lse, s)) {
         return false;
     }
     if (((a->rt | a->rs) & 1) != 0) {
@@ -3250,7 +3250,7 @@ static bool trans_CASP(DisasContext *s, arg_CASP *a)
 
 static bool trans_CAS(DisasContext *s, arg_CAS *a)
 {
-    if (!dc_isar_feature(aa64_atomics, s)) {
+    if (!dc_isar_feature(aa64_lse, s)) {
         return false;
     }
     gen_compare_and_swap(s, a->rs, a->rt, a->rn, a->sz);
@@ -3743,15 +3743,15 @@ static bool do_atomic_ld(DisasContext *s, arg_atomic *a, AtomicThreeOpFn *fn,
     return true;
 }
 
-TRANS_FEAT(LDADD, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_add_i64, 0, false)
-TRANS_FEAT(LDCLR, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_and_i64, 0, true)
-TRANS_FEAT(LDEOR, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_xor_i64, 0, false)
-TRANS_FEAT(LDSET, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_or_i64, 0, false)
-TRANS_FEAT(LDSMAX, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_smax_i64, MO_SIGN, false)
-TRANS_FEAT(LDSMIN, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_smin_i64, MO_SIGN, false)
-TRANS_FEAT(LDUMAX, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_umax_i64, 0, false)
-TRANS_FEAT(LDUMIN, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_umin_i64, 0, false)
-TRANS_FEAT(SWP, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_xchg_i64, 0, false)
+TRANS_FEAT(LDADD, aa64_lse, do_atomic_ld, a, tcg_gen_atomic_fetch_add_i64, 0, false)
+TRANS_FEAT(LDCLR, aa64_lse, do_atomic_ld, a, tcg_gen_atomic_fetch_and_i64, 0, true)
+TRANS_FEAT(LDEOR, aa64_lse, do_atomic_ld, a, tcg_gen_atomic_fetch_xor_i64, 0, false)
+TRANS_FEAT(LDSET, aa64_lse, do_atomic_ld, a, tcg_gen_atomic_fetch_or_i64, 0, false)
+TRANS_FEAT(LDSMAX, aa64_lse, do_atomic_ld, a, tcg_gen_atomic_fetch_smax_i64, MO_SIGN, false)
+TRANS_FEAT(LDSMIN, aa64_lse, do_atomic_ld, a, tcg_gen_atomic_fetch_smin_i64, MO_SIGN, false)
+TRANS_FEAT(LDUMAX, aa64_lse, do_atomic_ld, a, tcg_gen_atomic_fetch_umax_i64, 0, false)
+TRANS_FEAT(LDUMIN, aa64_lse, do_atomic_ld, a, tcg_gen_atomic_fetch_umin_i64, 0, false)
+TRANS_FEAT(SWP, aa64_lse, do_atomic_ld, a, tcg_gen_atomic_xchg_i64, 0, false)
 
 static bool trans_LDAPR(DisasContext *s, arg_LDAPR *a)
 {
@@ -3759,7 +3759,7 @@ static bool trans_LDAPR(DisasContext *s, arg_LDAPR *a)
     TCGv_i64 clean_addr;
     MemOp mop;
 
-    if (!dc_isar_feature(aa64_atomics, s) ||
+    if (!dc_isar_feature(aa64_lse, s) ||
         !dc_isar_feature(aa64_rcpc_8_3, s)) {
         return false;
     }
-- 
2.43.0


