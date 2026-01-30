Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D464CE6BF37
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 20:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlv5c-00019k-BU; Fri, 30 Jan 2026 15:27:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vlv5X-00019A-Nk
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 15:27:31 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vlv5U-00023A-JU
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 15:27:30 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4359228b7c6so1807883f8f.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 12:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769804846; x=1770409646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tTQnyXkt6mPVo9KR5GxpqCjbhjPBX727ATjE1sQOZSc=;
 b=dDSJQ20yFklce901FmL3xoml8zSI9jwceKvqYQIz8TiuZSi4JXaow0H/ALYs7ZrvOe
 f/16mzqPxZ8YwjVcBv0UrNZynn9XfV4K3lIdxppOvJqj79qS+QdDOjq7HhGTu8+tpHU9
 YHqLo9IPphZl0X8TIe2mfywagppHzJg8CpRNDhLaV5gD56CNX2SmMlODirDHZMv3Unkk
 94CeseAmbvQbOWtr34Ctr2bmkCohqoR7yiGB1q23CPNliEVDyiD7TtIQtmghdHutD6FP
 rI+nhPWa9WK5VEXMZ8KhBb3OG3fPCOonBrFG+Cy2YI2CeSO5TP1MpRcBaV7wkYE2zzFk
 bi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769804846; x=1770409646;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tTQnyXkt6mPVo9KR5GxpqCjbhjPBX727ATjE1sQOZSc=;
 b=rYlxfyM/SDoLRp8ON7zBSP4623uGCHjFjvi3CEPxKdb7FpQ2CAI7nzPgTHYystRB1L
 aKxPIYmCgoQpiaamOk8xnfJ74lCYk/SLCs0xV9oUIPBx/k/Dy22AlvzPPxe+a55qcusL
 v4JR90uVk5Q7jcPFmYTqX940U3wQPw5zTZ4gMbKv2RekWUbfGcWs1ahGrp440p678xff
 O2wSD4zZTG85Rxvwe5uwXlA+41qwC3oy52k0Gj/kV4ruh+ORmnhUBZJPQEDMPlN+5UgN
 hGsl/GWTWrcIwurupYYYC7nxLNFQquduP1HhL8L26JDYWH5jqPuUmYFicA76RZKJYaIu
 5vPA==
X-Gm-Message-State: AOJu0YzoE7MkG3dhDuFmM3gmJ0hzGn+vlrSEqPkkGxHEauwDEbit9H8o
 FUZezyuCunZo0kFFKZEU/Q+Rs+9jRB+wp+sTZGx4x1Re4IrkTDByuScy3Kt5ZV3Eyjo=
X-Gm-Gg: AZuq6aL0Mkx7MQtHCtkwz5sogJAch56Q6n/cfvE33nA2flxbhG+2MWtNBsjA724w1pE
 2itazw9jAuvyTezWxdtpn+PxLO5kt5ggmCOFjVVL2NVamAx+eTckUcO4VAM3WZDkCFl2StwaEGC
 GVm7iz4qdKfqyo/VdMEBO/CCDkSDB/k+SBlXsAq8S6VR1L1OM4CUijRs6S7unpvahYxJmwsoZBO
 ASjOW0cu90BK7OO7Hg3Yb9utbhXCg7hIZCF3vrjB322/AyAClEuo9Jd1VYPeZ1Ui7zgR7ykaYVf
 uQ+VNxPU0LKiXZa3U8dlBDbVEEpAu952Ghvfs++ZUuHF1IDuf6yXdTkiff1jdbXlZiQAc0ZvZYo
 uebvkmuuRvQBKNWIER6Elk9Wyh7vJkWUdARKuFG0g2gLcLvtPnw6tCJfPe3iF2JuXuOrQyzJB1e
 uutMvNEHqLnl8=
X-Received: by 2002:a05:6000:1861:b0:430:fd60:940f with SMTP id
 ffacd0b85a97d-435f3a86042mr5570792f8f.14.1769804846284; 
 Fri, 30 Jan 2026 12:27:26 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1323770sm24908117f8f.32.2026.01.30.12.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 12:27:25 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6AEC55F898;
 Fri, 30 Jan 2026 20:27:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH] target/arm: implement FEAT_E2H0
Date: Fri, 30 Jan 2026 20:27:21 +0000
Message-ID: <20260130202722.667885-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

FEAT_E2H0 is a formalisation of the existing behaviour of HCR_EL2.E2H
being programmable to switch between EL2 host mode and the
"traditional" nVHE EL2 mode. This implies at some point we might want
to model CPUs without FEAT_E2H0 which will always have EL2 host mode
enabled.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
comment: I've left a fixme? for HCR_EL2.NV1, I await guidance on if
I'm reading the spec wrong.
---
 docs/system/arm/emulation.rst |  1 +
 target/arm/cpu-features.h     |  6 ++++++
 target/arm/helper.c           | 14 +++++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 3f30ea5a30e..74359f3e844 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -53,6 +53,7 @@ the following architecture extensions:
 - FEAT_DotProd (Advanced SIMD dot product instructions)
 - FEAT_DoubleFault (Double Fault Extension)
 - FEAT_E0PD (Preventing EL0 access to halves of address maps)
+- FEAT_E2H0 (Programming of HCR_EL2.E2H)
 - FEAT_EBF16 (AArch64 Extended BFloat16 instructions)
 - FEAT_ECV (Enhanced Counter Virtualization)
 - FEAT_EL0 (Support for execution at EL0)
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index a7ca410dcb4..b6ef328fe0a 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -347,6 +347,7 @@ FIELD(ID_AA64MMFR3, ADERR, 56, 4)
 FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
 
 FIELD(ID_AA64MMFR4, ASID2, 8, 4)
+FIELD(ID_AA64MMFR4, E2H0, 24, 4)
 
 FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
 FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
@@ -1376,6 +1377,11 @@ static inline bool isar_feature_aa64_asid2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR4, ASID2) != 0;
 }
 
+static inline bool isar_feature_aa64_e2h0(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR4, E2H0) == 0;
+}
+
 static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 655ce73ee1b..27b5fb01827 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3773,7 +3773,8 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
     }
 
     if (arm_feature(env, ARM_FEATURE_AARCH64)) {
-        if (cpu_isar_feature(aa64_vh, cpu)) {
+        if (cpu_isar_feature(aa64_vh, cpu) &&
+            cpu_isar_feature(aa64_e2h0, cpu)) {
             valid_mask |= HCR_E2H;
         }
         if (cpu_isar_feature(aa64_ras, cpu)) {
@@ -3797,6 +3798,11 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
         if (cpu_isar_feature(aa64_rme, cpu)) {
             valid_mask |= HCR_GPF;
         }
+        /*
+         * FIXME? HCR_EL2.NV1 is only meant to be RES0 if
+         * FEAT_E2H0 is not implemented with 0b1110 although the Arm
+         * ARM doesn't explicitly state it is RES1 with 0b1111.
+         */
         if (cpu_isar_feature(aa64_nv, cpu)) {
             valid_mask |= HCR_NV | HCR_NV1 | HCR_AT;
         }
@@ -3820,6 +3826,12 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
         value |= HCR_RW;
     }
 
+    /* Strictly E2H is RES1 unless FEAT_E2H0 relaxes the requirement */
+    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
+        !cpu_isar_feature(aa64_e2h0, cpu)) {
+        value |= HCR_E2H;
+    }
+
     /*
      * These bits change the MMU setup:
      * HCR_VM enables stage 2 translation
-- 
2.47.3


