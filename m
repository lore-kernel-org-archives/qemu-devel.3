Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB27F34C63
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 16:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCKXG-0006rt-Ji; Mon, 13 Apr 2026 12:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCKXE-0006rO-3l
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:53:16 -0400
Received: from p-west2-cluster3-host11-snip4-10.eps.apple.com ([57.103.69.33]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCKXC-0005W4-A7
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:53:15 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 4E7131800EAF; Mon, 13 Apr 2026 16:53:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776099193; x=1778691193;
 bh=T/ylQnS/te0fMXN5QyRAvae93avWDOZqU0zT/KgDwLQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=CBpRPMH/yDMjN0ATuKXdftkQ99v0L1mLJJQoCsfEOMYQjdM6UEE46Mh+HZqn5lGC+nV7A8sTbChpexfPMnY8sxPqaoiTMU0pYJihNmzWPXYF0JZWvOG7M3YYhXY2sKeQZHZxa+5ymKvsqyEHUF/uWwduLJicBhpcZKWaOa8qbtBBxYg9HNJtO3l04HbCzZ/cZhKCbt1WLx/qQ7a58TCYkludrQGh/I4RCERRRKzR+6q242tWHK//yqBUONA+SL0TaYhnJDhcBBq0gkmz/XatZyYI6gmtPumHZ54vG+5R4KAnljrWqWaOK8t/vKQyGuz7ghyljC4bsBNe+ULhqZe/Cw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 C36371800843; Mon, 13 Apr 2026 16:53:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v11 08/15] whpx: i386: kernel-irqchip=off fixes
Date: Mon, 13 Apr 2026 18:52:10 +0200
Message-ID: <20260413165217.47105-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260413165217.47105-1-mohamed@unpredictable.fr>
References: <20260413165217.47105-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MeGrepLLuzY9JqL3MhR3INHZAD0IT3lV
X-Authority-Info-Out: v=2.4 cv=QsdTHFyd c=1 sm=1 tr=0 ts=69dd1f78
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gP1GEkNOX-MqffGxZ4oA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE2NiBTYWx0ZWRfX8+JnFz+38QRS
 rE2vP/GWgIIH/0/UZyZO+dhW8Ug1K7gthAk8KhoMyWV0EzCeQuACIFqqmltkTws1fAmPeE9qVjU
 rYU7ZhjNYpOIJua3Dv/7fy/aLjmjn/eqw5jvDep9IPv+Dyu0Q9mceyPiymfmEWg0EpvAxYI2aT2
 guD20DJcVidD0YTEtsps1MpfvsN6iazLRcC5nSf53ABbxZ+gYlsLG2dL1jFKXj53NJSdtcsmvy0
 BT66cAfYKMMzjwGb1at9kI6IwBP5XGqhGnHBlLpLdsCgYv+QpVxYoCck3d5jwzNPuhyyEyyhL2m
 zoQW04+Hc4RJ0XvH0bxdwxkaOzG7RrbTOpy38XEfechO7HoaBYL+vw4ba7x6Rs=
X-Proofpoint-GUID: MeGrepLLuzY9JqL3MhR3INHZAD0IT3lV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0
 adultscore=0 clxscore=1030 mlxscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130166
Received-SPF: pass client-ip=57.103.69.33;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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
index 9827c93df1..62542922a4 100644
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


