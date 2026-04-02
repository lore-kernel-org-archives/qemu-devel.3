Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D096DD3940B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Ew6-0006xE-CO; Thu, 02 Apr 2026 06:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8Evs-0006q7-LN
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:05:50 -0400
Received: from qs-2004g-snip4-8.eps.apple.com ([57.103.84.71]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8Evo-0003mn-Fm
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:05:48 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-1 (Postfix) with ESMTPS id
 1BB923000139; Thu, 02 Apr 2026 10:05:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775124343; x=1777716343;
 bh=GLvxS3ZXniVWZSo6nScZk1ySvLSYx1kbrzXjMB1npTo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=AWR8xgWaZghBhzw/siuPqqfp7MTX9Z9YMq3vdzmG7Xi+knB1sBWX01Mm7pFNxtjV2uBC15hahF3DAuRG5bDDlwYL/0OAsSR2cnMfF0ba0IYGIxwStjzWoL/S7xyOLS0eBsM8ksEG+gBcs9KnbgFPeT642XYHegSuyfZ3uVV2syM2Rb2olEAmpfnho+p0V8o7F7/V0g1PwZCj5wiJIMqvcCfffsCbkBSM5EFWLhdzj4Eg48AAIQBg7N8BPykmV/486ZrrtRfezg+SwG6+ULyjcJthb5R4wEV9N4/QmnsI6b3edEC6I/55ekGAkoJMriOZhI79FFIJua6cPInsw90ZLA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-1 (Postfix) with ESMTPSA id
 9F72F30000AF; Thu, 02 Apr 2026 10:05:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH 2/2] whpx: i386: reintroduce enlightenments for Windows 10
Date: Thu,  2 Apr 2026 12:05:35 +0200
Message-ID: <20260402100535.42960-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402100535.42960-1-mohamed@unpredictable.fr>
References: <20260402100535.42960-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4Oyofk0OczscGxahp1QHjl9DsdsdxQuf
X-Authority-Info-Out: v=2.4 cv=GMsF0+NK c=1 sm=1 tr=0 ts=69ce3f75
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7Tkn1UfjudUksutfP3gA:9
X-Proofpoint-ORIG-GUID: 4Oyofk0OczscGxahp1QHjl9DsdsdxQuf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5MCBTYWx0ZWRfXyHu52Jk7k3O6
 ohC1Wh/U1CVHw8sHAsbhPsFKyQ2Y94s6QoEaj32bgWOLxPFM66HeNf95u23MonHQ9Fe9n9QkmCw
 jwpl9JEoTy6jAaEqAil5ZcJ4zEIc2/auxc/0kSramG4KAA425RAiHdh1Ee5SXvdrLZnuQwFsJ9i
 hSqP7BIYjVGGsIKNrLzUoE1fEwQDCduIrNN/+1FUXNh+93DKQjICphpwqvCCle/s6fL8F2VFoQ1
 TR55aVgTtjqJi2Uq/rW3RZ8Cfz2XJfdupCApgosk5TTh5uR598Z0WdMK0niierWXw8DDt2nYx5s
 4MFuITBOsbDZapcXk9c3Wj/ijI1rNPLZvPHkRJfxPM5cn0fxhcVkaIsctbxyNY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 clxscore=1030 mlxlogscore=699 bulkscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604020090
Received-SPF: pass client-ip=57.103.84.71;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

Was removed in 2c08624 but it's still useful for
Windows 10 so reintroduce it there.

And this time, actually make it work by reporting
the hypervisor bit in CPUID.

Also pretend to be KVM, with the only capability
reported being X2APIC support.

Although looks like Linux doesn't use that vmware leaf...

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 64 ++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 8 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 5460207bdb..e4f297eec1 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2071,15 +2071,45 @@ int whpx_vcpu_run(CPUState *cpu)
                 vcpu->exit_ctx.VpContext.Rip +
                 vcpu->exit_ctx.VpContext.InstructionLength;
 
-            reg_values[1].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
-            reg_values[2].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
-            reg_values[3].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
-            reg_values[4].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
-
-            if (vcpu->exit_ctx.CpuidAccess.Rax == 1) {
-                if (cpu_has_x2apic_feature(env)) {
-                    reg_values[2].Reg64 |= CPUID_EXT_X2APIC;
+            if (whpx_is_legacy_os()) {
+                reg_values[1].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
+                reg_values[2].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
+                reg_values[3].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
+                reg_values[4].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
+                switch (vcpu->exit_ctx.CpuidAccess.Rax) {
+                case 1:
+                    if (cpu_has_x2apic_feature(env)) {
+                        reg_values[2].Reg64 |= CPUID_EXT_X2APIC;
+                    }
+                    reg_values[2].Reg64 |= CPUID_EXT_HYPERVISOR;
+                    break;
+                case 0x40000000:
+                    /* report KVM */
+                    if (x86_cpu->vmware_cpuid_freq) {
+                        reg_values[1].Reg64 = 0x40000010;
+                    } else {
+                        reg_values[1].Reg64 = 0x40000001;
+                    }
+                    reg_values[4].Reg64 = 0x4b4d564b;
+                    reg_values[2].Reg64 = 0x564b4d56;
+                    reg_values[3].Reg64 = 0x4d;
+                    break;
+                case 0x40000001:
+                    /* report X2APIC */
+                    reg_values[1].Reg64 = reg_values[4].Reg64 = reg_values[2].Reg64 = 1 << 15;
+                    break;
+                case 0x40000010:
+                    if (x86_cpu->vmware_cpuid_freq) {
+                        reg_values[1].Reg64 = env->tsc_khz;
+                        reg_values[4].Reg64 = env->apic_bus_freq / 1000; /* Hz to KHz */
+                    }
+                    break;
                 }
+            } else {
+                cpu_x86_cpuid(env, vcpu->exit_ctx.CpuidAccess.Rax, 0, 
+                    (UINT32 *)&reg_values[1].Reg32,
+                    (UINT32 *)&reg_values[4].Reg32, (UINT32 *)&reg_values[2].Reg32,
+                    (UINT32 *)&reg_values[3].Reg32);
             }
 
             hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
@@ -2253,6 +2283,24 @@ int whpx_init_vcpu(CPUState *cpu)
         env->apic_bus_freq = 1000000000;
     }
 
+    /* Windows 10 doesn't provide Hyper-V enlightenments. */
+    if (whpx_is_legacy_os()) {
+         UINT32 cpuidExitList[] = {1, 0x40000000, 0x40000001, 0x40000010};
+
+         hr = whp_dispatch.WHvSetPartitionProperty(
+                 whpx->partition,
+                 WHvPartitionPropertyCodeCpuidExitList,
+                 cpuidExitList,
+                 RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
+
+         if (FAILED(hr)) {
+             error_report("WHPX: Failed to set partition CpuidExitList hr=%08lx",
+                         hr);
+             ret = -EINVAL;
+             goto error;
+         }
+     }
+
     vcpu->interruptable = true;
     cpu->vcpu_dirty = true;
     cpu->accel = vcpu;
-- 
2.50.1 (Apple Git-155)


