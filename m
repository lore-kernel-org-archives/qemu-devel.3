Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA4CFC592B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYyb-0004Ec-4g; Thu, 26 Feb 2026 05:52:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYyZ-0004Dd-9c; Thu, 26 Feb 2026 05:52:11 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYyX-0000hd-RA; Thu, 26 Feb 2026 05:52:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGnOVw/uIP4XtrMsUEOTWainCZuhQ9rbjPmQjFhzkgOlgLKUHQ58iNbVh0b8RZWIGy9qYgKonGyhAgXAAENvss9TWWokeWipUwk0ko5ffG4xx6bhwVjlkfNyc3cfB31/k4KOFQkMhDHfg1SloxK4nB//jarbKzFGKwBgaEenlGhCsc7GG4bOzdixBWZs3vFRhVSgcBBoswZhPfuZqDnKcQ1MuL1tjA6ft+viBGWCht8IBGrE4tC0j4z3eHq8J+qjDM3rah97FbsbKpjdm2LEiW6HIgGkPtQYlS7HCXZVbTzBhqlh0uZFKrKTuwwbm2Vqgc17yKy9DfZY87GtHlJwLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8Qa0PpBzFZ84WCU9yjH4j6AI0mxwnw4XDBCA1bGV6Y=;
 b=m0ZEZyiOW28eZJkgZCDbmhoWatMthr22rFQS2ORNEVQyVEehwofmYdAKnQusP81ONXAKwHfk6sZOHHmorqMNJCiprxldZNXiHqdpYUlILtXxBPh/oleaLz2N4IPTOxkBJPONTBnAAMrdvhyTtMJFeVehEjLk1JH4jGmKcDXd/YW+GCtiBd9jwR38qt6qxuSxA610da6TgVxFGu2E/5CoF84x3ZSbYe1WT5qM9YTUgEPiAUchbZTMM5e2/PC+jQWqvcMxspuLS8aO74mtrzFDowRIr5hOjTlgljLZaS9FlkQ8vNWNzfUJxbtI36ueOEKjAHUp2Ud6ofugCFDz02M+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8Qa0PpBzFZ84WCU9yjH4j6AI0mxwnw4XDBCA1bGV6Y=;
 b=rOPankPZtM7OFjs5XO4s9efJ42It3RgSeCMtT+a/Wr2dq2UU6d63FWEj8ci97bsMNht8sFaoiwHUOJY5s6ieZgznN/85q6EDVroEcYnDvTfFoCFB3saJOVA3riOcH2MfcEAOnMaeQ0loNAPShPqX1/KUeJKGGPGjgQokRbbNWh/YZ9mlXr9P3y+FXxsHAZpZ1rxOZ573SovwpszrO8z3DhYm6S4YzaXLeyH5y8CTSr980PNV8v2ZbRjMYHwmQ//w67On3cnS/yHTWtYiE+mkYbUrZDAdhPcJzrEFVZtdNCz4Pd5dFTKd9UHnz0vHSJAiX2j0de/tJaOV9pU2BYROVw==
Received: from PH7P220CA0124.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::27)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 10:52:03 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::93) by PH7P220CA0124.outlook.office365.com
 (2603:10b6:510:327::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Thu,
 26 Feb 2026 10:52:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:52:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:51:40 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:51:36 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 04/32] backends/iommufd: Introduce
 iommufd_backend_viommu_mmap
Date: Thu, 26 Feb 2026 10:50:28 +0000
Message-ID: <20260226105056.897-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226105056.897-1-skolothumtho@nvidia.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|CY5PR12MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 6753a481-3942-4abc-9ed8-08de75251317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|7416014; 
X-Microsoft-Antispam-Message-Info: Wk552MIpNnCZWFSVH4jZQ24H/0rEjCUxMobRLU2iLHCVbcCDgOYalfq8OPbiGgTtqJAUzmvUCchsVAygLDx+ahB5drOUiJJRm/YFG5bxV7WUd3PCovyBnv0I9aLYdSWDwLvshCv2jKG/GdeIqEfNMgGhuFUWtVmvDrKfIV/M2O5S8UFSU3N+O8j9K6dNY0O5VyEDiR/0xpzStFsDNO2WqG0FOl0geuJG1BcPMnfZw4jJSlwhSJo9UP3gT4WyhnWCuYFbVza9wRJuDAzO0Xk2q8P21iKRjAFCjPIG3N+znLVV15rBoiBhVivTeoLPgodksfB6UHbTBSezlltXbkRDoK5LH+TCQ2uO2t2BAgcWYJM2AC9VQtOmKQoBUTwDp+4OfSHYZKWljrwIFBVmlsWxhWjn0CUeYsSuEaQgmDEGPloj4AwuRArX9PaBlk/ZaZObfL1aSVy7Al6aYKG9SBezlZZ5uUH9juloPGlFxglMazAGUcgDNk+C7rrrpwGAPyLY9aPArOtMSRuJxKHfhwy/rZa0FOJSwBs8rat5bmWSvfoeU90GpOxSod8otxT/Bfh4LiVKNPrgtDFFOoy0N0rbPl5v4ULBrX8ehvGMVfbTFRT+ihY/wtTPJe+LLhVXao5C283h7RLcO7HGFKcpllhdJaSRkTbe4AD60aXY1OtEERyoGm+5NuNY+65uG7+Cxcfcbntvsu+YQOSJuMP3JLMUdbzJ+1axFlC3lVmVPi91e42seWERq8KTJU373KPgBIfA1mtmj+w+Uvs916XiRNE5nxmd3aj8cK5YNxicDEPdeteGKWkOdmb+AvpTXswBeCVE
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f/AjbsV90WqgNu1fx3a964MCysNAP4bAjBin8POPhewFsPBVN/mSd0AKHVXWgGJ43A1UCN21iEk6HNl/OAvWEgJqoO+PKMzm6ky2wBiDysKcvxCmf/jcW5WDgOvW2t7uWsWDnRPUKZZYyNgG6/sCcYyPPLmy+IUS3kt/V5Ozgha1sUwfa+jo/E1V10q2C9iVxmKg1kLFONzH4O2egcpB4hanhyye9puQKHrpNz9Nbmu3WPzKro195fgHmvr1+1w9PxtNvO1tX6PpY41EVb4O8azxtPUKYMq6au6GlCtSZ1b/Byo0CTg00hqpppQpDzjIw0HlLkcGLMxpvfmjjSKYnWWeVbvXytQ1R2RgZgF5CilHRg9o3oi+7qdp85OT62TpeE9gZ71OzpM8c4t2ZVuGnX8/6Il/kgRACZcCElSk10YvG/qP0zJSYeJArytdFMuk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:52:02.5375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6753a481-3942-4abc-9ed8-08de75251317
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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
index 86f9c9f4cc..6defdf6a52 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -577,6 +577,28 @@ bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
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


