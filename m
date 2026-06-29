Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC516C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAg8-00075u-H3; Mon, 29 Jun 2026 08:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfP-0006qh-8o
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:50 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfN-0007Kq-B9
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:46 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4938d60c035so16629155e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734444; x=1783339244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9GoeIbkfvhhhUXCcpCPbrE2uV96YY8p39ctMuDrsX/E=;
 b=eQiWHdL++z64hbkpRqzw/P69wDsk88wNbTzdVSP00KDfBfFagtrZoTzI7JHUDWXzJr
 w8J5g+4fqf+a12j/kG8SxqHB8yqG4GSDc//29936pl4z/1+WA9lR3gPElUTodWohQr39
 jXNVuEs+5XDp7LoOpz7y5LywQ674ltQPxYRo1FO889JDn6oj6rTDwA0MZ9WPWUHzPmWb
 ZEapgmFZzHhTdqYL3KdRMa6ULDpYPipvXFbGYq6JPLPu1Ll8y/jlyrGyb9VRTpDNFZ7m
 yiG5wvzZcWeTgevaNliHlA1ync7SjaJBps2xzakCM0NP1UBVCmEd94Vr4jIRCGFZd1vS
 3WbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734444; x=1783339244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9GoeIbkfvhhhUXCcpCPbrE2uV96YY8p39ctMuDrsX/E=;
 b=St2PcgJlTfuUzvOjKdEsD6VkIClGFf1GKVdKPjQ6xeC3r7xNPHNLn+KvI9mGelp3EO
 2+DzWJLcIAESzsei/x/xiFAM3h3m3doDowd9g4eGj2sybCZsJBmesgdZ99wCZwYhs7sF
 fpYmuFu0IkQBCQ6a4AKHKAiCnPXakeW9BSyQ+8NbFYeiSGKVXX/r+i+yV0pEp4miJf7d
 DN6hqu321laya6c075kFve+Z5oEsGT/w3Q3SVOJFc9FzS/a7dBxnLnZwBrYghhd7CJ0b
 opQy2jHzWG1rxE5PagmtCPm/Q4g1uvtijOBQaW2a7+OsGP46CCJ2xo0ly3R2kum53Ugh
 eZ7g==
X-Gm-Message-State: AOJu0YyFOUxtv6UZksrSB2eFFgZ7iAKHZyzULsdsWTdgk/0vOQJ33QMY
 Q1FLSZqkuid7F7sy9mQ4rvGUe4eWmlFZaJeojGqupem+txY9QDZOor/zD2QhJuIk8Mn+zNPt/vY
 6aReJ
X-Gm-Gg: AfdE7ckMZ6dY5U4jJDPel8HXtMaRs2onL53CbCTSDGg6I5zRTU0VTZKRsoUp+p3XbLx
 1cqUHw+N70rBS5FbLhcgtFubsNt0PpJH1kDyicrpnzFm0GkkNdOIpdss9dvd+XBAEZZymlg6YVc
 OJqHCqlIW1Ig0rLMW4ReNfaRy2IW4Ahy8Dr1cw0NrhnqokTX+CEgMXJvGpqdJX4hDzyb6MbjUZZ
 3VhcGSKRCFXg+ATXtDxWtag25f8PrpNcxw5PM9ZRKl19hXOUJCMXGkudkQHHGA+5OsQWfX+rQHK
 6pmtZaxvF79rY6VOEwdVYbZFm4hUFXOzt0m70CGzlAEcwnZTUIQC4W7iiNCe3Gn9cRoh0YaSutt
 G65J5VBBdd8UkxAJvIgKM8o1W2GNJ0MLJmi5ZU0k7rFYhpdFiqw0/cWL68paF4dHfa+ptt4bdl3
 KKP5ixxK1XXsKG7iQyuydlXPUDvut3TZq7K7dOqvNYapQ89VEj7KqFFQxmRsRKgwJrnmnxh9Z/J
 S8cWSwI0w/ab+/7ivsK0Q==
X-Received: by 2002:a05:600c:3513:b0:492:564f:5603 with SMTP id
 5b1f17b1804b1-49266850086mr248129725e9.14.1782734443463; 
 Mon, 29 Jun 2026 05:00:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/54] target/arm: Implement FEAT_SSVE_AES
Date: Mon, 29 Jun 2026 12:59:46 +0100
Message-ID: <20260629120032.1645265-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
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

Enable FEAT_SVE_AES instructions in streaming mode.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260618040718.572950-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst  |  1 +
 linux-user/aarch64/elfload.c   |  1 +
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/cpu64.c         |  1 +
 target/arm/tcg/translate-sve.c | 20 +++++++++++---------
 5 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index a8072ddb67..0b4623139a 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -171,6 +171,7 @@ the following architecture extensions:
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SSVE_AES (Streaming SVE Mode Advanced Encryption Standard and 128-bit polynomial multiply long instructions)
 - FEAT_SSVE_FP8DOT2 (SVE2 FP8 2-way dot product to half-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 3479e61a12..0f96bbe70b 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -173,6 +173,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_cmpbr, ARM_HWCAP_A64_CMPBR);
     GET_FEATURE_ID(aa64_f8mm8, ARM_HWCAP_A64_F8MM8);
     GET_FEATURE_ID(aa64_f8mm4, ARM_HWCAP_A64_F8MM4);
+    GET_FEATURE_ID(aa64_ssve_aes, ARM_HWCAP_A64_SME_AES);
 
     return hwcaps;
 }
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index af843b32d3..c07bcb0a73 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1575,6 +1575,11 @@ static inline bool isar_feature_aa64_sve_b16b16(const ARMISARegisters *id)
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
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index f7a920a202..e4a8d7a2f6 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1383,6 +1383,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, AES, 1);      /* FEAT_SSVE_AES */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* FEAT_SSVE_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 9f0f0e0e12..79e8e16b24 100644
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
 
-TRANS_FEAT_NONSTREAMING(AESMC, aa64_sve_aes, gen_gvec_ool_zz,
-                        gen_helper_crypto_aesmc, a->rd, a->rd, 0)
-TRANS_FEAT_NONSTREAMING(AESIMC, aa64_sve_aes, gen_gvec_ool_zz,
-                        gen_helper_crypto_aesimc, a->rd, a->rd, 0)
+TRANS_FEAT_STREAMING_IF(AESMC, aa64_sve_aes, aa64_ssve_aes,
+                        gen_gvec_ool_zz, gen_helper_crypto_aesmc,
+                        a->rd, a->rd, 0)
+TRANS_FEAT_STREAMING_IF(AESIMC, aa64_sve_aes, aa64_ssve_aes,
+                        gen_gvec_ool_zz, gen_helper_crypto_aesimc,
+                        a->rd, a->rd, 0)
 
-TRANS_FEAT_NONSTREAMING(AESE, aa64_sve_aes, gen_gvec_ool_arg_zzz,
-                        gen_helper_crypto_aese, a, 0)
-TRANS_FEAT_NONSTREAMING(AESD, aa64_sve_aes, gen_gvec_ool_arg_zzz,
-                        gen_helper_crypto_aesd, a, 0)
+TRANS_FEAT_STREAMING_IF(AESE, aa64_sve_aes, aa64_ssve_aes,
+                        gen_gvec_ool_arg_zzz, gen_helper_crypto_aese, a, 0)
+TRANS_FEAT_STREAMING_IF(AESD, aa64_sve_aes, aa64_ssve_aes,
+                        gen_gvec_ool_arg_zzz, gen_helper_crypto_aesd, a, 0)
 
 TRANS_FEAT_NONSTREAMING(SM4E, aa64_sve2_sm4, gen_gvec_ool_arg_zzz,
                         gen_helper_crypto_sm4e, a, 0)
-- 
2.43.0


