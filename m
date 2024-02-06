Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A346C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 13:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLWC-0000eY-Vy; Tue, 06 Feb 2024 08:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLW7-0000PF-Qt
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:29:39 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLW4-0008Di-F0
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:29:39 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33b4b121e28so25467f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 05:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707226174; x=1707830974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h7YaNX76JwqZEJT0rHKxb3cowkocOAyFr6+DgbOiGaE=;
 b=VRAiac+QPyabZ6xxWZZoUs3NPPwiZkIzarYqWlx6s4yOMojHN+Eu29em/60mmub/DJ
 zn2j2SM4E9LbLy189ysGlihKb4afCpgV1tsx/lcuy09Bc9GnSKdwfrFikBE6vZjPAZPx
 +rTGs9mwFYzKjHQhVHicnbh3dWfNEwLETlfLW4/mxtDYFsuOpH1qu9KJMgESyMmglKuB
 otaYcUpSawbJq2180wHTgqJORsIol9rzUUUfM7uVT4pVhf2Sq5MdRtd7Oe4CpKG8PxEr
 C62nKQP0fv/9SUmMVQbDrPcEypQiTPGVaS1CxC7uX3ShBQwiqgP1RuqxauLyj7yqx3Vy
 or/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707226174; x=1707830974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h7YaNX76JwqZEJT0rHKxb3cowkocOAyFr6+DgbOiGaE=;
 b=VgG7JCM0kUpU2409xOofzqDU8rCO2FnD8vA3WaQLios/h9Z/WoDh/Hiy4lp6VU/Xa1
 rAmu8NeUg4b2Em46ECU5RwjNb9YE51c02lVmT7ocJxXAXfUr+qQ/hbykP+Xqr96jG2sC
 QylBopA/L0c6UuR+a2RD72B0FKRLaYERjMRzr5dw88iOdr++pnbAllDK09veZdVZpYwJ
 vuaRLRyToxAGQhvweNEITXGLDtem/e17ZBEGi3FRdxHUl/qRn7vnbAntfhYhEjxBWOEa
 HpZmjoyezkesIrjYsjMc9HS4/Z/4ne/Rr1K3ezmxjQz95CLGJC9ls7KButACPoUy6+px
 DvKw==
X-Gm-Message-State: AOJu0YzeFXnqttssyirKxm6ZvP3hP7FvskeO4czzIRBeOVKAT60bHrcS
 TihghJJUdsS+yPftpulOA+j6VWfZgcdtCBxTyaqS1hwFNucycoSlEirgdWivbnU=
X-Google-Smtp-Source: AGHT+IHobB3hvfz2GrLp2gza7bUNw8EVpcsVCuiE7ZdgxPwSjoBlnjPaA964QgtrhrKlH5HskbuLXw==
X-Received: by 2002:a5d:6682:0:b0:33a:eec4:c0c6 with SMTP id
 l2-20020a5d6682000000b0033aeec4c0c6mr1251743wru.12.1707226173986; 
 Tue, 06 Feb 2024 05:29:33 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU1s9rGIXOur/AiDMftwLUWKqfXHFK+gVeCGoeqCaVAy60DXB5ga24x9kX2ATYiBBTeQQ1hZeEMH/J+dtY5P+cDS7KIdCU=
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a056000108700b0033b470a137esm1492932wrw.79.2024.02.06.05.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 05:29:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 03/13] target/arm: Add Cortex-R52 IMPDEF sysregs
Date: Tue,  6 Feb 2024 13:29:21 +0000
Message-Id: <20240206132931.38376-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206132931.38376-1-peter.maydell@linaro.org>
References: <20240206132931.38376-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Add the Cortex-R52 IMPDEF sysregs, by defining them here and
also by enabling the AUXCR feature which defines the ACTLR
and HACTLR registers. As is our usual practice, we make these
simple reads-as-zero stubs for now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu32.c | 108 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 311d654cdce..6eb08a41b01 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -800,6 +800,111 @@ static void cortex_r5_initfn(Object *obj)
     define_arm_cp_regs(cpu, cortexr5_cp_reginfo);
 }
 
+static const ARMCPRegInfo cortex_r52_cp_reginfo[] = {
+    { .name = "CPUACTLR", .cp = 15, .opc1 = 0, .crm = 15,
+      .access = PL1_RW, .type = ARM_CP_CONST | ARM_CP_64BIT, .resetvalue = 0 },
+    { .name = "IMP_ATCMREGIONR",
+      .cp = 15, .opc1 = 0, .crn = 9, .crm = 1, .opc2 = 0,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_BTCMREGIONR",
+      .cp = 15, .opc1 = 0, .crn = 9, .crm = 1, .opc2 = 1,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_CTCMREGIONR",
+      .cp = 15, .opc1 = 0, .crn = 9, .crm = 1, .opc2 = 2,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_CSCTLR",
+      .cp = 15, .opc1 = 1, .crn = 9, .crm = 1, .opc2 = 0,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_BPCTLR",
+      .cp = 15, .opc1 = 1, .crn = 9, .crm = 1, .opc2 = 1,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_MEMPROTCLR",
+      .cp = 15, .opc1 = 1, .crn = 9, .crm = 1, .opc2 = 2,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_SLAVEPCTLR",
+      .cp = 15, .opc1 = 0, .crn = 11, .crm = 0, .opc2 = 0,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_PERIPHREGIONR",
+      .cp = 15, .opc1 = 0, .crn = 15, .crm = 0, .opc2 = 0,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_FLASHIFREGIONR",
+      .cp = 15, .opc1 = 0, .crn = 15, .crm = 0, .opc2 = 1,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_BUILDOPTR",
+      .cp = 15, .opc1 = 0, .crn = 15, .crm = 2, .opc2 = 0,
+      .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_PINOPTR",
+      .cp = 15, .opc1 = 0, .crn = 15, .crm = 2, .opc2 = 7,
+      .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_QOSR",
+      .cp = 15, .opc1 = 1, .crn = 15, .crm = 3, .opc2 = 1,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_BUSTIMEOUTR",
+      .cp = 15, .opc1 = 1, .crn = 15, .crm = 3, .opc2 = 2,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_INTMONR",
+      .cp = 15, .opc1 = 1, .crn = 15, .crm = 3, .opc2 = 4,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_ICERR0",
+      .cp = 15, .opc1 = 2, .crn = 15, .crm = 0, .opc2 = 0,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_ICERR1",
+      .cp = 15, .opc1 = 2, .crn = 15, .crm = 0, .opc2 = 1,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_DCERR0",
+      .cp = 15, .opc1 = 2, .crn = 15, .crm = 1, .opc2 = 0,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_DCERR1",
+      .cp = 15, .opc1 = 2, .crn = 15, .crm = 1, .opc2 = 1,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_TCMERR0",
+      .cp = 15, .opc1 = 2, .crn = 15, .crm = 2, .opc2 = 0,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_TCMERR1",
+      .cp = 15, .opc1 = 2, .crn = 15, .crm = 2, .opc2 = 1,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_TCMSYNDR0",
+      .cp = 15, .opc1 = 2, .crn = 15, .crm = 2, .opc2 = 2,
+      .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_TCMSYNDR1",
+      .cp = 15, .opc1 = 2, .crn = 15, .crm = 2, .opc2 = 3,
+      .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_FLASHERR0",
+      .cp = 15, .opc1 = 2, .crn = 15, .crm = 3, .opc2 = 0,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_FLASHERR1",
+      .cp = 15, .opc1 = 2, .crn = 15, .crm = 3, .opc2 = 1,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_CDBGDR0",
+      .cp = 15, .opc1 = 3, .crn = 15, .crm = 0, .opc2 = 0,
+      .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_CBDGBR1",
+      .cp = 15, .opc1 = 3, .crn = 15, .crm = 0, .opc2 = 1,
+      .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_TESTR0",
+      .cp = 15, .opc1 = 4, .crn = 15, .crm = 0, .opc2 = 0,
+      .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IMP_TESTR1",
+      .cp = 15, .opc1 = 4, .crn = 15, .crm = 0, .opc2 = 1,
+      .access = PL1_W, .type = ARM_CP_NOP, .resetvalue = 0 },
+    { .name = "IMP_CDBGDCI",
+      .cp = 15, .opc1 = 0, .crn = 15, .crm = 15, .opc2 = 0,
+      .access = PL1_W, .type = ARM_CP_NOP, .resetvalue = 0 },
+    { .name = "IMP_CDBGDCT",
+      .cp = 15, .opc1 = 3, .crn = 15, .crm = 2, .opc2 = 0,
+      .access = PL1_W, .type = ARM_CP_NOP, .resetvalue = 0 },
+    { .name = "IMP_CDBGICT",
+      .cp = 15, .opc1 = 3, .crn = 15, .crm = 2, .opc2 = 1,
+      .access = PL1_W, .type = ARM_CP_NOP, .resetvalue = 0 },
+    { .name = "IMP_CDBGDCD",
+      .cp = 15, .opc1 = 3, .crn = 15, .crm = 4, .opc2 = 0,
+      .access = PL1_W, .type = ARM_CP_NOP, .resetvalue = 0 },
+    { .name = "IMP_CDBGICD",
+      .cp = 15, .opc1 = 3, .crn = 15, .crm = 4, .opc2 = 1,
+      .access = PL1_W, .type = ARM_CP_NOP, .resetvalue = 0 },
+};
+
+
 static void cortex_r52_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -810,6 +915,7 @@ static void cortex_r52_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
+    set_feature(&cpu->env, ARM_FEATURE_AUXCR);
     cpu->midr = 0x411fd133; /* r1p3 */
     cpu->revidr = 0x00000000;
     cpu->reset_fpsid = 0x41034023;
@@ -840,6 +946,8 @@ static void cortex_r52_initfn(Object *obj)
 
     cpu->pmsav7_dregion = 16;
     cpu->pmsav8r_hdregion = 16;
+
+    define_arm_cp_regs(cpu, cortex_r52_cp_reginfo);
 }
 
 static void cortex_r5f_initfn(Object *obj)
-- 
2.34.1


