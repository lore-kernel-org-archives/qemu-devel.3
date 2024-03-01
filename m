Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56794C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 18:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg7gT-0006TL-AS; Fri, 01 Mar 2024 13:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg7gM-0006Pk-0d
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:32:31 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg7gI-0008L9-2g
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:32:29 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33da51fd636so1086021f8f.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 10:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709317944; x=1709922744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Rb0Z7zjLpv30F7lDtK7tZWHoJA0TmXTubgs4mA4pQs=;
 b=MDWAURfxkz8z3ktjdnS8WzraE7ZAIszwTYbmzISy8n8MOddPCu7nm5jeHXR1JZvHsW
 3n42knSqliKeV4F77qRWUW9orQzMcS2Eag1rDOrf3xkr+EzJNIiSij8EB1NGqG8WxHTC
 Dx8ZG3xANL1VoKHujV+fl8ZIT9z5Fg8hQhZd8d7oSHyp9avHsIc8jDaVJTOp5WzlESs9
 PCfJSwod2PQo5NocnA60FWhWFTbFXKQgMMzukmK4q3afIGpjH5GAB4bCzmPL4Td/esXm
 n1sTQTexbXwJLKQdc5TTEOK8PoeDV7Trtt+lNgSl+dC+vDM9av6xbUCF7WmtiQVYRVMd
 RRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709317944; x=1709922744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Rb0Z7zjLpv30F7lDtK7tZWHoJA0TmXTubgs4mA4pQs=;
 b=BjkPL9dR7ppo6LGwYBweNUZlWtPj8qbZsGBbLPiWV6uEn7ompPkVXWkwCpyz7Va7zx
 BuoDH5WENprvdfNjDsbgVPTnIEGto7UZRYDB7EjePUnLBJ53FVk0o060hzN6UiDuR3aT
 wjk2zFjL7SPhrxUp7jE4+D6Q+4UM3OYdT8th1Gk/Mosde109IBrQjVaZNrMCCSTy51xL
 8KlHuDzVSUK57FroUaF4xndGyPjnjIfzBtPkYy2VNLCYVmDrjp4aqsvkQu4XaEwjYLDw
 H+kjB8nsNnrKrN2xHWn6DRFj8F09LCBgzyhsKskpF+KdFVV4lp6P+MxkXfmSXm0Atfvg
 6o7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYA1Nu9T2tLv9cfU3euWTBunhenygtSxiCj3Jv8RiIlj1rsDZEA0RIG5WLr0LSAqYsaEc/+9nXsEKsV9212szR5heTzR8=
X-Gm-Message-State: AOJu0YyBVLEW/iyCiW6eC79uP1o5/AWM+mtfri/CDLcLEyW3Bx0WpGU+
 5Ee0RI2HjBgQPSJ7vnUTjZbmmJegOsR1pJnAhohjKYDUHnM1d+xjVIKiuvWIzDE=
X-Google-Smtp-Source: AGHT+IGfEB9m/9/1BS3zGkUXOndMR4YofG/scuEAWoSoKR9sudNP8Cx4Lem6J186k2KgwBT7SpAoGw==
X-Received: by 2002:adf:9ccd:0:b0:33e:1f94:c493 with SMTP id
 h13-20020adf9ccd000000b0033e1f94c493mr2214804wre.65.1709317943986; 
 Fri, 01 Mar 2024 10:32:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u2-20020adfeb42000000b0033b483d1abcsm5158934wrn.53.2024.03.01.10.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 10:32:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 6/8] target/arm: Define CNTPCTSS_EL0 and CNTVCTSS_EL0
Date: Fri,  1 Mar 2024 18:32:17 +0000
Message-Id: <20240301183219.2424889-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301183219.2424889-1-peter.maydell@linaro.org>
References: <20240301183219.2424889-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

For FEAT_ECV, new registers CNTPCTSS_EL0 and CNTVCTSS_EL0 are
defined, which are "self-synchronized" views of the physical and
virtual counts as seen in the CNTPCT_EL0 and CNTVCT_EL0 registers
(meaning that no barriers are needed around accesses to them to
ensure that reads of them do not occur speculatively and out-of-order
with other instructions).

For QEMU, all our system registers are self-synchronized, so we can
simply copy the existing implementation of CNTPCT_EL0 and CNTVCT_EL0
to the new register encodings.

This means we now implement all the functionality required for
ID_AA64MMFR0_EL1.ECV == 0b0001.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6c528903a9a..3441b14ba39 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3389,6 +3389,34 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     },
 };
 
+/*
+ * FEAT_ECV adds extra views of CNTVCT_EL0 and CNTPCT_EL0 which
+ * are "self-synchronizing". For QEMU all sysregs are self-synchronizing,
+ * so our implementations here are identical to the normal registers.
+ */
+static const ARMCPRegInfo gen_timer_ecv_cp_reginfo[] = {
+    { .name = "CNTVCTSS", .cp = 15, .crm = 14, .opc1 = 9,
+      .access = PL0_R, .type = ARM_CP_64BIT | ARM_CP_NO_RAW | ARM_CP_IO,
+      .accessfn = gt_vct_access,
+      .readfn = gt_virt_cnt_read, .resetfn = arm_cp_reset_ignore,
+    },
+    { .name = "CNTVCTSS_EL0", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 6,
+      .access = PL0_R, .type = ARM_CP_NO_RAW | ARM_CP_IO,
+      .accessfn = gt_vct_access, .readfn = gt_virt_cnt_read,
+    },
+    { .name = "CNTPCTSS", .cp = 15, .crm = 14, .opc1 = 8,
+      .access = PL0_R, .type = ARM_CP_64BIT | ARM_CP_NO_RAW | ARM_CP_IO,
+      .accessfn = gt_pct_access,
+      .readfn = gt_cnt_read, .resetfn = arm_cp_reset_ignore,
+    },
+    { .name = "CNTPCTSS_EL0", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 5,
+      .access = PL0_R, .type = ARM_CP_NO_RAW | ARM_CP_IO,
+      .accessfn = gt_pct_access, .readfn = gt_cnt_read,
+    },
+};
+
 #else
 
 /*
@@ -3422,6 +3450,18 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     },
 };
 
+/*
+ * CNTVCTSS_EL0 has the same trap conditions as CNTVCT_EL0, so it also
+ * is exposed to userspace by Linux.
+ */
+static const ARMCPRegInfo gen_timer_ecv_cp_reginfo[] = {
+    { .name = "CNTVCTSS_EL0", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 6,
+      .access = PL0_R, .type = ARM_CP_NO_RAW | ARM_CP_IO,
+      .readfn = gt_virt_cnt_read,
+    },
+};
+
 #endif
 
 static void par_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
@@ -9258,6 +9298,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
         define_arm_cp_regs(cpu, generic_timer_cp_reginfo);
     }
+    if (cpu_isar_feature(aa64_ecv_traps, cpu)) {
+        define_arm_cp_regs(cpu, gen_timer_ecv_cp_reginfo);
+    }
     if (arm_feature(env, ARM_FEATURE_VAPA)) {
         ARMCPRegInfo vapa_cp_reginfo[] = {
             { .name = "PAR", .cp = 15, .crn = 7, .crm = 4, .opc1 = 0, .opc2 = 0,
-- 
2.34.1


