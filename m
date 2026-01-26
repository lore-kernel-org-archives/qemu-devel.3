Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4DDCF65DC
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkKBQ-0004NN-Ak; Mon, 26 Jan 2026 05:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkKBO-0004D5-Tk; Mon, 26 Jan 2026 05:50:58 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkKBN-0006Fl-3D; Mon, 26 Jan 2026 05:50:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yx/asK5q1ejmjEJR8T/EOvn+DWQptw9KMx3x1DoJFAtX9YktqnywBUb2OhQPfROE++0DzBN/tCYM+l/D4I72F/NPPrUWu3LAqKoT6YtLzxD3NS8onbRrsX3NoquJ450OSJvxoePtJa/GeGU4ShCrSBzjlOsPe703nZ6Lo8ShEgfLwlYHYpV65lwqxe0cT2gLYNSbhH6orarrg8Gb9i7FdySUdTtlPq3sP/bjEwrDNaM6ss8WavJUdZHgczQjOLfzaXw6KkSMd5DOXGqSgjtSSlhQOpxM/J1kP+LSmR4vG9FlI8tHcSvrecHMZFZTb19OS/bywWGBn3gVsVjHgmJ+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ov4tQAUHPzrhFsFrfKxGL6wrulTQ2yGB8yRjycHkvuM=;
 b=IpPoNICPpO2VYypY6PqvtJ0XpW3UyTkdFWIM0fDyIRYbdCmKg6CJLD82xwelMDBzOT4THoyipfnhYleVNZdjCu0vgDOLUZDEkGS5JSHkT6bcpzoX91iMZEFHh2sPwSr0UhkzqW5BesRl75sTnkdyb7mynt0n/r1YryO8/B1KJXX39cVrVWG5jxGbSNlTXC8zfgso5sGYe4Mto1vDDdaq3n/1vuUKb69O8uZ7uOw+vcIzH7lF9BqogWph+qk3oRBfd7klCo5v0R8I9krAK40lvcVxNvmShF//zrNVOA9I1aF4K4UlrsUK1QMgRZGZOHAPP/te4mdchXoXxcQ+1FUZdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov4tQAUHPzrhFsFrfKxGL6wrulTQ2yGB8yRjycHkvuM=;
 b=uI21Wz3Zv90PUwr9hx8BLZUzeUfNNCGmIMxfyO7YUcuhek4RrFgamDO9fE5w3zC97AAGKqeu5dJfaQ8mHlP5uP/o2HcxOzxsDPhhV8OjiAJaqvkOpqrPVAP23hgQ0Eg/wwybRI5zflx5R3MHfhGrOu6AuUjFy+RTJrsgd1BYL4ypFs/0RCXYVrmE2mxbkG9tq+STIsKi+UQKRhUATCFVC+ApYGR6deZZu3TUtnfB4eIKzM1LQZytHtGuuL+jhFNYf5pxKIgfulzaym+tKHBYqc444quAvO4mYFpSLNmJj2LkseB5vlVQnNiy7w3ektAWDyhgdn7t1uyQSYX75BV13w==
Received: from CH2PR05CA0030.namprd05.prod.outlook.com (2603:10b6:610::43) by
 IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:50:48 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::da) by CH2PR05CA0030.outlook.office365.com
 (2603:10b6:610::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Mon,
 26 Jan 2026 10:50:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:50:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:50:32 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:50:28 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 37/37] hw/arm/smmuv3-accel: Make SubstreamID support
 configurable
Date: Mon, 26 Jan 2026 10:43:34 +0000
Message-ID: <20260126104342.253965-38-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 91470b8f-7123-4ff7-63e4-08de5cc8c414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EnbkiS3wP9CccqX4iRdXf1jv6r16XrBlasAn1nkV938BPChPG+b6kfB6dGnS?=
 =?us-ascii?Q?klpkK3ibuPAjFxdO5a3RdeUAQFRM2jbCWZeepZCOvMkcriraH9Um9MtBclU6?=
 =?us-ascii?Q?CKZwZr/auQTVBBBty5y45UQ7CBkoSEwcppVepeP0CZeaVgRgFLD6J6c7AZi4?=
 =?us-ascii?Q?UbTiw+elFY3EKPyFamQQ0SutagiC4wZP1TUOr2OpLm3Al41+TUa/lQOYh3Q0?=
 =?us-ascii?Q?IacyBtvDuwkH/Ck/LFUkOxNkOL/H6dtHRzkn7tb+O1VgbQ5dxgMKq1ggoSBq?=
 =?us-ascii?Q?YbMjBp4ZIRGnKp0osVZzw+z2PtqG29vnVVultLSc2qWVMjHcuH1Vt0MqdlgS?=
 =?us-ascii?Q?WyjmMDdXJil1q8I5LO9S9BWI4Wf7cp+0LvlsnLfRoXR2GcJyqlHNP2KmDEc4?=
 =?us-ascii?Q?4hNnJCooflHafAEczxINIWGYvqDTuF8Z1QapBCsUMx5J40rWLUqbh0BQIuTd?=
 =?us-ascii?Q?uUI7exrkZhlmZuX7XNnj55+X6hI92vAwDjixcvnXWkBM56tvme8frtZzdQVx?=
 =?us-ascii?Q?+nnobRAtOzwBOkjDEEXb5p2pqkyKW68StP+AbEkc0DQG8bF59jDtXwQqYyZw?=
 =?us-ascii?Q?yxgJpBpOvSKqQwr2M9zQrCfHHk1+LbV0HbxQNZW/QFxPOZNHR8Y3TowMJBbY?=
 =?us-ascii?Q?/4FILqs6HmMEZRX3etJNqEt5/7Af8Q3zu1qxPo084owXlBdRcSk7wUaS8Zrl?=
 =?us-ascii?Q?6BZ8oIPZeRP0ba7W3aVXttzBqBty3PLrIdWFz2++LlkGFQnb7w54Yg8ghyMh?=
 =?us-ascii?Q?aG1PjvbMqse2S5CnTmJw0xEv337EgZ+chJZTCYgPNWWaeLLwKWVPyouSABEg?=
 =?us-ascii?Q?4ww6QjEAG60OnW8NilCYokHHSFToxmfce4ndU3RmqoXn09/KmReClmgDFtU+?=
 =?us-ascii?Q?IF8TdEee96AO7TIkKPQ+AWS3972vmPN1iSBwRc8X17N34ffZkWRQx8cl4BsC?=
 =?us-ascii?Q?1ieMH9UtXfgZ38+PzwFZtOdDiM888DQDrgKNL7IJGn/Fv+Jqt8P4qvZrJODv?=
 =?us-ascii?Q?8aCXwJCtsyCbe6psZxtaxd1GzYm2P5Zo/o3U1QssV+hVSrK6HL8Mky7281nt?=
 =?us-ascii?Q?xpGJ7W6+enJH5OMcsfCxUqT+CRwAtarNuw8fSIuOVgMzHdr0Y+QdiebLT+tF?=
 =?us-ascii?Q?lpiYTlvGuCEDTZxPLXZ3neCkjeAKANIbCUjm8wmek9szExEq1OphWZXepr49?=
 =?us-ascii?Q?4trR/OR9e64tcvxyUEtrhozK3SxNad5ZC7fQar9DHwiHGVVPX3J0f+rs+4as?=
 =?us-ascii?Q?sNoCtTrREPiC8qWBkCvSqPy4OstnM9FxC838NpcElwMPqN5mvpP8rBONAbSF?=
 =?us-ascii?Q?2x400EBRn2E/+kLCGrYHWPCNCSthP404SqBbpplLJ1VaESOhjxpVibg+KXSj?=
 =?us-ascii?Q?Ocg2LK3cplIbr9H0fKNyPmKc0PEQr/fw17MYWfcgkyJX/lXP0sVHqHMBd+1r?=
 =?us-ascii?Q?G0+tc1Z79lXbyxilvq38u/i9Xo//1a0d8B3kIBj+620ZiFTyMpfUPAW+2xpu?=
 =?us-ascii?Q?lvCVW0CtKoWoHXbqi1P2NNVz8il3vU97JmnS+xLmW2wnXXFWcM/AkHVE+etV?=
 =?us-ascii?Q?ED3so66UU7K6vwJLPW7cz9UeHe9sBBQ/gnyqm3j98VeN04OswcMceXhDFipN?=
 =?us-ascii?Q?Cp8Id2CZG6PovXx1iR3Cv0PBrTpiCTjtX/9lUu+KhMAXxOR9UZGQ/3cgjFHG?=
 =?us-ascii?Q?EB44pw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:50:48.4559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91470b8f-7123-4ff7-63e4-08de5cc8c414
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

QEMU SMMUv3 currently reports no SubstreamID support, forcing SSID to
zero. This prevents accelerated use cases such as Shared Virtual
Addressing (SVA), which require multiple Stage-1 context descriptors
indexed by SubstreamID.

Add a new "ssidsize" property to explicitly configure the number of bits
used for SubstreamIDs. A value greater than zero enables SubstreamID
support and advertises PASID capability to the vIOMMU.

The requested SSIDSIZE is validated against host SMMUv3 capabilities and
is only supported when accel=on.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c          | 25 ++++++++++++++++++++++++-
 hw/arm/smmuv3.c                | 22 ++++++++++++++++++++--
 include/hw/arm/smmuv3-common.h |  1 +
 include/hw/arm/smmuv3.h        |  1 +
 4 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 342944da23..f5cd4df336 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -76,6 +76,16 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
         return false;
     }
 
+    /* Check SSIDSIZE value opted-in is compatible with Host SMMUv3 SSIDSIZE */
+    if (FIELD_EX32(info->idr[1], IDR1, SSIDSIZE) <
+                FIELD_EX32(s->idr[1], IDR1, SSIDSIZE)) {
+        error_setg(errp, "Host SMMUv3 SSIDSIZE not compatible "
+                   "(host=%u, QEMU=%u)",
+                   FIELD_EX32(info->idr[1], IDR1, SSIDSIZE),
+                   FIELD_EX32(s->idr[1], IDR1, SSIDSIZE));
+        return false;
+    }
+
     /* User can disable QEMU SMMUv3 Range Invalidation support */
     if (FIELD_EX32(info->idr[3], IDR3, RIL) <
                 FIELD_EX32(s->idr[3], IDR3, RIL)) {
@@ -652,7 +662,14 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
      * The real HW nested support should be reported from host SMMUv3 and if
      * it doesn't, the nesting parent allocation will fail anyway in VFIO core.
      */
-    return VIOMMU_FLAG_WANT_NESTING_PARENT;
+    uint64_t flags = VIOMMU_FLAG_WANT_NESTING_PARENT;
+    SMMUState *bs = opaque;
+    SMMUv3State *s = ARM_SMMUV3(bs);
+
+    if (s->ssidsize) {
+        flags |= VIOMMU_FLAG_PASID_SUPPORTED;
+    }
+    return flags;
 }
 
 static const PCIIOMMUOps smmuv3_accel_ops = {
@@ -680,6 +697,12 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
     if (s->oas == SMMU_OAS_48BIT) {
         s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
     }
+
+    /*
+     * By default QEMU SMMUv3 has no SubstreamID support. Update IDR1 if user
+     * has enabled it.
+     */
+    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE, s->ssidsize);
 }
 
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index cb02184d2d..c08d58c579 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -611,9 +611,11 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
         }
     }
 
-    if (STE_S1CDMAX(ste) != 0) {
+    /* Multiple context descriptors require SubstreamID support */
+    if (!s->ssidsize && STE_S1CDMAX(ste) != 0) {
         qemu_log_mask(LOG_UNIMP,
-                      "SMMUv3 does not support multiple context descriptors yet\n");
+                "SMMUv3: multiple S1 context descriptors require SubstreamID support. "
+                "Configure ssidsize > 0 (requires accel=on)\n");
         goto bad_ste;
     }
 
@@ -1954,6 +1956,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "OAS must be 44 bits when accel=off");
             return false;
         }
+        if (s->ssidsize) {
+            error_setg(errp, "ssidsize can only be set if accel=on");
+            return false;
+        }
         return true;
     }
 
@@ -1968,6 +1974,11 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         error_setg(errp, "OAS can only be set to 44 or 48 bits");
         return false;
     }
+    if (s->ssidsize > SMMU_SSID_MAX_BITS) {
+        error_setg(errp, "ssidsize must be in the range 0 to %d",
+                   SMMU_SSID_MAX_BITS);
+        return false;
+    }
 
     return true;
 }
@@ -2096,6 +2107,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
     DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
+    DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2129,6 +2141,12 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     object_class_property_set_description(klass, "oas",
         "Specify Output Address Size (for accel=on). Supported values "
         "are 44 or 48 bits. Defaults to 44 bits");
+    object_class_property_set_description(klass, "ssidsize",
+        "Number of bits used to represent SubstreamIDs (SSIDs). "
+        "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
+        "Valid range is 0-20, where 0 disables SubstreamID support. "
+        "Defaults to 0. A value greater than 0 is required to enable "
+        "PASID support.");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index abe3565357..67a23fbeaa 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -311,6 +311,7 @@ REG32(IDR1,                0x4)
     FIELD(IDR1, TABLES_PRESET, 30, 1)
     FIELD(IDR1, ECMDQ,        31, 1)
 
+#define SMMU_SSID_MAX_BITS 20
 #define SMMU_IDR1_SIDSIZE 16
 #define SMMU_CMDQS   19
 #define SMMU_EVENTQS 19
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index d488a39cd0..26b2fc42fd 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -72,6 +72,7 @@ struct SMMUv3State {
     bool ril;
     bool ats;
     uint8_t oas;
+    uint8_t ssidsize;
 };
 
 typedef enum {
-- 
2.43.0


