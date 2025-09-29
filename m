Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB97BCAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E6p-0002cB-Ob; Mon, 29 Sep 2025 09:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E6j-0002UU-8u; Mon, 29 Sep 2025 09:40:02 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E6R-0003CZ-Or; Mon, 29 Sep 2025 09:39:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gArY1L/imBxioy2D8+wq2m+uXKDJJOEfFqKwcwjKO9bm0PBLybNLfYSwFbfhvpHb1QU1vCfFSrzywq6nShZjMlvbViVFDC9boyxFU/bdq7sXGEOrTo9XOgRV9xVct0Y5uBCzwUUICVpjKdoPSTiEIQBqLq4QHfOYPZIWh8ErXtIMZ0eEyr9Xc8c6Be4luIjsmdEN0wxVCT4PLWgFwWX7wezCSQqhylpfzB9Tewt0eGZsOOiz2MvuA+eNukIAyNpA2Dw8Vh1q7a7O8tt9KdEshPGbOwj1hCI7pJjt+09VhrMbbMfAvEhN40VPRxHfQPypwT46wKbWR+neB/fYCd9GuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icLiUc2FR64vwBk0ka976FkCAHBA01nq23ch7+aRu64=;
 b=QU4o43zihixGU3l0EaS/ADExLP7YNRvNKGpfqly65hdYLgNfSb7bnc0CtpYftKFvk4iBfmLkhKRgGf9xgNrp12ig6wxiWY2KcKl5glnTn7GqKadjr8NSGNKxPVfLmHg1Dv2GgG5nlU58ZBfclsolHkEHHt6qdNrMRBZsn76s2AFdLH7LNps0YXFmPgQUCw1/pvsRoZqlrg8vkXVzMYy7x8hD4h5uh8aPumQgrYWLrSNGzcJfTr+diN7jdoTeUHii4I05V9RMDuQZTO54M5jRIpGRtiQ1SJW1YacpeXRzALBHShhF7AMTL0OeiVKCLIA4hEOpGEMbxMaT2tls1GmTlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icLiUc2FR64vwBk0ka976FkCAHBA01nq23ch7+aRu64=;
 b=sNcqrtw9giKpuinvaj2q1lxirulgxUwEiGO8i+BHNDeyqafuty8Padg8EcParYOlpOKCg93FORBl9JiuR6hbBjqN0VZNRb8nZnUQ2pmTwlYAVcFTDVADX4tsl/nOe/PyWPFBh0RIYkhpMxa59VVWxdtuPss/ziImXfQhYNcYzC9yuwaqwJLIzYZPmgr3mdJnvyW0AjRrl5tW9K5+bZxbyt+GQfazAkmvvMD7Cwg7JCcd6jqVxWQ+1Kwne3kzExLj536Cd//xzfCbDCsd6525UOMxidAShAgSBulJphQuGcc5gw28jry5BBjZNa+nDu1Nqu+O0v9e2+/Ww/WBhPbI9A==
Received: from CH5P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::6)
 by MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 13:39:28 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::23) by CH5P223CA0019.outlook.office365.com
 (2603:10b6:610:1f3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 13:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:39:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 29 Sep
 2025 06:39:15 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:39:11 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 04/27] hw/arm/smmu-common:Make iommu ops part of SMMUState
Date: Mon, 29 Sep 2025 14:36:20 +0100
Message-ID: <20250929133643.38961-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|MN0PR12MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dee559c-118e-431c-88e2-08ddff5d9cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnNiRy9ndVN6MXl3M1VRcU5yTExMVUlMeGNzcDlUWm1jNjNZaFByZUJ2dVlG?=
 =?utf-8?B?UC8vendmRk1OSjJ4QytZQXY2ZVcrSjA4ZDI0NHV0K3NyQTNHOHFsczhzc0pE?=
 =?utf-8?B?dW55ZEVXenI2R0lQaUJJeDNwNlN4UU1ZMTlGVnRscXk0WDVtSUVTZVZaTUpL?=
 =?utf-8?B?dWdaU1hYVWVQRDdXcVRjTzFkSkhXdGJNRmpFbmlCRlMwOFpFMUFiejhZMXc3?=
 =?utf-8?B?Vmp2SU5JRXpXTEkzVmoxZUwrZnEwWHNzT1BsQUQ4alNNNlJMdlpRTkZwZmZ1?=
 =?utf-8?B?aEl3VUpIWW51blZNS29Rb2lDbkhLM0xFcklydm5qRDB1Sm9IRytHNGVDQ3M1?=
 =?utf-8?B?d2FhQkJEQTBvNzI3RWpXTWwvcForMlJrL2hRcmhGR05TQ3hNVnBxZHVhTEM0?=
 =?utf-8?B?L1dyaTRLbythZElGTkk5ajE1b0JCM3c4WWZKbTI3RkVWNG83R1JQdG9iTEND?=
 =?utf-8?B?WU5TSW1saHJrdkpmNGZoVyt5dFVacGlwUHg3ZGF1enlOWUlQQ0Rpa0FIZVI4?=
 =?utf-8?B?eDlFRk9uZXE4bXF6MTBvVmt5a2RnQ1NGdFBNa2p3VXcxUWtENUNXTGp6a0dS?=
 =?utf-8?B?WXBXZU5qYWp4akVyVm8rV0NMeDkzajRFTUxDWDF5emJoYTRXK0RqdTc2MmZs?=
 =?utf-8?B?b1RyMHhjYTFEVFFVM1d3K2NQQURmdlpFRmc4UDFraVFLZ0FoSkZibW9LZ3Yx?=
 =?utf-8?B?YWNpelFHaW9tZXQwVDBYbmNBZHhMaTBJREdoaTZ4cEU1QUFzMXFrZEdCNTA2?=
 =?utf-8?B?OEVhOXhuOVJZM2lSRzQ0STA3T0xCcGYxWTkxRDZmMzhpNklBYVJhSDVDSTV6?=
 =?utf-8?B?c0JkSXh5VmZicTY4V3dCVUtBR1JjejZ6TXNpVXdDTTdTTnFXM2xPb0ZGT0tq?=
 =?utf-8?B?bHdsN3Q5ZzJHblBTQnl5aWNTRFpZWERpQk5MKzk2Ui9odmR6ckV4cVpqTXhr?=
 =?utf-8?B?Y3Mya3Z0UmpvRll4aFhkbGJuWC9YTkRjSWpOTExiNEIzZ3BZUXVGemh4MEtZ?=
 =?utf-8?B?enRMWXhCNGZzdlF5MmoyK1ZxL2cwZ1BPK3BlY25peFc2ZTgrUm9yNGJHZVdl?=
 =?utf-8?B?b2tPOVAzZTNqZzlvSGFpRUpSTnJnQnQyN3JubWF4S3dGdzZCZXAvNm5BRjFR?=
 =?utf-8?B?NmtYTWgxREJKNlBtbGRDNjV4alJmelFHd21LYzBzOG9ZMWZocC8xdXZXcWpY?=
 =?utf-8?B?dG5sczJoaWRSVU5aT1NkSEJVVzJkeXpiUHcrSVQwTWJ0UjdITjFIVThVdnFD?=
 =?utf-8?B?R2R1NUNUWTllVUNDeEg2N0tDdTQ1UlpPZTdjMXRHbXdsT1BHZVNWc0pWQ3cw?=
 =?utf-8?B?UnM2ODc0R0MrazJ5aVN1Q1Zjd1ZIMHhDcVFrMEpDMWhaSGZQQjVuTGoxZnk2?=
 =?utf-8?B?WFFJNEtGZWxzcEFDQjU1OVB6VjQvbzQ0Zndxc1VMOEVTMzQwVjlRa2p6cXZX?=
 =?utf-8?B?YU5pVXgrZnhXWTVLc1NKYkhqTUhDZ2ZrR2R6NzhvNnR5dEpWM0lCSDlGaWtC?=
 =?utf-8?B?OTNleW1EUnZ5eTJxeHg0am0rZmVUUnN3MFN6YW5YOG15dms4L0RYMGt0K2J6?=
 =?utf-8?B?bW9DWjVXcFdraTZTYTVrMGNicm1udU95cXpYdUl5bkRxZFpLTVk2bXdkT2VZ?=
 =?utf-8?B?YnUwejBJcVpDdERFQWh3cnREYWZ0ZTVJUXZUWEl4d2F2OXcrTml1WXZBM01O?=
 =?utf-8?B?Zm8zV1ZaZk1Qb0I5SEYwNldYYWp5VkNQZE1yQ2ZSNVpQMHJTUEZ6bXFWMEpq?=
 =?utf-8?B?RVNDV2J1RVkwTDBBNFBheFRaTVkyclF6QlBYUWpGbnhxSktjeVJoak5yOWp6?=
 =?utf-8?B?N3BUVEdJR2pvUGhGNnRrUVRXU3dEdngyNGRVSTdEUzcvUngxMkJGWWR2MzJa?=
 =?utf-8?B?SXBpVHVrbHc5WTFlK0lLU0taQTlhanhiZHVEYW9rY1pTdldYSStWcVpnUmli?=
 =?utf-8?B?UUtGcnY2blFzUHpGL1VjQkd5OXBkV1dJNERFREgrL0o3bG1hSlJkZElFUkU1?=
 =?utf-8?B?WGk0Ulo2Sm1Na1d5amhtcEJvbE5DQW9WbCtZdlNiRDBscWwxM3YrOGkybGhY?=
 =?utf-8?B?Rmo5UklSbzFhN0FmMHZrREY1RTJCYWlFck15SGtxYkVIWHBoTHRHcGhzem9a?=
 =?utf-8?Q?f0r4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:39:28.3070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dee559c-118e-431c-88e2-08ddff5d9cd0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

And set to the current default smmu_ops. No functional change intended.
This will allow SMMUv3 accel implementation to set a different iommu ops
later.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmu-common.c         | 7 +++++--
 include/hw/arm/smmu-common.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 59d6147ec9..4d6516443e 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -952,6 +952,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (!s->iommu_ops) {
+        s->iommu_ops = &smmu_ops;
+    }
     /*
      * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
      * root complexes to be associated with SMMU.
@@ -971,9 +974,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         }
 
         if (s->smmu_per_bus) {
-            pci_setup_iommu_per_bus(pci_bus, &smmu_ops, s);
+            pci_setup_iommu_per_bus(pci_bus, s->iommu_ops, s);
         } else {
-            pci_setup_iommu(pci_bus, &smmu_ops, s);
+            pci_setup_iommu(pci_bus, s->iommu_ops, s);
         }
         return;
     }
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index c6f899e403..75b83b2b4a 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -162,6 +162,7 @@ struct SMMUState {
     uint8_t bus_num;
     PCIBus *primary_bus;
     bool smmu_per_bus; /* SMMU is specific to the primary_bus */
+    const PCIIOMMUOps *iommu_ops;
 };
 
 struct SMMUBaseClass {
-- 
2.43.0


