Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034CBE63F25
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 03:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrpXR-0002VQ-Ei; Sun, 15 Feb 2026 22:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXQ-0002V0-4H
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:44:44 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXO-0002OH-70
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:44:43 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2aaed195901so12760045ad.0
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 19:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771213481; x=1771818281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9NzjEqJY7+NdUrSQzEJSoR9zNgCwGWGpP9vTRT1K2JY=;
 b=yMsAxXn/osoE1eC/DTYhJAKtqz7CkPtYJQit86SyqS9xpxi07S7lqd097nK9dHK3L7
 sneZV3sTIXGAPB9u4hpZ4aEC1rtsgkrm/3tV16WchgTxrISMUsakKL5V7ZTJlo9m0+Mz
 hiQcCsPf09WHmtt17M2GzH02LZF7w+9FsVa8oVN+U5UYSna7iAW8a58fr+P45qATCOVu
 M6RwMGEDl8dJVLhGbarg1NIMmtDFpzQ8yE1j+b02PF/dW1UyoBNW/7yfjIqPWm22dwlF
 Xlyi8qx/IzulijsSNjjORWx73f4Xl/M06YjCIDO2e93q1QyeFXSfKNVSufl1HI3+LelO
 x6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771213481; x=1771818281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9NzjEqJY7+NdUrSQzEJSoR9zNgCwGWGpP9vTRT1K2JY=;
 b=EVFZpuSCgd6vUmTcqgMOpvAPQVHdg2OLpDcO2N+TC+PfOGWoFp/UTkIdeHKAsPW4Hr
 WFpEYgF7eCnVW/qfRb/ThFP9ysOI2V5Nr+0UalszMz6MCw/BUAupFoqQ6iygp3EVGkqM
 Bn8OfiS4GEwub2hZcZtww1shU0+S4EnE4Fdi6ps6b1tj1XbMMU9TnykcKfOQzkKeCuH2
 ER25Uaip5VTdkP6CXXExqdufCJA/8oAxE5dh6W9aj7Np+Xz7AOE1DZTQ2WdQCZcgwxgq
 rRK9qAMbqddE4UafLYtub9vcmFhyRksy8IelFYeTZbyKZyn+jQLCcgh0tlexoVXBVNl1
 fZdQ==
X-Gm-Message-State: AOJu0Yx7vOLnt7fgtU2bhkaQfdtzs0izQpS0GrWZkg8sLIuPgjfZp5gc
 ARaPf+PpcL2/LmxR5gaNCodTwKSmv3Xj7INaSYf0Z7W6idmVUQh8oRAT58cLFQ9qmVod5HeD/04
 mE12ws1E=
X-Gm-Gg: AZuq6aJwIyFILFYF12tWuEOuybmdR5ypZq5TeseED6UHNS50ingWC3C+3fnekkMzcOG
 w+Ru0CLZty8ncD39ZRaXaS053lBdg5UHKGDquekleo14iujcAbnNLUOhWdrdomIqulZTV745gX7
 yv/pSRgrb4v9jBWAfGGIgJ3jP6k5gv4fAogXgouwVGMol/WaOYJB678OYnUsX7t56ifjDvNTd8H
 3QXPnDI3wy+uppoMwuurnIZDEkKDA2YBZ0EHp7468YdNH6Sm0XGt2ILtrcTwuSSIQgrGJhzi3hw
 YzcwZ89lDMfwrFU6UpbnwvI3E1xwwOi7NeyoDjqrXwkhUSjYd30u6T3cxBkyOtMoZgKKiUj571v
 26xSiWt51IANTR5lqSS3GAab5IIPt7FTbuhINgSBzMIlZeufEGSav2o8Om/1VXb2LVFPQxMfb5T
 +NEhr0ITEpx/i7HgHOUXuN9naDNXTROes1
X-Received: by 2002:a17:902:f612:b0:295:8a2a:9595 with SMTP id
 d9443c01a7336-2ab505d7b3cmr100704075ad.39.1771213480475; 
 Sun, 15 Feb 2026 19:44:40 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:4a1:428a:70f2:5844])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadca84sm53294155ad.70.2026.02.15.19.44.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 19:44:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 01/13] NOTFORMERGE: Update linux-headers for arm64 kvm
 from SME devel branch
Date: Mon, 16 Feb 2026 13:44:20 +1000
Message-ID: <20260216034432.23912-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216034432.23912-1-richard.henderson@linaro.org>
References: <20260216034432.23912-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

To be replaced by a proper update once the API is merged upstream.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-headers/asm-arm64/kvm.h | 33 +++++++++++++++++++++++++++++++++
 linux-headers/linux/kvm.h     |  1 +
 2 files changed, 34 insertions(+)

diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 46ffbddab5..bbfc4781ca 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -106,6 +106,13 @@ struct kvm_regs {
 #define KVM_ARM_VCPU_PTRAUTH_GENERIC	6 /* VCPU uses generic authentication */
 #define KVM_ARM_VCPU_HAS_EL2		7 /* Support nested virtualization */
 #define KVM_ARM_VCPU_HAS_EL2_E2H0	8 /* Limit NV support to E2H RES0 */
+#define KVM_ARM_VCPU_SME		9 /* enable SME for this CPU */
+
+/*
+ * An alias for _SVE since we finalize VL configuration for both SVE and SME
+ * simultaneously.
+ */
+#define KVM_ARM_VCPU_VEC		KVM_ARM_VCPU_SVE
 
 struct kvm_vcpu_init {
 	__u32 target;
@@ -348,6 +355,32 @@ struct kvm_arm_counter_offset {
 #define KVM_ARM64_SVE_VLS_WORDS	\
 	((KVM_ARM64_SVE_VQ_MAX - KVM_ARM64_SVE_VQ_MIN) / 64 + 1)
 
+/* SME registers */
+#define KVM_REG_ARM64_SME		(0x17 << KVM_REG_ARM_COPROC_SHIFT)
+
+#define KVM_ARM64_SME_VQ_MIN __SVE_VQ_MIN
+#define KVM_ARM64_SME_VQ_MAX __SVE_VQ_MAX
+
+/* ZA and ZTn occupy blocks at the following offsets within this range: */
+#define KVM_REG_ARM64_SME_ZA_BASE	0
+#define KVM_REG_ARM64_SME_ZT_BASE	0x600
+
+#define KVM_ARM64_SME_MAX_ZAHREG	(__SVE_VQ_BYTES * KVM_ARM64_SME_VQ_MAX)
+
+#define KVM_REG_ARM64_SME_ZAHREG(n, i)					\
+	(KVM_REG_ARM64 | KVM_REG_ARM64_SME | KVM_REG_ARM64_SME_ZA_BASE | \
+	 KVM_REG_SIZE_U2048 |						\
+	 (((n) & (KVM_ARM64_SME_MAX_ZAHREG - 1)) << 5) |		\
+	 ((i) & (KVM_ARM64_SVE_MAX_SLICES - 1)))
+
+#define KVM_REG_ARM64_SME_ZTREG_SIZE	(512 / 8)
+
+/* Vector lengths pseudo-register: */
+#define KVM_REG_ARM64_SME_VLS		(KVM_REG_ARM64 | KVM_REG_ARM64_SME | \
+					 KVM_REG_SIZE_U512 | 0xfffe)
+#define KVM_ARM64_SME_VLS_WORDS	\
+	((KVM_ARM64_SVE_VQ_MAX - KVM_ARM64_SVE_VQ_MIN) / 64 + 1)
+
 /* Bitmap feature firmware registers */
 #define KVM_REG_ARM_FW_FEAT_BMAP		(0x0016 << KVM_REG_ARM_COPROC_SHIFT)
 #define KVM_REG_ARM_FW_FEAT_BMAP_REG(r)		(KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index a4ab42dcba..d8fd57d681 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -966,6 +966,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_GUEST_MEMFD_FLAGS 244
 #define KVM_CAP_ARM_SEA_TO_USER 245
 #define KVM_CAP_S390_USER_OPEREXEC 246
+#define KVM_CAP_ARM_SME 247
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.43.0


