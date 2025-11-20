Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4702CF8855
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4fu-0003qO-8o; Thu, 20 Nov 2025 08:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4fm-0003Hn-9p; Thu, 20 Nov 2025 08:26:08 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4fk-0002iF-LU; Thu, 20 Nov 2025 08:26:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2LZga3Xtu8YvCbxLq9jz/hoeqtFbgRyu9k7WxpDY1liva7VpTHyTKme5b3vKwTaqU1E9At3ec1h4VA21L+ZHa9PFhk5cnc4M85C572ZFGgdHn5rdzuoYJSVwQJ1JEMRDibiHXrbbYDZfv1WePthFZ9C7a6UuPzMS6YyfVjzrl1pwiJ+lXWvjMDgI6dGbsyhFQy3rPP1SwkNWhmWVjMv46Z28gpgPq1VFDftZt3XRKyst0M0ViAM8DvOHOf6waWOAd5TMD6Avknkb4WSOUAnJAV6gl5X+oDvW6YVrvj+mqql73cOVqpp4PI24vnHYXLOsykwrbF0J1okGf4TmRPuBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwVhdtr9uDK+sH1bxEj9k3lTOediIeBooIujcKdjP2Q=;
 b=qWX6G56xfz/BoNsaE3wsj2so8+AVE3g5a29Pvw65644pYxmwVQHFOMYdfS3Mo77aCmVspEgmq/E/v83a9NsCKa1dgZQGC+LBBD6uIJcYQcoVgy9E/QJCSYbatm+/mGlFlLKVIh+farou2YxUZ4ab9UOUNYzBxpk5dmooevmGBs9/30WFKdHbRz42TCOVb+O2PXeIcppZsfFn+WOAj7ou8MQJfk8EMjsFC5A/1VIFX8bSdKT1KzItGMc1j0R6vaNsr/KRpUTmKHI36cVign1Wrdu+VOp4Gt54CIlbwkCX214jt6qP+ZrA6t8ksR6mI4NMizuA/80TSGXEOo3NMedcDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwVhdtr9uDK+sH1bxEj9k3lTOediIeBooIujcKdjP2Q=;
 b=Idi4ucIu86aOup22PQmG22AES3e9qVe6U6obE7HLCw9khjiJXm3VzkjLwg0fIMHLsjnTbZXveGX+6HpI4qY6BrUsSjy2UMvbQiIH5QI1ukrc5c2d80zgtOUZH0C204IY9AAFkw3ArC0ZDcybK/+tFKIginkTKWOu94bHjnrz1DzwHMd5nUEK17g2Et3bgY4ROvoosAVd8d6vsDMwmLVQncWja1IXPVd1sZu5gohWBvru0waKTr4hXZimY8iZKjdLY+YAMsnLcB6Go1pj3PzTa3EjV83yDhmqYqKRNTm2l9yMokrPN7FbObGBV/9n1bHvxnBewsZJEGGhAAs2Xx/xkQ==
Received: from MW4PR04CA0068.namprd04.prod.outlook.com (2603:10b6:303:6b::13)
 by LV5PR12MB9803.namprd12.prod.outlook.com (2603:10b6:408:306::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:25:58 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::eb) by MW4PR04CA0068.outlook.office365.com
 (2603:10b6:303:6b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:25:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:25:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:25:40 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:25:37 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 33/33] hw/arm/smmuv3-accel: Add support for PASID enable
Date: Thu, 20 Nov 2025 13:22:13 +0000
Message-ID: <20251120132213.56581-34-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|LV5PR12MB9803:EE_
X-MS-Office365-Filtering-Correlation-Id: 7141188c-a581-4c80-1798-08de2838571a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f+f4xAD/TZBsyFleYGMtz9LGQ6WIlbZ1JH7VuvQg3edBTBS1P2FuUij2vMxp?=
 =?us-ascii?Q?ot3EWWdQSvuXHhHpT3QrkG/q7cYsfbJ1KC03pkBU0O/ca8BFb3L406SxA1mh?=
 =?us-ascii?Q?V+qJQU+/3Ywi58ayv9V74GhBh7trTFToPNIyu2/C3515rwesfWI6HX+5YpDu?=
 =?us-ascii?Q?2ypq5sfywgw2m2AxikACG7jeneVf/2it5Y8XTBR77v6ayTy/QHFu+xySJ4xA?=
 =?us-ascii?Q?prz9mgRfKzCFs12HsyqyVvaW1HAnEtiLiJXHc4GCks/SwZiBRMLDf3uNfICH?=
 =?us-ascii?Q?Sai6ha2PNx+ibdk1Ii1tp0fCW+d91jUOyJ/m6dkJMKmetFpfJ/Cj07sXCkDH?=
 =?us-ascii?Q?zsliEqMGijFZHcoin4n6xvcl3LhDxZZU5mCz9zbZJNq80GvsutK+yaTiKZWR?=
 =?us-ascii?Q?JCJ0S8WC4vpbpbBLm68et4HUkmlsVqDkv7sknGVHAP0hvzvl4viccfj8Qz+a?=
 =?us-ascii?Q?ZD5sJgWCSll8WHOrlkSE84FYANcARpH+rYhs3EGJX9rH2Qn4D0HS1dDvVw94?=
 =?us-ascii?Q?2sRWVvntPEw8H4WMjX6cUghOptcEHzpsrdfk4RAsU7a2/SP7F9rfCCHDNpjN?=
 =?us-ascii?Q?WgfqIieRfJceIA/2oVJJN5VEFyz6fVfz1hGsxLvaAh3rTKMMj/Hh4LDdAK2D?=
 =?us-ascii?Q?0g2YsRQ7soOAl2hJIacaWymWKbNWZCax1us+dWSNNXhG3XAey7QU78mVd2mq?=
 =?us-ascii?Q?HQqvrSd/uSnbP83UfZ0amOM3caBeBYtpy5FhZidODR32fmeQrqPYUwpgDJCi?=
 =?us-ascii?Q?rxehJ9kW8zylTylWW8mCwm0T9bdvM/aDUG5+7cuZzjfk8EycFbjWCj638bHs?=
 =?us-ascii?Q?DFzKG7h5EltUeAvSCEM/glzVuPlFG459XnLkr8jdDkS2z22K4bnjVvODXSsw?=
 =?us-ascii?Q?TWPRTeMY/On6SDdRunISBpl9Xu2+QZVqozSMBP/s2+0JzA4y67T/vzCt45SD?=
 =?us-ascii?Q?d83Pg0P0NuDZmW5USZLc2NrqpvdNDcjSv5Aqm0che+1960IuyWyi4aSLt72u?=
 =?us-ascii?Q?OqUjmfiDtJ9UxUpKlRzEVVnAQS3Lc3Ds/59VOdeuDzVmwYIGvMAl/4kB2HnL?=
 =?us-ascii?Q?fYplRF8OhdSZkwC0xF/ZhmVy3yWdMxC9MFzyipKggudkjE8BtCpnP/MiWZn9?=
 =?us-ascii?Q?9S7qtMC6JEvcy7X0WQW7cgrw0aeJdqGXWX5fp0+uzegFpUW0HYPAZDLF1JRB?=
 =?us-ascii?Q?e1qc+P8sS8w9//b7d5pEQNu/hAc4RduI1s6qkv/vYowRSrSz5S4LIBh0Pa9N?=
 =?us-ascii?Q?prTZH/go/Am8DVR5BEoMudcCAMx6or8zcxtoi1iTFMTIV+GHCDOvSzKbXieW?=
 =?us-ascii?Q?2t6s9ZonXn5HsXUT5sr9/xQpFwlqKQTIzQ879dk9rTjicYfLM3iUqYrIWMVe?=
 =?us-ascii?Q?xopNCczy6wHsBze3XEnodwCRZxX8jieHZVgzXmGxYdizsY+6LdEyuGN2B8DM?=
 =?us-ascii?Q?JkI0rNjg3AMgRhhxjY1YYQpTRHhcK4GXygljukZq49Q0J3hB8MYhxt5hovAQ?=
 =?us-ascii?Q?ZK+d7l8PrCl/iiWRi3F63Hyag5WZxmr5+LfSjK2WPfA6WKL5D3lerlnCHLZ2?=
 =?us-ascii?Q?DHONmM3aEIdxYccCju4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:25:57.6713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7141188c-a581-4c80-1798-08de2838571a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9803
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c    | 23 ++++++++++++++++++++++-
 hw/arm/smmuv3-internal.h |  1 +
 hw/arm/smmuv3.c          | 13 +++++++++++--
 include/hw/arm/smmuv3.h  |  1 +
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 254d29ee2d..dc0f61e841 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -67,6 +67,12 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
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
     if (FIELD_EX32(info->idr[3], IDR3, RIL) >
@@ -643,7 +649,14 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
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
@@ -671,6 +684,14 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
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
 
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 0f44a4e1d3..e45aad27f7 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -81,6 +81,7 @@ REG32(IDR1,                0x4)
     FIELD(IDR1, ECMDQ,        31, 1)
 
 #define SMMU_IDR1_SIDSIZE 16
+#define SMMU_IDR1_SSIDSIZE 16
 #define SMMU_CMDQS   19
 #define SMMU_EVENTQS 19
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index a7bd4eeb77..763f069a35 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -611,9 +611,11 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
         }
     }
 
-    if (STE_S1CDMAX(ste) != 0) {
+    /* If pasid not enabled, can't support multiple CDs */
+    if (!s->pasid && STE_S1CDMAX(ste) != 0) {
         qemu_log_mask(LOG_UNIMP,
-                      "SMMUv3 does not support multiple context descriptors yet\n");
+              "SMMUv3: multiple S1 context descriptors require PASID support. "
+              "Enable PASID with pasid=on (supported only with accel=on)\n");
         goto bad_ste;
     }
 
@@ -1950,6 +1952,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "OAS can only be set to 44 bits if accel=off");
             return false;
         }
+        if (s->pasid) {
+            error_setg(errp, "pasid can only be enabled if accel=on");
+            return false;
+        }
         return true;
     }
 
@@ -2084,6 +2090,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
     DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
+    DEFINE_PROP_BOOL("pasid", SMMUv3State, pasid, false),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2117,6 +2124,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     object_class_property_set_description(klass, "oas",
         "Specify Output Address Size (for accel =on). Supported values "
         "are 44 or 48 bits. Defaults to 44 bits");
+    object_class_property_set_description(klass, "pasid",
+        "Enable/disable PASID support (for accel=on)");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index d488a39cd0..2d4970fe19 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -72,6 +72,7 @@ struct SMMUv3State {
     bool ril;
     bool ats;
     uint8_t oas;
+    bool pasid;
 };
 
 typedef enum {
-- 
2.43.0


