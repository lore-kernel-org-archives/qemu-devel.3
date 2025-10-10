Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34594CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cpk-0006RP-1r; Fri, 10 Oct 2025 09:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpR-0006Ny-F8
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:38 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cou-0003t3-TU
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:37 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e52279279so14550395e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101557; x=1760706357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tgxDCeYY+hPQV5P9VqVCtdojob7RiRndVUUkk5KB/ys=;
 b=fRVLa/a9UJq9PCI7MJS8vbVrlNIgwtPeHR5UpdBkBwYMU8tisScqlRi0JLeYLizaZw
 3ZLN5SG/tQp0V6xYDFqAe1WEQbd55ti3n3mheUsS0ljD4Ye9rpwOJzAKBYrJTvJ3CRv6
 gLUsUW4KG0a70QFvrYAspUxLm326YB3UaS1r4gGZEPWyjhPfVxMyzTyYjE0nJwI29D2e
 EYS15gBfVraLrdSNj5p8sY6XXBHpKGYBGRtt90ifjMkkxbZz8j4y6X5GXHENfvXru6xQ
 RsbqUggDgqo6lUqij44hWISKMpTYl5qVou5X7/Qch6vPHIRz2qmPxuhL4BhqxqgZpugb
 dXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101557; x=1760706357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tgxDCeYY+hPQV5P9VqVCtdojob7RiRndVUUkk5KB/ys=;
 b=FfVQ+nJDmsjoS//55diFuNi8L2VUeCrX/63iuiyCTilHQncIPOMmD+cBxKgJt01Zjh
 WDhZtooGD+D2nSVVmBrzU8kN59EZDbhQdcClAp96gppYh58muweSPEHnOHBOEPm9Dkem
 kMOg6SAuX+3gIOvxoh2BKAajJDn2xrej3CPaWQd6QUumeEC7beTMY6Bodivcg8v9QvSn
 ZdMEuEy/cPsurrst7BZ8RCvFByeNY7NDDbatErn0ppaR+PJTaDyIRIkkGwaI4SNvpaQR
 6smKzyCqAUng39Udv3ncIXbX+X3esaxXfRxM6xQxiyKsQF6oUOi6B8m1njAepEfJ58ul
 kKyA==
X-Gm-Message-State: AOJu0YwoME8VIhpunonUUC6Vs0T1MoRsyUztp0XJ6DFSlyyvBG+3rxaj
 +ksOeJ++Rq8qr2Q9YXAMA867160ldfdoNagjm3ocQ/p228BWbot5RiE7ofx+k51bPS7eljba0Eb
 W+Hld
X-Gm-Gg: ASbGncvhHP7z5HpkwkhgiK/ZWAO2DT8rxppVvfEQsnVsk8OLAtta50E0szewtcKXmVH
 NNGmL4/DHeImhjOV3ySQ5n3ufKqCyW0khbzVRBZ07lixHt2WcScju66kuPkX45eK33YVbjjHytI
 2rmOtKCTgQ9joPq7PGFUQ/nz/h8WCg4l1lyidbFhE9rAje2Pmpmag0vj9SfsuWSPxb/DOeOmHO9
 sEp5XfbInzWm6LaQfIN+GZPhhntNqplPTOoxwNojSKq82xoxYX20Pj1KOOHftdwMFG4fbhBJMNA
 oe0COWWZ9wK0QWiZ4aeHgy696e2wXu7H2MK4nxl0M1GmzhR/+7WFA+Aty/HqtA62q5NkeOErvNk
 M2HTmlZkg222p8prDxgyweSF6taCzR8GJLm2mKeIg1ydLVy9CPwNeOZdxO7YFcA==
X-Google-Smtp-Source: AGHT+IEdnoZea13FJpMsH1WlJER/GtgLOwN7awe0IooajhzOKU4xg4WiiAr7X4bUjxxzJ3rjO1Qt3g==
X-Received: by 2002:a05:600c:3f1b:b0:46e:1a14:a81b with SMTP id
 5b1f17b1804b1-46fa9b17e09mr73281885e9.36.1760101557385; 
 Fri, 10 Oct 2025 06:05:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/76] target/arm: Convert regime_is_user from switch to table
Date: Fri, 10 Oct 2025 14:04:35 +0100
Message-ID: <20251010130527.3921602-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-25-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h       | 17 -----------------
 target/arm/mmuidx-internal.h | 12 ++++++++++++
 target/arm/mmuidx.c          |  6 ++++--
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index d0d976cbb08..c4aef8b50e5 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1032,23 +1032,6 @@ static inline bool regime_is_stage2(ARMMMUIdx mmu_idx)
     return mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S;
 }
 
-static inline bool regime_is_user(ARMMMUIdx mmu_idx)
-{
-    switch (mmu_idx) {
-    case ARMMMUIdx_E10_0:
-    case ARMMMUIdx_E20_0:
-    case ARMMMUIdx_E30_0:
-    case ARMMMUIdx_Stage1_E0:
-    case ARMMMUIdx_MUser:
-    case ARMMMUIdx_MSUser:
-    case ARMMMUIdx_MUserNegPri:
-    case ARMMMUIdx_MSUserNegPri:
-        return true;
-    default:
-        return false;
-    }
-}
-
 /* Return the SCTLR value which controls this address translation regime */
 static inline uint64_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
diff --git a/target/arm/mmuidx-internal.h b/target/arm/mmuidx-internal.h
index 41baf1a003c..3e51c0f5790 100644
--- a/target/arm/mmuidx-internal.h
+++ b/target/arm/mmuidx-internal.h
@@ -17,6 +17,7 @@ FIELD(MMUIDXINFO, REL, 3, 2)
 FIELD(MMUIDXINFO, RELVALID, 5, 1)
 FIELD(MMUIDXINFO, 2RANGES, 6, 1)
 FIELD(MMUIDXINFO, PAN, 7, 1)
+FIELD(MMUIDXINFO, USER, 8, 1)
 
 extern const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8];
 
@@ -64,4 +65,15 @@ static inline bool regime_is_pan(ARMMMUIdx idx)
     return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, PAN);
 }
 
+/*
+ * Return true if the exception level associated with this mmu index is 0.
+ * Differs from arm_mmu_idx_to_el(idx) == 0 in that this allows querying
+ * Stage1 and Stage2 mmu indexes.
+ */
+static inline bool regime_is_user(ARMMMUIdx idx)
+{
+    tcg_debug_assert(arm_mmuidx_is_valid(idx));
+    return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, USER);
+}
+
 #endif /* TARGET_ARM_MMUIDX_INTERNAL_H */
diff --git a/target/arm/mmuidx.c b/target/arm/mmuidx.c
index 98db02b8e54..1c1e062bfef 100644
--- a/target/arm/mmuidx.c
+++ b/target/arm/mmuidx.c
@@ -7,10 +7,12 @@
 #include "mmuidx-internal.h"
 
 
-#define EL(X)  ((X << R_MMUIDXINFO_EL_SHIFT) | R_MMUIDXINFO_ELVALID_MASK)
+#define EL(X)  ((X << R_MMUIDXINFO_EL_SHIFT) | R_MMUIDXINFO_ELVALID_MASK | \
+                ((X == 0) << R_MMUIDXINFO_USER_SHIFT))
 #define REL(X) ((X << R_MMUIDXINFO_REL_SHIFT) | R_MMUIDXINFO_RELVALID_MASK)
 #define R2     R_MMUIDXINFO_2RANGES_MASK
 #define PAN    R_MMUIDXINFO_PAN_MASK
+#define USER   R_MMUIDXINFO_USER_MASK
 
 const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     /*
@@ -33,7 +35,7 @@ const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     [ARMMMUIdx_Stage2_S]        = REL(2),
     [ARMMMUIdx_Stage2]          = REL(2),
 
-    [ARMMMUIdx_Stage1_E0]       = REL(1) | R2,
+    [ARMMMUIdx_Stage1_E0]       = REL(1) | R2 | USER,
     [ARMMMUIdx_Stage1_E1]       = REL(1) | R2,
     [ARMMMUIdx_Stage1_E1_PAN]   = REL(1) | R2 | PAN,
 
-- 
2.43.0


