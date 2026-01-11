Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFFDD2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 20:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1b5-00052Z-Il; Sun, 11 Jan 2026 14:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1ak-00049j-IP; Sun, 11 Jan 2026 14:59:15 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1ai-0004I4-OP; Sun, 11 Jan 2026 14:59:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jl8iYGfYEbEH9RrpiOcmGSQMJwTAw8VaAizV7d+Damxc9kaWd8PBu5clsBqBeIsY8eqYsyWwwY8i8FFOdrsi4WH+71KGlSCAWuF8B5WNWWZg2OaoPlewQO0Vc0E8q7nZXil+ZBLLnyJhKtHLM288BEIUvvcxRZrx/G8KuOVNiBK/8OFWgQPTpMTJVE3+hZm3ekajlEIeaEr/nyhqC3LENLBCsA67dxEgvgzO6Zn84DjLSGLi5T9/hgh6DJK6RjGrNe4lj3XQ1UFt6avlLdn0h+hs4He+oP6Oze2zU1l1i9G3FaA3iMfU9lWNGuOSVTOOaU5r7XYyEvn7ZNnN8x4gCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLjRza6Bc4oMnEVA8TqH1SvlRQ2FNc2USGzHVZFGlZM=;
 b=WRHmL+m+g1FWpoTDBh0VOb6+ReMt/QYT2R12pFrUYAPCZEdLerLzRDNcjemKdiiHZxDbMS0if3JQyHA70mbH0+0ZGbut43+JEAockqZxZi59/8L0en6B728MoHDJK/W16IsamOwjJ98CjO33kiB6+t17Xpy+O2mDtbJrFo/AkFkgu1rgb+c+xWvz7S1fv/7QDwIG2LL/wdYLhEiUbZbIuetT604yGwCzJtI8WZJSorIv04yQpFek5i6omwc1ZMY1JP8HR9vdcM/crBAGaMg3BXjcSxIIdlBHw2UbSXCwTfbjkQO3Jb9/E9u8smeQ0BMg2f1WNG7v7iO8/oB2vXQhrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLjRza6Bc4oMnEVA8TqH1SvlRQ2FNc2USGzHVZFGlZM=;
 b=nN5MGzxrznCMJhyc5BxVxG5jW6I8lAMo/PmMNdIkrAMjhmV2PxIIx/RDzLpTJfpH93ZHyiSywjF1s41mMVD7/hldySv3DFS0YQwBH+PzmEUvYFWFGdnBFSfFobjcg+4INdEpFRFNYrWzUtv0JybxZJ3sq2hTTNoXctrPPhzZEnw/PGF7DP8zMELWC3zBkvQovIy88LEdMLC/AxgIfLQD0maKHEr61qUBUhaIrX5XH57fj/d1Lx1BjIbNk1OyW9c9ineWGWQDRjQ0TW1lDp/Jo70itRW73L6nPeDbxc3aFkcjWXgXB4+4i5xBzbG11+HMn++a8qkL3TgHwyVbuoaDKA==
Received: from SN7PR04CA0002.namprd04.prod.outlook.com (2603:10b6:806:f2::7)
 by PH8PR12MB7423.namprd12.prod.outlook.com (2603:10b6:510:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:59:05 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:f2:cafe::6c) by SN7PR04CA0002.outlook.office365.com
 (2603:10b6:806:f2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:59:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:58:58 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:58:53 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 36/36] hw/arm/smmuv3-accel: Make SubstreamID support
 configurable
Date: Sun, 11 Jan 2026 19:53:22 +0000
Message-ID: <20260111195508.106943-37-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|PH8PR12MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 132285a3-a71d-40a4-e753-08de514be016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2xwKHMTfFaf7/l024twbVgosDSGcRmgKaF3tuZhHDezERK6FarseAMpCRSy8?=
 =?us-ascii?Q?q+BOX8GhDfhT2KkoslLDPw6SRgi3LbEQaWu9n5WWit5awpEnd1idGkyWSUHL?=
 =?us-ascii?Q?f1LwXwFt1yfJGzliTXbQ/qZPutkoJO0J7BAf5yebLUOgWKMMQNYIdQOQ99sH?=
 =?us-ascii?Q?itf3McP1jBEjOLEsXjN3uj88BdrGLQa0EiNLasY2/RWxcCeLyFDi7EZWdCl4?=
 =?us-ascii?Q?fZzuoFFI6vq7ZZqC/m5VxkUI57ahwEKjMkPXc8GdfslUehMOZmV9m05KT1YJ?=
 =?us-ascii?Q?vgh0SyFnCwR0QpOdHoP0pEoHON/gwHJfkQSPN7sWtbYnFnDBhh50daSzvqPh?=
 =?us-ascii?Q?dnkAaor8fp0LhxMjuVa6PfGY3ZqWw+3OAtIHOEHb9E8Pvyc7XZX1oIZEYFfB?=
 =?us-ascii?Q?3BYIr6SwRDMFzOb87DSE6pfzWbGMDBLXmNIA53levr5/lS80tSRIFbxJnWEj?=
 =?us-ascii?Q?g8SMwK+Netj150crBCN9u5eo8oBoccY6+F4UHe+3szer8P1/GLm7xBVi1KZV?=
 =?us-ascii?Q?LfQh7YVa/T7W2KHOio6mg7SkJdGJRoYDaGEYSKCitdAa+ivs7AnGnfp11DEo?=
 =?us-ascii?Q?Tv9PgSzx3ntC6oBDZCa+aIjKgA60tER/skOJBd4eI5vFKHycwtqJyDJEUGm4?=
 =?us-ascii?Q?5zWNGzafOezO/kzKVOyhyNkxLdmsIbVexOMtiNTDXB3p6gpS0406HyjW9tk0?=
 =?us-ascii?Q?iaWY9+UIDenDPNm5B/OnzxE8id8oPmnfdtAh+1kcrniIdcX88SaagObYuifv?=
 =?us-ascii?Q?UwNnmWVnIRNwYlIMcyj1abiP0UblI/BpCEQ7et9tM4ZRMEYjc0dOZ202dcVq?=
 =?us-ascii?Q?jOJgLgS3xaeclvFOiT1bYFg0zOxaeAG8kA727I0gsT6fHSrSWUsWngl6g7fW?=
 =?us-ascii?Q?T0qUa5UB1mRCyNmX1PfQo9fbWwFPZrbbMZvh+2Nh0ck2SoVeRVAZacAEUJt+?=
 =?us-ascii?Q?QvNyZ4NsxQM2Y4PJwY7Pd1v6D2MV1HORwJwsTfXbU4HVN/mNd105Wooum0Xk?=
 =?us-ascii?Q?uowKWzHfr9R5FsTDMfmbWBsRpfObX4oCOqxrfN37GWit8YlEoICfh5ELohfa?=
 =?us-ascii?Q?cfaVm2U5ylaM+WHWmviWxMc46Pwy0jePiL9AjZ9J9eE4OpfeGtF9OXuMGJjL?=
 =?us-ascii?Q?0Ix3BkwZ7fjqdqtW/84Jr4JnNIIMjI71GRMO1/ZJoap0/Mm11CB010lhmklm?=
 =?us-ascii?Q?q4MdlXt10qqMr7HtCfos7g4jIZTBXJ8Q+rdX96qaj+u588aMHOu7mPzBJGLZ?=
 =?us-ascii?Q?RBssSvjPZ0udk84uzyfje30MWHXSusJ+cukY/gzh6OD1+tzhZRWFiEhJ4zHO?=
 =?us-ascii?Q?7Pl4wRkIOLVh3C4wpPGWBj4e/4zcMCX8iaC5taxjS9Xxez9/ZxaKrREbhJMz?=
 =?us-ascii?Q?NP7oB1TC8zaHRNtRlVxaAoP//NcK+r4tgyrL5rDlnjMiAajxunODjptONDsm?=
 =?us-ascii?Q?q18nlP0AWcUCco7k8Mj+XSZ4SHisyoacrkCOEEoWXhwCYEW7GxRkGJDystwv?=
 =?us-ascii?Q?clR2mSWXa5T9diNzWb7HmKRp7agDhIVCDNwjhsH98gsqRXM/E4FJuy30a/1l?=
 =?us-ascii?Q?Ap1epDtkbhNwKAaRMKc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:59:05.5685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 132285a3-a71d-40a4-e753-08de514be016
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7423
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c    | 25 ++++++++++++++++++++++++-
 hw/arm/smmuv3-internal.h |  2 ++
 hw/arm/smmuv3.c          | 22 ++++++++++++++++++++--
 include/hw/arm/smmuv3.h  |  1 +
 4 files changed, 47 insertions(+), 3 deletions(-)

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
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index bcf04d0a27..c462629f79 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -111,6 +111,8 @@ REG32(IDR5,                0x14)
      FIELD(IDR5, VAX,        10, 2);
      FIELD(IDR5, STALL_MAX,  16, 16);
 
+#define SMMU_SSID_MAX_BITS 20
+
 #define SMMU_OAS_44BIT 44
 #define SMMU_OAS_48BIT 48
 #define SMMU_IDR5_OAS_44 4
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


