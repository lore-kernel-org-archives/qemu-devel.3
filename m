Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1DCE67A8D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 07:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxKPF-0005F6-Mh; Tue, 03 Mar 2026 02:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vxKP2-0005Bh-Vt
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 02:42:49 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vxKOy-0004PI-3o
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 02:42:47 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48371bb515eso80762225e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 23:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772523762; x=1773128562; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OGDMPnEtUcBeZDW+QIcygSY+TqYwDQGWWbrfsmB/kKI=;
 b=UNt5q2rOtrMbrSvk2XHLh2sWBfjDfIjWyA8Vd59iB15/J4DB5NRkj4d8KVu8IDNoIO
 IxjfbIBJLeq6cfghJ3TEiIvyWz4P9f1JIf0/G6ir5Gq2B3/ojstL4G16TyUAJNIZiMu/
 mxxi2S/gE2F52PqoJGUZbTi393+iyxYwMhG8Au/gqqLw5ygkJry7t2cFyJSqy3NrxnLX
 ujer0C/mMYUo1MzbhdcE4+fHCZa1EibmzpWJbrbK1+jWhUXszcct77Vqm2FoUI+5dcia
 l8ZMGVG7V/+mNTR7kZwjndAptj9d9i/NiXJHq9tnzLMGmQeu+z97+g1TJCvSSo5tWrmj
 khWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772523762; x=1773128562;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OGDMPnEtUcBeZDW+QIcygSY+TqYwDQGWWbrfsmB/kKI=;
 b=OI/yvvHKWQ1Rm94N5EKO13Q28WOE+DMfDGmHuTcE2bnTy0pzudgcb6GDdVNVGhOU8u
 7yowhhcNc6q1SZuvKJjT6gAEqfc9ch4wdnz/kQ9H+td/9HBLN13EbWzgnl6h6NhJkx54
 zWM2bMygi/tDmj9JvheZKEavxAu6KJCQ8ranMsggqDb6Ff6WVmT3bEFUK3Pnprh5YO8u
 fw9egRSi5/xajbiXRSjlVPROnYBDOnW3K7Fy0P3QKDRvzuKG/0xNkKwqYXv+b1Sc9UpJ
 fB2EqhWIDXuaRUGDbnWWw8a+J/LOphNj1rEswjMEzXtZe1GBUr9+6AxQrZ/b5AzqJoDm
 QYag==
X-Gm-Message-State: AOJu0YwRhzvRexCaex0i7Pl6jfiq7jBT6x+1AygbRiiNhRSU2AaYgvg3
 9txOZlKmyr1WpSClBEzE2+Q6eiOYgnMA1P6fPl3SGmBrGWWUji9luPjA4Q37pkthmAM=
X-Gm-Gg: ATEYQzyISbeX/Y/FmvfKQ1NwPpG5RIpgP4YgxgZLXeQGY4GJPVzC+Obc5IpGu6jGV/E
 fv9y/IFu6fpabi9Ask4jP8CKjCy+zfhmzXHxctsvxpTyJ+6VQCwAmSkt4wWDWfB18umwJku8O+t
 o//aScIgW2JgS5rHuGSXffOxOPcyqtcxeP8vqhbXgOlwqrmHgxIIxMYLcy88BIcLMjiI93veaZV
 1LE2sAKM2Xu4Rq3R6G9BjGEy0YlVrBNPZYvIIPWo5vXHNjdPx6+fu8mn43pYFMATIYP0gg/b2c2
 z/4K+o3kZN7HpabyMM/s0vWPGLRVZh3fWhmOsAfFO3f9yfCVeGl/3lyRAZxsAeLvXmq3XYreXue
 +nljKapkSKfimQhxaeHz4dZ7buSa0kugdkgEcn4v1xUdln3+oqsRsuVxkFK1s4H5GHQSBnu4xzL
 DJh534EsyysJwr4KemzrJbXhFH4Jn9HPWxrwc9vSvbvzUglcqzvx7lBqfpCra0O4nz3mvqTQqV9
 6PWn5ZjdDdUkJEm4oTcWBingS6Hxob6whkf0griYV8GMrnyDA==
X-Received: by 2002:a05:600c:81c9:b0:483:badb:6191 with SMTP id
 5b1f17b1804b1-483c9bc19f8mr222588775e9.8.1772523762274; 
 Mon, 02 Mar 2026 23:42:42 -0800 (PST)
Received: from [127.0.1.1] (ppp-2-86-215-248.home.otenet.gr. [2.86.215.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f26d7sm475943045e9.3.2026.03.02.23.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 23:42:41 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 03 Mar 2026 09:42:30 +0200
Subject: [PATCH v6 1/2] hvf/arm: handle FEAT_SME2 migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-sme2-hvf-v6-1-b473702d8287@linaro.org>
References: <20260303-sme2-hvf-v6-0-b473702d8287@linaro.org>
In-Reply-To: <20260303-sme2-hvf-v6-0-b473702d8287@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 =?utf-8?q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=23343;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=V7uflc0vil9/pJsxLunFwh0B38DLYq9u2yo0IwW6PrE=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnBwcER2VGNKOUdtZU5XS2J1RXN2SC9wYXgyZHBXCkVQVFNzelpvMzZCNHJBNFhD
 cWVKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWFhUTd3QUt
 DUkIzS2Nkd2YzNEowSHFVRC80ck5PcXF6a0kwMjA0NnJ5QzU5Z0RiWTh5Z0h1aTY1VEhhRkhvaw
 p6NjRUSnRRY3FDOXBrSjJZeExKL3JTQ1I5c3NpcXhmYWJOMnZUWkhhVzR3RW00dE1LQ3h6R3FSS
 01iZVg1a0xMCnk0Nm84OW9selQyUkJkVXFiWnhkL2JibmJreVpzb3lIR3NUcWlkWFBhZStxZk55
 eXVoZGpaeXNmNG9abVI2L0EKM0d5UTFsU0JkenB2NCtaMGZuc0xIamg2RkVSVmN4cE9nY2NvaXE
 xQnZFRitoWFZzNnJCaHRXYkhXVjJOQno0UApFc0JBNllZV1ZrL1hyeHdsWlZUd3ZReVR5YzZQQz
 kyU3lOV3Y3VmFDb0dsSHBtZTVLUlBrKy9tMEVaNDJwNU9GCkNFNmUrcVArcVVpQTdSYWhsL3JNd
 EdITTk5VjJHTG1wK2pmYUdteENQWG12K1p3aUgzdXNSYUZJSjV3emlENlAKTktYVTdYeWswL2Uz
 NWwzejRMN3ZINFNkbTF6WnlEUmF2VUVYNEdTWWhqRmdBOGF0blBZd3Myblc4a2dJYjBUQgpPR1B
 sNmlVdmVPaE1TZEIwc1MxWnJlQW13aHQ2NmhDZTQ4ME1XTUhCc2tpcC83WTU2YXlmcHVVck1HdF
 RXV1BYCmFyZjF5REhWOWxPME5pSDZlQzhhV1dSY3p4Z1pWeW1DbXozM1dnRGF3bzRYM1AreWpYe
 XVmTGpjeGpZZ0M4T28KWUpEc0Y0S1kyeHBmWVQ0NWQxRGlmcDV4TjRyTmlhZlloUUlrKzJSa0lI
 MHJYUzkvNnJjRGpnSEVGbFpObkhzSApCd0pON0xQMkgyczZFV3pSL2lyVWQ0UVJaRVF0V0tINmJ
 hS1VubUcySzdBZmZ5MXVjYWE2Ty85aHNPVE1Lck5JCno5c3lYZz09Cj14MHRQCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
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
 target/arm/hvf/hvf.c           | 294 ++++++++++++++++++++++++++++++++++++++++-
 target/arm/hvf/hvf_sme_stubs.h | 158 ++++++++++++++++++++++
 target/arm/hvf/sysreg.c.inc    |   8 ++
 target/arm/hvf_arm.h           |  41 ++++++
 target/arm/machine.c           |   2 +-
 5 files changed, 500 insertions(+), 3 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d79469ca27f794139b8073e25fc16d470b1942d5..3d194680cc87e78835098df2e0e7987ed544c553 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -395,6 +395,60 @@ static const struct hvf_reg_match hvf_fpreg_match[] = {
     { HV_SIMD_FP_REG_Q31, offsetof(CPUARMState, vfp.zregs[31]) },
 };
 
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
+
 /*
  * QEMU uses KVM system register ids in the migration format.
  * Conveniently, HVF uses the same encoding of the op* and cr* parameters
@@ -406,22 +460,201 @@ static const struct hvf_reg_match hvf_fpreg_match[] = {
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
 
 static uint32_t hvf_reg2cp_reg(uint32_t reg)
 {
@@ -534,6 +767,10 @@ int hvf_arch_get_registers(CPUState *cpu)
         uint64_t kvm_id = arm_cpu->cpreg_indexes[i];
         int hvf_id = KVMID_TO_HVF(kvm_id);
 
+        if (kvm_id == HVF_TO_KVMID(SVCR)) {
+            continue;
+        }
+
         if (cpu->accel->guest_debug_enabled) {
             /* Handle debug registers */
             switch (hvf_id) {
@@ -627,6 +864,13 @@ int hvf_arch_get_registers(CPUState *cpu)
 
         arm_cpu->cpreg_values[i] = val;
     }
+    if (cpu_isar_feature(aa64_sme, arm_cpu)) {
+        if (__builtin_available(macOS 15.2, *)) {
+            hvf_arch_get_sme(cpu);
+        } else {
+            g_assert_not_reached();
+        }
+    }
     assert(write_list_to_cpustate(arm_cpu));
 
     aarch64_restore_sp(env, arm_current_el(env));
@@ -643,6 +887,18 @@ int hvf_arch_put_registers(CPUState *cpu)
     hv_simd_fp_uchar16_t fpval;
     int i, n;
 
+    /*
+     * Set SVCR first because changing it will zero out Z/P (including NEON)
+     * regs
+     */
+    if (cpu_isar_feature(aa64_sme, arm_cpu)) {
+        if (__builtin_available(macOS 15.2, *)) {
+            hvf_arch_put_sme(cpu);
+        } else {
+            g_assert_not_reached();
+        }
+    }
+
     for (i = 0; i < ARRAY_SIZE(hvf_reg_match); i++) {
         val = *(uint64_t *)((void *)env + hvf_reg_match[i].offset);
         ret = hv_vcpu_set_reg(cpu->accel->fd, hvf_reg_match[i].reg, val);
@@ -672,6 +928,10 @@ int hvf_arch_put_registers(CPUState *cpu)
         uint64_t kvm_id = arm_cpu->cpreg_indexes[i];
         int hvf_id = KVMID_TO_HVF(kvm_id);
 
+        if (kvm_id == HVF_TO_KVMID(SVCR)) {
+            continue;
+        }
+
         if (cpu->accel->guest_debug_enabled) {
             /* Handle debug registers */
             switch (hvf_id) {
@@ -985,6 +1245,18 @@ int hvf_arch_init_vcpu(CPUState *cpu)
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
 
     /* system count frequency sanity check */
@@ -1005,7 +1277,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     memset(arm_cpu->cpreg_values, 0, sregs_match_len * sizeof(uint64_t));
 
     /* Populate cp list for all known sysregs */
-    for (i = 0; i < sregs_match_len; i++) {
+    for (i = 0; i < ARRAY_SIZE(hvf_sreg_list); i++) {
         hv_sys_reg_t hvf_id = hvf_sreg_list[i];
         uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
         uint32_t key = kvm_to_cpreg_id(kvm_id);
@@ -1016,6 +1288,24 @@ int hvf_arch_init_vcpu(CPUState *cpu)
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
 
diff --git a/target/arm/hvf/hvf_sme_stubs.h b/target/arm/hvf/hvf_sme_stubs.h
new file mode 100644
index 0000000000000000000000000000000000000000..9c679b711017448681e532b88ce10a07ebfd5122
--- /dev/null
+++ b/target/arm/hvf/hvf_sme_stubs.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+typedef int32_t hv_return_t;
+typedef uint64_t hv_vcpu_t;
+
+static inline bool hvf_arm_sme2_supported(void)
+{
+    return false;
+}
+
+static inline uint32_t hvf_arm_sme2_get_svl(void)
+{
+    g_assert_not_reached();
+}
+
+typedef enum hv_sme_p_reg_t {
+    HV_SME_P_REG_0,
+    HV_SME_P_REG_1,
+    HV_SME_P_REG_2,
+    HV_SME_P_REG_3,
+    HV_SME_P_REG_4,
+    HV_SME_P_REG_5,
+    HV_SME_P_REG_6,
+    HV_SME_P_REG_7,
+    HV_SME_P_REG_8,
+    HV_SME_P_REG_9,
+    HV_SME_P_REG_10,
+    HV_SME_P_REG_11,
+    HV_SME_P_REG_12,
+    HV_SME_P_REG_13,
+    HV_SME_P_REG_14,
+    HV_SME_P_REG_15,
+} hv_sme_p_reg_t;
+
+typedef __attribute__((ext_vector_type(64))) uint8_t hv_sme_zt0_uchar64_t;
+
+typedef enum hv_sme_z_reg_t {
+    HV_SME_Z_REG_0,
+    HV_SME_Z_REG_1,
+    HV_SME_Z_REG_2,
+    HV_SME_Z_REG_3,
+    HV_SME_Z_REG_4,
+    HV_SME_Z_REG_5,
+    HV_SME_Z_REG_6,
+    HV_SME_Z_REG_7,
+    HV_SME_Z_REG_8,
+    HV_SME_Z_REG_9,
+    HV_SME_Z_REG_10,
+    HV_SME_Z_REG_11,
+    HV_SME_Z_REG_12,
+    HV_SME_Z_REG_13,
+    HV_SME_Z_REG_14,
+    HV_SME_Z_REG_15,
+    HV_SME_Z_REG_16,
+    HV_SME_Z_REG_17,
+    HV_SME_Z_REG_18,
+    HV_SME_Z_REG_19,
+    HV_SME_Z_REG_20,
+    HV_SME_Z_REG_21,
+    HV_SME_Z_REG_22,
+    HV_SME_Z_REG_23,
+    HV_SME_Z_REG_24,
+    HV_SME_Z_REG_25,
+    HV_SME_Z_REG_26,
+    HV_SME_Z_REG_27,
+    HV_SME_Z_REG_28,
+    HV_SME_Z_REG_29,
+    HV_SME_Z_REG_30,
+    HV_SME_Z_REG_31,
+} hv_sme_z_reg_t;
+
+enum {
+  HV_SYS_REG_SMCR_EL1,
+  HV_SYS_REG_SMPRI_EL1,
+  HV_SYS_REG_TPIDR2_EL0,
+  HV_SYS_REG_ID_AA64ZFR0_EL1,
+  HV_SYS_REG_ID_AA64SMFR0_EL1,
+};
+
+typedef struct {
+    bool streaming_sve_mode_enabled;
+    bool za_storage_enabled;
+} hv_vcpu_sme_state_t;
+
+static inline hv_return_t hv_sme_config_get_max_svl_bytes(size_t *value)
+{
+    g_assert_not_reached();
+}
+
+static inline hv_return_t hv_vcpu_get_sme_state(hv_vcpu_t vcpu,
+                                                hv_vcpu_sme_state_t *sme_state)
+{
+    g_assert_not_reached();
+}
+
+static inline hv_return_t hv_vcpu_set_sme_state(hv_vcpu_t vcpu,
+                                                const hv_vcpu_sme_state_t *sme_state)
+{
+    g_assert_not_reached();
+}
+
+static inline hv_return_t hv_vcpu_get_sme_z_reg(hv_vcpu_t vcpu,
+                                                hv_sme_z_reg_t reg,
+                                                uint8_t *value,
+                                                size_t length)
+{
+    g_assert_not_reached();
+}
+
+static inline hv_return_t hv_vcpu_set_sme_z_reg(hv_vcpu_t vcpu,
+                                                hv_sme_z_reg_t reg,
+                                                const uint8_t *value,
+                                                size_t length)
+{
+    g_assert_not_reached();
+}
+
+static inline hv_return_t hv_vcpu_get_sme_p_reg(hv_vcpu_t vcpu,
+                                                hv_sme_p_reg_t reg,
+                                                uint8_t *value,
+                                                size_t length)
+{
+    g_assert_not_reached();
+}
+
+static inline hv_return_t hv_vcpu_set_sme_p_reg(hv_vcpu_t vcpu,
+                                                hv_sme_p_reg_t reg,
+                                                const uint8_t *value,
+                                                size_t length)
+{
+    g_assert_not_reached();
+}
+
+static inline hv_return_t hv_vcpu_get_sme_za_reg(hv_vcpu_t vcpu,
+                                                 uint8_t *value,
+                                                 size_t length)
+{
+    g_assert_not_reached();
+}
+
+static inline hv_return_t hv_vcpu_set_sme_za_reg(hv_vcpu_t vcpu,
+                                                 const uint8_t *value,
+                                                 size_t length)
+{
+    g_assert_not_reached();
+}
+
+static inline hv_return_t hv_vcpu_get_sme_zt0_reg(hv_vcpu_t vcpu,
+                                                  hv_sme_zt0_uchar64_t *value)
+{
+    g_assert_not_reached();
+}
+
+static inline hv_return_t hv_vcpu_set_sme_zt0_reg(hv_vcpu_t vcpu,
+                                                  const hv_sme_zt0_uchar64_t *value)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
index 067a8603fa785593ed0879cea26d036b0ec2823e..7a2f880f784b7610b14a6eb91fec1817e98bfd2e 100644
--- a/target/arm/hvf/sysreg.c.inc
+++ b/target/arm/hvf/sysreg.c.inc
@@ -145,3 +145,11 @@ DEF_SYSREG(HV_SYS_REG_TPIDRRO_EL0, 3, 3, 13, 0, 3)
 DEF_SYSREG(HV_SYS_REG_CNTV_CTL_EL0, 3, 3, 14, 3, 1)
 DEF_SYSREG(HV_SYS_REG_CNTV_CVAL_EL0, 3, 3, 14, 3, 2)
 DEF_SYSREG(HV_SYS_REG_SP_EL1, 3, 4, 4, 1, 0)
+
+DEF_SYSREG_15_02(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
+DEF_SYSREG_15_02(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
+DEF_SYSREG_15_02(HV_SYS_REG_TPIDR2_EL0, 3, 3, 13, 0, 5)
+DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
+DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
+DEF_SYSREG_15_02(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
+DEF_SYSREG_15_02(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index 5d19d82e5ded66bc02da10523c0f7138840ecff3..6b1c3b9792dfd7d81ef747d8a6676a23fd212d84 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -22,4 +22,45 @@ void hvf_arm_init_debug(void);
 
 void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
 
+/*
+ * We need access to types from macOS SDK >=15.2, so expose stubs if the
+ * headers are not available until we raise our minimum macOS version.
+ */
+#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
+  #if (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200)
+    #include "system/hvf_int.h"
+
+    static inline bool hvf_arm_sme2_supported(void)
+    {
+        if (__builtin_available(macOS 15.2, *)) {
+            size_t svl_bytes;
+            hv_return_t result = hv_sme_config_get_max_svl_bytes(&svl_bytes);
+            if (result == HV_UNSUPPORTED) {
+                return false;
+            }
+            assert_hvf_ok(result);
+            return svl_bytes > 0;
+        } else {
+            return false;
+        }
+    }
+
+    static inline uint32_t hvf_arm_sme2_get_svl(void)
+    {
+        if (__builtin_available(macOS 15.2, *)) {
+            size_t svl_bytes;
+            hv_return_t result = hv_sme_config_get_max_svl_bytes(&svl_bytes);
+            assert_hvf_ok(result);
+            return svl_bytes;
+        } else {
+            abort();
+        }
+    }
+  #else /* (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200) */
+      #include "hvf/hvf_sme_stubs.h"
+  #endif /* (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200) */
+#else /* ifdef __MAC_OS_X_VERSION_MAX_ALLOWED */
+  #include "hvf/hvf_sme_stubs.h"
+#endif /* ifdef __MAC_OS_X_VERSION_MAX_ALLOWED */
+
 #endif
diff --git a/target/arm/machine.c b/target/arm/machine.c
index bbaae3444928985813b7dcc91888784d06cfe305..81a506ce4cc09493dd7faed88652d8d246e23187 100644
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


