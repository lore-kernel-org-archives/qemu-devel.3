Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA397CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmod-0001b2-9x; Fri, 31 Oct 2025 06:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmn3-0007R0-JO; Fri, 31 Oct 2025 06:55:30 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmmy-0003Id-LY; Fri, 31 Oct 2025 06:55:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a07cwg8ZRZwq0vmH6nG7ifUY/CQUYHpHAlJ8rfh5iqTjzUMeOyB4rjOgs9gyq1u4VLb/VLEJio/HHLkeuKAh9O6MW09WDIJyq7po4OneCOIebcPwWUrwPXJE/EAWuZh1nIGfmFruLrEYpPM75wRChvLPIdjlVj+KZrnfa/wBfH+xsMTUnvuSI947xdDTkRZuTwoeAoxcWgMllw7mP3S4cBuIQGRx5Yjgl8HCgZaLQfazQ2cW+pukn9+WZ6o14gdivsXlwCc45TCU7UfScUgygdd/h2si+D5WchinNxOYFG8Os/CIiDFsZ0S1b6PYbrX7/vCyYbgVD4/AU0cpBAvd2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoFFUcBnsusOQozE4jOwG+fxO0EhQtt8w+1c8oJ8dsQ=;
 b=NWiDTkIHq3QaKqXL9ov1f0pr7dWQfID7a9wCPSZGaMNRr/pSmKkvyrE1f1dfqYLonV22DWCa2q3ROX/2GdbGoEaKBjRXvI9ViHKB08l+Yc5eAKtO4dHgs/HmBBCpveWyE+NMxvTiiw3Q1kcBRgPbGoMZA57YildaAavdkn/GZi0Fes2iVLEjw5BPkOqKOL9FdqIOZxqSa/pCUWW5nNFR/2OmeuOY9GelFrMwDmc+3ALkVO4qMxmGAgO/3PKy5IHO0K6ZxLmEMI5vQ6G20OE0FlKo1JxbSqGQpVX6MSwWcdrXwFT6AwYatSsuSTypxdGP+UcmykO0BA+Gmt/+C1C3AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoFFUcBnsusOQozE4jOwG+fxO0EhQtt8w+1c8oJ8dsQ=;
 b=DlNbvM1lYpaa51WrKv7Xd4vXPa8dZmgUBG+Rodevr8t28RjnsKx+pK5pnmk2J4sRXBuIn3JNcakgu2UxMsbc4M7ETunmovhp74bNTQ+kOXY4ZvcowRa3UT0qh3zU/CvGt0aZ4RE9w6ftwr/Nw8SWb7tPAll8tTJQy2Bd3JrgYSCMQ6fVqHa5v1Ht6qw0X8JpIG/piKkyMSApmvrSaadoa3XESqZPQuhjeYEVOb+vaMKkUFtMMCRSJpQAHynJGfYdzL/h39kRj7nZmjCDut7+YxibuI88GINqNLGm4DBeRstwoTYLFBhZENKHKiaVPeVPhsgoEux+axTxqzR6boiKVQ==
Received: from BLAPR03CA0151.namprd03.prod.outlook.com (2603:10b6:208:32f::15)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 10:55:14 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::6d) by BLAPR03CA0151.outlook.office365.com
 (2603:10b6:208:32f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:55:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:55:04 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:55:01 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 32/32] hw/arm/smmuv3-accel: Add support for PASID enable
Date: Fri, 31 Oct 2025 10:50:05 +0000
Message-ID: <20251031105005.24618-33-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ced06d5-feba-413c-ed4d-08de186bf840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|7416014|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y4E+Y/opumKTrm4f1nKJMOorGEOfbQNi7zVgfXLgxMWwBMxQFjJQw/kLpchT?=
 =?us-ascii?Q?ca6OLUKhecLLDQxwzkQW2peSyBCGPBFz2uIlVTIelK22/l+9SJxQV6HX3OPY?=
 =?us-ascii?Q?Y3Tfj24iJhmp76O+vlGQFCH3puL37TpaHoBDRYE2gAvyTXlGOqQMP8+XCkCv?=
 =?us-ascii?Q?3u+ioOYLxKqhadtTjeM01ESND2u6iRMwcDJ5vO7M7V48epISs7/oOPWCz0ti?=
 =?us-ascii?Q?khrNts9aC4B6cDBX6C3j2+06LsylBLt3XDL1r7U+t4Lh/nvo4sEe/y2gqgUL?=
 =?us-ascii?Q?cSVPPaC0/DMpCOzVGgCE8nnrLOcMlls+JeXzKYDsOhyanR/xJGZSP8AhaAVm?=
 =?us-ascii?Q?gJ+0knagz2a2+EH9enLuSCjuLvfMU0hbV2fDHsLMSDp4+ZO1VyuRiAMj5nmt?=
 =?us-ascii?Q?Tkd5I008pj9tzGtVivI5NziNkaKxZOpyRDm+cDb+/pyHu2VPgI0GEPwHIM4O?=
 =?us-ascii?Q?p0pKHngfouL9K/8sVOSw+4TyvesBvpyjyq8ZTfFOnNfxJbi/KUcqDPW4M4NK?=
 =?us-ascii?Q?mdtpMyLVV/3Lr89CzNgttTm3+QdYfXdtR45JgWEGXPIxfeavOjyoNi9zD/C7?=
 =?us-ascii?Q?B1iWDfyvVuNyhijE6k0Cp5NO4+3BDwstTYghmuPO8dlDxG80QHhU5dSsJtDw?=
 =?us-ascii?Q?yfnu2IQ0fAYjxDsqgoxxvwrCiz2acvcKOpjG7jldOYd3o63wUE30OxvkdtjU?=
 =?us-ascii?Q?jlam4d0qSsYGpNzh9LJyKg7zLn1xyp1ydU6aFaNHw9KzOmi5yr3BEtn9Otx1?=
 =?us-ascii?Q?tMVY7lyJA7QBP1Pa8FF5YbtJ3gat6cNxKaXMHDp2y6rfasx54kEPbNDQcmzP?=
 =?us-ascii?Q?W7iirxqq3vLa5F9WQGkf6LZ4Ai5rJ6lKb1jBYkz0yAUtl/JW+9cCnTqCUYOX?=
 =?us-ascii?Q?UiwAzhgS94K9J8Rwoc35ZTK/sPbyWLxRHSaFM2AmfZ2dqVAkX0g0TgHm2ehB?=
 =?us-ascii?Q?xMp9Mzx2o4IV5vsGBa3JOj6iEyBxe1LanWJ6VIp0QSwkpAuy3F/IKgCWJ4ZZ?=
 =?us-ascii?Q?Yh43ZdiCeyv1rcTVGs9yVDR7+2GGf//XeyVZUNOulwTs2/5hkF7zxCdODbkT?=
 =?us-ascii?Q?r5kBxnAoWo4eXB89ZbFStMw9wpg0/NdjSTREGCWU6s8mrl3Z6aDbbQ9sfiE1?=
 =?us-ascii?Q?QEPMoKv+YxOw+FCKNLvsOYn2ECCQsv+jUDuJjaZ8zXzMUVY63lSr3GyLpzXD?=
 =?us-ascii?Q?GknvC3Pv9IKzkNVsl+qCI8fAbGWyBqO89vrnQ2+YD3W5qcyNWyrwNAsIDC+h?=
 =?us-ascii?Q?llJq83NLO5KzfKRQPNW+/XphywPICWdGsFGEULViggN5zqEBke02Y5jp0M9t?=
 =?us-ascii?Q?sOO7Ko9xrCgpEb9V+mlXKu6iY5Uctf474AXsOaluWwVQahhzDDMeidd1bZRr?=
 =?us-ascii?Q?QsSsp2H4mYwWMtGzURvfz/76eXVN5/vCGWfol2PvQjXQ5n0EvD6ft3W39UPx?=
 =?us-ascii?Q?AJ7TiSuORw93FwKNtm1pCoXX9SvP5OqJFelSEeNkL5c011AOdDBFIBgKyfrr?=
 =?us-ascii?Q?ta7iPblMaTh6MgkzqXtCtkO3gveR5HnM0ihPHQzLcCa0nAv3VzltZBbs9IZh?=
 =?us-ascii?Q?J/4I8y165hLaoImQj38=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:55:13.7017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ced06d5-feba-413c-ed4d-08de186bf840
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997
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

QEMU SMMUv3 currently forces SSID (Substream ID) to zero. One key use case
for accelerated mode is Shared Virtual Addressing (SVA), which requires
SSID support so the guest can maintain multiple context descriptors per
substream ID.

Provide an option for user to enable PASID support. A SSIDSIZE of 16
is currently used as default.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c    | 23 ++++++++++++++++++++++-
 hw/arm/smmuv3-internal.h |  1 +
 hw/arm/smmuv3.c          | 10 +++++++++-
 include/hw/arm/smmuv3.h  |  1 +
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index caa4a1d82d..1f206be8e4 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -68,6 +68,12 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
         error_setg(errp, "Host SMMUv3 SIDSIZE not compatible");
         return false;
     }
+    /* If user enables PASID support(pasid=on), QEMU sets SSIDSIZE to 16 */
+    if (FIELD_EX32(info->idr[1], IDR1, SSIDSIZE) <
+                FIELD_EX32(s->idr[1], IDR1, SSIDSIZE)) {
+        error_setg(errp, "Host SMMUv3 SSIDSIZE not compatible");
+        return false;
+    }
 
     /* User can disable QEMU SMMUv3 Range Invalidation support */
     if (FIELD_EX32(info->idr[3], IDR3, RIL) !=
@@ -642,7 +648,14 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
      * The real HW nested support should be reported from host SMMUv3 and if
      * it doesn't, the nesting parent allocation will fail anyway in VFIO core.
      */
-    return VIOMMU_FLAG_WANT_NESTING_PARENT;
+    uint64_t flags = VIOMMU_FLAG_WANT_NESTING_PARENT;
+    SMMUState *bs = opaque;
+    SMMUv3State *s = ARM_SMMUV3(bs);
+
+    if (s->pasid) {
+        flags |= VIOMMU_FLAG_PASID_SUPPORTED;
+    }
+    return flags;
 }
 
 static const PCIIOMMUOps smmuv3_accel_ops = {
@@ -672,6 +685,14 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
     if (s->oas == 48) {
         s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
     }
+
+    /*
+     * By default QEMU SMMUv3 has no PASID(SSID) support. Update IDR1 if user
+     * has enabled it.
+     */
+    if (s->pasid) {
+        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE, SMMU_IDR1_SSIDSIZE);
+    }
 }
 
 /* Based on SMUUv3 GBPA configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index cfc5897569..2e0d8d538b 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -81,6 +81,7 @@ REG32(IDR1,                0x4)
     FIELD(IDR1, ECMDQ,        31, 1)
 
 #define SMMU_IDR1_SIDSIZE 16
+#define SMMU_IDR1_SSIDSIZE 16
 #define SMMU_CMDQS   19
 #define SMMU_EVENTQS 19
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c4d28a3786..e1140fe087 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -611,7 +611,8 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
         }
     }
 
-    if (STE_S1CDMAX(ste) != 0) {
+    /* If pasid enabled, we report SSIDSIZE = 16 */
+    if (!FIELD_EX32(s->idr[1], IDR1, SSIDSIZE) && STE_S1CDMAX(ste) != 0) {
         qemu_log_mask(LOG_UNIMP,
                       "SMMUv3 does not support multiple context descriptors yet\n");
         goto bad_ste;
@@ -1966,6 +1967,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "OAS can only be set to 44 bits if accel=off");
             return false;
         }
+        if (s->pasid) {
+            error_setg(errp, "pasid can only be enabled if accel=on");
+            return false;
+        }
         return false;
     }
 
@@ -2098,6 +2103,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
     DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
+    DEFINE_PROP_BOOL("pasid", SMMUv3State, pasid, false),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2133,6 +2139,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     object_class_property_set_description(klass, "oas",
         "Specify Output Address Size (for accel =on). Supported values "
         "are 44 or 48 bits. Defaults to 44 bits");
+    object_class_property_set_description(klass, "pasid",
+        "Enable/disable PASID support (for accel=on)");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index e4226b66f3..ee0b5ed74f 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -71,6 +71,7 @@ struct SMMUv3State {
     bool ril;
     bool ats;
     uint8_t oas;
+    bool pasid;
 };
 
 typedef enum {
-- 
2.43.0


