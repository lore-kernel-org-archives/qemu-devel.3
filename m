Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D83C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 18:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2YJj-0003b7-4a; Fri, 04 Sep 2026 14:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x2YJh-0003aF-Ju; Fri, 04 Sep 2026 14:07:09 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x2YJf-0001kU-L8; Fri, 04 Sep 2026 14:07:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLLGLiR9h4Z9mv7pPUpG5Uy9hL+mfwLQ210WELSGG2i7n84jUZ3bv4dDY2BcBq1F9FIttcgXHjlcIKRNUSRZt4LoTlWrXicTf0iT6k9hV+0Ng7Nzp7pcoDgRWffqwOUtAYOXdyTy7eOgDv5vKCQ2H0aUwk2Lvasf9GjEGTZzaGqEyKq3yAWdam8F1g+BfPVbrWt2t4PeA/ADszRzQdhIDuVhwiE5sHXXqHF8AvLfe1GE5GxapAQTQXFi8Kwur9nZs4Z8hq8WfTf9uANki61okm53+A1/TCK9ga64Aqtx1vkapIWKFD8YHdA0SERxc6iL/2LCL8tqPuER8fq/bBeFWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuDdpObHdowphFzMNilYnyRc0L0AC0HlOZ4COdHKSdM=;
 b=OE6dwyNPRgzRLGyVy/oUQpxKrNtGraraOTyqdTMa4P9ORwwv2AJDPvKSS6VRnblC9wz4qR52mI2UcquQorh0N0gTjRhyukUys8w6Wrz2swpgIND6vtZeZ9nx9RKEN7+rAK/d0T6XgSAd9i6EYhKnthhBWIFEVLvT+CLFvHnaAO7rASisCFbd+r6k9N3DOR7x0LLoiLm2nFdMjPKO4YEZ0xNg+ioVEH0pdbwKGL89KMMITRu3fBlXTCJhkorFJoQrUcXVV7vQT0LOa3Ixf2qrQ++KxlNS0Hntf2o7t7fnbBw7Eg9XOL/ETlg8bDXrh8n+qlNTlwPeVgqpf0EMhunaIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuDdpObHdowphFzMNilYnyRc0L0AC0HlOZ4COdHKSdM=;
 b=EWNrtjFsSEqCbZdi2GMN94Y5lf4MlyXwuM3R/2qI420n/gO/MzBfam2Hn4GyTj0H6hcHAaSokeLaMzD6KgB/eaaHYJE0AtkUAFEtNPMaxbm5SuthPaT3WXrldiBR34usfueUrOr1dll97FT3Rw6p6jHvhTOwMPd/J7if6KDqhX+z+Mi1JsQ1BKMnQd3aMEulktYp6BmXpn6hNUguIop4LWYDdsfpFzjB6lxDOww/r3NXu5EPBz+HQcCOB8p7Dyg89QqVa7Lyk8JL4Cq9/MtyFuYnPr44sUSFqLdw0cYu+q13+Jyh97iw4DdyCUhnAUvxVF7iChLCr6ditsOGOm8LpQ==
Received: from CH2PR20CA0030.namprd20.prod.outlook.com (2603:10b6:610:58::40)
 by CHBPR12MB463627.namprd12.prod.outlook.com (2603:10b6:610:36c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 18:06:59 +0000
Received: from BN5PEPF00046988.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::28) by CH2PR20CA0030.outlook.office365.com
 (2603:10b6:610:58::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 18:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN5PEPF00046988.mail.protection.outlook.com (10.167.245.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 18:06:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 11:06:31 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 11:06:28 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@ziepe.ca>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <skolothumtho@nvidia.com>
Subject: [RFC PATCH 3/7] hw/arm/smmuv3: Migrate the accelerator feature set
Date: Fri, 4 Sep 2026 19:05:09 +0100
Message-ID: <20260904180513.248396-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904180513.248396-1-skolothumtho@nvidia.com>
References: <20260904180513.248396-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF00046988:EE_|CHBPR12MB463627:EE_
X-MS-Office365-Filtering-Correlation-Id: 69aa60d6-9a72-4f42-ae41-08df0aaf500d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|11063799006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: l9OVcm9ncXBphKH3voeHxKIlsTwXBq/mRPdxknJsKWaTuSdVGhGJwSxEJ8cKqwu4SJTnauCO26s3VARJjZy1HbGHvGAZWw0cW2xXC0jdLbaePs0IdfJD5L0Ld0AazEIqN1pfn4FVu6mVgnChvQVY/YSjNTQpaVQ2S9Gl4EWuVSsXlTrAI32rCY2mgDFpRzb7xLqOUYglqMDOMBDFwHzI0/JCUl7SE12QELA7ZuXcY3juOYZZ8qKOqr+4x0weUdFyGoZ+DYqWE2YMGUXOZ2CqHnHRgz/cjMyX9ravvC7y21/+pU77COVIz3jTyb7KJ/hPgMvcoxR27SEh5UwUynhW/wokvyWGgjZ37hw0J5PZMTJfAypXLSGLoq5U5qCjkpBPbkMZIrR1CBxnYz+yWaM3Oeqk127p9w56jLAZN5g6pVFApnnIGcXbvvnG4fmt1qEbTq2t0xYVmopnFaxjSJR48UVfI8r8pIbYLJS9qmwukvBw22LhKVr4sg20OWbe8ezViYFJcbmWealLI6zkmCSYGZh9K266eXxqU9cYFXJGVbIYKCaH380Iwy80B8KnghJG996PeNylC5AUvi2UKtY9NV/XLCRMxOv9AK6faWwWRxK7N/W6+ziKxrvIQmiyjLl5XqffnaFa2V1aocNs5CSG8MOTPNA4zV16vAKRRRS/P4jrmysFbk+R5Xr2zWBlNMBV7zky7b75iq5LscHyvK9N8Q==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(10067099003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VuDH9bUqfqR4/6PFxY/3LftFb4Lu5m2SF2S2q52ELCNV3vbQSExRi0NBA73crNiHZolkkGQZDGtAzVloGcnIzsHE6QH9fHMghXrQnKdQw4mQJ9hmwxTJqjuIL1VbUdL3bncneTPj/kGWlSfeBkkSN4iCjOjWfMYojkPZ69NYnTe0cg1VOTzQmegCbO0gzCjIzogaFONe9Z3bfUAa+HStJkQQ0J431lPuhl2yESvoatbOw9S+2lYm7VxPTuL4a5w+NTN26cfJvqI5cjgXhwI4IvbKuDZI2ZVZVWbGsY1fX4erLxVcK16/4f15yS3SlpCMon3r14EMYeQQrDofEEum1Eu3/B8b/GH1zVdxQpaiEvpE6+ZhjoVTu1PRjnY9hv8sVCKXdRnWPQNaIiLI+KRfY1e0byM91zk4pesgrgup0KynB3leF1f/OC8ugu+jbesB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 18:06:58.6537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69aa60d6-9a72-4f42-ae41-08df0aaf500d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF00046988.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB463627
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Add a subsection carrying idr[0] to idr[5], needed when accel=on. pre_load
saves the locally resolved values and post_load fails the migration if the
incoming ones differ. Accepting the source values would leave QEMU
advertising features the destination host cannot provide.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h       |  1 +
 include/hw/arm/smmuv3.h     |  7 ++++-
 hw/arm/smmuv3-accel-stubs.c | 12 ++++++++
 hw/arm/smmuv3-accel.c       | 58 +++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3.c             |  1 +
 5 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index ea11d513cc..a91d188d61 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -99,6 +99,7 @@ void smmuv3_accel_idr_override(SMMUv3State *s);
 bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
 int smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
                                      void *buf, size_t size, Error **errp);
+extern const VMStateDescription vmstate_smmuv3_accel;
 void smmuv3_accel_reset(SMMUv3State *s);
 SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj);
 
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index d39fe8850b..9e0836b81a 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -26,6 +26,9 @@
 
 #define TYPE_SMMUV3_IOMMU_MEMORY_REGION "smmuv3-iommu-memory-region"
 
+/* Number of IDR registers, IDR0 to IDR5 */
+#define SMMU_NUM_IDR 6
+
 typedef struct SMMUQueue {
      uint64_t base; /* base register */
      uint32_t prod;
@@ -41,7 +44,9 @@ struct SMMUv3State {
     uint8_t sid_size;
     uint8_t sid_split;
 
-    uint32_t idr[6];
+    uint32_t idr[SMMU_NUM_IDR];
+    /* Locally resolved IDRs, saved by pre_load for post_load to check */
+    uint32_t local_idr[SMMU_NUM_IDR];
     uint32_t iidr;
     uint32_t aidr;
     uint32_t cr[3];
diff --git a/hw/arm/smmuv3-accel-stubs.c b/hw/arm/smmuv3-accel-stubs.c
index b8dd7e7b89..b57b5c01e7 100644
--- a/hw/arm/smmuv3-accel-stubs.c
+++ b/hw/arm/smmuv3-accel-stubs.c
@@ -8,6 +8,7 @@
 #include "qapi/error.h"
 #include "hw/arm/smmuv3.h"
 #include "hw/arm/smmuv3-accel.h"
+#include "migration/vmstate.h"
 
 bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
 {
@@ -53,6 +54,17 @@ int smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
     return 0;
 }
 
+static bool smmuv3_accel_vmstate_needed(void *opaque)
+{
+    return false;
+}
+
+const VMStateDescription vmstate_smmuv3_accel = {
+    .name = "smmuv3/accel",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = smmuv3_accel_vmstate_needed,
+};
 
 void smmuv3_accel_reset(SMMUv3State *s)
 {
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 73509dbd8d..287ea91fbe 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -18,6 +18,7 @@
 
 #include "smmuv3-internal.h"
 #include "smmuv3-accel.h"
+#include "migration/vmstate.h"
 #include "system/runstate.h"
 #include "system/system.h"
 #include "tegra241-cmdqv.h"
@@ -1096,6 +1097,63 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
     return all_ok;
 }
 
+static bool smmuv3_accel_vmstate_pre_load(void *opaque, Error **errp)
+{
+    SMMUv3State *s = opaque;
+
+    if (!s->s_accel) {
+        error_setg(errp, "Incoming stream carries SMMUv3 accelerator state "
+                   "but this arm-smmuv3 has accel=off");
+        return false;
+    }
+
+    /* Save the locally resolved IDRs before the stream overwrites them. */
+    memcpy(s->local_idr, s->idr, sizeof(s->idr));
+    return true;
+}
+
+static bool smmuv3_accel_vmstate_post_load(void *opaque, int version_id,
+                                           Error **errp)
+{
+    ERRP_GUARD();
+    SMMUv3State *s = opaque;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->idr); i++) {
+        if (s->idr[i] == s->local_idr[i]) {
+            continue;
+        }
+        error_setg(errp, "SMMUv3 IDR%d mismatch: source 0x%08x, "
+                   "destination 0x%08x", i, s->idr[i],
+                   s->local_idr[i]);
+        error_append_hint(errp, "ril, ats, oas and ssidsize must resolve to "
+                          "the same values on source and destination.\n");
+        return false;
+    }
+
+    return true;
+}
+
+static bool smmuv3_accel_vmstate_needed(void *opaque)
+{
+    SMMUv3State *s = opaque;
+
+    return s->accel;
+}
+
+const VMStateDescription vmstate_smmuv3_accel = {
+    .name = "smmuv3/accel",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = smmuv3_accel_vmstate_needed,
+    .pre_load_errp = smmuv3_accel_vmstate_pre_load,
+    .post_load_errp = smmuv3_accel_vmstate_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(idr, SMMUv3State, SMMU_NUM_IDR),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 void smmuv3_accel_reset(SMMUv3State *s)
 {
     SMMUv3AccelState *accel = s->s_accel;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ed19536a4d..66d95e1076 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2137,6 +2137,7 @@ static const VMStateDescription vmstate_smmuv3 = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_gbpa,
+        &vmstate_smmuv3_accel,
         NULL
     }
 };
-- 
2.43.0


