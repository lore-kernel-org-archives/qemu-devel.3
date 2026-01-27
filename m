Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3499AD2D8F2
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 10:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkgRu-0004Rs-1D; Tue, 27 Jan 2026 05:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkgQf-0003Ie-Q4; Tue, 27 Jan 2026 05:36:16 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkgQW-00017t-BD; Tue, 27 Jan 2026 05:36:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7u/hAvR2I1Sc5uFe+5QeUibJpadcvk/A0BfCfjkv4roPwB+DQRkovBOSLoKZnOcG0txqFlHoKS3CSWVA4jdVc58TeG2xazhkTYzuILDb41MeD1z27eZ8n3LtvTcFfd+7kB7wdmOhFQOqdvAPZvN0jhp9uzSCni47pMhS2KftoJtWdOpCLR132IWUXs+cbQLHDAW49r+xiIybgyxyxh3itbyGgQEpz8vrho5RSBbzylAgmRQGCdN3tiOVq52sAWuPAG2NX2WMqLZNuxTZtY/Ni6Pgrfed+93vflIa7afNrdjcRtovhJ72uV7W2VY3XZV9ajjxIgazmANtP14N7MqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XT7O4mrQ9VclqmzqBjZNrfY6MLpvrUtAP3o/A/Lg+f8=;
 b=vhwxmIpCSJMzg4yYhjA3FvOoRufEdxHvqYvEUSFfQbrgGitqpDDEBLpoFWsbdIy8J/9HoZF8mEZw0/YOsOhS9G8Idjbn69MLUozkQRt9PlxYtCmb8YDw3W6KCrxuTyrBXN5S5Q1XPIowLjjsCvFKESVEPgyQjsSJghNDXWjzzXkMn58L+0dA8+PyIgkPY1rIlLcSUZghk5lhxfqqqVveEowMPu55h9oYxPafN45xFtEzQwWvbuJf7Tmpk1vsobrqilnOBFVGw1JBMjVDvwEGQ0wpy2GN/imKOOa9qTUWNfT6fosWT2MVnzff0wxhjOENRBT2jPE7PGNqZrGxzuAQ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XT7O4mrQ9VclqmzqBjZNrfY6MLpvrUtAP3o/A/Lg+f8=;
 b=NdwTUVohH5bzrE0WRX2PnTpJjStHgTZod/FNImOhoONZNlD6aiMS0YRH842OoUCYCqiXT6AcM8QaiWjdaYh6tFjUcAfWGIfSychI5vlfhL7eq7wGgNs2P2N0p6gXk/8FD39MM9g3YxLl+4V2LA55+lDo9HwwQos759PbbPP8ZvEU+zq7otXl683GNUWuAHPEDF78Q8B+NjOSIdzw7QnfjLssc0qj1TDriFJwDEsdQf4BRQp+YKbB9nAq+wUURqr+yNaXIffXTzXmndLab+zwmZ8PA5k7bpwjEFcjz7Jwe6zBDYkWyzH9nfzvveFoK3Nqv/LHPasYtxpotXPr+PE5IQ==
Received: from CH0PR03CA0393.namprd03.prod.outlook.com (2603:10b6:610:11b::21)
 by SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 10:34:27 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::43) by CH0PR03CA0393.outlook.office365.com
 (2603:10b6:610:11b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 10:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 10:34:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:34:13 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:34:10 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v3 1/4] backends/iommufd: Introduce
 iommufd_backend_alloc_veventq
Date: Tue, 27 Jan 2026 10:33:25 +0000
Message-ID: <20260127103328.255382-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127103328.255382-1-skolothumtho@nvidia.com>
References: <20260127103328.255382-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7ab667-1946-431f-95f1-08de5d8fa5d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xJI5/A+wfRzoNnjmywXAfek/mtMdQ3p8vwSyR5QgRlAxlRsTyLIbpHQyRGJm?=
 =?us-ascii?Q?whLvzlcqWkKaP06QhlEKTweyFNM6+A8qq7/NuqAW7fGHTahCUPbriNPw/bb+?=
 =?us-ascii?Q?iH/h65BX7HaOSGiWOFG67cWMeDpYpLh2I8xuJdjZA90DziRcVuZDTrxNSYr2?=
 =?us-ascii?Q?ZnVlY9QNJwOzd0QWIVJAqDy7czyGvh7420egkyYQwLYkLP/sSaAarkGsFd2t?=
 =?us-ascii?Q?/jCpG4LnsMxLWpLdHfN4WJI/O/7xKinYSLNxRE5ExRTwFxj3QATitDXrEu2r?=
 =?us-ascii?Q?kFsjopKg+fNEdlJ0wXIKN3m1MF11C5bRSSdqZ0S6NSKC010mZNYoJK3RWOXi?=
 =?us-ascii?Q?eQyadtQN/sGLqyNKyTGG0Kx20+fIxOTUTMK+oy5y/OdXqSQrUmkSQBaSKgBc?=
 =?us-ascii?Q?XdRNYIbY3c3HmcSvR0gmkOg/+ncOdlSuzaqwmpLnIR8XTNF6LqVOHHz0cO82?=
 =?us-ascii?Q?IUXetOG+YumEtUVaWAYErs9D0c1c6LrgBH+Pwkg7I3XFgnCvcPNC95DjN2TI?=
 =?us-ascii?Q?J7YMzSvXF4ySJgHsKbcFlB7TQXNZ+O6MML4vYx7fiegImn0RBGmiul5nRSjJ?=
 =?us-ascii?Q?i8HKO89LNc0w6hFCQqFonSFQncPoSFJWbO/vKaSl2VwGFtUHBRs01Nx0jgkB?=
 =?us-ascii?Q?BVIheIJGs5ltVciIQGWlaivz1RBHlIF0SqEKZN7d1HFun3hcBm+3ZZKRagoc?=
 =?us-ascii?Q?7HAli+ok1retShNCAeNi+HQZ2qG9MrSqVIlNbUp55uKRaJDaJMGtS+Bstg2H?=
 =?us-ascii?Q?V3Z2XD0aIHHQOvyAptxmL7wbsl+4wg7RMwHDu6C27eUMDopv18XzyJVVtCas?=
 =?us-ascii?Q?xKMDz2SwuxfC2IGMli8Ny+4suxCmyNxBgUQKMYJjLVIEKN1XpCkWvlS28PNz?=
 =?us-ascii?Q?7xhcEgXX8U3cEiTucyP6ypXRWAE9d0db1ujDatpUDeY1oJbJ7JSs5xIS7uw9?=
 =?us-ascii?Q?BwL3dY+g/sNumqL3aj+yIy6oamCxDHvPsqLtQVwdL8uapZ/2PPVxOrwHkdIT?=
 =?us-ascii?Q?7//ncWMKEYIH7wA43oHfABt2bo1m1bzwuL87+ENf/B7l75R3o/mhKZ4UQuPe?=
 =?us-ascii?Q?liaAMD6wd3T+L6hG9umAHQa9THZS086zSbS49D7byI8gX8mEA2bYkUz74idG?=
 =?us-ascii?Q?hrMIb3AAH0/xHmdqpGxDKdrhlt2J4bBxRx2U1NJn4+H6JVUHxMTzqp389w8P?=
 =?us-ascii?Q?cvhIx8UT9Y2cewvu+5D8wJQjDtkfaCXS7ZHr8wRiBPsBSenjAsRU3RTo/0Gu?=
 =?us-ascii?Q?F+rX3IBs9bBBvv6S6s5LMNyluaOOb3IfeBFs1cJE6AU5jNxMixH196ERS/lY?=
 =?us-ascii?Q?OdCy8r8k/9ZiLQMbI2BwuNZkKYhJQ77ygzHDOnlOmqOmqg+mjP8ZJSaRcJAa?=
 =?us-ascii?Q?Ejmst8C618rKwZmPtn3PYj3PaNiP7mmwSMCAfDfdKnzvv7qsyU0w4APXYLKz?=
 =?us-ascii?Q?eQld8I2JVeyRqun4LhX9iF2ZXzy9lCFd/ootIblSmsb84TlJsJHcsqi/tvsG?=
 =?us-ascii?Q?cLRQIa67EcL1CW9M7zlheBXEB/xOhzTjXqc083Uo7zCVLX+NjSqE79GfwJXW?=
 =?us-ascii?Q?J1vo5pOlayaN+NjvP2+r9kruDUpZYPxrCx9uNJ/8VD8zl1IXlzKr11qg7EBu?=
 =?us-ascii?Q?2aCogxeJcmzQ/wUoc9f31XhPJXJPgZmKVzzjoIcSlStGlkcHMcKddO0PNwN1?=
 =?us-ascii?Q?0Bd/sw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 10:34:27.5936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7ab667-1946-431f-95f1-08de5d8fa5d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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

Add a new helper for IOMMU_VEVENTQ_ALLOC ioctl to allocate a virtual event
queue (vEVENTQ) for a vIOMMU object.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c       | 31 +++++++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h | 12 ++++++++++++
 3 files changed, 44 insertions(+)

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
index 14a7ecf5aa..5cb7d4d62d 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -23,3 +23,4 @@ iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, u
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
 iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
+iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 80d72469a9..e4ca16da70 100644
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


