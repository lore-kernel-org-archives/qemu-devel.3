Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5332CC624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONl-0001U6-BU; Tue, 01 Sep 2026 09:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONg-0001Ru-KN
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:28 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONe-0007M6-P6
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:28 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c2544ff970dso734822066b.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268705; x=1788873505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6PIyPEC1jlx2yTCokfrc/ZgJkLtcvysXWDS/+He/fh0=;
 b=ugpVLR9Bc6bdo2qrOHV5KLKaC0VLEJbiB5dfychXwKSEXh/kkZjaQG0IwvMGxrqE8C
 aiHnN0PavUTDb/zQvc711swwIXS64e90KX9Jj/E7wnirlxbQpeJhLZ0ZxoYER/sMGP/3
 JGU41kWT5n2kMHNWegMbdmyQvY9QFX+teL/gsaGozA3o3rRkkkZ1wgM3rLOCYbfMu1Tb
 jsaXvuATqGaR5vunD68tEfNa9t3Afevf/Erv1RHtuoc0ThiegQJb5nEOLrJmdF381az2
 V5DCB+za+V2qSGrqYcX43yJZ1ivv7TJKiGuI1OJxeFlrwYDtjRqpV8QtGTLzQ433kK42
 gFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268705; x=1788873505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6PIyPEC1jlx2yTCokfrc/ZgJkLtcvysXWDS/+He/fh0=;
 b=GfTnsI0YLybFSgtn7kSvHQJuklQLo6vQ0/byelDjXn9F8g8yoZDFWZNNdLGVda9E6H
 jS/bcHzv+xTtXP+KQYuVLDwYyVn1L2jYjh4WwwgyExZd68wAPXpP5nGpB6FOPEzSu+gS
 y8RuFX95t+G5w7zopJme++5ucefyvpif7aLMZRia4WfAo3eM4wabcllvYcSZ4lduCtP1
 9SZNK+maYHmGHH9RmKp+Im2HUy6HJOvFkEcOkP6yrTV9o6VafJv0xbIOz16sQ1lCDlgu
 ipINSe/6xvqUvHRFs+EQsoAM/83uw75yNzHf7/iDHCSnlwSSIiF+871iKk/91EorlaWR
 gwRw==
X-Gm-Message-State: AFuF++l1R+cijt35zavNoH0FSe0dk4xyq412uvwpSoaY0CrhjRd4AezX
 x5ShyQ5zxpq/RWCGLkzrGaTlndaX+cRQ+ooJ7Pl9aZ5+5jOlqueAJWSLCuwLz7KsYxCv7y+LwVh
 aD19EpsE=
X-Gm-Gg: AR+sD13/e+bM2HxbMK4t/24g/y4SE7UXwWCd1y0y3oxxlnnDOxzAlz9NGFcEeFyxeZD
 bRJPbf4Oq3BAclvbm9/EwGojqfhPkebyYJV8Ahzk3BN5S/xpWxIh2xLrGqSEWkkHp54ytMf306F
 CI//VDtk/fhFoKqMA0qLTQ4kRs+eNLoWmHf4N6xHtcoQBv5ZksK2e4+KwzfLYt2ujC+k/+fMIH8
 tyaeAfcs7KMQN/O99YGi2GsY/2w1cEDMiEANjeiZHhyLgextvHkDaDQOg9oYSdb782y4eBMdns0
 h9jRTzdi/dBfl4CLRxDLAPUZrFzayWefhywPY9QkCBETj6sQo3eYeZOS1CUoXa4jvYvjz9q8DGQ
 dVxxJqsE5Ge4kTXXJI0swkIyzH2k7/hvj8rRmRKT1SAYiAk+7WEj9XZpWwVmXBv3NucnsqSUZ2n
 Qh9C+1HEnBg7lR1Sv6GoJ7PLwDqHQLXXMqBQi2WrOBBSXkqLpjWGVw4oms+EA0psUyDkWOJrayS
 7nWDYcre16R9TrT7eAbb7llqi/sY+yKrfPYsMCgXiP10DP2cI7grhxBIgBzln6L3MCkng==
X-Received: by 2002:a17:906:478c:b0:c24:6390:decf with SMTP id
 a640c23a62f3a-c25571630ecmr2100478066b.16.1788268705264; 
 Tue, 01 Sep 2026 06:18:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/58] target/arm: Implement and enable FEAT_SSVE_BitPerm for
 -cpu max
Date: Tue,  1 Sep 2026 14:17:26 +0100
Message-ID: <20260901131732.2263947-53-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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
Message-id: 20260826174213.614571-20-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst  |  1 +
 linux-user/aarch64/elfload.c   |  1 +
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/cpu64.c         |  1 +
 target/arm/tcg/translate-sve.c | 12 ++++++------
 5 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index af5245cd21b..e3ec4b6137a 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -192,6 +192,7 @@ the following architecture extensions:
 - FEAT_SME_MOP4 (Quarter-tile outer product instructions)
 - FEAT_SME_TMOP (Structured sparsity outer product instructions)
 - FEAT_SSVE_AES (Streaming SVE Mode Advanced Encryption Standard and 128-bit polynomial multiply long instructions)
+- FEAT_SSVE_BitPerm (Streaming Scalable Vector Bit Permutes instructions)
 - FEAT_SSVE_FEXPA (Streaming FEXPA instruction)
 - FEAT_SSVE_FP8DOT2 (SVE2 FP8 2-way dot product to half-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 7afbfca4183..4359312ee38 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -181,6 +181,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_sve2p2, ARM_HWCAP_A64_SVE2P2);
     GET_FEATURE_ID(aa64_sme2p2, ARM_HWCAP_A64_SME2P2);
     GET_FEATURE_ID(aa64_sve_bfscale, ARM_HWCAP_A64_SVE_BFSCALE);
+    GET_FEATURE_ID(aa64_ssve_bitperm, ARM_HWCAP_A64_SME_SBITPERM);
 
     return hwcaps;
 }
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 749dbfe6fb0..b23b5a83c68 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1610,6 +1610,11 @@ static inline bool isar_feature_aa64_ssve_aes(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, AES);
 }
 
+static inline bool isar_feature_aa64_ssve_bitperm(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SBITPERM);
+}
+
 static inline bool isar_feature_aa64_ssve_f8fma(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SF8FMA);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 2eb049b6002..4994a87afed 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1484,6 +1484,7 @@ void aarch64_max_v9_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, STMOP, 1);    /* v9.4: FEAT_SME_TMOP */
     t = FIELD_DP64(t, ID_AA64SMFR0, SFEXPA, 1);   /* v9.4: FEAT_SSVE_FEXPA */
     t = FIELD_DP64(t, ID_AA64SMFR0, AES, 1);      /* v9.5: FEAT_SSVE_AES */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SBITPERM, 1); /* v9.4: FEAT_SSVE_BitPerm */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* v9.2: FEAT_SSVE_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* v9.2: FEAT_SSVE_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* v9.2: FEAT_SSVE_FP8FMA */
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 3d823674cca..8a5903da4fc 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7430,22 +7430,22 @@ static gen_helper_gvec_3 * const bext_fns[4] = {
     gen_helper_sve2_bext_b, gen_helper_sve2_bext_h,
     gen_helper_sve2_bext_s, gen_helper_sve2_bext_d,
 };
-TRANS_FEAT_NONSTREAMING(BEXT, aa64_sve_bitperm, gen_gvec_ool_arg_zzz,
-                        bext_fns[a->esz], a, 0)
+TRANS_FEAT_STREAMING_IF(BEXT, aa64_sve_bitperm, aa64_ssve_bitperm,
+                        gen_gvec_ool_arg_zzz, bext_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const bdep_fns[4] = {
     gen_helper_sve2_bdep_b, gen_helper_sve2_bdep_h,
     gen_helper_sve2_bdep_s, gen_helper_sve2_bdep_d,
 };
-TRANS_FEAT_NONSTREAMING(BDEP, aa64_sve_bitperm, gen_gvec_ool_arg_zzz,
-                        bdep_fns[a->esz], a, 0)
+TRANS_FEAT_STREAMING_IF(BDEP, aa64_sve_bitperm, aa64_ssve_bitperm,
+                        gen_gvec_ool_arg_zzz, bdep_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const bgrp_fns[4] = {
     gen_helper_sve2_bgrp_b, gen_helper_sve2_bgrp_h,
     gen_helper_sve2_bgrp_s, gen_helper_sve2_bgrp_d,
 };
-TRANS_FEAT_NONSTREAMING(BGRP, aa64_sve_bitperm, gen_gvec_ool_arg_zzz,
-                        bgrp_fns[a->esz], a, 0)
+TRANS_FEAT_STREAMING_IF(BGRP, aa64_sve_bitperm, aa64_ssve_bitperm,
+                        gen_gvec_ool_arg_zzz, bgrp_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const cadd_fns[4] = {
     gen_helper_sve2_cadd_b, gen_helper_sve2_cadd_h,
-- 
2.43.0


