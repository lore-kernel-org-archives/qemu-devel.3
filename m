Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF7FC41513
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 12:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sThe9-0003Kg-BL; Tue, 16 Jul 2024 08:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sThe7-0003Df-M4
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:51:07 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sThe5-0004wO-G9
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:51:07 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fb4a807708so48533575ad.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721134264; x=1721739064;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WEJblyW6Ds1TMF7KFQ+gDmurIfGkUROkVQ8nHbOWOsc=;
 b=wIBIlEE6zIuVsLG300I0vs8UpN3cKwfhFvkNTc7E7pu4P1Th5wvButz6VOlyYuQlI7
 7xTezJfOFQT7FyAgF7WZeXGJ9p7J3IlerZFLHcVBw9rj0cCo0ZjwUl5mtrQHe2ADnClO
 5rJsjUQzEyxMkYUH1JNAN5lo0v0oN2r+HRfHbHR/QiBi0Ttec9Ihry4u7CduJ1F7lIRx
 4pnhOpKX4dkkfkXd6ESbJmSk6Y5pCQj8YvpY+1wQ9fNQgvgixK2gjh3+dQhLtiGoLiP7
 1ZBbZn4hb14xNuWhvWHgxWMJEMGzh3Jl22WKAOLC0zWr+yG/pSGJX5U51Du0AgBo41jD
 pl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721134264; x=1721739064;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WEJblyW6Ds1TMF7KFQ+gDmurIfGkUROkVQ8nHbOWOsc=;
 b=h5U9/TvbpF+oSL9ijrd5d2HiHqxf3HkR8bMRGOKpMwixPVp68aLW/kJlcwA1IpQN0m
 y6Ji/+VrOZMVYHOUYFnJuO7TeledF7iV3eW9Qg3/Fe+KX0hrFGs7jOVKjXQCvUBVltvm
 zExdauMjg0vj1OSmc9fLD7p7a90EyvLfbBZIyCWoqB/XoEWwkLrODc/tI1V4FUIGbR+0
 v7ke2pEh+Q5115uni/0cJCwCmTsiNBdISuHN1/xmX5D1htiUu6h2TTCrbN9597qtG3UX
 BMQHNiu9CiFt1PCRfjdsOJSUb55XVVNcbgomt9cEQO/W+sYEp4QlZ2nrF3oEmbqaewwN
 Gc2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEfSkfr7KceRs2vAq41cIqgUenWXEAscvMWFcKjBhjSCnU6+Whx6Orug02t1fN5vldRXs/z9MuSkQWcXzl+Hjuj9en230=
X-Gm-Message-State: AOJu0YzGquljI9NnmUVF5I+jl+OjutPKzqr5hUkokExU2bzAvraYCgPc
 5mliOoCGUGbxHDKYI6AuOOKyzoen1VE8rknDMRQBccoOHnNNmruzzsG9V+gt3uDFNQngo0ttYDW
 P
X-Google-Smtp-Source: AGHT+IHLl6OhxYtFa4Hu9G+eXwmzB422zbJLkf8LJk3FIsLRsVJ+05Y25EPMKfYbsu8hkTzkg2XY7A==
X-Received: by 2002:a17:902:fc8d:b0:1fc:2c53:80a0 with SMTP id
 d9443c01a7336-1fc3d93959cmr16756835ad.14.1721134263928; 
 Tue, 16 Jul 2024 05:51:03 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fc0bc2634fsm57640325ad.127.2024.07.16.05.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 05:51:03 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 16 Jul 2024 21:50:34 +0900
Subject: [PATCH v3 5/5] hvf: arm: Properly disable PMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-pmu-v3-5-8c7c1858a227@daynix.com>
References: <20240716-pmu-v3-0-8c7c1858a227@daynix.com>
In-Reply-To: <20240716-pmu-v3-0-8c7c1858a227@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Setting pmu property used to have no effect for hvf so fix it.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/arm/hvf/hvf.c | 317 ++++++++++++++++++++++++++-------------------------
 1 file changed, 163 insertions(+), 154 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index eb090e67a2f8..7c593c2d93de 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1199,57 +1199,23 @@ static bool hvf_sysreg_read_cp(CPUState *cpu, uint32_t reg, uint64_t *val)
     return false;
 }
 
-static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt)
+static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt,
+                           uint64_t *val)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
-    uint64_t val = 0;
 
     switch (reg) {
     case SYSREG_CNTPCT_EL0:
-        val = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
-              gt_cntfrq_period_ns(arm_cpu);
-        break;
-    case SYSREG_PMCR_EL0:
-        val = env->cp15.c9_pmcr;
-        break;
-    case SYSREG_PMCCNTR_EL0:
-        pmu_op_start(env);
-        val = env->cp15.c15_ccnt;
-        pmu_op_finish(env);
-        break;
-    case SYSREG_PMCNTENCLR_EL0:
-        val = env->cp15.c9_pmcnten;
-        break;
-    case SYSREG_PMOVSCLR_EL0:
-        val = env->cp15.c9_pmovsr;
-        break;
-    case SYSREG_PMSELR_EL0:
-        val = env->cp15.c9_pmselr;
-        break;
-    case SYSREG_PMINTENCLR_EL1:
-        val = env->cp15.c9_pminten;
-        break;
-    case SYSREG_PMCCFILTR_EL0:
-        val = env->cp15.pmccfiltr_el0;
-        break;
-    case SYSREG_PMCNTENSET_EL0:
-        val = env->cp15.c9_pmcnten;
-        break;
-    case SYSREG_PMUSERENR_EL0:
-        val = env->cp15.c9_pmuserenr;
-        break;
-    case SYSREG_PMCEID0_EL0:
-    case SYSREG_PMCEID1_EL0:
-        /* We can't really count anything yet, declare all events invalid */
-        val = 0;
-        break;
+        *val = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
+               gt_cntfrq_period_ns(arm_cpu);
+        return 0;
     case SYSREG_OSLSR_EL1:
-        val = env->cp15.oslsr_el1;
-        break;
+        *val = env->cp15.oslsr_el1;
+        return 0;
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
-        break;
+        return 0;
     case SYSREG_ICC_AP0R0_EL1:
     case SYSREG_ICC_AP0R1_EL1:
     case SYSREG_ICC_AP0R2_EL1:
@@ -1276,11 +1242,11 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt)
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
-        if (!hvf_sysreg_read_cp(cpu, reg, &val)) {
+        if (!hvf_sysreg_read_cp(cpu, reg, val)) {
             hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
             return 1;
         }
-        break;
+        return 0;
     case SYSREG_DBGBVR0_EL1:
     case SYSREG_DBGBVR1_EL1:
     case SYSREG_DBGBVR2_EL1:
@@ -1297,8 +1263,8 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt)
     case SYSREG_DBGBVR13_EL1:
     case SYSREG_DBGBVR14_EL1:
     case SYSREG_DBGBVR15_EL1:
-        val = env->cp15.dbgbvr[SYSREG_CRM(reg)];
-        break;
+        *val = env->cp15.dbgbvr[SYSREG_CRM(reg)];
+        return 0;
     case SYSREG_DBGBCR0_EL1:
     case SYSREG_DBGBCR1_EL1:
     case SYSREG_DBGBCR2_EL1:
@@ -1315,8 +1281,8 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt)
     case SYSREG_DBGBCR13_EL1:
     case SYSREG_DBGBCR14_EL1:
     case SYSREG_DBGBCR15_EL1:
-        val = env->cp15.dbgbcr[SYSREG_CRM(reg)];
-        break;
+        *val = env->cp15.dbgbcr[SYSREG_CRM(reg)];
+        return 0;
     case SYSREG_DBGWVR0_EL1:
     case SYSREG_DBGWVR1_EL1:
     case SYSREG_DBGWVR2_EL1:
@@ -1333,8 +1299,8 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt)
     case SYSREG_DBGWVR13_EL1:
     case SYSREG_DBGWVR14_EL1:
     case SYSREG_DBGWVR15_EL1:
-        val = env->cp15.dbgwvr[SYSREG_CRM(reg)];
-        break;
+        *val = env->cp15.dbgwvr[SYSREG_CRM(reg)];
+        return 0;
     case SYSREG_DBGWCR0_EL1:
     case SYSREG_DBGWCR1_EL1:
     case SYSREG_DBGWCR2_EL1:
@@ -1351,35 +1317,64 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt)
     case SYSREG_DBGWCR13_EL1:
     case SYSREG_DBGWCR14_EL1:
     case SYSREG_DBGWCR15_EL1:
-        val = env->cp15.dbgwcr[SYSREG_CRM(reg)];
-        break;
-    default:
-        if (is_id_sysreg(reg)) {
-            /* ID system registers read as RES0 */
-            val = 0;
-            break;
+        *val = env->cp15.dbgwcr[SYSREG_CRM(reg)];
+        return 0;
+    }
+
+    if (arm_feature(env, ARM_FEATURE_PMU)) {
+        switch (reg) {
+        case SYSREG_PMCR_EL0:
+            *val = env->cp15.c9_pmcr;
+            return 0;
+        case SYSREG_PMCCNTR_EL0:
+            pmu_op_start(env);
+            *val = env->cp15.c15_ccnt;
+            pmu_op_finish(env);
+            return 0;
+        case SYSREG_PMCNTENCLR_EL0:
+            *val = env->cp15.c9_pmcnten;
+            return 0;
+        case SYSREG_PMOVSCLR_EL0:
+            *val = env->cp15.c9_pmovsr;
+            return 0;
+        case SYSREG_PMSELR_EL0:
+            *val = env->cp15.c9_pmselr;
+            return 0;
+        case SYSREG_PMINTENCLR_EL1:
+            *val = env->cp15.c9_pminten;
+            return 0;
+        case SYSREG_PMCCFILTR_EL0:
+            *val = env->cp15.pmccfiltr_el0;
+            return 0;
+        case SYSREG_PMCNTENSET_EL0:
+            *val = env->cp15.c9_pmcnten;
+            return 0;
+        case SYSREG_PMUSERENR_EL0:
+            *val = env->cp15.c9_pmuserenr;
+            return 0;
+        case SYSREG_PMCEID0_EL0:
+        case SYSREG_PMCEID1_EL0:
+            /* We can't really count anything yet, declare all events invalid */
+            *val = 0;
+            return 0;
         }
-        cpu_synchronize_state(cpu);
-        trace_hvf_unhandled_sysreg_read(env->pc, reg,
-                                        SYSREG_OP0(reg),
-                                        SYSREG_OP1(reg),
-                                        SYSREG_CRN(reg),
-                                        SYSREG_CRM(reg),
-                                        SYSREG_OP2(reg));
-        hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
-        return 1;
-    }
-
-    trace_hvf_sysreg_read(reg,
-                          SYSREG_OP0(reg),
-                          SYSREG_OP1(reg),
-                          SYSREG_CRN(reg),
-                          SYSREG_CRM(reg),
-                          SYSREG_OP2(reg),
-                          val);
-    hvf_set_reg(cpu, rt, val);
+    }
 
-    return 0;
+    if (is_id_sysreg(reg)) {
+        /* ID system registers read as RES0 */
+        *val = 0;
+        return 0;
+    }
+
+    cpu_synchronize_state(cpu);
+    trace_hvf_unhandled_sysreg_read(env->pc, reg,
+                                    SYSREG_OP0(reg),
+                                    SYSREG_OP1(reg),
+                                    SYSREG_CRN(reg),
+                                    SYSREG_CRM(reg),
+                                    SYSREG_OP2(reg));
+    hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
+    return 1;
 }
 
 static void pmu_update_irq(CPUARMState *env)
@@ -1499,69 +1494,12 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
                            val);
 
     switch (reg) {
-    case SYSREG_PMCCNTR_EL0:
-        pmu_op_start(env);
-        env->cp15.c15_ccnt = val;
-        pmu_op_finish(env);
-        break;
-    case SYSREG_PMCR_EL0:
-        pmu_op_start(env);
-
-        if (val & PMCRC) {
-            /* The counter has been reset */
-            env->cp15.c15_ccnt = 0;
-        }
-
-        if (val & PMCRP) {
-            unsigned int i;
-            for (i = 0; i < pmu_num_counters(env); i++) {
-                env->cp15.c14_pmevcntr[i] = 0;
-            }
-        }
-
-        env->cp15.c9_pmcr &= ~PMCR_WRITABLE_MASK;
-        env->cp15.c9_pmcr |= (val & PMCR_WRITABLE_MASK);
-
-        pmu_op_finish(env);
-        break;
-    case SYSREG_PMUSERENR_EL0:
-        env->cp15.c9_pmuserenr = val & 0xf;
-        break;
-    case SYSREG_PMCNTENSET_EL0:
-        env->cp15.c9_pmcnten |= (val & pmu_counter_mask(env));
-        break;
-    case SYSREG_PMCNTENCLR_EL0:
-        env->cp15.c9_pmcnten &= ~(val & pmu_counter_mask(env));
-        break;
-    case SYSREG_PMINTENCLR_EL1:
-        pmu_op_start(env);
-        env->cp15.c9_pminten |= val;
-        pmu_op_finish(env);
-        break;
-    case SYSREG_PMOVSCLR_EL0:
-        pmu_op_start(env);
-        env->cp15.c9_pmovsr &= ~val;
-        pmu_op_finish(env);
-        break;
-    case SYSREG_PMSWINC_EL0:
-        pmu_op_start(env);
-        pmswinc_write(env, val);
-        pmu_op_finish(env);
-        break;
-    case SYSREG_PMSELR_EL0:
-        env->cp15.c9_pmselr = val & 0x1f;
-        break;
-    case SYSREG_PMCCFILTR_EL0:
-        pmu_op_start(env);
-        env->cp15.pmccfiltr_el0 = val & PMCCFILTR_EL0;
-        pmu_op_finish(env);
-        break;
     case SYSREG_OSLAR_EL1:
         env->cp15.oslsr_el1 = val & 1;
-        break;
+        return 0;
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
-        break;
+        return 0;
     case SYSREG_ICC_AP0R0_EL1:
     case SYSREG_ICC_AP0R1_EL1:
     case SYSREG_ICC_AP0R2_EL1:
@@ -1591,10 +1529,10 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
         if (!hvf_sysreg_write_cp(cpu, reg, val)) {
             hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
         }
-        break;
+        return 0;
     case SYSREG_MDSCR_EL1:
         env->cp15.mdscr_el1 = val;
-        break;
+        return 0;
     case SYSREG_DBGBVR0_EL1:
     case SYSREG_DBGBVR1_EL1:
     case SYSREG_DBGBVR2_EL1:
@@ -1612,7 +1550,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_DBGBVR14_EL1:
     case SYSREG_DBGBVR15_EL1:
         env->cp15.dbgbvr[SYSREG_CRM(reg)] = val;
-        break;
+        return 0;
     case SYSREG_DBGBCR0_EL1:
     case SYSREG_DBGBCR1_EL1:
     case SYSREG_DBGBCR2_EL1:
@@ -1630,7 +1568,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_DBGBCR14_EL1:
     case SYSREG_DBGBCR15_EL1:
         env->cp15.dbgbcr[SYSREG_CRM(reg)] = val;
-        break;
+        return 0;
     case SYSREG_DBGWVR0_EL1:
     case SYSREG_DBGWVR1_EL1:
     case SYSREG_DBGWVR2_EL1:
@@ -1648,7 +1586,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_DBGWVR14_EL1:
     case SYSREG_DBGWVR15_EL1:
         env->cp15.dbgwvr[SYSREG_CRM(reg)] = val;
-        break;
+        return 0;
     case SYSREG_DBGWCR0_EL1:
     case SYSREG_DBGWCR1_EL1:
     case SYSREG_DBGWCR2_EL1:
@@ -1666,20 +1604,80 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_DBGWCR14_EL1:
     case SYSREG_DBGWCR15_EL1:
         env->cp15.dbgwcr[SYSREG_CRM(reg)] = val;
-        break;
-    default:
-        cpu_synchronize_state(cpu);
-        trace_hvf_unhandled_sysreg_write(env->pc, reg,
-                                         SYSREG_OP0(reg),
-                                         SYSREG_OP1(reg),
-                                         SYSREG_CRN(reg),
-                                         SYSREG_CRM(reg),
-                                         SYSREG_OP2(reg));
-        hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
-        return 1;
+        return 0;
     }
 
-    return 0;
+    if (arm_feature(env, ARM_FEATURE_PMU)) {
+        switch (reg) {
+        case SYSREG_PMCCNTR_EL0:
+            pmu_op_start(env);
+            env->cp15.c15_ccnt = val;
+            pmu_op_finish(env);
+            return 0;
+        case SYSREG_PMCR_EL0:
+            pmu_op_start(env);
+
+            if (val & PMCRC) {
+                /* The counter has been reset */
+                env->cp15.c15_ccnt = 0;
+            }
+
+            if (val & PMCRP) {
+                unsigned int i;
+                for (i = 0; i < pmu_num_counters(env); i++) {
+                    env->cp15.c14_pmevcntr[i] = 0;
+                }
+            }
+
+            env->cp15.c9_pmcr &= ~PMCR_WRITABLE_MASK;
+            env->cp15.c9_pmcr |= (val & PMCR_WRITABLE_MASK);
+
+            pmu_op_finish(env);
+            return 0;
+        case SYSREG_PMUSERENR_EL0:
+            env->cp15.c9_pmuserenr = val & 0xf;
+            return 0;
+        case SYSREG_PMCNTENSET_EL0:
+            env->cp15.c9_pmcnten |= (val & pmu_counter_mask(env));
+            return 0;
+        case SYSREG_PMCNTENCLR_EL0:
+            env->cp15.c9_pmcnten &= ~(val & pmu_counter_mask(env));
+            return 0;
+        case SYSREG_PMINTENCLR_EL1:
+            pmu_op_start(env);
+            env->cp15.c9_pminten |= val;
+            pmu_op_finish(env);
+            return 0;
+        case SYSREG_PMOVSCLR_EL0:
+            pmu_op_start(env);
+            env->cp15.c9_pmovsr &= ~val;
+            pmu_op_finish(env);
+            return 0;
+        case SYSREG_PMSWINC_EL0:
+            pmu_op_start(env);
+            pmswinc_write(env, val);
+            pmu_op_finish(env);
+            return 0;
+        case SYSREG_PMSELR_EL0:
+            env->cp15.c9_pmselr = val & 0x1f;
+            return 0;
+        case SYSREG_PMCCFILTR_EL0:
+            pmu_op_start(env);
+            env->cp15.pmccfiltr_el0 = val & PMCCFILTR_EL0;
+            pmu_op_finish(env);
+            return 0;
+        }
+    }
+
+    cpu_synchronize_state(cpu);
+    trace_hvf_unhandled_sysreg_write(env->pc, reg,
+                                     SYSREG_OP0(reg),
+                                     SYSREG_OP1(reg),
+                                     SYSREG_CRN(reg),
+                                     SYSREG_CRM(reg),
+                                     SYSREG_OP2(reg));
+    hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
+    return 1;
 }
 
 static int hvf_inject_interrupts(CPUState *cpu)
@@ -1944,7 +1942,18 @@ int hvf_vcpu_exec(CPUState *cpu)
         int sysreg_ret = 0;
 
         if (isread) {
-            sysreg_ret = hvf_sysreg_read(cpu, reg, rt);
+            sysreg_ret = hvf_sysreg_read(cpu, reg, rt, &val);
+
+            if (!sysreg_ret) {
+                trace_hvf_sysreg_read(reg,
+                                      SYSREG_OP0(reg),
+                                      SYSREG_OP1(reg),
+                                      SYSREG_CRN(reg),
+                                      SYSREG_CRM(reg),
+                                      SYSREG_OP2(reg),
+                                      val);
+                hvf_set_reg(cpu, rt, val);
+            }
         } else {
             val = hvf_get_reg(cpu, rt);
             sysreg_ret = hvf_sysreg_write(cpu, reg, val);

-- 
2.45.2


