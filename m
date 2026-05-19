Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2E5CD5BA3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHqt-0007pN-FR; Tue, 19 May 2026 06:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHqs-0007oG-3c; Tue, 19 May 2026 06:39:06 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHqq-0006Qg-Iz; Tue, 19 May 2026 06:39:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YipEh0AavSJTlqtsmuCHABQRGc4kRBNYIAVEqAlfHMMXA3bwjVZjJBfg+KjFWIkgiB/UDvg0+bxQ6ef1OH9QNNFZFtfWfUhHg2veYphe6zwozSzNonvh6SJ51ys/vuEi50FaJSNFzaTE4m+UY2rUzerjhxx8KdkGcsj9VoiriuFUtYblZRUbexTBnb8XNQymmHPx3U3ZMNyMkZsrrPseun/YKFq2/18qkG2TsveUPu3904RWKtN20ipXQLuxWfVcvsmCOeTKWD49k1m4+mk912kW1MUeZq9wM8NZeJEFKfxZCggfym7ET2y6DL/QT8UYBx4c0pTNEDxbZxD8JuQC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXwoDOs5zkQzXbcqUq9sdFg0aBSrecsoVza9NedzfL4=;
 b=bPKOCQ55H5Nn/Zrmq+lMg6PG9PQ66cPYyMo2z0CdjhSnzEJr8lXShy9tWMx0vDB64XScz51wAr11jKwYYEOOeNkPwnOZkF9zfqVsITlsdfCe+HgrCwFM0jtRmX1zbvi8TXQjMy42/r3VC0ulSMaorcGsqry39Or4CPwdu6MNsOqN0PHx7stNaAbkHWix4ZrjNXuSiDpciFN1AXeOw8icWGIFGfgbUJ9F5aGCw52FTqTNi2YbBka5DA2Z+v60th80Dj/awfe7tKjp17WCJHT1XVqAtM+0Ms9qdG+BSx63voBTbjwfPthLJhyzeoAPF0Ge+8sWQNz8sRzbLDYkZp0iBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXwoDOs5zkQzXbcqUq9sdFg0aBSrecsoVza9NedzfL4=;
 b=Ygv7+Ci3d2UAufNlvJUDFCmKxpbY2EL1+9deFDm9vhwBookz5Hr40Ggnisso1JGRxKUpqoDYhdJXO7XyAc3R0V8OPgwGpbKw+7Eqo4U3bKrtDJPpBhYpX9nBGJ6dIArQqP0rpF7DrS40PhfmoMZJR+NQW7NyAIDHJllGmPflZqUdWODav6YMcF+tautv6pgVdQUovCMGJ61f5m4b9+9+uxErmtHKHMuTXfVOMr6IBVEDfYdg+XFvfTGTu2CbbwUanp/hzOB1+HLTC03sGNkC2hedxEMWixCDul3F1RaMl+LNzYrgPqBenRX7/TkSKvGjDx8rxxPoKy4bUsTiU+2TOw==
Received: from BL1PR13CA0219.namprd13.prod.outlook.com (2603:10b6:208:2bf::14)
 by SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 10:38:57 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2bf:cafe::a0) by BL1PR13CA0219.outlook.office365.com
 (2603:10b6:208:2bf::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:38:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:38:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:38 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:35 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 06/32] hw/arm/smmuv3-accel: Introduce CMDQV ops interface
Date: Tue, 19 May 2026 11:36:44 +0100
Message-ID: <20260519103727.899332-7-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|SJ0PR12MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0dd2c9-f309-4826-f973-08deb592d4e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 0hr4LiLV1Bo9vehINSWPUY/xhXasIgBXpTLe4ySVp7na2aqQ5oEHA8k+JmvG4Fo3lRHF8x6It67drmk9xz/62VWDq7AJ/9mH5JmUwnfYEWea8V0sABfPV3cs4Niv8niJHyJXOtqgkn/0s3EFkgVrf6ZtUxCbp7Rc6M8zDmtfnVjbLHh4AZKmfAmeEzSmJ5KOLQiT1MMmOUOkmOMoUKMBaziWUoZofJZS9TWPY6QYwmY1RADYKIzuoZhQFWmEuDRg8+fnB+H6k9aaxwiwmsXMZ3ev3nitTdA78alptwjnvkFkeBXFJmaoNY34R+YlOuAUp2lJ6KElW4wP+VzH6P/rILQCC8ZyiKceReFrXLNVf9HEJYBAmLTUC+2r/xZDaN5H8WnV37X5l8TeYBkssmKKkhNQrRNDPvR5vsLvgw0vlAl5qh+LUbnsXHOpEbIr8wOumLkYTVyHi6wsCQU+k9WnfKeJ9F/mgMlA5khxntMk+TWSnYXpjPW72TRoOpRlYwSpA3vtuXXq2yqO+a1p1m4lll/G4IIz3/p9gpV6hP/NvYxwKuNtOzCYINKi4QULws/3j3HtN+Kfsvs3mJBzWAzGy+oMj88a3GFpoEB2R50W2zLomrJb5vamqgFCYhIvMA8MsI5W0uxv/4CwMaBAePli2u1jOv33LcdcdsOSEbzB7Eaq0QLCcxyDjCZcZ4l79GYYFXPjqCmLGZIvjNzuVIbFwtL99Ra0YHv+lZWFdmlUDdw=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W1dHcnxvJC5Q0oTpYISVmMNFTS7GtDi4r+9/JteRbcVMwt9vHqHChr0sR356STnhIf1l42SaRtLnS7hVlcE11/KAMexpluV5D5//MnmhAeiEHTOBA66uLWoGoumfhiIBJHJjNLmwGBHS93lUOl8sVszEMv29qov/8B7CDg1Tx8Py80/VQBrH/JlQyZ8LYtjGacK97/blgjDv6lyW94iDKIpv1EXwftGvptQsrI7aETSxv+SOKYQOIlUItIrI+esOEoU8Hv1aXJNtJsK8620sxKiPgNdc87zsTDvdNCfJRRqGzF0vfPvP0PpBt/NDkEstIHF+0O3bCXOfxPa/+rkCPRS/Vw3sajsocR2Hu3wPvYqOHR25REk4JcECnnf4cYzYAyTLFsQPOa7PuGBdcZVmHkupVeD//oaRttZIhOvijyJWdHsZDLT1fPIY38/FIgB2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:38:57.3108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0dd2c9-f309-4826-f973-08deb592d4e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

Command Queue Virtualization (CMDQV) is a hardware extension available
on certain platforms that allows the SMMUv3 command queue to be
virtualized and passed through to a VM, improving performance.

For example, NVIDIA Tegra241 implements CMDQV to support virtualization
of multiple command queues (VCMDQs).

The term CMDQV is used here generically to refer to any platform that
provides hardware support to virtualize the SMMUv3 command queue.

CMDQV support is a specialization of the IOMMUFD-backed accelerated
SMMUv3 path. Introduce an ops interface to factor out CMDQV-specific
probe, initialization, and vIOMMU allocation logic from the base
implementation. The ops pointer and associated state are stored in
the accelerated SMMUv3 state.

This provides an extensible design to support future vendor-specific
CMDQV implementations.

No functional change.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 87fecb5c68..f82a7112d8 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -10,11 +10,45 @@
 #define HW_ARM_SMMUV3_ACCEL_H
 
 #include "hw/arm/smmu-common.h"
+#include "hw/arm/smmuv3.h"
 #include "system/iommufd.h"
 #ifdef CONFIG_LINUX
 #include <linux/iommufd.h>
 #endif
 
+/*
+ * CMDQ-Virtualization (CMDQV) hardware support, extends the SMMUv3 to
+ * support multiple VCMDQs with virtualization capabilities.
+ * CMDQV specific behavior is factored behind this ops interface.
+ */
+typedef struct SMMUv3AccelCmdqvOps {
+    /**
+     * @probe: Optional callback. Vendor-specific device probing.
+     */
+    bool (*probe)(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev, Error **errp);
+    /**
+     * @init: Optional callback. Initialize CMDQV hardware.
+     */
+    bool (*init)(SMMUv3State *s, Error **errp);
+    /**
+     * @alloc_viommu: Mandatory when probe is implemented.
+     * Allocate CMDQV viommu resources.
+     */
+    bool (*alloc_viommu)(SMMUv3State *s,
+                         HostIOMMUDeviceIOMMUFD *idev,
+                         uint32_t *out_viommu_id,
+                         Error **errp);
+    /**
+     * @free_viommu: Optional callback. Free CMDQV viommu resources.
+     * If NULL, the viommu_id is freed directly via iommufd_backend_free_id().
+     */
+    void (*free_viommu)(SMMUv3State *s);
+    /**
+     * @reset: Optional callback. Reset CMDQV state.
+     */
+    void (*reset)(SMMUv3State *s);
+} SMMUv3AccelCmdqvOps;
+
 /*
  * Represents an accelerated SMMU instance backed by an iommufd vIOMMU object.
  * Holds bypass and abort proxy HWPT IDs used for device attachment.
@@ -27,6 +61,7 @@ typedef struct SMMUv3AccelState {
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
     bool auto_mode;
     bool auto_finalised;
+    const SMMUv3AccelCmdqvOps *cmdqv_ops;
 } SMMUv3AccelState;
 
 typedef struct SMMUS1Hwpt {
-- 
2.43.0


