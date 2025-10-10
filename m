Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8286ACCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cpk-0006S7-Lj; Fri, 10 Oct 2025 09:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpU-0006O9-G3
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:43 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cos-0003tL-6U
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:39 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ee1221ceaaso1495470f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101559; x=1760706359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sSydecAbKfM/Sk80G4rIV2ZnoCty/L+1TLVKi2ojoeg=;
 b=h4ARH/CaCgIbqWimKg3Op2xdVSu7XsLerCAJmj63+7Lv1vzRx10dvmHK7w99duVjp/
 FyMInGTSkH65nF75QOTJQ3cYdOAkXnOShMfEDQMxoSNkjms7V+VHMfLjPZdmJNUz4Lr/
 oHr+Pa/65xpy/WZYSjbJJdj8/YhZI7Oz7jpswpVNt+mkz9P1MhuYA9MvWJy+9Cz1sMFq
 N/ttVP9ZugVOt/2u4JDuYDF9qrBrW63kqJcV5ZLMqGgWQwDLooy9l+fyBFZ2PP5AL+jV
 Tg3flzmHkskQfudTZggW4LMDZCXChEQhcalBhAamIMpoM9+k5yLgjz8YxZUAtPYDi6Gk
 GPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101559; x=1760706359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sSydecAbKfM/Sk80G4rIV2ZnoCty/L+1TLVKi2ojoeg=;
 b=TwpdXgbBhjtFXokTKF5p2TMU/lAiYUzO1qA3w88kjnjoy8EHsILgcq4uL8xg3Anlwr
 OVxxffkpKP/0s2fJDgec4KfotjPPCfbIJvHmQw5V6kn+DPRcEFeHq0LDhrC4Hc8Bxe2t
 hqyTfLtvpYNkaEsc/xgP4XBaMG3YFAAbtToeqamSNDN4gU7ldsbH1tCSPkwJS63hQF3c
 GMT7LN06mp06Z3sS3WSjLgYFKBsXCJ/9HhJEO5VmWObKFw9GcMwMGAYoGrRRgojK3OCS
 ytCzCVuBCCL7G5tOUitmnNYnQezCU5tVtrje4pi01IFhyrQD0ZHCGf4g31WUDsS7hiSX
 ELNQ==
X-Gm-Message-State: AOJu0YwqDve2tKF6LS1FRg+9iIi13lhOfUgsPC5uKFCFyW3qw8dxxhny
 Yj9O9WRYu5QnXse/GWl6ZKDOgBpGAxS3HBt0beQFX+w9zKpUVYeiczVKcpUG4wWI/pTUmAKYVEM
 NV0Vd
X-Gm-Gg: ASbGncvLx+xF3SGoaSeCyZFoaELncPXzJ3sTcyZSLQ6Bi9gS9o6Q7JnSu1EgY4lSDP9
 bscf1aHRcKnWp8+dEsB/FBF831P50LL8hFEKrBT1kpjAbL6StEs0k7RZmTFbW9tdWO6/4MytlS1
 DXbNDPxg08JZmL9iqlyEQZVBnBTfF3F+1KQeR4jVnmbxyRFqn2V50AzNjfD2LXJKWSJ9zK9tfr2
 LD4orJfHDrppz4CpfsDxoK62FdzW1H0wIpf8K58abywDST2K8V0z87OEyQFelbl7M7v6iCNQQ/5
 pswO1cJeCXabqO17XZEVRrM27VppSGZs6OR/nzZu5r9XG3CFdzI+PQ1XayMQ61nAltiC+A7mMk3
 i7Y0pC4siLuNnJL5W5cD+pAw2vX+47NWnC0CVm1tmXeS8m+SQbkbJvkiFr9T/Lw==
X-Google-Smtp-Source: AGHT+IF3JRfpIWf093/ugvEDCAedKGVO3ZSDsk3Df8a6xtPa+cVCgGZ0+pJfvCGh6WaEZczX0hbxkg==
X-Received: by 2002:a05:6000:1867:b0:3eb:b80c:cea0 with SMTP id
 ffacd0b85a97d-42666abbbabmr6297894f8f.4.1760101559223; 
 Fri, 10 Oct 2025 06:05:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/76] target/arm: Convert regime_is_stage2 to table
Date: Fri, 10 Oct 2025 14:04:37 +0100
Message-ID: <20251010130527.3921602-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

This wasn't using a switch, but two comparisons.
Convert it to arm_mmuidx_table for consistency.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-27-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h       | 5 -----
 target/arm/mmuidx-internal.h | 8 ++++++++
 target/arm/mmuidx.c          | 5 +++--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 92883b6c0e4..591b509e68b 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1027,11 +1027,6 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
     }
 }
 
-static inline bool regime_is_stage2(ARMMMUIdx mmu_idx)
-{
-    return mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S;
-}
-
 /* Return the SCTLR value which controls this address translation regime */
 static inline uint64_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
diff --git a/target/arm/mmuidx-internal.h b/target/arm/mmuidx-internal.h
index 55fba4aae26..1d948aa6f4c 100644
--- a/target/arm/mmuidx-internal.h
+++ b/target/arm/mmuidx-internal.h
@@ -19,6 +19,7 @@ FIELD(MMUIDXINFO, 2RANGES, 6, 1)
 FIELD(MMUIDXINFO, PAN, 7, 1)
 FIELD(MMUIDXINFO, USER, 8, 1)
 FIELD(MMUIDXINFO, STAGE1, 9, 1)
+FIELD(MMUIDXINFO, STAGE2, 10, 1)
 
 extern const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8];
 
@@ -84,4 +85,11 @@ static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx idx)
     return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, STAGE1);
 }
 
+/* Return true if this mmu index is stage 2 of a 2-stage translation. */
+static inline bool regime_is_stage2(ARMMMUIdx idx)
+{
+    tcg_debug_assert(arm_mmuidx_is_valid(idx));
+    return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, STAGE2);
+}
+
 #endif /* TARGET_ARM_MMUIDX_INTERNAL_H */
diff --git a/target/arm/mmuidx.c b/target/arm/mmuidx.c
index c5b43a59327..61a682e655d 100644
--- a/target/arm/mmuidx.c
+++ b/target/arm/mmuidx.c
@@ -14,6 +14,7 @@
 #define PAN    R_MMUIDXINFO_PAN_MASK
 #define USER   R_MMUIDXINFO_USER_MASK
 #define S1     R_MMUIDXINFO_STAGE1_MASK
+#define S2     R_MMUIDXINFO_STAGE2_MASK
 
 const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     /*
@@ -33,8 +34,8 @@ const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     [ARMMMUIdx_E30_0]           = EL(0) | REL(3),
     [ARMMMUIdx_E30_3_PAN]       = EL(3) | REL(3) | PAN,
 
-    [ARMMMUIdx_Stage2_S]        = REL(2),
-    [ARMMMUIdx_Stage2]          = REL(2),
+    [ARMMMUIdx_Stage2_S]        = REL(2) | S2,
+    [ARMMMUIdx_Stage2]          = REL(2) | S2,
 
     [ARMMMUIdx_Stage1_E0]       = REL(1) | R2 | S1 | USER,
     [ARMMMUIdx_Stage1_E1]       = REL(1) | R2 | S1,
-- 
2.43.0


