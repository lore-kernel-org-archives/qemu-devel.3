Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C906D6AAFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 19:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Nlc-0000Oz-W8; Thu, 02 Apr 2026 15:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8NlO-0000Lq-7I
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 15:31:39 -0400
Received: from pv-2002j-snip4-3.eps.apple.com ([57.103.64.144]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8NlI-0008HC-67
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 15:31:30 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-1 (Postfix) with ESMTPS id
 91A1F1800161; Thu, 02 Apr 2026 19:31:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775158286; x=1777750286;
 bh=DJiQcN+R2DoS0VUEx1nwHZdiISPegzTmeoPCfvvpPAA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JPt4jXyHExwsBN3yRflU64Mop3wrZTfSLdvoEeYKK7p9yYwD15gpfB4O5ozCdnlBUxaqltYSD/Zlq9Otr8NGswN1n2Ehn0tMoIgVc4LP+gYlSuE408QEG8qYHYwZTn9HGyOnJjpJCq/D82hE8BBlkTPIZund89zLB3WiWrJD03Uhf6S/ClcJgHFTThf7Ty7jblmofJqFEtB82wDIcrEUi/Wz8RbJcGau1xVBDkNT7Y/n80UePWHwZH59VXWNFONtAN/L6KWCO+/GiWoUAVuAD2sVGR3nV/mOUTS1xoblTHphrG/yrKoCcLRz6mcUCNEeMTqL8lFNLYdg4MUnGIY4bg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-1 (Postfix) with ESMTPSA id
 383941800166; Thu, 02 Apr 2026 19:31:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 6/6] whpx: i386: reintroduce enlightenments for Windows 10
Date: Thu,  2 Apr 2026 21:31:04 +0200
Message-ID: <20260402193104.56331-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402193104.56331-1-mohamed@unpredictable.fr>
References: <20260402193104.56331-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE3NSBTYWx0ZWRfX98CdvnNC8KgV
 ztIJSyZ32lOdeAiq0LJvBa+IdxzVK75WZn8EG5X21y03aBBHnX3ewpgeaYjJ1gslWPPItUwPB86
 MsAmIYv5ncwAbt0abK4/+xSgHI1Y8etNrDVG5ONTLMpEpgrVvYatqOCLNkYGovWjRG6TPAjsBjd
 j0b0PwCt63YPR3lTz7fAQuQYHJU7rsYMIJoHyyXVS7Rs3fsmqlIEacKQD7pZTpF6Kk/HE9rO5+1
 3XqHazF0s2PfBFgzicBCA/gsudBCURkQ0AEbogV0+PRCLhe4OFCuuh6MPL10ywCwCY6MSGBGTG3
 v9mMMYS47/xWkhMxQRT7dSx3PiiGhVNPqfS+eIFIukGLx2TajTDTL1gP9NpyBE=
X-Proofpoint-GUID: HsktXxGOi5Zk_rkYOiND54WOm5OaaT4A
X-Proofpoint-ORIG-GUID: HsktXxGOi5Zk_rkYOiND54WOm5OaaT4A
X-Authority-Info-Out: v=2.4 cv=Qr9THFyd c=1 sm=1 tr=0 ts=69cec40d
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1av6p83xj7LwzDHaJJEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 clxscore=1030 spamscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604020175
Received-SPF: pass client-ip=57.103.64.144;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 accel/whpx/whpx-common.c       |  2 +
 include/system/whpx-internal.h |  1 +
 target/arm/whpx/whpx-all.c     |  1 +
 target/i386/whpx/whpx-all.c    | 68 ++++++++++++++++++++++++++++++----
 4 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index b813a5d9d2..59be996aef 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -550,6 +550,8 @@ static void whpx_accel_instance_init(Object *obj)
 
     whpx->hyperv_enlightenments_allowed = true;
     whpx->hyperv_enlightenments_required = false;
+    /* Value determined at whpx_accel_init */
+    whpx->hyperv_enlightenments_enabled = false;
 }
 
 static const TypeInfo whpx_accel_type = {
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 480d05fdca..576587ec3b 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -45,6 +45,7 @@ struct whpx_state {
 
     bool hyperv_enlightenments_allowed;
     bool hyperv_enlightenments_required;
+    bool hyperv_enlightenments_enabled;
 
 };
 
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index bbf0f6be96..4019a513aa 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -968,6 +968,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
      * as they're not needed for performance.
      */
     if (whpx->hyperv_enlightenments_required) {
+        whpx->hyperv_enlightenments_enabled = true;
         hr = whp_dispatch.WHvSetPartitionProperty(
                 whpx->partition,
                 WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index b8f53ca532..b62377cb41 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2077,14 +2077,47 @@ int whpx_vcpu_run(CPUState *cpu)
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
+            } else {
+                cpu_x86_cpuid(env, vcpu->exit_ctx.CpuidAccess.Rax, 0, 
+                    (UINT32 *)&reg_values[1].Reg32,
+                    (UINT32 *)&reg_values[4].Reg32, (UINT32 *)&reg_values[2].Reg32,
+                    (UINT32 *)&reg_values[3].Reg32);
+            }
+
+            if (!whpx->hyperv_enlightenments_enabled) {
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
             }
 
@@ -2259,6 +2292,24 @@ int whpx_init_vcpu(CPUState *cpu)
         env->apic_bus_freq = 1000000000;
     }
 
+    /* When Hyper-V enlightenments are not active, fall back to the KVM ones */
+    if (!whpx->hyperv_enlightenments_enabled) {
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
+    }
+
     vcpu->interruptable = true;
     cpu->vcpu_dirty = true;
     cpu->accel = vcpu;
@@ -2507,6 +2558,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     }
 
     if (!is_legacy_os && whpx->hyperv_enlightenments_allowed) {
+        whpx->hyperv_enlightenments_enabled = true;
         hr = whp_dispatch.WHvSetPartitionProperty(
                 whpx->partition,
                 WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
-- 
2.50.1 (Apple Git-155)


