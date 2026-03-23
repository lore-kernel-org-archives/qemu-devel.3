Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80ADF483E9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 19:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4l5L-0005mh-OV; Mon, 23 Mar 2026 15:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l58-0005lm-Ge
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:37:00 -0400
Received: from p-west3-cluster3-host5-snip4-10.eps.apple.com ([57.103.72.141]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l56-0004WW-CP
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:36:58 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPS id
 A74561800100; Mon, 23 Mar 2026 19:36:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774294614; x=1776886614;
 bh=2GvRGzc1MRHwmLUZVIfY+An7ZJn+U4NKEHF+iW/SlLc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=dCIeECaR1uNbkJm7inmdln8hPKfQqSFsX9pjr9g6uIma73qpjbA76NnAVG8QfGSwStRM/5yiE4x4O37UWtqnxddBFirs7Zw28LRpuW5SlDJBLLFy1pKS2hFZiep6sT8LRtN2/fAn6HZUhu24tI93CXTlqmpTBuC/0NczU9mTURLq44vAjc/1hiyNyPcbNC+H8imtvR691hTXYsFiImCHzgClJiO9/cOQb/VOxVLH3/Yn/sD0EBsNHJwWFGkXQ0znubyHCs54CROKJ2PXtq1h3HO9YxD5OUp38iKwd3J3cVnCUkagH/VDmzN8eVaPpy9j9JKSF+RSnZdM+Mtvl4hWbQ==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPSA id
 9E73B180027A; Mon, 23 Mar 2026 19:36:50 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH 01/12] whpx: i386: workaround for Windows 10 support
Date: Mon, 23 Mar 2026 20:36:34 +0100
Message-ID: <20260323193645.82602-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323193645.82602-1-mohamed@unpredictable.fr>
References: <20260323193645.82602-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WPomYIkuBVq4q9jw7EHdTZbCebTNoswa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0NSBTYWx0ZWRfX4q0uOw5RxVp3
 xPp1XjomQWqOXNfLTQnHWq1IL5dq7NswrwVu1P7PvIPN1XAtbd8rXbe7xJo5ixUaAFMLmMEM4qy
 N2Fm39qQCl5Xz38TlvKgE08ghdlM0xBBaYurpz9BY54WHB1JIZ4kLEUPINnuPH5EZGsKxzs7MKQ
 Mj5Y+IeTqkFJLR0BtJbgNh76LhmNDC9BS0/FcDO9vAR4ZQYVc2ihmVqfuzTV5FLGKCrqkFUjlvF
 O8WPQynPt+8ZdEgQjqGcVfG2hyp/ITcaBQTG4rrXJVikLiuzDZu9zrrY0KPHGRT/r7houw7JXk0
 +ictLhptZU7iq7beyeTXZmBZE1ilLmblT7YkYkFpk6fsYaQer55fEmYLS2L1vA=
X-Authority-Info-Out: v=2.4 cv=TY6bdBQh c=1 sm=1 tr=0 ts=69c19655
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0RUPog5Yt9CtxV4tMQEA:9
X-Proofpoint-ORIG-GUID: WPomYIkuBVq4q9jw7EHdTZbCebTNoswa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 clxscore=1030 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230145
Received-SPF: pass client-ip=57.103.72.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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

Windows Server 2022 and later support
WHvCapabilityCodeProcessorPerfmonFeatures and
WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks.

Windows 10 supports neither of those.

As the QEMU executable doesn't have a manifest, OS version
queries do not return the actual Windows version but 6.2.9200
which corresponds to Windows 8. Windows Server 2022 and Windows
11 still use the 10.0 number, with distinction being the build
number.

As such, use the absence of perf monitoring feature query as
a cutoff to detect if a legacy OS is present.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 43 ++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 4d5d3dbd24..015c0f1dc9 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1948,6 +1948,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_CAPABILITY_FEATURES features = {0};
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
+    bool is_legacy_os = false;
 
     whpx = &whpx_global;
 
@@ -2096,21 +2097,29 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     hr = whp_dispatch.WHvGetCapability(
         WHvCapabilityCodeProcessorPerfmonFeatures, &perfmon_features,
         sizeof(WHV_PROCESSOR_PERFMON_FEATURES), &whpx_cap_size);
+    /*
+     * Relying on this is a crutch to maintain Windows 10 support.
+     *
+     * WHvCapabilityCodeProcessorPerfmonFeatures and
+     * WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks
+     * are implemented starting from Windows Server 2022 (build 20348).
+     */
     if (FAILED(hr)) {
-        error_report("WHPX: Failed to get performance monitoring features, hr=%08lx", hr);
-        ret = -ENOSPC;
-        goto error;
-    }
-
-    hr = whp_dispatch.WHvSetPartitionProperty(
-            whpx->partition,
-            WHvPartitionPropertyCodeProcessorPerfmonFeatures,
-            &perfmon_features,
-            sizeof(WHV_PROCESSOR_PERFMON_FEATURES));
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to set performance monitoring features, hr=%08lx", hr);
-        ret = -EINVAL;
-        goto error;
+        warn_report("WHPX: Failed to get performance "
+                    "monitoring features, hr=%08lx", hr);
+        is_legacy_os = true;
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
     }
 
     /* Enable synthetic processor features */
@@ -2138,7 +2147,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         synthetic_features.Bank0.DirectSyntheticTimers = 1;
     }
 
-    if (whpx->hyperv_enlightenments_allowed) {
+    if (!is_legacy_os && whpx->hyperv_enlightenments_allowed) {
         hr = whp_dispatch.WHvSetPartitionProperty(
                 whpx->partition,
                 WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
@@ -2149,6 +2158,10 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
             ret = -EINVAL;
             goto error;
         }
+    } else if (is_legacy_os && whpx->hyperv_enlightenments_required) {
+        error_report("Hyper-V enlightenments not available on legacy Windows");
+        ret = -EINVAL;
+        goto error;
     }
 
     /* Register for MSR and CPUID exits */
-- 
2.50.1 (Apple Git-155)


