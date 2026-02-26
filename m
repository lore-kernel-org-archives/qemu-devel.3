Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67CAFD8FC3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdih-0005X7-O2; Thu, 26 Feb 2026 10:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiV-0005Ok-5b
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:55 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiT-0003mM-DU
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:54 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4398dd671daso1117776f8f.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772121351; x=1772726151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Rmltxj0hvxlVzepTANi2L0kwJYbr2zP+eSEap718xM8=;
 b=wclB73vU98VRmFID+k+ZNn2tGAl9+mUkuvBdn4K4skS4BiS/jKsX3v4riht+eFl9cQ
 djoHB3vQ2BBIxU8rvtu/Eo4gHKXMESoJjfjTJCzsGve7t+65zxGBSP+DCSEgq9AqWMwS
 /SOTa6W0LCB0zUl/x5W+UcgCmhqx2b4IJ/EF9t1iJtHA/wQjl6+0lG4Qr2pXpXMnTylX
 VOoP06r4x482BMc+ABZ+8wQniBg3JvXCxVd3WGlX6eNf5d+i2LOtIWh3C4oi548zNFHe
 Pd3l9WWJjSrrVCfALjoRk0bqgkgrv0LkSpqxpy1YThGV1E7y1epOdGn3g6EHjylq/0H2
 QIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121351; x=1772726151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Rmltxj0hvxlVzepTANi2L0kwJYbr2zP+eSEap718xM8=;
 b=L4TVqQh76lhU9T0P3z4nlGYOqoIjg8TOSavQ/QJHPBWb9fR9Z832WCqsR+miMB/S7o
 absKsDdDELl+cAa7z3ebeIxqNs1HjCzA5Z2+iuMPS0JDnas+69mulPS8cqvWGDkq8gx7
 YKFz32TOvJZKBan1XSCkX22moUNB1JAlqHPu64yJ3lqeuzqngjwmyTIp1Tvxflg4saWQ
 xDaTuMpDdLezavuA+mYJDLDNO9Qe36SHB6iV6zOMl1prZAuY6x/gqgi6JwVM6jVQXJ1W
 bjFiqStHHejIcxqu7suzLgp9S7lSLu91gVBSqXzmOc5nSN6AHX/tVWe/oNZ1eb/Mmmk7
 Givw==
X-Gm-Message-State: AOJu0YxJuoiYBb5AWxmq2KU9mj8sKa4W/QysNxnRYvWk56YjAB3nwmSI
 S4DGR1p/30OLb2jk7in3TH5QiwAlDq50wsrdTZLnBFeBdlqO3LVuCbEYYyCDqqUlSM4eZgMZbKO
 6mPUU
X-Gm-Gg: ATEYQzzLpLLAM5ciZOdiMZ4ZqeqDbV3An8cRgx1QrsIeyO9cdOxXLkhlm6ZZXe668uh
 PMm0AgksZyiAlgvYm5MEqCVDxc2XT2F8NM0Q/i46uuMSEEZY5OXkzcAt9H9F0y4mFFGLIKD7G/l
 eZiWG+Ip5WtQy+UV4vHi4/h9Vgr8H1H3sZYbS3+hzy7nY/vAqaSo7mL7yZyQtzTAQ1zxiXPLcPE
 KYB4tfx9PkLZiudr0SCnOy2OTe866hSAKMyN3J+LC18FtLDHeb7P/uNkTvrs6H/KLdzBER+4OsO
 hqoFGdqVT1+B7UOzyjRsc619aLyXTSrZNwIpPCVB+XzZcQh8+Nnp/8u8THbh6S8sJNMQHkWVug3
 UAvhtiEO1Y2x6TolWk/tq8UJ9WVQFiK9H3+DokZQvbZZ2NDiCmVIdlrf9LZw5KQ3MJ6sGSvfrHT
 gOf7YH7DqxnH9vmCW+Poq0R+RbjAMkGRNjrF9uA9VBWyTVUCtf4WEUd1NkOhcO1gGLwbl6Ax+pT
 0nWL0C9NKSbcdsi25DDV8Km8L8zQv4=
X-Received: by 2002:a05:6000:2dc6:b0:439:8f6f:1b2a with SMTP id
 ffacd0b85a97d-43997ed6d0dmr5410071f8f.4.1772121351467; 
 Thu, 26 Feb 2026 07:55:51 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm407235f8f.23.2026.02.26.07.55.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:55:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/20] target/arm: Drop kvm_arm_sve_supported
Date: Thu, 26 Feb 2026 15:55:29 +0000
Message-ID: <20260226155535.1171290-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226155535.1171290-1-peter.maydell@linaro.org>
References: <20260226155535.1171290-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This function has only one real use, so inline it and
drop the stubs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260216034432.23912-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm-stub.c |  5 -----
 target/arm/kvm.c      |  9 +--------
 target/arm/kvm_arm.h  | 12 ------------
 3 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index f2de36aef3..f1d0ca09e6 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -37,11 +37,6 @@ bool kvm_arm_pmu_supported(void)
     return false;
 }
 
-bool kvm_arm_sve_supported(void)
-{
-    return false;
-}
-
 bool kvm_arm_mte_supported(void)
 {
     return false;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b00172a289..495ac0709a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -246,7 +246,6 @@ static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf,
 
 static uint32_t kvm_arm_sve_get_vls(int fd)
 {
-    /* Only call this function if kvm_arm_sve_supported() returns true. */
     uint64_t vls[KVM_ARM64_SVE_VLS_WORDS];
     struct kvm_one_reg reg = {
         .id = KVM_REG_ARM64_SVE_VLS,
@@ -298,7 +297,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      * Ask for SVE if supported, so that we can query ID_AA64ZFR0,
      * which is otherwise RAZ.
      */
-    sve_supported = kvm_arm_sve_supported();
+    sve_supported = kvm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
     if (sve_supported) {
         init.features[0] |= 1 << KVM_ARM_VCPU_SVE;
     }
@@ -1937,11 +1936,6 @@ bool kvm_arm_el2_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL2);
 }
 
-bool kvm_arm_sve_supported(void)
-{
-    return kvm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
-}
-
 bool kvm_arm_mte_supported(void)
 {
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
@@ -2000,7 +1994,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
     }
     if (cpu_isar_feature(aa64_sve, cpu)) {
-        assert(kvm_arm_sve_supported());
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SVE;
     }
     if (cpu_isar_feature(aa64_pauth, cpu)) {
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 97549766ea..cee06b5f0b 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -176,13 +176,6 @@ bool kvm_arm_aarch32_supported(void);
  */
 bool kvm_arm_pmu_supported(void);
 
-/**
- * kvm_arm_sve_supported:
- *
- * Returns true if KVM can enable SVE and false otherwise.
- */
-bool kvm_arm_sve_supported(void);
-
 /**
  * kvm_arm_mte_supported:
  *
@@ -208,11 +201,6 @@ static inline bool kvm_arm_pmu_supported(void)
     return false;
 }
 
-static inline bool kvm_arm_sve_supported(void)
-{
-    return false;
-}
-
 static inline bool kvm_arm_mte_supported(void)
 {
     return false;
-- 
2.43.0


