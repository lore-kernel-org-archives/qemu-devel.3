Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4617EEE20A8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNBR-00028A-2x; Fri, 06 Feb 2026 09:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAD-0000lo-9E; Fri, 06 Feb 2026 09:50:31 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAA-0007Pm-RY; Fri, 06 Feb 2026 09:50:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjONIu7eZ5OXPR9NjCBRmD8NsBK/wjm7yHSIVLQfRD36KPbKt2p7q+l3hmpdkxjs84CC0FVDdEmGpSryodPaB3pdjqejdjKPSTFT/tSkEhCPbAP41dPqUVO+eD2XSakXPL4TBYDOtPGqGPpbGkinPGLwO7PPv6JiOfBSdqkyF7w7ylGQxpj5qbEZEUNxvM+K37E9piobRaN9W8L9WD2AQM7Tpsr6Wo5yH3mcArc9/wWE003oNZoM8Y4UdMgouRUVFhOe6aV6B05t88sXaKEh+jMBNnxVrTJlnYSV4CUcl60eZaW6GG5UodSelXFnJnTfmZWMZAlVjjmk2MPYl3jUtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmI021rnNTNYvFnpIa5OtwhwrRmnyze7C+V8SDc15tA=;
 b=QBzziRHQFJ63aoFW1WAGM3/Jh52bT+eRWVK3UARiLRhH3ktiqM8ATQ28TfAoRZdL7PJAlqu89wyPNt6hnzTMqcyiXG1dBF5hkbyRN34XQf5IMoTH9cZTC9DZIekp0jp59h23faEjEDBo8Yxz7O+zwv4Z47neA0RLJelYWCuu8ghSK3RVX5PHkqFIFeWdu4SoxFvnx48hy/NX1YdUpHjMBF1v/XLsx+FQPb490w/5/6iAMNKJ0iiWITkA/hPLtowGm2vpEDtj0LjLUekLgn9xsMlbvuaMatwvLNSJxUuCiQaYCWPkYCEykBloU1g85uPW2BVghLFAMXu1ceACtZfSTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmI021rnNTNYvFnpIa5OtwhwrRmnyze7C+V8SDc15tA=;
 b=Gq/28SQJFbeyhIsuCWNqJqyAnfg6boYkyE9cZMgs566dLbos9PzdL7xc66r/UICYOLa5X66NHjp0OtkPiCd+0947Hxh+78S6pGP/Y8LeFBOfMGrB5SkOvg3TwJH7O28LjlTVusy4/b/kNA6I2zsSH5+02tbL9hbPVdsZtUNBqA4qEeXA18xnvvb3rc5E6rpxxhpujv4d3OVbXKiL+C0QpevcnD0BHbqt1t/tUpA7HaCCTTiEIyxTXSBzD5nsQ32E2TU5H3kAv19liI7uPteFSrSWdUN1jwceWCz4ub/3dSHu25V1D7Hf4rCvvgQY+L2NEYvMHNhJ4dKxYNlY4cFJZA==
Received: from BYAPR11CA0074.namprd11.prod.outlook.com (2603:10b6:a03:f4::15)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 14:50:19 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::81) by BYAPR11CA0074.outlook.office365.com
 (2603:10b6:a03:f4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 14:50:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:50:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:50:01 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:58 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 14/24] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs on base
 register programming
Date: Fri, 6 Feb 2026 14:48:13 +0000
Message-ID: <20260206144823.80655-15-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206144823.80655-1-skolothumtho@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|BL3PR12MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 2968cc7c-476e-4ed0-b1ac-08de658f0be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E2T1J8bcxdgWJOUhOGOr1mV0RUhS9pmcYxVWO8exNXjcvNaba2RlHSzJtvc+?=
 =?us-ascii?Q?u2ChClIDXpVs4uCGfI6VJmWHHLcmZT9/RMC2vdrtOVgFPNYkFU/ugdFvuDW7?=
 =?us-ascii?Q?e7pEBTkaFkulfFWJev0rPffflsFM/CcWno1kgbfPAtXSdMjjov3aTl0jJtSI?=
 =?us-ascii?Q?0B8ajeX4nAfRCTpGWg6n00btE0O6wNIB8KqEnzAJ5HXre9l2CDT+HSEUU9II?=
 =?us-ascii?Q?jR+ApRtHnIDuOVykgk3rmfWorQeiszgK6KsjVhFcgM4GbXYndzVFI4ZP8BGI?=
 =?us-ascii?Q?p42vbXtgztbOPVej0AMV+aAeEIth++cpO05XK/racso0EpvhYr7ap2WfGckR?=
 =?us-ascii?Q?KZxyY8wSn1dK0OF2Q1+o2BKfk9aA0nwLqIRpSgbDmmaOF6Vx3plqAWZgocp2?=
 =?us-ascii?Q?FIFuoFAtlbc9kLTIGPudd3uUWIzcDbvHparZVTuTJ8vF3oahPRcNgiuIgnzq?=
 =?us-ascii?Q?AA7jue6TFhr+4NhYtdz6ddbgXPMZV3jPlvSfxs74nOv/zhJLRKIOLW/g5PlZ?=
 =?us-ascii?Q?eUW/W9KzLd7Sko8RRsCe6tJnLZMYxmIz1e9VyCEjeYgB9tQw0qRNd0/FPA7g?=
 =?us-ascii?Q?ofgefbZ/8dCA9LlHa/dIXjKnMTXh5bIWAA++9zT5x2o9cNTX8tu5Ftv336qF?=
 =?us-ascii?Q?s9HQMyCDIxn41ln9kQZWBgfw0nqZWOPTbRogBv+kU+OO274AQH6hZNKhaeIo?=
 =?us-ascii?Q?QO5aJg+71Xq5g9lPVzVxiKNiDkQNTcpP78tTT02dczKcDa1mayNW98yg5CE6?=
 =?us-ascii?Q?yv12eA5T/eu+rqc/MAW+idARiD6yiXZ5iWQ06sES1iZbdDgh4n8OEyLsqTvY?=
 =?us-ascii?Q?5P7fCE3lv5gAxyn+roCXba+2sViBkrnlcAKV5jG9/7Q6aOM6e7CLoPc/X5Cy?=
 =?us-ascii?Q?UzmkFkVGjt34U7K9wJNAudIOeiy0oHLzU6pk485a0veO1BW0O73m+TwJE2B9?=
 =?us-ascii?Q?fR9GCVwV+z2l1lEnshTWlK0aGUyct4XjhzDoUxTORJeVXxj4ACBPqThSYn1L?=
 =?us-ascii?Q?IAZjJXgV2vU8ZifrUUpZmr3KiY0m/9mop5h7KWNs7/oWo7rdr+IjXmFs9zbX?=
 =?us-ascii?Q?s53SKk2RZRbVXXSnVM6jPs2iZw9VrQpfvVVCO0ATrSj8npq64rQHUd/y89rI?=
 =?us-ascii?Q?85vEvC5uCoNeFI1LYnkmvwj+84AtgK9GD2mNuLDOoEGKmgx8Rv81S4YPIJDG?=
 =?us-ascii?Q?KzJu1jVCyaU5kSQIAmgZWB/ELZUgc2nBZRhEOoNNV5TuwVCjHBFQdRtsBt+l?=
 =?us-ascii?Q?ghdpFak46+xOo6HveR09cZrWu4ZcAXyi7yJPA/+5Z2cT6K4Jzfrjcq/YmL7k?=
 =?us-ascii?Q?N4rnhTa9w+AwOMRWUw03frNJwMOzAAmOpn9o/OA5j0C/sfcmFIBM7AmTGbgY?=
 =?us-ascii?Q?2pwdrvRrP4GZDtzkefPSlRuaRVotXAH/A8oa+b8GiKYXt5s6hcGBdYMrhaUm?=
 =?us-ascii?Q?U2azG6LS6zQSZzq/jSuruz53niwKEhbq33bxGl8v6KUozI+31dS10SdV29V0?=
 =?us-ascii?Q?vWBIQiDh7B63Z7zeOvRFnLXAiI92YOVOHk5YxMxXsUgb0bzOTfRZ6KhCHrdz?=
 =?us-ascii?Q?aJX0whBh5lm+Gnj0fGqePVmv1oHvHBxuEt7fwD3osuVwRLVUnxGLXrCWzswv?=
 =?us-ascii?Q?VHOmN+Pv1WrCS+g4fyeI/Uh9dDCqmYvcMynxo5/E0HxXP5edm5gQ2Tchwfk0?=
 =?us-ascii?Q?SC/1Wg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CVtClMW5SlRKHbSiaRJ8fhQPOA/4cGCuAfIX292Ai+BTTCrVUg+RPwfb68iC23PkzMPuH9h7WqIA24qCge3fvw9g5FAV04T13d6qwdSQiqW0Cng3BCgMsHI2nuT6Mea17BBZ48ri3CewxflGtTLBxYxkJh3VKFQatiHQCun551mo0DxlSMBo6LNEsMtf5/a3ObtZvEfbNfbojSttTzRjdK+MYBFRbXoUASTLGO2MhNq3QLfHsMs2jCb/07JQntuAABI/xImJu19F9+3o0VRPwuVDSzNj+XJ37ri3/qHy+wmhV9wP4G73GKUcLMI82JCOi0/usDW5k5c6Bb2sFrfLgDvxtCpWpWfvbKq+yqhb6d4mSVIK/H8Y62jrer2vVqVSTQSoMegJ8X+WnT6bfTlXdQ5K3h5rkyZL32LUlKQ1pCaJ61jGfe58FlsxoqAtjEmw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:50:18.6064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2968cc7c-476e-4ed0-b1ac-08de658f0be5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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

Add support for allocating IOMMUFD hardware queues when VCMDQ base
registers are programmed by the guest.

When a VCMDQ BASE register is written with a valid RAM-backed address,
allocate a corresponding IOMMUFD hardware queue for the CMDQV device.
Any previously allocated queue for the VCMDQ is freed before reallocation.
Writes with invalid addresses (e.g. during reset) are ignored.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 51 ++++++++++++++++++++++++++++++++++++++---
 hw/arm/tegra241-cmdqv.h |  1 +
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 71f9a43bce..57f47a4997 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -170,6 +170,45 @@ static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
     }
 }
 
+static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
+                                       Error **errp)
+{
+    SMMUv3AccelState *accel = cmdqv->s_accel;
+    uint64_t base_mask = (uint64_t)R_VCMDQ0_BASE_L_ADDR_MASK |
+                         (uint64_t)R_VCMDQ0_BASE_H_ADDR_MASK << 32;
+    uint64_t addr = cmdqv->vcmdq_base[index] & base_mask;
+    uint64_t log2 = cmdqv->vcmdq_base[index] & R_VCMDQ0_BASE_L_LOG2SIZE_MASK;
+    uint64_t size = 1ULL << (log2 + 4);
+    IOMMUFDHWqueue *vcmdq = cmdqv->vcmdq[index];
+    IOMMUFDViommu *viommu = accel->viommu;
+    IOMMUFDHWqueue *hw_queue;
+    uint32_t hw_queue_id;
+
+    /* Ignore any invalid address. This may come as part of reset etc */
+    if (!address_space_is_ram(&address_space_memory, addr)) {
+        return true;
+    }
+
+    if (vcmdq) {
+        iommufd_backend_free_id(viommu->iommufd, vcmdq->hw_queue_id);
+        cmdqv->vcmdq[index] = NULL;
+        g_free(vcmdq);
+    }
+
+    if (!iommufd_backend_alloc_hw_queue(viommu->iommufd, viommu->viommu_id,
+                                        IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV,
+                                        index, addr, size, &hw_queue_id,
+                                        errp)) {
+        return false;
+    }
+    hw_queue = g_new(IOMMUFDHWqueue, 1);
+    hw_queue->hw_queue_id = hw_queue_id;
+    hw_queue->viommu = viommu;
+    cmdqv->vcmdq[index] = hw_queue;
+
+    return true;
+}
+
 /*
  * Write a VCMDQ register using VCMDQ0_* offsets.
  *
@@ -178,7 +217,7 @@ static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
  */
 static void
 tegra241_cmdqv_write_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0, int index,
-                           uint64_t value, unsigned size)
+                           uint64_t value, unsigned size, Error **errp)
 {
 
     switch (offset0) {
@@ -207,11 +246,13 @@ tegra241_cmdqv_write_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0, int index,
                 (cmdqv->vcmdq_base[index] & 0xffffffff00000000ULL) |
                 (value & 0xffffffffULL);
         }
+        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
         return;
     case A_VCMDQ0_BASE_H:
         cmdqv->vcmdq_base[index] =
             (cmdqv->vcmdq_base[index] & 0xffffffffULL) |
             ((uint64_t)value << 32);
+        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
         return;
     case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
         if (size == 8) {
@@ -303,7 +344,7 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
     case A_VCMDQ0_CONS_INDX ... A_VCMDQ127_GERRORN:
         index = (offset - 0x10000) / 0x80;
         tegra241_cmdqv_write_vcmdq(cmdqv, offset - 0x80 * index, index, value,
-                                   size);
+                                   size, &local_err);
         break;
     case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ127_CONS_INDX_BASE_DRAM_H:
         /* Same decoding as read() case: See comments above */
@@ -312,12 +353,16 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
     case A_VCMDQ0_BASE_L ... A_VCMDQ127_CONS_INDX_BASE_DRAM_H:
         index = (offset - 0x20000) / 0x80;
         tegra241_cmdqv_write_vcmdq(cmdqv, offset - 0x80 * index, index, value,
-                                   size);
+                                   size, &local_err);
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
                       __func__, offset);
     }
+
+    if (local_err) {
+        error_report_err(local_err);
+    }
 }
 
 static void tegra241_cmdqv_free_veventq(SMMUv3State *s)
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 1bc03c4f97..2f4a8ab35f 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -31,6 +31,7 @@ typedef struct Tegra241CMDQV {
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
     void *vintf_page0;
+    IOMMUFDHWqueue *vcmdq[128];
 
     /* Register Cache */
     uint32_t config;
-- 
2.43.0


