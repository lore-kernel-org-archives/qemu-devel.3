Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8263FF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABTq-0004zB-Dv; Tue, 07 Apr 2026 14:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wABSZ-0002em-VB
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:47:36 -0400
Received: from p-east2-cluster2-host2-snip4-5.eps.apple.com ([57.103.78.18]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wA8Bj-0002EA-Nc
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 11:18:02 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPS id
 8B34B18013F4; Tue, 07 Apr 2026 15:17:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775575078; x=1778167078;
 bh=9UzhbHGn3KNjJvwbSrpYXcynAdkRNKmx/7n4duVcxcA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=dHJJoHjBPCr9MaUZrY/DJuZcRMXhlrQPUpHEto6B9rxFhuV5tLHrS2yCg7LmVJkOWAw6QMdopMZzTjhpM6l+h0234npPPdkuE4LObYLVgvIg+okH5KjijrZ1v9IkMX4iycPFW5PlAKL8SjOx/3lW/8IFGRBHyZMmrRbuAFIvniNKYnbLcPRRSunLOGHKkHfSSI+1cFRnaLcuhxP90UFFEf4WU8PAl9BNL9iZ1+T1XE+1Fq9KzDjQQf2UqkmDb9x+Tx6v3iyR7EzwEGbo5eRw9nDhZ9q/zhFl9C5PSFq7YroEKusKw5u+pgskgFJKgzeQ21+gGxfhkZR2IHjOV8M3LA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPSA id
 795BC1800CBD; Tue, 07 Apr 2026 15:17:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v9 09/13] whpx: i386: use WHvX64RegisterCr8 only when
 kernel-irqchip=off
Date: Tue,  7 Apr 2026 17:17:03 +0200
Message-ID: <20260407151707.46536-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260407151707.46536-1-mohamed@unpredictable.fr>
References: <20260407151707.46536-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0MCBTYWx0ZWRfX4YN7I9aJMhtx
 FBLxTWULHWQKaBFJgzd40IF21wXFrU1j6QRFdM24/h+xDLA8G5pz7K1oS6Ct875BJE0naw1jWFN
 owfL+N65X8UiVV5PXP7fN3phdFMwbbCx6Pwy1bohSsjlMzkY2H7YNm2Q73N1M7YLCjc1Y2gUmnm
 4xjLm3h03ozQHyxUFd7tkGYk5vlA8TwJzUH5BS8hmL+nBqLsFMY2nWfx8aL0YGffYwtYMBb17Rl
 0jF7kA/FUJt58RkhCIW8s2useHFtIen/RPTNSgcY/CWXc4MUNCEQHJEg5n8Ld4b4gvbqsolFLHg
 qu/yVq8Chlp02oCjWUr8Wf0O2bft2vQqAWV6rHQyGmWmiB2XoMaSUqxJm2tQgs=
X-Proofpoint-ORIG-GUID: IDoR2bJ87a_SONTBaRa5Fn0MdTTgTkNs
X-Proofpoint-GUID: IDoR2bJ87a_SONTBaRa5Fn0MdTTgTkNs
X-Authority-Info-Out: v=2.4 cv=HYgZjyE8 c=1 sm=1 tr=0 ts=69d52025
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=4IdwVP5-j8YZXVcKM5MA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0 clxscore=1030 suspectscore=0 mlxlogscore=866
 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604070140
Received-SPF: pass client-ip=57.103.78.18;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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

When kernel-irqchip=on, manage TPR as part of the APIC state instead entirely.

This fixes some failure to set state errors.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 62542922a4..74b94b799e 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -95,7 +95,6 @@ static const WHV_REGISTER_NAME whpx_register_names[] = {
     WHvX64RegisterCr2,
     WHvX64RegisterCr3,
     WHvX64RegisterCr4,
-    WHvX64RegisterCr8,
 
     /* X64 Debug Registers */
     /*
@@ -459,8 +458,11 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
         vcxt.values[idx++].Reg64 = env->cr[3];
         assert(whpx_register_names[idx] == WHvX64RegisterCr4);
         vcxt.values[idx++].Reg64 = env->cr[4];
-        assert(whpx_register_names[idx] == WHvX64RegisterCr8);
-        vcxt.values[idx++].Reg64 = vcpu->tpr;
+        /* For kernel-irqchip=on, TPR is managed as part of APIC state */
+        if (!whpx_irqchip_in_kernel()) {
+            WHV_REGISTER_VALUE cr8 = {.Reg64 = vcpu->tpr};
+            whpx_set_reg(cpu, WHvX64RegisterCr8, cr8);
+        }
 
         /* 8 Debug Registers - Skipped */
 
@@ -716,11 +718,14 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
     env->cr[3] = vcxt.values[idx++].Reg64;
     assert(whpx_register_names[idx] == WHvX64RegisterCr4);
     env->cr[4] = vcxt.values[idx++].Reg64;
-    assert(whpx_register_names[idx] == WHvX64RegisterCr8);
-    tpr = vcxt.values[idx++].Reg64;
-    if (tpr != vcpu->tpr) {
-        vcpu->tpr = tpr;
-        cpu_set_apic_tpr(x86_cpu->apic_state, tpr);
+
+    /* For kernel-irqchip=on, TPR is managed as part of APIC state */
+    if (!whpx_irqchip_in_kernel()) {
+        tpr = vcpu->exit_ctx.VpContext.Cr8;
+        if (tpr != vcpu->tpr) {
+            vcpu->tpr = tpr;
+            cpu_set_apic_tpr(x86_cpu->apic_state, tpr);
+        }
     }
 
     /* 8 Debug Registers - Skipped */
@@ -1660,7 +1665,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
 
     /* Sync the TPR to the CR8 if was modified during the intercept */
     tpr = cpu_get_apic_tpr(x86_cpu->apic_state);
-    if (tpr != vcpu->tpr) {
+    if (!whpx_irqchip_in_kernel() && tpr != vcpu->tpr) {
         vcpu->tpr = tpr;
         reg_values[reg_count].Reg64 = tpr;
         qatomic_set(&cpu->exit_request, true);
@@ -1702,12 +1707,14 @@ static void whpx_vcpu_post_run(CPUState *cpu)
 
     env->eflags = vcpu->exit_ctx.VpContext.Rflags;
 
-    uint64_t tpr = vcpu->exit_ctx.VpContext.Cr8;
-    if (vcpu->tpr != tpr) {
-        vcpu->tpr = tpr;
-        bql_lock();
-        cpu_set_apic_tpr(x86_cpu->apic_state, vcpu->tpr);
-        bql_unlock();
+    if (!whpx_irqchip_in_kernel()) {
+        uint64_t tpr = vcpu->exit_ctx.VpContext.Cr8;
+        if (vcpu->tpr != tpr) {
+            vcpu->tpr = tpr;
+            bql_lock();
+            cpu_set_apic_tpr(x86_cpu->apic_state, vcpu->tpr);
+            bql_unlock();
+        }
     }
 
     vcpu->interruption_pending =
-- 
2.50.1 (Apple Git-155)


