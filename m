Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABA5EC1430
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxO8m-0005GO-7b; Tue, 03 Mar 2026 06:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxO8T-00051E-AV
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:41:58 -0500
Received: from p-west1-cluster6-host11-snip4-7.eps.apple.com ([57.103.67.10]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxO8R-0001ZS-E4
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:41:57 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-3 (Postfix) with ESMTPS id
 9969E18001BE; Tue,  3 Mar 2026 11:41:49 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772538112; x=1775130112;
 bh=ENulIaYe1hrBKX4sy4ybjhPR8v1QLe7vH2WpJAvLr7c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=USJela9l9qypoTe25SJrzFsicsr4zDiw5vQTetEgCa3GdPZ3kgu/dsY6kD6N5Q5y5kMU17oDHZEwiSBvSyzzAGWCPh2F6pGc/TfyIWfYVohjhniG61BzQprmwSzItMvwY3uM1C9fKOM1qLJFR5eCTFiskUzO9KMI9y7t9rxvWvQp10tzsWSGO8SyFzu/5fB4tigkN2jbQPypT8kzt9t8uk1jKeVwkSKHiEzMPjHwSl/36XQNCqWY+dMfWLSNf9OtuFGkBI/KXXg4uFcZ6+0PNpsvA4tsPLO8fm0mcG44DpawXOtwLMc1di5wlgciaVn5W0bt/VA5/vF8RAh4bOH9Hw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-3 (Postfix) with ESMTPSA id
 55361180018D; Tue,  3 Mar 2026 11:41:47 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 4/6] whpx: make Hyper-V enlightenments configurable
Date: Tue,  3 Mar 2026 12:41:33 +0100
Message-ID: <20260303114135.15390-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303114135.15390-1-mohamed@unpredictable.fr>
References: <20260303114135.15390-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA5MSBTYWx0ZWRfX4C7KV3f8j+Xy
 GSpbkUFT940n4QqHK3lwejkfH18CL+yZ4dgP/27VrTjyGYhLeO8HjWpWzzl64t4IMG3o6/tJ2S8
 28+2VH6Yoke+UcnkM6ROQ3ACgMm50W8F3T5qNblzSNfI9tHbQ3fR0ccjE/mENHtcYsovdHRvdOK
 nvIXvCI4qv5TmDfNCQ2hvO5bO/Ae5Fz4Z9KltRpA9Z5SSAfIJpuG31ijF0g998O45HwDPWrrfk1
 mCneMfMQaIX2uXsWylkj/TS5sZ5Hn7j6PvxGBJtaccNWzf/SI4YhKkiojylZOI+9DS4VX///5rj
 6zR4PLHbpf7+9ndH6HCfupMbsSZF6sP+W+gQ4zjRI4kwgXIh4UNNSd+HImlI4g=
X-Authority-Info-Out: v=2.4 cv=IuITsb/g c=1 sm=1 tr=0 ts=69a6c8fe
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=BRqF0JgGwH6LvUrOcfoA:9
X-Proofpoint-GUID: Nc0Gy-h24n_64VIQ5rLCvkml7XhccyEV
X-Proofpoint-ORIG-GUID: Nc0Gy-h24n_64VIQ5rLCvkml7XhccyEV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1030 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030091
X-JNJ: AAAAAAABfCeNVSDZBB5M76o1XP0NwdVnMN7ZGnU503lUDoLgq0FjVgX9VYzxKvi+dW96PseBUukatFXmpNaINDy44kzVwW3VbSl55e+e3rnDG36DqL3r3BXX9M/C03Yk/OXbrXYra/74m5CA+AppctRAi5xd4GOTtrCJ0pieTN5qUlRb4tqB7O9e6Ng9jPBSH/7NSs+OOJJOyQ28KGXbGthmEX4rffOXG1Tm0tuw4TlKim5zYTPBLjDbK7anbR6y5IxsgwgriLsxAlRdofU1fy7bfQmWtz8Iw0JBHzOfSA2laDqcihufWAUqPzYrXG69LBrLtZjNp32w0lrS+hheTj0juT6cBMXfQknoASjxn48cstqVcxEfHLroyy0XsKMJ3SKsci8qJ5HMSU+8801ZtANPd23yrAuj7F//8ej2AjJsJccXsGiF4yHOe5xF/8SWcC7YZfHtKPLTND2xWKGW+oRsVUGz5LfaZAGaABPdOzGOw9Pdyo2CqC1fXjxJIoWIdywoMKq8nyLqwnQKnymCTsbrHPuFOXNNxrdiNslL9b7bUbukKsPtslZVTm2U1D2Vdz0bV2q8DlreZMlkqyzI+Qf/oXA2eABQlu6+aAm/jaxE6BjdJQ2VctIw4L/pGIPe1U4SBWEvJniy/TWkcky29ff0amdZO/zmoeIiiKyA9p9f7WDCxdSdYBJE19HOGCx2PvE2hXlYJ06CFSspAKerCm/m808E
Received-SPF: pass client-ip=57.103.67.10;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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

Have them be a machine option instead of a CPU one, to have something available, even if not ideal...

The existing Hyper-V enlightenments configuration mechanism is part of per-CPU configuration, which happens too late for this.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-common.c       | 43 ++++++++++++++++++++++++++++++++++
 include/system/whpx-internal.h |  4 ++++
 target/i386/whpx/whpx-all.c    | 20 +++++++++-------
 3 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 4863fc8663..a75d4338e2 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -25,6 +25,7 @@
 #include "qapi/qapi-visit-common.h"
 #include "migration/blocker.h"
 #include "accel/accel-cpu-target.h"
+#include "qemu/target-info.h"
 #include <winerror.h>
 
 #include "system/whpx-internal.h"
@@ -470,6 +471,40 @@ static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
     }
 }
 
+static void whpx_set_hyperv(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    struct whpx_state *whpx = &whpx_global;
+    OnOffAuto mode;
+
+    if (!visit_type_OnOffAuto(v, name, &mode, errp)) {
+        return;
+    }
+
+    switch (mode) {
+    case ON_OFF_AUTO_ON:
+        whpx->hyperv_enlightenments_allowed = true;
+        whpx->hyperv_enlightenments_required = true;
+        break;
+
+    case ON_OFF_AUTO_OFF:
+        whpx->hyperv_enlightenments_allowed = false;
+        whpx->hyperv_enlightenments_required = false;
+        break;
+
+    case ON_OFF_AUTO_AUTO:
+        whpx->hyperv_enlightenments_allowed = true;
+        whpx->hyperv_enlightenments_required = false;
+    default:
+        /*
+         * The value was checked in visit_type_OnOffAuto() above. If
+         * we get here, then something is wrong in QEMU.
+         */
+        abort();
+    }
+}
+
 static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
@@ -498,6 +533,11 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "kernel-irqchip",
         "Configure WHPX in-kernel irqchip");
+    object_class_property_add(oc, "hyperv", "OnOffAuto",
+        NULL, whpx_set_hyperv,
+        NULL, NULL);
+    object_class_property_set_description(oc, "hyperv",
+        "Configure Hyper-V enlightenments");
 }
 
 static void whpx_accel_instance_init(Object *obj)
@@ -507,6 +547,9 @@ static void whpx_accel_instance_init(Object *obj)
     memset(whpx, 0, sizeof(struct whpx_state));
     /* Turn on kernel-irqchip, by default */
     whpx->kernel_irqchip_allowed = true;
+
+    whpx->hyperv_enlightenments_allowed = true;
+    whpx->hyperv_enlightenments_required = false;
 }
 
 static const TypeInfo whpx_accel_type = {
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index e7b915ccbf..abea3ddeee 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -41,6 +41,10 @@ struct whpx_state {
 
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
+
+    bool hyperv_enlightenments_allowed;
+    bool hyperv_enlightenments_required;
+
 };
 
 extern struct whpx_state whpx_global;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 915d79152e..4968a5a3e4 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2219,15 +2219,17 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         synthetic_features.Bank0.DirectSyntheticTimers = 1;
     }
 
-    hr = whp_dispatch.WHvSetPartitionProperty(
-            whpx->partition,
-            WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
-            &synthetic_features,
-            sizeof(WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS));
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to set synthetic features, hr=%08lx", hr);
-        ret = -EINVAL;
-        goto error;
+    if (whpx->hyperv_enlightenments_allowed) {
+        hr = whp_dispatch.WHvSetPartitionProperty(
+                whpx->partition,
+                WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
+                &synthetic_features,
+                sizeof(WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS));
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to set synthetic features, hr=%08lx", hr);
+            ret = -EINVAL;
+            goto error;
+        }
     }
 
     /* Register for MSR and CPUID exits */
-- 
2.50.1 (Apple Git-155)


