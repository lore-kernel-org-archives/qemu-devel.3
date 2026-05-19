Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278EECD5BA4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHqm-0007ad-Kf; Tue, 19 May 2026 06:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHql-0007Xi-7K; Tue, 19 May 2026 06:38:59 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHqj-0006Q1-K2; Tue, 19 May 2026 06:38:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXYiUNksPPK9B9ncnVH96jZHZgF79enpUI2xCuMIuVyGrWxqGsax9IPmJXWmdMYS/kaIc9bhDY30u2KSoj6yaEGxdSdzc2EdlthjhYjJaxGavk13piibE8OSsu9Iokn8PYlXVB5lR1eJ8kN1wPd9j7gSBFnU9m9V62BuIiZO9SgFx3wzh8YrP7k2vg3LtufpaIdTKGMJLaoLe2YSHccKJyN0Rxqqh+GZt2veXccQ3EPYleQI0SZjrrgifzwngohsLHPrXLfXoSJ3JHrqycHIojRIW0HOAyAo9sT2UZQFOi2mW2SQVpzGD3NqyCoJyUGCTmXNmSjDEbSdX6vUHI6sEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlD6pyhUH8jjkVrSnNE4WiCKsyHJm9VqTGxARHi+44g=;
 b=FxxfZfBn9nVDp1KI4C6eS472RTAvIAnwlPthIHfOzQMpwC71S73FIAb0xKeCbHz84IQ5hJEkImFiN6FhW8jF/U2M1id79SYL/K5gtk8MYdiTYf3HnotaaImeV2dBhIGt5i/Uot1qmaS34+50KnTAeFqV/SnVw6ZAjVUPFCQP/ei5wSnfIBMdFVB0Ie4IWjbn7I+6HsLwpF3g5LiWksWId33SL6eJoP56ui6Yt5Mqs7vAwCXlU2TUKUjTyajBwIoOGNh6Rg066te8ZK842LgEo5ogMtor1Js2i75KQKgQ69JE3p++c3ylri0nuTJZvJn9NFrAZoVTAQCMb+yqYjjQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlD6pyhUH8jjkVrSnNE4WiCKsyHJm9VqTGxARHi+44g=;
 b=qATrYslZP71X1dVMnvKz61x5xQT8Ae7TWFkySWOvMzuPKQp9JgleBYCQtm+fsI6AYW9SsWzUI89+OAYG4q7qCe9ReoFb/pOpDVt/FesySk0guWDhQt6nuC2noj3MwsKslcy+W8/Rfzyc9DJbYETw4aMc8XwlDb4vqjRkzp8nxzuWptrBmGveXIip8Mrm5sCF+TJi8q3ZNTrz9Y14UvZ8e4x7htNLCqhmwk/NGOvyXYcRmGRBDlQikEGgO5Id0402lAisbM3eltGjdbb2qze+pJgxt82kz+AAZGfJJ5XFEO2zkmiRiPxss6yD6wLV1j7ABLA/QzAa9tN8uajcH4fNWA==
Received: from BL1PR13CA0166.namprd13.prod.outlook.com (2603:10b6:208:2bd::21)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.25; Tue, 19 May
 2026 10:38:49 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::1d) by BL1PR13CA0166.outlook.office365.com
 (2603:10b6:208:2bd::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:38:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:30 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:27 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 04/32] backends/iommufd: Introduce
 iommufd_backend_viommu_mmap
Date: Tue, 19 May 2026 11:36:42 +0100
Message-ID: <20260519103727.899332-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519103727.899332-1-skolothumtho@nvidia.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DM6PR12MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: b2990cca-5259-4cba-fccf-08deb592d034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4dG6jvaF+5UAF7TK271hEeHhz/Q60Bha8s4dQMR1Hrzb/RsBOLtoHMpoOGDOzKIFnNy/hUfHyzly1NopYniQdmZBoT3F32XO8kVTogbO9mPhnJcZn7hLuPtAyxGlXxlyb+5wB6qivO+bMjs24enSIHcAEM9VO3UhyrU9xac51Ke7O+nocn08l7evPtS4W3aqKYTYPhQw8HvzkB1sAK0kMkljJBzGwA8YUcwVWQnt4nwyj14DpuT0r2es6ftxagWddwoSBfyd6RoxfF5KcmX9lAeTMHbyLcYiXQCPUE7ANB3wca+23GcT0c09Ljfacfz4+qo+KcJpcg4FlwujSG2w8V+YUZivpdbiwAmNpxmJ4RX0uOLsVFgsgfz7qbi2r7d8xqZHkKtqVwi8kisQ3bmVs6J4Tp0xvUp4mUxpDiKJBzvILiHGvi6heFD7AIa+icZhIiDntzZVWDP18FQWPEDBkLrhJmabgqzaD91STT0ZK9MJydJQWOmvAjrFVTQfsMoJEFRn1tVRy8TmvlrXlA7YwNxunrGUCwTkD4eje3QbaJmJWVfZnJi2ECRypo7Wuu3q0nGrw3byPiib9Ut5oT3U/WOIee93ZTxuz/EpJvx1nweeb0mgEiK+U3pdEwsq9F1itx/RGKCsketcUtZYSf7bzAXpD/mcg9AJI6RD0xqICcduWn3dPs1721u832oGV9Wg3IsFQY4nEQbudx4JZKnjm6wQQjayedKd0QoLPInXjuo=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OVzxC8gF2dLKytCvrgsfB/sUMdOqzdDAWp3eg97ZUNh99RbnTVJjDBNIRBqzH2ZpXaQL1vid9p6jsJmL3qltAhLQR7a7FmvZZ29ewbhpcW1ugF7pM3Ngl1vufxctFzBj1DCnl/VsFfu14U3XVIKrOui1KnraZ++hto5CuPcB0nWB5BmCKzphtPhGSeosLmIJEVTZwX9bwMaj512dQgFUKgKH2fxP0215gv3OInFoToKWfn5U0JlQN5bBvQfWUotZISVTMzxNL+3jzhF0VhMlT1aB6KTMj5oT2gYuphV5iR0PrU1ynS1Arzmci8LUx4Cu+QnEd1u4bgIQfHCQzs3tVk6fiGMx8DkgLLMzNaXBo44M5YnKsih6YyX5NBTOZixJYZeLddoiLHXqLp7c9Ecae0Hoa+jhOR6s81jr20Uwm7oftBiIWxznO3Z5R0kMHshZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:38:49.4303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2990cca-5259-4cba-fccf-08deb592d034
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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


