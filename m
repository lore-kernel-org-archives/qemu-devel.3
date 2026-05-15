Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F00CD4F47
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtGu-0006s5-TM; Fri, 15 May 2026 10:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtGj-0006c8-C5
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:12:02 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtGg-0004BU-RE
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:12:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48374014a77so80104595e9.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854316; x=1779459116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X4z7sxEcq8cgRQJzCS3+RxU14e+GbTMxdJeSkxmfOJw=;
 b=hpGeArNBD4Mwkogag54w4+B9D2R2u+jp3G9RyoFVRwNFtFg+I6bbZNEF/+P7NU4bqh
 wqm+1nozmpimelPF4DkKbaMbw71oSw/Dcl4XFEYOSKFTJ5PPYGj8CBMBcQvNNYPug1eR
 lp54ko0AOQY0V9TJi5f2IifM+XVfVRhnYOVmStDPGta73cpt7QR/8Sk/v3rEugsfltYS
 FL3iLD9+LL+maw9TyCFiAYwRj3eH6V1nbAnFpknDG+zxqhXK9QKkN08LrfG1mrFJHSd6
 dL2VwRXrYETpCQ2pZif1Unz3qS+BxJXqHz5aL5F/5hWQ1FLhtyCAuESx+q5e+NmagCX4
 XJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854316; x=1779459116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X4z7sxEcq8cgRQJzCS3+RxU14e+GbTMxdJeSkxmfOJw=;
 b=Q3o2dNy2YnL62Xeum/cmoEGYLw2YvnCtujIZLZaZbuvknqUmxhvGkVUnmiS+kaui6i
 k1Swbg7lo6xazci0YvX3aKvIBS7QBnLJaIhMGO9P6Zmgqi2vRDwOcEFfABaXkxuMgb2s
 O0XgYOWmfQqm/MRvycA5SBBH654fZb7l5a9HRFW1b7qKoP5QVQNFUujckHlYjwSZiieI
 Va+fH/pzkfB8ZWqpOiAIcQ6ImoP/U/Arh+zSQ6+9I4UPHucgdRsHbqvx35UfyxMXgD5T
 NljjvTokfRwRiZrAfbxECJQPn6LIH+nGjEunYTmgOjtApGt9A15WuuoQhGpl/3V87mqV
 drHA==
X-Gm-Message-State: AOJu0YzED11APRAw59uq7fP2nc/Ei5fbX2yoBHgBqou4ubSXQq13qGnm
 d7UappMLoXFR9S0I581/K42ZF0SrnuySHA5g7TNEMSq3ckYST0FTmSR4BVrAwLonIfHTlemPXgU
 kEzowAPo=
X-Gm-Gg: Acq92OHUlzN9jH0Hg1j9XUSTa1pqXVPrSUrcu2+Mu/1kQ13i07e3HOwfXAq1t9iOpt6
 +jocffxdd4bgbrDsbCO76l7yytDgR/Y1b6BXA4QOTrpiHgebcn8kgGJTCSuK/rZb4CsDz96sBr9
 DPQ6sTJRlJO+DFv+o+/15BbTGz9UnWN/Rh6pZqmicqmpyjYlSNFub7eEyozfRfq3BPPWRHzdSk1
 /jspR1U0JtCtN8gypb/z+WV40Q6TxAnCNXUikpzmzQ7UFl1sC2cz6wKSokRr7BPqWFaQzFhxKnt
 qsmmQM15RqsgXKFHJwGcGjIJDeLi1Fo+5hgTGjDYkudysMzP/iB9cGKXnYFrRnc0A+RrpdZKMaK
 D3Me56296ZIDZAkJ6k7bb2wRLC8wuNGDmsALAC5CRnd9q/FjRnC2d/QSna/PoMPV36iREV5msPC
 ZHC8wXPx1BjoXBZDkW8+Zp/qVnC9sUCyDFbA+Q24mWPdsNQj2yy1Kn5C5nrmjCfr9dr5uDb3ZFZ
 DyQhKLHomM=
X-Received: by 2002:a05:600c:c087:b0:48a:7b55:12a6 with SMTP id
 5b1f17b1804b1-48fe5cb36aamr50828545e9.0.1778854316524; 
 Fri, 15 May 2026 07:11:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fead1c364sm16411955e9.8.2026.05.15.07.11.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 May 2026 07:11:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 11/20] target/arm: Rename Aarch64-specific methods
Date: Fri, 15 May 2026 16:10:22 +0200
Message-ID: <20260515141032.3271-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515141032.3271-1-philmd@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
index 76f5909e902..31e1fd6cd51 100644
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


