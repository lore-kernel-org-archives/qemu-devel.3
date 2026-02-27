Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377DBFD530A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 19:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw3Af-0003Fs-Np; Fri, 27 Feb 2026 14:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vw3AW-0003E5-HF
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:06:32 -0500
Received: from p-west2-cluster3-host9-snip4-9.eps.apple.com ([57.103.69.72]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vw3AU-0006R2-AY
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:06:31 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id
 25BD718000A6; Fri, 27 Feb 2026 19:06:25 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772219186; x=1774811186;
 bh=4n4xIy8i5xV9kHLwKpAQhwfVxRJH3sNm66Cv+vgl914=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=beeRE0hzMf6oj5ZjM4lMbOqFCOJONdwUBBIjRXcoAHeB+wSRdiFFkkHKP7fyxZ9VxiUfF2a6KOqs3CXOTtRxSufw2RWfrmVjG2fwUS78qagM01eUFabUJuxZMfXo/tmRFPsbz3cIBb/liHZBq3UU7DcnRXZro8LTjU00APbvViAF8ZRDyMrNLZZ+qItzuPvzgSfTYOw1gsKQpBfr2iqkj4fGPltcPdWsGNPr3d4GOpzklqpGxZ4jhM9slYxQChxHkLUKHpPCJhUJryLKQaWmmo4GimuVkXIg5KtI3P2NbTqpDMYW8SOqrjmU7kNzhE/FRYt3Ssyj5ssBo4/xDVXnUQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id
 C64161800171; Fri, 27 Feb 2026 19:06:23 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH 1/4] whpx: i386: move whpx_vcpu_kick_out_of_hlt() invocation
 to interrupt raise time
Date: Fri, 27 Feb 2026 20:06:16 +0100
Message-ID: <20260227190619.8867-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260227190619.8867-1-mohamed@unpredictable.fr>
References: <20260227190619.8867-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE2OCBTYWx0ZWRfX5+4bJ0qZxnOm
 NCALgzMTKGkJl0hreC+5JIyAhD33ijcl6UCPs33dSte3qkqoa7xfitsWWRvysMDP8VVFiKj8/sV
 gFUn1WzS6ud/RQktS3h+Hjt7rJVCYqpAVT04uTzoimdruka+/wVIq+y7JSjIRlgyN2tVz3pHQbQ
 KAdkukaY2om0nvOh7FR3kDyVfBjVa4hR9LEvAlkUx83jUuPC5Jg9RRulzVCY0TB5SGDwBZ1hWlm
 N4Odcf3BCWouRqce9ilMr8Z4UnaPsb4X//TmYF+OeUMWp3chTZtAP6WfH358xElZ/8z4i+ZLbHc
 GkSWrUBAhYsrAVxK5E9dLxfxF5GKrQwiICim+6Sa2TgpKwCyGg7KtIiPb6s62I=
X-Proofpoint-GUID: wYGUP3lI72CoypRWrWwvwlLaeNNcRrfC
X-Authority-Info-Out: v=2.4 cv=RYadyltv c=1 sm=1 tr=0 ts=69a1eb31
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=o8I7T96M5UCSVa1h564A:9
X-Proofpoint-ORIG-GUID: wYGUP3lI72CoypRWrWwvwlLaeNNcRrfC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1030 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602270168
X-JNJ: AAAAAAABVP2HDaZOd/r5FMXVj76K5HmnFbFheYm7kgnW4MIfRrpy9RUN0bccWc9po2/nPAzMv5rTz1KUENJTUzM6NuFYKX6jBTDQELK0hZNvEJjgGN8LglQMjcc/qSR0EqYIVViJR4FUEfJXDj2alrHDZZ1q9McGsaKnv06+BxUeluyQcwSdIHy5BqobUxrFdUpyh5ezp8he/HzvShv7QZLjluA7sbfAauecIsqmg98m3mhjGOM9JcSLWb1czhnI/amzMGZ/glgh8P5Q4RE0qbrBy9Vc4JsatnT3phHP1c2mYvTkC0epf1GKvA1oWKh0Qcz8BGu23XySmx5Jw9E4TLw2YipwNM+OHTnpdlerrSnwrFAgAMkw7cIgoKPfCp+KvCOb6TAlMDvVm4FBI49QQVEdBmQS4WloMfa7L7nMxx7DvM/MxOC79pMOnIuezlO5uBGauIrc32BARFoI+JKHx7EqVklSg1WLtlo1+oEd9TaKISDmlFFr4EsMHccWofJZbAnf64p9Jckc5mTui+fiUlMGH1VK7PzmoSq9P+TezLyp5gA698PlPS/CPiWtHb0pngUEsnABHcK+YBe9D2CFovPw0INRzUhoFYe4m/TY29HJfOCKFBI2/G176eD17gxminlH5bzDioY=
Received-SPF: pass client-ip=57.103.69.72;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This fixes the sti followed by hlt kvm_unit_tests.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 49 ++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 6d2771a98a..90f51fc4dd 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1308,6 +1308,16 @@ static int whpx_handle_halt(CPUState *cpu)
     return ret;
 }
 
+static void whpx_vcpu_kick_out_of_hlt(CPUState *cpu) 
+{
+    WHV_REGISTER_VALUE reg;
+    whpx_get_reg(cpu, WHvRegisterInternalActivityState, &reg);
+    if (reg.InternalActivity.HaltSuspend) {
+        reg.InternalActivity.HaltSuspend = 0;
+        whpx_set_reg(cpu, WHvRegisterInternalActivityState, reg);
+    }
+}
+
 static void whpx_vcpu_pre_run(CPUState *cpu)
 {
     HRESULT hr;
@@ -1391,6 +1401,17 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
                 .Vector = irq,
             };
             reg_count += 1;
+            /* 
+             * When the Hyper-V APIC is enabled, to get out of HLT we
+             * either have to request an interrupt or manually get it away
+             * from HLT.
+             *
+             * We also manually do inject some interrupts via WHvRegisterPendingEvent
+             * instead of WHVRequestInterrupt, which does not reset the HLT state.
+             */
+            if (whpx_irqchip_in_kernel()) {
+                whpx_vcpu_kick_out_of_hlt(cpu);
+            }
         }
      }
 
@@ -1453,15 +1474,6 @@ static void whpx_vcpu_post_run(CPUState *cpu)
         !vcpu->exit_ctx.VpContext.ExecutionState.InterruptShadow;
 }
 
-static void whpx_vcpu_kick_out_of_hlt(CPUState *cpu) 
-{
-    WHV_REGISTER_VALUE reg;
-    whpx_get_reg(cpu, WHvRegisterInternalActivityState, &reg);
-    if (reg.InternalActivity.HaltSuspend) {
-        reg.InternalActivity.HaltSuspend = 0;
-        whpx_set_reg(cpu, WHvRegisterInternalActivityState, reg);
-    }
-}
 
 static void whpx_vcpu_process_async_events(CPUState *cpu)
 {
@@ -1770,25 +1782,6 @@ int whpx_vcpu_run(CPUState *cpu)
                 cpu->exception_index = EXCP_INTERRUPT;
                 ret = 1;
             }
-            /* 
-             * When the Hyper-V APIC is enabled, to get out of HLT we
-             * either have to request an interrupt or manually get it away
-             * from HLT.
-             *
-             * We also manually do inject some interrupts via WHvRegisterPendingEvent
-             * instead of WHVRequestInterrupt, which does not reset the HLT state.
-             *
-             * However, even with this done, if the guest does an HLT without
-             * interrupts enabled (which the test_sti_inhibit KVM unit test does)
-             * then the guest will stay in HLT forever.
-             *
-             * Keep it this way for now, with perhaps adding a heartbeat later
-             * so that we get the CPU time savings from having Hyper-V handle HLT
-             * instead of going away from it as soon as possible.
-             */
-            if (whpx_irqchip_in_kernel()) {
-                whpx_vcpu_kick_out_of_hlt(cpu);
-            }
             break;
         case WHvRunVpExitReasonX64MsrAccess: {
             WHV_REGISTER_VALUE reg_values[3] = {0};
-- 
2.50.1 (Apple Git-155)


