Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC00F99C98
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEF9-0006nG-6f; Sat, 18 Apr 2026 18:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEF5-0006Th-Gj
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:24 -0400
Received: from p-east2-cluster1-host2-snip4-10.eps.apple.com ([57.103.76.43]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEF3-000585-8d
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:23 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 EADBF1800219; Sat, 18 Apr 2026 22:34:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551660; x=1779143660;
 bh=NjePHP/x5PK9n6m7HobdZ0wT/5aohBRW4KL4TqeRGZc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=M+9SXfHeDOfzww2YfTK65n88HcxX3uopnmXM8PaU0dELTKTaZ/gwsJsWzwaIUtu6SYAlKKD+j+n0Lai9Csa3MawqlT7rnOTxTWt/E8lY86VUVTuyS86ecRcayxB7ct0eDuH2DQBWh9B703HdvjDHGATpc4CprNtFqyYP/987Pb2uh35bvVQ/tkCI5ClqNCvCm7u4/mavdrlgk7jPE6Elxtvpok0tG02ajFK7fERGFnPCjRg2QjSAVbgNtzqZxQqc5uxrtgX9Kk/2ODFunmq4QxjYSdYL3klNOx0Ce6pw9D5ZJFnfDqgLejQ+49HyqQrUZp7zmsxGg7lnBjs65v/6RA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 77B7C1800231; Sat, 18 Apr 2026 22:34:14 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 28/38] whpx: i386: CPU features support for Windows 10
Date: Sun, 19 Apr 2026 00:33:10 +0200
Message-ID: <20260418223320.51330-29-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOCBTYWx0ZWRfX8B13bsxtV+FU
 GPLeKj33yK/eha2c4JOB2LjwUd71EkILMWp9KggJrvrftfbyKmDMyzNysZjz5co9K2dj2kvPUA8
 RyXak8/gWpmVXXSyAYVc88FuR24vBzqgvqrNn9g+IHyWyJO7XAH1j2LSqyxvw2Yt9sj9i6GAXok
 s7j1egvgwGODbS0GX3F//LRGJiEf/nv6YMsZYcvlozjErAdgK46hVymTcsLAI1lIXfRwMuxz4ac
 rHLsVto74AFNeA350yIrrRqmfKo0n0M1EDq/BZ8MtmPPuj2F1ETPcPdJKiL6EexWObrUzaeZP4z
 VReykPF69IfAtmI7RKqp1G73v7yry4aG2IrHOYbIrgH6LYuwxJZe9gh5zrZK00=
X-Proofpoint-GUID: f75Y3ARh1qCKeS4lx6b_l7_iifvSnYaD
X-Authority-Info-Out: v=2.4 cv=WZMBqkhX c=1 sm=1 tr=0 ts=69e406ea
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mDV3o1hIAAAA:8 a=_S2v2Z1saO19s7bx6VoA:9
X-Proofpoint-ORIG-GUID: f75Y3ARh1qCKeS4lx6b_l7_iifvSnYaD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0 mlxscore=0
 clxscore=1030 malwarescore=0 bulkscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604180228
Received-SPF: pass client-ip=57.103.76.43;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/cpu.c                  |  18 +--
 target/i386/whpx/meson.build       |   1 +
 target/i386/whpx/whpx-all.c        |  38 ++++++-
 target/i386/whpx/whpx-cpu-legacy.c | 171 +++++++++++++++++++++++++++++
 target/i386/whpx/whpx-i386.h       |   7 ++
 5 files changed, 215 insertions(+), 20 deletions(-)
 create mode 100644 target/i386/whpx/whpx-cpu-legacy.c

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b18e40666e..8f090782bd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8092,9 +8092,6 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
     } else if (whpx_enabled()) {
         if (wi->type != CPUID_FEATURE_WORD) {
             return 0;
-        }
-        if (whpx_is_legacy_os()) {
-            r = wi->tcg_features;
         } else {
             r = whpx_get_supported_cpuid(wi->cpuid.eax,
                                         wi->cpuid.ecx,
@@ -8182,17 +8179,10 @@ static void x86_cpu_get_supported_cpuid(uint32_t func, uint32_t index,
         *ecx = hvf_get_supported_cpuid(func, index, R_ECX);
         *edx = hvf_get_supported_cpuid(func, index, R_EDX);
     } else if (whpx_enabled()) {
-        if (whpx_is_legacy_os()) {
-            *eax = 0;
-            *ebx = 0;
-            *ecx = 0;
-            *edx = 0;
-        } else {
-            *eax = whpx_get_supported_cpuid(func, index, R_EAX);
-            *ebx = whpx_get_supported_cpuid(func, index, R_EBX);
-            *ecx = whpx_get_supported_cpuid(func, index, R_ECX);
-            *edx = whpx_get_supported_cpuid(func, index, R_EDX);
-        }
+        *eax = whpx_get_supported_cpuid(func, index, R_EAX);
+        *ebx = whpx_get_supported_cpuid(func, index, R_EBX);
+        *ecx = whpx_get_supported_cpuid(func, index, R_ECX);
+        *edx = whpx_get_supported_cpuid(func, index, R_EDX);
     } else {
         *eax = 0;
         *ebx = 0;
diff --git a/target/i386/whpx/meson.build b/target/i386/whpx/meson.build
index c3aaaff9fd..1c6a4ce377 100644
--- a/target/i386/whpx/meson.build
+++ b/target/i386/whpx/meson.build
@@ -1,4 +1,5 @@
 i386_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
   'whpx-all.c',
   'whpx-apic.c',
+  'whpx-cpu-legacy.c'
 ))
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 02235d5391..9b48ef2914 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -270,11 +270,30 @@ typedef enum WhpxStepMode {
 static uint32_t max_vcpu_index;
 static WHV_PROCESSOR_XSAVE_FEATURES whpx_xsave_cap;
 
-static bool whpx_has_xsave(void)
+bool whpx_has_xsave(void)
 {
     return whpx_xsave_cap.XsaveSupport;
 }
 
+bool whpx_has_xsaves(void)
+{
+    return whpx_xsave_cap.XsaveSupervisorSupport;
+}
+
+static bool whpx_rdtsc_cap;
+
+bool whpx_has_rdtscp(void)
+{
+    return whpx_rdtsc_cap;
+}
+
+static bool whpx_invpcid_cap;
+
+bool whpx_has_invpcid(void)
+{
+    return whpx_invpcid_cap;
+}
+
 static WHV_X64_SEGMENT_REGISTER whpx_seg_q2h(const SegmentCache *qs, int v86,
                                              int r86)
 {
@@ -1057,6 +1076,11 @@ uint32_t whpx_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
     bool temp_cpu = true;
     HRESULT hr;
 
+    /* Legacy OSes don't have WHvGetVirtualProcessorCpuidOutput */
+    if (whpx_is_legacy_os()) {
+        return whpx_get_supported_cpuid_legacy(func, idx, reg);
+    }
+
     hr = whp_dispatch.WHvCreateVirtualProcessor(
         whpx_global.partition, cpu_index, 0);
 
@@ -2147,7 +2171,7 @@ int whpx_vcpu_run(CPUState *cpu)
              * just pass through what the hypervisor
              * provides without any QEMU filtering.
              */
-            if (whpx_is_legacy_os() || xcc->max_features) {
+            if (xcc->max_features) {
                 reg_values[1].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
                 reg_values[2].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
                 reg_values[3].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
@@ -2507,11 +2531,11 @@ void whpx_cpu_instance_init(CPUState *cs)
     host_cpu_instance_init(cpu);
     x86_cpu_apply_props(cpu, whpx_default_props);
 
-    if (!whpx_is_legacy_os() && xcc->max_features) {
+    if (xcc->max_features) {
         whpx_cpu_max_instance_init(cpu);
     }
 
-    if (!whpx_is_legacy_os()) {
+    if (whpx_has_xsave()) {
         whpx_cpu_xsave_init();
     }
 }
@@ -2536,7 +2560,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         0x40000000, 0x40000001, 0x40000010, 0x80000000, 0x80000001,
         0x80000002, 0x80000003, 0x80000004, 0x80000007, 0x80000008,
         0x8000000A, 0x80000021, 0x80000022, 0xC0000000, 0xC0000001};
-    UINT32 cpuidExitList_legacy_os[] = {1, 0x40000000, 0x40000001, 0x40000010};
 
     X86MachineState *x86ms = X86_MACHINE(ms);
     bool pic_enabled = false;
@@ -2700,6 +2723,9 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    whpx_rdtsc_cap = processor_features.Bank0.RdtscpSupport;
+    whpx_invpcid_cap = processor_features.Bank0.InvpcidSupport;
+ 
     if (whpx_irqchip_in_kernel() && processor_features.Bank1.NestedVirtSupport) {
         memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
         prop.NestedVirtualization = 1;
@@ -2808,7 +2834,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     hr = whp_dispatch.WHvSetPartitionProperty(
         whpx->partition,
         WHvPartitionPropertyCodeCpuidExitList,
-        !whpx_is_legacy_os() ? cpuidExitList : cpuidExitList_legacy_os,
+        cpuidExitList,
         RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
 
     if (FAILED(hr)) {
diff --git a/target/i386/whpx/whpx-cpu-legacy.c b/target/i386/whpx/whpx-cpu-legacy.c
new file mode 100644
index 0000000000..477429b460
--- /dev/null
+++ b/target/i386/whpx/whpx-cpu-legacy.c
@@ -0,0 +1,171 @@
+/*
+ *  i386 CPUID helper functions
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *  Copyright (c) 2017 Google Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * cpuid
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cpuid.h"
+#include "host/cpuinfo.h"
+#include "cpu.h"
+#include "emulate/x86.h"
+#include "whpx-i386.h"
+
+static bool cached_xcr0;
+static uint64_t supported_xcr0;
+
+static void cache_host_xcr0(void)
+{
+    if (cached_xcr0) {
+        return;
+    }
+
+    if (whpx_has_xsave()) {
+        uint64_t host_xcr0 = xgetbv_low(0);
+
+        /* Only show xcr0 bits corresponding to usable features.  */
+        supported_xcr0 = host_xcr0 & (XSTATE_FP_MASK |
+                                      XSTATE_SSE_MASK | XSTATE_YMM_MASK |
+                                      XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK |
+                                      XSTATE_Hi16_ZMM_MASK);
+        if ((supported_xcr0 & (XSTATE_FP_MASK | XSTATE_SSE_MASK)) !=
+            (XSTATE_FP_MASK | XSTATE_SSE_MASK)) {
+            supported_xcr0 = 0;
+        }
+    }
+
+    cached_xcr0 = true;
+}
+
+uint32_t whpx_get_supported_cpuid_legacy(uint32_t func, uint32_t idx,
+                                 int reg)
+{
+    uint32_t eax, ebx, ecx, edx;
+
+    cache_host_xcr0();
+    host_cpuid(func, idx, &eax, &ebx, &ecx, &edx);
+
+    switch (func) {
+    case 0:
+        eax = eax < (uint32_t)0xd ? eax : (uint32_t)0xd;
+        break;
+    case 1:
+        edx &= CPUID_FP87 | CPUID_VME | CPUID_DE | CPUID_PSE | CPUID_TSC |
+             CPUID_MSR | CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC |
+             CPUID_SEP | CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV |
+             CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH | CPUID_MMX |
+             CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS | CPUID_HT;
+        ecx &= CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3 |
+             CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID |
+             CPUID_EXT_SSE41 | CPUID_EXT_SSE42 | CPUID_EXT_MOVBE |
+             CPUID_EXT_POPCNT | CPUID_EXT_AES |
+             (supported_xcr0 ? CPUID_EXT_XSAVE : 0) |
+             CPUID_EXT_AVX | CPUID_EXT_F16C | CPUID_EXT_RDRAND;
+        ecx |= CPUID_EXT_HYPERVISOR;
+        ecx |= CPUID_EXT_X2APIC;
+        edx |= CPUID_HT;
+        break;
+    case 6:
+        eax = CPUID_6_EAX_ARAT;
+        ebx = 0;
+        ecx = 0;
+        edx = 0;
+        break;
+    case 7:
+        if (idx == 0) {
+            ebx &= CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
+                    CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 |
+                    CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 |
+                    CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_RTM |
+                    CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
+                    CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_AVX512IFMA |
+                    CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512PF |
+                    CPUID_7_0_EBX_AVX512ER | CPUID_7_0_EBX_AVX512CD |
+                    CPUID_7_0_EBX_CLFLUSHOPT | CPUID_7_0_EBX_CLWB |
+                    CPUID_7_0_EBX_AVX512DQ | CPUID_7_0_EBX_SHA_NI |
+                    CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512VL |
+                    CPUID_7_0_EBX_INVPCID;
+
+            if (!whpx_has_invpcid()) {
+                ebx &= ~CPUID_7_0_EBX_INVPCID;
+            }
+
+            ecx &= CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_AVX512_VPOPCNTDQ |
+                   CPUID_7_0_ECX_RDPID;
+            edx &= CPUID_7_0_EDX_AVX512_4VNNIW | CPUID_7_0_EDX_AVX512_4FMAPS;
+        } else {
+            ebx = 0;
+            ecx = 0;
+            edx = 0;
+        }
+        eax = 0;
+        break;
+    case 0xD:
+        if (!supported_xcr0 || idx >= 63 ||
+            (idx > 1 && !(supported_xcr0 & (UINT64_C(1) << idx)))) {
+            eax = ebx = ecx = edx = 0;
+            break;
+        }
+
+        if (idx == 0) {
+            eax = supported_xcr0;
+        } else if (idx == 1) {
+            eax &= CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1;
+            if (!whpx_has_xsaves()) {
+                eax &= ~CPUID_XSAVE_XSAVES;
+            }
+        }
+        break;
+    case 0x80000001:
+        /* LM only if HVF in 64-bit mode */
+        edx &= CPUID_FP87 | CPUID_VME | CPUID_DE | CPUID_PSE | CPUID_TSC |
+                CPUID_MSR | CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC |
+                CPUID_EXT2_SYSCALL | CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV |
+                CPUID_PAT | CPUID_PSE36 | CPUID_EXT2_MMXEXT | CPUID_MMX |
+                CPUID_FXSR | CPUID_EXT2_FXSR | CPUID_EXT2_PDPE1GB | CPUID_EXT2_3DNOWEXT |
+                CPUID_EXT2_3DNOW | CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX;
+        if (!(whpx_has_rdtscp())) {
+            edx &= ~CPUID_EXT2_RDTSCP;
+        }
+        ecx &= CPUID_EXT3_LAHF_LM | CPUID_EXT3_CMP_LEG | CPUID_EXT3_CR8LEG |
+                CPUID_EXT3_ABM | CPUID_EXT3_SSE4A | CPUID_EXT3_MISALIGNSSE |
+                CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_OSVW | CPUID_EXT3_XOP |
+                CPUID_EXT3_FMA4 | CPUID_EXT3_TBM;
+        break;
+    case 0x80000007:
+        edx &= CPUID_APM_INVTSC;
+        eax = ebx = ecx = 0;
+        break;
+    default:
+        return 0;
+    }
+
+    switch (reg) {
+    case R_EAX:
+        return eax;
+    case R_EBX:
+        return ebx;
+    case R_ECX:
+        return ecx;
+    case R_EDX:
+        return edx;
+    default:
+        return 0;
+    }
+}
diff --git a/target/i386/whpx/whpx-i386.h b/target/i386/whpx/whpx-i386.h
index 6db9a75d39..9dc6837574 100644
--- a/target/i386/whpx/whpx-i386.h
+++ b/target/i386/whpx/whpx-i386.h
@@ -2,3 +2,10 @@
 
 uint32_t whpx_get_supported_cpuid(uint32_t func, uint32_t idx, int reg);
 bool whpx_is_legacy_os(void);
+
+uint32_t whpx_get_supported_cpuid_legacy(uint32_t func, uint32_t idx,
+                                 int reg);
+bool whpx_has_xsave(void);
+bool whpx_has_xsaves(void);
+bool whpx_has_rdtscp(void);
+bool whpx_has_invpcid(void);
-- 
2.50.1 (Apple Git-155)


