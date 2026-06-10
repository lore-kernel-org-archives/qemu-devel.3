Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B567DCD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYn-0003zs-Ov; Wed, 10 Jun 2026 12:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYm-0003wB-Hb
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:44 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYk-0006gY-IH
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:43 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45eeba68948so5012815f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781108021; x=1781712821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uRTwcqocnJpCUDaGXYCby0OmO/91zwV4EYa90KBUQO4=;
 b=Ko0ETs2Z5nYwIK93rkTJjL4sgCbOUgcohT7ZfSwv8bcNE2bqRds6sA5mZNq6b66WAy
 aXf3pbUG+Trze2q8S9qG0dldrEeYNSOxEUpw5Ea39LQvotRzJ0DYw1mftq/ICx9z/OPl
 tkWtsBg+TadnbOLUro97TGl728mqhtGiKTeZqIb7LUY4CesOEGOMittNt1pIbxWsfjUv
 0kAiycO6DxsM4w4esIPvyS6CB/d8Tt6zBP9Nh67SaMJmhTx05KjfnjNFciBSqkphKoly
 Y2v8HHdzcuW7A8CwPA6y6BE48IUcl5TRSrcvnTH98d9zxY2rmnCaXZZGvRV+kR9gF3zd
 pYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781108021; x=1781712821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uRTwcqocnJpCUDaGXYCby0OmO/91zwV4EYa90KBUQO4=;
 b=ZSo5VXgAFQOxIYRsGqVr3BFBDVQLGKqsYW6HN0YoDF0LM28qFmyRIKl4GIT6E9J696
 n1T3O2FlTNvt9lzN7EkKgrUPMs0SH0M2p/KVoFfIYuI2ePzRmlpSzyz0XhOOsYaFCq3A
 bfgGUQurK580XefoxFurqYn1sgDC6+oUl4nR2qvUQmukA/91Bm0B5BNleahaBnGRy/Jp
 9CHhXjfaP/Tybi6MtGKlPDBoL8U0XiQS8hIJyT9anHmO3kzEPGhq6z0V2R6l9Nn9LYyE
 5VTCn31tKtBgRe9NlBIED2gKCPYwRBDfGr9vgPBITtfn0wGJ9eMIQbKI7rlK89G0vU5a
 4WFw==
X-Gm-Message-State: AOJu0YxO/ruyfXzswO8qDsMyIIiD4mt9ZQY1PLyH4zGHxZTw2FMl83+K
 B9q7VqAlKqvWvlN7Df6TRLeDPQfunK9RSgTD4l+QS8ZsCfkKZMJtKAAtWpt4vY3ZyfqVa5v1jBt
 Iel07
X-Gm-Gg: Acq92OE6G/Vp/y6lsalJGs+crhyJj63W2gH3BTr1ZRCXZetNwb+a3qpqbx2n8tdnUGb
 Utt2UZwl/dCbaVbXMZYSeh4VXoATHlNwrPX45mI11heMhQHJnlRxT4jx6y2t5sFy/bhTvDH0myy
 ZH6HrJlUN/xAq/7dIrySHr+oFMeo9Mmfru6oheto6Z8Q2bZCw+qNuqbcgxNFxRp8MTsP0vqXWy5
 m4tg4zqalk0pFb7c8bE0uRBYSD5mKudU7iUccUBPiSZ/1vtx9Gdu8jhJkGMp5ms6pdGL9BDxAnp
 +Of+lf7JhJ1vswg215jlWd9TjoCm8625glf3nT66HOfRxdeVugbX32SjDMvZ28Qis8dcjvti1sa
 XfzwuJMZ2xz+ulOyEDsohwsONXdVgZNTUQYVaXbWkJf2G3Pb9c7IY4uKz7SD7t+v/szNcRVggv6
 /SDjIFT4BxHw55nWzw9lUiCI95OO/UuplWNYWuh9i6bn3x8NZWm+uIR9x/g3GQ8KjfNcrkCujBZ
 OLJXgwluB870nicNY4qS32xgJt+7QqI2kE/PL74tSA=
X-Received: by 2002:adf:f503:0:b0:45e:f2bd:2b16 with SMTP id
 ffacd0b85a97d-46030501b6bmr25122297f8f.18.1781108021053; 
 Wed, 10 Jun 2026 09:13:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 71/71] target/arm: Enable FEAT_F8F16MM for -cpu max
Date: Wed, 10 Jun 2026 17:12:02 +0100
Message-ID: <20260610161202.2235298-72-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
Message-id: 20260609192110.752384-46-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 3 files changed, 3 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 56da6baed9..a8072ddb67 100644
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
index 0f2ce592d1..f7a920a202 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1404,6 +1404,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8MM4, 1);    /* FEAT_F8F16MM */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8MM8, 1);    /* FEAT_F8F32MM */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* FEAT_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
-- 
2.43.0


