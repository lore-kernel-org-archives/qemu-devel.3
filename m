Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF5DCD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX28p-0005cx-CS; Tue, 09 Jun 2026 15:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX24x-0005i4-9L
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:25:43 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX24u-0005Xa-7Z
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:25:38 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2c0c2d792c8so40197825ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781033087; x=1781637887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZhUQtrZgH1sNCcu1zDpkvoAehYLcJxzUn96qi4Hts0=;
 b=Xp8JUk23s/+wTuSeRu4kpl/orQs/vRfkNmfeh+mx+JEbeQBsHXbOsCR3RTOqhobcpm
 lMknCfWVYI5JjQmXrldG10+VWOxAD9uSCIk8s3aTj4FS9ln808p6SGIVmfkPWFaxR2Db
 8SHExNHdCusXyWTRV+pBO1znp4WVrGGFX3pbdfkoez/zgzgb/r3h0HKxaddljDpqkF8f
 XqWek3hDp41V/0hpc6A+iuGufZMYQwGzT1r0qTUp4Lm47mK2gLdy50hG6AyePSeL0vso
 /ugrGu8g9f841iyNyoLsBzmOuoJZDeAR5WP83w1EvhQvUbbSTQRvtJSG0o2a5pav7g5p
 Jm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781033087; x=1781637887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MZhUQtrZgH1sNCcu1zDpkvoAehYLcJxzUn96qi4Hts0=;
 b=RLld845ZLxfLjjH0dBktvlYkaD1iIClLnq7g36ZKvARyycv2hJz33bUqfIRRT5CGC4
 hlNVhD44/UV0w43TB6E8FElnMLsD4pWS5Z68H6rmNlxVWaROKaR6n5VuJ2EZ3daDXOB9
 gjWbF6MlmzGzFjH4vq175sQXfLJtoQbAqxd/5eceS+WBz5iL1gG9Y6eiMCa7/ZluKA99
 29pr2/0UqnwOqX8W5hC/qomiy0dI1uWiRapJzEJwM6vRDdAGA9O7xW/+BH7UUSKq69Dj
 6euQhKriw+pXwuvGBBWLpDYzaDRmJUAjnyJWY2yvisP+h4JygR/gfHLral5Ukr7BN8g/
 cJZg==
X-Gm-Message-State: AOJu0YycYNIk2ezPAZ5BtF/dbHkR2T7k9GHjWs/ZULNqe4WvTip2SZt3
 aZsECrDdvQ9bPmhcuSBQNZlFRau7ul87i9QNUmnhktsQE7VAwulaZdwMNIagdXRleRozF2k0trS
 Wpiz3AmU=
X-Gm-Gg: Acq92OGX9gUK1hnMQf4tX4njeVP8cFTBssm16dlo14YQCwbxIQ7Z50mysKQ+tb/UBi0
 heFK58QJ2qD3+nu0Zh0Ur6nU86pXatwo2GLlPdtIEoCryzfi68pKYy8jx2+RB6EzJ1XAcMgLF2N
 aqg0gdTLFSCJm4tH4iSmJ4czccZJA2Lg97m+0r9y/1r4EfZh8j14kSxexzSLoqZx543ppFgbOEq
 Cmu++RB2NPjdIC94y2+iTaaMoFV5h+knV7NUKn2Upx8yavo//SaOW3X23NNq4CrJnwSsGQWvapY
 YJ0Pn/GUDRNQ8GAQbZ73Us4AfCYQnJZAJ1yzGDqN3R+J/u2nt21OwChNtdKDYW3ktFmugjoAAZb
 DhQNrEpR+ZvZ/R7elMI5r7DrbjQjFh9xSE2eUeZzobmJmLWX/VnOAk4gb0RkFEKahRQzFdG0HNW
 sD4SQnKF2yrqaZsi6waoacqgSxdtNiduz4zj6dQx0=
X-Received: by 2002:a17:903:8ce:b0:2c0:cb0e:ac3a with SMTP id
 d9443c01a7336-2c1e7f91985mr244243175ad.23.1781033086405; 
 Tue, 09 Jun 2026 12:24:46 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164fa00b3sm212247045ad.32.2026.06.09.12.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:24:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 45/45] target/arm: Enable FEAT_F8F16MM for -cpu max
Date: Tue,  9 Jun 2026 12:21:09 -0700
Message-ID: <20260609192110.752384-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 3 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 7864765ba0..4887a3a7b7 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -172,6 +172,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_gcs, ARM_HWCAP_A64_GCS);
     GET_FEATURE_ID(aa64_cmpbr, ARM_HWCAP_A64_CMPBR);
     GET_FEATURE_ID(aa64_f8mm8, ARM_HWCAP_A64_F8MM8);
+    GET_FEATURE_ID(aa64_f8mm4, ARM_HWCAP_A64_F8MM4);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 15dafb9aee..15c1ece4b7 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1399,6 +1399,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8MM4, 1);    /* FEAT_F8F16MM */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8MM8, 1);    /* FEAT_F8F32MM */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* FEAT_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index dcfb4f2073..64b2a87e1a 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -67,6 +67,7 @@ the following architecture extensions:
 - FEAT_EPAC (Enhanced pointer authentication)
 - FEAT_ETS2 (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
+- FEAT_F8F16MM (8-bit floating-point matrix multiply-accumulate to half-precision)
 - FEAT_F8F32MM (8-bit floating-point matrix multiply-accumulate to single-precision)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
 - FEAT_F64MM (Double-precision Matrix Multiplication)
-- 
2.43.0


