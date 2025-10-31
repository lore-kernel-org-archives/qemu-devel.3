Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE9CCCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmn6-0007PG-48; Fri, 31 Oct 2025 06:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmmf-0006u8-5B; Fri, 31 Oct 2025 06:55:05 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmma-00034N-Uy; Fri, 31 Oct 2025 06:55:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tk2C/rXECeycSM5Cn9Ns1BFjNPW61XjFWFpaH9TZdrom+FQWxeeQ+ov2EYuuZce7muNZrCy6FzcgzAkVhAj9ON0bBe+K1QXYx6S23Uc769UC2GKulWWzFF2dhhMFxb9J0aCEx3lELo1moHgcF/AQnfvwbEwSR9DPVYOit5KS13ZUkT9vTifSqJlHMzH1fDu/Q61znNaO9MG1ncD+5JsSmXtolPawz/XsoSsSrCVtVnhppwt8MzpEraG/Dz+FAwI5G5R5W6VlAlFVGdn1hEr9LBAk19uQBZjEXSeIapctdz8krQDFG+t1tvUPa01iVJ200AiNUAfnfVJjt9vQsFaBHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJbYO1QWxZ6zOVqfOhWuQaMdT3xdK+Ib9smb9Zv+QBM=;
 b=XlrCqz8bsP8TUWysCkJTDksiF0gOr2QI1wlUaNB17NMtg3jhT/7Vu1hjdhzhjmraIKtLO1uSFVqviVHBhFLTgXaN+Tv5iThNi1cov1SoVr+aqPSOgZmk+gUMm2VJzeKND0ECWrCSQMHrXvlQbIm0u7WYdm7JPuS6Cfgbj3WGThWZUIXFt0fhBVG1d8t0eyfpQeUSOepWJXtn1fRG1obO9ryQI3Gfb2yYGoxi8M1adUpmqBF0qpG9dpSpg/Q2PobNVWTyybCLdu93JMRhpdMJSdZAU53p+VoNmgBZ5BbOgnDfwGxiqJfVaBQJ36z/s0n2wSElCaqapE17/e+KuKZvow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJbYO1QWxZ6zOVqfOhWuQaMdT3xdK+Ib9smb9Zv+QBM=;
 b=bz+QV9uBtwfvI8xg4uwCE7l9TpHt1F6pZKGGaDTaLMpFDXiDvlBthpFJN6JIFtDY8JaYKoiLaxTVYS6TJvlluTS3uN0yO1pcJVuuICGTGGbHt4IepptAHKJcylP1CVAY5WUNqpXmiHESg5+tF6Qe4/4OrT1jiviRhgZiRo9yQU3xYmvs414s1UCDPzwgi8giWo9TLfu1Rqsxp3j7JOAbtSoDmBeK5fboetSU9Hk5VzuOtufUBESLkm+BqXgQ6rx/kD/LjfVK2SNABiNt6WDp4XKRJShHigJ52yxZSLjcBVwnCmC9yqvn/fkJ06xJRRlxdHmpYNvQ4G9E8nzXHITrgw==
Received: from MN2PR12CA0008.namprd12.prod.outlook.com (2603:10b6:208:a8::21)
 by LV5PR12MB9778.namprd12.prod.outlook.com (2603:10b6:408:300::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 10:54:48 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:a8:cafe::c9) by MN2PR12CA0008.outlook.office365.com
 (2603:10b6:208:a8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:54:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 03:54:39 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:54:35 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 27/32] hw/arm/smmuv3-accel: Add support for ATS
Date: Fri, 31 Oct 2025 10:50:00 +0000
Message-ID: <20251031105005.24618-28-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|LV5PR12MB9778:EE_
X-MS-Office365-Filtering-Correlation-Id: 061cd689-fd2a-4ede-54b3-08de186be8fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KAzNTYO8LbozbFrnaQh7/oFqz0luOVV0trS3XS64XYuy2oImCxmBjShCrFlU?=
 =?us-ascii?Q?HqJJg5Eo1ZlfWZlgSnz113o+w+hup0f0O0zlbFjvheZlbNA1pMYOejVp0jVf?=
 =?us-ascii?Q?5v9kYL6s15te6sQRKekYJxGp5bBkRUd8aWJUglpom10mqJiwdAigd7T3GrDA?=
 =?us-ascii?Q?7cXU1VBtx3vYAMObtAu/gKCNh4Q6YJ6sam/uWceecjl7nSWGJ/Ede59CZE8k?=
 =?us-ascii?Q?uDqIqDeVKe9gkeo3Ty8R1QX9kM07MjUT1V1aBsV8UdH97LVDbswG/xnesNeq?=
 =?us-ascii?Q?8yLAyiA5+yyeRo5kJI0ar3TNtMW66Ts+x68J+envwtFw1Awjq5HfC72dcT3p?=
 =?us-ascii?Q?/V/twQcEeogqpiEEHwwokBkhCOtLxXCc071sf1g28YeD2G0JXhXCOp/y5xeJ?=
 =?us-ascii?Q?6HDHdxyWSgsVMAkEqkaXXbULzN4AUGOVIb6pzPbbV2ZofzqFFBFN8r1HBnTr?=
 =?us-ascii?Q?5JI1sH9RRLA5SWq9CKAPv9j/sex/ypxf+weV4b7yeikFeMEPgfObQAK7Jq36?=
 =?us-ascii?Q?ETuyeu6pOWwZ5iOqTCmcCpqbgWHUO8TaDx9g1Igo0mlQuKXI9ZaONoIh8gF5?=
 =?us-ascii?Q?1LoNDXdxqRDl+hE04McVWvUuAv/fb/ipTHdTwS73s//pQgRNv70wzuBE7JnD?=
 =?us-ascii?Q?/5GNmv6Daa633Q4y/6+AQMR+6g89dIZXrvB1DlPGsmaPRuRbvY4KDJJtvpBV?=
 =?us-ascii?Q?WdeMZO9icZiwp9h+NGqSXv8NorO4nAb4hzfy2CqEu++6+z63+Y1uy8GJqO1F?=
 =?us-ascii?Q?z9YOvON79lxI0/CUcarLa/Z+/KdOmfjzdBAr6SNA5L79ScwGAxrMGu4YESJw?=
 =?us-ascii?Q?SwFoblXZVBMkTpVgI1lMY9+cOaWZDKNOmgdo2GGvlQLeKdr9SRDs6Gu6s2N0?=
 =?us-ascii?Q?e3+aLnCXrTa30+v/pclkxLjSdZgSnAVPrRGZBH88imfXUjiqXTa2bbrUoGHL?=
 =?us-ascii?Q?gJRI992h/vQDaG0e61ubfzKoRbhXIL424m+jH7ujWJwelP1gYpC7n5Whs98o?=
 =?us-ascii?Q?9EFCr4eGYSPVupqvGQAlP1Y2JmREA3nvuJCocmLnyVeJ3oJlauWRWZkJ9u3i?=
 =?us-ascii?Q?f1BA46rEHJ4g1duqny6F5y/NZ+/FVS2zr3dtnqtBlTFsQikMcGm9mzWmGoJi?=
 =?us-ascii?Q?VhQvxpxyHtDhlsaFVTCO338RfFJ9bk6ZcR0wDzV4BOprR/3ZiMG8aLKoPVs3?=
 =?us-ascii?Q?HzUi2tE8X8BlBKdOr5ReuI3ZAWiprASBKdgcLBplRxH2gCAb8lFEQ3H9qCyG?=
 =?us-ascii?Q?ESn/q/zF0KWCQuzIQ/OWc8kAckvFwY5XiET8BGXjtDzqH/OThyW07ui9CuQY?=
 =?us-ascii?Q?xGdp5z0O/CPTQxgxCB+4GvwRpgyZTawV7AqoXzoDLd0jvknRV9me9K3siJq7?=
 =?us-ascii?Q?ZXs21tutM2kZrM0RX1llSuhphkiYwH9ODENZMnp2sB3u59BHY8Ygd7nqP8zA?=
 =?us-ascii?Q?6HafWt4yllDRgRG4T1iHZP6HCKSlS0AXYQHRpbXyalragRJWDZWA3/BgZaCH?=
 =?us-ascii?Q?NyZyJ7llDfGZzHAu5IIFbfpSi+40dyRepPquVDIupbGCy9GRdjL8byK3euw/?=
 =?us-ascii?Q?RUsrkBNzOqJHjZ2XsQA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:54:48.0850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 061cd689-fd2a-4ede-54b3-08de186be8fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9778
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

QEMU SMMUv3 does not enable ATS (Address Translation Services) by default.
When accelerated mode is enabled and the host SMMUv3 supports ATS, it can
be useful to report ATS capability to the guest so it can take advantage
of it if the device also supports ATS.

Note: ATS support cannot be reliably detected from the host SMMUv3 IDR
registers alone, as firmware ACPI IORT tables may override them. The
user must therefore ensure the support before enabling it.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c    |  4 ++++
 hw/arm/smmuv3.c          | 25 ++++++++++++++++++++++++-
 hw/arm/virt-acpi-build.c | 10 ++++++++--
 include/hw/arm/smmuv3.h  |  1 +
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 35298350cb..5b0ef3804a 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -645,6 +645,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
     if (!s->ril) {
         s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 0);
     }
+    /* QEMU SMMUv3 has no ATS. Update IDR0 if user has enabled it */
+    if (s->ats) {
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1); /* ATS */
+    }
 }
 
 /* Based on SMUUv3 GBPA configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index b9d96f5762..d95279a733 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1517,13 +1517,28 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
              */
             smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2);
             break;
+        case SMMU_CMD_ATC_INV:
+        {
+            SMMUDevice *sdev = smmu_find_sdev(bs, CMD_SID(&cmd));
+            Error *local_err = NULL;
+
+            if (!sdev) {
+                break;
+            }
+
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, &local_err)) {
+                error_report_err(local_err);
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
+            break;
+        }
         case SMMU_CMD_TLBI_EL3_ALL:
         case SMMU_CMD_TLBI_EL3_VA:
         case SMMU_CMD_TLBI_EL2_ALL:
         case SMMU_CMD_TLBI_EL2_ASID:
         case SMMU_CMD_TLBI_EL2_VA:
         case SMMU_CMD_TLBI_EL2_VAA:
-        case SMMU_CMD_ATC_INV:
         case SMMU_CMD_PRI_RESP:
         case SMMU_CMD_RESUME:
         case SMMU_CMD_STALL_TERM:
@@ -1942,6 +1957,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "ril can only be disabled if accel=on");
             return false;
         }
+        if (s->ats) {
+            error_setg(errp, "ats can only be enabled if accel=on");
+            return false;
+        }
         return false;
     }
     return true;
@@ -2067,6 +2086,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
+    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2096,6 +2116,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
                                           "in nested mode for vfio-pci dev assignment");
     object_class_property_set_description(klass, "ril",
         "Disable range invalidation support (for accel=on)");
+    object_class_property_set_description(klass, "ats",
+        "Enable/disable ATS support (for accel=on). Please ensure host "
+        "platform has ATS support before enabling this");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6106ad1b6e..1b0d0a2029 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -345,6 +345,7 @@ typedef struct AcpiIortSMMUv3Dev {
     /* Offset of the SMMUv3 IORT Node relative to the start of the IORT */
     size_t offset;
     bool accel;
+    bool ats;
 } AcpiIortSMMUv3Dev;
 
 /*
@@ -400,6 +401,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
 
     bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
     sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
+    sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
     pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
     sbdev = SYS_BUS_DEVICE(obj);
     sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
@@ -544,6 +546,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     int i, nb_nodes, rc_mapping_count;
     AcpiIortSMMUv3Dev *sdev;
     size_t node_size;
+    bool ats_needed = false;
     int num_smmus = 0;
     uint32_t id = 0;
     int rc_smmu_idmaps_len = 0;
@@ -579,6 +582,9 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         /* Calculate RMR nodes required. One per SMMUv3 with accelerated mode */
         for (i = 0; i < num_smmus; i++) {
             sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+            if (sdev->ats) {
+                ats_needed = true;
+            }
             if (sdev->accel) {
                 nb_nodes++;
             }
@@ -678,8 +684,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, 0, 2); /* Reserved */
     /* Table 15 Memory Access Flags */
     build_append_int_noprefix(table_data, 0x3 /* CCA = CPM = DACS = 1 */, 1);
-
-    build_append_int_noprefix(table_data, 0, 4); /* ATS Attribute */
+    /* ATS Attribute */
+    build_append_int_noprefix(table_data, (ats_needed ? 1 : 0), 4);
     /* MCFG pci_segment */
     build_append_int_noprefix(table_data, 0, 4); /* PCI Segment number */
 
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 95202c2757..5fd5ec7b49 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -69,6 +69,7 @@ struct SMMUv3State {
     struct SMMUv3AccelState *s_accel;
     Error *migration_blocker;
     bool ril;
+    bool ats;
 };
 
 typedef enum {
-- 
2.43.0


