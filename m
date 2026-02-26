Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60452FC5926
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYyb-0004Ee-PG; Thu, 26 Feb 2026 05:52:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYya-0004Dr-H6; Thu, 26 Feb 2026 05:52:12 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYyZ-0000hs-13; Thu, 26 Feb 2026 05:52:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jopvj/NqNqhG5TKtwhTL8A0blQ6dVdUaAIi4ahykgFPTJcSxzOCdVq5qPMlhEwyLDp/CfYfaflNiQ0jY/5BHWlYtsKeEajmumLs+PeORZ7EsBwe3K8tsBAMoWY01gZwuPQsqG65zoCxG1ou7qUFy5RZA7Jqu5RvffuZeXYpNBANfHWb+XeSoJW90mlp68r/LTfCxramlUBqIpo3BxrDx31kb+EZALDyVuuyZasuliJXW94K2bIOQnXVk91BiH9JPQp2V1CI7MSaFSaXMx9PcXtqCMgM5slH4a6dYOvNufHo5HHxdqud6Y5gsPX4Np/8F6cJPGTsfR/n/qI0c1KWpGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZhdYXogTw9rlCshhYuAvxL6CLuFxiREWJLLOXLAv/M=;
 b=LC3VWyPW2xCpU0tiiTaMTXnASJtAlIqbcORwfw2xiBmYIvKd2nBzxFrKg0F9cvEdHs226JOjLBchJ6eZYCKtfnr9CDRhu090CuVSEkHnlm0zqbvTUAQPqk0XLiBHRooUNwYlte6+oOMiNgbXlf6H+gEdMLopJ/+bxdcjiyfDfzMEE7F0VioyeKFoVjfdo4vrU9pz/YGrvggmsiebUzS0DhZyXuiqorUj7WSyoeBE/HnkQJCOmSpTTctWcEAUZF3lxzPRfpgyXVdEHowyu2a+NFHUJOT+N6Iwq6GVvyzmEmJmze7vt/ggd7MXF18/Py7NpoAdbpdh6p1tFsC9+GodkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZhdYXogTw9rlCshhYuAvxL6CLuFxiREWJLLOXLAv/M=;
 b=tfE+n2rOHxoZrXIhzy+rvbz5CdTszXvN5uILHL3VWt+NTqc+j49QZBEyXSROMDTcrtJUMsdoKVUeLR8v4b0W0yiiVEPIRDgK0oxggLJAVs+59njmpASCc4KnPkPSwRrkfIJo2AQCkfPJygQQJx+7svgokN3f26pVJCDCx0KNBVl2W95P58pU5CYh57PzrDUqtXClplkhvrtI83tKy4FZyvrVFvOnytFC5BsQMOwmzm14eZU7sxvstHn2lXyNh4kVmVJJRNEyaXnnsAyzBTpv9sKGMXVdrTjUDH+tc59BV5YtU622jhAihh2GoHmU0KUneCf5M2AR3FbwHkAQLycGxA==
Received: from SA9P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::26)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 10:52:05 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::1c) by SA9P223CA0021.outlook.office365.com
 (2603:10b6:806:26::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 10:52:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:52:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:51:44 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:51:40 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 05/32] hw/arm/smmuv3-accel: Introduce CMDQV ops interface
Date: Thu, 26 Feb 2026 10:50:29 +0000
Message-ID: <20260226105056.897-6-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|MN2PR12MB4191:EE_
X-MS-Office365-Filtering-Correlation-Id: 70cecba7-a9cd-4307-76e6-08de752514af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: g/U0IN4VmZZL0I/dZ0xel3SYBTmZxuqBHR/p8klDzAxqVbECiLlpoD7gZZz/dSuYsLMg7GkCEyKFgekYkVCr412bZDjzHf44oAty1q9Jm1QnXhHkVS53hNn3dh/rED9B6BtKDCy5uFnUOZS/B1NxcKRdIEQpuSbVvGSfk5bcltWLW10DCzSPch71NrMaJ6fqrRTBjFs7w5zZgB09CnjwJQ80KRf5XzTesePmB/UYyQ6Yl6C/IOjEPYsY63HcbA4dzBv2Gq+4MmqSFhPjJPqMmGqZuIpCtwfD28EWVji4eHDxdIVCSI2eUQ0FqA5tUHy4YSZ1PnjcSrFvQyi5bwmERQdD41941dkrvAN7Eweluzl4K8/zXibf9J7t+ZHU+k8XRxxLfKAA+h4ALitw+gS96hOmNzr2UOdw71sYMnUHlRPpu68UzuGbVEOEhMospH8+/YEiNeUpaidZQbMrJFy0GAlC1F1m1BZ4+KoDGs/oK4mIUQvel9jKIjL7yPZD5F7G73Hu2aN2O+VEW2k3dJwbAbnMud1HnIcaGTjmLj8/bhHFIscooVRWJhbi30ZSucklNVxHpxgYbSlT6G/DKE7CuEKcoKRnKIbI9PoCmGz5gvD5DCKFrejbIPBr3rSQN/pNaRBdYoVjipkYxpgHXPz/vgcEs4HTQjgwsC2PCaC7h7gYwE09b5PUQVZQfu4sXN5ORzhw8RC6ZkLlEz8HlRjX3DIzV0I4ISMtvQeOqWk7O9BpNrRo+ZlCQjh1j/FixAYwoPhrVZTxy7nLK8wt+8d6TwvjXniZnEBEeeCUw8bmwLt6v/HftOAngxjOAx4G5SPys3UCrQBtus8Zs1QfUCHseA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MrOGRPqsinZ5Td8ia8sjjMexmoRSIzwl2MWUps7fBt2etvGrjS4qOwdc3zM6qnWrt4U2AtropyrEnZPEXDSTG39jSkrMzu+bOKGet1U47kSPUgnwSzrr4U0D3Y+N6o+hxpp2q0E6Cn7NcDr3SmN0exI5U29fZoeLDx+E+uinQ2TgkhxOwKdr8w3bWB5TYYaQs4mq8RiZ7D20Ww4W/t7pl3k0WOzawDTDjsfxmIDUqo7/FMI8M9yyTHaXEeNeObzgcpnkZXVT21ThYDJC6tcLwe5dRz3dcnL2ltj7fFScJ12O+hEe5Z/iTtzrdeLVAvVhQmFTC9kX+QcpTuuzJFZoZvDvHFPaq5kDA7QMhS1SOGOtqlUgZJTSuca+aaZ1z75tPw9ux1LIZI0Gs1nyaJ9idH0x3G90VL5l9LzwurmO5oK2nKTv9x/uk2u8LCg3Vsgm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:52:05.2463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cecba7-a9cd-4307-76e6-08de752514af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
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

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 85669d0e00..5bdd01afb5 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -15,6 +15,22 @@
 #include <linux/iommufd.h>
 #endif
 
+/*
+ * CMDQ-Virtualization (CMDQV) hardware support, extends the SMMUv3 to
+ * support multiple VCMDQs with virtualization capabilities.
+ * CMDQV specific behavior is factored behind this ops interface.
+ */
+typedef struct SMMUv3AccelCmdqvOps {
+    bool (*probe)(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev, Error **errp);
+    bool (*init)(SMMUv3State *s, Error **errp);
+    bool (*alloc_viommu)(SMMUv3State *s,
+                         HostIOMMUDeviceIOMMUFD *idev,
+                         uint32_t *out_viommu_id,
+                         Error **errp);
+    void (*free_viommu)(SMMUv3State *s);
+    void (*reset)(SMMUv3State *s);
+} SMMUv3AccelCmdqvOps;
+
 /*
  * Represents an accelerated SMMU instance backed by an iommufd vIOMMU object.
  * Holds bypass and abort proxy HWPT IDs used for device attachment.
@@ -25,6 +41,7 @@ typedef struct SMMUv3AccelState {
     uint32_t bypass_hwpt_id;
     uint32_t abort_hwpt_id;
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
+    const SMMUv3AccelCmdqvOps *cmdqv_ops;
 } SMMUv3AccelState;
 
 typedef struct SMMUS1Hwpt {
-- 
2.43.0


