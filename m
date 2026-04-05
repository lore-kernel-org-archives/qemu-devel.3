Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39384E64006
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 02:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9DJh-0003YA-4H; Sat, 04 Apr 2026 22:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w9DJf-0003XX-HG
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 22:34:23 -0400
Received: from p-east2-cluster4-host12-snip4-10.eps.apple.com ([57.103.78.191]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w9DJd-0008FW-LO
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 22:34:23 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 578CA18000B4; Sun, 05 Apr 2026 02:34:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775356460; x=1777948460;
 bh=Ash1yi3VlTyxdP0Aar5CNwwUDY+XErFVJjyfbU7EpDA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=KhxwCHYJfFQXoVpC3ULd+dx9DtH4qjbVzu2VNIcONvSz+9pvAsFwxLqcYXU1UYSLb2QJb+AZs9eOI3scclJj3VF5Z66nCQvxY4hOj3WBiU0ahSIqF9CEiKAZX6mo7nv6rIVwZ0XgoIg1TX+ikyeIjyRfSvY/hbywCWYyRNyspy08IlKIlKTZL+mRGi/NAV0oCUkf04eW8p4K8bDpnrvQm+IOH45zgJaRCT3RwEOt3HN+C0uvVfnug7/5Oip0C0vJoNeYtLYAmcQESlIU25ci0fBNnlfubxzaVw/GRj12oPLCg/RWf1V0Zq4tPAP/5f2k1g+2GOtou3vo1TbwxHoFnw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 8759B1800152; Sun, 05 Apr 2026 02:34:16 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v7 03/11] whpx: i386: wire up feature probing
Date: Sun,  5 Apr 2026 04:34:01 +0200
Message-ID: <20260405023409.23142-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260405023409.23142-1-mohamed@unpredictable.fr>
References: <20260405023409.23142-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ncx4RRv3uBYnMLjWi994KsqeskMAVnTJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDAyNCBTYWx0ZWRfXxwwVKtoQWKB6
 DlR5p0JdpSXJrTHXpxc5PTD80E+XKBjwVtomL194/B7pccs0fduz2OoytvmcUwEouZ1YbYmzq/v
 s936+GDIfueo+qAtYPHfK6ZvrPtp6isTZKdxMzXFNngq3v4tUrnC6jIh5pNfHJLGaaIPwJKJJxM
 AlOQSff1cPzgSTPvN7VvIIv19U5FtrRhyTNQt9SbEgWLWkTAm/n5LHHQnxxTow8pEpICt1J/wnO
 HOlsdIuTVequ7B08WlMqGxg24cB7JsOMlSY5Foj5sxTb1XA2HKrdqwMqXf/F6y32ZmuAkyj/QxX
 WYENKm27W8b7uK+AALoPeTuOfV04MZlZ64sOz5a1HuKE/kn/7+PGI4XYYmuQlI=
X-Authority-Info-Out: v=2.4 cv=cs6WUl4i c=1 sm=1 tr=0 ts=69d1ca2b
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Gr33WSPopR-aU8k7cJUA:9
X-Proofpoint-ORIG-GUID: ncx4RRv3uBYnMLjWi994KsqeskMAVnTJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=986
 adultscore=0 clxscore=1030
 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604050024
Received-SPF: pass client-ip=57.103.78.191;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Windows 10 doesn't have the API for this, so using this
only for Windows 11.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 include/system/whpx-internal.h |  9 ++++
 target/i386/cpu.c              | 25 ++++++++++++
 target/i386/whpx/whpx-all.c    | 75 ++++++++++++++++++++++++++++++++--
 target/i386/whpx/whpx-i386.h   |  4 ++
 4 files changed, 109 insertions(+), 4 deletions(-)
 create mode 100644 target/i386/whpx/whpx-i386.h

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 8482901f71..5902124b63 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -73,6 +73,14 @@ void whpx_apic_get(APICCommonState *s);
   X(HRESULT, WHvGetVirtualProcessorRegisters, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, const WHV_REGISTER_NAME* RegisterNames, UINT32 RegisterCount, WHV_REGISTER_VALUE* RegisterValues)) \
   X(HRESULT, WHvSetVirtualProcessorRegisters, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, const WHV_REGISTER_NAME* RegisterNames, UINT32 RegisterCount, const WHV_REGISTER_VALUE* RegisterValues)) \
 
+#ifdef __x86_64__
+#define LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL_ARCH(X) \
+    X(HRESULT, WHvGetVirtualProcessorCpuidOutput, \
+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, UINT32 Eax, \
+         UINT32 Ecx, WHV_CPUID_OUTPUT *CpuidOutput))
+#else
+#define LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL_ARCH(X)
+#endif
 /*
  * These are supplemental functions that may not be present
  * on all versions and are not critical for basic functionality.
@@ -89,6 +97,7 @@ void whpx_apic_get(APICCommonState *s);
          UINT32 StateSize)) \
   X(HRESULT, WHvResetPartition, \
         (WHV_PARTITION_HANDLE Partition)) \
+  LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL_ARCH(X)
 
 #define WHP_DEFINE_TYPE(return_type, function_name, signature) \
     typedef return_type (WINAPI *function_name ## _t) signature;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c6fd1dc00e..0000093fa3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -26,6 +26,8 @@
 #include "tcg/helper-tcg.h"
 #include "exec/translation-block.h"
 #include "system/hvf.h"
+#include "system/whpx.h"
+#include "whpx/whpx-i386.h"
 #include "hvf/hvf-i386.h"
 #include "kvm/kvm_i386.h"
 #include "kvm/tdx.h"
@@ -8087,6 +8089,17 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
         r = hvf_get_supported_cpuid(wi->cpuid.eax,
                                     wi->cpuid.ecx,
                                     wi->cpuid.reg);
+    } else if (whpx_enabled()) {
+        if (wi->type != CPUID_FEATURE_WORD) {
+            return 0;
+        }
+        if (whpx_is_legacy_os()) {
+            r = wi->tcg_features;
+        } else {
+            r = whpx_get_supported_cpuid(wi->cpuid.eax,
+                                        wi->cpuid.ecx,
+                                        wi->cpuid.reg);
+        }
     } else if (tcg_enabled() || qtest_enabled()) {
         r = wi->tcg_features;
     } else {
@@ -8168,6 +8181,18 @@ static void x86_cpu_get_supported_cpuid(uint32_t func, uint32_t index,
         *ebx = hvf_get_supported_cpuid(func, index, R_EBX);
         *ecx = hvf_get_supported_cpuid(func, index, R_ECX);
         *edx = hvf_get_supported_cpuid(func, index, R_EDX);
+    } else if (whpx_enabled()) {
+        if (whpx_is_legacy_os()) {
+            *eax = 0;
+            *ebx = 0;
+            *ecx = 0;
+            *edx = 0;
+        } else {
+            *eax = whpx_get_supported_cpuid(func, index, R_EAX);
+            *ebx = whpx_get_supported_cpuid(func, index, R_EBX);
+            *ecx = whpx_get_supported_cpuid(func, index, R_ECX);
+            *edx = whpx_get_supported_cpuid(func, index, R_EDX);
+        }
     } else {
         *eax = 0;
         *ebx = 0;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 4127440c0c..2d527b90dd 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -36,6 +36,7 @@
 #include "system/whpx-accel-ops.h"
 #include "system/whpx-all.h"
 #include "system/whpx-common.h"
+#include "whpx-i386.h"
 
 #include "emulate/x86_decode.h"
 #include "emulate/x86_emu.h"
@@ -49,6 +50,8 @@
 /* for kernel-irqchip=off */
 #define HV_X64_MSR_APIC_FREQUENCY       0x40000023
 
+static bool is_modern_os = true;
+
 static const WHV_REGISTER_NAME whpx_register_names[] = {
 
     /* X64 General purpose registers */
@@ -1062,6 +1065,71 @@ static void whpx_init_emu(void)
     init_emu(&whpx_x86_emul_ops);
 }
 
+bool whpx_is_legacy_os(void)
+{
+    return !is_modern_os;
+}
+
+uint32_t whpx_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
+{
+    WHV_CPUID_OUTPUT output;
+    uint32_t eax, ebx, ecx, edx;
+    uint32_t cpu_index = 0;
+    bool temp_cpu = true;
+    HRESULT hr;
+
+    hr = whp_dispatch.WHvCreateVirtualProcessor(
+        whpx_global.partition, cpu_index, 0);
+
+    /* This means that the CPU already exists... */
+    if (FAILED(hr)) {
+        temp_cpu = false;
+    }
+
+    hr = whp_dispatch.WHvGetVirtualProcessorCpuidOutput(whpx_global.partition,
+        cpu_index, func, idx, &output);
+
+    if (FAILED(hr)) {
+        abort();
+    }
+
+    if (temp_cpu) {
+        hr = whp_dispatch.WHvDeleteVirtualProcessor(whpx_global.partition, cpu_index);
+        if (FAILED(hr)) {
+            abort();
+        }
+    }
+
+    eax = output.Eax;
+    ebx = output.Ebx;
+    ecx = output.Ecx;
+    edx = output.Edx;
+
+    /*
+     * We can emulate X2APIC even for the kernel-irqchip=off case.
+     * CPUID_EXT_HYPERVISOR and CPUID_HT should be considered present
+     * always, so report them as unconditionally supported here.
+     */
+    if (func == 1) {
+        ecx |= CPUID_EXT_X2APIC;
+        ecx |= CPUID_EXT_HYPERVISOR;
+        edx |= CPUID_HT;
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
+
 /*
  * Controls whether we should intercept various exceptions on the guest,
  * namely breakpoint/single-step events.
@@ -2235,7 +2303,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_CAPABILITY_FEATURES features = {0};
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
-    bool is_legacy_os = false;
     UINT32 cpuidExitList[] = {1};
 
     whpx = &whpx_global;
@@ -2395,7 +2462,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     if (FAILED(hr)) {
         warn_report("WHPX: Failed to get performance "
                     "monitoring features, hr=%08lx", hr);
-        is_legacy_os = true;
+        is_modern_os = false;
     } else {
         hr = whp_dispatch.WHvSetPartitionProperty(
                 whpx->partition,
@@ -2435,7 +2502,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         synthetic_features.Bank0.DirectSyntheticTimers = 1;
     }
 
-    if (!is_legacy_os && whpx->hyperv_enlightenments_allowed) {
+    if (is_modern_os && whpx->hyperv_enlightenments_allowed) {
         hr = whp_dispatch.WHvSetPartitionProperty(
                 whpx->partition,
                 WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
@@ -2446,7 +2513,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
             ret = -EINVAL;
             goto error;
         }
-    } else if (is_legacy_os && whpx->hyperv_enlightenments_required) {
+    } else if (!is_modern_os && whpx->hyperv_enlightenments_required) {
         error_report("Hyper-V enlightenments not available on legacy Windows");
         ret = -EINVAL;
         goto error;
diff --git a/target/i386/whpx/whpx-i386.h b/target/i386/whpx/whpx-i386.h
new file mode 100644
index 0000000000..6db9a75d39
--- /dev/null
+++ b/target/i386/whpx/whpx-i386.h
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+uint32_t whpx_get_supported_cpuid(uint32_t func, uint32_t idx, int reg);
+bool whpx_is_legacy_os(void);
-- 
2.50.1 (Apple Git-155)


