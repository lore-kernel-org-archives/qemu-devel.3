Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCCECAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3EA4-0004iO-CP; Mon, 29 Sep 2025 09:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E8h-0003nD-9J; Mon, 29 Sep 2025 09:42:03 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E8Q-000405-W6; Mon, 29 Sep 2025 09:42:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aiHg4uTHzFdpqwXyHdWxnI2Kptw97633WhuFqmyD5IFmphRJAGspkKWe4cwR6KtyHKZnG79CI0mzz0EEg9TOd4fKSdRLyEIczuo3rq/r+teDEoOvYAYY9LDluoBT0gRZr7mf2VxyvSWcyNe8ckyJGRiW0u+PPYAVEUTWFQCCLI8Cuc8sfFr3eeaY7/4xDTrs54XjZebe2ITunSweR4RsL5SSyTQtt2gjy4wGTHzgGA0gGPb8NyTyufA5Sy1gl8ixZnXG/BGAdxtOAthRBe6O81zAgHgsn3eZVizitZnyf2mLsflhAEWNkGKJ/U4gzzu5aEf8784gTSYNbgdBzEJh/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWXFu4ctiXC1RwXCpC2CxZSxLVU4UltahOVGboeoMAc=;
 b=Hsnxe2FMqHs84tv4cIKkc4NtSS2l1ZCURrQr0hQUPk5ZT8xb0cDXLbHMmDfq4KMA682q/L0pQM2YFyzuE2/kBaJ2hmAlpoPvPQXjSX1UY1K35KDFeXXULUtiWePwxQLjv03/rxMOCK5P4KuLK/tXsjU5yetcZmSKSdp8cV62MR/t36mttpBTON3O3bni7XJbLmjEgJ3tKo5lAWm4Od4bHKiRoJEEfKnKNVYFW6x93y9YLexhXdkmvR/m0UwjggtzzusTsfUaUYeZlTIhMjP8JOj7+QwMXm3a2KJpPeaULnheqRPs5USr2Xr86KKDjez8dU/0Qo/3dG4dXmO1H1CkUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWXFu4ctiXC1RwXCpC2CxZSxLVU4UltahOVGboeoMAc=;
 b=kJ+d8/CudT8TDRJJGVKvYbLNAd89nhiF6R0A99eBOaEUoCVL+Y4kjKXHZluk6FRfeil+BQXuqTjNv4x3McFrM8x/kbmY0Di827ZNy0AHHmnZbocRY5tk7sUdz73cHTZD3z56sfre2dnlqY6CWY+fMr2NlevR7+xoE89W4+FTlFA5Ei8Mx22kQ9bXDE24wgpCE5ZoZMoXTgYXx1C5D4MNmiKE8VO8jnNGiupUJht9j7V2v8C1kkmNmkCnBN4vpJVPge5ex8UK3uIE8NF4DFtmKZXenAvKlNOfX0GU485OMjr56qNmrtXOg79BA01Lruh+FYGeiO7qeIQlejwGY4Xi3g==
Received: from CH2PR08CA0010.namprd08.prod.outlook.com (2603:10b6:610:5a::20)
 by SA5PPF9176ED2F1.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 29 Sep
 2025 13:41:25 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::24) by CH2PR08CA0010.outlook.office365.com
 (2603:10b6:610:5a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Mon,
 29 Sep 2025 13:41:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:41:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 29 Sep
 2025 06:41:05 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:40:54 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 27/27] hw.arm/smmuv3: Add support for PASID enable
Date: Mon, 29 Sep 2025 14:36:43 +0100
Message-ID: <20250929133643.38961-28-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|SA5PPF9176ED2F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3b5ffa-60f2-49cf-10ac-08ddff5de234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kxDt1eF7v0k8T0fH2dSpqdykREP6GVM6a3ri34APLw3CtvGMXzY1EUdRPAgw?=
 =?us-ascii?Q?6dVn1J4xjYjBuHrvhSPmwfsyJqtkJMB5nQdeKm1sASRL4GdsD1a86K8c2iGL?=
 =?us-ascii?Q?CqG6l1YB8eTnJ1Xpyl4sHbfdGjDJKGEU7OFJTKqgHMGcNGSQxQKSsJzI1OMq?=
 =?us-ascii?Q?g0Z8nQ4/ssCwDKycF4Pjs35/SE+Yo4Op44/QFr4i8WwOmTtrFxO39fi6awlE?=
 =?us-ascii?Q?IQpJlTYb15UPaHuMrgS7+FFvfl8ooreMCPnr0jST+xP2R0ihBy+L2Uph2ra1?=
 =?us-ascii?Q?dGYjNVyvCMTT/h4L3y32otKucORr4H5Wz+j75zeRJIk3AG5Augw7+vFTihmO?=
 =?us-ascii?Q?pEQxdOuj0g1u2XjmxONZNjb3tSMIGvfTlHp5HZANtduDZmtwbdQC3Hbfz/8K?=
 =?us-ascii?Q?NLbw2tTXr+gQOkmM0yg9IfZXDq8OaBTGGq1+U/A85EYH01zDDrjTvtOwFoh+?=
 =?us-ascii?Q?1MC8hx9herog1g+ndYRcpHAOw7rEdVM3MfScvR0HgCrkifv9lA1f5+Xr/bEQ?=
 =?us-ascii?Q?AJBbnDjui3ji0v9wwVaJ7I4r9CEQsIaxLOAQZNrNvnQQ3+41FVNTV8xNubjy?=
 =?us-ascii?Q?QIPylj0Lo0K0vMwIAtGJ3JPentffrK3Ku0JGARvcUsIB4BjDzn+S1gJnWlWM?=
 =?us-ascii?Q?frh2ScAA+w6oNHJOhzyUjdSpsWBEF1hfYrHnQW/iQ0byBjnCiZlep0fyo3WC?=
 =?us-ascii?Q?qZ5emIGN1EWKjm8k6zZUyykpn7gkBG9QJzpLtVb3dC4K1jy0mJBDZqI6WiQM?=
 =?us-ascii?Q?X6058zJpfhINvqgKTvABCYxK28ePMjPWtvdJDrzeZW6yn71XNZg+FWlhr9VH?=
 =?us-ascii?Q?GqcflgO5VOEwYWif8VR1aGwZ3dDjF+yLzqbP2xVUg+Znm8yjr6KKoBiX0xHa?=
 =?us-ascii?Q?6Epp1elzX9zUnHddPII9n32J3D21Q/wO5d8IfrwkraHSTPhhk4AdU0OhrcgY?=
 =?us-ascii?Q?95lSKnfk24zmFdk2ezh4PlsMb+PdcyOF2Zdm44FvvmfmS47RawDovsQcmL1m?=
 =?us-ascii?Q?sqEcd2Dpktmpa/UJeLnN5duys/XZp1aw+YKUjvGqp3v1e9DQiHHfDTf/OscL?=
 =?us-ascii?Q?FqOlhhuIVU3y7DhBAd6HFLvTrmpqbGa75QE5z7Ois19wgsyuA2quKqf69sSP?=
 =?us-ascii?Q?yFk81GEgbWSVMEYKdtkpxTYbwwqgaMKN60kXfB2BVcZADNGbi2mPAO0hOnyS?=
 =?us-ascii?Q?nQpj7MFii1jd7z/IjpQHRL3v8ypBliZOTkbhbm7XtR6xfevetlZ3S5AhYntn?=
 =?us-ascii?Q?COUYeYUsM4r8E17mP6Alr0jmgNPjjKEUsY/D5N1WcTi1SIgqWd7M/5446wW8?=
 =?us-ascii?Q?3mhcbkxhFlujUP63fZm+/P6OM+T34GCOypNesBkJ9p93fO06Fi+Y+1PlImag?=
 =?us-ascii?Q?IHnuVEfASP2KAkUMBAeo/7nczz9TbMuUt2n/s/YTX66wAo39TjloA4OKMsjI?=
 =?us-ascii?Q?MjexkcnbV4Tyu+DDUWGqmlTqllGR1RTftcasOtFrAluPtIvNiicnyKHo1Jvs?=
 =?us-ascii?Q?Cp+GTSWQT1xKPlphWrSVUPcpl/G9WmPSSagNXfoRpMjaiiCLmCaYsQIswyRc?=
 =?us-ascii?Q?x5JY5JRJTij7ZbPSRD8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:41:24.6931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3b5ffa-60f2-49cf-10ac-08ddff5de234
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9176ED2F1
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, KHOP_HELO_FCRDNS=0.4, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c    | 24 +++++++++++++++++++++++-
 hw/arm/smmuv3-internal.h |  1 +
 hw/arm/smmuv3.c          |  8 +++++++-
 include/hw/arm/smmuv3.h  |  1 +
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 283d36e6cd..0de9598dcb 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -79,6 +79,13 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
         return false;
     }
 
+    /* If user enables PASID support(pasid=on), QEMU sets SSIDSIZE to 16 */
+    val = FIELD_EX32(info->idr[1], IDR1, SSIDSIZE);
+    if (val < FIELD_EX32(s->idr[1], IDR1, SSIDSIZE)) {
+        error_setg(errp, "Host SUMMUv3 SSIDSIZE not compatible");
+        return false;
+    }
+
     /* User can override QEMU SMMUv3 Range Invalidation support */
     val = FIELD_EX32(info->idr[3], IDR3, RIL);
     if (val != FIELD_EX32(s->idr[3], IDR3, RIL)) {
@@ -635,7 +642,14 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
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
@@ -664,6 +678,14 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
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
 
 /*
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 910a34e05b..38e9da245b 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -81,6 +81,7 @@ REG32(IDR1,                0x4)
     FIELD(IDR1, ECMDQ,        31, 1)
 
 #define SMMU_IDR1_SIDSIZE 16
+#define SMMU_IDR1_SSIDSIZE 16
 #define SMMU_CMDQS   19
 #define SMMU_EVENTQS 19
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 7c391ab711..f7a1635ec7 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -604,7 +604,8 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
         }
     }
 
-    if (STE_S1CDMAX(ste) != 0) {
+    /* If pasid enabled, we report SSIDSIZE = 16 */
+    if (!FIELD_EX32(s->idr[1], IDR1, SSIDSIZE) && STE_S1CDMAX(ste) != 0) {
         qemu_log_mask(LOG_UNIMP,
                       "SMMUv3 does not support multiple context descriptors yet\n");
         goto bad_ste;
@@ -1962,6 +1963,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         error_setg(errp, "oas can only be set to 44 bits if accel=off");
         return false;
     }
+    if (s->pasid) {
+        error_setg(errp, "pasid can only be enabled if accel=on");
+        return false;
+    }
     return true;
 }
 
@@ -2088,6 +2093,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
     DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
+    DEFINE_PROP_BOOL("pasid", SMMUv3State, pasid, false),
 };
 
 static void smmuv3_instance_init(Object *obj)
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index d3788b2d85..3781b79fc8 100644
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


