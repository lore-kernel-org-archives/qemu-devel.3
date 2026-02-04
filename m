Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76866E9539A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnchr-0006cq-NQ; Wed, 04 Feb 2026 08:14:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnchq-0006aN-2u
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:14:06 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnchl-0000cX-5M
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:14:05 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-658b511573cso11465095a12.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 05:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770210838; x=1770815638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ddHqE3wsLOoUWKgCDcSl6HfZDeo+Nc4hEYigGKAOnAA=;
 b=n8KvPVHjPUiFCCv0ooLmkmjTpI+td9fHMMzAA/waaxPB9mVbnVOy1unMejCoi+W4In
 rtq0S/CNfVK37HyLzrh6KivvYesUDgfmzhefcuEqaMadqxVrVlT2ZCA3aAx3Qm0YAWTQ
 XovB74OT/CfwvTgQzStR+73cwTr2iRk1//pU2yIjR3c6BJVhAEeFcGJ4OeP6IeoZw2sd
 dqdfjGhnnI6RdLR37jGeadR2MQ6ZRrGjqM9Qxb6f9pNidBaNJ1PMavPZeRjawbkb61xx
 cFHDfUf/7H61SJYyMA3pFaZBHHgTGgJQgmVplDD+96kirstyQEt2o+e+guLU/DQQYHLT
 oHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770210838; x=1770815638;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ddHqE3wsLOoUWKgCDcSl6HfZDeo+Nc4hEYigGKAOnAA=;
 b=FS6/YgaU28a1lMc/ZuepIdJqN0NdxL6DqIL7dJNANln7cpYrHKEK2tFA/vpyqpgDi7
 qqw9fi9FllZTxkFnSyAB6BR9LEvkHZswOwHhr+PCeCNLYWy5T6yWKDhLY/fo+/YxuXHv
 FM9kdJaAYE4QXBYAVta1KMo/NIrk0pJ379h0uVEbdr4NaqFFgpCq9YkMwQ7C4hQ1Kmj6
 FDSHBI6I/HbgsJ6YdpH6Fmvt7kkfoJrPrigmq8l4/TcXNLxjaF/8+b7Dy3NiG/oZB75T
 /d1CgtcTe4cH6AAJoMRmBsqJbUUQH20FXCNX3qrToSJEHOEegmMJqCkUc9EB0F7Mh9sm
 saRA==
X-Gm-Message-State: AOJu0YzNgCQYxZdI/JNT2YV9gpMgS9T7/h3K4FxnEwK54bu/GMUUzfCF
 9Vwq/pUOclWcZqA8w6omgHX3cizaZvXDqZa/L95YHyY8vwGs5q5/ILAj7zw+w2sSGqo=
X-Gm-Gg: AZuq6aLQ91ggxSZ0dfXTT/bFO+96Hrk+YLg1Y3jt07vLyPDRp49FEbcGVweAviPmzQw
 IOdm6ZLC7LwFlpnxARSu2ynKXlWnWp6aIxGzSZG8iLWehhRYPlFMK0M1uonwVIvmhoVPwYNSdqf
 Ry3o0p/QRBbnbiJr+6hNcTn4dIztdvd/A9cD2wnC3qrANXpcjNf6JGvp5mG+wzJcEBj6hneR+wF
 h4Wzhf1hFZtSxrEKjRaTnx/oUdr89ZLVXUQO6yYOcg7ISweU5fRKFaWgHU0NYyGd+5JuW6QZX33
 S1uL7SgGOZNY2B0ZHRQxeYbr0roBfEfNrJpeJP7HKp48bI4hHxIoKNXB3Iw+uX01coseZPV0Lk7
 ZxlLsnckZp5y1e9k/903Mw6wehUSbbOVti+SZyhSTRln7cvv+zdNF8q4zNt5z1qrdZqC+1Fr47y
 rXOg0H0BFwQ5U=
X-Received: by 2002:a17:907:9723:b0:b80:4030:1eca with SMTP id
 a640c23a62f3a-b8e9f161e1emr200756066b.2.1770210838373; 
 Wed, 04 Feb 2026 05:13:58 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8ea00455adsm124120266b.60.2026.02.04.05.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 05:13:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B2CF85F80E;
 Wed, 04 Feb 2026 13:13:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH v2] target/arm: implement FEAT_E2H0
Date: Wed,  4 Feb 2026 13:13:53 +0000
Message-ID: <20260204131353.2977855-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

FEAT_E2H0 is a formalisation of the existing behaviour of HCR_EL2.E2H
being programmable to switch between EL2 host mode and the
"traditional" nVHE EL2 mode. This implies at some point we might want
to model CPUs without FEAT_E2H0 which will always have EL2 host mode
enabled.

There are two values to represent no E2H0 systems of which 0b1110 will
make HCR_EL2.NV1 RES0 for FEAT_NV systems. For FEAT_NV2 the NV1 bit is
always valid.

Message-ID: <20260130181648.628364-1-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - new helper and properly handling NV1
---
 docs/system/arm/emulation.rst |  1 +
 target/arm/cpu-features.h     | 12 ++++++++++++
 target/arm/helper.c           | 16 +++++++++++++---
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index e0d5f9886e1..7787691853e 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -54,6 +54,7 @@ the following architecture extensions:
 - FEAT_DotProd (Advanced SIMD dot product instructions)
 - FEAT_DoubleFault (Double Fault Extension)
 - FEAT_E0PD (Preventing EL0 access to halves of address maps)
+- FEAT_E2H0 (Programming of HCR_EL2.E2H)
 - FEAT_EBF16 (AArch64 Extended BFloat16 instructions)
 - FEAT_ECV (Enhanced Counter Virtualization)
 - FEAT_EL0 (Support for execution at EL0)
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index e0b7a45b7bd..78ff761ae06 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -347,6 +347,7 @@ FIELD(ID_AA64MMFR3, ADERR, 56, 4)
 FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
 
 FIELD(ID_AA64MMFR4, ASID2, 8, 4)
+FIELD(ID_AA64MMFR4, E2H0, 24, 4)
 
 FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
 FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
@@ -1378,6 +1379,17 @@ static inline bool isar_feature_aa64_asid2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR4, ASID2) != 0;
 }
 
+static inline bool isar_feature_aa64_e2h0(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR4, E2H0) == 0;
+}
+
+static inline bool isar_feature_aa64_noe2h0_and_nv1_res0(const ARMISARegisters *id)
+{
+    /* 0b1110 is not permitted unless we have FEAT_NV */
+    return isar_feature_aa64_nv(id) && FIELD_EX64_IDREG(id, ID_AA64MMFR4, E2H0) == 0b1110;
+}
+
 static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 390ea32c218..c3f4054a0b0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3776,7 +3776,8 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
     }
 
     if (arm_feature(env, ARM_FEATURE_AARCH64)) {
-        if (cpu_isar_feature(aa64_vh, cpu)) {
+        if (cpu_isar_feature(aa64_vh, cpu) &&
+            cpu_isar_feature(aa64_e2h0, cpu)) {
             valid_mask |= HCR_E2H;
         }
         if (cpu_isar_feature(aa64_ras, cpu)) {
@@ -3801,10 +3802,13 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
             valid_mask |= HCR_GPF;
         }
         if (cpu_isar_feature(aa64_nv, cpu)) {
-            valid_mask |= HCR_NV | HCR_NV1 | HCR_AT;
+            valid_mask |= HCR_NV | HCR_AT;
+            if (!cpu_isar_feature(aa64_noe2h0_and_nv1_res0, cpu)) {
+                valid_mask |= HCR_NV1;
+            }
         }
         if (cpu_isar_feature(aa64_nv2, cpu)) {
-            valid_mask |= HCR_NV2;
+            valid_mask |= HCR_NV1 | HCR_NV2;
         }
     }
 
@@ -3823,6 +3827,12 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
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


