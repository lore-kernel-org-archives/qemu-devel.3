Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A598E9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 09:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vszvE-00051O-QW; Thu, 19 Feb 2026 04:02:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vszux-0004ye-W6; Thu, 19 Feb 2026 04:01:53 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vszuw-0002Om-9Q; Thu, 19 Feb 2026 04:01:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkAcGZvDkogaJudnopJVq7KgFoNKhVIf1aAETnzBX4Ur/V08fGwhrnifwUmD1Vpy5fgi24W70cly3VLd1dqXXNQvmg3dXMdsWVeGnP88R0A5un3g5gpZjVuyFHGQJx3ax3aYyV9egHEXShkpDreW3IMiJTOxiHqWpYRNs4aA/nsL4lkOTAkZApRq8/GAPorb7hNYUzubIP6SPGWx2mAFFj11MkFCh7ESGaCssCr6ieqYPH2kVOynMK4Pu+HxahBqrsg5xMi5osd4qLgJQllKMWkOYacWDo4IYK0R/c440fUIVZ+1osLfdhxOR7/woVlzFhs/aCxAan43QFO4L8O0OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBPYkvHqrCR0tAwMTnX7bJ2nFU7HCEa54A6b5Tdp/50=;
 b=zPWkC7C9DOVnbAUVS9Y1dYebMvCLPv2+Xh2bMhzooTwBPmxNcIoxq5xABQirC/Z02g8jFOAI2iWeI4j8uYghtqf7oSodFOLo7hazm/I2eMGmxYq69M92HmPH2mcJCldQpT99NPDJSyAn6/TaDInWv1imdJ+CUM0BOJ8RwDNTy0ZZNrUMRtRfpxu7TY2q21/QJMwU/hl24e47JR0xywCpPE2ymWXu0yhztqSPHGnpV2cRo0ron8WOIwsJvuIbFPCgedwGIWH48P8T39n4ZjHLqBPphqi33bnVd/RjkyCB8sfqnnQApYIm2De4IEU8PGPDLHmQP5k84uSBghZj1eMQ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBPYkvHqrCR0tAwMTnX7bJ2nFU7HCEa54A6b5Tdp/50=;
 b=boDohBsU+YnS0dvQnZKxC3GoGeWeOvaSRMJnzeRIAP1CYOiFiksnMFE7KTVxf8NyaiBCk3jP7ahwItTvisDbqP+2r73hJF2B1QCEZ5BvT7QemFwzRdgo7lz7DpvT5tTBv47k0ib0LglgBIxU9Ze8iRGfGSYZggSsX8WKKnOJKjSG/kctMNdiC0WT5kvhv3f9QCqMm326Zjj1Xv2lhdmxcJpL86J/rDkkHmetMNIALjM5PEZGVXyLl2I6HuneejQSBh8x+6N7mQZgEhscNJb2XUCz3hFsYQUvTJNBeeecrt4DyUJatpyTRFm5Q6vFgH7hvuK4A7DYXcS9fi01BpdFVQ==
Received: from SN6PR08CA0017.namprd08.prod.outlook.com (2603:10b6:805:66::30)
 by BN7PPFD3499E3E3.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 19 Feb
 2026 09:01:44 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::76) by SN6PR08CA0017.outlook.office365.com
 (2603:10b6:805:66::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Thu,
 19 Feb 2026 09:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 09:01:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 01:01:31 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 01:01:28 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 1/5] backends/iommufd: Introduce
 iommufd_backend_alloc_veventq
Date: Thu, 19 Feb 2026 09:00:59 +0000
Message-ID: <20260219090103.33697-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219090103.33697-1-skolothumtho@nvidia.com>
References: <20260219090103.33697-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|BN7PPFD3499E3E3:EE_
X-MS-Office365-Filtering-Correlation-Id: a41ebb9c-5217-44ee-9bd5-08de6f95810d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CVaqEUBKg22EqmdxqrRppo1RbaE4PCBsDjDCWuwrRTy4DF3b/4Yowi4cl/Hz?=
 =?us-ascii?Q?0wYUVPp1kZ0i9CXsbV1GL2nLDRMoyPuAUb/uAzGUBN4haBzEdUDfF2MiV/rW?=
 =?us-ascii?Q?gr9SwZ99VhZn4axUS/lekMrFZgpHpyupnTIK5QwOrvEB0VgdwlWeiu56/31t?=
 =?us-ascii?Q?DVgxYYZID3y6EGljZojBPPeyMTnfzkfPTd+LtSwqW0JYwctqMPylcTiI4BFi?=
 =?us-ascii?Q?WoGcI9DuO5gr3jF6/2IlT7kGWp4Aly0rJdXSL15rMJfy2nmTKwEbRcvkvbaW?=
 =?us-ascii?Q?R7UxwYo6G5xvcp3mDu5gkrvlhG6VQ2sVsA8K9NjrUAWd87cKS1RS/5gyYSMX?=
 =?us-ascii?Q?i6lU1i9UxcuSnEDHSTJ8IchUZtIyw+6bjprC3ZYEuJHdTNqXUr3BFtMPDytI?=
 =?us-ascii?Q?hb3hwCCXl8/BKN5P/B2wPOBVzuQrGjJaXghqZ8UwDHQ9pwKRXOW65YVSKjjV?=
 =?us-ascii?Q?3w6VEoeOMhl5LbiQ/iM5lsMNLZrR02hTVP5HeRurnZzWOWu5Uoexo+CkFCW5?=
 =?us-ascii?Q?fPlvX4aBIip0d/PVuBkVNw25x5sRoOHDTFCywyk0ybbNlsxfr8BIOaB89aN+?=
 =?us-ascii?Q?5577+jIE78C3Tb8LCy9JwIuvcDtWDEnQx04MATIdXBA1K/OEiROt0fFKhVqj?=
 =?us-ascii?Q?bGLb5gzMROJS2t19sKkjSrVE6OQT4txkbIZnV+z+L7MVO4KiIuW7LWQBnUo+?=
 =?us-ascii?Q?9XjEh0rKAU6FcvCHIchVjvFakJqegxn0sPF3SVDVuwfdktK1IoK3UMd8UbUJ?=
 =?us-ascii?Q?hi0QA55rBT9K+ICiAnK7adj41VR37ZLCU8Lx4QkJA5Nyk5pfn0C7FuVNLqB/?=
 =?us-ascii?Q?L1C3C6NG5+1vWjQZZoJIdE+Vxj3kMgGv+YenmIEs2AQ5idw5Mh0XlRRG2cB0?=
 =?us-ascii?Q?pi/drVtPEVxHSfzpGaslCAo51P4nenMIE+Wri/SVsmsUuKLD9CYC1uv+zZJq?=
 =?us-ascii?Q?wXoHMu5FKLo/pAgAwb3oNRWtYYgUhSth2OfrW7mpcNdSHvhlqRjxcBTgnH2l?=
 =?us-ascii?Q?4XN8pADtsET5JPsgaYthlmjWNu6kGe71pstYcnIqosPBEVkQM/D+ZTJj/kwJ?=
 =?us-ascii?Q?/w/E442dUhgz1wRrdJFVGVx8CmDYlR8jPnC29Lr6h9B3Rosopm8heVwgYvnG?=
 =?us-ascii?Q?7A3IHNuBOQpvOSEkdxeWNJp6TyMOpRPH8uUEvjK+pU2z8z3OhDOfzPffcMzp?=
 =?us-ascii?Q?Uq+FPuzFTPrJI1LWYKyXpNyxuk5hockXjoHm56yLV1PzKEGZfcwk2NqJbBu7?=
 =?us-ascii?Q?+9+tanF9NYa/3tCcCd1kh91BbksTyvAFyrKpW/OgF73OzcYc1bGfbt2G5HMk?=
 =?us-ascii?Q?S7oxAOaCgT/lip17DPnyZiicwiS0BtrBbKbPjaM/kGbBuP0wPUDqzFM/iQLf?=
 =?us-ascii?Q?6jE9S3SPqGlQknD65QdFq7qtK7h8W5S/PcCkRVdJO2bZpojV/8xtVvxcNJlO?=
 =?us-ascii?Q?5GQpgyyZd18jrv7kWdNjfllhrPdueTbe+lo+dFs+bvvSTcAiT3GwsWGYI9la?=
 =?us-ascii?Q?Ss/x5+M7/o2mIUNiNMue2W+d+mXT+fC6b53U36iJoMy9fge5KGtvTAA2wbUe?=
 =?us-ascii?Q?A757frV4DvYSTAhVchDlHqqvTiR+JQav24QhRI01bAsBHLwSJ5FyRpxOetE2?=
 =?us-ascii?Q?BKwhruhHeywOshqarwymqKGFd2x8Zvf3OxPBgICjbVgq6ZgzM10P79Z8/KhD?=
 =?us-ascii?Q?+gSJPQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gzVCjHbaswuoQEVRPgLnU6gVHM4vBb3dsfDADHi614jAiZAByrmWHwJnX3cpihnykqsLJ7I1riAS2snFnqNUrKIH4Qqml6BCC6jDNdF/+DvAmBeKiMe3o8TkJ0TSLd2V7FbXFo0SZGmyAR3F3owvZ54rk9L0tkm/3S2HXz3Ai63k8DtGzMP8XeKhPtPXOcBFCNlbZEh42E5zepKL7gurXmF9sCBKk4y0er6RFcFsZqlsysCsxAfzosbaxESSm4q90TVqr0dj9ZyglZmLTizygBUDX5UPMkba+gve04mrf3W4p/gk5qBZ7HqTeLcBdmprc9f77YIxWSeCOp53dHyPv4WjqC6rOXUJx1ZzLo18WqrrE8hpnyPIDSuox9A0ALtvdFmWZHiKSShN3HLlPs0SwxikpW+hSnb4gvuwP3iNjQ5cqr8ieSDxr1lbP9m9e+ba
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 09:01:43.7539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a41ebb9c-5217-44ee-9bd5-08de6f95810d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD3499E3E3
Received-SPF: softfail client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
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

Add a new helper for IOMMU_VEVENTQ_ALLOC ioctl to allocate a virtual event
queue (vEVENTQ) for a vIOMMU object, and define struct IOMMUFDVeventq to
represent the allocated vEVENTQ.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/system/iommufd.h | 14 ++++++++++++++
 backends/iommufd.c       | 31 +++++++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 3 files changed, 46 insertions(+)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 80d72469a9..7062944fe6 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -56,6 +56,15 @@ typedef struct IOMMUFDVdev {
     uint32_t virt_id;  /* virtual device ID */
 } IOMMUFDVdev;
 
+/* Virtual event queue interface for a vIOMMU */
+typedef struct IOMMUFDVeventq {
+    IOMMUFDViommu *viommu;
+    uint32_t veventq_id;
+    uint32_t veventq_fd;
+    uint32_t last_event_seq; /* Sequence number of last processed event */
+    bool event_start; /* True after first valid event; cleared on overflow */
+} IOMMUFDVeventq;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
@@ -86,6 +95,11 @@ bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
                                 uint32_t viommu_id, uint64_t virt_id,
                                 uint32_t *out_vdev_id, Error **errp);
 
+bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
+                                   uint32_t type, uint32_t depth,
+                                   uint32_t *out_veventq_id,
+                                   uint32_t *out_veventq_fd, Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 13822df82f..acfab907c0 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -504,6 +504,37 @@ bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
     return true;
 }
 
+bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
+                                   uint32_t type, uint32_t depth,
+                                   uint32_t *out_veventq_id,
+                                   uint32_t *out_veventq_fd, Error **errp)
+{
+    int ret;
+    struct iommu_veventq_alloc alloc_veventq = {
+        .size = sizeof(alloc_veventq),
+        .flags = 0,
+        .type = type,
+        .veventq_depth = depth,
+        .viommu_id = viommu_id,
+    };
+
+    ret = ioctl(be->fd, IOMMU_VEVENTQ_ALLOC, &alloc_veventq);
+
+    trace_iommufd_viommu_alloc_eventq(be->fd, viommu_id, type,
+                                      alloc_veventq.out_veventq_id,
+                                      alloc_veventq.out_veventq_fd, ret);
+    if (ret) {
+        error_setg_errno(errp, errno, "IOMMU_VEVENTQ_ALLOC failed");
+        return false;
+    }
+
+    g_assert(out_veventq_id);
+    g_assert(out_veventq_fd);
+    *out_veventq_id = alloc_veventq.out_veventq_id;
+    *out_veventq_fd = alloc_veventq.out_veventq_fd;
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index 8dc64a20d3..b9365113e7 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -23,6 +23,7 @@ iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, u
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
 iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
+iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
 
 # igvm-cfg.c
 igvm_reset_enter(int type) "type=%u"
-- 
2.43.0


