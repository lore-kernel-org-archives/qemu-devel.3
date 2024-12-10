Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E030BE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2kO-0001hP-1D; Tue, 10 Dec 2024 11:06:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2k2-0001Nj-PW
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:05:44 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2k1-0004ds-6f
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:05:42 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-434e8aa84f7so31382325e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733846739; x=1734451539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kGY83EyKxuvPM5IyRxuK3ovsjOlPKnkdROIg+ri5KTo=;
 b=BZInvBhaJqZj6uQab0S2oGqIcnZcUIrdjsdxD+oR+FK/XN14J57wz7CofWbsDWuIMz
 7+ghFy/uRwx0NPBjHdo2NQHkFvbT0jPvDfTje1eJCjapph85xIHUlYtcCsBVVttQeuK1
 VynSyhwWtxQawZ4axUXtGKqawhlHJlxgDgSQljFvYhe/Eg0HJdCnNxZsNooI7CkHx3nr
 TkfN5oKj7Bdm+uYmkc0K/1wPltlBQYCt6fvg99OKGVyyoaYfFTNN4vXHrJSxeEDe9FKy
 UB4ylzzo5s5/SR69ukrBLuSR8EvpsFwpA6NgAvuz6SPH+T3o1VBjVZtHDZ3ABSCnklj0
 vwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733846739; x=1734451539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kGY83EyKxuvPM5IyRxuK3ovsjOlPKnkdROIg+ri5KTo=;
 b=FT+eshX7mxjamX8nn1FevtHNkO3RJl/PajLZV43izvG749C9MRNAB7BAALnhIbv0mN
 KniHDIF9QMA7rKdam5Fbkec54Xzhyvcoy+BG/G+cWfesyrfN0sQoOt3naxvjEm8v9Bez
 x5y0NGhCm0GHZf6pSfTzNBZ5jQSF1HcUg8lAMbr5eZaalfgfskTczmeSn86PdTwuLnTS
 6gOrAZing2yhh5pcE3myz/RTnFhh0lTYJWiO0oXW/JyyaBJYWiLamrSZU/vWcgHqmTnF
 ETjZSBBaT4iUTxe3G1t2rPhO0GCQaJyrP7stYNZhicyhLEo5hfr+cYUu/KGCJwPY+p3u
 nukA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyg9TfaV33fDkIO0J4DeSiN7W7YEIh5Qgkt90N70AHvZSycfz6WbJ+a1lW5j8dPWIbVRooi8U2yEBE@nongnu.org
X-Gm-Message-State: AOJu0Yz9c68/zez1zsj7PpE1EQ2PWGoQkYYj9xgMvfTEODq7D1YbX4cG
 bEp4pKmYCwAg8H+d5NJWz00tNz1vA/ezwqVekLzAEvJSp86Xp+HpurR1CqO4ITdyAg6vRtf0Q33
 0
X-Gm-Gg: ASbGnctphPQyKMtyGrZfF83SbYx3aFa5OvGlV7rwIZjOWy4dz8wwltveOoBIQRGEJVt
 fJyrBlD6AqTIr56rWv3+IewwL1oEXqCvGYk+HH0YGRM9A/JhvIanmXUI8MsIalTXDdmrhYH4UaL
 wNyxOxLjEaJDOAFvOFf1zhV6tBwaQz0rIodSUupZ1bfPyvcu/e9CR5xDitbQhSFV66Wtn1+rhz6
 5Vii4JzeOGI6/roCkXWm2A/XZqTTCRl4M5SyJdtUkrfM/35oCUU+N2kGkBA
X-Google-Smtp-Source: AGHT+IGo/RiwcHCrI+S1tazZPluP4OwfpXWld/28XiGm7LhGpzZM0Wq+nsRItLKV+he8ykZu8QJfUg==
X-Received: by 2002:a05:600c:4ecb:b0:432:7c08:d0ff with SMTP id
 5b1f17b1804b1-434fff98709mr41318165e9.23.1733846738223; 
 Tue, 10 Dec 2024 08:05:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434e8ec8072sm124671605e9.18.2024.12.10.08.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:05:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 10/10] target/arm: Simplify condition for tlbi_el2_cp_reginfo[]
Date: Tue, 10 Dec 2024 16:04:52 +0000
Message-Id: <20241210160452.2427965-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210160452.2427965-1-peter.maydell@linaro.org>
References: <20241210160452.2427965-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

We currently register the tlbi_el2_cp_reginfo[] TLBI insns if EL2 is
implemented, or if EL3 and v8 is implemented.  This is a copy of the
logic used for el2_cp_reginfo[], but for the specific case of the
TLBI insns we can simplify it.  This is because we do not need the
"if EL2 does not exist but EL3 does then EL2 registers should exist
and be RAZ/WI" handling here: all our cpregs are for instructions,
which UNDEF when EL3 exists and EL2 does not.

Simplify the condition down to just "if EL2 exists".
This is not a behaviour change because:
 * for AArch64 insns we marked them with ARM_CP_EL3_NO_EL2_UNDEF,
   which meant that define_arm_cp_regs() would ignore them if
   EL2 wasn't present
 * for AArch32 insns, the .access = PL2_W meant that if EL2
   was not present the only way to get at them was from AArch32
   EL3; but we have no CPUs which have ARM_FEATURE_V8 but
   start in AArch32

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/tlb-insns.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index d20d32624da..0f67294edc4 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -1246,9 +1246,7 @@ void define_tlb_insn_regs(ARMCPU *cpu)
      * ops (i.e. matching the condition for el2_cp_reginfo[] in
      * helper.c), but we will be able to simplify this later.
      */
-    if (arm_feature(env, ARM_FEATURE_EL2)
-        || (arm_feature(env, ARM_FEATURE_EL3)
-            && arm_feature(env, ARM_FEATURE_V8))) {
+    if (arm_feature(env, ARM_FEATURE_EL2)) {
         define_arm_cp_regs(cpu, tlbi_el2_cp_reginfo);
     }
     if (arm_feature(env, ARM_FEATURE_EL3)) {
-- 
2.34.1


