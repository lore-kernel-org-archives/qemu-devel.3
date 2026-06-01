Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F285DCD6E62
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU18Q-0004Zd-Hh; Mon, 01 Jun 2026 07:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18O-0004Z6-50; Mon, 01 Jun 2026 07:48:44 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18M-0004rt-Oz; Mon, 01 Jun 2026 07:48:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R42nX4J6xbpSt3cPAxA4/56E9jWQD2wyRByEY3GWrePvNMspGHCd2wdK/8mgDMf/37tVVL8iw27/Dok2MxPJ+n90yq7HojRw5BI2Jbouyt0d+kbgsR+jwHb5LXaSzBdDAaXt99wcGMCdCB4TjrqXyF7mV5xwkauJTmmyTuNi/PAAKyjnx7LsJt8tQC05I5Erwz/g6Me0fBsY6YxuyQ3rGUBxC4Az5CRTWSQeJywGzyoI5J70txc2i+hbxIniMjV34It2pmx58jtsSK00/V1Mxh4qa9y5CrywJPtY544rIgQIFLlykSkgpA8b+zCa0OOccXRHIVJiytqIRrqaI52xfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fr1JB8HxyXTtLWMxYoK5D5Vhz/BEAPhPcg5tByWK3Zk=;
 b=q7ukSzAJ1i48loPG3uqAA8N1TfDLzYdua+YtCbphpebwXZUqGM58OQ5InJqMNtKf+0K8Nva7Vzr/XlrNfZsU9g4IdWQ1IvcDdWJD85zsCGmKgQPmNFouyCW7J7QfUIzZ+AmGVXMeRRczE9QYBiwslRqgCfOVhnikmIWKFJK5Bas2YoscUM2DNbTmRHe7Ymf0c6ZQtQC/Hj2cOkHGkg86dp/cj7myXdGhylE10UUW/9m3ERQpYq/Gc0a3CFtc4TiQtM49tquN8XVbIfj+BWtB3e25Y7M2VU3+cvCT3c98F+hFFptneTFiTlEZbM86mxRzpWBsyJNZRVehtN5QLqBTBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fr1JB8HxyXTtLWMxYoK5D5Vhz/BEAPhPcg5tByWK3Zk=;
 b=HjpAblz3+myW8448tDfwLvtY86shEv+woGoX8sCMoIu4CDtIdKAZxY+plOkFLmAa90Ai+S3TLnt2MHknZltxfqcCaC1Y8zCPGOWeO2HPEOKNGNU52o117SVxWiCIw+9BIn2eOftfhOwduMbP4ej2ZoLIbdBO/W4e6Q/r1RcOdvwM6+6SCRZuYSRE+Oa29yXUoP8Gryp13CHbVNQcgegtaq//EbKyyhdh24jEsYLjycQ2RO8vl4SBQ0ibTKGWizgWyWFzkkNRgtk7wUEb+OJGgtf/8Ua0+C2CBuAp2GsaGCs8UJHTkKeWnOyI/yWxsymAuUPY7pcta1Fh8039teBdpA==
Received: from BL1PR13CA0238.namprd13.prod.outlook.com (2603:10b6:208:2bf::33)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 11:48:37 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::10) by BL1PR13CA0238.outlook.office365.com
 (2603:10b6:208:2bf::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Mon, 1
 Jun 2026 11:48:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 11:48:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:24 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:21 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 06/31] hw/arm/smmuv3-accel: Introduce CMDQV ops interface
Date: Mon, 1 Jun 2026 12:41:56 +0100
Message-ID: <20260601114221.457995-7-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e70e539-08d2-40dd-89f8-08debfd3b7a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FZn6uY6W7I1MWfuE0aS+FltamLFFy6QuYEPFs/p08vhFHfJXvduzn9Dv/EmKLeVXVUxxc2XCB9dXTtTfzhjRYcZwmSk2qMp3Mgx9Hi5K0rFJ8UT61TE6PUCn2sQ5gPvK7OqBDb3affvbEymjl7CXGeaG4pS9+HhoDSIyiaAKiDC23x+Nc/srvw0PIqjOu7BfIYgNQVFAxIGNr/3qnwjhLYGHkEwSdhWBUmBOoz1iQ9mJ9rRWP8lc9Fy0AofYToAPiutoIIo+nFUDnIJDAFBUtE/zFUrssYGqjZUi5iRhwaMPZDZO/1cGyBAxjwop2zm7Tblrma3shRs63QBczPfgMiJI5W7rM4cOuTGhv1Si0v67HuoRn7VcsMd04cQNBG+1T+6AnlNBoPRMbn5qa5XHFEMaFL5bdPKsbbmGoDChNjcTrOGcKbnwI7Q+5cJi/yCJYUww5ZZ0wl+XqZ+NqTnOov6cYyARzxiakNhF+0nlkYAnvsEsItPrYMKxggvoALASGhC9Q0bEsgnqXa3fUHfg1w2Q7TV0GFoPdeuOyyiEV03H1pc+Wn87H24WcH8GtpOqwymi6pIfTtxLhyWLKDlKSrP6TtjVXTsruHAlsW5B5OXp49khPJJik87WwpL1VU5LKNrsW7gUu6F+bmBUoSIqOk5TvRkV40KCMdOfqO/E2u7dZfmOjB4bwuSZZUXF3oHcpwndiVFK/vkJLvFql2HzvMw+aSbSX3/q+gR3Ed+1UIs=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GGaJKlbTGZ1PbOCOXtAkIhWshHazMU250a1YEIujBht/6QfM2aZxd7Gnv7X3x4YrbLgg7n5VDH7A1OkKe0U5LXR37PPi98+xk+R09TKO9E4NCmoALcRYJD/9ousOeHpSNH+mj3TDe1tTg9dQ8MVV24VYslOY559WpqrYpVDuRB5ZrOgRvPbtcLUpbrsOvDTNEBjjxYGVLp5mU+Y5Hzh9MBIiKbBwzwae+aKWj+fatSQfuktMUnti9Dg8Zw+0sKCz8mO8041IDRkpr6oE3Jajda2YxU2TW+GzfjFttgCiYd+UnEYDpVW3/p/ypktoMwwlqqoSDQnHeLQx8zgeZumFJBXVb5YtMwo/tvu7y4XVMhtpcGdFl7pnAQushpuko1QX/hoRFZj7s+G2R99X6USpbAOUTIruHB2ntOQOh+o9MKi8WJr7MAcvZ3p8w9wGo+qT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:48:37.1439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e70e539-08d2-40dd-89f8-08debfd3b7a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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


