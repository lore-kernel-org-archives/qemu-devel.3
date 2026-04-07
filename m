Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F8AFF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABUB-0005b2-If; Tue, 07 Apr 2026 14:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wABSZ-0003JL-V2
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:47:36 -0400
Received: from p-east2-cluster2-host12-snip4-2.eps.apple.com ([57.103.78.95]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wA8Bn-0002EY-0D
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 11:18:04 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPS id
 5ECAB1803F17; Tue, 07 Apr 2026 15:17:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775575082; x=1778167082;
 bh=UDUDDhSNImOkwjgegNmDYFGV0Ws4YLT0V61YNwqVXjA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=W0zrtfDRw2i8iFlYdQiyzmCBQeKBI2au5rfHRkAe1zlFrWCFji9g4/0MqC3aclTUdAN9Mc/EeWTx04N58lbmBm4zMMMIMYuzbaZEoFbi3XKyqytF4T2YSaLPi7e7Ht7j61AvgQFMms6xLNaDrx6IAPyHkf0vgzMUR0Am4sxcZ9spm8DpN6Le7+bgCiqEnQXH2hypGTj0OLoTQfef5NiFisXA0AkdqYbI+pGqbPjsUFK2QqDthicYbN4ZPjaP+6/2oDAuuTY3EfOh0nCyy2ZPUmryEKoZi8xZoayr95vTb+lkFPMqiSu+QYfG+fHZzdodgxRFXG20hf4fzjxZokWlFQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPSA id
 D3C6418013D7; Tue, 07 Apr 2026 15:17:23 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v9 10/13] whpx: i386: disable kernel-irqchip on Windows 10
 when PIC enabled
Date: Tue,  7 Apr 2026 17:17:04 +0200
Message-ID: <20260407151707.46536-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260407151707.46536-1-mohamed@unpredictable.fr>
References: <20260407151707.46536-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xi-nRYkBnpZFTN493Uua_yy2kSpznk4c
X-Proofpoint-GUID: xi-nRYkBnpZFTN493Uua_yy2kSpznk4c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0MCBTYWx0ZWRfXwCkaJiMe/6rs
 ehR92v7pvNavGNj7ieUAFoWx9IiDBFYW9SlNd/tRKaWfczun8dNYGRkDNaKyAXTWGjyDlA9Kk5W
 l4j5xwcSUFx/DuqQPOLUBgQzGbS5OlzHLvZDdp5V1bmI/DuQl8DyErPpXOijuOapIRabuytJYQv
 AXLOC3Vbab9j2Rb5liCfo7mjt3jCwm4o9ab7NgFPrlAlh0LnUxFI6ujPetou7eo3QtJBh560i8G
 0D1ms5nmaV7IPvGGUqnfeeMI/bs/XoBj9aw/j8U738fA65YjUy09Z6HMi4HGFK4p+K1fJvmAMOm
 icN4ydXEl6dCoOLGU82KAM7iiVRiBrSxdxngo/rWFchQTsnMUU6vZgoS6d6SLQ=
X-Authority-Info-Out: v=2.4 cv=eqnSD4pX c=1 sm=1 tr=0 ts=69d52028
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=nUl_a9z44qMLw6SsMv4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 clxscore=1030 adultscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxlogscore=778 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604070140
Received-SPF: pass client-ip=57.103.78.95;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Move WHvCapabilityCodeProcessorPerfmonFeatures queries
as that's how we distinguish if on a legacy OS.

Now that Windows guests are booting, disable kernel-irqchip=on
by default for Windows 10 when the PIC is enabled.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 69 +++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 74b94b799e..7c80d653d1 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2447,6 +2447,13 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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
@@ -2518,6 +2525,35 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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
@@ -2530,8 +2566,9 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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
@@ -2590,34 +2627,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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


