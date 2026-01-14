Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F317D31A25
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 08:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfwLq-00006O-Ny; Wed, 14 Jan 2026 03:35:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vfwLh-0008VQ-3M
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 03:35:30 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vfwLd-0000Vr-Pt
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 03:35:28 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47ed9b04365so10670385e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 00:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768379723; x=1768984523; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5ZPwJRHQFilEPOEWOmwxWP3sRhP1MADwliPZOkuPvbc=;
 b=xH5lJZtDQKtykHwnzQH2zj9bEBk6WK1FHzH6Wjav5zpZ9VOBc8n+0zAq6WGboyf42y
 7evy+mXeQ1IdNpU3qvtVi4r+DJZrQ0CSF7Sc8pWbQXcl1f5ZTQ6GoL+r9wMiSghL8VEE
 Gwcj2zmO8orXZc7tyM0pyaWVi5d+pfG9iBAI8aXHZSTRjQzV0UkG5T874yRapRZQR8uW
 EnmwpG56aApZA14msIzmgKMhcpBe1isTZ2vpoGSdjhKeq59v24g3AMjAR7/7lc9mvlQw
 0co0r0pRn1Mw6usA15JpS2hYejaXJkZ54T4iqo1xF/B6HXcEbaiMbbxxlOq49EgIgzWn
 nyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768379723; x=1768984523;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5ZPwJRHQFilEPOEWOmwxWP3sRhP1MADwliPZOkuPvbc=;
 b=kHHDamStlwTpVwV8lezG0bJolsHu89iM7D3OyKp702ZkXWoBJ4AJfGh8k52HzlZ0T9
 y5z6xW6/8wuwNUUtoGuXqqSsb+B13rLDh+Fak0JcFCZs9F5nxJlWq0JKJ6Bx3fG9k0ev
 m2IgtMl5iRAwZi8gd/+QxuRt2cBEkK4lbrLY+eL0hco5bsm3WMp1rA2tpwJth9icckrj
 LB79MQVOMshtWyqewRZji+jvjq0+Uf/esTvjrIlV8dvM1xWZd1Gh3NU3a4sAvQ+3n/jy
 BAj+NbDeMrQBUoemViVvuPw8YR9Z74yv/ly2CjaU0fcSoHCpWIiJLpN4Z7xgvgh55zOr
 rZLg==
X-Gm-Message-State: AOJu0YzJHGAi9mpYwZz4w+c+Bhz67dUwMHmiJwfnSPG6AT8P+CHb8Ltu
 OIE1en4CGARCxSdUSph5AKc9o8otNGBBkzK4u+Jmdw8E9B7dJ8NNxtV7NJZxzRajPtE=
X-Gm-Gg: AY/fxX7a18F8kFVs4X1MbQPpni+XSscoxAJF+HJt6zIJs+lSYF9pUF34V/oHLTj2Sl+
 EHHPjLGlghEcYbJI5Kw4hMtPkf2zv0ogUhSlfntOnD4CvPxNL90A7dzll7ZkXVJlt6Zh7ABSl1X
 17vh/5g/RjGm1WykOOBAYLNsKtzanplsxp9wH4onH1dv0X7XgKbx9/bxMHjk7QMW/cNscQBXSPn
 F8z4CdDxBWxdh1IRZ6exOFYYc9S7L10gOfZEXptPelVmyM4Fmk9T6gRVHSc8c0Gg9MHkQRY8IwH
 J4WOlcFMPRrsAXhFatUx88OdumOq+OvXpTsgF63zBvlupnPs41K+R3EL1+fAeFjINHUzEpZ3RNE
 EJdv3qYP4PAsdJLjuL2ad2nBCZIxRtlp1iVyPpUGnygMJTy3LGWQ+riQ+5GYqDrSLc50EZVRUc4
 HWcoM/c/Mcs4OvaBcPgSWVNDgnGOOyIgYlDPDgfdb+kF+fJwbwMZDnilKdQSGhypjl6niH0azJm
 HARIF4v5U/MnO/VlECZPznL
X-Received: by 2002:a05:600c:470c:b0:47e:e2b0:15ba with SMTP id
 5b1f17b1804b1-47ee32e03edmr19647835e9.8.1768379723045; 
 Wed, 14 Jan 2026 00:35:23 -0800 (PST)
Received: from [127.0.1.1] (ppp-2-86-214-23.home.otenet.gr. [2.86.214.23])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm50121053f8f.22.2026.01.14.00.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 00:35:22 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 14 Jan 2026 10:35:03 +0200
Subject: [PATCH 1/2] hvf/arm: handle FEAT_SME2 migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-sme2-hvf-v1-1-ce9599596736@linaro.org>
References: <20260114-sme2-hvf-v1-0-ce9599596736@linaro.org>
In-Reply-To: <20260114-sme2-hvf-v1-0-ce9599596736@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 =?utf-8?q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=18478;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=NvcBLupGc8GMVdtjdth8YjCrppGSEu88OnpCqMiQAOw=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnBaMVZJbU0zNnpxM2F0RDh3NjNzeWgvdElIanhoCmk5YXFtQ2VHdjJNTnQwU2Jp
 MXVKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYVdkVlNBQUt
 DUkIzS2Nkd2YzNEowUGtoRC85L00xcmJuOTZOck5rV0RlN3JxWHd5eDRoc1dTc250UFBsYndMcg
 paZkN1YnNFR3B3anJkSENtWitWbVBXOXRHaGtDOGhmVTh4UTZsSUlIdkl3ZCt4V1NLZHpKTytPe
 HZ2QnZjMnIxCmlRZGM4Y0k3a2ZGQk5jUmk3anFMMmJqQUk5aG5WYUNMZnQ1eEF4YTkzdGVDeDVj
 WFdGVEZKTklRRXBac1pzbXQKRGl1TGJ5bGlpN0pSQWZjbmdKaW04UWlESjRjUXZ2anU5OHljVE1
 xY2NKQVdVVFZiTFhHNnlWZVVhR2J6dlIwMwptOFhyRGJRZVJ2ZkNVUG1wRlZ3ODdMUHRXSUdCQl
 QrbWh2d0l0bWRuclg2Z2F6OHdZU0V0Z0dURFNSME1ZTUhwCnhJeEpJT01hRE9OR2ExekxUQ2x3V
 GcyNlhlMElRR0psM1NoYWtCU2ErMC9iR2VtdTM1QjNnUUZRK3M2MUQvajEKWkllNWtZWWhRM0l6
 NitQMmNkUVZDMHo3NVc2WnhHK2NZUnFLZzMvelZIaUgwYmRTMGhpZXRuS3lmZUV6ejFWbwpVRW1
 FYWpOcnBYc1A2R29EZS9rdnJ4ZXNzMTlmalk5WWFhYzRLc2lmSWdMakErVFgvUGg4MW8ybFozV1
 I3VE05CkFOU3Nsckh5TGVMcWZ1WGUxWFZMTFVDSklyaGhtd0lYSWlhaVgra0NqVUhXamdqWFhHZ
 0pLTG1kaGthN3pPeXQKTkdVQjAyZFB2a2ZnclNMdk4zMnlLMm5PMW5yQk5YUnRscUdJSndUMzJN
 NENwMnN4OW0rWUY1Ym16Z29QOTVkdgoxVk44encwRmIxbElnMkN0N0NTVldHV1FzUXZLcGszcm1
 5a1VibFF1MHFvWTRvTnZ3dG9MNEYwZjYxNm1rSGhTClFrbTJSdz09Cj1hc2VvCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
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

SME2 support adds the following state for HVF guests:

- Vector registers Z0, ... , Z31 (introduced by FEAT_SVE but HVF does
  not support it)
- Predicate registers P0, .., P15 (also FEAT_SVE)
- ZA register
- ZT0 register
- PSTATE.{SM,ZA} bits (SVCR pseudo-register)
- SMPRI_EL1 which handles the PE's priority in the SMCU
- TPIDR2_EL0 the thread local ID register for SME

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/arm/hvf/hvf.c        | 293 +++++++++++++++++++++++++++++++++++++++++++-
 target/arm/hvf/sysreg.c.inc |  10 ++
 target/arm/hvf_arm.h        |  46 +++++++
 target/arm/machine.c        |   2 +-
 4 files changed, 348 insertions(+), 3 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index fa26f63a61ad8fc2ffb675bd6d3c7fd21f1a9dae..42547b175c30c01c2b7e060dcc01d1e11efb0d1b 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -397,6 +397,62 @@ static const struct hvf_reg_match hvf_fpreg_match[] = {
     { HV_SIMD_FP_REG_Q31, offsetof(CPUARMState, vfp.zregs[31]) },
 };
 
+#if HVF_SME2_AVAILABLE
+static const struct hvf_reg_match hvf_sme2_zreg_match[] = {
+    { HV_SME_Z_REG_0, offsetof(CPUARMState, vfp.zregs[0]) },
+    { HV_SME_Z_REG_1, offsetof(CPUARMState, vfp.zregs[1]) },
+    { HV_SME_Z_REG_2, offsetof(CPUARMState, vfp.zregs[2]) },
+    { HV_SME_Z_REG_3, offsetof(CPUARMState, vfp.zregs[3]) },
+    { HV_SME_Z_REG_4, offsetof(CPUARMState, vfp.zregs[4]) },
+    { HV_SME_Z_REG_5, offsetof(CPUARMState, vfp.zregs[5]) },
+    { HV_SME_Z_REG_6, offsetof(CPUARMState, vfp.zregs[6]) },
+    { HV_SME_Z_REG_7, offsetof(CPUARMState, vfp.zregs[7]) },
+    { HV_SME_Z_REG_8, offsetof(CPUARMState, vfp.zregs[8]) },
+    { HV_SME_Z_REG_9, offsetof(CPUARMState, vfp.zregs[9]) },
+    { HV_SME_Z_REG_10, offsetof(CPUARMState, vfp.zregs[10]) },
+    { HV_SME_Z_REG_11, offsetof(CPUARMState, vfp.zregs[11]) },
+    { HV_SME_Z_REG_12, offsetof(CPUARMState, vfp.zregs[12]) },
+    { HV_SME_Z_REG_13, offsetof(CPUARMState, vfp.zregs[13]) },
+    { HV_SME_Z_REG_14, offsetof(CPUARMState, vfp.zregs[14]) },
+    { HV_SME_Z_REG_15, offsetof(CPUARMState, vfp.zregs[15]) },
+    { HV_SME_Z_REG_16, offsetof(CPUARMState, vfp.zregs[16]) },
+    { HV_SME_Z_REG_17, offsetof(CPUARMState, vfp.zregs[17]) },
+    { HV_SME_Z_REG_18, offsetof(CPUARMState, vfp.zregs[18]) },
+    { HV_SME_Z_REG_19, offsetof(CPUARMState, vfp.zregs[19]) },
+    { HV_SME_Z_REG_20, offsetof(CPUARMState, vfp.zregs[20]) },
+    { HV_SME_Z_REG_21, offsetof(CPUARMState, vfp.zregs[21]) },
+    { HV_SME_Z_REG_22, offsetof(CPUARMState, vfp.zregs[22]) },
+    { HV_SME_Z_REG_23, offsetof(CPUARMState, vfp.zregs[23]) },
+    { HV_SME_Z_REG_24, offsetof(CPUARMState, vfp.zregs[24]) },
+    { HV_SME_Z_REG_25, offsetof(CPUARMState, vfp.zregs[25]) },
+    { HV_SME_Z_REG_26, offsetof(CPUARMState, vfp.zregs[26]) },
+    { HV_SME_Z_REG_27, offsetof(CPUARMState, vfp.zregs[27]) },
+    { HV_SME_Z_REG_28, offsetof(CPUARMState, vfp.zregs[28]) },
+    { HV_SME_Z_REG_29, offsetof(CPUARMState, vfp.zregs[29]) },
+    { HV_SME_Z_REG_30, offsetof(CPUARMState, vfp.zregs[30]) },
+    { HV_SME_Z_REG_31, offsetof(CPUARMState, vfp.zregs[31]) },
+};
+
+static const struct hvf_reg_match hvf_sme2_preg_match[] = {
+    { HV_SME_P_REG_0, offsetof(CPUARMState, vfp.pregs[0]) },
+    { HV_SME_P_REG_1, offsetof(CPUARMState, vfp.pregs[1]) },
+    { HV_SME_P_REG_2, offsetof(CPUARMState, vfp.pregs[2]) },
+    { HV_SME_P_REG_3, offsetof(CPUARMState, vfp.pregs[3]) },
+    { HV_SME_P_REG_4, offsetof(CPUARMState, vfp.pregs[4]) },
+    { HV_SME_P_REG_5, offsetof(CPUARMState, vfp.pregs[5]) },
+    { HV_SME_P_REG_6, offsetof(CPUARMState, vfp.pregs[6]) },
+    { HV_SME_P_REG_7, offsetof(CPUARMState, vfp.pregs[7]) },
+    { HV_SME_P_REG_8, offsetof(CPUARMState, vfp.pregs[8]) },
+    { HV_SME_P_REG_9, offsetof(CPUARMState, vfp.pregs[9]) },
+    { HV_SME_P_REG_10, offsetof(CPUARMState, vfp.pregs[10]) },
+    { HV_SME_P_REG_11, offsetof(CPUARMState, vfp.pregs[11]) },
+    { HV_SME_P_REG_12, offsetof(CPUARMState, vfp.pregs[12]) },
+    { HV_SME_P_REG_13, offsetof(CPUARMState, vfp.pregs[13]) },
+    { HV_SME_P_REG_14, offsetof(CPUARMState, vfp.pregs[14]) },
+    { HV_SME_P_REG_15, offsetof(CPUARMState, vfp.pregs[15]) },
+};
+#endif /* HVF_SME2_AVAILABLE */
+
 /*
  * QEMU uses KVM system register ids in the migration format.
  * Conveniently, HVF uses the same encoding of the op* and cr* parameters
@@ -408,22 +464,203 @@ static const struct hvf_reg_match hvf_fpreg_match[] = {
 #define HVF_TO_KVMID(HVF)  \
     (CP_REG_ARM64 | CP_REG_SIZE_U64 | CP_REG_ARM64_SYSREG | (HVF))
 
-/* Verify this at compile-time. */
+/*
+ * Verify this at compile-time.
+ *
+ * SME2 registers are guarded by a runtime availability attribute instead of a
+ * compile-time def, so verify those at runtime in hvf_arch_init_vcpu() below.
+ */
 
 #define DEF_SYSREG(HVF_ID, ...) \
   QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
+#define DEF_SYSREG_15_02(...)
 
 #include "sysreg.c.inc"
 
 #undef DEF_SYSREG
+#undef DEF_SYSREG_15_02
 
 #define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  HVF_ID,
+#define DEF_SYSREG_15_02(...)
 
 static const hv_sys_reg_t hvf_sreg_list[] = {
 #include "sysreg.c.inc"
 };
 
 #undef DEF_SYSREG
+#undef DEF_SYSREG_15_02
+
+#define DEF_SYSREG(...)
+#define DEF_SYSREG_15_02(HVF_ID, op0, op1, crn, crm, op2) HVF_ID,
+
+API_AVAILABLE(macos(15.2))
+static const hv_sys_reg_t hvf_sreg_list_sme2[] = {
+#include "sysreg.c.inc"
+};
+
+#undef DEF_SYSREG
+#undef DEF_SYSREG_15_02
+
+/*
+ * For FEAT_SME2 migration, we need to store PSTATE.{SM,ZA} bits which are
+ * accessible with the SVCR pseudo-register. However, in the HVF API this is
+ * not exposed as a system-register (i.e. HVF_SYS_REG_SVCR) but a custom
+ * struct, hv_vcpu_sme_state_t. So we need to define our own KVMID in order to
+ * store it in cpreg_values and make it migrateable.
+ */
+#define SVCR KVMID_AA64_SYS_REG64(3, 3, 4, 2, 2)
+
+#if HVF_SME2_AVAILABLE
+API_AVAILABLE(macos(15.2))
+static void hvf_arch_put_sme(CPUState *cpu)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+    const size_t svl_bytes = hvf_arm_sme2_get_svl();
+    const size_t z_size = svl_bytes;
+    const size_t preg_size = DIV_ROUND_UP(z_size, 8);
+    const size_t za_size = svl_bytes * svl_bytes;
+    hv_vcpu_sme_state_t sme_state = { 0 };
+    hv_return_t ret;
+    uint64_t svcr;
+    int n;
+
+    /*
+     * Set PSTATE.{SM,ZA} bits
+     */
+    svcr = arm_cpu->cpreg_values[arm_cpu->cpreg_array_len - 1];
+    env->svcr = svcr;
+
+    /*
+     * Construct SVCR (PSTATE.{SM,ZA}) state to pass to HVF:
+     */
+    sme_state.streaming_sve_mode_enabled = FIELD_EX64(env->svcr, SVCR, SM) > 0;
+    sme_state.za_storage_enabled = FIELD_EX64(env->svcr, SVCR, ZA) > 0;
+    ret = hv_vcpu_set_sme_state(cpu->accel->fd, &sme_state);
+    assert_hvf_ok(ret);
+
+    /*
+     * We only care about Z/P registers if we're in streaming SVE mode, i.e.
+     * PSTATE.SM is set, because only then can instructions that access them be
+     * used. We don't care about the register values otherwise. This is because
+     * when the processing unit exits/enters this mode, it zeroes out those
+     * registers.
+     */
+    if (sme_state.streaming_sve_mode_enabled) {
+        for (n = 0; n < ARRAY_SIZE(hvf_sme2_zreg_match); ++n) {
+            ret = hv_vcpu_set_sme_z_reg(cpu->accel->fd,
+                                        hvf_sme2_zreg_match[n].reg,
+                                        (uint8_t *)&env->vfp.zregs[n].d[0],
+                                        z_size);
+            assert_hvf_ok(ret);
+        }
+
+        for (n = 0; n < ARRAY_SIZE(hvf_sme2_preg_match); ++n) {
+            ret = hv_vcpu_set_sme_p_reg(cpu->accel->fd,
+                                        hvf_sme2_preg_match[n].reg,
+                                        (uint8_t *)&env->vfp.pregs[n].p[0],
+                                        preg_size);
+            assert_hvf_ok(ret);
+        }
+    }
+
+    /*
+     * If PSTATE.ZA bit is set then ZA and ZT0 are valid, otherwise they are
+     * zeroed out.
+     */
+    if (sme_state.za_storage_enabled) {
+        hv_sme_zt0_uchar64_t tmp = { 0 };
+
+        memcpy(&tmp, &env->za_state.zt0, 64);
+        ret = hv_vcpu_set_sme_zt0_reg(cpu->accel->fd, &tmp);
+        assert_hvf_ok(ret);
+
+        ret = hv_vcpu_set_sme_za_reg(cpu->accel->fd,
+                                     (uint8_t *)&env->za_state.za,
+                                     za_size);
+        assert_hvf_ok(ret);
+    }
+
+    return;
+}
+
+API_AVAILABLE(macos(15.2))
+static void hvf_arch_get_sme(CPUState *cpu)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+    const size_t svl_bytes = hvf_arm_sme2_get_svl();
+    const size_t z_size = svl_bytes;
+    const size_t preg_size = DIV_ROUND_UP(z_size, 8);
+    const size_t za_size = svl_bytes * svl_bytes;
+    hv_vcpu_sme_state_t sme_state = { 0 };
+    hv_return_t ret;
+    uint64_t svcr;
+    int n;
+
+    /*
+     * Get SVCR (PSTATE.{SM,ZA}) state from HVF:
+     */
+    ret = hv_vcpu_get_sme_state(cpu->accel->fd, &sme_state);
+    assert_hvf_ok(ret);
+
+    /*
+     * Set SVCR first because changing it will zero out Z/P regs
+     */
+    svcr =
+        (sme_state.za_storage_enabled ? R_SVCR_ZA_MASK : 0)
+        | (sme_state.streaming_sve_mode_enabled ? R_SVCR_SM_MASK : 0);
+
+    aarch64_set_svcr(env, svcr, R_SVCR_ZA_MASK | R_SVCR_SM_MASK);
+    arm_cpu->cpreg_values[arm_cpu->cpreg_array_len - 1] = svcr;
+
+    /*
+     * We only care about Z/P registers if we're in streaming SVE mode, i.e.
+     * PSTATE.SM is set, because only then can instructions that access them be
+     * used. We don't care about the register values otherwise. This is because
+     * when the processing unit exits/enters this mode, it zeroes out those
+     * registers.
+     */
+    if (sme_state.streaming_sve_mode_enabled) {
+        for (n = 0; n < ARRAY_SIZE(hvf_sme2_zreg_match); ++n) {
+            ret = hv_vcpu_get_sme_z_reg(cpu->accel->fd,
+                                        hvf_sme2_zreg_match[n].reg,
+                                        (uint8_t *)&env->vfp.zregs[n].d[0],
+                                        z_size);
+            assert_hvf_ok(ret);
+        }
+
+        for (n = 0; n < ARRAY_SIZE(hvf_sme2_preg_match); ++n) {
+            ret = hv_vcpu_get_sme_p_reg(cpu->accel->fd,
+                                        hvf_sme2_preg_match[n].reg,
+                                        (uint8_t *)&env->vfp.pregs[n].p[0],
+                                        preg_size);
+            assert_hvf_ok(ret);
+        }
+    }
+
+    /*
+     * If PSTATE.ZA bit is set then ZA and ZT0 are valid, otherwise they are
+     * zeroed out.
+     */
+    if (sme_state.za_storage_enabled) {
+        hv_sme_zt0_uchar64_t tmp = { 0 };
+
+        /* Get ZT0 in a tmp vector, and then copy it to env.za_state.zt0 */
+        ret = hv_vcpu_get_sme_zt0_reg(cpu->accel->fd, &tmp);
+        assert_hvf_ok(ret);
+
+        memcpy(&env->za_state.zt0, &tmp, 64);
+        ret = hv_vcpu_get_sme_za_reg(cpu->accel->fd,
+                                     (uint8_t *)&env->za_state.za,
+                                     za_size);
+        assert_hvf_ok(ret);
+
+    }
+
+    return;
+}
+#endif /* HVF_SME2_AVAILABLE */
 
 int hvf_arch_get_registers(CPUState *cpu)
 {
@@ -465,6 +702,10 @@ int hvf_arch_get_registers(CPUState *cpu)
         uint64_t kvm_id = arm_cpu->cpreg_indexes[i];
         int hvf_id = KVMID_TO_HVF(kvm_id);
 
+        if (kvm_id == HVF_TO_KVMID(SVCR)) {
+            continue;
+        }
+
         if (cpu->accel->guest_debug_enabled) {
             /* Handle debug registers */
             switch (hvf_id) {
@@ -558,6 +799,13 @@ int hvf_arch_get_registers(CPUState *cpu)
 
         arm_cpu->cpreg_values[i] = val;
     }
+#if HVF_SME2_AVAILABLE
+    if (__builtin_available(macOS 15.2, *)) {
+        if (cpu_isar_feature(aa64_sme, arm_cpu)) {
+            hvf_arch_get_sme(cpu);
+        }
+    }
+#endif /* HVF_SME2_AVAILABLE */
     assert(write_list_to_cpustate(arm_cpu));
 
     aarch64_restore_sp(env, arm_current_el(env));
@@ -603,6 +851,10 @@ int hvf_arch_put_registers(CPUState *cpu)
         uint64_t kvm_id = arm_cpu->cpreg_indexes[i];
         int hvf_id = KVMID_TO_HVF(kvm_id);
 
+        if (kvm_id == HVF_TO_KVMID(SVCR)) {
+            continue;
+        }
+
         if (cpu->accel->guest_debug_enabled) {
             /* Handle debug registers */
             switch (hvf_id) {
@@ -687,6 +939,13 @@ int hvf_arch_put_registers(CPUState *cpu)
     ret = hv_vcpu_set_vtimer_offset(cpu->accel->fd, hvf_state->vtimer_offset);
     assert_hvf_ok(ret);
 
+#if HVF_SME2_AVAILABLE
+    if (__builtin_available(macOS 15.2, *)) {
+        if (cpu_isar_feature(aa64_sme, arm_cpu)) {
+            hvf_arch_put_sme(cpu);
+        }
+    }
+#endif /* HVF_SME2_AVAILABLE */
     return 0;
 }
 
@@ -909,6 +1168,18 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     hv_return_t ret;
     int i;
 
+    if (__builtin_available(macOS 15.2, *)) {
+        sregs_match_len += ARRAY_SIZE(hvf_sreg_list_sme2) + 1;
+
+#define DEF_SYSREG_15_02(HVF_ID, ...) \
+        g_assert(HVF_ID == KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
+#define DEF_SYSREG(...)
+
+#include "sysreg.c.inc"
+
+#undef DEF_SYSREG
+#undef DEF_SYSREG_15_02
+    }
     env->aarch64 = true;
     asm volatile("mrs %0, cntfrq_el0" : "=r"(arm_cpu->gt_cntfrq_hz));
 
@@ -927,7 +1198,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     memset(arm_cpu->cpreg_values, 0, sregs_match_len * sizeof(uint64_t));
 
     /* Populate cp list for all known sysregs */
-    for (i = 0; i < sregs_match_len; i++) {
+    for (i = 0; i < ARRAY_SIZE(hvf_sreg_list); i++) {
         hv_sys_reg_t hvf_id = hvf_sreg_list[i];
         uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
         uint32_t key = kvm_to_cpreg_id(kvm_id);
@@ -938,6 +1209,24 @@ int hvf_arch_init_vcpu(CPUState *cpu)
             arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
         }
     }
+    if (__builtin_available(macOS 15.2, *)) {
+        for (i = 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
+            hv_sys_reg_t hvf_id = hvf_sreg_list_sme2[i];
+            uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
+            uint32_t key = kvm_to_cpreg_id(kvm_id);
+            const ARMCPRegInfo *ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
+
+            if (ri) {
+                assert(!(ri->type & ARM_CP_NO_RAW));
+                arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
+            }
+        }
+        /*
+         * Add SVCR last. It is elsewhere assumed its index is after
+         * hvf_sreg_list and hvf_sreg_list_sme2.
+         */
+        arm_cpu->cpreg_indexes[sregs_cnt++] = HVF_TO_KVMID(SVCR);
+    }
     arm_cpu->cpreg_array_len = sregs_cnt;
     arm_cpu->cpreg_vmstate_array_len = sregs_cnt;
 
diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
index 067a8603fa785593ed0879cea26d036b0ec2823e..fb973ec19b747b445b57d7fc15e8d0a05336f941 100644
--- a/target/arm/hvf/sysreg.c.inc
+++ b/target/arm/hvf/sysreg.c.inc
@@ -145,3 +145,13 @@ DEF_SYSREG(HV_SYS_REG_TPIDRRO_EL0, 3, 3, 13, 0, 3)
 DEF_SYSREG(HV_SYS_REG_CNTV_CTL_EL0, 3, 3, 14, 3, 1)
 DEF_SYSREG(HV_SYS_REG_CNTV_CVAL_EL0, 3, 3, 14, 3, 2)
 DEF_SYSREG(HV_SYS_REG_SP_EL1, 3, 4, 4, 1, 0)
+
+#if HVF_SME2_AVAILABLE
+DEF_SYSREG_15_02(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
+DEF_SYSREG_15_02(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
+DEF_SYSREG_15_02(HV_SYS_REG_TPIDR2_EL0, 3, 3, 13, 0, 5)
+DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
+DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
+DEF_SYSREG_15_02(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
+DEF_SYSREG_15_02(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
+#endif /* HVF_SME2_AVAILABLE */
diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index ea82f2691dfcce780d9ab7d580c8a7946e3abaa7..adb282f02d0fc059b6ff0ce5270ad9f447f37927 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -13,6 +13,14 @@
 
 #include "target/arm/cpu-qom.h"
 
+#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
+  #define HVF_SME2_AVAILABLE (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200)
+  #include "system/hvf_int.h"
+#else
+  #define HVF_SME2_AVAILABLE 0
+#endif
+
+
 /**
  * hvf_arm_init_debug() - initialize guest debug capabilities
  *
@@ -25,4 +33,42 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
 uint32_t hvf_arm_get_default_ipa_bit_size(void);
 uint32_t hvf_arm_get_max_ipa_bit_size(void);
 
+#if HVF_SME2_AVAILABLE
+static inline bool hvf_arm_sme2_supported(void)
+{
+    if (__builtin_available(macOS 15.2, *)) {
+        size_t svl_bytes;
+        hv_return_t result = hv_sme_config_get_max_svl_bytes(&svl_bytes);
+        if (result == HV_UNSUPPORTED) {
+            return false;
+        }
+        assert_hvf_ok(result);
+        return svl_bytes > 0;
+    } else {
+        return false;
+    }
+}
+
+static inline uint32_t hvf_arm_sme2_get_svl(void)
+{
+    if (__builtin_available(macOS 15.2, *)) {
+        size_t svl_bytes;
+        hv_return_t result = hv_sme_config_get_max_svl_bytes(&svl_bytes);
+        assert_hvf_ok(result);
+        return svl_bytes;
+    } else {
+        abort();
+    }
+}
+#else /* HVF_SME2_AVAILABLE */
+static inline bool hvf_arm_sme2_supported(void)
+{
+    return false;
+}
+static inline uint32_t hvf_arm_sme2_get_svl(void)
+{
+    abort();
+}
+#endif /* HVF_SME2_AVAILABLE */
+
 #endif
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 0befdb0b28ad3f45b0bd83575dd9fd4fecaf3db1..7e3339081bf1f9f57bb0514d795c8a4254975c6a 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -231,7 +231,7 @@ static bool sve_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
 
-    return cpu_isar_feature(aa64_sve, cpu);
+    return cpu_isar_feature(aa64_sve, cpu) || cpu_isar_feature(aa64_sme, cpu);
 }
 
 /* The first two words of each Zreg is stored in VFP state.  */

-- 
2.47.3


