Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293DAC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 00:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww7f5-0002IY-Mc; Mon, 17 Aug 2026 20:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1ww7f2-0002Gc-Ai
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 20:26:36 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1ww7f0-0004Gt-2x
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 20:26:36 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4b28d7fdac4so676677b6e.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 17:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787012793; x=1787617593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6ETn2XhFKfaJnEJO3St0lwG1jW1GLwuG+pFGHVIRjow=;
 b=h8CO/jQsH9Yle8Vo717a5ta1Q2J83IN4KD9DL1VWDQiAqnLvnzWpU5WnRxdE3dwPke
 hCE5v7Vrs9BW1IG9+L8QY2SsXwAL9CyXquzlu5OxaQ1MC86uVrvGiagJgxqtjHP+fJ5I
 5i8DeCoUPGm8cN5u7pZuRprnV8B67BEfYqvGTlgk3GS0drma+yNMoLe37TAk+Yne0M38
 MQ1DwxYttYxqE4P6ucbVGcT6NM591ZAYIaLiOI6ym2psRibHhD3vAprBoSvqJ60mF3S1
 efAUOyoTQpxKGBn+2HzoTOnqf4WQt7H21q40Z0+kCyQ9qN4yT8wva0iD+IBHz2mGeqeB
 rBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787012793; x=1787617593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6ETn2XhFKfaJnEJO3St0lwG1jW1GLwuG+pFGHVIRjow=;
 b=hKxXBkwy8CyrMPhvYSm32NNXrXaT6ujUx7HHalBZCtUy6Fr5K5DYxEhu2mQb7/1Xf5
 8X50oSgm4A2ksqt5aEcdU1ZlkvtfFXJF1oofGEL7cmAv/nGqkPQYX4Be7yuHlkG09GC1
 dkF30FuhjfWoPpl8NutMnt/EcCHqWF1RigfRhfNp6Eko+aWMsLFGwR/XUp/08uvUN1O8
 j4ocnsKbwONv4ibDXBbfyAplQDN9Dr9+7bZruVZjqSzFtftF8GYACY82ChGla3A/xs1x
 ejulzuO4LSnwoDFNs1gWdtQeB7GdaH5ON65SIo0WK5/EpjY36bG18P4Rxt/OxAj8m6Hu
 CUAw==
X-Gm-Message-State: AOJu0YyU5ycN8+6edcWPawJPbwKP8V0BIT3UGZvONlF1XwlKJbLAGwaD
 YyzHiuNL+WLkRYLVdpqlr7P+b/qH0ZK0xtxaRx/r7gDu6z52empi15TDTVSKcjTQ
X-Gm-Gg: AR+sD10aJ/7VpiDXzdn0Qc2XtOeAoF/LsmO0x2AFtSWfdbpPq/KBiaJ/rpuW6KguTak
 LStblBkIORd8tA/6okcOLoeDOwtDmTy+d0+lu5Qd5EOUYGmBH4AyC3+n8dWCj8sf4VWiFh6PFlT
 7XNiGVbeiUuOCaHTQz+fbmkvnLS0VpTxiZtN5DRj7YV2v0JnEoMNv6lV3O+PgKnJMDjnJodjVuW
 6CDiGvOozhsUsUJIix+uDD2c2Nml4Z69lAG/wyNM84Yp/pqpDD6bqNDczFgKtCn3birwokXvki5
 Z4oEk2Ll0bsWvxc7x0YvMM73Xha50JsvAF7e5KEV53aWQr5gSaXlllPITDoaBCGaIIUSnG3bDwB
 Bgb+riPQjVU0WZd1Ljp30kNeam2sVkTiCByT8dbfL34X/PyFVLFxqQAbRMDmWIqk+DMc+w9Baaj
 cIWqaZd1Mw5di08cBg4+Bnw6m8FekR5uifKycGkl529JLsIa/okvdEhA33U69HFZuARTIlBC/E1
 csUKbHMCzM=
X-Received: by 2002:a05:6808:4f54:b0:496:e0:a47b with SMTP id
 5614622812f47-4b241edaf3dmr28470495b6e.20.1787012792826; 
 Mon, 17 Aug 2026 17:26:32 -0700 (PDT)
Received: from LAPTOP-86EU4LQA.home.local ([23.124.244.239])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2960dfc9bsm1715165b6e.14.2026.08.17.17.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 17:26:32 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Simon Xu <simonxhy0404@gmail.com>, Owen Giles <owen.giles@hpe.com>,
 Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 1/9] target/arm/tcg/cpu-v7m.c: add cortex-m85 model
Date: Mon, 17 Aug 2026 19:26:21 -0500
Message-ID: <20260818002629.172827-2-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818002629.172827-1-simonxhy0404@gmail.com>
References: <20260818002629.172827-1-simonxhy0404@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add Arm Cortex-M85 CPU, modeld after the existing M55 CPU.
The new M85 feature PACBTI is not implemented in QEMU and the midr value
is based off the r1p1 product revision identifier.

Arm Cortex-M85 TRM:
https://developer.arm.com/documentation/101924/0101/

Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
Message-Id: <20260805153005.9989-2-simonxhy0404@gmail.com>
---
 target/arm/tcg/cpu-v7m.c | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index dc249ce1f1..a1e62a20f8 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -237,6 +237,45 @@ static void cortex_m55_initfn(Object *obj)
     cpu->ctr = 0x8303c003;
 }
 
+static void cortex_m85_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
+
+    /* QEMU currently does not support the PACBTI feature */
+    set_feature(&cpu->env, ARM_FEATURE_V8);
+    set_feature(&cpu->env, ARM_FEATURE_V8_1M);
+    set_feature(&cpu->env, ARM_FEATURE_M);
+    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
+    set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
+    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
+    cpu->midr = 0x411fd231; /* r1p1 */
+    cpu->revidr = 0;
+    cpu->pmsav7_dregion = 16;
+    cpu->sau_sregion = 8;
+    /* These are the MVFR* values for the FPU + full MVE configuration */
+    cpu->isar.mvfr0 = 0x10110221;
+    cpu->isar.mvfr1 = 0x12100211;
+    cpu->isar.mvfr2 = 0x00000040;
+    SET_IDREG(isar, ID_PFR0, 0x20000030);
+    SET_IDREG(isar, ID_PFR1, 0x00000230);
+    SET_IDREG(isar, ID_DFR0, 0x10200000);
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
+    SET_IDREG(isar, ID_MMFR0, 0x00111040);
+    SET_IDREG(isar, ID_MMFR1, 0x00000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01000000);
+    SET_IDREG(isar, ID_MMFR3, 0x00000011);
+    SET_IDREG(isar, ID_ISAR0, 0x01103110);
+    SET_IDREG(isar, ID_ISAR1, 0x02212000);
+    SET_IDREG(isar, ID_ISAR2, 0x20232232);
+    SET_IDREG(isar, ID_ISAR3, 0x01111131);
+    SET_IDREG(isar, ID_ISAR4, 0x01310132);
+    SET_IDREG(isar, ID_ISAR5, 0x00000000);
+    SET_IDREG(isar, ID_ISAR6, 0x00000000);
+    SET_IDREG(isar, CLIDR, 0x00000000); /* caches not implemented */
+    cpu->ctr = 0x8303c003;
+}
+
 static const TCGCPUOps arm_v7m_tcg_ops = {
     /* ARM processors have a weak memory model */
     .guest_default_memory_order = 0,
@@ -290,6 +329,8 @@ static const ARMCPUInfo arm_v7m_cpus[] = {
                              .class_init = arm_v7m_class_init },
     { .name = "cortex-m55",  .initfn = cortex_m55_initfn,
                              .class_init = arm_v7m_class_init },
+    { .name = "cortex-m85",  .initfn = cortex_m85_initfn,
+                             .class_init = arm_v7m_class_init },
 };
 
 static void arm_v7m_cpu_register_types(void)
-- 
2.53.0


