Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27E6E8536F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 14:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8fSl-0005OW-6H; Fri, 03 Apr 2026 10:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8fSe-0005Nm-1V
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 10:25:24 -0400
Received: from p-east2-cluster2-host12-snip4-10.eps.apple.com ([57.103.78.103]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8fSY-0000O1-HK
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 10:25:21 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPS id
 D208718038E5; Fri, 03 Apr 2026 14:25:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775226317; x=1777818317;
 bh=I1qIMF60/hdkMQjsW/iuFcTfVIViRyblz4VLoxCPh1s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=KdMohnYMzbkyD9mRvcZKaVs7NhmYIbaWNr0NF+5/4XVnQGwjSby/nSnrjgCsWBx/l/tFAHYfG8U9N4HST9gb9gqWknWDuy34S5f58If+d+3FZPhCyKTbkT26wdWkN1qY288y6PYLqDxmjEAyfYPxI3FSkfRNJn4N/RtxOktrDo8l7sCdKilD/UGGfDG24rMeBy+NmY/T29FYpXFKv87ft/wWDkdVcBDZKm14iK+HcJoWOP974DJsY6KA2v5pt5ai2uVCw4DYVisz9OVUhB/8exI48J1BFu4twtg12ny9f+2+onjPVjkEjOKyyCj7OG/uJCDyJWOE+y+Me/g5Yoj2mw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPSA id
 0E7F21800F95; Fri, 03 Apr 2026 14:25:01 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v5 9/9] whpx: i386: disable kernel-irqchip on Windows 10 when
 PIC enabled
Date: Fri,  3 Apr 2026 16:24:46 +0200
Message-ID: <20260403142446.36964-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260403142446.36964-1-mohamed@unpredictable.fr>
References: <20260403142446.36964-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NZxShgZWVreMbW83qpNZaUa3RuZE4RQq
X-Proofpoint-ORIG-GUID: NZxShgZWVreMbW83qpNZaUa3RuZE4RQq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDEyOCBTYWx0ZWRfX4w2eBApmVK9J
 og/ftEKxYvjJwTGp/YnE39mAOdHfmRXLgDRIsqbnzB3zlLu5dqlYjBImDcEKQmPuLkuL8B6/qqZ
 0WTYHVbUxDIATPbMhDYGWftVCkMmZftulohYFLWxPMTLfAkgrh5pnHn7wR/7zVUTKV0XTxKti48
 M8q9Y2PV1JUYP2UD5ZR0umzyw8OHBPWkBcW0qNbzpYNzstDIMUsOhfsbXmKOeShy7Wt/zPcLQW0
 r3EqSpi5l/jdYlepno9v6rzlNvky9+YjjyMYvW/wuQaFKgbXh2QVT8pYXZzNkikrSU69jeFbVeR
 mTZtOkkmS6Zbvl2TPguPOzXyVh3aPacnufb4VHg1p2TtXVYG5yNODA+6PIp8tU=
X-Authority-Info-Out: v=2.4 cv=X8pf6WTe c=1 sm=1 tr=0 ts=69cfcdcd
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=nUl_a9z44qMLw6SsMv4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=816
 clxscore=1030 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604030128
Received-SPF: pass client-ip=57.103.78.103;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Move WHvCapabilityCodeProcessorPerfmonFeatures queries
as that's how we distinguish if on a legacy OS.

Now that Windows guests are booting, disable kernel-irqchip=on
by default for Windows 10 when the PIC is enabled.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 70 +++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 30 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index db2e85514c..b8ef636c09 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -22,6 +22,7 @@
 #include "qemu/main-loop.h"
 #include "hw/core/boards.h"
 #include "hw/intc/ioapic.h"
+#include "hw/i386/x86.h"
 #include "hw/i386/apic_internal.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -2354,6 +2355,13 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         0x8000000A, 0x80000021, 0x80000022, 0xC0000000, 0xC0000001};
     UINT32 cpuidExitList_legacy_os[] = {1, 0x40000000, 0x40000001, 0x40000010};
 
+    X86MachineState *x86ms = X86_MACHINE(ms);
+    bool pic_enabled = false;
+
+    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
+        pic_enabled = true;
+    }
+
     whpx = &whpx_global;
 
     if (!init_whp_dispatch()) {
@@ -2425,6 +2433,35 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    /* Enable supported performance monitoring capabilities */
+    hr = whp_dispatch.WHvGetCapability(
+        WHvCapabilityCodeProcessorPerfmonFeatures, &perfmon_features,
+        sizeof(WHV_PROCESSOR_PERFMON_FEATURES), &whpx_cap_size);
+    /*
+     * Relying on this is a crutch to maintain Windows 10 support.
+     *
+     * WHvCapabilityCodeProcessorPerfmonFeatures and
+     * WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks
+     * are implemented starting from Windows Server 2022 (build 20348).
+     */
+    if (FAILED(hr)) {
+        warn_report("WHPX: Failed to get performance "
+                    "monitoring features, hr=%08lx", hr);
+        is_modern_os = false;
+    } else {
+        hr = whp_dispatch.WHvSetPartitionProperty(
+                whpx->partition,
+                WHvPartitionPropertyCodeProcessorPerfmonFeatures,
+                &perfmon_features,
+                sizeof(WHV_PROCESSOR_PERFMON_FEATURES));
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to set performance "
+                         "monitoring features, hr=%08lx", hr);
+            ret = -EINVAL;
+            goto error;
+        }
+    }
+
     /*
      * Error out if WHP doesn't support apic emulation and user is requiring
      * it.
@@ -2437,8 +2474,9 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    if (whpx->kernel_irqchip_allowed && features.LocalApicEmulation &&
-        whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2) {
+    if (whpx->kernel_irqchip_allowed && !(whpx_is_legacy_os() && pic_enabled
+        && !whpx->kernel_irqchip_required) && features.LocalApicEmulation
+        && whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2) {
         WHV_X64_LOCAL_APIC_EMULATION_MODE mode =
             WHvX64LocalApicEmulationModeX2Apic;
         hr = whp_dispatch.WHvSetPartitionProperty(
@@ -2497,34 +2535,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    /* Enable supported performance monitoring capabilities */
-    hr = whp_dispatch.WHvGetCapability(
-        WHvCapabilityCodeProcessorPerfmonFeatures, &perfmon_features,
-        sizeof(WHV_PROCESSOR_PERFMON_FEATURES), &whpx_cap_size);
-    /*
-     * Relying on this is a crutch to maintain Windows 10 support.
-     *
-     * WHvCapabilityCodeProcessorPerfmonFeatures and
-     * WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks
-     * are implemented starting from Windows Server 2022 (build 20348).
-     */
-    if (FAILED(hr)) {
-        warn_report("WHPX: Failed to get performance "
-                    "monitoring features, hr=%08lx", hr);
-        is_modern_os = false;
-    } else {
-        hr = whp_dispatch.WHvSetPartitionProperty(
-                whpx->partition,
-                WHvPartitionPropertyCodeProcessorPerfmonFeatures,
-                &perfmon_features,
-                sizeof(WHV_PROCESSOR_PERFMON_FEATURES));
-        if (FAILED(hr)) {
-            error_report("WHPX: Failed to set performance "
-                         "monitoring features, hr=%08lx", hr);
-            ret = -EINVAL;
-            goto error;
-        }
-    }
 
     /* Enable synthetic processor features */
     WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS synthetic_features;
-- 
2.50.1 (Apple Git-155)


