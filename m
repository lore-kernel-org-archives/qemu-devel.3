Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEAECD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX266-000804-Bo; Tue, 09 Jun 2026 15:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21s-0003Z3-Bo
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:31 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21g-0004CE-TT
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:23 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2bf77d4a4e2so37214015ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032902; x=1781637702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DS9O8SaU3UtlC+2YZXc3ame2k7BLsC7rPFolJeiV0Jo=;
 b=OPmIqInpyH2WGs9GhZiIr4pLqLFcISqbcKqpg95nJg2jHqA9IjXgnOrnPbET+39YT5
 1+ZJ1mLN9wfXv4+ZBuCXWBcBKc/e6RuVzUI+D40uhYShjCvbhkEYEwbbAXsMvtvFPstD
 pWwFL3CihtLNOKKZ7ifA/JXPWkvUipW/fpWTXYXy7VDYbme0WdDQQx+rIQx4UZrlffIN
 PLjDoGN6MtW61XBE+GD0jOkD5ieBwITN48Fy8D0NZveBpAnVqfn2GwzMkzx2PW0DKTkN
 j/qnsHNS/sx8Ig1abZvKjs5E1amj1hh8cWP24M2IPom8cU62ZmptK1EoSsNTtS9W2U5z
 8zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032902; x=1781637702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DS9O8SaU3UtlC+2YZXc3ame2k7BLsC7rPFolJeiV0Jo=;
 b=Mk1JlEvKHOkYWSaDeJ3oARrKnkmTWRdAOc6djDGNeQE5GSC7a5p87FJfBzMQla+sku
 i6iqCEzLAaPF+BIlT3D1cSnHK4qlHgvWKkZAOhQeEdT0aJ4FyBnJvx82cK/i0jt5vJ6V
 Qb8Tb+HKMaET0aNKcxoSII4g7OXLufZ78DbWhNSRokuC2nZ+ZeUwJp6eZymvFvvdQD2E
 Qz2kMOiln1Va3kCGVJjFKZb52UECCZ24JPeRK4PiQLaWdcn0SR9M0vq2x/vGvuBbYj/R
 OzSvu3CPhRNWNShnYD8lYOnJgTIZa6TmpmTFugrbM03EHjXUFWVuGiBa8HHU6157XT6M
 hNbQ==
X-Gm-Message-State: AOJu0YzVahF5sZC5MyYYO/3l+A7nF2QVwsCdIWQ+VAsugca+oEZKFJvh
 M4Co8KdVt69C9/SwaJXMlHMeMFUkm0GLGZ5bd854qOrEpkBL2WP5e80hGoxYf9FSZG5IZzC80t7
 DCKryqd4=
X-Gm-Gg: Acq92OFWQNnLcRq6qetRvxG7s5tQvDQATOrSg62+OoOby8HmSadu4GRwE2PF///m1dv
 JW5QH9HoUlJU+zRAcBvKwnTo8d7M4o7225cPy9ln2VAafnmRJfUe2CYexeyxIrusOFWW/Ltd7Qe
 NC7YXifBnO3eW9hSUnjN1On7u/7jbyZOjYdn9Q380fQsEoHuxj/VyEk/YUZIkIGc9a7byAHnXwk
 dFi1XPAvVwCUnJJydMDhdqIFwXtk8i24UOXeR4OzrBlxyuN4MnPAmq8iw+klyq5EIamDHvoHWQa
 SZpHYAfYhmVgetrInKKulkWtiGwNmqcSH43vSXC/Z2Av5IATTBnX3hIOhDvUO9y9TmXE1WQiwdW
 oJ7xAALhynXCmJfNy2kgrRdYCtEA9iWPrVcMaxsnyBO0Nlj2R9Rn4gbm7DsryYdBMx28rAb7JcP
 6/HLFfn3KH5AzNNOsLp15FeGEu+XXlyQbhLZ4mXPU=
X-Received: by 2002:a17:903:3b8c:b0:2bf:361e:3edc with SMTP id
 d9443c01a7336-2c1ec3f61a1mr187134945ad.2.1781032901512; 
 Tue, 09 Jun 2026 12:21:41 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 39/45] target/arm: Enable FEAT_FP8DOT2,
 FEAT_SSVE_FP8DOT2 for -cpu max
Date: Tue,  9 Jun 2026 12:21:03 -0700
Message-ID: <20260609192110.752384-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c  | 2 ++
 target/arm/tcg/cpu64.c        | 2 ++
 docs/system/arm/emulation.rst | 2 ++
 3 files changed, 6 insertions(+)

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
index 1e2d1311b9..893e20f0eb 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1378,6 +1378,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* FEAT_SSVE_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
@@ -1398,6 +1399,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* FEAT_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 8d786f9dae..f1c8f5aa68 100644
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
@@ -163,6 +164,7 @@ the following architecture extensions:
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SSVE_FP8DOT2 (SVE2 FP8 2-way dot product to half-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
 - FEAT_SVE (Scalable Vector Extension)
-- 
2.43.0


