Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D3BC624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ON3-0000xY-81; Tue, 01 Sep 2026 09:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1OMw-0000vw-UM
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:43 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1OMu-00077F-Oq
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:42 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c1712a04ddaso773481766b.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268659; x=1788873459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rGk9086+658YDSmXaw95r1eVO+HDDXP2VbVahmR2kXM=;
 b=EJfhGbXV/wlDZRqW/bMtLf3g+O40gq8gYR0Ul+d/tpXdmNRGOBeaInHxdwoMSlA+xz
 Bgy5e3NhVZJjhM0HzrGHvPr8gPtg2FPhooNxX+e6yNct03dZA7gjjLfOK7SBzIyeuTSS
 hEr2MXC0IlTVml3EaAlgMDboEMBlkmEYcfTkS2bMedjcPA2FHTtSbhTe9IMyRjcVvKvN
 WuEyCSCYOL+TqX3A5BZOgiQcAsLoiwqsLHK0A0Cc9436kcvE1sdhSQD/wYjihyHpTzPY
 J4DLXHC1mqRIFbCniv1nwbO8aGzRlc7f0ZHxo7pOfoNh+mOH2+iyFoCY3WSO4TX6ebWF
 7hbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268659; x=1788873459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rGk9086+658YDSmXaw95r1eVO+HDDXP2VbVahmR2kXM=;
 b=Sx/hCrqd6yQ6m2dcm22cbDDF5PRKiJOs3bMG8qUOISXVGrPRZVKzvRjh/YNup18WPV
 Lo0rL5BM2IHgdDA0UCDQJzqXiRkDhblckYYlmLUaijse1jHPcd26a1TMx54+tVD9qS75
 RyCY/brJ+r4pNi2dchNoEpYQDTGvDVx5t2ymsQfYwl+lAYWUgb451ieE35tu3tuzL7Ot
 jaGtmmYtkVxvTVLuQ9D5wKZdnwE4P19UiKgy4qe6FPf87BpckOB70SKDAhIX8/tfQaDB
 30cK1q2E9u6wavKN3RQgPfS8gpfQ48STItkkXC6LNjJnVnvBD/dT2urI5IFOBlJb46UI
 HRCA==
X-Gm-Message-State: AFuF++lpLCpsQOcG8QejWHTHN+mTbzoaxrEjvr4S4FKtJ//t5y7Mxcsv
 6MWh08DrW4pCzi5jEPIu6yjUTP09P3CGgStZvQ1wu3grk5XsW4Yv3scPaju8scJEuOW+IOTg7AA
 8gRNP7Tc=
X-Gm-Gg: AR+sD13Q1u7BJuBXnayHtSZK06LaQXsRw41OKTrr4uos/DqO58vkMs84LAql1tNcjfG
 RBUHdPjPzUPZ83HJVzq0Z7afw4LwUiuDzh8APN5pm5KUKq5VU4KcH1/QMEKRsT/K1vXe58DkUQO
 giTOUr1GmU1re4Mie5z5JCgyafN8JdaWb9GZ2cZRcAvtM31C0+EwvvimD6BOxXiyUykHinfKNPF
 TBJC5enFyrTOgjFjZgxi2yZOGvw+P5bf4b5pMgNd5mKJ+cLvu/lXTOLBP4FQ84JFBEJJQNVuAV5
 vSWF9RqF2mry5ArsC52eGQUgtwB1PXrj7vSu+TAtsUT309vkjr7MLhD8bLhEeSV3sxweye9i25m
 ieu1qfg5BbD8X3SOHt1KcPO+R/hJWp24KOKqMKw1fHubltT192Nof/WJZifxFqODshUb00/x0S9
 DQADKWZnnyQqBeghfX3VkBuv9q/5UHmP++uhkSyPrLVH61RHYLKba66N8fSUJishHY1hW4wOo95
 jqzcj7NBPVc6B9aHF0pfk+Xjazc7KQHeT4+iYDNBblezyO+N6CuxtR8maGdS52uHRJTP392k8lA
 qi0L
X-Received: by 2002:a17:906:9fc5:b0:c20:f4ee:7c97 with SMTP id
 a640c23a62f3a-c2556c19e06mr2196809066b.5.1788268658704; 
 Tue, 01 Sep 2026 06:17:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/58] target/arm: Don't provide TLBTR for pre-v6 CPUs
Date: Tue,  1 Sep 2026 14:16:38 +0100
Message-ID: <20260901131732.2263947-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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

The TLBTR register (encoding cp15, 0, c0, c0, 3) is listed in the v7A
Arm ARM appendix O as being present in v4 and v5 (section O.7.1,
diagram "Organization of CP15 registers in an ARMv4 or ARMv5 VMSA
implementation").  However, it isn't listed in the v5 Arm ARM, and
checking individual TRMs for the arm926, arm1026, sa1100, sa1110 and
ti925 shows that none of them implement it, so it seems much more
likely that TLBTR was new for v6.  It's also confirmed not to be
present on a real arm926.

Gate the register on ARM_FEATURE_V6 being present; this means that on
pre-v6 cores the encoding will fall back to reporting the MIDR (due
to the CP_ANY wildcarding), matching the hardware behaviour.

We can also remove the "make id_tlbtr_reginfo r/w for strongarm and
omap" code, because those CPUs are pre-v6 so won't be using that
reginfo struct now.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4207
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260821120036.4161792-1-peter.maydell@linaro.org
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4f30a94ecd3..e10ec21a8cd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7353,7 +7353,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
                 id_cp_reginfo[i].access = PL1_RW;
             }
             id_mpuir_reginfo.access = PL1_RW;
-            id_tlbtr_reginfo.access = PL1_RW;
         }
         if (arm_feature(env, ARM_FEATURE_V8)) {
             define_arm_cp_regs(cpu, id_v8_midr_cp_reginfo);
@@ -7364,7 +7363,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             define_arm_cp_regs(cpu, id_pre_v8_midr_cp_reginfo);
         }
         define_arm_cp_regs(cpu, id_cp_reginfo);
-        if (!arm_feature(env, ARM_FEATURE_PMSA)) {
+        if (arm_feature(env, ARM_FEATURE_V6) &&
+            !arm_feature(env, ARM_FEATURE_PMSA)) {
             define_one_arm_cp_reg(cpu, &id_tlbtr_reginfo);
         } else if (arm_feature(env, ARM_FEATURE_PMSA) &&
                    arm_feature(env, ARM_FEATURE_V8)) {
-- 
2.43.0


