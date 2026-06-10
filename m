Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2500CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYV-0002eb-1Q; Wed, 10 Jun 2026 12:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYP-0002VK-Cb
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:21 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYN-00068g-Py
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:21 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45efb698ef2so3467161f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107998; x=1781712798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rFWWecOymn7ap1d4JecW5vVY+UBPQ7clb8UYhOn+KQ4=;
 b=iswTp6Z6MNXhGiPe/BnnyxqZQu2IyBMzxSMGXoDDkKc0pEp1iVxIQUCM2KzjFceoeG
 9DLSvvA+mtIeYXAFHeeNElbqtrbB7Jh3C7XJXiMeR1Q7mWgf9AkzFZ9Mgt2DYxfeSgMa
 J454ZCZEjpsfdxf7Vp5pvysiLIOAPYzExLMhQ0342Y/JCkOL1mmsFBkc37kzm/sqm5wg
 lbwvZb7HgLv7xlbaTLa8QyVZxy0J8n9XOKjGftZIzLwpmoOqAXKirNu5tp1NvXo831BY
 WUFLi1qTO7AjcwnDvBUHCHald5+jewk5g0jdjRA/9eHpzhX0HeJg/ncI4uQSTsdSEs3K
 AZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107998; x=1781712798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rFWWecOymn7ap1d4JecW5vVY+UBPQ7clb8UYhOn+KQ4=;
 b=HCSg9oS5PJJ7HgGWWrQ5Ta7zbOaO0jS3J9VzOk7Pg+n7CBwAVogVuep0jjxKS0NH6h
 7zHuZTbxBP2YKjAmVzLGth92FWcC7qQ7pqoY+z0OW8HdFNWNitBlBHPyBERaBd83K8kD
 5/lhGFJ/IwEk1BRSR3VOZitWpC1rULUpmv3lmFTbVeFUy+aogt4m0X7GKKh0Z0et0tHe
 wfHlIU2dfypS3fE3FsZA1F/FsZkzE6fF5WEH5IdgulIm0PMUcvihKoWm/OIBqwrdvd+N
 nZ3EI3ADCMn9b/H9+xbei79ZUbzbx4Ono2DUoxn/i48cpCWorpfPhV3CKwgKLsip6UYD
 zY6A==
X-Gm-Message-State: AOJu0YyjGjryEvEOMPy5H9Qmh0ZiZZXGl22wra4k2ClyFaHmD2v9QG7a
 nvtEvvfhT9lAnpy9+HMy9Xjms3jihCOFmKGpCLPBjJtDyAnhqdym2wRiNNxyhBP+udZpn5I8DRL
 KkC8R
X-Gm-Gg: Acq92OGuoKsCzUdf4nlu0hio6CEjD3T7muBGsDVMYo/Sxu39bFZX2uh5aY/S3jnfemR
 XKBjFLMA1E0qgy+oxGMpwTY+eXokwg4RsgEJOG9bfA8LarDcLqL7yZLmu4ePzEbDK7SG6jYZRwF
 n4PcXTufWIOA+7smezeBfl9VbBFehX54udkxQJOPrtB+8/iqHhjKTTqfoz/LQFj4f/49KBuG+lP
 Ju1CKBMw8gbWuO6WZNqPWgfQO9wfutbvXiR+QXi9h50AolcOhUYGKUIW3I4xQWwdVNy0INP+0ds
 lJtixqdI+HO4KneY3MKkzQ6EBUbeH37/VbCqbBZQN3F/JfYxh7upPI6yC6mWRSoQTIIgFOBObFK
 gR3nnd8RIUi8D8rZiUklWtZjisBRFxqobeQvSBcyU9VYUYOTvt7TXGmDwKzgUZSg6ORve52eKHW
 OwWCiA1SsP7LXTyT0yPaKQaG05PeiAthK5NZsG6at5b0BCTwHf0un6tkXj/NyDl59EPYmmfR4Rd
 xM/YnomHF/UvrvawbiNgNbtyr13eSjD7aGuHYmsvSE=
X-Received: by 2002:adf:fcc6:0:b0:45e:8866:e58d with SMTP id
 ffacd0b85a97d-460302ed4c7mr28626880f8f.11.1781107998297; 
 Wed, 10 Jun 2026 09:13:18 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/71] target/arm: Enable FEAT_SME_LUTv2 for -cpu max
Date: Wed, 10 Jun 2026 17:11:45 +0100
Message-ID: <20260610161202.2235298-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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
Message-id: 20260609192110.752384-29-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 3 files changed, 3 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index b8f452f2f9..9ff4473154 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -165,6 +165,7 @@ the following architecture extensions:
 - FEAT_SME_F16F16 (Non-widening half-precision FP16 arithmetic for SME2)
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
+- FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
 - FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 1c0c404b7c..06c14e82ea 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -222,6 +222,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_faminmax, ARM_HWCAP2_A64_FAMINMAX);
     GET_FEATURE_ID(aa64_fpmr, ARM_HWCAP2_A64_FPMR);
     GET_FEATURE_ID(aa64_lut, ARM_HWCAP2_A64_LUT);
+    GET_FEATURE_ID(aa64_sme2p1_lutv2, ARM_HWCAP2_A64_SME_LUTV2);
     GET_FEATURE_ID(aa64_f8cvt, ARM_HWCAP2_A64_F8CVT |
                                ARM_HWCAP2_A64_F8E4M3 |
                                ARM_HWCAP2_A64_F8E5M2);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 7a6f1c6601..7f79ee645b 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1394,6 +1394,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, F64F64, 1);   /* FEAT_SME_F64F64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, I16I64, 0xf); /* FEAT_SME_I16I64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 2);   /* FEAT_SME2p1 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, LUTv2, 1);    /* FEAT_SME_LUTv2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
 
-- 
2.43.0


