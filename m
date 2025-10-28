Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC90CCF9EA
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 00:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDtR6-0001yz-CM; Tue, 28 Oct 2025 19:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtR3-0001vz-4U
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:06 -0400
Received: from p-east1-cluster5-host12-snip4-1.eps.apple.com ([57.103.89.242]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtQi-0004lu-Pr
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:02 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPS id
 A1D581801586; Tue, 28 Oct 2025 23:48:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=nyMGJmQjId70qlaUiH6zAOIIYOqu5rfF47Fw0gYjees=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=WdlX2/IgVGlDPXcYeS+c+LZVg5mogOvILSp1o1M+6CUkuN/sfp1V3VK9xDkVpY0h7wmxlz8+0UQrGwTW7rbk/85bcRypdNBzlAHG7OmiJlpgjSJLetrnMNEL8b/B7qG3mYhINRTxgmLEH2i0XUCDe51ZuD8JkPgd13HYTkomI4hLUlh64Ijt1QCiW48nBz2zQWXO3DTXUudRI+eX2wQjUvELqu2zMqJfclKgwdc2FDCJALKGuy8MyaVXT+27LLosQN6jHD1SGvcD98osq7ndHCCOC5SnzJxY/v/jnGNOL1d7QIw8L15IVKF6IHotge21wDgFWb7h2BBBvue8tB9uhg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPSA id
 7118E18034DB; Tue, 28 Oct 2025 23:48:28 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v9 10/27] hw, target,
 accel: whpx: change apic_in_platform to kernel_irqchip
Date: Wed, 29 Oct 2025 00:47:40 +0100
Message-ID: <20251028234757.39609-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028234757.39609-1-mohamed@unpredictable.fr>
References: <20251028234757.39609-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDIwMiBTYWx0ZWRfXwkfPjZZ4mPVV
 9y7EL1WmdOB5xXxVP52uq6szOib5LS2I6DX8cRCXbS4xIK2hHYtkqKEGD7WAZcCQV28ITxPEwEa
 ayBbCoKLYvwxPcxFZeu8+4lQYoWV3eyVP+/otZ9nZ+r8sseQTXgxVNLmHvuXEtquZWrdVJPxUGq
 7G2ExZfi3Jnl8jwY7c0tYGQiEfBM6DfcldFmMKQ/K5mx8+R7bl61uAzPFL6wPzt5HmtN3lkXlqf
 XO4F4Zi/3tBtzmm1DVR0x6IXROkhwT/964mHYuFs6kV5+P9VPZDwJPl/Mw48fAZ5vpcudqr6Gqr
 qWsjmEoeTFXRGVE63rF
X-Proofpoint-ORIG-GUID: FpVnLkmC1HcIWZ77s8RgMUA2Ox3Voo7M
X-Authority-Info: v=2.4 cv=OpFCCi/t c=1 sm=1 tr=0 ts=6901564f cx=c_apl:c_pps
 a=2G65uMN5HjSv0sBfM2Yj2w==:117 a=2G65uMN5HjSv0sBfM2Yj2w==:17
 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=ogbMO5OAvhA2mBZm2BUA:9
 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: FpVnLkmC1HcIWZ77s8RgMUA2Ox3Voo7M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 adultscore=0
 mlxlogscore=966 clxscore=1030 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2509250000 definitions=main-2510280202
X-JNJ: AAAAAAABIK3Orl7mlo0Q7XVaMMqlUGXFg56PO7vXAfQ5NE1kCZbhqJuHbIJO1v/+7qtqfTYFh6gBm881pntlmIiZI7bcuDpg6kKWHN33yvXlxuxFiH3l5tcgGXVeRxc3/d4vMz5H8tjKvhd4sM8qq/0XF5ABUUN/V8XWxrA5ZowcON2VWZX22CizCSQiWILr3x4BImqxU7U2yIAMDW0fdZy14feU/3gSL3FuE39ihRkC1G0J7lLOEpZl0w+QH5YrlFrVORohRhFWbFGf5nWDqdttbqoKDY/MSpGLT5XCRal7eJa2Q/9JCit6ChzBsowYFDkOci+zbhi0agAQqUerkAVwApzpHiX19P56XVkE+YAcX9Ugc9dFf7Qq7FjJrdfP+BRKyOy3UO1HX4tm33VgkkjlDCRokRNKA4NSbC8R/vBc9Wfm7vNeKptJaNsfDO5eqi4lwnIwN8Vyl7Qluk4cMZu5E15b4OflGh9/c4Hp3x2tAk87N13wegkp9izs/W1ct6XDbg8RVodUMLbfMMiIB7Grl7fANj9FEDfSR8EtWZSGuqm8CMjd4qL6HXnE1IesD2G69eOL3yHfBDOhtHXA7VC5iGC9LF/+JFxAIOO07sy3YHIUfMQlyqouYn0B3C4BLpgRkg1FkU746cZJQvM3krHDbQgj3wU8Q3Ilgs0rYzIqh6A1leLG3+q6yN8X7iyUBELijVqqRHEZEZvElgMtAey0jKo5TRoPNaa9CVbL9/TC1BLwlwcn2FAfVohiw7LZgz+vkZcA4TNbguyeHrS9UvhN68bND0NwbwF622QaeiHCdRl+
Received-SPF: pass client-ip=57.103.89.242;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Change terminology to match the KVM one, as APIC is x86-specific.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/whpx/whpx-accel-ops.c    |  2 +-
 accel/whpx/whpx-common.c       |  4 ++--
 hw/i386/x86-cpu.c              |  4 ++--
 include/system/whpx-internal.h |  2 +-
 include/system/whpx.h          |  4 ++--
 target/i386/cpu-apic.c         |  2 +-
 target/i386/whpx/whpx-all.c    | 14 +++++++-------
 7 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/accel/whpx/whpx-accel-ops.c b/accel/whpx/whpx-accel-ops.c
index c84a25c273..50fadea0fd 100644
--- a/accel/whpx/whpx-accel-ops.c
+++ b/accel/whpx/whpx-accel-ops.c
@@ -78,7 +78,7 @@ static void whpx_kick_vcpu_thread(CPUState *cpu)
 
 static bool whpx_vcpu_thread_is_idle(CPUState *cpu)
 {
-    return !whpx_apic_in_platform();
+    return !whpx_irqchip_in_kernel();
 }
 
 static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index c0ff6cacb8..18d93225c1 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -496,9 +496,9 @@ static const TypeInfo whpx_cpu_accel_type = {
  * Partition support
  */
 
-bool whpx_apic_in_platform(void)
+bool whpx_irqchip_in_kernel(void)
 {
-    return whpx_global.apic_in_platform;
+    return whpx_global.kernel_irqchip;
 }
 
 static void whpx_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/i386/x86-cpu.c b/hw/i386/x86-cpu.c
index 1a86a853d5..aee7fc76f5 100644
--- a/hw/i386/x86-cpu.c
+++ b/hw/i386/x86-cpu.c
@@ -45,7 +45,7 @@ static void pic_irq_request(void *opaque, int irq, int level)
 
     trace_x86_pic_interrupt(irq, level);
     if (cpu_is_apic_enabled(cpu->apic_state) && !kvm_irqchip_in_kernel() &&
-        !whpx_apic_in_platform()) {
+        !whpx_irqchip_in_kernel()) {
         CPU_FOREACH(cs) {
             cpu = X86_CPU(cs);
             if (apic_accept_pic_intr(cpu->apic_state)) {
@@ -71,7 +71,7 @@ int cpu_get_pic_interrupt(CPUX86State *env)
     X86CPU *cpu = env_archcpu(env);
     int intno;
 
-    if (!kvm_irqchip_in_kernel() && !whpx_apic_in_platform()) {
+    if (!kvm_irqchip_in_kernel() && !whpx_irqchip_in_kernel()) {
         intno = apic_get_interrupt(cpu->apic_state);
         if (intno >= 0) {
             return intno;
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 4565436682..81c0c1819f 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -44,7 +44,7 @@ struct whpx_state {
 
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
-    bool apic_in_platform;
+    bool kernel_irqchip;
 };
 
 extern struct whpx_state whpx_global;
diff --git a/include/system/whpx.h b/include/system/whpx.h
index 00f6a3e523..98fe045ba1 100644
--- a/include/system/whpx.h
+++ b/include/system/whpx.h
@@ -26,10 +26,10 @@
 #ifdef CONFIG_WHPX_IS_POSSIBLE
 extern bool whpx_allowed;
 #define whpx_enabled() (whpx_allowed)
-bool whpx_apic_in_platform(void);
+bool whpx_irqchip_in_kernel(void);
 #else /* !CONFIG_WHPX_IS_POSSIBLE */
 #define whpx_enabled() 0
-#define whpx_apic_in_platform() (0)
+#define whpx_irqchip_in_kernel() (0)
 #endif /* !CONFIG_WHPX_IS_POSSIBLE */
 
 #endif /* QEMU_WHPX_H */
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index 564c1288e4..c0492035b8 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -32,7 +32,7 @@ APICCommonClass *apic_get_class(Error **errp)
         apic_type = "kvm-apic";
     } else if (xen_enabled()) {
         apic_type = "xen-apic";
-    } else if (whpx_apic_in_platform()) {
+    } else if (whpx_irqchip_in_kernel()) {
         apic_type = "whpx-apic";
     }
 
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index d1f8e49cb2..feabbec427 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -607,7 +607,7 @@ void whpx_get_registers(CPUState *cpu)
                      hr);
     }
 
-    if (whpx_apic_in_platform()) {
+    if (whpx_irqchip_in_kernel()) {
         /*
          * Fetch the TPR value from the emulated APIC. It may get overwritten
          * below with the value from CR8 returned by
@@ -749,7 +749,7 @@ void whpx_get_registers(CPUState *cpu)
 
     assert(idx == RTL_NUMBER_OF(whpx_register_names));
 
-    if (whpx_apic_in_platform()) {
+    if (whpx_irqchip_in_kernel()) {
         whpx_apic_get(x86_cpu->apic_state);
     }
 
@@ -1379,7 +1379,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     }
 
     /* Get pending hard interruption or replay one that was overwritten */
-    if (!whpx_apic_in_platform()) {
+    if (!whpx_irqchip_in_kernel()) {
         if (!vcpu->interruption_pending &&
             vcpu->interruptable && (env->eflags & IF_MASK)) {
             assert(!new_int.InterruptionPending);
@@ -1552,7 +1552,7 @@ int whpx_vcpu_run(CPUState *cpu)
 
     if (exclusive_step_mode == WHPX_STEP_NONE) {
         whpx_vcpu_process_async_events(cpu);
-        if (cpu->halted && !whpx_apic_in_platform()) {
+        if (cpu->halted && !whpx_irqchip_in_kernel()) {
             cpu->exception_index = EXCP_HLT;
             qatomic_set(&cpu->exit_request, false);
             return 0;
@@ -1641,7 +1641,7 @@ int whpx_vcpu_run(CPUState *cpu)
             break;
 
         case WHvRunVpExitReasonX64ApicEoi:
-            assert(whpx_apic_in_platform());
+            assert(whpx_irqchip_in_kernel());
             ioapic_eoi_broadcast(vcpu->exit_ctx.ApicEoi.InterruptVector);
             break;
 
@@ -2186,7 +2186,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
                 goto error;
             }
         } else {
-            whpx->apic_in_platform = true;
+            whpx->kernel_irqchip = true;
         }
     }
 
@@ -2195,7 +2195,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     prop.ExtendedVmExits.X64MsrExit = 1;
     prop.ExtendedVmExits.X64CpuidExit = 1;
     prop.ExtendedVmExits.ExceptionExit = 1;
-    if (whpx_apic_in_platform()) {
+    if (whpx_irqchip_in_kernel()) {
         prop.ExtendedVmExits.X64ApicInitSipiExitTrap = 1;
     }
 
-- 
2.50.1 (Apple Git-155)


