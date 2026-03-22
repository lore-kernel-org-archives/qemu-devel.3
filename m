Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE17D58CA3
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2026 22:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4Rcf-00083O-6q; Sun, 22 Mar 2026 18:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4Rcd-00083E-Eu
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 18:50:15 -0400
Received: from p-west3-cluster5-host5-snip4-9.eps.apple.com ([57.103.72.52]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4Rcb-0004yG-7Q
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 18:50:15 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPS id
 0EF631800130; Sun, 22 Mar 2026 22:50:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774219808; x=1776811808;
 bh=2GvRGzc1MRHwmLUZVIfY+An7ZJn+U4NKEHF+iW/SlLc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Mk8Y/NpuxuClXchXGUDoczyalYGV/l/OnfTJLWTLlweLVO4mCkyiBm3OOIxYG7T1t+elUQ5Ox3MP2GgqGsI/nrINuvKxdi1nX5Be6IM9iWGD2D2fJ5l2j+kYsimJBcaZK0Xr8R6zLaGwO5ObyROyLmZop31xQgAAPeOYYW+8H4m6YioDUWScCFDTRRw10CLQEUfBLylBmJmlw5XzWlVFRhDaF3RDy4X56GLMfSHFytl/5Dgw0nL6NnUqFb0wDftpo/JQrWss6cFH62xDBiMIy7OJX7nra91et2PcsEwxnau27o7lyiZo/WtyrdNZYNCyCDpYeRhdhdP9HkU9+tG5Jg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPSA id
 A4C4F1800102; Sun, 22 Mar 2026 22:50:06 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH] whpx: i386: workaround for Windows 10 support
Date: Sun, 22 Mar 2026 23:49:53 +0100
Message-ID: <20260322224953.63297-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=OZ+VzxTY c=1 sm=1 tr=0 ts=69c07220
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0RUPog5Yt9CtxV4tMQEA:9
X-Proofpoint-GUID: mQbC6iKO1tuWyN9wr2hppEwaJSYyOK1R
X-Proofpoint-ORIG-GUID: mQbC6iKO1tuWyN9wr2hppEwaJSYyOK1R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIyMDE5NyBTYWx0ZWRfXym2VEa2QL1uC
 zb6/zDCprwMPXh+w2uBY2I9v8KIXHqmSIGPTiAxJm8GJiY8mYG6ujjiq7r8ZFVd9A8Mklh7HuT1
 hGkwYQ8AWuG8OARB5QyVxT+6fL2TGTjoqNl2H+L2wf6CZ3twG8E1jQZrqcmW1eo+wDpxwwGhlvX
 MmIuL6GCTgjzrK+kzfMjLxwCri7wT6rtQiMHspVjY0w/8RdFJr5J5FP5CP2+ESkz652YsJ0ZRCt
 BnUpCtnyMDfSXp3XZmoG97VYIZMfZIK+H2A7FRjiJxNv1rfyKUz0sv5E2NmFDZ7q2dmloTI4K+e
 GhSyPbQmn36la8Tk98u4LsTVFDbw9X2w2rmHsXcQ2qRwLd3iIYU1UshUCZ8E1U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-22_07,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1030
 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603220197
Received-SPF: pass client-ip=57.103.72.52;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


