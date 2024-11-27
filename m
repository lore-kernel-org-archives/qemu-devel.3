Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF32D6ACF7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 17:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGLQo-0005aa-Ur; Wed, 27 Nov 2024 12:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tGLQM-0005Mh-ND
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 12:01:59 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tGLQK-00087O-JE
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 12:01:58 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3822ba3cdbcso4376831f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 09:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732726912; x=1733331712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BK8TIAjll/6R1Ge96CSRoz23ynixcHerxBS5pLRFo6w=;
 b=mjbwGbyJrB+DxJ7aerv4kppEQUeTJToO9GrSUgbT7pbcGhb3Vm88MOuC1DFRQrtHlV
 ABNeGuI2D0wZAlz0dywTD9KMBbOXf3KjDtc/p2RznUREHFQe1FoYVOWqMpljhhWrCQfE
 zR+drmRpIJvjuncHmf+k/FLfRaN9kZslPgPC7qpzqDUijEalF5o1KiRhncRUwkCeD3yh
 9Uwbr6/2eoC/khK9ScvMXTxRKIJXhBljpJts61TNZJk5t1q5rgXurU7MDVYAeHiwycng
 iA1x80CNmC/dQIvKLUEN4zJytoBbW5ep3K/90/ono4BJ4gSnvsZ32WsV+3DFALcJR+0N
 0iEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732726912; x=1733331712;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BK8TIAjll/6R1Ge96CSRoz23ynixcHerxBS5pLRFo6w=;
 b=ulxkAZaxFc11Rbf/oNIffkT65tuwc/ctsdLqzKMKXNXBMH+phIOhroXMev4M9tUq7s
 fEQcwzUHyt7EWDi07WJV68uHZ4+vYKWFhA3bwpjSFpcSr77Eq+nMXb9xnYyrLiwm57ln
 QTeGBiR6yWaxFj/OigqHDVOaYdmPBSPpO3n8wj9Uw3ejjlMquayTPoIColibI4YK7Zqh
 JMZCD3zErHVTjaKtHfMwbOCb9krJq11sbUjXLaBdUZ3+qMKuw3qjzEz8x2BsPe3ckvx9
 y0cG6Ebl15ceCmyAaP7RsX2woPdEVWOVnK1wTxNKLf6sKNdvevQPl2vKyiSqQFDGQSIE
 bAzA==
X-Gm-Message-State: AOJu0YxWi+H//1itLjDvXXyiXyO7ks+V0C0uVlh926PDoyk5iG3hKI/X
 WQjBSRqbVWsoey+wa69cLXX61QeSoOET6wV0+trWyXT8fK7kmbMc8aWCwbCe8ZdfNflHKo92rdn
 hXaM=
X-Gm-Gg: ASbGncvF+TiioU4z92DyWO5nm6fhJCtUdQHWcPj7yVjvneuuYOUgE8MgYlfqvpEX8P5
 gZBs9RYIizvVJrVK4zJ4BBoskfNGE6bLJ0eiWavG/9bZ6M4wtXJ8ZfBoh8zMMkhqaqdXnHMruoi
 ebYXEUES9fLip6QYscpvoI1SZdBCe5ctgq/3EC0W74DFoqS5TwrpTvyvL9oSuEZmAeofHp8evic
 ypLrSCuYSpYmDetd+bg05hyT3+YeafcJsV5OWsD0tMOruVf
X-Google-Smtp-Source: AGHT+IELswnrsLo8kQCzbo6wj5p/2jz6hUjubvbZbhxxjl7FxA0qIY8EMwZevVly2n8zKmptcAS5NA==
X-Received: by 2002:a5d:588c:0:b0:382:4a9d:2910 with SMTP id
 ffacd0b85a97d-385c6ef4b02mr3288688f8f.51.1732726912081; 
 Wed, 27 Nov 2024 09:01:52 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbedf35sm16739876f8f.99.2024.11.27.09.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 09:01:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 647465F760;
 Wed, 27 Nov 2024 17:01:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Andrei Homescu <ahomescu@google.com>,
 =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@google.com>,
 =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi.denis.courmont@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:Virt)
Subject: [RFC PATCH] target/arm: implement SEL2 physical and virtual timers
Date: Wed, 27 Nov 2024 17:01:43 +0000
Message-Id: <20241127170143.1664829-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When FEAT_SEL2 was implemented the SEL2 timers where missed. This
shows up when building the latest Hafnium with SPMC_AT_EL=2. The
actual implementation utilises the same logic as the rest of the
timers so all we need to do is:

  - define the timers and their access functions
  - conditionally add the correct system registers
  - create a new accessfn as the rules are subtly different to the
    existing secure timer

Fixes: e9152ee91c (target/arm: add ARMv8.4-SEL2 system registers)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Andrei Homescu <ahomescu@google.com>
Cc: Arve Hjønnevåg <arve@google.com>
Cc: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
---
 include/hw/arm/bsa.h |   2 +
 target/arm/cpu.h     |   2 +
 target/arm/gtimer.h  |   4 +-
 hw/arm/virt.c        |   2 +
 target/arm/cpu.c     |   8 +++
 target/arm/helper.c  | 155 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/bsa.h b/include/hw/arm/bsa.h
index 8eaab603c0..b4ecca1b1c 100644
--- a/include/hw/arm/bsa.h
+++ b/include/hw/arm/bsa.h
@@ -22,6 +22,8 @@
 #define QEMU_ARM_BSA_H
 
 /* These are architectural INTID values */
+#define ARCH_TIMER_S_VIRT_EL2_IRQ  19
+#define ARCH_TIMER_S_EL2_IRQ       20
 #define VIRTUAL_PMU_IRQ            23
 #define ARCH_GIC_MAINT_IRQ         25
 #define ARCH_TIMER_NS_EL2_IRQ      26
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d86e641280..10b5354d6f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1139,6 +1139,8 @@ void arm_gt_vtimer_cb(void *opaque);
 void arm_gt_htimer_cb(void *opaque);
 void arm_gt_stimer_cb(void *opaque);
 void arm_gt_hvtimer_cb(void *opaque);
+void arm_gt_sel2timer_cb(void *opaque);
+void arm_gt_sel2vtimer_cb(void *opaque);
 
 unsigned int gt_cntfrq_period_ns(ARMCPU *cpu);
 void gt_rme_post_el_change(ARMCPU *cpu, void *opaque);
diff --git a/target/arm/gtimer.h b/target/arm/gtimer.h
index b992941bef..3c097c59c7 100644
--- a/target/arm/gtimer.h
+++ b/target/arm/gtimer.h
@@ -15,7 +15,9 @@ enum {
     GTIMER_HYP      = 2,
     GTIMER_SEC      = 3,
     GTIMER_HYPVIRT  = 4,
-#define NUM_GTIMERS   5
+    GTIMER_SEC_PEL2 = 5,
+    GTIMER_SEC_VEL2 = 6,
+#define NUM_GTIMERS   7
 };
 
 #endif
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1a381e9a2b..451d154459 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -873,6 +873,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
             [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
             [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
             [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
+            [GTIMER_SEC_PEL2] = ARCH_TIMER_S_EL2_IRQ,
+            [GTIMER_SEC_VEL2] = ARCH_TIMER_S_VIRT_EL2_IRQ,
         };
 
         for (unsigned irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6938161b95..e42ab8ce8b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2078,6 +2078,14 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
                                               arm_gt_stimer_cb, cpu);
         cpu->gt_timer[GTIMER_HYPVIRT] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
                                                   arm_gt_hvtimer_cb, cpu);
+
+        /* FEAT_SEL2 also has physical and virtual timers */
+        if (cpu_isar_feature(aa64_sel2, cpu)) {
+            cpu->gt_timer[GTIMER_SEC_PEL2] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
+                                                       arm_gt_sel2timer_cb, cpu);
+            cpu->gt_timer[GTIMER_SEC_VEL2] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
+                                                       arm_gt_sel2vtimer_cb, cpu);
+        }
     }
 #endif
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f38eb054c0..b5a8a5846e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2668,6 +2668,41 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
     }
 }
 
+static CPAccessResult gt_sel2timer_access(CPUARMState *env,
+                                          const ARMCPRegInfo *ri,
+                                          bool isread)
+{
+    /*
+     * The AArch64 register view of the secure EL2 timers are mostly
+     * accessible from EL3 and EL2 although can also be trapped to EL2
+     * from EL1 depending on nested virt config.
+     */
+    switch (arm_current_el(env)) {
+    case 0:
+        return CP_ACCESS_TRAP;
+    case 1:
+        if (!arm_is_secure(env)) {
+            return CP_ACCESS_TRAP;
+        } else if (arm_hcr_el2_eff(env) & HCR_NV) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+        return CP_ACCESS_TRAP;
+    case 2:
+        if (!arm_is_secure(env)) {
+            return CP_ACCESS_TRAP;
+        }
+        return CP_ACCESS_OK;
+    case 3:
+        if (env->cp15.scr_el3 & SCR_EEL2) {
+            return CP_ACCESS_OK;
+        } else {
+            return CP_ACCESS_TRAP;
+        }
+    default:
+        g_assert_not_reached();
+    }
+}
+
 uint64_t gt_get_countervalue(CPUARMState *env)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -3175,6 +3210,62 @@ static void gt_sec_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gt_ctl_write(env, ri, GTIMER_SEC, value);
 }
 
+static void gt_sec_pel2_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    gt_timer_reset(env, ri, GTIMER_SEC_PEL2);
+}
+
+static void gt_sec_pel2_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   uint64_t value)
+{
+    gt_cval_write(env, ri, GTIMER_SEC_PEL2, value);
+}
+
+static uint64_t gt_sec_pel2_tval_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return gt_tval_read(env, ri, GTIMER_SEC_PEL2);
+}
+
+static void gt_sec_pel2_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    gt_tval_write(env, ri, GTIMER_SEC_PEL2, value);
+}
+
+static void gt_sec_pel2_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    gt_ctl_write(env, ri, GTIMER_SEC_PEL2, value);
+}
+
+static void gt_sec_vel2_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    gt_timer_reset(env, ri, GTIMER_SEC_VEL2);
+}
+
+static void gt_sec_vel2_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    gt_cval_write(env, ri, GTIMER_SEC_VEL2, value);
+}
+
+static uint64_t gt_sec_vel2_tval_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return gt_tval_read(env, ri, GTIMER_SEC_VEL2);
+}
+
+static void gt_sec_vel2_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   uint64_t value)
+{
+    gt_tval_write(env, ri, GTIMER_SEC_VEL2, value);
+}
+
+static void gt_sec_vel2_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    gt_ctl_write(env, ri, GTIMER_SEC_VEL2, value);
+}
+
 static void gt_hv_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     gt_timer_reset(env, ri, GTIMER_HYPVIRT);
@@ -3231,6 +3322,20 @@ void arm_gt_stimer_cb(void *opaque)
     gt_recalc_timer(cpu, GTIMER_SEC);
 }
 
+void arm_gt_sel2timer_cb(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    gt_recalc_timer(cpu, GTIMER_SEC_PEL2);
+}
+
+void arm_gt_sel2vtimer_cb(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    gt_recalc_timer(cpu, GTIMER_SEC_VEL2);
+}
+
 void arm_gt_hvtimer_cb(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -6613,6 +6718,56 @@ static const ARMCPRegInfo el2_sec_cp_reginfo[] = {
       .access = PL2_RW, .accessfn = sel2_access,
       .nv2_redirect_offset = 0x48,
       .fieldoffset = offsetof(CPUARMState, cp15.vstcr_el2) },
+#ifndef CONFIG_USER_ONLY
+    /* Secure EL2 Physical Timer */
+    { .name = "CNTHPS_TVAL_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 5, .opc2 = 0,
+      .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL2_RW,
+      .accessfn = gt_sel2timer_access,
+      .readfn = gt_sec_pel2_tval_read,
+      .writefn = gt_sec_pel2_tval_write,
+      .resetfn = gt_sec_pel2_timer_reset,
+    },
+    { .name = "CNTHPS_CTL_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 5, .opc2 = 1,
+      .type = ARM_CP_IO, .access = PL2_RW,
+      .accessfn = gt_sel2timer_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_SEC_PEL2].ctl),
+      .resetvalue = 0,
+      .writefn = gt_sec_pel2_ctl_write, .raw_writefn = raw_write,
+    },
+    { .name = "CNTHPS_CVAL_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 5, .opc2 = 2,
+      .type = ARM_CP_IO, .access = PL2_RW,
+      .accessfn = gt_sel2timer_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_SEC_PEL2].cval),
+      .writefn = gt_sec_pel2_cval_write, .raw_writefn = raw_write,
+    },
+    /* Secure EL2 Virtual Timer */
+    { .name = "CNTHVS_TVAL_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 4, .opc2 = 0,
+      .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL2_RW,
+      .accessfn = gt_sel2timer_access,
+      .readfn = gt_sec_vel2_tval_read,
+      .writefn = gt_sec_vel2_tval_write,
+      .resetfn = gt_sec_vel2_timer_reset,
+    },
+    { .name = "CNTHVS_CTL_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 4, .opc2 = 1,
+      .type = ARM_CP_IO, .access = PL2_RW,
+      .accessfn = gt_sel2timer_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_SEC_VEL2].ctl),
+      .resetvalue = 0,
+      .writefn = gt_sec_vel2_ctl_write, .raw_writefn = raw_write,
+    },
+    { .name = "CNTHVS_CVAL_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 4, .opc2 = 2,
+      .type = ARM_CP_IO, .access = PL2_RW,
+      .accessfn = gt_sel2timer_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_SEC_VEL2].cval),
+      .writefn = gt_sec_vel2_cval_write, .raw_writefn = raw_write,
+    },
+#endif
 };
 
 static CPAccessResult nsacr_access(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.39.5


