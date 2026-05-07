Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F39CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11l-0004P2-0c; Thu, 07 May 2026 11:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11j-0004HI-K2
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:39 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11h-0003xi-FH
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:39 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so10274535e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169156; x=1778773956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x2jByYOcRCS9jxQs8w1Al6UoyCvhrIi2zp66CXsq9Dw=;
 b=O0309RBqq2BAUXtTwvJ2ETGCleMa38BK8f0VmPyfbvcBcHi2jLdnfwmFjjbuIvCbrL
 dZZL3bF/VTTlIeKnlpmUYNekx2lZc0CZ6qDl8vGVRJTttLEBnKux0oy6ZbWlj2+AuPYS
 p/IMhyzPKht+dW0hr1IQtLpP+5/Ogi+VJ8SEfSwQxml9lMACyQe/es1SLyXLpY9cyAp1
 0b6L9mQcJeG082eLQXOAQOKdmQcfIpKHZMr2zfRD5OpRtaHvtBrRDqTSmMS8ovmIvNvk
 maSnkXa+74inexiZ9UybFjmuEbZJxRnW202ZWGWIIuPayfQ9vVrRfMMYByTbY5VPwjic
 TEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169156; x=1778773956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x2jByYOcRCS9jxQs8w1Al6UoyCvhrIi2zp66CXsq9Dw=;
 b=JgpAvMCns3slvOmqYvK6BPQxLi0hrgdpEk3HDU6AtrDb2aAM3NYhAPNZQ+SlSYXUh+
 Z+T+UW1V8cXFLLk6VsnPdhPb3AnO9JOUq63XZO/8ELVuZGk4tcocsky+VBHsBiST5LdL
 jRHE+t/j3NSWM+szbgx9YqQAhgl0KYs2XVTAK4xvqXZlJTsPBWl44969LCVn6U9fZsuf
 n8Hoy9WPhIqvL9dPXXeKuMtRSKWHcRy+YkbODlLhoAku+AUkRTdukPPMNRBC/bBpGQqD
 WdxGPaZy4wmw/FOQD+cWa9oHNRg6NHn4cBK2py0har6hXdwrH4+XCP80Y1k1ujHqlCLj
 h5AQ==
X-Gm-Message-State: AOJu0YwIqohffPVp1YMkDNsgGImRyWfh3HUFazByqHxE7wM90c7Y1w2A
 AiCZslV5m99PMjWt2d1CGdJoK9NXGm30X6Y6VBSroGLGlF7oTmCkzzfHCwIhWqZEp3ffBT2gW/r
 a8ckN
X-Gm-Gg: AeBDietlsZQWNAn3B1uP2T86eb6llk1OGQgxMqDN1CX8wFzyjwvvz66onzr9AhLUgEn
 Q5qxInAB/0xGDwUI9e9h4NFCxgRS73i+v2FYL2CPmbgW2aJ5DH/Q2WDDfXDRfciyz73qKQkbQwY
 FskoCouMBotacRYDHDORYIEDfgkkXro/7QZmLJ8B8NZMabkPOFniuOx2t3bYFiFlKkAgMVOjWxm
 geWUpy+Oq7dfdMp8lqNa0FYXuOZbioZKHplhBZ2OqHanjwwiVcGELn5yiEeBMQRrX5W/9BTiPNv
 /YfjZx+Ggtm1QdUaNZq+sTnFQoeG6TM4YbwYi5IogUgODl/vLXPXTZ1QZ+gWWcyhNHsW6eFcJ7R
 a0R1MoNk1glI94qDMuqEpBbg9/txmTgpZGUcKRDWk9YK/tv+QnJabEKot9Z9gmeKcTR7HOA1G0K
 A2bFh3o0kK/hlVDUEKHVL5LS9A67ynDTjqwe8n0XFIg2Rlk8h4Ld1wkSg0ECIMSDfh2duUDI3Jd
 ay6mwel1/mYGnR7qVF9p6D6wVdkZ2c=
X-Received: by 2002:a05:600c:a405:b0:489:1a3a:9e45 with SMTP id
 5b1f17b1804b1-48e51f54230mr118107145e9.26.1778169155778; 
 Thu, 07 May 2026 08:52:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/67] target/arm: GICv5 cpuif: Implement ICC_APR_EL1 and
 ICC_HAPR_EL1
Date: Thu,  7 May 2026 16:51:28 +0100
Message-ID: <20260507155154.1886557-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

The ICC_APR_EL1 GICv5 cpuif register records the physical active
priorities.  Since the GICv5 always uses 5 bits of priority, this
register always has 32 non-RES0 bits, and we don't need the
complicated GICv3 setup where there might be 1, 2 or 4 APR registers.

ICC_HAPR_EL1 is a read-only register which reports the current
running priority.  This is defined to be the lowest set bit (i.e.
the highest priority) in the APR, or the Idle priority 0xff if there
are no active interrupts, so it is effectively a convenience
re-presentation of the APR register data.

The APR register is banked per interrupt domain; ICC_APR_EL1 accesses
the version of the register corresponding to the current logical
interrupt domain.  The APR data for the final domain (EL3) is
accessed via ICC_APR_EL3.  Although we are starting with an EL1-only
implementation, we define the CPU state as banked here so we don't
have to change our representation of it later when we add EL3 and RME
support.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-42-peter.maydell@linaro.org
---
 include/hw/intc/arm_gicv5_types.h |  2 ++
 target/arm/cpu.h                  |  2 ++
 target/arm/tcg/gicv5-cpuif.c      | 60 +++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/include/hw/intc/arm_gicv5_types.h b/include/hw/intc/arm_gicv5_types.h
index f6f8709a6a..5966ebde05 100644
--- a/include/hw/intc/arm_gicv5_types.h
+++ b/include/hw/intc/arm_gicv5_types.h
@@ -84,4 +84,6 @@ typedef enum GICv5TriggerMode {
     GICV5_TRIGGER_LEVEL = 1,
 } GICv5TriggerMode;
 
+#define PRIO_IDLE 0xff
+
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cf7f8f8fac..76db5a9197 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -34,6 +34,7 @@
 #include "target/arm/gtimer.h"
 #include "target/arm/cpu-sysregs.h"
 #include "target/arm/mmuidx.h"
+#include "hw/intc/arm_gicv5_types.h"
 
 #define EXCP_UDEF            1   /* undefined instruction */
 #define EXCP_SWI             2   /* software interrupt */
@@ -602,6 +603,7 @@ typedef struct CPUArchState {
     struct {
         /* GICv5 CPU interface data */
         uint64_t icc_icsr_el1;
+        uint64_t icc_apr[NUM_GICV5_DOMAINS];
         /* Most PPI registers have 1 bit per PPI, so 64 PPIs to a register */
         uint64_t ppi_active[GICV5_NUM_PPIS / 64];
         uint64_t ppi_hm[GICV5_NUM_PPIS / 64];
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 74132ca097..33e4762ef4 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -95,6 +95,16 @@ static GICv5Domain gicv5_current_phys_domain(CPUARMState *env)
     return gicv5_logical_domain(env);
 }
 
+static uint64_t gic_running_prio(CPUARMState *env, GICv5Domain domain)
+{
+    /*
+     * Return the current running priority; this is the lowest set bit in
+     * the Active Priority Register, or the idle priority if none (D_XMBQZ)
+     */
+    uint64_t hap = ctz64(env->gicv5_cpuif.icc_apr[domain]);
+    return hap < 32 ? hap : PRIO_IDLE;
+}
+
 static void gic_cddis_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
@@ -231,6 +241,44 @@ static void gic_ppi_priority_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
+/*
+ * ICC_APR_EL1 is banked and reads/writes as the version for the
+ * current logical interrupt domain.
+ */
+static void gic_icc_apr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    /*
+     * With an architectural 5 bits of priority, this register has 32
+     * non-RES0 bits
+     */
+    GICv5Domain domain = gicv5_logical_domain(env);
+    value &= 0xffffffff;
+    env->gicv5_cpuif.icc_apr[domain] = value;
+}
+
+static uint64_t gic_icc_apr_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv5Domain domain = gicv5_logical_domain(env);
+    return env->gicv5_cpuif.icc_apr[domain];
+}
+
+static void gic_icc_apr_el1_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    for (int i = 0; i < ARRAY_SIZE(env->gicv5_cpuif.icc_apr); i++) {
+        env->gicv5_cpuif.icc_apr[i] = 0;
+    }
+}
+
+static uint64_t gic_icc_hapr_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /*
+     * ICC_HAPR_EL1 reports the current running priority, which can be
+     * calculated from the APR register.
+     */
+    return gic_running_prio(env, gicv5_current_phys_domain(env));
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -382,6 +430,18 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[1]),
         .writefn = gic_ppi_spend_write,
     },
+    {   .name = "ICC_APR_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 1, .crn = 12, .crm = 0, .opc2 = 0,
+        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .readfn = gic_icc_apr_el1_read,
+        .writefn = gic_icc_apr_el1_write,
+        .resetfn = gic_icc_apr_el1_reset,
+    },
+    {   .name = "ICC_HAPR_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 1, .crn = 12, .crm = 0, .opc2 = 3,
+        .access = PL1_R, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .readfn = gic_icc_hapr_el1_read, .raw_writefn = arm_cp_write_ignore,
+    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


