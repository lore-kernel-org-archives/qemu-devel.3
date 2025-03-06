Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B93AC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqEGC-0006yn-HY; Thu, 06 Mar 2025 11:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEG3-0006nz-CL
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:39 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEG0-0004bT-Ak
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:39 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43bbd711eedso7121325e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741279174; x=1741883974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1PcIVTeLlBiv7qMlV9Lkx3x01wPrgzn/KuduCivbSeQ=;
 b=wvRxbPZO+rw+IzSf5/sQz2G6+PTyq3mEhv0KIDJC562ey531oPaTLFEy3ortMwDGLX
 Klr0s478YxnfzMF+LHwGcGAzg0zGauY1AlTuj9rjouPiFPoUPbxblVt7B4bhHvi1bZ0m
 7DES3GvdMeSXjz2Y/R43c62B3+wfzu/4k9lI7IoeZNtU+ONR4YfZd64LzXmC12mDjZ8V
 AG+rkJWbTzUiyo6+nMeJfbVPsbL9KXKkf0g9MzYBvtwoYMMvNAK1+zkm607yMDnY/u0p
 3uAJnCoEc2S6bSi0P4x+dhR9lHkYihox99zcdOUjge2sVdwwjZfHw+xPDOHDQGK9nDh5
 tcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741279174; x=1741883974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1PcIVTeLlBiv7qMlV9Lkx3x01wPrgzn/KuduCivbSeQ=;
 b=JBa/OQR1C/G2QY3ivNkAWlmaKiZYCg4F+0GNu3rhh7En9Ulugq8yRwft6AHfohPiMG
 HcdAjk5GyAdR/+0QILYDjiSCiFaWezrlVjj2BWHA/SKcu1T+w/lTXmapq/U48b20Wm0N
 Id/0HExgvN+aF+WYirVjxz6yrYlTz6aSYQMU7o9RBNzFKPub33kNCbaNbUpEhIuzzjbz
 Dw670jpFR6602dHAvn4Ls57SyJmCFauej9ucAHnpbzn38gzwqKVh7fgVOrubQ/h8JSJf
 pHoVkvLRQx/EhdQ+S8ltvu2dLji6qSyUayCw4zxn1flJlJF8l8+gPPDC3NTe1dqj1rVU
 n5cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVefBA9GikWf/kcLA5OfpyDF3dSX6j9oGoZla/6pK9HeM4q99MzedRdm3d7ibO9ynv4dOPIeporNSbl@nongnu.org
X-Gm-Message-State: AOJu0Ywix0pZcdoKyCnkuBcQrVZhSU1lhDCFtLOYj+hzfUzapIcWFmCf
 /3QmDjJs8QQopJXD/GkxCuPbLf0ZpD6E0glcL6dydnxzFrfhR1AFgV1FshokFUI=
X-Gm-Gg: ASbGncvWedZ08Psd0BaqaXrRcw3O3J7VuY0Q0dFE6rTZPapXbm4NtJPK17UIhDfI+k7
 wED+0fUEaUbg75/YMUq7gGeeLtYBjU04B20r+WewYj0KUPwf86/lpylfqCzd3w5xcHG9PZGh6iM
 i43sG/GkKBAe6f4vl4BG3Ljp+dqUcailz6U6Pl8vaeXUnLU96ZWqMuAaGbuUbDXuzxFgtEQbsd7
 qTGseRYySlGMpbcv3m1lwKgAY9Y7RcMJAe1RwMH6VxpIWDI0UqedXNAAfsgUuJTApAIP68ZeFJk
 LDqV3JSZLKWS6C9nAHt5SvsajJruXq/N9Z2PndkTtx4PHVovklY=
X-Google-Smtp-Source: AGHT+IEFJ4imgNuNQM/bPgnqMgt4xOAax8ZPe7SAUTEoQPoqJ0YjnJUIYqOT2sPGE3OFWzeaqQ4rhg==
X-Received: by 2002:a05:600c:3b1a:b0:439:6712:643d with SMTP id
 5b1f17b1804b1-43c5a5f95f4mr1371135e9.9.1741279173761; 
 Thu, 06 Mar 2025 08:39:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd94913fsm23999905e9.37.2025.03.06.08.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:39:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 07/10] target/arm: SCR_EL3.RW should be treated as 1 if EL2
 doesn't support AArch32
Date: Thu,  6 Mar 2025 16:39:21 +0000
Message-ID: <20250306163925.2940297-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306163925.2940297-1-peter.maydell@linaro.org>
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

The definition of SCR_EL3.RW says that its effective value is 1 if:
 - EL2 is implemented and does not support AArch32, and SCR_EL3.NS is 1
 - the effective value of SCR_EL3.{EEL2,NS} is {1,0} (i.e. we are
   Secure and Secure EL2 is disabled)

We implement the second of these in arm_el_is_aa64(), but forgot the
first (because currently all our CPUs with AArch64 support AArch32 at
all exception levels).

Provide a new function arm_scr_rw_eff() to return the effective
value of SCR_EL3.RW, and use it in arm_el_is_aa64() and the other
places that currently look directly at the bit value.

(scr_write() enforces that the RW bit is RAO/WI if neither EL1 nor
EL2 have AArch32 support, but if EL1 does but EL2 does not then the
bit must still be writeable.)

This will mean that if code at EL3 attempts to perform an exception
return to AArch32 EL2 when EL2 is AArch64-only we will correctly
handle this as an illegal exception return: it will be caught by the
"return to an EL which is configured for a different register width"
check in HELPER(exception_return).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 24 +++++++++++++++++++++---
 target/arm/helper.c    |  4 ++--
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index b3f732233f4..82a0e1f785f 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -392,6 +392,25 @@ static inline FloatRoundMode arm_rmode_to_sf(ARMFPRounding rmode)
     return arm_rmode_to_sf_map[rmode];
 }
 
+/* Return the effective value of SCR_EL3.RW */
+static inline bool arm_scr_rw_eff(CPUARMState *env)
+{
+    /*
+     * SCR_EL3.RW has an effective value of 1 if:
+     *  - we are NS and EL2 is implemented but doesn't support AArch32
+     *  - we are S and EL2 is enabled (in which case it must be AArch64)
+     */
+    ARMCPU *cpu = env_archcpu(env);
+    bool ns_and_no_aarch32_el2 = arm_feature(env, ARM_FEATURE_EL2) &&
+        (env->cp15.scr_el3 & SCR_NS) &&
+        !cpu_isar_feature(aa64_aa32_el1, cpu);
+    bool s_and_el2_enabled =
+        (env->cp15.scr_el3 & (SCR_NS | SCR_EEL2)) == SCR_EEL2;
+
+    return ns_and_no_aarch32_el2 || s_and_el2_enabled ||
+        (env->cp15.scr_el3 & SCR_RW);
+}
+
 /* Return true if the specified exception level is running in AArch64 state. */
 static inline bool arm_el_is_aa64(CPUARMState *env, int el)
 {
@@ -411,9 +430,8 @@ static inline bool arm_el_is_aa64(CPUARMState *env, int el)
         return aa64;
     }
 
-    if (arm_feature(env, ARM_FEATURE_EL3) &&
-        ((env->cp15.scr_el3 & SCR_NS) || !(env->cp15.scr_el3 & SCR_EEL2))) {
-        aa64 = aa64 && (env->cp15.scr_el3 & SCR_RW);
+    if (arm_feature(env, ARM_FEATURE_EL3)) {
+        aa64 = aa64 && arm_scr_rw_eff(env);
     }
 
     if (el == 2) {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 71dead7241b..1085bff0ec5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9609,7 +9609,7 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
     uint64_t hcr_el2;
 
     if (arm_feature(env, ARM_FEATURE_EL3)) {
-        rw = ((env->cp15.scr_el3 & SCR_RW) == SCR_RW);
+        rw = arm_scr_rw_eff(env);
     } else {
         /*
          * Either EL2 is the highest EL (and so the EL2 register width
@@ -10418,7 +10418,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
 
         switch (new_el) {
         case 3:
-            is_aa64 = (env->cp15.scr_el3 & SCR_RW) != 0;
+            is_aa64 = arm_scr_rw_eff(env);
             break;
         case 2:
             hcr = arm_hcr_el2_eff(env);
-- 
2.43.0


