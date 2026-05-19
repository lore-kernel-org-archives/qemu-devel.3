Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F909CD4F57
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHsr-000614-GH; Tue, 19 May 2026 06:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHso-0005as-7d; Tue, 19 May 2026 06:41:06 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHsj-0007XC-6d; Tue, 19 May 2026 06:41:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPYek8X9P4Dhe8sGfKooBkyW77o+Es4w7kyvcRTIO4/paxeBzFaSi2sv8e4UxoaQ6LYouFEV5tgSdM541fmgNH1a8BxhT8uythH6iduh1Xkyr1zK8YF9yBCUyFhkg28XtIbDvmM1fsedKfPll2RE9WlapFtZM5iRE18pu4d8B3am+WVxY+XNNo4rXt7I7UHTJCLJSc/3/shjE3ZIXw7F3PDurd6BEeOc3cxokHv0gVWhsCzFxWmYq4d/V0nQo2IBHwMiQqHqLYcL3SI+fwIWzvWEAvxFV6Ea6uxIfarGsowG568z4dkp9FCQHWe/1R5YLHuyUjVNSuO5pBZeU//+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJ2yh4zHfmZpub68KH2s9iOe8W332c0T3nuuiUcrwsQ=;
 b=UJaNN8ni140s0f58uj3nQcmmu6Qj+zrFmfwGO29xs4qeXcO5U6k5RTCS0VkPlMoGlR5p5MsqfVn15zeP9KkH4GZlC+Fa8f8ogRGMt08SgXnOx1nM25y5rDIqR/TDDx1HU6wvdgRZZvGPlmpRy2gQ+k1FGl19HO03EdMGxUAWhxMk7P7xclFVwuxqzk+SYooxHrB0MNcwWuUEkJ1BkxXLBIABj+YUW4Er9jiat11t+licJ7krMs5haqy8DsD7IUsMwwcXiuGnorYJRK1XAr4ULRESLS21upxa+xHRZlqbcEEW2IP5cJpuphXmlzob5F9kwpOacaeXsHlEf65IirR+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJ2yh4zHfmZpub68KH2s9iOe8W332c0T3nuuiUcrwsQ=;
 b=Dxa2R8sxFBU5SdzNB4L6t8eO6JP8Vld1bHZ8lNeFoLU9LDnxroxjoNse7CPGcwkJL9h9YHt5qEdDZOVJGGh4emgbYo6hVRfYi1CS9BmDB8FuncDsYTouS1X7Fpc+8moY61avitkAYShoi5WOvKeCggzQcRBLcLUBpKqYXurqZLxEh/NfImStOXnBmJwMT93AwgreAUNCmKbNDvHkJzJpg74S1VQ2FVigzOa9RTilF61TiRTncTQMjzaRDROXzIYOAM82IhuPMz4g8sZ6A5O8SlGx9KNr87aTvIs4jhXScuG/DLS83RGwqame5JzY7Tgywx0+ZcAn3NHroK5ACOed6g==
Received: from BN9PR03CA0359.namprd03.prod.outlook.com (2603:10b6:408:f6::34)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.18; Tue, 19 May 2026 10:40:53 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:f6:cafe::98) by BN9PR03CA0359.outlook.office365.com
 (2603:10b6:408:f6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:40:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:40:34 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:40:31 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 32/32] hw/arm/smmuv3: Add cmdqv property for SMMUv3 device
Date: Tue, 19 May 2026 11:37:10 +0100
Message-ID: <20260519103727.899332-33-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e0810f-056c-4958-9ddf-08deb5931a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|11063799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gAJyzfynLaNM0UBR3msCxXCGidVo/G0sJJ9zCRsA7Em8cxvaSdSIzpgw6aTnr95skAi9ZkL151XoDHcmICJV2aB+YO1CKkfFk/KxxjBQE24R8w/0PLrzkidd3Wx69FfSRbgViIfe/nJDNgCW9a8iST8BZufzE3xOUKawtwGqNemuv0ChheevfvHAesaTcP4KHa2p6G4PxKEcrJhw2P4rKSBkqakDPVj5IAdEe4mxxhKh3ekGqE8olVs0+H/6nIBnDRq06XO3yL7XZdn93UkZ1WfDtBM7EW4bCgYrU+AzpjDVsjn5LU71+YOedUMRGLcgTPskxGmTaSehnpRGizxIuZrQml3FBdM7Xt7o64Y1Q80iicjmPxvMASS7TTVqnBuUnGxLoXe6nYY796bMItq5IRei9CaFiIyKwc7lWCaKLBRGVkJPQ3O9ysZax+g5P3TbrrV9T+ILCab801CWXa11IRNw3lxaFpmlgRxGMYFRDr3AekfDD4x6uI+BKbOWZZUe8A7balkBQ2KYnRrAIAYIGAxzuzh+pB40PAGv6hxmisEdR8lfMSOB3p8Q/5PjtUolu41SK0sBMdwoV4t+QSlaOVUyZ3n91eSZrlCJr/64N1RERg2t6iT7mP2OU/hCrRKfvEO576r8o2I7Q5+iABA9Y+kFYi5lelSx1DDtYqa/7hIYcb1ddCWvKyUEtSGArPoRHA2u/o+ksFAQl9af99SECnfV7fon46vacvqk+OaThZo=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(11063799006)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u4y3yncRlRhSR9aagQjNZll2+HxWvRh48PB7BBn/ptlwv6TdVzaiY9Fi2aLdzuLNh/JpxulUt7oPC8LNQyFLrLlorsX3xaywjgHOAWwYCRCZY4agpTCkiRDw8B/YXZSDXme8f8NbG1+bsyEaff+cFlxe6yjNITL9DOaXX8LjgdaiVHBkBtabEP2HjSQG8g7XXHRT3Xyivxtva+or9B/c5WkZ2X+7Z5PNR4oEukwsZf3s1GOAxfqDQd/lwaBkBQ5O45beXdmjtmcjTtlcHjItUTjsM6Ys19vEabVHNooDmZuNslGts9WrflisZEXhpdzZRSi6fcWzzRv92JZG/vcNXkSXb5v4ISzaSXwSoSw6oWQC3L2YossVOMbjK+siB2XfhkSrhgvKMkB9u8n3GkRULDjnYdlIZq6Ym+QeE4ddaIxC+CIPamkFIGF2FZW6zo3s
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:40:53.2663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e0810f-056c-4958-9ddf-08deb5931a03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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

Introduce a "cmdqv" property to enable Tegra241 CMDQV support.
This is only enabled for accelerated SMMUv3 devices.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c | 8 ++++++++
 qemu-options.hx | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 763b86c417..8c13489a5c 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1994,6 +1994,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
                        "bits if accel=on");
             return false;
         }
+        if (s->cmdqv == ON_OFF_AUTO_ON) {
+            error_setg(errp, "cmdqv can only be enabled if accel=on");
+            return false;
+        }
         return true;
     }
 
@@ -2144,6 +2148,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_AUTO),
     DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
                               SSID_SIZE_MODE_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("cmdqv", SMMUv3State, cmdqv, ON_OFF_AUTO_AUTO),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2188,6 +2193,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
         "A value of 0 disables SubstreamID support. A value greater "
         "than 0 is required to enable PASID support.");
+    object_class_property_set_description(klass, "cmdqv",
+        "Enable/disable CMDQV support (for accel=on). "
+        "Valid values are on, off, and auto. Defaults to auto.");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/qemu-options.hx b/qemu-options.hx
index 46b02a1bb3..c8b8f4e69a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1329,6 +1329,14 @@ SRST
         - With accel=on, auto means the value is automatically derived from the host SMMU.
         - With accel=off, auto is resolved to 0.
 
+    ``cmdqv=on|off|auto`` (default: auto)
+        Enable hardware Command Queue Virtualization (CMDQV) for the
+        SMMUv3 command queue. Currently only the NVIDIA Tegra241 CMDQV
+        implementation is supported.
+
+        - With accel=on, auto means the value is automatically derived from the host SMMU.
+        - With accel=off, auto is resolved to 'off'.
+
 ``-device amd-iommu[,option=...]``
     Enables emulation of an AMD-Vi I/O Memory Management Unit (IOMMU).
     Only available with ``-machine q35``, it supports the following options:
-- 
2.43.0


