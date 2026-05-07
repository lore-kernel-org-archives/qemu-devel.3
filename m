Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FA2CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 13:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKz4g-0007rU-HS; Thu, 07 May 2026 09:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKz4T-0007os-UJ
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:47:23 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKz4S-0004Ry-7L
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:47:21 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so13010935e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 06:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778161638; x=1778766438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vnX1tchTMN4f4eTabnG6jZSrIEMOA2BX2sx6GfZ0fk=;
 b=yC7eqW3lBlXUbqjpnKora1bXQozTvxhh5fRApyiRsGJkFm45SdVf5V25C0pMudF2JJ
 R76Ai/tse8h87AlwYe5a1V/s1Vl8vQIfqeJBBYz23Qytb1yyjA2OK0fAObcAzOxlEhEW
 7pVQrhjvZ0ib9Ntf/4VrNKuGLfQpqPYjypY6ni64O9jPZzxJZlTMmE3CyhQzu0uGY4r5
 3No2outpX0vXPN2dAJL3R3ZaSB+xdVLjSF3P5jzK3i3vpKNz/ANhugW/d6K3xJlvzDXp
 8hQU8e0luz+N1bS+WkMl3sH6zKM0U1Q34oT3FdkRQ/H4+noWkyIa5q9aNjPXZYpNH94b
 CMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778161638; x=1778766438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0vnX1tchTMN4f4eTabnG6jZSrIEMOA2BX2sx6GfZ0fk=;
 b=SbEBO3wTK5yMlcQFEO/vb0uIqs49XPHfbKTaUAZCANxEnmHgQ3+8CeJDub3GmbgaXh
 vAKWSdRHWzwLcm+bn5JOi45OqWFKbzhacFStVtWPWPmqQeRAxiF1on4Zl79VwXjV4MeY
 rXJFKn29N+jLXPGzYn/cHqbojAQFcMxklkrzuwfkWDQBRRwArDthzlhHG5cHQOkIhwip
 DpLkSgB+RIniUWsBqIziS/vFLPqxRxjBA3QDgqTgbAUeto5Vmx+7PixF0Y8RKHGTEndk
 Lt+sHM8OJsnr/6tSIIk/oD54uM7NbPDVLHZYkpoUUeRu3FpXvn5z6Tl6PHuU4veIL/gy
 3evQ==
X-Gm-Message-State: AOJu0Yy6ogjV8qlzjm+F2gaIMlOR3MPxTrpiG2PDnmT5xsyoomW6t6Kc
 +zB5RURc59KaavgRyNmkaCQeUnLmwMTtsGbT+nF7kPQWuMlUlBTKOIlTLs5KF1vjehiqiiUFd1u
 7T2a22wM=
X-Gm-Gg: AeBDies0icfrr8bewwY/ey10B4cJQ3sODuAPgq9xWxMjc1//EanAC5KyZ/ui2WOXIYZ
 JxBYfpX2ka1/BxC3vtSXetGXHeA/gQKiRbfSAIauhLgBOTMr7IwRXxNzDYCgevSUUACgFJ60B4D
 eTAVBLLjU2NOh+RyJRFcO77E4+sPP1lH6EU194TewBv/DwowhHVdytUPQzIu/mSLnOvm8FN40Mx
 yR/6X+F/Iw9rxyRyWSqgJAxf56mSdfp0bSrNW5PIVuQu0CJ3YKjt74zVjfCO05vehHjZxjv2Q37
 posxesHAIAVQzppunahrQF3W7SGT10tnOA+ULTwBs4BKDKcZYIIazPurWxO7YLhphY5XvZciZQT
 W2pbzUTW9P/iHvOe8y/WwUOGfOhvT3Ya7XPf3dDdo/TEfNmjvrprqhc9jIY7cpTGF5Th51wpW+y
 UC+0PbPdAxTdkOLvDV85mTWUsJcp8HBd5AUZd9Rt+dRKYG37Zfst2avT8uflfhDaKPRS/WppL+b
 +Azj1IW6os=
X-Received: by 2002:a05:600c:8b08:b0:48a:5501:7995 with SMTP id
 5b1f17b1804b1-48e51f32ca9mr140288565e9.18.1778161638183; 
 Thu, 07 May 2026 06:47:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538fb1a7sm220467085e9.9.2026.05.07.06.47.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 May 2026 06:47:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] target/arm: Rename Aarch64-specific methods
Date: Thu,  7 May 2026 15:47:08 +0200
Message-ID: <20260507134709.70507-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507134709.70507-1-philmd@linaro.org>
References: <20260507134709.70507-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Various Aarch64 specific methods start with the 'aarch64_'
prefix. Rename few more emphasizing Aarch64 specific features.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/internals.h   |  8 ++++----
 target/arm/cpu.c         |  8 ++++----
 target/arm/cpu32-stubs.c |  8 ++++----
 target/arm/cpu64.c       | 12 ++++++------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index a632584a4e0..27b284f17b9 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1746,10 +1746,10 @@ int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg);
 int aarch64_gdb_get_tls_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_tls_reg(CPUState *cs, uint8_t *buf, int reg);
-void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
-void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp);
-void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp);
-void arm_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp);
+void aarch64_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
+void aarch64_cpu_sme_finalize(ARMCPU *cpu, Error **errp);
+void aarch64_cpu_pauth_finalize(ARMCPU *cpu, Error **errp);
+void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp);
 void aarch64_max_tcg_initfn(Object *obj);
 void aarch64_add_pauth_properties(Object *obj);
 void aarch64_add_sve_properties(Object *obj);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 10feb639c4d..d670ffe4de0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1682,25 +1682,25 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
     Error *local_err = NULL;
 
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-        arm_cpu_sve_finalize(cpu, &local_err);
+        aarch64_cpu_sve_finalize(cpu, &local_err);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
             return;
         }
 
-        arm_cpu_sme_finalize(cpu, &local_err);
+        aarch64_cpu_sme_finalize(cpu, &local_err);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
             return;
         }
 
-        arm_cpu_pauth_finalize(cpu, &local_err);
+        aarch64_cpu_pauth_finalize(cpu, &local_err);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
             return;
         }
 
-        arm_cpu_lpa2_finalize(cpu, &local_err);
+        aarch64_cpu_lpa2_finalize(cpu, &local_err);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
             return;
diff --git a/target/arm/cpu32-stubs.c b/target/arm/cpu32-stubs.c
index 9e50bb1b0b5..d42b1a5d6a6 100644
--- a/target/arm/cpu32-stubs.c
+++ b/target/arm/cpu32-stubs.c
@@ -4,22 +4,22 @@
 #include "target/arm/cpu.h"
 #include "target/arm/internals.h"
 
-void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
+void aarch64_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
 {
     g_assert_not_reached();
 }
 
-void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
+void aarch64_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
 {
     g_assert_not_reached();
 }
 
-void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
+void aarch64_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
 {
     g_assert_not_reached();
 }
 
-void arm_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
+void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
 {
     g_assert_not_reached();
 }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index a93ad2da5ad..b38a78aac3f 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -60,7 +60,7 @@ int get_sysreg_idx(ARMSysRegs sysreg)
 
 #undef DEF
 
-void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
+void aarch64_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
 {
     /*
      * If any vector lengths are explicitly enabled with sve<N> properties,
@@ -121,7 +121,7 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
              * Disable all SVE extensions as well. Note that some ZFR0
              * fields are used also by SME so must not be wiped in
              * an SME-no-SVE config. We will clear the rest in
-             * arm_cpu_sme_finalize() if necessary.
+             * aarch_cpu_sme_finalize() if necessary.
              */
             FIELD_DP64_IDREG(&cpu->isar, ID_AA64ZFR0, F64MM, 0);
             FIELD_DP64_IDREG(&cpu->isar, ID_AA64ZFR0, F32MM, 0);
@@ -336,7 +336,7 @@ static void cpu_arm_set_sve(Object *obj, bool value, Error **errp)
     FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, SVE, value);
 }
 
-void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
+void aarch64_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
 {
     uint32_t vq_map = cpu->sme_vq.map;
     uint32_t vq_init = cpu->sme_vq.init;
@@ -408,7 +408,7 @@ static void cpu_arm_set_sme(Object *obj, bool value, Error **errp)
     /*
      * For now, write 0 for "off" and 1 for "on" into the PFR1 field.
      * We will correct this value to report the right SME
-     * level (SME vs SME2) in arm_cpu_sme_finalize() later.
+     * level (SME vs SME2) in aarch_cpu_sme_finalize() later.
      */
     FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR1, SME, value);
 }
@@ -548,7 +548,7 @@ void aarch64_add_sme_properties(Object *obj)
 #endif
 }
 
-void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
+void aarch64_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
 {
     ARMPauthFeature features = cpu_isar_feature(pauth_feature, cpu);
     ARMISARegisters *isar = &cpu->isar;
@@ -666,7 +666,7 @@ void aarch64_add_pauth_properties(Object *obj)
     }
 }
 
-void arm_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
+void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
 {
     uint64_t t;
 
-- 
2.53.0


