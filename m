Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346A2FC590F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 08:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvX0a-0004vg-Od; Thu, 26 Feb 2026 03:46:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvX0U-0004tv-G6; Thu, 26 Feb 2026 03:46:03 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvX0R-00053U-N5; Thu, 26 Feb 2026 03:46:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yN1kRMmA0DZ7M5C9tYmXWdDImSE5wovLVOC7wzLE1tgurJwNGLnl9YNyWOnvbxf99F/M2Nl1EE0kBrF1/wJMkKMQCWgd0ORa2z9O6JEvtGWUkhUzLMxB0a24h5NG4H0uQXeaK5Lt4ypizNa8kAaJgfCggGObkE9dw3VmwOKv9SV10sHPf352vSkzdZ69OQACqaIt1SED8yFLe8cWnX8EFyBuHTMgDH68Qnk9qxzPqE2BHXTcyPCnbqffQJctR0yPBC5/d47A3iRD4nDkVEvapevY1gZUgAX/lqVUU3NsLHxlxqqHlfWPx5pPaiWzZEizFds09+evFPktETwGNDvNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Moxa23sTz6WJISn3YNhhHYEne9Lcbc5VZsMZVvuAy1s=;
 b=y9KFiynviLpLJsqDRKHEkf6voTnNfgmQ2diy1zC6mvJRvuayajz/mq+xCKfb5Msolw0FCJvhtw6oeCg9rhLlwfgQ42zzypjr3JfjEz7FEIXvnB1tfiaZHA7lWrCCbS4objMKy70j+HQue0COXb8CvQHBMfVQ+tvw9eCs6YIvmYyuoIiA/eNWaZg6GS+YerKU9hloC6M5FM99pdCAOHAyiTR1w8NptU2291Sp0Z5bKU3DT0FVG8gCVdQN9TrR5wKo8lS8FPsxT0iEWmjcqhQjFdfnmwk3h2DgKuHxJtO8VeFcNdoNsHRc4WzqGjiEf6HpXOrrO7CfEizQxxhbEjRnrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Moxa23sTz6WJISn3YNhhHYEne9Lcbc5VZsMZVvuAy1s=;
 b=aJs6GU6OL+SmLK/QPt95Q5caBdbQGPE8XUvKi1MBWSFU6Yxv8p9qutsfowkwUTpLoiVCKEqN7rMIwier/k88UIOYRrcAKuzXBKxPoUgefOMstaMxQ2A8OcTZPAJkWXfM0DQjg1/a+tXmyDjvNzdInwu+Ib/fNyg62cwaAB6cD8QbjPXnfs1p6zVbkJAh2NVhrLxhzWCIJm8WbJsWCLrrRScX+ItNvH+BMQxupdOEVekGKY6lc0VttLfn46XdiPqXUYz4SkL9lh2qOqjifKg/pc55cdP/9UtSn1X4WdAirS9qN6BWqfQIFopseb/xt+ajXOTzeKNWH9K1gh8tps5aJw==
Received: from CH0PR03CA0325.namprd03.prod.outlook.com (2603:10b6:610:118::31)
 by IA1PR12MB8222.namprd12.prod.outlook.com (2603:10b6:208:3f2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 08:45:52 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::77) by CH0PR03CA0325.outlook.office365.com
 (2603:10b6:610:118::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 08:45:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 08:45:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 00:45:31 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 00:45:28 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <philmd@linaro.org>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for accelerated
 SMMUv3 devices
Date: Thu, 26 Feb 2026 08:44:54 +0000
Message-ID: <20260226084456.112142-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226084456.112142-1-skolothumtho@nvidia.com>
References: <20260226084456.112142-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|IA1PR12MB8222:EE_
X-MS-Office365-Filtering-Correlation-Id: 16320b75-2191-421d-7ee8-08de751372a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: 8j3JrlpHHt5c60nUw4H348RWTKwCE1zV/SzzXY+7pgSMBEvLzr1y0urWDk0TF6SW2BMn7uuHdaSb6SmSmlYluMHyNOeoEBM5N17RhCKH6+9BGTRnQX37/TvaeBz3YPPHeHZKJo8HlafX7Tz6CGMGWIjyCnHeocK3/OqXyl9OrNs2oi+L56AKOohZ+ATCmNa+3YadgFikCX4hNaIb1xYPxMdW926r5Bryn970wRL/pjT4vl4jmFSYsnnLUDaGHVRcOmd2w1+iTrfNkpIExAeSJCoiTsn6uLnrLYbnWD6F0dIA7pzJh0+7p1+A0bc/vvW2lpUSVATYaH1fUVlhzTCNJKy6+irDRJ/YngaXiIf/qgZb/zGw3VMYjSUsH0kteqfRop1rRMPiKp36p93JEgMMth+9xnDaPKsEDpusS8pgtS96Pp27450YTDuv0+LAP0j9I2z3xq95UmyDWt7zu/mAMVGNfVFaPdrPYhT+zI7bQetFiqJCoz6HJivCr6Frw+UzHfvedDAe11XZSbqkJv3+pvDPToTvfoS0/XP7K1ibU20X529Fh9YPBfx+N7qrQns3q+xY24+7nxNw6Hyf1TkOKDUlXHrtFBbaHmJ/93slcjPvExQs8qMju0JRBrhVAFtcRX1AquTyNdQuFWcdc5do5st1bXVg1zZ7p285EfDncGU4aM4PdyFsNVeGjJ2yosWYki9Lf3x6yfA8xAQOng9HJnWMtZt0nOERQ6bYPRzgrGSDD9vtXkC7PnYL1HML2CL/DLU40MZKOm3wWbgUSb9Ufpf/4wmH2nt2QJaMWpzKgXFeYdQ8iWRyYGBazDiJ3p0EBOJs0HdkFO00MqWr+31fFQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rioxQHukd2Fk0jpi1CC6cEQtSBEcf4Drsy2/NFcc/1BZCTeQMXkrW3+S/44MfsYuooD7m4y4CulBOJV9dQlb4GohcMsqCLDkjj8BX6lbx2ApKlfsx4tGGtBxb5i48esY8F2JO2SSDTqNOF9MfL3zFnv+3e6FUSo85nl5P6VmXRi5qXmXRLZ0bdi8yCa2SekJVUUheC5/WM6a91QEUK/C3KQbdPBsZiWRWY0abCoW95/Kn9q/D5GE0u7YMn7lbfMOvKwiODZYzsIpmADJRY6SvrMZmysFSGxbTx1V/ToW0eWUXGQ4bhqn2O8jRo3xnR4iFHGFPj8yzIzUrq0+20kJ32c4j8h8Dy6/I4gV2joRf1qHXi76VsMhEHGYVMHVOFrU0X8pPW1gD4C29KpjPC33SVgwsB3FEH4dEMhi/UWavA3Gd6GQkJeAGsAqHa3WY+vK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:45:52.0083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16320b75-2191-421d-7ee8-08de751372a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8222
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Nicolin Chen <nicolinc@nvidia.com>

When the guest enables the Event Queue and a vIOMMU is present, allocate a
vEVENTQ object so that host-side events related to the vIOMMU can be
received and propagated back to the guest.

Allocate a vEVENTQ only when both of the following conditions are met:

  1) The guest SMMUv3 driver has set EVENTQEN = 1 in SMMU_CR0.
  2) A vIOMMU exists (created when the first VFIO device is attached).

These two conditions may occur in any order.

In the cold-plug case, the vIOMMU already exists before the guest
driver probes. When the guest sets EVENTQEN = 1 during driver probe,
the vEVENTQ is allocated at that point.

With hot-plug, the VFIO device may be attached either before or after
the guest sets EVENTQEN. If the vIOMMU is created first, allocation is
deferred until EVENTQEN = 1. If EVENTQEN is already set, allocation
happens when the vIOMMU is created.

In all cases, allocation is triggered when the second required
condition becomes true.

Errors from command queue consumption and vEVENTQ allocation are reported
independently as the two operations are unrelated.

Event read and propagation will be added in a later patch.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h |  6 +++++
 hw/arm/smmuv3-accel.c | 61 +++++++++++++++++++++++++++++++++++++++++--
 hw/arm/smmuv3.c       |  6 +++++
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index a8a64802ec..dba6c71de5 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -22,6 +22,7 @@
  */
 typedef struct SMMUv3AccelState {
     IOMMUFDViommu *viommu;
+    IOMMUFDVeventq *veventq;
     uint32_t bypass_hwpt_id;
     uint32_t abort_hwpt_id;
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
@@ -50,6 +51,7 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
 bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
                                 Error **errp);
 void smmuv3_accel_idr_override(SMMUv3State *s);
+bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
@@ -80,6 +82,10 @@ smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
 static inline void smmuv3_accel_idr_override(SMMUv3State *s)
 {
 }
+static inline bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
+{
+    return true;
+}
 static inline void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index c19c526fca..f703ea1aac 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -390,6 +390,19 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
                    sizeof(Cmd), &entry_num, cmd, errp);
 }
 
+static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
+{
+    IOMMUFDVeventq *veventq = accel->veventq;
+
+    if (!veventq) {
+        return;
+    }
+    close(veventq->veventq_fd);
+    iommufd_backend_free_id(accel->viommu->iommufd, veventq->veventq_id);
+    g_free(veventq);
+    accel->veventq = NULL;
+}
+
 static void smmuv3_accel_free_viommu(SMMUv3AccelState *accel)
 {
     IOMMUFDViommu *viommu = accel->viommu;
@@ -397,6 +410,7 @@ static void smmuv3_accel_free_viommu(SMMUv3AccelState *accel)
     if (!viommu) {
         return;
     }
+    smmuv3_accel_free_veventq(accel);
     iommufd_backend_free_id(viommu->iommufd, accel->bypass_hwpt_id);
     iommufd_backend_free_id(viommu->iommufd, accel->abort_hwpt_id);
     iommufd_backend_free_id(viommu->iommufd, accel->viommu->viommu_id);
@@ -404,6 +418,41 @@ static void smmuv3_accel_free_viommu(SMMUv3AccelState *accel)
     accel->viommu = NULL;
 }
 
+bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
+{
+    SMMUv3AccelState *accel = s->s_accel;
+    IOMMUFDVeventq *veventq;
+    uint32_t veventq_id;
+    uint32_t veventq_fd;
+
+    if (!accel || !accel->viommu) {
+        return true;
+    }
+
+    if (accel->veventq) {
+        return true;
+    }
+
+    if (!smmuv3_eventq_enabled(s)) {
+        return true;
+    }
+
+    if (!iommufd_backend_alloc_veventq(accel->viommu->iommufd,
+                                       accel->viommu->viommu_id,
+                                       IOMMU_VEVENTQ_TYPE_ARM_SMMUV3,
+                                       1 << s->eventq.log2size, &veventq_id,
+                                       &veventq_fd, errp)) {
+        return false;
+    }
+
+    veventq = g_new0(IOMMUFDVeventq, 1);
+    veventq->veventq_id = veventq_id;
+    veventq->veventq_fd = veventq_fd;
+    veventq->viommu = accel->viommu;
+    accel->veventq = veventq;
+    return true;
+}
+
 static bool
 smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                           Error **errp)
@@ -429,6 +478,7 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     viommu->viommu_id = viommu_id;
     viommu->s2_hwpt_id = s2_hwpt_id;
     viommu->iommufd = idev->iommufd;
+    accel->viommu = viommu;
 
     /*
      * Pre-allocate HWPTs for S1 bypass and abort cases. These will be attached
@@ -448,14 +498,20 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
         goto free_abort_hwpt;
     }
 
+    /* Allocate a vEVENTQ if guest has enabled event queue */
+    if (!smmuv3_accel_alloc_veventq(s, errp)) {
+        goto free_bypass_hwpt;
+    }
+
     /* Attach a HWPT based on SMMUv3 GBPA.ABORT value */
     hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
     if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
-        goto free_bypass_hwpt;
+        goto free_veventq;
     }
-    accel->viommu = viommu;
     return true;
 
+free_veventq:
+    smmuv3_accel_free_veventq(accel);
 free_bypass_hwpt:
     iommufd_backend_free_id(idev->iommufd, accel->bypass_hwpt_id);
 free_abort_hwpt:
@@ -463,6 +519,7 @@ free_abort_hwpt:
 free_viommu:
     iommufd_backend_free_id(idev->iommufd, viommu->viommu_id);
     g_free(viommu);
+    accel->viommu = NULL;
     return false;
 }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c08d58c579..5d718da764 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1605,6 +1605,12 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         s->cr0ack = data & ~SMMU_CR0_RESERVED;
         /* in case the command queue has been enabled */
         smmuv3_cmdq_consume(s, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            local_err = NULL;
+        }
+        /* Allocate vEVENTQ if EVENTQ is enabled and a vIOMMU is available */
+        smmuv3_accel_alloc_veventq(s, &local_err);
         break;
     case A_CR1:
         s->cr[1] = data;
-- 
2.43.0


