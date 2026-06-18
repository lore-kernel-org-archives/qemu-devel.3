Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FF9CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 04:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa42R-0000zo-LI; Thu, 18 Jun 2026 00:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa42L-0000sF-Gr
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:07:29 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa42J-000469-7p
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:07:28 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-36ba285e98bso529689a91.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 21:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781755645; x=1782360445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7eGpGNVw0VKbFAFjy1dhp8kGk5UBS8foO5qXpZBTgI=;
 b=mX+MPPSq50X4WzlV5VAAZvgfj8Wry7Hw/OuAulQxgMbcfpO97/nHzB1xvIhP/UEaPY
 BTJS78sH7rBtsh6AAIjHqGENHkp+seCZkEF7vKnoE6o3CmrSrfpaKjsEo32iAY5643Uw
 9aTFNE0B0yVaF9iR9xLh+B6Ajikt0EASnAm1F/MDinQJx7CwMf3vzCbU9SJDUjoGFQ4Z
 WvWLdzsROvpLuYASW1nGCx++t+xIEQO9rW89RXJhJyCQZ8A3qVYc9B8CZvO9RO15W6RH
 yMBLe8fKM9pmSjw4chHdsI4fZn33Zpdco4RdpYgLdmGvmBQcZmPx2UoWwhtem6WAtGTQ
 bRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781755645; x=1782360445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y7eGpGNVw0VKbFAFjy1dhp8kGk5UBS8foO5qXpZBTgI=;
 b=lLL7/x8PNuePQZZSWJhyqE0M+QUsn/SGdCDAuTizn443RBSv5X71brlBjT47ZlY8Hj
 fw0kQJ8SnALcUtzkcka52WpsLVjsN9F3iEWTbO+eEqHD/rdwfG2j4JbvoLoBmxGq6Uq7
 BxX5IO7djbJ6wohT/ry4JmI20QhE8192mP8Hx4pQ76NDY0ObHsqAitXVVe/Tm5VJPT24
 6nSH4Rs1D10ukw0Ag4mDIUGTonV6gSYfhp9v9tvl8bGttngxDC5FAKW4rUUpxAhPDIiT
 Lt7rfV/54ENHkAtyh9L0IjqdIlQi+xx1SRAVLlQuksc9sO1J5Ta8p1BX1bHMXOWTia4r
 gccQ==
X-Gm-Message-State: AOJu0Ywno6lAoKP/O6NXQ/l8P1Eo6M0I9+MMTqhL9fTzaCwuCt5al0AE
 Cx3w+T8fg1qlVWKRYTF94qVKCfHlnpxuAClQ2bemmWxd2k4qfDOKhosL90UURBGAECsNXc268kl
 OxssP
X-Gm-Gg: AfdE7clkClpDBvYt0ZATAfFodz68/h7loTSAAxBOs5pZ2CtuC3YkVVkPg9LpiS+ypwh
 AC6hFL9cgpuwoSzJyaS2g6Km6aTL2xSwePuBu874zcYmjnA28S1jW2Tm4lTzCuD/nmjJRQPUo+Z
 c/Ga4f2GTLr+/rX2drXycPhv51cNI/wQbTQTeKWIDGl5d96TBuURU/g94rj/cTHwRZGTN1/uQKx
 QJs+v6LoSf8EbNiK6KKHOkJE1ordN48bDvkWCP1s+JHmHl7O1pbJkszp166s+4a3i+Qf7k121Zn
 xtDoD7NIHZQK+1ySddowREwjrSZ6lCdFA4Hyqtq5dfdfST/0MKVNnzqW3CXAEKJZFnkKkRBYo2w
 fYI/SYilE6hvsPW7IFE5Z/Nru17QMwXsRx7y0Vfzdwg3RqkJCVatIXm9/fknrqdG6tdMLZlS07n
 CWCBttZG4u+7wPiqdv5ayNOjX+bwp5NbMYWpwuxCUnLcxaar2nSC5tjmVEMZ9U
X-Received: by 2002:a17:90b:1b4d:b0:36a:fcf5:64bd with SMTP id
 98e67ed59e1d1-37c9da99d43mr7425061a91.2.1781755645380; 
 Wed, 17 Jun 2026 21:07:25 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c5222e042sm8830476a91.16.2026.06.17.21.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 21:07:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 6/8] target/arm: Rename isar_feature_aa64_sve_aes
Date: Wed, 17 Jun 2026 21:07:16 -0700
Message-ID: <20260618040718.572950-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618040718.572950-1-richard.henderson@linaro.org>
References: <20260618040718.572950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Rename from isar_feature_aa64_sve2_aes to match
the feature name: FEAT_SVE_AES.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/aarch64/target_arch_elf.h | 2 +-
 target/arm/cpu-features.h          | 2 +-
 linux-user/aarch64/elfload.c       | 2 +-
 target/arm/tcg/translate-sve.c     | 8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/bsd-user/aarch64/target_arch_elf.h b/bsd-user/aarch64/target_arch_elf.h
index 5ea5232a57..2fb7dcd778 100644
--- a/bsd-user/aarch64/target_arch_elf.h
+++ b/bsd-user/aarch64/target_arch_elf.h
@@ -126,7 +126,7 @@ static uint32_t get_elf_hwcap2(void)
 
     GET_FEATURE_ID(aa64_dcpodp, ARM_HWCAP2_A64_DCPODP);
     GET_FEATURE_ID(aa64_sve2, ARM_HWCAP2_A64_SVE2);
-    GET_FEATURE_ID(aa64_sve2_aes, ARM_HWCAP2_A64_SVEAES);
+    GET_FEATURE_ID(aa64_sve_aes, ARM_HWCAP2_A64_SVEAES);
     GET_FEATURE_ID(aa64_sve2_pmull128, ARM_HWCAP2_A64_SVEPMULL);
     GET_FEATURE_ID(aa64_sve2_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
     GET_FEATURE_ID(aa64_sve2_sha3, ARM_HWCAP2_A64_SVESHA3);
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index a80b251589..af843b32d3 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1524,7 +1524,7 @@ static inline bool isar_feature_aa64_sve2p2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, SVEVER) >= 3;
 }
 
-static inline bool isar_feature_aa64_sve2_aes(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_sve_aes(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, AES) != 0;
 }
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 4887a3a7b7..3479e61a12 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -184,7 +184,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
 
     GET_FEATURE_ID(aa64_dcpodp, ARM_HWCAP2_A64_DCPODP);
     GET_FEATURE_ID(aa64_sve2, ARM_HWCAP2_A64_SVE2);
-    GET_FEATURE_ID(aa64_sve2_aes, ARM_HWCAP2_A64_SVEAES);
+    GET_FEATURE_ID(aa64_sve_aes, ARM_HWCAP2_A64_SVEAES);
     GET_FEATURE_ID(aa64_sve2_pmull128, ARM_HWCAP2_A64_SVEPMULL);
     GET_FEATURE_ID(aa64_sve2_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
     GET_FEATURE_ID(aa64_sve2_sha3, ARM_HWCAP2_A64_SVESHA3);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 63f64796e5..9f0f0e0e12 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8174,14 +8174,14 @@ TRANS_FEAT(SDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
 TRANS_FEAT(UDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
            gen_helper_gvec_udot_2h, a, 0)
 
-TRANS_FEAT_NONSTREAMING(AESMC, aa64_sve2_aes, gen_gvec_ool_zz,
+TRANS_FEAT_NONSTREAMING(AESMC, aa64_sve_aes, gen_gvec_ool_zz,
                         gen_helper_crypto_aesmc, a->rd, a->rd, 0)
-TRANS_FEAT_NONSTREAMING(AESIMC, aa64_sve2_aes, gen_gvec_ool_zz,
+TRANS_FEAT_NONSTREAMING(AESIMC, aa64_sve_aes, gen_gvec_ool_zz,
                         gen_helper_crypto_aesimc, a->rd, a->rd, 0)
 
-TRANS_FEAT_NONSTREAMING(AESE, aa64_sve2_aes, gen_gvec_ool_arg_zzz,
+TRANS_FEAT_NONSTREAMING(AESE, aa64_sve_aes, gen_gvec_ool_arg_zzz,
                         gen_helper_crypto_aese, a, 0)
-TRANS_FEAT_NONSTREAMING(AESD, aa64_sve2_aes, gen_gvec_ool_arg_zzz,
+TRANS_FEAT_NONSTREAMING(AESD, aa64_sve_aes, gen_gvec_ool_arg_zzz,
                         gen_helper_crypto_aesd, a, 0)
 
 TRANS_FEAT_NONSTREAMING(SM4E, aa64_sve2_sm4, gen_gvec_ool_arg_zzz,
-- 
2.43.0


