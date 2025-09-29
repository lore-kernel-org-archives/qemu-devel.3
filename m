Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0243CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E6Q-0002ON-OY; Mon, 29 Sep 2025 09:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E6M-0002Ms-TU; Mon, 29 Sep 2025 09:39:39 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E6E-00037u-Li; Mon, 29 Sep 2025 09:39:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZGHpEmmar6vTgQ2JrhK/cSN82fa7kDb+tjHqI1FIon4IvLKTLfZXQM3JNU+XJo4oK7YRsPy6MCAzuY/rsiPN95Hjv1wzeMr+tzogbPqixWJQ1QhQGQhHMsIF8Tp5PsgD+xLk5oGsq92Y1McpxvIMpTGRFOMR9GP9mzNp5Zs5dcWl5KYkBD99mqSRbG9EUvVFrziGxiyqMXmBXMWEnpT7TA2nQF5Jspse8urbsAy//uP1RImdKdgpgtQ/7ey6fVJpS5bG2/Xm5xjNe2NuewuKLOpL8Ik018zlXhODgkhs2/TqoTnqPPj8jMRtElFTD2HuLWsbJIGbJwcYM0VHUQFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eq6vthXwDTiDzpj7zBeqnPMW+SqE8CRY8e5eLQUVCs=;
 b=X20SgeSX1kyErd6etDm4xRkySGnpQh/nFBIq1VIdYyGNUdwbRwiB4aLB97ssD0nu7+IlYoilAaUUBh+lWoy5Xb3IX5TPPJTPvpfaor7/jl0Pz11+ab0EnIKUWHJ1IWSrh0NTA5N1FS8EWeQl/YB/9rFMXcOIy9srEGv9k/w0NM1axYmBowJxWGrUeZ9KGrhtglEdpTnBpgZ155Z64xSWTJuVzXt6t1hJk8PoYYdOnfUtSvZUPmwIgOgDTszdhZgZWYt9hD7Wslg38/DJY6xumuR7Vz/NlNX91uDHMyHOpzOjaLjpnq3uNB0UEctBXwdGtBBO1E22ZHbFUwMaaLtauA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eq6vthXwDTiDzpj7zBeqnPMW+SqE8CRY8e5eLQUVCs=;
 b=EaCZlpzGMcWHDvzdmvVR2RPIGc/cCXx4gCh27qhEltg+smG/zXuGr8dbqL6VpKuL0ZetzleX6Q+JDntEZcaUYIn+Bj+JCzPfUPnzV8XIHAeR3OUNP0fRxwnVtiEM89N9Ep/j+VGrp93i9PoGTzYFIGahu1Q9GtXUxogtQudsK7ReCn1nPeC6Dd8z2kfcSzud/BpHE/mhaLGXnvvgagj2SHwTDarREP6QEBuq0AfzrmzQc9+xdH/dtU/4heiBXIom5mt4LXogBBLCpzvxwOX7lpHJ4LPr/z6ndkkzVyovnpXhO6PvkkoUtljVP+xzzZDz7V2x9XcCO+kpDtOyX6XSdA==
Received: from BL1P223CA0031.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::6)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Mon, 29 Sep
 2025 13:39:14 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:5b6:cafe::2e) by BL1P223CA0031.outlook.office365.com
 (2603:10b6:208:5b6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 13:39:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.1 via Frontend Transport; Mon, 29 Sep 2025 13:39:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 29 Sep
 2025 06:38:56 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:38:52 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 01/27] backends/iommufd: Introduce
 iommufd_backend_alloc_viommu
Date: Mon, 29 Sep 2025 14:36:17 +0100
Message-ID: <20250929133643.38961-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a477b18-60d7-4889-a8c0-08ddff5d9432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/Is89RiraT54z5Mkv5tobRUGPKpmzAhy2ZXrOzVSqMbtzg+TsJczNI3gmCu3?=
 =?us-ascii?Q?wTR5wBzB23o0JIbG40t33dKSwPBWZDtApp8Cgw6xRCRXf9TfNss7kPrVJypa?=
 =?us-ascii?Q?jzWwKukd3GhwNztnQ8j6PT4M0zi3zEXJh37FZwecNzAa3g795jj1lVoEwV2I?=
 =?us-ascii?Q?Vca6iZZ7PSAVRjRpp2oZFke1ivbXIDmVCRuXUUCW8rf7tliHpYiS5IjYTtME?=
 =?us-ascii?Q?ZP0+dcb5BF+Tji6l8w5nioqOWytAdQeAttyorVa+R9Xzbw3Tx4ENkkmpscHw?=
 =?us-ascii?Q?YViuzBH6PD+WivMVWFWPldRMJU+hANbBIrwuqrAqnOkhxhst56Vg7Ru7Vv1b?=
 =?us-ascii?Q?Y784IoSAEjty8f1+zqkPs2MxX8JGHevZMNDXIkSpkhMpHVroDzXR5Wc42rpS?=
 =?us-ascii?Q?u/fX0exof8DKDhQHHBwotNBSIgmsZGAr7NnDKXIKNqEgjOeejOhgTu+dHpFK?=
 =?us-ascii?Q?4j1PIzzQKyCzdGsa3CE6QIV1ihWq9nb29dhUogLCsvXClHzY6l9jWM/wJ4Sr?=
 =?us-ascii?Q?B0AS74D+ry5TJ8NVYQNQCiZ6PX30stBzJkFAd7RbNN3A0Lzfr5VpD+6xQShV?=
 =?us-ascii?Q?zDJd+0vU5iyFsMtpEWKxP0veMxdC/TnGn8SReJBjL9fz8888wFWp3UHVNYJt?=
 =?us-ascii?Q?YYvkkvQeOvTA7OHCoSSgXFTqlL/nUcIYzAXYhv4lAwJhQLdMSq1KsnDJZ1MI?=
 =?us-ascii?Q?s9iaDjYa9Ag1SGEnyTEvsloc39uwQkac6qAxgQqOBLDr7TWMnZ2G02ZS3UkA?=
 =?us-ascii?Q?3nqoe+uQfugxEOijRgT81tOI714/Z0d0hIEPkjsPuQCr4TlceO/KdvWixHka?=
 =?us-ascii?Q?NTJpXLOYQUwwbnsRhvkp4CZamd8HqSvDHhepaXLCzIAOWni/ZSzk1mauEGp/?=
 =?us-ascii?Q?UuuGMhNi1hgnw/5hqaoLCykJCgIlv5E3unjFVAQWDZmBJiZH+05SVmSFvFQL?=
 =?us-ascii?Q?8k9YIbOG/xoWe/qvdIC/E7Wz/yobV/jd6B46Ku99591zW4rjiuXZdx+5oEXf?=
 =?us-ascii?Q?fia2aF6B36SEIKoLaWibyqLvHJqjbjHe+2YoB4VEA4bNhSylCEFNIYLjR0sG?=
 =?us-ascii?Q?dqIPhWAarmbchdtinkt9Ds1Z7x43shcy21xV+6mPzwW4QDf/XuQR4UaTvPJE?=
 =?us-ascii?Q?GLFjH2D1OP3wRi+hQZ+xrE5F5IcZSqmr7OFNc+B9KvRHOuuOraMA31NNYI7D?=
 =?us-ascii?Q?5WGwPTOpKh88yxCen0sg6+qXdU6gaOwZCy/Pi//rGFFMzgvOwnkATGJ7Aqwc?=
 =?us-ascii?Q?/1L+Vo8aDb6j2dmvLnuU9+SfkH9UwQs41cPk8MY9xoI8MGpiWkzJHQF3DFNT?=
 =?us-ascii?Q?k2ee04jkTkTeQC/ThNNuc7iulKuRnhGg0BTqDTdZDpiIQCDkJyIi3UL08mO4?=
 =?us-ascii?Q?0TO5n6a7NZqeVSdrLeynFKKZ2+QGl8NrhzdSHiiwYQSR3dsAJpnJAhNfm21y?=
 =?us-ascii?Q?TM+mBbyKjIgHaad+XzOonWfeaqzC24qeOpHIu/wfvq0Jgq15MM9slFr9n428?=
 =?us-ascii?Q?hFlV/OVpBu0WcE9H3r97KGKOun/uc9LD62LWq2qgfDb+emoHv9qnyXuyFhWz?=
 =?us-ascii?Q?Q5pCbFTrumpv3tTkTbE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:39:13.8067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a477b18-60d7-4889-a8c0-08ddff5d9432
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c       | 26 ++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h | 14 ++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 2a33c7ab0b..7b2e5ace2d 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -446,6 +446,32 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
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
index 56132d3fd2..01c2d9bde9 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -21,3 +21,4 @@ iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
+iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index c9c72ffc45..dfe1dc2850 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -38,6 +38,16 @@ struct IOMMUFDBackend {
     /*< public >*/
 };
 
+/*
+ * Virtual IOMMU object that respresents physical IOMMU's virtualization
+ * support
+ */
+typedef struct IOMMUFDViommu {
+    IOMMUFDBackend *iommufd;
+    uint32_t s2_hwpt_id; /* Id of stage 2 HWPT */
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


