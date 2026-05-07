Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0185CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11w-0005L2-P9; Thu, 07 May 2026 11:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11t-0005Al-KZ
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:49 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11r-00040W-Ji
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso6753895e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169166; x=1778773966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0uKJt+OphwE2k5DECXia92MWndnWedOH3NjDI4wh+v0=;
 b=lhqBi9PcYW8j4jhcQ7RsNwQ4NVWaj4+WrRJqA0BICbKhU7ze9PgFdwnXb/suHSkmY0
 YQP1h68Srk8tMcdUe2k0SmBsb2HOGeqtrG4mW8byTZIlFGO/isJvMNxKK/uhp3y6yvWg
 Z2RSNGIv2Aj6DYGySnOBC/luYLBRmhSGAqK7VGYryCoQCZOKz0sSxQ3vM3tS16AAovtv
 3gFSV8oBlR7tIj7xjo5IOGdR6NEQqeQSA+FozM0eMsg1sEnJZhWsplwk2d3uvR2dEQ+d
 phzl0sgR24z4WvJwUoX+KdBnfPh3ms1hL3CIuZZyJ7U+6rgHlKTQwGvnUwIsOw8U5dBv
 znYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169166; x=1778773966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0uKJt+OphwE2k5DECXia92MWndnWedOH3NjDI4wh+v0=;
 b=fkAUcMJkaVkYI07gOjeDTmqvqJWLYfl8PN3eP/8p9qu7s6ePKHSTIS5yxQ8T+4EEms
 yAVFb3bhLHcUzAI9pGbh162DjbsTCV+pywNUUbE9fcg32gKMHKVMXeG1JHtky4oEt0ft
 LBQxyMTwnnXNoyf+Vghhi+iDvLoLUstgFlGpHWv0h9JV/2JVTJGST5KbY4cY88Lri3w3
 o16a8oW8NPt226I/jkw84OKtRPA8DxGgubd/ww0tbSswPCyO18T21oPzgaBXgqVPTWPd
 Y3TqPMV0cNCtgMgz0PmlqWgdY/V/WNzHOQMy+8ocrQ6C59mrjuBjGcCKBP4KOR9aiLVy
 2ywg==
X-Gm-Message-State: AOJu0YxPD8eCCBbyEpOs/wCM+RIhkTz6cnRrqmK9HARHqFwMQEo8bda4
 LlJv3p8i3+v/RzgA7N5GadRRWxFTZF60RfLvBpSXCYCQMd3aYBXrhzfh2cEj7D45cb+17DbbMlZ
 L2Z+z
X-Gm-Gg: AeBDiesJBDx3FbtQNhG2/lNbvJumfgTHPVFIsldMGoBvB51XlIjWahcXj52cKaM3l+B
 qRkBn6jvqoIxsRpIij3veo+Wi34EEA+GB+fVWxLeqvivwI7biND6aNYff3njsaMir6j8417/c1f
 KBBpHkO5eaBAFGufZaart3BYFjdWvnJTLUleodb5skToWSfN5zDysogUzCquBdF//xJXFlpxMqB
 jl88A580rIGq5JioH8SxKd5Brrjwdh5rvgr5Gzm0m0SVp7zMZ97iIL1cXfVwX3tZJFpeg7w1fd+
 DIjptToyw0e99Pa/rE+XJ8B+6tXfcpwWmepiZRPdm+31yBne0CIMx0Q8oO5rzV+BV99orVyoWpH
 cf4Tdrd/R8SCsFtOPHoVAVI5W3C0g9afnJi9YZcDdK0+v6mj59E8l2wIuSomNNkjwPCASBAeNEv
 yF+Dj6aK3ywWYv2krtcOnx6bbM8+7xOaM+6n0lJ5DtRFfdriSjOHTD1GS/F3977UgKauyeeBgeO
 RS/Bf7899R7Gusg
X-Received: by 2002:a05:600c:46d2:b0:485:364e:9328 with SMTP id
 5b1f17b1804b1-48e51f32aebmr133265455e9.16.1778169161829; 
 Thu, 07 May 2026 08:52:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/67] target/arm: GICv5 cpuif: Implement ICC_HPPIR_EL1
Date: Thu,  7 May 2026 16:51:33 +0100
Message-ID: <20260507155154.1886557-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Implement ICC_HPPIR_EL1, which the guest can use to read the current
highest priority pending interrupt.  Like APR, PCR and CR0, this is
banked, with the _EL1 register reading the answer for the current
logical interrupt domain, and the _EL3 register reading the answer
for the EL3 interrupt domain.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-47-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c                | 10 +++++
 include/hw/intc/arm_gicv5_stream.h | 13 +++++++
 target/arm/tcg/gicv5-cpuif.c       | 61 ++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 12cbf9c51e..605cf6fd6f 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -527,6 +527,16 @@ static void irs_recall_hppis(GICv5 *s, GICv5Domain domain)
     }
 }
 
+GICv5PendingIrq gicv5_get_hppi(GICv5Common *cs, GICv5Domain domain,
+                               uint32_t iaffid)
+{
+    GICv5 *s = ARM_GICV5(cs);
+    int cpuidx = irs_cpuidx_from_iaffid(cs, iaffid);
+
+    assert(cpuidx >= 0);
+    return s->hppi[domain][cpuidx];
+}
+
 static hwaddr l1_iste_addr(GICv5Common *cs, const GICv5ISTConfig *cfg,
                            uint32_t id)
 {
diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
index 60c470b84c..cc1c7cc438 100644
--- a/include/hw/intc/arm_gicv5_stream.h
+++ b/include/hw/intc/arm_gicv5_stream.h
@@ -175,4 +175,17 @@ uint64_t gicv5_request_config(GICv5Common *cs, uint32_t id, GICv5Domain domain,
  */
 void gicv5_forward_interrupt(ARMCPU *cpu, GICv5Domain domain);
 
+/**
+ * gicv5_get_hppi
+ * @cs: GIC IRS to query
+ * @domain: interrupt domain to act on
+ * @iaffid: IAFFID of this CPU interface
+ *
+ * Ask the IRS for the highest priority pending interrupt that it has
+ * for this CPU. This returns the equivalent of what in the stream
+ * protocol is the outstanding interrupt sent with a Forward packet.
+ */
+GICv5PendingIrq gicv5_get_hppi(GICv5Common *cs, GICv5Domain domain,
+                               uint32_t iaffid);
+
 #endif
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 07ebe3a816..e7fe4f0fa1 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -51,6 +51,10 @@ FIELD(ICC_CR0, PID, 38, 1)
 
 FIELD(ICC_PCR, PRIORITY, 0, 5)
 
+FIELD(ICC_HPPIR_EL1, ID, 0, 24)
+FIELD(ICC_HPPIR_EL1, TYPE, 29, 3)
+FIELD(ICC_HPPIR_EL1, HPPIV, 32, 1)
+
 /*
  * We implement 24 bits of interrupt ID, the mandated 5 bits of priority,
  * and no legacy GICv3.3 vcpu interface (yet)
@@ -114,6 +118,51 @@ static uint64_t gic_running_prio(CPUARMState *env, GICv5Domain domain)
     return hap < 32 ? hap : PRIO_IDLE;
 }
 
+static GICv5PendingIrq gic_hppi(CPUARMState *env, GICv5Domain domain)
+{
+    /*
+     * Return the current highest priority pending interrupt for the
+     * specified domain, if it has sufficient priority to preempt. The
+     * intid field of the return value will be in the format of the
+     * ICC_HPPIR register (and will be zero if and only if there is no
+     * interrupt that can preempt).
+     */
+
+    GICv5Common *gic = gicv5_get_gic(env);
+    GICv5PendingIrq best, irs_hppi;
+
+    if (!(env->gicv5_cpuif.icc_cr0[domain] & R_ICC_CR0_EN_MASK)) {
+        /* If cpuif is disabled there is no HPPI */
+        return (GICv5PendingIrq) { .intid = 0, .prio = PRIO_IDLE };
+    }
+
+    irs_hppi = gicv5_get_hppi(gic, domain, env->gicv5_iaffid);
+
+    /*
+     * If the best PPI and the best interrupt from the IRS have the
+     * same priority, it's IMPDEF which we pick (R_VVBPS). We choose
+     * the PPI.
+     */
+    if (env->gicv5_cpuif.ppi_hppi[domain].prio <= irs_hppi.prio) {
+        best = env->gicv5_cpuif.ppi_hppi[domain];
+    } else {
+        best = irs_hppi;
+    }
+
+    /*
+     * D_MSQKF: an interrupt has sufficient priority if its priority
+     * is higher than the current running priority and equal to or
+     * higher than the priority mask.
+     */
+    if (best.prio == PRIO_IDLE ||
+        best.prio > env->gicv5_cpuif.icc_pcr[domain] ||
+        best.prio >= gic_running_prio(env, domain)) {
+        return (GICv5PendingIrq) { .intid = 0, .prio = PRIO_IDLE };
+    }
+    best.intid |= R_ICC_HPPIR_EL1_HPPIV_MASK;
+    return best;
+}
+
 static void gic_recalc_ppi_hppi(CPUARMState *env)
 {
     /*
@@ -407,6 +456,13 @@ static void gic_icc_pcr_el1_reset(CPUARMState *env, const ARMCPRegInfo *ri)
     }
 }
 
+static uint64_t gic_icc_hppir_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv5Domain domain = gicv5_logical_domain(env);
+    GICv5PendingIrq hppi = gic_hppi(env, domain);
+    return hppi.intid;
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -522,6 +578,11 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_hm[1]),
         .resetvalue = PPI_HMR1_RESET,
     },
+    {   .name = "ICC_HPPIR_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 3,
+        .access = PL1_R, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .readfn = gic_icc_hppir_el1_read,
+    },
     {   .name = "ICC_PPI_ENABLER0_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 6,
         .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
-- 
2.43.0


