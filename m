Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F07CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 17:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOIdV-0004LQ-1n; Sat, 16 May 2026 13:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOIdI-0003iZ-FS
 for qemu-devel@nongnu.org; Sat, 16 May 2026 13:17:02 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOIdG-0008CH-Jk
 for qemu-devel@nongnu.org; Sat, 16 May 2026 13:17:00 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-449d6c68ed8so752318f8f.0
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778951815; x=1779556615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jK7qGzHLhnk2A1+FDhnQPXqGGZvsf0GaBoX/NZPQKsM=;
 b=E5Rnc7B0adAp4msZ5JwNTOZJu3SIRsXcuEYnQvvVomlJDKYFV8nDg7I1v35/vzmmxF
 CfD2wiTVMiWvNzGlVWa4ZB176BC0nb1doge02JNEx+WqQI5kyMcyA4ApSxGGghxeG0Kn
 Uol61DX+gnrjopJRaeom6N0oVHioft1RqQz2snRfnJg6V6xOCmeBwIbSVxT3qai4G23u
 DI1eOeXpojycojpiFbZF8fYnnVr7E2pkOjlinpUwIr2n/GQztYB1quU++j66zYs1oB+7
 9z6Tz6XZaKSnpJuCgyLVynXrIwdbmd+9W/yViRkYW8tiHLuN9amDMIWxpwmWWx2BxJ35
 9qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778951815; x=1779556615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jK7qGzHLhnk2A1+FDhnQPXqGGZvsf0GaBoX/NZPQKsM=;
 b=AZYLiWt2/Wi6RTe6Cf+Qp6q1SiQiGOLk7KE3ACcOtDDYRhG8XC6c8HIuawV/JbuT0M
 pqDdmmVYWAiLPSY1yAjjbr/ANAZfwk2fYdff2rxGCZCnqQfgddxZnGqsGapVZBzh9w/K
 XWGf/bZ0yA6jO5dX57903x1w6TcC+BlQistg2n4Azzd01zlcFx5fEAyIdd9qkkJJLAyQ
 oMqUYXcMFfqqwkNvhxflyzK3/s9cKdPsr0ySZDEkGKo8LsrdKEdi0Mwptr3Pf06IrUMZ
 1baewAe4+1AK3fz4NqHWpjgzyz0oxFVNe1Bdkkc8+UvzBmMsIpvKGUqYRpGnrBVpA+iP
 LG/A==
X-Gm-Message-State: AOJu0YzWtPcbm483I6edov39yY+ZRtUfmzcLZLmN8fc2ouZtQ+yWFBWE
 wRKo5gq3EbZb1TrZU2AKWOe2xWfkQ9spmJRwShSJW3rPHs7ll1FznlOkrXJqd36Bw+R7oY/ciSN
 vGbXsEDk=
X-Gm-Gg: Acq92OFluyJAbR/w8aD0iSHLyUzu5BlIIChovnjm7KcMORW44NoJWtWKajs5Y07zQ3D
 mNFjACI3QrUeiImS1ey134Jm5RmfXrIHqNWzXKNQTTe3fUSeZU0LJV7ua4xTwd76SFIY5fkMatU
 ghtZJ0kh+vDVF4U5bv2dORBmuMhdAlKA3+rLM063tdEF6m9WQeCqpXJWxeodLZIkrFjF5a/Llag
 SPhPKPYm1G2LhqDOSOO7X+J2cXBsGY6FAbWBdFOWk6wtRtFyW+lWAJsUG53XlgaKlyVro5fznVZ
 9S4y4yHVpMlqjBCj/Q8P9bSGbv8P6/zqi7l91pn/I9LYAbuE3CgBPt5iQhESAn4kEEhYyfLskgI
 1XGAac0tjzZIt4poFGCsLZoShyvOxTMtLC6ULfxADl5uHzKmKp/mDg/ue/7xZlMgvDeWmSVJkJ0
 YBXIYYPSHnJxlz/j0nCefQke6oZGagcnQRZnKKcdDRfLJMQYli9zfPvnzMfdG7FaiuLYaR6Oxt
X-Received: by 2002:a5d:584c:0:b0:446:db72:e8ec with SMTP id
 ffacd0b85a97d-45e5c587281mr12343588f8f.23.1778951815008; 
 Sat, 16 May 2026 10:16:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768bcesm25526974f8f.4.2026.05.16.10.16.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 16 May 2026 10:16:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Joel Stanley <joel@jms.id.au>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v7 12/21] target/arm: Rename Aarch64-specific methods
Date: Sat, 16 May 2026 19:15:14 +0200
Message-ID: <20260516171524.19184-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516171524.19184-1-philmd@linaro.org>
References: <20260516171524.19184-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/arm/internals.h   |  8 ++++----
 target/arm/cpu.c         |  8 ++++----
 target/arm/cpu32-stubs.c |  8 ++++----
 target/arm/cpu64.c       | 12 ++++++------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 3edc15c7b4a..00830b17248 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1750,10 +1750,10 @@ int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg);
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
index a4eb6a2de5e..c47b70ac694 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1707,25 +1707,25 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
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


