Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62EBC3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 09:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sV6RA-0000go-42; Sat, 20 Jul 2024 05:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sV6R8-0000ZD-3R
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 05:31:30 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sV6R6-000726-2K
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 05:31:29 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2caaae31799so1644605a91.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 02:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721467886; x=1722072686;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zyb9AANp083iaNY8Z+adG9wP/HNnG5GrtOuS/kU6QUk=;
 b=TKtZLQgRRNDeUBJ8YdzCGFzrrfzxaN2/UXNitrqF0rw1fallf6m9vOC1v9YaoQafnz
 RfJwhsTe7bziouBxkqCgPHYpbrEfkWE9dyVHknRB7cyS05GoRNPnBJXHbdxzX5oVw1gI
 0XmUgPjP6LiWFjzRmIDfuzof4Cq4Jc2XEuA5nTnEAJSTIgpqCt2me+8v88kJ2UBLcnEw
 U+FwP4nz/RHA3pUehkPrYArqLrsFPpCTCvz656BOhvDLTG0ZuHTR4wrDcChs89m8y7E2
 6jxNnbXTazFX3XUzcS892mfjXaDirF6cR4h9psw3F7l4h2jscLkZZFqNKC4/OILqhj1s
 8aBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721467886; x=1722072686;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zyb9AANp083iaNY8Z+adG9wP/HNnG5GrtOuS/kU6QUk=;
 b=B6SLthRzXNNmJjox1pmgMHHLdXwtWRoMJMfemiEutjljl9jFBM/2zpLp6z96PB/vbZ
 lJXOqbntFpgN7A/IcZJuUeryGtP1RvFJhtd4kZ8UV1bSYtPGNOgBD3odaQp7zOuqr/zw
 HKexn9BUduegnrc9QMI85jGQgksATqLDCP6TjX6hNsyGw+l9ykqFrfH5Nr06JI38L2I1
 0Vl54RBxH99KWn12x9TYvMcfkrDRfU0EphzVvZ8HsMF2iyExDKCMZLUvXpJfW0eQjQv4
 6W0XwWuVYCoFNDKOflXtVjoJyhR6923fWpWWzRG/k5/mIpwzroSMWhbzmB89pY8Q2gZi
 Q9aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULVldnI03RZL3MneIB2fbrZ59kTbyewBgXu0Cu2yAgPdGkbIyD8zQ3teN+45eotPmbNpKEoGc7/zlDBBkY58nlV0ahFeA=
X-Gm-Message-State: AOJu0Yyk/HWx5RgVH4Uf8tP4rplHwleug4gz6va2YEzKLC4fHVhrFdDH
 RmkQ2xrL7XtYHmCsbT0CdG1XiA3YCBUEdu1XReNjRWet2d0OsVzD0/JsYJOX3xkPfh461lUpsm/
 Mflw=
X-Google-Smtp-Source: AGHT+IFLK7YAa8KVAxsj8+pIl37nqSE3PlIwtNlg+Ie+K7ixATPTr/4qrNsV0Adtr+FdH2XvbPWsOg==
X-Received: by 2002:a17:90a:5993:b0:2c9:5f45:5d26 with SMTP id
 98e67ed59e1d1-2cd27432453mr681429a91.19.1721467886441; 
 Sat, 20 Jul 2024 02:31:26 -0700 (PDT)
Received: from localhost ([157.82.204.122])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2ccf7c5391bsm3130441a91.24.2024.07.20.02.31.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 02:31:26 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 20 Jul 2024 18:30:52 +0900
Subject: [PATCH v4 4/6] hvf: arm: Raise an exception for sysreg by default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240720-pmu-v4-4-2a2b28f6b08f@daynix.com>
References: <20240720-pmu-v4-0-2a2b28f6b08f@daynix.com>
In-Reply-To: <20240720-pmu-v4-0-2a2b28f6b08f@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::102e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102e.google.com
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

Any sysreg access results in an exception unless defined otherwise so
we should raise an exception by default.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/arm/hvf/hvf.c | 174 +++++++++++++++++++++++++--------------------------
 1 file changed, 85 insertions(+), 89 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index eb090e67a2f8..1a749534fb0d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1199,57 +1199,56 @@ static bool hvf_sysreg_read_cp(CPUState *cpu, uint32_t reg, uint64_t *val)
     return false;
 }
 
-static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt)
+static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
-    uint64_t val = 0;
 
     switch (reg) {
     case SYSREG_CNTPCT_EL0:
-        val = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
+        *val = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
               gt_cntfrq_period_ns(arm_cpu);
-        break;
+        return 0;
     case SYSREG_PMCR_EL0:
-        val = env->cp15.c9_pmcr;
-        break;
+        *val = env->cp15.c9_pmcr;
+        return 0;
     case SYSREG_PMCCNTR_EL0:
         pmu_op_start(env);
-        val = env->cp15.c15_ccnt;
+        *val = env->cp15.c15_ccnt;
         pmu_op_finish(env);
-        break;
+        return 0;
     case SYSREG_PMCNTENCLR_EL0:
-        val = env->cp15.c9_pmcnten;
-        break;
+        *val = env->cp15.c9_pmcnten;
+        return 0;
     case SYSREG_PMOVSCLR_EL0:
-        val = env->cp15.c9_pmovsr;
-        break;
+        *val = env->cp15.c9_pmovsr;
+        return 0;
     case SYSREG_PMSELR_EL0:
-        val = env->cp15.c9_pmselr;
-        break;
+        *val = env->cp15.c9_pmselr;
+        return 0;
     case SYSREG_PMINTENCLR_EL1:
-        val = env->cp15.c9_pminten;
-        break;
+        *val = env->cp15.c9_pminten;
+        return 0;
     case SYSREG_PMCCFILTR_EL0:
-        val = env->cp15.pmccfiltr_el0;
-        break;
+        *val = env->cp15.pmccfiltr_el0;
+        return 0;
     case SYSREG_PMCNTENSET_EL0:
-        val = env->cp15.c9_pmcnten;
-        break;
+        *val = env->cp15.c9_pmcnten;
+        return 0;
     case SYSREG_PMUSERENR_EL0:
-        val = env->cp15.c9_pmuserenr;
-        break;
+        *val = env->cp15.c9_pmuserenr;
+        return 0;
     case SYSREG_PMCEID0_EL0:
     case SYSREG_PMCEID1_EL0:
         /* We can't really count anything yet, declare all events invalid */
-        val = 0;
-        break;
+        *val = 0;
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
@@ -1276,9 +1275,8 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt)
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
-        if (!hvf_sysreg_read_cp(cpu, reg, &val)) {
-            hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
-            return 1;
+        if (hvf_sysreg_read_cp(cpu, reg, &val)) {
+            return 0;
         }
         break;
     case SYSREG_DBGBVR0_EL1:
@@ -1297,8 +1295,8 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt)
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
@@ -1315,8 +1313,8 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt)
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
@@ -1333,8 +1331,8 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt)
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
@@ -1351,35 +1349,25 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt)
     case SYSREG_DBGWCR13_EL1:
     case SYSREG_DBGWCR14_EL1:
     case SYSREG_DBGWCR15_EL1:
-        val = env->cp15.dbgwcr[SYSREG_CRM(reg)];
-        break;
+        *val = env->cp15.dbgwcr[SYSREG_CRM(reg)];
+        return 0;
     default:
         if (is_id_sysreg(reg)) {
             /* ID system registers read as RES0 */
-            val = 0;
-            break;
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
     }
 
-    trace_hvf_sysreg_read(reg,
-                          SYSREG_OP0(reg),
-                          SYSREG_OP1(reg),
-                          SYSREG_CRN(reg),
-                          SYSREG_CRM(reg),
-                          SYSREG_OP2(reg),
-                          val);
-    hvf_set_reg(cpu, rt, val);
-
-    return 0;
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
@@ -1503,7 +1491,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
         pmu_op_start(env);
         env->cp15.c15_ccnt = val;
         pmu_op_finish(env);
-        break;
+        return 0;
     case SYSREG_PMCR_EL0:
         pmu_op_start(env);
 
@@ -1523,45 +1511,45 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
         env->cp15.c9_pmcr |= (val & PMCR_WRITABLE_MASK);
 
         pmu_op_finish(env);
-        break;
+        return 0;
     case SYSREG_PMUSERENR_EL0:
         env->cp15.c9_pmuserenr = val & 0xf;
-        break;
+        return 0;
     case SYSREG_PMCNTENSET_EL0:
         env->cp15.c9_pmcnten |= (val & pmu_counter_mask(env));
-        break;
+        return 0;
     case SYSREG_PMCNTENCLR_EL0:
         env->cp15.c9_pmcnten &= ~(val & pmu_counter_mask(env));
-        break;
+        return 0;
     case SYSREG_PMINTENCLR_EL1:
         pmu_op_start(env);
         env->cp15.c9_pminten |= val;
         pmu_op_finish(env);
-        break;
+        return 0;
     case SYSREG_PMOVSCLR_EL0:
         pmu_op_start(env);
         env->cp15.c9_pmovsr &= ~val;
         pmu_op_finish(env);
-        break;
+        return 0;
     case SYSREG_PMSWINC_EL0:
         pmu_op_start(env);
         pmswinc_write(env, val);
         pmu_op_finish(env);
-        break;
+        return 0;
     case SYSREG_PMSELR_EL0:
         env->cp15.c9_pmselr = val & 0x1f;
-        break;
+        return 0;
     case SYSREG_PMCCFILTR_EL0:
         pmu_op_start(env);
         env->cp15.pmccfiltr_el0 = val & PMCCFILTR_EL0;
         pmu_op_finish(env);
-        break;
+        return 0;
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
@@ -1591,10 +1579,10 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
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
@@ -1612,7 +1600,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_DBGBVR14_EL1:
     case SYSREG_DBGBVR15_EL1:
         env->cp15.dbgbvr[SYSREG_CRM(reg)] = val;
-        break;
+        return 0;
     case SYSREG_DBGBCR0_EL1:
     case SYSREG_DBGBCR1_EL1:
     case SYSREG_DBGBCR2_EL1:
@@ -1630,7 +1618,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_DBGBCR14_EL1:
     case SYSREG_DBGBCR15_EL1:
         env->cp15.dbgbcr[SYSREG_CRM(reg)] = val;
-        break;
+        return 0;
     case SYSREG_DBGWVR0_EL1:
     case SYSREG_DBGWVR1_EL1:
     case SYSREG_DBGWVR2_EL1:
@@ -1648,7 +1636,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_DBGWVR14_EL1:
     case SYSREG_DBGWVR15_EL1:
         env->cp15.dbgwvr[SYSREG_CRM(reg)] = val;
-        break;
+        return 0;
     case SYSREG_DBGWCR0_EL1:
     case SYSREG_DBGWCR1_EL1:
     case SYSREG_DBGWCR2_EL1:
@@ -1666,20 +1654,18 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
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
@@ -1944,7 +1930,17 @@ int hvf_vcpu_exec(CPUState *cpu)
         int sysreg_ret = 0;
 
         if (isread) {
-            sysreg_ret = hvf_sysreg_read(cpu, reg, rt);
+            sysreg_ret = hvf_sysreg_read(cpu, reg, &val);
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


