Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74779F4198E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxvs-0000aG-DZ; Wed, 15 Apr 2026 06:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxvk-0000Wt-CF; Wed, 15 Apr 2026 06:57:12 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxvi-0003te-NF; Wed, 15 Apr 2026 06:57:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEBRgHz7lZ7e21I3Y+MtQAb5nq9//dHMVeroicH/qk5GYREjjxPP8DFylJuoGLf72NOYl9nqD298/vCrbsruZUelnBcldHNK0s2O469zCX7w3LFAsUDamFl9IRQuW5dlTJ4xEmkqayuNCcsJWwOGCNaksRXshuSfzS4DRcjbIWn7C1tLIXhij7QHP0GIZS4xO7R902LzLmB50RFPnLAIx8+JJZkmLZnuTVFXnRGLJZUbQdsH7XCH3gBkVCklHnsmObwn15s+usX0CLChKJcz50uqCDNpjcFj8I0Bh6MM68UZxKR66Edc6XODjGW7oNUVSpc3cIo2HqN1L8lS9IpdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgWYlak3dOxH4EYfJaKpkcct/ed9uMqGoroAb1BvOBo=;
 b=mLZ7hP/FSVpVzNLHfT+M0BN5ulwHBshzxy5dRWEoXqiX14r2oMkTYXEkr7maqaB386/+g0RSHCgYhlUoQyBHlfIXqJuu9hQ2D+pa5LnEGKn1Ki8xUZPOby4TFURxnLzQJFKc60VQbpgtOSoICsQP4HK5U3JYTVIHrx/JBXDRJBd//Of0CLsqMZCGyirBHXWOA81lDS+sr+JLTseSp5+FZOKTRTahDp9LDKwy02NtgYEzJFaYBfewGPpGPM2cAV0rPJax5N3UYpN6gWS4b6Qk8N+P8rlYL5aBwoUDX0JLErWAArN2k9GbH30Uepu3hCDHszVzXNPQAxaJ9cXUFA1/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgWYlak3dOxH4EYfJaKpkcct/ed9uMqGoroAb1BvOBo=;
 b=rKeIuwLan7UednqtV9DBW0xeX2A/r+OKwAjBSawz2eMuNkDrzQyQygYP7ty2+vDGv7T8Bvm0cEDBzQa/VxnC9NDoNLbaBYEmzkiU/RYqd+JQl+KSDf/xFbXowemEp6nkHMS/SBx0yZiH07lyMEUFqJlWBbYdkpkXFRFP71Tcku9YOY2dNoe0auz4pI6KXvKgEIL79Ua8YWYJh3kp9m3CbWbBWT6NpUpwp9VmWdI4RuQBU8RnDuKDutpuiUUS9heuuQvF8mE2wp+iEjNlIQua8rt62yrWMta4qaHRW9434ZJXMvMEGzTdcTeU5Q7FMjlDO1f9SOSOuj5ERK0BCmg3UQ==
Received: from MN0P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::16)
 by SA1PR12MB6869.namprd12.prod.outlook.com (2603:10b6:806:25d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 10:57:04 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::99) by MN0P223CA0010.outlook.office365.com
 (2603:10b6:208:52b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.50 via Frontend Transport; Wed,
 15 Apr 2026 10:57:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:57:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:56:47 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:56:43 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 04/31] backends/iommufd: Introduce
 iommufd_backend_viommu_mmap
Date: Wed, 15 Apr 2026 11:55:25 +0100
Message-ID: <20260415105552.622421-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415105552.622421-1-skolothumtho@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SA1PR12MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: fd1bf615-8b1c-4e26-a83e-08de9addba4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: e5Wz6ueXUiDHJsN5P5wNET/rcHu+aeKvO7sznTMQDOdoDVzgGtst5NOqFzghXf8GA11ZXSgZCnUsnKcf85FK9auqUoSFwR2l8CBVWHgoByteYT33jWCaPQitqmO33wGVni76TjlzZzQWO2QA33pAXcY6uijxkwBfp2Pyq1Amdrt5IU4dAioCPPfgJcUNZwsuOa1N+9AZLUykPnjaVBtMXT5VxlcylE1lgnlt33uPcJLAREA+c5mDxX9iVVQN+9ijC0mIUQ7nfTqHurh0zqPjO+bPsxv+YIM7AcZtC4Z0NAlMLHu1Y9C0R9Qy6CK/8Ad/9ZDy2GQ4dRuWJWbME8lWAr2qAh+UzhllE+gxvVuySlPum/ujiaRxyjFrzIvUOaiWf/Ha+HKc56Ehh7IJwV8C8KIFeP4GTrAe54lIXHjEOBPexhZ1l3WYrkaaguGXj5MhaaCShjEKXizb6U6MmBUVW+RX9SKedH3UzDnoPewxeLY+4yjc1XF2M0pM7z4El1iav3+DaK7vFWTxDc6rfXND9Jcv7h+vSAQ4VMU5sxpvMIPJxliZqzX/NHrPLU7aihL+8vowBxJRR6ooveF7j0bEljNLUhjk12YaqfnbOwv4xKFKqx6RI4pr6getUjbDDOrOh9Aqh2xcL+ni08YCmbl9dKW61wplkfBIwi+O4hZlesefMUS1dxRGyotiMrmA7qW6F0B7NWomvWpvN+t7qSYrOFr7PNyGaIDkex0dFoW6pBvvPrT9/R275/UJYc/Fxg1s++SXP+mxSYgd2xWozsRqDg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QAqMrXupBKcJqYVntGq7e4oIkUTwMj2YtABMNA+TGUmWlb25fNCGsuX647bw3TZbG3rF7BgUAL6R86eBiM4Khde6x3S5Q4ddFsZrBSFk+PgKMeYH2BVRj25XQY9I+GTQOumkpyJ5uOPw8s/vVJqzRK5v/BcJM1j4jearizWdsXnWhytwc2QvsP8tzk/x2jmwuk1Ln/Y8XlLYyafwApOjyId5OnaG/if0ud1pL0KDKfOerJ8hvlhcBHMKaUo6S/gcGZz1la7Hde0OR5Z+iSFS1iZizA1JUq3mqGoNHLCqf3tIwfjnTdTqefefnjZjxZUSSym1bGFA0mKiuodJX6jjuS0LuADav6BvBeIsbpfqAihVskqzfjnpgtgUeVlgNLP/BY0L3zdTtSPXZsP7slvyABlOUV5bN6epeieffmXwUltl3CHWM3jvv+BnwcU4bUvC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:57:03.5296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1bf615-8b1c-4e26-a83e-08de9addba4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6869
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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
index 8009ce3d31..38cfceca84 100644
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
index 3be7b07eec..e26675990e 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -587,6 +587,28 @@ bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
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
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
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


