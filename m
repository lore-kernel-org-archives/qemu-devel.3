Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAE9C4452D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmFXs-0003Wi-Nq; Tue, 21 Jul 2026 14:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFV2-00018L-1q
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:29 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUz-0006i5-6a
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:27 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c998fd549a8so7709323a12.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784659644; x=1785264444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=veqhogoqyls198dbcRhu1qq+EqvvsqzxKAimddpRnic=;
 b=MoUT1W9IlbQqw05gnyZOj2QfwL1O/vLu5CWiLIDVMZt2s0B6RgGEcK8U4hQn5Cla6O
 rlbNYkvodrsVjAa4oF0q/8ptYUKGB6BRfAkdBP/PbZ+N53IRSzTLX3/4Zy0cGMtwxYlC
 KP4KJC/xZzmHSSPVxBDzsqW+10Dz7OvYJid3yaYRunJ+U4fZdUI0KMS7ggWx6L9bxUzn
 g2dzeAWp5+8+rksJZythhrrzpJO0+d6vU+YhNw6S8xiwd0CVTIm7P6hx55ra5E58j3/z
 5P8Xt+cXV/lW3QTSpY3suMGsTuh/lw/85P/2TffydhqIFVp2SpJJmem3p5R2++I03Pa5
 8Jbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659644; x=1785264444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=veqhogoqyls198dbcRhu1qq+EqvvsqzxKAimddpRnic=;
 b=FgsvCcB4D7cm8guq0hPnQtZ4d1LrDiKMpo8kG03BDbal1p4BDAh3jvz8bJC708A68w
 vU/c8LDDMRJcVxv1mHEdTO9YvMbcL+WtYE4Z7weOkAGjqZNuIXaT0/ilABR8tKSI0HI9
 sXLR3jSuh1E9w34UU3KgBoyAYr1Cx6/cGa/c6cT0hG0de9Q2+nKMV5HL1fElKwcLlowK
 usOKBb1GSOB9efjdXwO3JughTx93sO0PdVoeuIovjsQegR7fKC265yLbMLAxSbqBGWef
 t2oW/0oXap7DDm7vFhkxrCsLSbjIHV6f86Iou52mzH7LHOKu9kdH+49fu8x9XUW4OOFs
 rcdA==
X-Gm-Message-State: AOJu0YwFomRobM6ZFTuZXLA9EbVTuqWQPBjCtRTfM9fO9mcgV10HCgfk
 eMaKw1Ri5+5JS3/y4cmBVlMPIvLL8OMdfqGNFaVXfOvxBiSOLdiD0qdReU5OAjeH0SSUvzkx2v1
 mhroi
X-Gm-Gg: AR+sD13BIwKyV3dUGUr+9AhfeMKk/Q0IY4wEfjzf+qlX1BlnC7x/1VOT8gV7uAt2jM/
 rpnjNvFy7bm/vJJZcQ/Ir74ug0zi/aysNXh3NZWW4IWuAVN/9Dz4yG5km/esW8A7gnmarYlk2Us
 0ujAKE3zqyEcPgu1NaiQW5/iqBbYs7ZU/iYoOORwx6ayCvLfadUQzWFj6wmpUOssk7kbXx/LmgW
 jj+vIK4c8cq7Heox/aVzXywqiLYmPTVifTgM25FreO9QiAWDf9UpX4zQAMEMHG3qqE5Y08OvJoj
 inluQSbA5fHALLAGvnBwYdBCW/YQ7BZvRs8ZUcWfj4x9++3V8PmpYA1oRmGQW0FHZ+93BPRwZb0
 EXdBoJ8nqnHH0iDdgAvCXbBWgi84o1/IFMwnXgwv7Zh7SBfp4BAw7ZvxFyiB6iIt0HT8O+yerjV
 ROVLSuEhg=
X-Received: by 2002:a05:6a21:6110:b0:3c3:a140:938a with SMTP id
 adf61e73a8af0-3c3ad947db0mr22396841637.45.1784659643388; 
 Tue, 21 Jul 2026 11:47:23 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29e340esm41108094c88.5.2026.07.21.11.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:47:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 20/20] target/arm: Enable FEAT_SVE_AES2 for -cpu max
Date: Tue, 21 Jul 2026 11:46:56 -0700
Message-ID: <20260721184656.530230-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721184656.530230-1-richard.henderson@linaro.org>
References: <20260721184656.530230-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 2 +-
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 4359312ee3..f87f22f690 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -182,6 +182,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_sme2p2, ARM_HWCAP_A64_SME2P2);
     GET_FEATURE_ID(aa64_sve_bfscale, ARM_HWCAP_A64_SVE_BFSCALE);
     GET_FEATURE_ID(aa64_ssve_bitperm, ARM_HWCAP_A64_SME_SBITPERM);
+    GET_FEATURE_ID(aa64_sve_aes2, ARM_HWCAP_A64_SVE_AES2);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index c7f8217cb3..23612cd22c 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1366,7 +1366,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
     t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 3);    /* FEAT_SVE2p2 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, AES, 3);       /* FEAT_SVE_AES2 */
     t = FIELD_DP64(t, ID_AA64ZFR0, ELTPERM, 1);   /* FEAT_SVE2p2 */
     t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* FEAT_SVE_BitPerm */
     t = FIELD_DP64(t, ID_AA64ZFR0, BFLOAT16, 2);  /* FEAT_BF16, FEAT_EBF16 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index fbc98d47d4..cb6c4ffd4a 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -198,6 +198,7 @@ the following architecture extensions:
 - FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
+- FEAT_SVE_AES2 (SVE multi-vector Advanced Encryption Standard and 128-bit polynomial multiply long instructions)
 - FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
 - FEAT_SVE_BFSCALE (BFloat16 Floating-Point Adjust Exponent)
 - FEAT_SVE_BitPerm (Scalable Vector Bit Permutes instructions)
-- 
2.43.0


