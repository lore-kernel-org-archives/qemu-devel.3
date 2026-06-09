Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6EECD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudj-0001vw-Pp; Tue, 09 Jun 2026 07:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudP-0008UL-QB; Tue, 09 Jun 2026 07:28:43 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudN-0003LI-Tb; Tue, 09 Jun 2026 07:28:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1kVAE/xjo1NPy3zjsfafs9CXTTl0zqgkCUGVowZoZO9PiIFYpWP4OWu/FdtSvwlCi9RgVTGvHHftJOtWrIyIn6athqIjLFLx6x/1YCYsw0V3QkBmEmUfSRiwHFqkdyGOsB2AvLHBokLEwddWxupgnhU4VPBXBoFLv5kHiVZIIxFUik+RBbxwg0ENSf3thDSQBXX1NMs0eDP4E6x9oT6HqzW+Rw7Ss8aIM+J74DJ8dM6HcHhesXCUBdfN2cOujXBA/NnGY95NaeO34zjZR0hnuwQNs2S12VTVe+hSM2o0Bfyvx+d1wXlof9e+RxHm2TxwPOCPPOE8wcpS8IwjtAIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4Ku95of3RBe0bd+zXwmiemIgzFLvGCMocDpIu1FCUQ=;
 b=Y2zZGQrKn2RRZZOOIxOItAiKjKHoWYwv+yE7A3jCFHavcKbi/F623O9codoQ762/olo3UugArwnrVf/svLMT/h7VgA2xjJA6eQAQ+TMrsU+r4+YFdDVYQXCtS80plfxE3FuxxqqyzFvuY+G0VzHhNnOfQKg9mTn548tx4dq7WDq7g61CeiVCxlmm7Up14vgTZciTRjqyC4aXkuNnep6ZllChQgtd8x3R8qYOEl7yo4awUzKQavhGMkHAjf7J956MWRTiN2Wdd/pJ7ls8a6LpLiCxZdYBuqclrlgorHobeezgFaYae3R25scjICFD+qPsDiansVl22/SmaDdyOIEgnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4Ku95of3RBe0bd+zXwmiemIgzFLvGCMocDpIu1FCUQ=;
 b=YFyrfLCmOkvOfyTRwUlTENDiKDJvr/N71oQP3RcfhxBX72HmUx6YNjuCz4YWESaA7aYtX/YeqJqMXfAg2Td3Z2rKkYqWzSbeP/IaEHyKEX+gPFyXHb9mZUD7gkdt0Wnfti4F/Kqeql5fX1dTe2jlehk4UkLWAs4UBZzo4D+1CWFRxmgp82Y2BGd2Z4yLEdoPyTy4HXZw98CnzhU18CC9yiXh4pwWeObpiVjnA8r10iFqJCDATosytvfkwZUsux6lSi4tkJqDb9Cu2DPUGYSPX0DpFnXhAT9rzNeIrOuXpQ/3IFTr/v40vGAETNWD+Sm/0Qw8u+qlSLF8HwKfJuQs5Q==
Received: from BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::17)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 11:28:33 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::95) by BY1P220CA0026.outlook.office365.com
 (2603:10b6:a03:5c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Tue, 9
 Jun 2026 11:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:28:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:12 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:08 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 22/31] hw/arm/smmuv3-accel: Introduce common helper for
 veventq read
Date: Tue, 9 Jun 2026 12:25:43 +0100
Message-ID: <20260609112552.378999-23-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609112552.378999-1-skolothumtho@nvidia.com>
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b1d811-3c42-4a0f-18a1-08dec61a3cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|6133799003|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 2q3A7+9imoZrCMS7Ej+bDyYxpifzyvCGg6RV9zHQj8LcUghNJ5gwk8ACjfji8SeHgDeObw8TX0EkWMUE4uclOS88sQUpNtnDkmOZzEanc525YKkH9zRX86JqkQiNYgii4NWAeY8K50eX6p+OuXTtBv3r2fdJkLBVXRJIOdUif8qriIyPK/QL2g0qk3rzTqYy4P+IMNi1KLEZJG6ZYiG4AZL0sQqhhIayXiHLChc9GXQxEkHuHhfPccj632R7qwGMz+kVwOH4SZ7E6AgzacQTyXwcIP//KjTDPmzuReUuNfli1e6iRSI7nbWcR2KaQAqez2gFIPj+Q57mbUepjlQClI6piDKs34bROiX8BCkhrSnMjHAOuG9/TNZci+jq0vOYXtbaVHdYCQ/FptavAp1lQwX9DsgCilUc1gTz1Lqb4pkZWoT2Pm3oJbtN6wXDTagpHhGEplx9947GtCHEqE6WlnQW2QWfZZoU03NS9gs1Igw+8qr8XWjawdUpU4as0JY0XyJztnr+JJ6nGl1q7KFAF94CQ4vPwno4YsPwPuAW96rO8RGIZMAbQ7gEar9xmoXymhiicOdubTLpgpVUd5f85kMbUR8GFjxaVVo4ttv8EJeZHJhdUHmMwqIwiBJgVfrfhsUejmarM1qxZKQazH+CCDEeUNPDfZskO0oCnorTM7aCj2UaIL+uKQSze6WJ6fOYIq5XqxHQsC5jCXotuMc7OCijh+CRMiB1qgPcjUr7Arc=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rUHQFGxQPAA5+fhSzj0p33/J+4Ik0lYauhq3TFzerqR9APEuIdGn90+LjLLAf4ZhlK5dde0eYwd8Q8MFR6BUBNjpJHbm8z0nZI8teAijEPp0dHzEJgASXmIJhPy239HQPMnb/lza5dLddpqoTXxdg6z4MGS2KxlME3SnsHBUfknLMgmUP5BCbC9MSSsy6mdfH+Ha05HNCElr08QPHB70fDAb0HpxTVILR4uhQqO7cxzgP9/WAgXp5zHQvb7xA0ye6mfNwu9GN4zgo7mQBeQTFL3rVF7lzatqd6q/P2Gbf23dpeuy4hJaWkViUyiJV2ZFwtX1bYdryK7j2EqqYKdHtHBIEuRbf4OlkVGPNbJO4nI8THMDZIhcwspli9UZFPBCogwYvf7vMJvf8HIyZi2Nmaf5u5lU14a65V0F3GqGJr8TxkRiwM0kiJRSU+E1jCnb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:28:32.5776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b1d811-3c42-4a0f-18a1-08dec61a3cf4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Move the vEVENTQ read and validation logic into a common helper
smmuv3_accel_event_read_validate(). The helper performs the read(),
checks for overflow and short reads, validates the sequence number,
and updates the sequence state.

This helper can be reused for Tegra241 CMDQV vEVENTQ support in a
subsequent patch.

Error handling is slightly adjusted: instead of reporting errors
directly in the read handler, the helper now returns errors via
Error **. Sequence gaps are reported as warnings.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h       |  2 ++
 hw/arm/smmuv3-accel-stubs.c |  7 ++++
 hw/arm/smmuv3-accel.c       | 67 ++++++++++++++++++++++---------------
 3 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index e0bbec8581..8d0f636338 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -87,6 +87,8 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
                                 Error **errp);
 void smmuv3_accel_idr_override(SMMUv3State *s);
 bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
+bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
+                                      void *buf, size_t size, Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3-accel-stubs.c b/hw/arm/smmuv3-accel-stubs.c
index 70cef66966..9e6c44a282 100644
--- a/hw/arm/smmuv3-accel-stubs.c
+++ b/hw/arm/smmuv3-accel-stubs.c
@@ -47,6 +47,13 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
     return true;
 }
 
+bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
+                                      void *buf, size_t size, Error **errp)
+{
+    return true;
+}
+
+
 void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 3ceca56a67..c1c2a67c97 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -440,47 +440,60 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
                    sizeof(Cmd), &entry_num, cmd, errp);
 }
 
-static void smmuv3_accel_event_read(void *opaque)
+bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
+                                      void *buf, size_t size, Error **errp)
 {
-    SMMUv3State *s = opaque;
-    IOMMUFDVeventq *veventq = s->s_accel->veventq;
-    struct {
-        struct iommufd_vevent_header hdr;
-        struct iommu_vevent_arm_smmuv3 vevent;
-    } buf;
-    enum iommu_veventq_type type = IOMMU_VEVENTQ_TYPE_ARM_SMMUV3;
-    uint32_t id = veventq->veventq_id;
     uint32_t last_seq = veventq->last_event_seq;
+    uint32_t id = veventq->veventq_id;
+    struct iommufd_vevent_header *hdr;
     ssize_t bytes;
 
-    bytes = read(veventq->veventq_fd, &buf, sizeof(buf));
+    bytes = read(veventq->veventq_fd, buf, size);
     if (bytes <= 0) {
         if (errno == EAGAIN || errno == EINTR) {
-            return;
+            return true;
         }
-        error_report_once("vEVENTQ(type %u id %u): read failed (%m)", type, id);
-        return;
+        error_setg(errp, "vEVENTQ(type %u id %u): read failed (%m)", type, id);
+        return false;
     }
-
-    if (bytes == sizeof(buf.hdr) &&
-        (buf.hdr.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
-        error_report_once("vEVENTQ(type %u id %u): overflowed", type, id);
+    hdr = (struct iommufd_vevent_header *)buf;
+    if (bytes == sizeof(*hdr) &&
+        (hdr->flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
+        error_setg(errp, "vEVENTQ(type %u id %u): overflowed", type, id);
         veventq->event_start = false;
-        return;
+        return false;
     }
-    if (bytes < sizeof(buf)) {
-        error_report_once("vEVENTQ(type %u id %u): short read(%zd/%zd bytes)",
-                          type, id, bytes, sizeof(buf));
-        return;
+    if (bytes < size) {
+        error_setg(errp, "vEVENTQ(type %u id %u): short read(%zd/%zd bytes)",
+                          type, id, bytes, size);
+        return false;
     }
-
     /* Check sequence in hdr for lost events if any */
-    if (veventq->event_start && (buf.hdr.sequence - last_seq != 1)) {
-        error_report_once("vEVENTQ(type %u id %u): lost %u event(s)",
-                          type, id, buf.hdr.sequence - last_seq - 1);
+    if (veventq->event_start && (hdr->sequence - last_seq != 1)) {
+        warn_report("vEVENTQ(type %u id %u): lost %u event(s)",
+                    type, id, hdr->sequence - last_seq - 1);
     }
-    veventq->last_event_seq = buf.hdr.sequence;
+    veventq->last_event_seq = hdr->sequence;
     veventq->event_start = true;
+    return true;
+}
+
+static void smmuv3_accel_event_read(void *opaque)
+{
+    SMMUv3State *s = opaque;
+    IOMMUFDVeventq *veventq = s->s_accel->veventq;
+    struct {
+        struct iommufd_vevent_header hdr;
+        struct iommu_vevent_arm_smmuv3 vevent;
+    } buf;
+    Error *local_err = NULL;
+
+    if (!smmuv3_accel_event_read_validate(veventq,
+                                          IOMMU_VEVENTQ_TYPE_ARM_SMMUV3, &buf,
+                                          sizeof(buf), &local_err)) {
+        warn_report_err_once(local_err);
+        return;
+    }
     smmuv3_propagate_event(s, (Evt *)&buf.vevent);
 }
 
-- 
2.43.0


