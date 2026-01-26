Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C7CCF65D6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK5Z-0006z5-K5; Mon, 26 Jan 2026 05:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK5X-0006yI-CG; Mon, 26 Jan 2026 05:44:55 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK5U-0005J2-SF; Mon, 26 Jan 2026 05:44:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILJkgNknHUPzc2rBPkAww3tmBTsM1sV9YH4md2S9r+cws7OoPJ3xGrHS+CGbMdFdZ5s3mb2E1CRRdB6FoOl7g20ts8PKoB4x4cRldFg6D7dgMYen2sIFYvVDrKgxDqiP64bAWah/0j2PXTEvOmJXjVjje4pfqStgir5aDid7Ga6YkKYYKa6CuYNzoz6nzo0MS2F4iILTpJ1a0bMt0d+WlibEqX75H9fvJmoAC32riATr9VnbGAMFi66PCJ3WKE8x30D/ftk6LA5g1R7nBMZh0cqEGNd2YusPrHx90DWEvne5I3GjnYDe9ZGJrsaal6BnWrno4xxZKaHtx5jbZTBr3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItAZUsrNP/kQbD1XLZycfFYOYS11uWOEy8QUfDmF3zM=;
 b=DJLMS4kNMI6OoAWekv3dTlx2yIFM6IiWutlCjoCAypQWg8OebZaIs9ndcg/DxdyVczYL8ev88PfD0tnRXTA7XIo3aKs2o1fanWACASaPneWwyPSPYedO3sB78CEdfa5jG1mapdO6qPyS9uiVXo4KRFoxvJXMxitWKDH48NlnDb4BhEL2SxdsONBE2L1NncF1hpN+GHSSG6ds6wZJmMJAIKGQrCRbp3rPZZ5aj8CS07uj3SqdB+2zY9PE8h9BgqZC2HwgA/DuYMDmAGce880dxF4cph/iFzX3w7pqPzxwfBVLrBJhjPGlPbIP2UZGRTgMD7I/X1yFjdbp7Eu19o3YEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItAZUsrNP/kQbD1XLZycfFYOYS11uWOEy8QUfDmF3zM=;
 b=lzDZC0TySaucxUHbGhbBZllatycgKNlHirxTXNMM7QiGEOC2VBBKkyuIXFOm6AVrTZ/IFiuNzZuZN6LhG9/e+B0vcBNeX4w8FgKJY7psE1EDYtzUDTLQjQBvIgnJ2F51wrB1c/vrgyJPv+PT+8Kc8DvYvEQ4Whcx/UQsseyzHPucyW/IaYhv22385Xqw2iFnVOzfrWaeFju48RzaJ15Ndu3j6TG3/2dtHEY1qUPuoOLtFhpubrszN7et0iXClrmUhMbZoezLV507uFUBo+RsiwmFBEJLN98GFa+kdCQW9f9sSr5EQofkA24/IEpOZs1hvg5RwYgAPdpZFju+6bzAZw==
Received: from MN2PR05CA0047.namprd05.prod.outlook.com (2603:10b6:208:236::16)
 by PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Mon, 26 Jan
 2026 10:44:45 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::87) by MN2PR05CA0047.outlook.office365.com
 (2603:10b6:208:236::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Mon,
 26 Jan 2026 10:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:44:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:44:29 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:44:25 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 01/37] backends/iommufd: Introduce
 iommufd_backend_alloc_viommu
Date: Mon, 26 Jan 2026 10:42:58 +0000
Message-ID: <20260126104342.253965-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|PH7PR12MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f574f89-59e8-4b11-0e51-08de5cc7ebbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M/YKGLpH9c/V1adJscVbIdfQ7iYG/V6Buj6iOdDPe/rXuNV2gcflkVmCfTMA?=
 =?us-ascii?Q?i3Qpohr44jTW/y5TogMbrMakpWqyPwzz3xYC9N8D0rn3GgaO4uM2C2OxlROC?=
 =?us-ascii?Q?I/wR0eQvcsOSOZdxLsOBNXAUEMsSvq+RMtHNGgJli59uHH8GRnFenJli8B21?=
 =?us-ascii?Q?BYuBQ/VgslqBMQGQnhsBDL/c//dVb/XZmNLc4OYjNLGo7T26ahni0cMX1CRO?=
 =?us-ascii?Q?AfesGjln9/FCH5wG+vRMEjZ1noh4CR+Nf433/NHrBGz7EaXJb9ktWfAuMZcr?=
 =?us-ascii?Q?27mvFat5d+EKU24vjsmVpq5IPoLiNAKYb6DXVzLMixX100KSMlIVQeu1rkhn?=
 =?us-ascii?Q?Wi0tpdLOLXlz71/ZEaWGwgILaQWqLWDzT4Omn1nafRMarJmwUSRLvqS7PXaA?=
 =?us-ascii?Q?HilESU+E0T/b73qTB/GIn9K0PH3az/3Tn3tJcnTxR3IZ1RyDlm8FScQxV3wX?=
 =?us-ascii?Q?76LwIb3XXAWfh1KXA6Wj7mwzbmYcXGinrT+m5kmO4hAWQMvk13GC1aPYvNGS?=
 =?us-ascii?Q?5uKi+Q5tRybVHAy+pvBTBTNP2rfYgZDUhA8i+XzAUk4dr7h3R7uATYazBYyq?=
 =?us-ascii?Q?7XPNtWBKcS08SyXdQvtadjEt8gVjRu+V09pMk71YR779EiMm9LedPoN2pQUf?=
 =?us-ascii?Q?zTQAsW1zAaCKWlvZMqUpUlrxEwrCzVRDofy106e28/QQz3ieBaOg2tIH1ZnJ?=
 =?us-ascii?Q?twx3GhskIlqMfKf7pR9XuAxiRag0A6/hueMlVnxwrbJDKck/8GhIRA511RYb?=
 =?us-ascii?Q?qhcRJ9RopG4Rt4Q+qjxWdvrzVF0KlGjZVXlJnlwAWbAG7gdNVW+K8VlUAwH1?=
 =?us-ascii?Q?dB7L15yldtp8Dm8ovXoXx6GjOcKb63YGze3jTL2vtINy36wNoB1Z5a19Z3ys?=
 =?us-ascii?Q?gaoBXEYJFUmTTVXB7tvh9uo4RFYlvsIv35gPvdgwm5m6mNuoo+o4z6PC5GnM?=
 =?us-ascii?Q?XADaZno2zcJNPg3ew7lK3KChg9B6Cdlaeawnh6Keek3MsiNl+mutFpn9pPhV?=
 =?us-ascii?Q?jkoGM9lSss3BNiFmapz/5EzUAgru4IEQbQGddde7JMCz4TLvwR8CTJX7JHv5?=
 =?us-ascii?Q?UURkpu6qnEWm7F0eodPGnmoX74m5kRxemRruYR8ycGIAeHVWEMlZv8ZJil1L?=
 =?us-ascii?Q?hxyWEMl+DDUAyEyWdRAgxy1W/ICxhUSjJgRJ3jLZk2AK38YJXesUF5UaEzvI?=
 =?us-ascii?Q?oY9sLCVoj5QcF5VZ3DF1YOKvE11dM00yNbpeOaQ/GQrJJmStCxOJr9k5mt8Y?=
 =?us-ascii?Q?DCiCFlIXcFr2sjP0Mm4WdnBaoRudgYIOKHdtguSFM/WxLCDBwxMFMJC9ay8P?=
 =?us-ascii?Q?l90QMEoJYz5KxXCL9FabIx+4nEoeFwcyGPsRhGoukElczd+ClDbSeeGCb2So?=
 =?us-ascii?Q?5eseGCjI83PtR3TSULcOQs2hIh55p0fx4OK6hg+6LFUEaP7PHJsQZI3Z3Rbe?=
 =?us-ascii?Q?OpWVT/4GAxVKHeMxgFrXd+X7Xqx7NJ63/xw8VjLSt5CtAtMJ+xbDZp6pjOV1?=
 =?us-ascii?Q?CnTDp/UG5myCSi4k7TJBVn2CQBsH/Vf8AhxhefqFteuP57LWvGxswLZRkI3l?=
 =?us-ascii?Q?nURNldvDfVdjyi3++H6J0STl6gfcNGyAJ0p1CMqAfyI2wDn7C0swJfYzr1xo?=
 =?us-ascii?Q?ugNrtIT2J134JuIKgGkKx+vJZrUn1h1+toHGZHPxvLOsjSmA/fZidsf2DKSd?=
 =?us-ascii?Q?0B7I4g=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:44:45.4564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f574f89-59e8-4b11-0e51-08de5cc7ebbd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Nicolin Chen <nicolinc@nvidia.com>

Add a helper to allocate a viommu object.

Also introduce a struct IOMMUFDViommu that can be used later by vendor
IOMMU implementations.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c       | 26 ++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h | 14 ++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 086bd67aea..c65dc41d71 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -447,6 +447,32 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
     return !ret;
 }
 
+bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
+                                  uint32_t viommu_type, uint32_t hwpt_id,
+                                  uint32_t *out_viommu_id, Error **errp)
+{
+    int ret;
+    struct iommu_viommu_alloc alloc_viommu = {
+        .size = sizeof(alloc_viommu),
+        .type = viommu_type,
+        .dev_id = dev_id,
+        .hwpt_id = hwpt_id,
+    };
+
+    ret = ioctl(be->fd, IOMMU_VIOMMU_ALLOC, &alloc_viommu);
+
+    trace_iommufd_backend_alloc_viommu(be->fd, dev_id, viommu_type, hwpt_id,
+                                       alloc_viommu.out_viommu_id, ret);
+    if (ret) {
+        error_setg_errno(errp, errno, "IOMMU_VIOMMU_ALLOC failed");
+        return false;
+    }
+
+    g_assert(out_viommu_id);
+    *out_viommu_id = alloc_viommu.out_viommu_id;
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index e1992ba12f..1ae94c4290 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -21,3 +21,4 @@ iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
+iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 1392706b83..bc4acd1e8b 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -38,6 +38,16 @@ struct IOMMUFDBackend {
     /*< public >*/
 };
 
+/*
+ * Virtual IOMMU object that represents physical IOMMU's virtualization
+ * support
+ */
+typedef struct IOMMUFDViommu {
+    IOMMUFDBackend *iommufd;
+    uint32_t s2_hwpt_id; /* ID of stage 2 HWPT */
+    uint32_t viommu_id;  /* virtual IOMMU ID of allocated object */
+} IOMMUFDViommu;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
@@ -59,6 +69,10 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
                                 uint32_t data_type, uint32_t data_len,
                                 void *data_ptr, uint32_t *out_hwpt,
                                 Error **errp);
+bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
+                                  uint32_t viommu_type, uint32_t hwpt_id,
+                                  uint32_t *out_hwpt, Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
-- 
2.43.0


