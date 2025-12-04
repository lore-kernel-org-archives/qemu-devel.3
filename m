Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30993D1D899
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 09:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR5ZY-00039I-3N; Thu, 04 Dec 2025 04:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vR5ZW-00036K-FZ; Thu, 04 Dec 2025 04:24:22 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vR5ZU-0004m4-N8; Thu, 04 Dec 2025 04:24:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xURlW0sKBwPk0YPAyeGn1fNbjI9rcU8hyaES0qW/gT/w+OPjDB125g6tHKVyVIaVLcu5BTTd1vnvqQSrRCZPjhc1s9uur0Ruv45nKwDjJ0/bRGOW/oG7zZXKVPsoiUST0iy8iIDAzB7bzGpomd05dtJb8Pbc8PPaI0qPd9e7U0Z+77ZbjDJ6ZgX6N8QzWrq1GnxC8DtzEWgF8/OQAL6qj1kZEGsOuFjmW92O9RFSwxbUylIe7sq/hVDNw5auhvDWqK7W+Vcb0X1t7WncsdN055bxsX/2Olp69izWpg7qoHK60pXgB0qT3RL83/jpHl+mVdintR6C86fNLcSx6E/rmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDozgO4x87UxpmIB7MdNgnZ2KSV6EujA8EA1wL7cZFQ=;
 b=d5jxl2/nHTIvIZakJV+ObPfHa0pj2+jMg1eBa2UJcPrJkKqte1UKO35jAyp58WyAq7Y9V1wH4ep8ZnKUvRaMI9OhkGGBH+6uI5n+JfFxNhQ80XX80/DLMp7pY8S3yTbsSZn7It5xCAM+sHcuYDkzvweRtqb9fMTAZuvA5raVBwEJ9oM8R79C0Mw5PNYXuzIQKapwRvRN63z2wJPuPU5HP42PhuSEexOocmYEoe1YdnZ9ZB4MBxqYOeWEaz9cJG023vn4bsCwaCNqFnIUuX2sZVpMEaoyj9d0UopG71W4gvU8eGppKP/QZFJa8tlNqoZCzzEHOMHg5Sju3mCW7zPRlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDozgO4x87UxpmIB7MdNgnZ2KSV6EujA8EA1wL7cZFQ=;
 b=iqZ8KE4oOm8yMJLmyZ7Y9j+tJ5nsQa+HnkfBbh/vuyGSVqxq2dR+F2vWSaBBAWB6XBM6jqYDpGvSYGDimyjMgqPDPT1l+tx/V7DaIgtIea5fR2u4k0CxSlsec9s1BSvmmbmLgVfDiaQZZMUdJXWVKJI57c1JyuXnhz4TemnpZVDBeJ7WenAYTeDsFBDNeQkGdCLYCRJNYsstFtzAwTpfkPiiVp4IrT1GqXL9MfCEUqH7Smg7Xag49lke+4CJJtGhaiM2IE7bii2fpnsxARWc5jyl+qhdYO/pEb4FqhTkW9ePrJM/3KYb14TgG9HSFQGR6ylo6NNZ9Xcul4zbZnaIUQ==
Received: from BN9PR03CA0848.namprd03.prod.outlook.com (2603:10b6:408:13d::13)
 by MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 09:24:14 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:13d:cafe::d5) by BN9PR03CA0848.outlook.office365.com
 (2603:10b6:408:13d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Thu,
 4 Dec 2025 09:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 09:24:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 01:23:22 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 01:23:18 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v2 1/4] backends/iommufd: Introduce
 iommufd_backend_alloc_veventq
Date: Thu, 4 Dec 2025 09:22:38 +0000
Message-ID: <20251204092245.5157-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204092245.5157-1-skolothumtho@nvidia.com>
References: <20251204092245.5157-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|MW6PR12MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: a0bf7a97-f2a8-46fd-d562-08de3316e42a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yMBnYJSi5iuWGOcI/HrjFcS6/2bKK60vEAwPCYsTN3o2YE6CIZIv8dqYsS/R?=
 =?us-ascii?Q?i59bom213zxln8LO7KPu4agOVqUBdOgGPEk/mRjiQ7FL0UmYZfd7xj3Z3j0z?=
 =?us-ascii?Q?gDU5OYx0sRsHk9NhhLSaJgn9ts5fvd+KW00MqS51j6yRa7CBNwPmPrw07IR3?=
 =?us-ascii?Q?ZCH7hisvnjdmdGs67umsvKAYNFkC9YZn4rU7kAUIDaAcILzy8QemU6QHztPJ?=
 =?us-ascii?Q?buQXMPmvrD8G0eMhTdV3qWOpphzJzqtyi7Apg5cp7hHDuIvgx24uNYfhXGWf?=
 =?us-ascii?Q?Cz3UKfc/DrzVul210EoxotpqWOxkOiG092ySQ5A/DyuK8nBfroAeyGqwUDcB?=
 =?us-ascii?Q?+mn9k/JmdUIAU11Jtn69/B4IC58DrKi9zl3/IdzboC9QpuL/KVb5l5ZIBkTz?=
 =?us-ascii?Q?ec1ddnBZU9EN/eqAOAn7gfpi/SmEfG7Vw7YrHmI0SShf9W5VokNwetd1HtGc?=
 =?us-ascii?Q?FBO3zE7uFeyX22wg/Uf5vXrI1v8FTipBIzP0U+lQOrrMsoJ/Okl0GcqbjXJt?=
 =?us-ascii?Q?KhnmvDnH9PiF9y4AWORfoyAhLRe/4+lQpgsQaeLVxSuk1CrUUmKZ7w9tM+4g?=
 =?us-ascii?Q?RbDHJbpcUDecmU3dBJ6b/APEHFYAuep+niVeYOFTz9qO0JfZ8oPR5ciRdoJ+?=
 =?us-ascii?Q?/dPoH3nShvUYJq7JW8zi4eWEBCJmfntPqGr29JScUnGgCRr47yXoEYNV/OEW?=
 =?us-ascii?Q?hNeQIEm5pSiKO4azLv30fVd9bgCqNs8TRcU7llS1bDWoWQpzLeL6aMYoJsry?=
 =?us-ascii?Q?aW7lbH/KfgukZ2MC8hXa+rKm+tgff3kLkit+XuF/O6g4F3X1hdhM4E2GmkyD?=
 =?us-ascii?Q?gou4uV/MwgnVSUkMamDJov6+JcDM/9/SNz0VlV4+c8Y4n4TQlEDFa1PxquAz?=
 =?us-ascii?Q?Wap5k9Cv9mjNcDR2ZZsCs9gSOcZJodtwQqI4HRvc+gXfuGTiNXnTAF/Q9FMT?=
 =?us-ascii?Q?GOrKbHBbc3V7ShU2tQayr4zqHtrX6zdwGooqc9/whxV47a+qD8ZvnkhaV/we?=
 =?us-ascii?Q?pz+DMZ4tJal/kH3FwfIKDdl6GctyCtzcUBW8vcfqFBs9IailasZfNpl/eBoD?=
 =?us-ascii?Q?4dAu3itnVLD+VQN1/rIhHWJbTFPD3pWrQLKodQt3PB3MzTUawrAxVpv5WY0p?=
 =?us-ascii?Q?NXH+19a/o5QzBIseGZsMjLlenq0D+hfAIyWcRIQ+97bVOyEQRsGUX4oGlBmP?=
 =?us-ascii?Q?mOA7X3SCMcLmGKSpidXLuPtFa29HBh0KTc0CIBBmFnjuqGc1WiEGJRucrl8U?=
 =?us-ascii?Q?DlmggBU6xV4eX6rORHd5Ta8D9Lyekygv1sCp1ybrQWh6UMTg4dToXmMbUPVX?=
 =?us-ascii?Q?BsDtre+KOQZXCAp61+kaOi0Zf+Vh2ScxsmnfCjVGNLrtanG3u+S0cgiqA4rZ?=
 =?us-ascii?Q?GlDnsX2FF9cIQrU4Pb9zOOFeC6+k/qv9W8rEH+9u694pmusn5m9PEfHl0448?=
 =?us-ascii?Q?/i48uos9POxHMJMkUhOaTOfD6QbbEKj/RdiaDWp/r55qzM5hhZVtJeEXkZvm?=
 =?us-ascii?Q?AH/ByLt3yX7qTZ7QJZaZuBd819JVxQWksjr1OYtz1irHoXSH6ZUeK0NT/oFQ?=
 =?us-ascii?Q?Ug5XUQBD32VcwmdYgEg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 09:24:13.2917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bf7a97-f2a8-46fd-d562-08de3316e42a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8733
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

Add a new helper for IOMMU_VEVENTQ_ALLOC ioctl to allocate a virtual event
queue (vEVENTQ) for a vIOMMU object.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c       | 31 +++++++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h | 12 ++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 718d63f5cf..633aecd525 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -503,6 +503,37 @@ bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
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
index 8408dc8701..5afa7a40be 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -23,3 +23,4 @@ iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, u
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
 iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
+iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index aa78bf1e1d..9770ff1484 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -56,6 +56,13 @@ typedef struct IOMMUFDVdev {
     uint32_t virt_id;  /* virtual device ID */
 } IOMMUFDVdev;
 
+/* Virtual event queue interface for a vIOMMU */
+typedef struct IOMMUFDVeventq {
+    IOMMUFDViommu *viommu;
+    uint32_t veventq_id;
+    uint32_t veventq_fd;
+} IOMMUFDVeventq;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
@@ -86,6 +93,11 @@ bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
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
-- 
2.43.0


