Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A056D4660F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSVx-0001hK-QI; Thu, 15 Jan 2026 13:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVQ-0000jC-5i
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:41 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVN-0005ws-SO
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:39 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47ee9817a35so7213205e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503332; x=1769108132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ccwGlBepenyCt3hvVIc/HOQFMTjzI66ATiAU+WWKcZY=;
 b=U0kzU4v8zCl1jb+qyojwLN64A9+mUJkOoLznXskODM0aFUDoqegKuPsdyqiPuw+cI3
 XqipsePylCk0aStO2nhLUGaR1gpdmGVq6xka7FALjLa+rlFKjw0sNlOQ86rpmpKP2OA4
 xzmycOmM0Ae64Bm0VWPnm/E5K0fnCHoiPMQGUGVrwV4EnN6accW5SHbqryqJNjSuV6Y0
 Vy3beculITMSBrnYofJRSmydf/J8GlcPdLgj88Ogkb0TPmdi1V/8vuYtfXqAoNIuBtAp
 O3xINVIaciRVgmQ6O9n0PM378dTV5IuHkf6hUS9Y15vFCLKXF9l+i8as+YUUjTewI5Yd
 xwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503332; x=1769108132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ccwGlBepenyCt3hvVIc/HOQFMTjzI66ATiAU+WWKcZY=;
 b=tJ5KLg3W3C3G8Yv8Dn/pkFKqsZcyVsdW6CQUVo/3yzq0K+l2earAY15FKv2gJp6DdI
 ASyRgbXgmiGCvKUhMyyrPLMtW5OjZX9drLSjcVDa4qd9ZCE+T3+oPDG1SosRgSHPYC4H
 M9NvZJbPj3XJLh09M1tX2dXQbcND+A/rK6u+B7644We+yS4IYtllJVOCClgTfi0g9+jU
 2ii/7ZcPxUJ7lshrOnKGHaMve7CF2WWhx3v8v/zGsx64W7JZFmEnlLVnrxdu3YxcCzmQ
 ZfzXp1s/MiKcGO5kZ79OcfN84vVjs/ZoZy6umXscCetqQoNgDL/NAxto0JSNeaZ296Gc
 Xaqg==
X-Gm-Message-State: AOJu0Yyh1+whBCI/S05crIKfI2ZokTUudklJsnKUqk0vbGKBoDecW1YS
 KzKWMaoRufMafHj5qIr8sF2yKJb8qGF1Sld/y/oWZPQxhOM/zqwSJ1KR5jsGrTIEv0VkenH8++H
 H7FvG
X-Gm-Gg: AY/fxX6o62K4Y5j81iXH4zNFS7BZCZSub79V2iw49ssoGsluiprYaFZoUIzRS5ENXE2
 fZHc8v1o5N8nDaurSkbjLJZ53D8Eymma5Fpjar9Cp6ktEOk6fMZDwYluTGJ66pGzAUMkoVdGboh
 R6YV5pT3Q5SjjtAhSG2hiIxDU+SEejpZmdVglbJNqKuvKHuVv8S2Gtzic26GO9ZHs/wHw5uDSK/
 ns1k1yCMd+H7w4U4XzBnHSPWo+3UkmL0u/vuT9GqFa5J3CBSQyTGYT1XVbRiLAALA8lr2te94Kf
 47PvSBPQAAiHHSZiBRhCaMjUYZlYKZImEIOtK/POuOwrxnTTadMmYhLTeGWUrUXeqNt90Gcy/Zb
 mxhQXNwpZzER5phfEgaZB4y1yJLs5WMRTkV5xjIWEiCnGAvqHmIDeuq6yCF888zSA12U4CsDTpQ
 BGvzFDqgGeUQA9sd2NHggJOFn4Naqb47HI8hjMB7KHeeAwxlQDesQlHio8+LniOloK/OIxjr9lG
 q4J6NSvMMFN51H+v5ISSCQvm8ExEPRTFXlNfmXf9f63DQ==
X-Received: by 2002:a05:600c:a07:b0:47f:8c05:786b with SMTP id
 5b1f17b1804b1-4801e3484eamr8651315e9.28.1768503331998; 
 Thu, 15 Jan 2026 10:55:31 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/25] target/arm: Correctly trap HCR.TID1 registers in v7A
Date: Thu, 15 Jan 2026 18:55:06 +0000
Message-ID: <20260115185508.786428-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

In v7A HCR.TID1 is defined to trap for TCMTR, TLBTR, REVIDR and AIDR.
We incorrectly use an accessfn for REVIDR and AIDR that only traps on
v8A cores.  Fix this by collapsing access_aa64_tid1() and
access_aa32_tid1() together and never doing a check for v8 vs v7.

The accessfn is also used for SMIDR_EL1, which is fine as this
register is AArch64 only.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251231170858.254594-4-peter.maydell@linaro.org
---
 target/arm/helper.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3f422f509d..acfb2cbc31 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -933,8 +933,8 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return ret;
 }
 
-static CPAccessResult access_aa64_tid1(CPUARMState *env, const ARMCPRegInfo *ri,
-                                       bool isread)
+static CPAccessResult access_tid1(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  bool isread)
 {
     if (arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_TID1)) {
         return CP_ACCESS_TRAP_EL2;
@@ -943,16 +943,6 @@ static CPAccessResult access_aa64_tid1(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
-static CPAccessResult access_aa32_tid1(CPUARMState *env, const ARMCPRegInfo *ri,
-                                       bool isread)
-{
-    if (arm_feature(env, ARM_FEATURE_V8)) {
-        return access_aa64_tid1(env, ri, isread);
-    }
-
-    return CP_ACCESS_OK;
-}
-
 static const ARMCPRegInfo v7_cp_reginfo[] = {
     /* the old v6 WFI, UNPREDICTABLE in v7 but we choose to NOP */
     { .name = "NOP", .cp = 15, .crn = 7, .crm = 0, .opc1 = 0, .opc2 = 4,
@@ -978,7 +968,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
     { .name = "AIDR", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 1, .crn = 0, .crm = 0, .opc2 = 7,
       .access = PL1_R, .type = ARM_CP_CONST,
-      .accessfn = access_aa64_tid1,
+      .accessfn = access_tid1,
       .fgt = FGT_AIDR_EL1,
       .resetvalue = 0 },
     /*
@@ -5001,7 +4991,7 @@ static const ARMCPRegInfo sme_reginfo[] = {
       .writefn = smcr_write, .raw_writefn = raw_write },
     { .name = "SMIDR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 1, .crn = 0, .crm = 0, .opc2 = 6,
-      .access = PL1_R, .accessfn = access_aa64_tid1,
+      .access = PL1_R, .accessfn = access_tid1,
       /*
        * IMPLEMENTOR = 0 (software)
        * REVISION    = 0 (implementation defined)
@@ -7112,7 +7102,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "REVIDR_EL1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 0, .opc2 = 6,
               .access = PL1_R,
-              .accessfn = access_aa64_tid1,
+              .accessfn = access_tid1,
               .fgt = FGT_REVIDR_EL1,
               .type = ARM_CP_CONST, .resetvalue = cpu->revidr },
         };
@@ -7136,7 +7126,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "TCMTR",
               .cp = 15, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 2,
               .access = PL1_R,
-              .accessfn = access_aa32_tid1,
+              .accessfn = access_tid1,
               .type = ARM_CP_CONST, .resetvalue = 0 },
         };
         /* TLBTR is specific to VMSA */
@@ -7144,7 +7134,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .name = "TLBTR",
               .cp = 15, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 3,
               .access = PL1_R,
-              .accessfn = access_aa32_tid1,
+              .accessfn = access_tid1,
               .type = ARM_CP_CONST, .resetvalue = 0,
         };
         /* MPUIR is specific to PMSA V6+ */
-- 
2.47.3


