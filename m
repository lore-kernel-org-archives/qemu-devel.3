Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18741D3C907
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKPG-0007MI-9z; Wed, 10 Dec 2025 08:39:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKP6-0007JY-G4; Wed, 10 Dec 2025 08:38:53 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKP4-0001Io-PA; Wed, 10 Dec 2025 08:38:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snHqSyJSmXYKzGnty1XBEtidtmwsSxIwyKzzzT8/7fJzkYmb5ZKcm9TTz8VYAu7scuq+I/aHEQWsXE0m++GsCOHHy4DcfPGLd22/vWYV17DhBGUUEt8gYJsPlrU9AW1gUcdDKLwsGpbG5/0sn7svgDMr9k2TLl5yvRVpxRYa7aVEZl2TdpeyyCU3cWrLdUCVIlfrIF4CBhXyQpgTMCbBpnnkbCDNmJzqr9FhTb/2ECSd/ZeZXYazYbgg8xvhZl/VaC2kyh2MXfzCVvd1rlz7EHjhas9jdLz+MUikHuA+mGXp91g9gnSB7eKTOpftZ6kY3AfXb1On3qlcD6ldRQO8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLw76l+8THQnJ5HCR1g6MCnJ8Q0z1dqt5VowTxqo23E=;
 b=kBpg6O3R8eijkh/NYP/piwRjg4cmBxa/J9N0smrsLgmULjbpqwJSO/dZ1vNwrZ6LPwmAzlx4EOnJQ3enagmoXO5BdRsCpBVQ4d44ZY4FkDWgylt8t+LrdmD0l3B24KhHcgpwhNXAEmOiJDKg9a/LJpJk3wbinH8sDsYQaen59JJ7KIvjHBdGDMpmBLWCX1dquAFVVmeyaAZ2LFCQi6/sLqzNVAU+uDRGu6lIZnpvpGq3e5VHvnfgKvaKVsHRUZqWxlOHEQ/CdyiDSJlU50axbWNqt2q3qpIAWybeuEnkTJTAHUAi60BkbOchlE/G2Jup4N7Q/LTJbaFZ2vb1uU2O7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLw76l+8THQnJ5HCR1g6MCnJ8Q0z1dqt5VowTxqo23E=;
 b=dwmD8UdBvnOVwtYwtRr7HQvPnBZA/kRlgvr8xCXWK9LJ6Jf1d2oky9pMsTuPKnYwLMpPBAL/hDRW857WDmgH86RY7D4wdDJrVxhnMYQ/8iL79qjYSWgGYTI7esiIOFbM8QAMDuH1iQCMxb/G+EgezTPsVkJHjwmZOuF6QzsUu9Ylan/OZzFcdwJKFETY4+mEn/f33RxqmbROkZL8U8k+ZwgnMGk6eDAWC2x75I+Ffyggkpxr+hZDuowMUihk2dpAcleaEE3oiv6MrZI0O8tS4E4wHByQipI/DwR/UgDlwTwcXCDQpUumnHcGk0rnojSjzB6N3CBvYa1ppHY9L55PEg==
Received: from BYAPR01CA0070.prod.exchangelabs.com (2603:10b6:a03:94::47) by
 MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 13:38:42 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::1a) by BYAPR01CA0070.outlook.office365.com
 (2603:10b6:a03:94::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 13:38:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 10 Dec 2025 13:38:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:25 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:22 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 03/16] backends/iommufd: Introduce
 iommufd_backend_alloc_hw_queue
Date: Wed, 10 Dec 2025 13:37:24 +0000
Message-ID: <20251210133737.78257-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210133737.78257-1-skolothumtho@nvidia.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ae4fb0-8d12-482a-52c4-08de37f16f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dLYfQX3qfKwQcYyJh0oHH1AgygNuiMlRbuXvEfu8imEIFyYajs9h2VRJbFGl?=
 =?us-ascii?Q?nO1rr5R6823DVe08+yYUCxGOVouA76rAAqCxf+u8CCLexW8sJDE80voxby2g?=
 =?us-ascii?Q?ACdZZYBg2zEh7scf4KNbhHstScOrzj3cR/GgckQ29H3ZKl1hUxGZbGNrHZS0?=
 =?us-ascii?Q?Nk6vVBpvfpJJfvItWxMp6XXIkDuSiYXk8wKhJZMpWb8NHZNaNcLKBpbZQvRc?=
 =?us-ascii?Q?x2fGwX5LpVWU0ptqzytuswdRuboN17aQiw5D3jj4cWxbZsfP6xCcAenCTFbZ?=
 =?us-ascii?Q?APsPKpAA8YvvaXnTjs+9tCx59hQM/YilFt15n6SiKzhRnn2/CtE+Apr/dK6H?=
 =?us-ascii?Q?b3UXHvfoA85spzYa15wVVbQLsrmPTFGHFD6yoEsdVqYFPN0Yu+ks8MH4LNvv?=
 =?us-ascii?Q?M81SMDIDMwNRwBCIS7jiG6sue6FGG8fU4jg2QoNqxruvymMmCluNzt+aUp6g?=
 =?us-ascii?Q?hvaQGMJ5hwDlb5wJWyD6HIDqXNdv6Bai97nblMsKCwB36SdcU0wzfDC57LMD?=
 =?us-ascii?Q?x4+OJaUmiAgfLkBDfRHk31IzG1aV8R0q+7mHRRkjJial86Oz2VZ+33RVqRYn?=
 =?us-ascii?Q?kIzLFZ0pKY2Cw2GB/uJ7uj8Q7VknK+/TlR6oHlrgBaoCaxgtJfw/jaSJi7DH?=
 =?us-ascii?Q?OBnR+D6Qx+HxH1+3W5p53KAdoBXvAgIKLnJOuv1+Wj6qJk6DZ8bzBJIaaZME?=
 =?us-ascii?Q?6YvCpnwQ+CYAV/VeOjbrrvdogSJ7wtfaMz/CLjBKhbT1MEM0Yt1DgmyaKdqL?=
 =?us-ascii?Q?eVI3Tw6P87Zg6z0WEWaip9yGv872diFYYmG2n/sB4R+gZWR70kqxUkk4GFiB?=
 =?us-ascii?Q?KURfH+Eac40w21zJGczOAuAWpw92biGv1Txxf6DrE4bdlgGMLIpOAs6de1nK?=
 =?us-ascii?Q?pFxFK/hoRb2p6t6fO+uZhnTj45Jkc41iUS8kLhynamovCzEVfW72Km9Up8WM?=
 =?us-ascii?Q?NnM7p3haCepnr3PJgyr4uLbFOsGJECuvy0nwT3exHBd2gfHa3GLxgK6Ya526?=
 =?us-ascii?Q?KKyJyVYIhYsvpppLRw6v6NlkyyWzAzgbWAtrDXUgsDueTcJdhrTuQfCFR4ay?=
 =?us-ascii?Q?5X9nzLgwuSI6khm9yvgan38h6JYwd5BU+kO2dFsRKQE1JcmfrOf3gY3CXqXK?=
 =?us-ascii?Q?eqzKDmZbKQcTSk+lUaAp+T7ATUhqEpyj+nRHYo36XOzr8EytzgjuhBg7mZTH?=
 =?us-ascii?Q?d3XCv3R7FNpa0AJWCCIVAmhk+HkZxxDFRL43sF+d0WADFKPZWFUf6BGuMuOJ?=
 =?us-ascii?Q?k2EJRcIcwhgshdqUYKeItR2JblnEmgqgqbf220RFW349EpKpLKxteRdgbz4s?=
 =?us-ascii?Q?LDD7iWGxuNf7bjjTGTVQa6X0IBUhLH9S4czrCVPJixeetipEIXkXOwfa1xIo?=
 =?us-ascii?Q?Jg9gLBmT8KiAWHXcIIbS7tu21b0uVdJA2kmfvSLngIgqM37jIxeo6/d/Ya8o?=
 =?us-ascii?Q?jLAMJ0p2V6+7EIHzts5eTLBoOHXR/zTjQBuDqFmLDo/mu9XeAregDrBGqaes?=
 =?us-ascii?Q?2yjWSIAV3p18x3Dj2Mb3aJLZkPyX8Gp36jMxITrhcxbMeRABu1lNjbpy3X22?=
 =?us-ascii?Q?gbndu8E9qro0n9+GSbA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 13:38:42.3406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ae4fb0-8d12-482a-52c4-08de37f16f23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952
Received-SPF: softfail client-ip=2a01:111:f403:c105::1;
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

Add a helper to allocate an iommufd backed HW queue for a vIOMMU.

While at it, define a struct IOMMUFDHWqueue for use by vendor
implementations.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c       | 31 +++++++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h | 11 +++++++++++
 3 files changed, 43 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 2f6fa832a7..a644763239 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -544,6 +544,37 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
     return true;
 }
 
+bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
+                                    uint32_t data_type, uint32_t index,
+                                    uint64_t addr, uint64_t length,
+                                    uint32_t *out_hw_queue_id, Error **errp)
+{
+    int ret;
+    struct iommu_hw_queue_alloc alloc_hw_queue = {
+        .size = sizeof(alloc_hw_queue),
+        .flags = 0,
+        .viommu_id = viommu_id,
+        .type = data_type,
+        .index = index,
+        .nesting_parent_iova = addr,
+        .length = length,
+    };
+
+    ret = ioctl(be->fd, IOMMU_HW_QUEUE_ALLOC, &alloc_hw_queue);
+
+    trace_iommufd_backend_alloc_hw_queue(be->fd, viommu_id, data_type,
+                                         index, addr, length,
+                                         alloc_hw_queue.out_hw_queue_id, ret);
+    if (ret) {
+        error_setg_errno(errp, errno, "IOMMU_HW_QUEUE_ALLOC failed");
+        return false;
+    }
+
+    g_assert(out_hw_queue_id);
+    *out_hw_queue_id = alloc_hw_queue.out_hw_queue_id;
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index 5afa7a40be..a22ad30e55 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -24,3 +24,4 @@ iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, u
 iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
 iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
 iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
+iommufd_backend_alloc_hw_queue(int iommufd, uint32_t viommu_id, uint32_t vqueue_type, uint32_t index, uint64_t addr, uint64_t size, uint32_t vqueue_id, int ret) " iommufd=%d viommu_id=%u vqueue_type=%u index=%u addr=0x%"PRIx64" size=0x%"PRIx64" vqueue_id=%u (%d)"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index a3e8087b3a..9b8602a558 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -63,6 +63,12 @@ typedef struct IOMMUFDVeventq {
     uint32_t veventq_fd;
 } IOMMUFDVeventq;
 
+/* HW queue object for a vIOMMU-specific HW-accelerated queue */
+typedef struct IOMMUFDHWqueue {
+    IOMMUFDViommu *viommu;
+    uint32_t hw_queue_id;
+} IOMMUFDHWqueue;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
@@ -99,6 +105,11 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
                                    uint32_t *out_veventq_id,
                                    uint32_t *out_veventq_fd, Error **errp);
 
+bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
+                                    uint32_t data_type, uint32_t index,
+                                    uint64_t addr, uint64_t length,
+                                    uint32_t *out_hw_queue_id, Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
-- 
2.43.0


