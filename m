Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B75EFC592E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYzr-0006tk-DC; Thu, 26 Feb 2026 05:53:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzp-0006r7-7O; Thu, 26 Feb 2026 05:53:29 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzn-00012i-Gy; Thu, 26 Feb 2026 05:53:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCidynVrn4nN+hr9gMiY2k2wAjYWFdNqTiarVei0QeocpsNs7CJrwQcrA3xpoTDOjSqmsNUS/eDjND7aksszaMmADNUadtpgelIBZMMK9N34VuC9KuN29uZ9psg6ef8NDa8BWf1k83ZpFsTvaBwahYuGB8MEla1zoAUVGt1Nzu2ughCDHT1/R2uNAYIgAEz8V5eJOqgViaxHCyoJz4Ss+GBlnYfpRjYIeuTfyaJ0wWJDN8Ra2JIy/zYOPV0hcxK0JDO1aKjIlKb4GFjIFatEBRX9haLWnTX38OB3mAss0z1/AYY4WqnFUlBfo2rwqK5lcYjO1tNtiif9+Lv4XVU8Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4BLP/NinOPuWVcsen0umfOn9ZCCyDrlPUaCh+VyMQk=;
 b=aZGsijlK/4JuNBS+EL63LGsBZYYW8kihckGSKj32QNXENGNegwdDO3r4/zrkzMxqrI/C8hJm3okc2X2AGqNZ3ZiJE6C/JF0IiJyAQBHlWT21UtYeekjl9R8LagS4xUrsRvFzG+I1kJqqOvNHd6nrxpa5gTJusK6WmZ8PSP+AikaL7BiEG4EF08DRlo61fwpsE9Ru6P05AdFwrRD1wPg0PbeYQOfdlU2628ZMOL2n0Cdo9xUrrD/E5Uws+6j4Qrk2sHx4Z8MBEGJVPzsna4r0MkROoQETKCz1HsHK7CjPfw5MuGzvrHHqvefpSTcwleVTrpJUz0wgr4WgLU9H6rDalw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4BLP/NinOPuWVcsen0umfOn9ZCCyDrlPUaCh+VyMQk=;
 b=sNontHsoZXdE8pFcIn9+22Zw5z2kSosv1JtNn+tIuV/1MwSwnPkZcg9Sjxk59w31o8y16jSCQYnCuhkoK0ASPcYMTIdZa1mv0TYFYbT/hf/9pIeBHP9dviKNvbvEvdqZgGgzbgaSqRhu0Gj38kL3wJWsXM4hkZ9DgNUTJ6NADvdoayMHCtqRGECETnweiHnK4WQJL1SQzkDRZtRgaF4uaA83lE5taZFLNp3uo1NMZME/lAUOprr2xKUIaFxdlV93pNmNo5/aEl9DaZ7JW9H3wBJMCtvA/5ast47a/cUbT8p0QwE0GVIMwUZITx7bOgQ5NO1eHqXgXwqGV5/0P3nqgg==
Received: from SA9P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::16)
 by MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 10:53:20 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::c7) by SA9P223CA0011.outlook.office365.com
 (2603:10b6:806:26::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 10:53:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:53:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:56 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:53 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 23/32] hw/arm/smmuv3-accel: Introduce common helper for
 veventq read
Date: Thu, 26 Feb 2026 10:50:47 +0000
Message-ID: <20260226105056.897-24-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226105056.897-1-skolothumtho@nvidia.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|MN0PR12MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4b9d99-cc6d-413e-ce8a-08de75254161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: IEP6gCz/ME+NYfhmNuEngn2oyiELe+J6mJYYa96OkPcATF7zhjdXuywCFkEVt+ApvQvceTfNWSus8ivWBq1N8MO3yHeJuIUcejxdMC5a8TfT8/C0duMmlaKmGJfBo5DyBIXgGLtLdTUZ1q6vygcH/6l0oWZd0phNmZJ1y1CYL8OAHumULHBlpP6X7Yraug2V61BAwmFMQwQ2Ox6+wzKOhPARkj6CfxDzMWmhAoQSv7nHKqw6qZy+Ple0ttOIv4kLi1ChkGQT3wt0RQv0V9Pioce9vrV+1sck8Ybvp7qNlPsR4l/sdZG9wFhXJI86wp7coAmMLujux0MX3EDXHtE1ZrMYs/duCytL1IxT8dSpmfKRRZUaBiWtTl1jYyhxm2vorj7QK1Z2wDZ0fCSyzzh40nwsTHPvOlClRh74ABoLg4ft44UmC2kGjlfPJjzlEvH9jHnT+xNJ4cmVXHOXRj2UaKEG95dpMu1crqiiMbPBM6K8BA/XchJJZX8YNrwMQ/5h2Yn1Vo01B6gDoEy/uv9ae9pYd+YQ3+OfKgGP1GIcGCq1ilJ7Ado83Sv1zQRzqs/fzcmvZwgLJnRc1KDjD6dpA9ok6qg/ULOaALBrYntQF1NtSunz0RwiIhBvzgNIBjEIp0fNXQiImrQkO5dmY16PAuSBnk+w5nErbdKvbbCNg2Lc30T7TZWRGqgF7olWvMi3auFYvsS1XQzzW/k3FLID9s9KyQsKG7eJ8JchJZX1UZKLkMEldmw86F8pvI05l8jAJzwk4C7beCJlUks88XMf/XUkwhdeDDdsvIQtPd8flA/698UQd+qsFeS3P36ZGL7wvGHMyG4s8SCiNn/ET47ACA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nAaU7slPUzO278Vv+1XhLtjqGVg2W6Km+zNXCJ6ArliqNZ2xi9s1gg0dq5KghoaBNq8m0wvPZ45hLessPVLosSJddz2vY01WoYWGu6uBWmJTTagkqufoiiC9Tgte43rXjfnK0OcS+NYgNDQeB3D1+qINHVxNcmwAafiyOAMoMgc80FSXsf79CqNLCj0FSfz9tEEJZC7Hn/G5U2thoFDRgYfVMNsDirPIfiio127Q6z2uIBSTSjcN22ypfopWkFeGu0Pi4JXa3wvHQ/jYWgmgE5gYBXruEEwom4HEQvxORIJ3WXng7ezgKbtb1uUaxatA/mPcvm5M+DQvxQBZ7SyTNdjqvxIRZc3mcJjrOcT1gV0shDqGQY/2MKM9awQ4n+A049cK/wwbUH4x7sfg7kNkSKBLHieig6qzp1re4fAQpVOU+748KKj9RoypmczxndX+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:53:20.1432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4b9d99-cc6d-413e-ce8a-08de75254161
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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

Move the vEVENTQ read and validation logic into a common helper.

The helper performs the read(), checks for overflow and short reads,
validates the sequence number, and updates the sequence state.

This helper can be reused in the subsequent patch for Tegra241 CMDQV
vEVENTQ support.

Error handling is slightly adjusted: instead of reporting errors
directly in the read handler, the helper now returns errors via
Error **. Sequence gaps are reported as warnings.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h       |  2 ++
 hw/arm/smmuv3-accel-stubs.c |  6 ++++
 hw/arm/smmuv3-accel.c       | 67 ++++++++++++++++++++++---------------
 3 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 4bff90e2c1..c349981e79 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -70,6 +70,8 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
                                 Error **errp);
 void smmuv3_accel_idr_override(SMMUv3State *s);
 bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
+bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
+                                      void *buf, size_t size, Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3-accel-stubs.c b/hw/arm/smmuv3-accel-stubs.c
index 870fc2a71c..1d5d3bb10c 100644
--- a/hw/arm/smmuv3-accel-stubs.c
+++ b/hw/arm/smmuv3-accel-stubs.c
@@ -42,6 +42,12 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
     return true;
 }
 
+bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
+                                      void *buf, size_t size, Error **errp)
+{
+    return true;
+}
+
 void smmuv3_accel_idr_override(SMMUv3State *s)
 {
 }
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index f6602f51aa..5f296ea763 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -391,47 +391,60 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
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
+    Error *local_err;
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


