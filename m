Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FC5E64004
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 02:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9DJm-0003aB-Oj; Sat, 04 Apr 2026 22:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w9DJk-0003ZJ-Og
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 22:34:28 -0400
Received: from p-east2-cluster4-host3-snip4-10.eps.apple.com ([57.103.78.141]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w9DJi-0008GB-VW
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 22:34:28 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 89E001800152; Sun, 05 Apr 2026 02:34:25 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775356466; x=1777948466;
 bh=SvZWTAGs4WR/HGAM6KHao8YretV05m393nDuH8AGBGk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Q1pJ/fZ00ZIYdGX2EWoZT5G8CK3QdM/2AnLdyvIsJr3RC9cLT1v0NQOUQ+u61VVuDlM/qhAIdA5x0CW7dX9ZZZV1QoRLzEAuINfWYYn1t7z8dTlg49DdcN0VDUXJQKPtaHa2zwBQHQJYiZg5QM66ftVESSp3oBFkwudAy+nMHnuV+IdkbA5rvsEWwfD63CtXsWB+UVfwsq9uWHsqMwDa4TTs8gSbIvv/K4FeZ68r/qDCoy7FB536k5iu9c+1jxJTrAUvhWHx313gPF57KQHC+SgyI4uysp+9SC6tI3nVgvaSRy99ncV5wEnWPSmDF/i1v8fLQjqOkdRlIJxeqYB6jQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 1191A1800154; Sun, 05 Apr 2026 02:34:23 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v7 08/11] whpx: i386: kernel-irqchip=off fixes
Date: Sun,  5 Apr 2026 04:34:06 +0200
Message-ID: <20260405023409.23142-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260405023409.23142-1-mohamed@unpredictable.fr>
References: <20260405023409.23142-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=B+u0EetM c=1 sm=1 tr=0 ts=69d1ca31
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gP1GEkNOX-MqffGxZ4oA:9
X-Proofpoint-GUID: csKSt6E3BgcYt1PuHuSMa7593zB1OAYL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDAyNCBTYWx0ZWRfX7o+zi7wgX27a
 Hmr3cwPRKSqnCXcCzfirWex68z564lE2Rp5s6shPbqP6ZJSgjZJknpVTWX6mCDxVrv8eLc/i75W
 GYKFLF5yELXhQOX7Eyam74/UGX1cXwxDg5Ym0E15VdNSWoqAlH4X3cV13QCCX+6ZJxS29ySbIqE
 XsV4Hv/YmsGxrRUS+7qrrFhYJ3rO3gy8Nivi9AvP0HDwHH1OD9Eh066SJGKukmYsvXIKxmqKDUm
 As/Xtqu86M7WYrbF2ebutU9S+Z6TV/VsSMKSnRyYEVTwDSpHKhADt9xsXAH0qs0aJDiydDjz5Fp
 jsW91pwvz94njEwaeGZlwYHFOr2pf4K/h7mfhP/7334kjvq0K7Uvay1/63Quhc=
X-Proofpoint-ORIG-GUID: csKSt6E3BgcYt1PuHuSMa7593zB1OAYL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604050024
Received-SPF: pass client-ip=57.103.78.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 target/i386/whpx/whpx-all.c  | 43 +++++-------------------------------
 2 files changed, 7 insertions(+), 37 deletions(-)

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
index 735ab920a6..11d36e0518 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -22,6 +22,8 @@
 #include "qemu/main-loop.h"
 #include "hw/core/boards.h"
 #include "hw/intc/ioapic.h"
+#include "hw/intc/i8259.h"
+#include "hw/i386/x86.h"
 #include "hw/i386/apic_internal.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -371,28 +373,6 @@ static int whpx_set_tsc(CPUState *cpu)
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
@@ -421,7 +401,7 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
     v86 = (env->eflags & VM_MASK);
     r86 = !(env->cr[0] & CR0_PE_MASK);
 
-    vcpu->tpr = whpx_apic_tpr_to_cr8(cpu_get_apic_tpr(x86_cpu->apic_state));
+    vcpu->tpr = cpu_get_apic_tpr(x86_cpu->apic_state);
     vcpu->apic_base = cpu_get_apic_base(x86_cpu->apic_state);
 
     idx = 0;
@@ -692,17 +672,6 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
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
@@ -751,7 +720,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
     tpr = vcxt.values[idx++].Reg64;
     if (tpr != vcpu->tpr) {
         vcpu->tpr = tpr;
-        cpu_set_apic_tpr(x86_cpu->apic_state, whpx_cr8_to_apic_tpr(tpr));
+        cpu_set_apic_tpr(x86_cpu->apic_state, tpr);
     }
 
     /* 8 Debug Registers - Skipped */
@@ -1690,7 +1659,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
      }
 
     /* Sync the TPR to the CR8 if was modified during the intercept */
-    tpr = whpx_apic_tpr_to_cr8(cpu_get_apic_tpr(x86_cpu->apic_state));
+    tpr = cpu_get_apic_tpr(x86_cpu->apic_state);
     if (tpr != vcpu->tpr) {
         vcpu->tpr = tpr;
         reg_values[reg_count].Reg64 = tpr;
@@ -1737,7 +1706,7 @@ static void whpx_vcpu_post_run(CPUState *cpu)
     if (vcpu->tpr != tpr) {
         vcpu->tpr = tpr;
         bql_lock();
-        cpu_set_apic_tpr(x86_cpu->apic_state, whpx_cr8_to_apic_tpr(vcpu->tpr));
+        cpu_set_apic_tpr(x86_cpu->apic_state, vcpu->tpr);
         bql_unlock();
     }
 
-- 
2.50.1 (Apple Git-155)


