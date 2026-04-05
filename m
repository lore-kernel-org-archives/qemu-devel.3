Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E93E64006
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 02:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9DJn-0003ah-L2; Sat, 04 Apr 2026 22:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w9DJm-0003Zp-3i
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 22:34:30 -0400
Received: from p-east2-cluster4-host12-snip4-7.eps.apple.com ([57.103.78.188]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w9DJj-0008GI-OG
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 22:34:29 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 60CCB1800161; Sun, 05 Apr 2026 02:34:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775356466; x=1777948466;
 bh=erbOCyU4O1JAOQSDnCBG5dNEHmmn9siO0GrdpKFTbRQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=bA+56f1j+AREDY09AcKa2RM4xN3DkNkdYYJt3XGRWm9bf0cY/21GTmUVmKkI0dEyHxEQ4X6E6ffZqW61MRpfZFIZdQucmCBuy4xW44YU6Wa+tbmNysFiFoBEmrPtJVUJ3siUoXXDvfCKieBiU/OUxwpWqqKuWEwcWbXYi+K44x6cbCEXgEsSGf2ic972iaEnyr4hJurRH5smkQYXX8DB4A2xaHGlIQRuya2a+46ybi2sjBHkLjsInD+lyxobSPDTDqYq1gxadQ9Vf2pPwl0DDn43d1v+Cuo67fIre4ZELIx//Xv+buwNwbY7wPisQZBQN+5rQeO1aJBgh4pzC5qeLQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 6B13F1800156; Sun, 05 Apr 2026 02:34:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v7 07/11] whpx: i386: introduce proper cpuid support
Date: Sun,  5 Apr 2026 04:34:05 +0200
Message-ID: <20260405023409.23142-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260405023409.23142-1-mohamed@unpredictable.fr>
References: <20260405023409.23142-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 024DTH6G0w30x106EuIyOJlf9U976DqL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDAyNCBTYWx0ZWRfXzZA4qtfz2l5F
 xyRHAMLqbqzdDNaX5G0A7LM3uOPUP6E7OblcF9m/gNevgTq1TSLDykGf50BvOVajEdd78fM3H57
 3WQ8IlIsjLCSM3ib7tR4iugwExeMyoqPuTjs1aGaKTZUO1CuhyM+vdhPQy3kvEP4bUgX1G6kdqf
 mdIXiCFJsB892R486TypxJvztTH+W0fBJ1N5Xxu3wKwlwp0HtLhd5+0eS/upsETzlFyaNwgOgog
 62hI6i5UFpJElNZm8h6cVrWJtt/uPL/nVuepAb8ZF3WRbhJKDnrgpcyEJ/WBxrzCMk4I8khLkb6
 3osOPOLCNu2WZRT6D+f8OSGqmqGb562ZE1gdg0LUmnTXv4uyfww7GwQ3XNrYxQ=
X-Authority-Info-Out: v=2.4 cv=dcqNHHXe c=1 sm=1 tr=0 ts=69d1ca31
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8sZpQ5n5XTMrbxHEXIkA:9
X-Proofpoint-GUID: 024DTH6G0w30x106EuIyOJlf9U976DqL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 clxscore=1030 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604050024
Received-SPF: pass client-ip=57.103.78.188;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Unlike the implementation in QEMU 10.2, this one works.

It's not optimal though as it doesn't use the Hyper-V support for this.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 108 ++++++++++++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 4 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 5601cacd33..735ab920a6 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2071,6 +2071,7 @@ int whpx_vcpu_run(CPUState *cpu)
             WHV_REGISTER_NAME reg_names[5];
             UINT32 reg_count = 5;
             X86CPU *x86_cpu = X86_CPU(cpu);
+            X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
             CPUX86State *env = &x86_cpu->env;
 
             reg_names[0] = WHvX64RegisterRip;
@@ -2083,7 +2084,15 @@ int whpx_vcpu_run(CPUState *cpu)
                 vcpu->exit_ctx.VpContext.Rip +
                 vcpu->exit_ctx.VpContext.InstructionLength;
 
-            if (whpx_is_legacy_os()) {
+            /*
+             * On Windows 10 we can't query features from
+             * the Hyper-V interface.
+             *
+             * On Windows 11, if using xcc->max_features
+             * just pass through what the hypervisor
+             * provides without any QEMU filtering.
+             */
+            if (whpx_is_legacy_os() || xcc->max_features) {
                 reg_values[1].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
                 reg_values[2].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
                 reg_values[3].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
@@ -2138,6 +2147,45 @@ int whpx_vcpu_run(CPUState *cpu)
                     }
                     break;
                 }
+            } else {
+                switch (vcpu->exit_ctx.CpuidAccess.Rax) {
+                case 0x40000000:
+                case 0x40000001:
+                case 0x40000010:
+                    reg_values[1].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
+                    reg_values[2].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
+                    reg_values[3].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
+                    reg_values[4].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
+                    break;
+                }
+            }
+
+            /* Dynamic depending on XCR0 and XSS, so query DefaultResult */
+            if (vcpu->exit_ctx.CpuidAccess.Rax == 0x07
+                && vcpu->exit_ctx.CpuidAccess.Rcx == 0) {
+                if (vcpu->exit_ctx.CpuidAccess.DefaultResultRdx
+                    & CPUID_7_0_EDX_CET_IBT) {
+                    reg_values[3].Reg32 |= CPUID_7_0_EDX_CET_IBT;
+                } else {
+                    reg_values[3].Reg32 &= ~CPUID_7_0_EDX_CET_IBT;
+                }
+
+                if (vcpu->exit_ctx.CpuidAccess.DefaultResultRcx
+                    & CPUID_7_0_ECX_CET_SHSTK) {
+                    reg_values[2].Reg32 |= CPUID_7_0_ECX_CET_SHSTK;
+                } else {
+                    reg_values[2].Reg32 &= ~CPUID_7_0_ECX_CET_SHSTK;
+                }
+            }
+
+            /* OSXSAVE is dynamic. Do this instead of syncing CR4 */
+            if (vcpu->exit_ctx.CpuidAccess.Rax == 1) {
+                if (vcpu->exit_ctx.CpuidAccess.DefaultResultRcx
+                    & CPUID_EXT_OSXSAVE) {
+                    reg_values[2].Reg32 |= CPUID_EXT_OSXSAVE;
+                } else {
+                    reg_values[2].Reg32 &= ~CPUID_EXT_OSXSAVE;
+                }
             }
 
             hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
@@ -2327,6 +2375,45 @@ error:
     return ret;
 }
 
+static void whpx_cpu_xsave_init(void)
+{
+    static bool first = true;
+    int i;
+
+    if (!first) {
+        return;
+    }
+    first = false;
+
+    /* x87 and SSE states are in the legacy region of the XSAVE area. */
+    x86_ext_save_areas[XSTATE_FP_BIT].offset = 0;
+    x86_ext_save_areas[XSTATE_SSE_BIT].offset = 0;
+
+    for (i = XSTATE_SSE_BIT + 1; i < XSAVE_STATE_AREA_COUNT; i++) {
+        ExtSaveArea *esa = &x86_ext_save_areas[i];
+
+        if (esa->size) {
+            int sz = whpx_get_supported_cpuid(0xd, i, R_EAX);
+            if (sz != 0) {
+                assert(esa->size == sz);
+                esa->offset = whpx_get_supported_cpuid(0xd, i, R_EBX);
+            }
+        }
+    }
+}
+
+static void whpx_cpu_max_instance_init(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+
+    env->cpuid_min_level =
+        whpx_get_supported_cpuid(0x0, 0, R_EAX);
+    env->cpuid_min_xlevel =
+        whpx_get_supported_cpuid(0x80000000, 0, R_EAX);
+    env->cpuid_min_xlevel2 =
+        whpx_get_supported_cpuid(0xC0000000, 0, R_EAX);
+}
+
 static PropValue whpx_default_props[] = {
     { "x2apic", "on" },
     { NULL, NULL },
@@ -2336,9 +2423,18 @@ static PropValue whpx_default_props[] = {
 void whpx_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
+    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
 
     host_cpu_instance_init(cpu);
     x86_cpu_apply_props(cpu, whpx_default_props);
+
+    if (!whpx_is_legacy_os() && xcc->max_features) {
+        whpx_cpu_max_instance_init(cpu);
+    }
+
+    if (!whpx_is_legacy_os()) {
+        whpx_cpu_xsave_init();
+    }
 }
 
 /*
@@ -2356,8 +2452,12 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_CAPABILITY_FEATURES features = {0};
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
-    UINT32 cpuidExitList[] = {1};
-    UINT32 cpuidExitList_nohyperv[] = {1, 0x40000000, 0x40000001, 0x40000010};
+
+    UINT32 cpuidExitList[] = {0x0, 0x1, 0x6, 0x7, 0x14, 0x24, 0x29, 0x1E,
+        0x40000000, 0x40000001, 0x40000010, 0x80000000, 0x80000001,
+        0x80000002, 0x80000003, 0x80000004, 0x80000007, 0x80000008,
+        0x8000000A, 0x80000021, 0x80000022, 0xC0000000, 0xC0000001};
+    UINT32 cpuidExitList_legacy_os[] = {1, 0x40000000, 0x40000001, 0x40000010};
 
     whpx = &whpx_global;
 
@@ -2613,7 +2713,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     hr = whp_dispatch.WHvSetPartitionProperty(
         whpx->partition,
         WHvPartitionPropertyCodeCpuidExitList,
-        whpx->hyperv_enlightenments_enabled ? cpuidExitList : cpuidExitList_nohyperv,
+        !whpx_is_legacy_os() ? cpuidExitList : cpuidExitList_legacy_os,
         RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
 
     if (FAILED(hr)) {
-- 
2.50.1 (Apple Git-155)


