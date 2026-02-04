Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D29CEA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vni8L-0004Ug-Pu; Wed, 04 Feb 2026 14:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vni7x-0004R9-Ro; Wed, 04 Feb 2026 14:01:27 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vni7v-0007PJ-0r; Wed, 04 Feb 2026 14:01:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5gKbl3CWdoqE2/BNjSh9QfuTrC/OMc9Jaf8YHEnck2bK7GjEwgjYEBM7wTpDx0AeAYHia6irQIb3DwL/OOVOXaakCZ7QTYsIrVEpk7ocENAAp/rHZHbRDAFkO2M6hdDXc30VwyJxaZgncaSLEFST/AwqnfCnq2rZimBXdg4cv5mOCtdWNXiIsR4p06yx94jUj3Qgs2Is4bGByblYpSqS2K6w0hlHTFG2Bmb1XE3YbDgcqX5uNAzgXJE3ZAUPCtyuK1+cuTM5F3ucgf255uguUsMyP+6VAPLeId7UnxNGWgpOrKqaAyrialzFYBYICTLxxVGB1Z/Qb4BA4BOJJXVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbFPJsbwlU/0/aHxpOM2PHyeH1R1/PFKKWhI+9w7gBw=;
 b=pN5ZJ8fuKTZRbrhE9ZDR1RWm3TnRaqcCpNoJ6tdUFhlst6c6wWTloQKDfpOFj6IpkeByuy+IXwFu4dY4arAaTCn6nnXKExsIxotQ2ZaZ4SECzkijPhX0F69HC7yFUW1fZr8wXew1zY/aNIUbFUuzhK/0qFTDJAq//9t9f50CqfpyA4vYbxXwfFzWfRP7msXFyTBmgYaA+SV+U4XnKELmmyurUcgKtTmutsynZmGp5Tc8w75m5YSihl+l252DdWO8jnjiWjidCy/TTc0woSkV3XwLx8kGqP7RmoKvOd4pRZVJpl1hdYgWgNEPvrJiNG+B7oujcQVsOt4JDUxC5lU2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbFPJsbwlU/0/aHxpOM2PHyeH1R1/PFKKWhI+9w7gBw=;
 b=ar/mv3AplHEzFhjCGfzrv954M4mMRdE0yDRLHFqHcvD4dhwZNkXObvPt85kZNSIkRT48JcPxJsrc5XnrrxqqjPhXR2R+b2TXlf4GZiH3IdEh52LMfhZm1Yco2evzOr7TDTzw0devOv4TYZXeKqe9SmsXLXhDEDnvAtFHcp+4cwghDMhdDwNXeVePRcj9JE56gODpnUoWIpSxFUGrXZMm6o3k4v/1j3IuApGWkWDRyScb7j76hPqMDT8zuSg7ZO5Kz39p1zdYnWbNSqEsnhMe33j9uO97U4+3MkAA8eVcZrr5epBM8OwFXALsk+SNLyN+TCST8SUi5bymeIco041cOQ==
Received: from BL1PR13CA0361.namprd13.prod.outlook.com (2603:10b6:208:2c0::6)
 by CH1PPF2C6B99E0C.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::609) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 19:01:12 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::a5) by BL1PR13CA0361.outlook.office365.com
 (2603:10b6:208:2c0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 19:01:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 19:01:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:00:43 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:00:39 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 1/5] backends/iommufd: Introduce
 iommufd_backend_alloc_veventq
Date: Wed, 4 Feb 2026 19:00:04 +0000
Message-ID: <20260204190008.20070-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204190008.20070-1-skolothumtho@nvidia.com>
References: <20260204190008.20070-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|CH1PPF2C6B99E0C:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe38aaf-8aa8-42db-37d4-08de641fc387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bXNCh6fJemg8Q69j/wA3z3/6YzkgbS41IVwZzV4rNWNpTEELUrAM0aqwJpaB?=
 =?us-ascii?Q?Oeatj0ydwexv/h3UWN4I5Zh5lqixMlzkeii509RIfUYpwgVjWvpjbWhhdql2?=
 =?us-ascii?Q?BoWPZINrzvBIRyU4Hujr4Px8DoaDP0dF5hmPix4JV8fnccOlMKVPdDPkd0OY?=
 =?us-ascii?Q?VKK9rvAaY/i1I5dzCBmEG5ZjxaPPvI44Bg8Pz5VxxkYr5SNSEjR9S3wCRcfG?=
 =?us-ascii?Q?s6rx4WDZ4ZwIPOeqC4V55j3RmPQ2VvkLhYzHB4rFL/cTIRzFnF1jHcJvRv1r?=
 =?us-ascii?Q?4izTAxfisygyyEKQ/7kUj4ZWtfgM4zXPZz4+fJ07geitqIRzerh1Skz7i9JZ?=
 =?us-ascii?Q?92LQ6jCkNz1X170Rb02OMWEhBxbxO7jwAUHJ/EpQoHJGDofpjAh2JTixWcE/?=
 =?us-ascii?Q?f87xiA6+fGMXsWZA/DcTzyulYvWzbaL8CY3ZgVCcaGAaJ1stvMe1vBm8Oteo?=
 =?us-ascii?Q?9E5lrlr7gV7oo2gfrECMYcQN48cr8F2Xx0PBiVKR+NDNgdIIpyL+39WkwSFA?=
 =?us-ascii?Q?2Ht4sveOsGjTZ8lTkApAMkbB+fnl0V/Fs/e8U8Abf2p0Hr1Xwsp1+aYrnzf3?=
 =?us-ascii?Q?22ju3pGtdMt1okmQHhxEOYMLqx3p9hD0ckAWwAujgO7dtf5Hg1IUhLSgDZyA?=
 =?us-ascii?Q?DNoysNNfazXXTR5GHSmJYahRae7C952NAHuH0fyUIYSmrrqJ8hcpgZbtVp1Y?=
 =?us-ascii?Q?wZ/AieejbvuvVih4Nrif/tpuASkOXEFjPwvOc7DCeT7pm8rNX0f5fpCZTXAu?=
 =?us-ascii?Q?TjT2xowZMktHPXHSb7A75oTJ59OoSLhuQgSXUjFfOHzn8xq0NJTOAxORZnQt?=
 =?us-ascii?Q?H+DHax/6M1QlWGXCtWfox16niQqKOk8XLYAjcf5JHMQHgsLGq+gstNM76dBB?=
 =?us-ascii?Q?e0hSnF/VXTisDG2La3QvrMm2j71GRw7zvX3MHoReHsKL0I++Dn8GZ3pJqltx?=
 =?us-ascii?Q?9NM9s1YRW/79EdV8Ex/9AM7/AfmUAlZofBtJO793QSLmI0DGdEWKcov+z/hx?=
 =?us-ascii?Q?19g8BLGburtDJwSOmt0PHxOvpoVWuxEknYNrDRLc1TdJM0MNStkmwsJMnCJs?=
 =?us-ascii?Q?8uuy60vjP1Mf+sIVo+f7U4DEajx+d0KJyINrVFk/IxphFX5vFLHTxCPZ8jig?=
 =?us-ascii?Q?oE3j/hUQ+d+D6uNATkU+QmRBaTNoNzX5cD3d5n00nnpQipof2ivkN5aEdmo4?=
 =?us-ascii?Q?nuA5iDEM9oZVsLdvDNvWeYVLovqIEIpzFhU0ivnGQWz4+gtToGAAeeBtVnJm?=
 =?us-ascii?Q?LdW/qICNIrmyR5YpD1hYsrq5w2SrSWtCJtgkgMZxRf543a9UDSSuiBgedDl5?=
 =?us-ascii?Q?yuHhncA6PSyoEUdfl+Ver1dX6oDbo63HCmxEaiCyxOojbFr6ik/lGiS/sS8z?=
 =?us-ascii?Q?nOx5PQaafKhlG4l9/YEDMvCTt+87Fyq2Cx9ou62AxbZYiw54YAZG63DsI9HR?=
 =?us-ascii?Q?wbLUnj6YwIMX3SyC5XgFEEubMXvSm2NtK/kdo3svB3JM3RSgpPffP9Pw1hDJ?=
 =?us-ascii?Q?b3Uc2DTl2MEfOgBstReQHRHlWB5TptfWt1ER/xdftoYQE+nlmxl5OiyWX3Kp?=
 =?us-ascii?Q?2U2OczfhEGDSrZ9wPOACN9qLBnczH+2s5oo/oQednVltfRdcQU1DNe512zPX?=
 =?us-ascii?Q?Z6oo824RNIRCAdP/tePmrH1s7UvdJXewyUUIJJlxA/xeqAwHZADh3jGBhIaH?=
 =?us-ascii?Q?++woTQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FPxN5YJYauUYuK7oF8GF6HoXInAdWB5laIxLrbmyb1gZ2384Hcbo9LRP574vxTX8IqWHe8nU5swk4FopRAKjj6twSBd5OVhbqVIMsxSLeEUJ0wkSm+1qoy9gPYAxAain+FQuJ9Z3L0czHwLFFiZUKa+GqvuKNopiJBwFGeXTSmRbwZDqh80JwZrBUGpFxWNZvMzCPUvYk3EsTjlixeuZCAh8VLbUnHQWAnZ1hTyexqI8F10Sge9sj0z2cW3cmwjFbxu+N1atb5Mi8O0jbmTTUjZ6lBsOkzgnknM0KNWQA4OAtS9vH6FPHN91fI2m7diaNuIQ/eEvNgMt9AGr4xUAlXfqSpIplF2zTL2jWSLwpEzLuZ5UamQY/mZCsc1tiFFfYrGd4SDLTp8GNyVS5R9FjjVrBBffE0c1SWMymcp6rPEiKgVhqGqs6+GRhkw6W79q
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 19:01:11.8491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe38aaf-8aa8-42db-37d4-08de641fc387
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2C6B99E0C
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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

Add a new helper for IOMMU_VEVENTQ_ALLOC ioctl to allocate a virtual event
queue (vEVENTQ) for a vIOMMU object.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
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


