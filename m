Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE5EFD7F93
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 19:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw3Ah-0003GN-C6; Fri, 27 Feb 2026 14:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vw3AX-0003EQ-E0
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:06:34 -0500
Received: from p-west2-cluster3-host10-snip4-1.eps.apple.com ([57.103.69.74]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vw3AU-0006R6-AU
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:06:33 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id
 6B839180029A; Fri, 27 Feb 2026 19:06:26 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772219187; x=1774811187;
 bh=x5vmcSdYHKQ1byZOmRZeGIdImPo+Cp8DSOTH0Tm5/x8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=fiRKPHAbhLtbIi4NhOjRl/OvlnKUev0dEbI4z90DCSGY9gNue+vNMTaGmClNVON36TXD05Rrr2buUxVn9Z+T7BobspoDUBJI57W42gAf7XEg0v7qWX1JqDZOpRed/07RP/hIv33x1kpxn5P9fC+IYcOuDnOwpXZtRzvENJdbup9XBCKXD2QqFtniKLA+PdIuZQUDtp46Hh81cQ5M9JwVPJw4Kly3rkks7LKNYUU3YzMuqtIjSUnLzw2BRbKE8UXDvniRbsG2qXJMv2jK9bhPennwf3sr0/4u7cd1R8Bf1jbakyTJhKpqkPcitQgcDdEcZq4YMqozvC/FdU0i3BwuOA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id
 EBB8818000A3; Fri, 27 Feb 2026 19:06:24 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH 2/4] whpx: i386: enable all supported host features
Date: Fri, 27 Feb 2026 20:06:17 +0100
Message-ID: <20260227190619.8867-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260227190619.8867-1-mohamed@unpredictable.fr>
References: <20260227190619.8867-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=a9E9NESF c=1 sm=1 tr=0 ts=69a1eb32
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=268zvHjo1I8v1SDp_XwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE2OCBTYWx0ZWRfX7q1Em4Ix0omU
 yR1nONPhsiibmXM9xElV07wcoeSBEZZTgbBEw2ryu3Qnmfj+t6R0k8bzfopn5PPLbJUCdoABcxN
 VDKFmvwja5xRazabUmd6qGNURw4JMpv0M3fo7Uc1rdOx4OuF6+s1M6XcTDtrJ0XZWgGGxawv+Ng
 62cqVEJyOXD8JzrT3C1JAl/t4v4PMdldGM84c4Xa2p0fME70XiYIOmb29UxDrRNfwIOpFBYLT4j
 X/N1U24BmC+qrMGh46bdnNvJEFIl+z4OYSvYSVNPpWTrhsxNsIw8Ppu2AkQWK0KJoEe8mneE6c2
 Z/Asug/nRFJZgy2ae2UuR+fg76yVSq0nSjRcLG9yPxv/P1fkYxeVysMBvhe80k=
X-Proofpoint-GUID: douEmjVZadDod2LZlLKH4PzJcBoce-yH
X-Proofpoint-ORIG-GUID: douEmjVZadDod2LZlLKH4PzJcBoce-yH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=800
 lowpriorityscore=0 phishscore=0 mlxscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602270168
X-JNJ: AAAAAAABrBtT7Xfbki2xEF7f4AYjz8AmlDmyEO7OULyLE5NwRQX1nXFeMEsC7O370PtZ/G3x/Qpj+9eB5NV2qPgi7c5nItD1tCx09a9Bl28w2pZZ3k1vC7HVn5Vb99qViDGU0LIapBvf7WL2NuwwdSJPbnG+3nDti4Vl2DTBmmpIzTGdJBx7J2y+fghHzWLwi7EW7qIE/1tg0tffERJyK4q1VvB5vjkSO3f32GNjg+vsnp52Qv6rN0wsr/nLHmunf+ud222a74JPDreJPar/kda/V0mgSMKJ+QSzeNic23Qk/IP6sCUXgIsyXsSttPbT+xudZgXfYe1+PZqr9hTGr5zQCGeBgXT0txGgd1YEprVVsRqtvZR0fgUgEUH8P7RZWAU+dXIo7lF17/r2g3Sc7OxOiQ8/gvvaTHtQYKAY/AxYjvzvDA/0C+HsiqJSYvrIOPawnkbhRCs4riQOe8O8q0lVuADGZIeqDLOXBOhu+c/eNRJUR7yHrpxIhZsg6URl+5mHReSfTB+aCPSWsXwX5tlP0Q7rmQQLeZH21snzVF2YZEu7pa0PK+vJfHGLeBRXHQa9y3cKlyUlLYLFsNXAF9oriyI/1xhzXy8DKnwOtO6ia9aUaqrpCTRu1A==
Received-SPF: pass client-ip=57.103.69.74;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 90f51fc4dd..ccc52d1f96 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2007,6 +2007,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     UINT32 whpx_cap_size;
     WHV_PARTITION_PROPERTY prop;
     WHV_CAPABILITY_FEATURES features = {0};
+    WHV_PROCESSOR_FEATURES_BANKS processor_features;
 
     whpx = &whpx_global;
 
@@ -2112,6 +2113,45 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         }
     }
 
+    /* Set all the supported features, to follow the MSHV example */
+    memset(&processor_features, 0, sizeof(WHV_PROCESSOR_FEATURES_BANKS));
+    processor_features.BanksCount = 2;
+
+    hr = whp_dispatch.WHvGetCapability(
+        WHvCapabilityCodeProcessorFeaturesBanks, &processor_features,
+        sizeof(WHV_PROCESSOR_FEATURES_BANKS), &whpx_cap_size);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get processor features, hr=%08lx", hr);
+        ret = -ENOSPC;
+        goto error;
+    }
+
+    if (processor_features.Bank1.NestedVirtSupport) {
+        memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
+        prop.NestedVirtualization = 1;
+        hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeNestedVirtualization,
+            &prop,
+            sizeof(WHV_PARTITION_PROPERTY));
+            if (FAILED(hr)) {
+                error_report("WHPX: Failed to enable nested virtualization, hr=%08lx", hr);
+                ret = -EINVAL;
+                goto error;
+        }
+    }
+
+    hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeProcessorFeaturesBanks,
+            &processor_features,
+            sizeof(WHV_PROCESSOR_FEATURES_BANKS));
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set processor features, hr=%08lx", hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
     /* Register for MSR and CPUID exits */
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ExtendedVmExits.X64MsrExit = 1;
-- 
2.50.1 (Apple Git-155)


