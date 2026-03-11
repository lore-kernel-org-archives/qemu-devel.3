Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245FA112583A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LGL-0004Kj-QU; Wed, 11 Mar 2026 11:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0LCt-0003Vi-Bs
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:10:46 -0400
Received: from p-west2-cluster3-host8-snip4-2.eps.apple.com ([57.103.69.55]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0LCq-00068w-NS
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:10:42 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 AEFEC1804E5E; Wed, 11 Mar 2026 15:10:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773241839; x=1775833839;
 bh=ocVBiiCbfqFuJ/DgB2v8laNKE69rBUiexmnNbVFv6+4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=BGjo8BEvE/dIObmpYDqmoyTOmrOfXOsN+SCgB92SdUCdIRaQZr4rd6C2tCw27RO5crWgjkw5G52It8n49Efv2Iax9vwMFzAY0004m6MrHmCy/KKyLdNY0XKTEs78EhFEjZIfUPUXqpM/pfPnIEcTOgwRxoKJ309ee0bZq0w9IrbxApcxYu2ysoQtQB44xLD4YXcP4KgWbwqFKdnNzI2QOZeL12lMRDx7yY5/U5MYqRQwr5YULDC0McZFGP+1yW+WPjujRxpuP7Wi4OZX7LRBeIM0nWjGXAGbwNDJ4fq0SjrixujcCLQGmKRcf/Bo2bS9AxN752l2o5ALBauNm4MN1A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 41A3518015DF; Wed, 11 Mar 2026 15:10:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org
Subject: [PATCH v2 3/5] whpx: arm: enable more enlightements
Date: Wed, 11 Mar 2026 16:10:12 +0100
Message-ID: <20260311151014.55915-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260311151014.55915-1-mohamed@unpredictable.fr>
References: <20260311151014.55915-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6WnhRkoYeK8ueazYIpvWbykpQ92SeqG2
X-Proofpoint-ORIG-GUID: 6WnhRkoYeK8ueazYIpvWbykpQ92SeqG2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEyOCBTYWx0ZWRfX+LmahOYqqwvh
 CAdTajWrtJ3uHuIc3sP1yGuX7Bm5KfDvf1Uw02cffTe2gyXdpvTeVZYXCn8xlBjHVzlTE6nbGg1
 5lqw+es6xsztfhe0KZONG8iaYe8Lxj7hBl+USlu48s1o+ZKoeDzfgMVFjDOLif7VCmcFMw5uUiR
 /+8LIFO5uOd9kD3c2WXPQ65CHpwklnMfrkxJ9VgBG2jrsAdhnmPvwNJMHcJ+hP0WbrhuxVX0sAK
 pCPsbbVD+tHhXgWCOX0sQUDX5f1BURu51V/pRISbqVGDAkl/q7ED+4R9WvUoAOQ+EpY5DDgwK/v
 VgU7vXrwVSr/c0AzW7eXH8/i3SJLCkUbMgFUXOceFVHskvlwN0pkS65PVzKdus=
X-Authority-Info-Out: v=2.4 cv=OZmVzxTY c=1 sm=1 tr=0 ts=69b185ed
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=qTR2NBNECMohrFtl0CEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1030 bulkscore=0 mlxlogscore=731 phishscore=0 adultscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603110128
X-JNJ: AAAAAAABK/Xh2/RcXRUdIGcJhNUxcUbtQ3YPUTfvbkwGpSBNRj/iKMuebVpt2IUDxkTSl3rnd4Z/+RZmN+gXoBmdby7XAJVADw2899Xz4th4Zb00qIwltPXS2PqbUZP6lE93iPhT9VZUvHIHNtxAtwVr7WkWNoxMAQLmToYp13Mvt8fosHumsXexY7SGv7FaioqO0ADwqbgnn0ZbPP9LOvBaagTj9w+Ajt/q3aOeL/j/ayrV+c88LXVHdPXKBPIM7ztKn5XmEJ+XhtiNsl3gDe6irsXeYgSvP/++YQQltkeHjW0NLnAuO165ERFM0oaHdpoiGmPBnjZttPoZUMOUMKGje8+Vo90AKW2ADejWxJ4IzvDEUKFEcQSZ+LBMX+Odb+nbddmgb0AkSPzdgwu6e0ophk9wItBBt3F65p8kVxfRerc4igXCEPqvvO+pxtGp3duQ6OPnAswBHkToe7cAt/W8GlZv5KgaVZUfVv7qifM+uwFcQd8xIbIbBLlMthOU7UFz3zGcubAbesm29pkmirpMV0ePPkg+MH38pWP97Wy/wiK/NumFFqEq5CHPn3ROJq63m37HGzaDq1y/elRiwAOrG83OhacXYz8m99XIBJyGkkKzxGe23gSiAfja
Received-SPF: pass client-ip=57.103.69.55;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Linux uses AccessVpRegs without checking availability and panics if it's not there. Expose it unconditionally.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/whpx/whpx-all.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 3df60a950d..9e5bc03a21 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -832,6 +832,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     UINT32 whpx_cap_size;
     WHV_PARTITION_PROPERTY prop;
     WHV_CAPABILITY_FEATURES features;
+    WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS synthetic_features;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     int pa_range = 0;
 
@@ -942,7 +943,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     }
 
     /* Enable synthetic processor features */
-    WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS synthetic_features;
     memset(&synthetic_features, 0, sizeof(WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS));
     synthetic_features.BanksCount = 1;
 
@@ -953,13 +953,15 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
     synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.AccessVpIndex = 1;
-    synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.TbFlushHypercalls = 1;
     synthetic_features.Bank0.AccessSynicRegs = 1;
     synthetic_features.Bank0.AccessSyntheticTimerRegs = 1;
     synthetic_features.Bank0.AccessIntrCtrlRegs = 1;
     synthetic_features.Bank0.SyntheticClusterIpi = 1;
     synthetic_features.Bank0.DirectSyntheticTimers = 1;
+    synthetic_features.Bank0.FastHypercallOutput = 1;
+    synthetic_features.Bank0.AccessVpRegs = 1;
+    synthetic_features.Bank0.SyncContext = 1;
 
     /*
      * On ARM64, have enlightenments off by default
-- 
2.50.1 (Apple Git-155)


