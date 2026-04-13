Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C88F531CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 20:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCOGt-0007Uh-7m; Mon, 13 Apr 2026 16:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCOGr-0007UB-Lx
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 16:52:37 -0400
Received: from ci-2007j-snip4-4.eps.apple.com ([57.103.88.97]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCOGp-0007xH-8k
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 16:52:37 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id
 ABBF81800144; Mon, 13 Apr 2026 20:52:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776113554; x=1778705554;
 bh=zvIfYiWHwTxnV4KpRpM414Hk+noi+RK5kzhb+FHpHGM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=gxoZouze6/JuXv73tdpaCz1QJk+CcSmOuWTuuINZ08WSv9rY/d3V29A8GWSHNvH4z9cp+J0DEwiFMGsr6E7OGG8rLOqF/+paAQCLkZkxx85Y+hV8aMIQfDBSnQmRCnPAT5ANvDAJ9u6kn+zxNTN5Gjm2kF6Zpo/wqCSHsKe293wiEM5goH9HgvFgkYnqe7LIXjsZ9K78kCEwAXfOcH7U4UwsoOdYoRyHIKPzQedYlRY8ctDQwDUF65FcjblUj1aYXtMHA06WJ4OfWkwkegL0ssn+YFreGAG3vROY24bt+vrI045NmIkEeu8+WysIhfMKbgypTfcF461zurY+Pd5WKQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id
 C88421800169; Mon, 13 Apr 2026 20:52:30 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v12 13/15] whpx: i386: interrupt priority support
Date: Mon, 13 Apr 2026 22:52:05 +0200
Message-ID: <20260413205208.50643-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260413205208.50643-1-mohamed@unpredictable.fr>
References: <20260413205208.50643-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cSCQRa8c86lX2ENfa65_AeIdoota3O6t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDIwNSBTYWx0ZWRfX08vP5GdyYELX
 tEuCZXsMF5tIph3b4TAjKkK+caPfdlDPQQ3Fc0YlIyV7c6zLIDxtZ4+a+AesLNqHxygOAnwLeJ4
 KuuEQRLbCXfTZoVLAnzNDaMwhdA87chGW3C3llttnQHs4X3iyW1FYVFBo/dI0NkvNJlnz32h9mr
 9RRzzlV8MZOwJIcHlXpnNr3B8HuOCrs3hKxwCbOEIkfwY2TJAZ4T3a4cdE4xcYySiQYY1GJa4vE
 vhjuGjUhkW36ZOkP/l7/8Cl7ROnyPM97qFo3ymohf1VJ1KHnYIr/3lqYXnsvD6sNEd97Yl3MVW0
 s9R7E5Xt+T2Mp3c9zIH7qyPGsTynl/RAsSmOGC2019JP+YFKaC4Omv2palxzMg=
X-Proofpoint-GUID: cSCQRa8c86lX2ENfa65_AeIdoota3O6t
X-Authority-Info-Out: v=2.4 cv=DohbOW/+ c=1 sm=1 tr=0 ts=69dd5791
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NuKELtICf0aykZwt-QIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 clxscore=1030 mlxlogscore=620 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604130205
Received-SPF: pass client-ip=57.103.88.97;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Implement APIC IRR interrupt priorities.

Even with kernel-irqchip=off, Hyper-V is aware of interrupt priorities
and implements CR8/TPR, with the InterruptPriority field being followed.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 7a31dc6427..ae15fced0a 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1588,6 +1588,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     UINT32 reg_count = 0;
     WHV_REGISTER_VALUE reg_values[3];
     WHV_REGISTER_NAME reg_names[3];
+    int irr = apic_get_highest_priority_irr(x86_cpu->apic_state);
 
     memset(&new_int, 0, sizeof(new_int));
     memset(reg_values, 0, sizeof(reg_values));
@@ -1623,10 +1624,20 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
         }
     }
 
+    if (irr == -1) {
+        if (isa_pic != NULL && pic_get_output(isa_pic)) {
+            /* In case it's a PIC interrupt */
+            irr = 0;
+        } else if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
+            abort();
+        }
+    }
+
     /* Get pending hard interruption or replay one that was overwritten */
     if (!whpx_irqchip_in_kernel()) {
         if (!vcpu->interruption_pending &&
-            vcpu->interruptable && (env->eflags & IF_MASK)) {
+            vcpu->interruptable && (env->eflags & IF_MASK)
+            && (vcpu->tpr < irr || irr == 0)) {
             assert(!new_int.InterruptionPending);
             if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
                 cpu_reset_interrupt(cpu, CPU_INTERRUPT_HARD);
@@ -1683,13 +1694,17 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     }
 
     /* Update the state of the interrupt delivery notification */
-    if (!vcpu->window_registered &&
+    if ((!vcpu->window_registered ||
+        (vcpu->window_priority < irr && vcpu->window_priority != 0) ||
+        (irr == 0 && vcpu->window_priority != 0)) &&
         cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
         reg_values[reg_count].DeliverabilityNotifications =
             (WHV_X64_DELIVERABILITY_NOTIFICATIONS_REGISTER) {
-                .InterruptNotification = 1
+                .InterruptNotification = 1,
+                .InterruptPriority = irr >> 4
             };
         vcpu->window_registered = 1;
+        vcpu->window_priority = irr;
         reg_names[reg_count] = WHvX64RegisterDeliverabilityNotifications;
         reg_count += 1;
     }
@@ -1703,7 +1718,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
             reg_names, reg_count, reg_values);
         if (FAILED(hr)) {
             error_report("WHPX: Failed to set interrupt state registers,"
-                         " hr=%08lx", hr);
+                         " hr=%08lx, InterruptPriority=%i", hr, irr >> 4);
         }
     }
 }
@@ -1919,6 +1934,7 @@ int whpx_vcpu_run(CPUState *cpu)
         case WHvRunVpExitReasonX64InterruptWindow:
             vcpu->ready_for_pic_interrupt = 1;
             vcpu->window_registered = 0;
+            vcpu->window_priority = 0;
             ret = 0;
             break;
 
-- 
2.50.1 (Apple Git-155)


