Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31082CD6E5D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU18J-0004YR-RK; Mon, 01 Jun 2026 07:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18I-0004XW-7T; Mon, 01 Jun 2026 07:48:38 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18G-0004rZ-Je; Mon, 01 Jun 2026 07:48:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0tVDBLuSzZQE/d88x9ySzGMUzkqrZA8aaCFeFITWAq3aWlO+/ek+aeZOkq4GafNkPjmw7sc0FNRHuM1/I3alzEJItMePnkrhkjlJs9NAEozE0AR7znUC8wzsD0QG9CLTa3Jon9zwFMritHpo5W59K897lJ+yJmIibOUQoFDDqf6b7lVwCiyRqcIJp78N6OJ+FklJamhVKZqIoXiBHt6m3/FnVuqx6ETnfevfRUWyxqN7iL3553o1a4Bljav1vn0LshKmAAwArUpjbItLC3g6JS6eOGv5L6w/pHmhis2mLUpnSagUa7j5iswR4nAMCQ13bi4Mccs1OuS4eZZGvv3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlD6pyhUH8jjkVrSnNE4WiCKsyHJm9VqTGxARHi+44g=;
 b=LncHbDSi9WtC7aWwi1OwK5Kwue1MTug4IVazaLuij/W6m1K/vzGA0eVUAqvantHUouo1gtciCa1Mvmj5A8Ab1RBaLGUEWSf1/XEmhRpnlvIIdgIGs4tiSEkLedNURavhN3LzJzWXZwtFHn+GA89kabdhhAW958QKJLQBJo/RqhpVICoHNvcBSkgycZCp8DHGZjVjkh3gBGo0gyi0qPdZPqjlUu6aUTWjRwG9WOM750xWq+O0npbppqbxyJrcTcWhJ3hrsHgWACNpU2pd9j6vKr4zOCdE6iEsjl5Xq3BhNhgRIZ0xbvXmcQIts00ztLSaeT04m1fAA3fQ59DqeYvwhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlD6pyhUH8jjkVrSnNE4WiCKsyHJm9VqTGxARHi+44g=;
 b=Ryj3g5dPlV+GPYw92XL5LQWuBAU5axz1371wUtcosHAqpvAbEqfoYB0i/Mc3VQt4lp3bLFbxWvew2QFcrbcVZ0RIDd/zJoUBzLE2PrjtVBGwTpxnQByKpHv7QolEgbShNHytlH5NAB9llJNPiml+JnG02/wL8OBAeSU9DZeU0Aj7ROOiIya17D3T4nPTtYtmoLKRgQLMesTZRBPl6YWk3mpO/uA3tTj7b+a9GSQvFaNKEBIXVXEHL2UswE8L9ijS0GN59et9ddf2DRrFaX2WoVbL/lrN/P+JJUyAhgd2nYPTEspCtYxwcmy9FVjespoHt0xQvb4E2SbshAQ2dVUoSQ==
Received: from BN0PR04CA0105.namprd04.prod.outlook.com (2603:10b6:408:ec::20)
 by SA1PR12MB8741.namprd12.prod.outlook.com (2603:10b6:806:378::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Mon, 1 Jun 2026
 11:48:29 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::81) by BN0PR04CA0105.outlook.office365.com
 (2603:10b6:408:ec::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 11:48:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 11:48:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:12 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:09 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 04/31] backends/iommufd: Introduce
 iommufd_backend_viommu_mmap
Date: Mon, 1 Jun 2026 12:41:54 +0100
Message-ID: <20260601114221.457995-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601114221.457995-1-skolothumtho@nvidia.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|SA1PR12MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 87853d12-e4ad-4491-9427-08debfd3b253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099006|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: fhOEZlb/xmn245jvu57w8/Ekz6Ad+KoMEWaWc3wIo58ZS4ZSVUuj6lfTYz3Jy4i0xLGR30LMxnPknEiPNP3OOgen3oAXpqs5CdBo3dNaLKmvBWJgusSlJ8IR8nnplXU6LS5zAKhqaUg4n2G3xj9+KqpOkEPc7GBCGkg1lTD03HaQcF8fSpm7UWxDjb+JzC0OIWif3DlSWDtruQCfm3JUNn/+FvRKFyC4WRR8V2Cx+R1u2UmidD/Zc8EPhHkanxODTUunkVvzqj0STZHAAfDYTwgRPb4hPrN4F3ySEq+QFpAvzZGeTCqTcbnsG795W4Zy7di+wGTGarNNGa5KbAU0ytpnk3quUie/lFt+SRh+UYms+mwgP4j66I0aBwDOjQcPVRsgqpVGff0vYkroLIyX90Z2rr87G9IOOAupiiqsAGJKDGTKA+Cctqwib7GE/b4ZfZDhM6yTyvMhIWQRcTzfWLASp2+yk2PJbv6Y89GHz19WZMZUuwmWyjFTwIG1hI+/HWEf0tScGRYh5SkxyYcUvOXDzho1twiJoVYNKwLrrPBidxxF0IvwU/J/ULADdwQO4vxfR8AvThDSyyVQmcSB7sQgO4w41q6jOZkDvnkql0gmClZD/wbQxyexGiIAVe+ulUptJ6x/YCxhdq1qyQmtOY+fjrUfa+5NbvkK5wX49XQYB3eS6nB6JRgK4XWSyAPB0Dx3q+YPznH+7pIMt1KHrGT8CUZgCwWRC2SvfRLC7LE=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eZLwuLni2ruv6tToy0J+ANJIbILtxqwVgVorwOaOc5d3qc/BNlcGZLhpTMKNcc4NGryMiMA9PWOW6zNsnVaE6XkBKDXJgt3IpdtgC7iPbzpQ1TAyr2TipneYugDCjQV6FI0gSrWm2u9cIMrzfeJWg4//9mwk4mzxHvIPfw/r/8qCX7VHfv+eGAh7qyb88npf5u5q2q2avgbX4O4uODmByAbnkRaIZRbUC3Go02AaUILw5/yoecrAnvGfm3CNyQubqut8SGhWOvitlp2HPU4GXOTjmlWHNLyJ9y9gQi9djekILC+j4YvoXclph0z5S/yET10ZHTxS5WW/FvKzQNs2hUUo5P2vIyg1q+tjCXSQFWJtP3CTe4PI+yGeb+yKYfNICC/7vqA94EOCOwgvukMtQw2ALm9hedqwJaiJRVXK3FesAt0c4vfyEaulERsMxmx4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:48:28.2117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87853d12-e4ad-4491-9427-08debfd3b253
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8741
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Add a backend helper to mmap hardware MMIO regions exposed via iommufd for
a vIOMMU instance. This allows user space to access HW-accelerated MMIO
pages provided by the vIOMMU.

The caller is responsible for unmapping the returned region.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/system/iommufd.h |  4 ++++
 backends/iommufd.c       | 22 ++++++++++++++++++++++
 backends/trace-events    |  1 +
 3 files changed, 27 insertions(+)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index c6f2e87a7e..bb8d5081d7 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -112,6 +112,10 @@ bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
                                     uint64_t addr, uint64_t length,
                                     uint32_t *out_hw_queue_id, Error **errp);
 
+bool iommufd_backend_viommu_mmap(IOMMUFDBackend *be, uint32_t viommu_id,
+                                 uint64_t size, off_t offset, void **out_ptr,
+                                 Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 8eaaf456e8..440c1b82bc 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -580,6 +580,28 @@ bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
     return true;
 }
 
+/*
+ * Helper to mmap HW MMIO regions exposed via iommufd for a vIOMMU instance.
+ * The caller is responsible for unmapping the mapped region.
+ */
+bool iommufd_backend_viommu_mmap(IOMMUFDBackend *be, uint32_t viommu_id,
+                                 uint64_t size, off_t offset, void **out_ptr,
+                                 Error **errp)
+{
+    g_assert(viommu_id);
+    g_assert(out_ptr);
+
+    *out_ptr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, be->fd,
+                   offset);
+    trace_iommufd_backend_viommu_mmap(be->fd, viommu_id, size, offset);
+    if (*out_ptr == MAP_FAILED) {
+        error_setg_errno(errp, errno, "IOMMUFD vIOMMU mmap failed");
+        return false;
+    }
+
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index c5c1d95aad..b63420b73e 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -25,6 +25,7 @@ iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32
 iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
 iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
 iommufd_backend_alloc_hw_queue(int iommufd, uint32_t viommu_id, uint32_t queue_type, uint32_t index, uint64_t addr, uint64_t size, uint32_t queue_id, int ret) " iommufd=%d viommu_id=%u queue_type=%u index=%u addr=0x%"PRIx64" size=0x%"PRIx64" queue_id=%u (%d)"
+iommufd_backend_viommu_mmap(int iommufd, uint32_t viommu_id, uint64_t size, uint64_t offset) " iommufd=%d viommu_id=%u size=0x%"PRIx64" offset=0x%"PRIx64
 
 # igvm-cfg.c
 igvm_reset_enter(int type) "type=%u"
-- 
2.43.0


