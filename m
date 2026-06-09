Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3197CD8CBD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudI-0007vX-JZ; Tue, 09 Jun 2026 07:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWucR-0006S6-6g; Tue, 09 Jun 2026 07:27:47 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWucI-0002zH-3P; Tue, 09 Jun 2026 07:27:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIuT+NQdp0AIHWg+RtIv/E9mJV+mLyNv+oXD7jgjnPBh1fJb6Oz2lW6Ecayo5vL/Z9RHQ32n83GH/zHg99UY+TeVwpiB0PErrX0dE16kydaAc8E0r0rCyFJf/bd/eU+jFX+9dXmvGdQ6NGJ01er2b0AnCVsm9Rm2twvDr3ShnwgNnpxNkPZYXoDKn654wDRjxSZXQy+TIsilkTC9PX6fMpslNTk5HG3N+qmDBvKV3mIp8P5ZmXOX9A4CKLa+KDp/cgFpfb2HnQ+FhD1UqjkNKIMJ/wn1ZR0UsXpmFZwT9mCwl2IsOZ0o4I++2oL6OPT4CxIojsIru81d/PHgWylZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPRUcrKVA4eH8RvznFC34xlDMOMTsQCLCy6H4okKBbs=;
 b=KNZxZFxUifKGCWXbKkD2HG2FE3l3qI4uXiRRpDVZNVStMAEkponl9lm9iTgihHxSBd4iHa/mpCSyNNq7KVwS4obQEprVW8SKqPOJCSCx1xMiT1UrwP7E4eMgzi77AWCSxFmogD0pbeDyZ9TGThj+z1ITrUZZ/UgdDPM7KNOy2ylAUJ/gE7ISNFVi2tUVZw3kEdHfyP+o8Ep+ecCwZLROa9W/RClXMiN7fq5XpmtIxrkTIFq1YNDfSkOI7jRg+duN5dlKuwfbkP0j71qAImC0H+ww9ey4xyQfvcT3rbm/x3FVfn2K2XEUXg1yX1MPLe9VrD0TDD9earRLQePf/h0zog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPRUcrKVA4eH8RvznFC34xlDMOMTsQCLCy6H4okKBbs=;
 b=rpT7xP72K38o4qO/ujVvcAbbg1JpvRoPa3jqGF2XEMW15rQ2dew7YJAeKSZdx8KUCVc0pOFCttzRts7x/2wv6O87FV2MU1CxHFAtAKqC/pJFFTyPIfP9Q0WBTYHDpu5+tJqBXu4sjuxZLLtVmARmnzK5ca6jl5tDi4zI577Ic4nfSQ9B2ahSDtOtzwlfCpQcYVSfuPM0+lVmLsCHdUGV8zCMWVqZzmhTWKnBylGUKtO/PJea4uOt89h2HK7MOaeuB5WzsGiRQsyc/ISB1cq8JzCKZTW3RN6z4eWlPsAd7+Wht5NQK/H8N5n8WceFvq6gfiVPmlJyeHQ4CrebcFKLCQ==
Received: from MW4PR03CA0123.namprd03.prod.outlook.com (2603:10b6:303:8c::8)
 by SJ2PR12MB8925.namprd12.prod.outlook.com (2603:10b6:a03:542::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 11:27:23 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:8c:cafe::6d) by MW4PR03CA0123.outlook.office365.com
 (2603:10b6:303:8c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.14 via Frontend Transport; Tue, 9
 Jun 2026 11:27:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:27:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:01 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:26:58 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 06/31] hw/arm/smmuv3-accel: Introduce CMDQV ops interface
Date: Tue, 9 Jun 2026 12:25:27 +0100
Message-ID: <20260609112552.378999-7-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609112552.378999-1-skolothumtho@nvidia.com>
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|SJ2PR12MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: 218f44d3-6521-44fe-a0b7-08dec61a13d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KaDo8OFQfkku0OloNw+cr1bPmdyic18JrrayWdZIbYi4gcQw+InRSDcMghoc0CKWky6/+Dv2uwwl4NTqbwOLnn2ZhoIzzKWdZX51kKbpHghNmBb9muVRU8xfF0tCNFauO1nD9MTzD83JdnooB4NmtndyhsqLJu0Y6WjuocvNP6aQ2q9Fs1IL9uuwwN9etwIcowPDsKz+WEZ3ZZMHHwGdy4QgnNSRlmfCI8dvTnoNjkkxZcLWI3olc8bfQjvGQ3cuvNRD0bV1greIJOLTZ38AEnd0v4k3OuvdQ6zOWZSEeAycpY+DbncA/MjGo8FlbKJlEVUuSCLn0rdjYdyU1frQbCGclhps3IEb3ak7FtkKAUEWrwuk3wJJRQXO0QfakWc3Ad0sa8jAttQi3TI1iZamDZZBkQW3+w+E7o2wCoFqA4eEmtqqvJ8S1luG4+mRB/yyW75U5c5ISMams11dTKA9tX/Ut+yDrfbi3dxRjea6twm5FJnxRMYDZazLe2mfTNZzb7E/qSa9BI8cj4UsJTSLnccwCPhikYr9NuAoC3fHXOoe9+NCBWD8RnsxDRubysozHVad7rfCtPoP8ElH0HwfqVIY+HrHrieXpBr7m+YQ+OjZrzm5+TiWzADOldnsZpyXpi/4SJh3XHmcHqEWn4SzTG1d3by72bAnaHAVxoUvGxH89mvKjh4RG8UD/nzQRehQ64XG2iN+l4LyoFLx6U5WVils2Z2VgEz42AV9WuNJ3GQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6f1JY+YfBaCZqR6Xol3lk6SlePD3w12SabpjkIVrBMo79f0OpoRiO7i95MjcKP2+WxbMRCcSakKwCDj3vgJwEtLkRD5KUENWTopAfIYD947VTpxFQ1N4OCvT2Pi5dX5qoTLGiweI6dud5eFzSNYMvJ4Z1pmnpRO/HhnxMISZUuu3UR51a6gR744WR7mKzpGtuz2kIPAioJsmjFbfFRXFuEOj93odGhprMDwxE6vRg3W6e0FS6ia5fN4Iflcp4QNvCw8v04k+6Nto7nGqmjWi81QbwJ+SGeyXJ1yb5yQAgh8B44qPyEli6bg2SEQKcj6DTgZThCWj2/1cEC8dhaN/KoYP3fSHVNP+aVsXhjLRGklPtP6YBIC1TyHRaDY2Wo0rtaT9V9z9hKjhd4vRj+hBcdNKsajffPNgVJdGddrP2Kkfh/E0Knsqika2L4iYzav7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:27:23.6210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 218f44d3-6521-44fe-a0b7-08dec61a13d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8925
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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 87fecb5c68..b45f25ad03 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -10,11 +10,44 @@
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
+     * @probe: Mandatory. Vendor-specific device probing.
+     */
+    bool (*probe)(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev, Error **errp);
+    /**
+     * @init: Optional callback. Initialize CMDQV hardware.
+     */
+    bool (*init)(SMMUv3State *s, Error **errp);
+    /**
+     * @alloc_viommu: Mandatory. Allocate CMDQV viommu resources.
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
@@ -27,6 +60,7 @@ typedef struct SMMUv3AccelState {
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
     bool auto_mode;
     bool auto_finalised;
+    const SMMUv3AccelCmdqvOps *cmdqv_ops;
 } SMMUv3AccelState;
 
 typedef struct SMMUS1Hwpt {
-- 
2.43.0


