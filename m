Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39529E88D7A
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 04:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8sUy-0006ms-QQ; Sat, 04 Apr 2026 00:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8sUv-0006hx-72
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 00:20:37 -0400
Received: from p-east2-cluster5-host2-snip4-7.eps.apple.com ([57.103.79.20]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8sUt-00065m-DL
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 00:20:36 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id
 4A3E618000BA; Sat, 04 Apr 2026 04:20:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775276434; x=1777868434;
 bh=gR8Ib7lXF8/u6lw5vo+4E3Ws12mo9iE1CDhgrlQLJb4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=J75GRisSPsqN2//DUmWq6XuUFhdd86bNUc9wWUieBP8I4L5gtNZSPZaXxfFnzxlLHDCwHPuxKnAJEslZ38rYYmIJNGbeiEecEsj4kRzh/a/OvuuY1YixrPRO/qtYRbSuCrr8UaWpZiOkKyntu47zauUXjP7PqixW3DlVX9qhRE32FOtpZPyS683nnLAsMSaECkb0eOgEgv/ZVxzTV5fdiXjbfZUNVR7iPutxER8CSc30v2z1U5gr007fQyDu6XdszL2+Cwn2Ofv9BLkBw4kzGKPKaape83AmJy2Sy9OIMH8Xw7Woh8U1tRSG7sN/FmvqNhDVfLqJqpD9OmVwmPl1Zg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id
 1FBBC180016F; Sat, 04 Apr 2026 04:20:29 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 08/11] whpx: i386: kernel-irqchip=off fixes
Date: Sat,  4 Apr 2026 06:20:12 +0200
Message-ID: <20260404042015.86580-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260404042015.86580-1-mohamed@unpredictable.fr>
References: <20260404042015.86580-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zwvKUYTFGv3MLkOOmrDquI6heT1hybuO
X-Authority-Info-Out: v=2.4 cv=J+2nLQnS c=1 sm=1 tr=0 ts=69d09190
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=csJb2AmPZwjbM2O5LjEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDAzNCBTYWx0ZWRfXytIek+2UqFI7
 OyykFb5z8hAofNlY1awP9daoH81v8IBl3zS3m4XeBB2iTQIL5B2XkcauNnYFwRKVe0SswloxiIw
 n4qsIP4hE718coJSqH5eYlzn/4N4SYBPruWOqtDJtPkAe/Jr9289KGcLnuYmP/AGSDQkVVbyxlW
 PNYyOVscYBOnKV0clt9aewf6PBvS+xiXrXJ9EE0OlQhDEpdTebe32emJW6TE5RHJLb8YUa0hcY0
 1kggIuiignjYWrX6XzYMCaxEOtiU3J2ls2RrVEtTtEClZJ2C3S84gQo5eHo5LSkvx4/A9a87L3s
 MukilbCAd1B+RUBEnhU8yr0sypVblxRlYGrVaxK1fhE99HVkvW1q/67dyzLZiY=
X-Proofpoint-GUID: zwvKUYTFGv3MLkOOmrDquI6heT1hybuO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 clxscore=1030 mlxlogscore=999 phishscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604040034
Received-SPF: pass client-ip=57.103.79.20;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This was really... quite broken. After fixing this,
Windows boots with kernel-irqchip=off.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 include/system/whpx-common.h |  1 +
 target/i386/whpx/whpx-all.c  | 54 ++++++++++--------------------------
 2 files changed, 15 insertions(+), 40 deletions(-)

diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index 04289afd97..3406c20fec 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -4,6 +4,7 @@
 
 struct AccelCPUState {
     bool window_registered;
+    int window_priority;
     bool interruptable;
     bool ready_for_pic_interrupt;
     uint64_t tpr;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 3e006496be..97284b954b 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -371,28 +371,6 @@ static int whpx_set_tsc(CPUState *cpu)
     return 0;
 }
 
-/*
- * The CR8 register in the CPU is mapped to the TPR register of the APIC,
- * however, they use a slightly different encoding. Specifically:
- *
- *     APIC.TPR[bits 7:4] = CR8[bits 3:0]
- *
- * This mechanism is described in section 10.8.6.1 of Volume 3 of Intel 64
- * and IA-32 Architectures Software Developer's Manual.
- *
- * The functions below translate the value of CR8 to TPR and vice versa.
- */
-
-static uint64_t whpx_apic_tpr_to_cr8(uint64_t tpr)
-{
-    return tpr >> 4;
-}
-
-static uint64_t whpx_cr8_to_apic_tpr(uint64_t cr8)
-{
-    return cr8 << 4;
-}
-
 void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
 {
     struct whpx_state *whpx = &whpx_global;
@@ -421,7 +399,7 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
     v86 = (env->eflags & VM_MASK);
     r86 = !(env->cr[0] & CR0_PE_MASK);
 
-    vcpu->tpr = whpx_apic_tpr_to_cr8(cpu_get_apic_tpr(x86_cpu->apic_state));
+    vcpu->tpr = cpu_get_apic_tpr(x86_cpu->apic_state);
     vcpu->apic_base = cpu_get_apic_base(x86_cpu->apic_state);
 
     idx = 0;
@@ -692,17 +670,6 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
                      hr);
     }
 
-    if (whpx_irqchip_in_kernel()) {
-        /*
-         * Fetch the TPR value from the emulated APIC. It may get overwritten
-         * below with the value from CR8 returned by
-         * WHvGetVirtualProcessorRegisters().
-         */
-        whpx_apic_get(x86_cpu->apic_state);
-        vcpu->tpr = whpx_apic_tpr_to_cr8(
-            cpu_get_apic_tpr(x86_cpu->apic_state));
-    }
-
     idx = 0;
 
     /* Indexes for first 16 registers match between HV and QEMU definitions */
@@ -751,7 +718,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
     tpr = vcxt.values[idx++].Reg64;
     if (tpr != vcpu->tpr) {
         vcpu->tpr = tpr;
-        cpu_set_apic_tpr(x86_cpu->apic_state, whpx_cr8_to_apic_tpr(tpr));
+        cpu_set_apic_tpr(x86_cpu->apic_state, tpr);
     }
 
     /* 8 Debug Registers - Skipped */
@@ -1605,6 +1572,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     UINT32 reg_count = 0;
     WHV_REGISTER_VALUE reg_values[3];
     WHV_REGISTER_NAME reg_names[3];
+    int irr = apic_get_highest_priority_irr(x86_cpu->apic_state);
 
     memset(&new_int, 0, sizeof(new_int));
     memset(reg_values, 0, sizeof(reg_values));
@@ -1643,7 +1611,8 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     /* Get pending hard interruption or replay one that was overwritten */
     if (!whpx_irqchip_in_kernel()) {
         if (!vcpu->interruption_pending &&
-            vcpu->interruptable && (env->eflags & IF_MASK)) {
+            vcpu->interruptable && (env->eflags & IF_MASK)
+            && (irr == -1 || vcpu->tpr < irr)) {
             assert(!new_int.InterruptionPending);
             if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
                 cpu_reset_interrupt(cpu, CPU_INTERRUPT_HARD);
@@ -1690,7 +1659,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
      }
 
     /* Sync the TPR to the CR8 if was modified during the intercept */
-    tpr = whpx_apic_tpr_to_cr8(cpu_get_apic_tpr(x86_cpu->apic_state));
+    tpr = cpu_get_apic_tpr(x86_cpu->apic_state);
     if (tpr != vcpu->tpr) {
         vcpu->tpr = tpr;
         reg_values[reg_count].Reg64 = tpr;
@@ -1700,13 +1669,18 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     }
 
     /* Update the state of the interrupt delivery notification */
-    if (!vcpu->window_registered &&
+    if ((!vcpu->window_registered || vcpu->window_priority < irr) &&
         cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
+        if (irr == -1) {
+            irr = 0;
+        }
         reg_values[reg_count].DeliverabilityNotifications =
             (WHV_X64_DELIVERABILITY_NOTIFICATIONS_REGISTER) {
-                .InterruptNotification = 1
+                .InterruptNotification = 1,
+                .InterruptPriority = irr
             };
         vcpu->window_registered = 1;
+        vcpu->window_priority = irr;
         reg_names[reg_count] = WHvX64RegisterDeliverabilityNotifications;
         reg_count += 1;
     }
@@ -1737,7 +1711,7 @@ static void whpx_vcpu_post_run(CPUState *cpu)
     if (vcpu->tpr != tpr) {
         vcpu->tpr = tpr;
         bql_lock();
-        cpu_set_apic_tpr(x86_cpu->apic_state, whpx_cr8_to_apic_tpr(vcpu->tpr));
+        cpu_set_apic_tpr(x86_cpu->apic_state, vcpu->tpr);
         bql_unlock();
     }
 
-- 
2.50.1 (Apple Git-155)


