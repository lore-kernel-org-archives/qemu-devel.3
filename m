Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87436FC592C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYyj-0004GS-6Z; Thu, 26 Feb 2026 05:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYyh-0004Fc-N1; Thu, 26 Feb 2026 05:52:19 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYyf-0000j9-Ur; Thu, 26 Feb 2026 05:52:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzHXwtYSI5U5WlI3IPh4vVQXrCHaqlWxEBzYRsnbhGy5cIxF6VeD4gHkTRQXSOl7yXo9nJxTKpztdVGACfjao8Xmn1aV74h7Kxm/8XLO8YNpdZGE5VusdY961KfTEJCMZL1PSNFn5CG92NJWAGXjyQ/GYgft6rXCgVZc1+/CHbmUA90rGVLRbM0mjTSX/7njFRsJzrX7e/4XJ2kGlxN9HS8srAu8N9BomesLQ7yBFfEzMkOCYMNVXOqoNUl3/C1SNTFQ5R/mO0TYV8yBEYoKwUd6KiuZGHxsx4e5Nw82dG1Ba0LN+L4wlfTJPAPuqS/1G0kASxZ04bArNYzLg0dyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqitqKl/uFZHk+Hq3v64X4lxeVqr4qkdUK7JGEdxZs4=;
 b=YzZKRzOnUj3xtBQJOEEi1tEIgNQOVdoLk9KUtHE+eFjLA0ffoeeTVfbbCFbw056D5Vw6I31EHuBuUh+wR4bLItIhIyhobBxsqCJcRn5KNntxt3TGNqhvosqEk8Y+iPXR8lyTylIATcpuiV+uFSfHa2pRj0wI2HVbyxpz6aZIh41XPTAdfw0na+4DZQ5Map2bygCJxMY+aC4Ug3qu22dv29T7pZW6BYsoqnICvNqzRRpwdj9MwT2BjHBwErgq2niIIWL8jkj+4oVsZEW7asjeByzaC3/+cSO7SgBwg7L9Ch7ckusHn9JTiR8stqmyf7bLz6pcVAKHeyYXvyVuXFdjIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqitqKl/uFZHk+Hq3v64X4lxeVqr4qkdUK7JGEdxZs4=;
 b=bs6AyRlXFcZw75YQci82TyYH9Od3dsZNxYAexDtkYkQs9fvXa4ijdXjjhfZaM78N6FD1hJgaIz2WiSSY9aFmSNYIcTWn9dqqPMQFxPrDi33YeowbntSNu+9rbcobklLwhb67DDmlns3nBGDNFpPTfBefhxG1qobrTbgBNTIW/PmzYhvRMd8hYd6AHgIUEfJMt4fzcUJ3zKLpSHTyqzlQX+c7ry5uJv5Hq3o7s6B2fpIulrrakPmO0d8IAGYd59SVGtpRdoYP5d9Lf/B3ICa9PyBvsM32ye9DuSuIoJgm0QdExglv6JF8abISXThBXWMA0uX494i63f5BN1GfbimNSA==
Received: from PH7P220CA0135.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::35)
 by IA4PR12MB9812.namprd12.prod.outlook.com (2603:10b6:208:55b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 10:52:11 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::1e) by PH7P220CA0135.outlook.office365.com
 (2603:10b6:510:327::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Thu,
 26 Feb 2026 10:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:52:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:51:51 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:51:48 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 07/32] hw/arm/smmuv3-accel: Wire CMDQV ops into accel
 lifecycle
Date: Thu, 26 Feb 2026 10:50:31 +0000
Message-ID: <20260226105056.897-8-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|IA4PR12MB9812:EE_
X-MS-Office365-Filtering-Correlation-Id: a471b790-9950-475d-590d-08de75251838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|7416014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: orG+mhq9sXB0R1hduXWTW3RiPj7hGx2tqhAJBATz2nhl0sTW/snPqY48ziD/x8PhjENHJlps8sloCO6yv512kEi7F4HdX3H5fpC6nkEv4NthBdj+p3ravOPXnmKaB+hfm6VIgkPSqNXzG9VdOsvvzVpc4Lfd3NHVQoEG44EIOsPb69GznEOfcDNTT1nll49c0YHHWIOXKzFACO7B2yyzpoLp+tfm6pEwFgd2LqrZC+0mxolvZoE/+/csg/lFEYo+BDXzkFKa8GBWELnEck4ebIB+kTyRoqJKEYr5GP6apnHxJ8455HzWOwI8q2bNtM2jDPK8gjUM7sbVIvTkwCpr04HPnBWxSOrN4H0rgkagyUXfLzRP3Y4sK8SIuWYEMmdVSaTGJlhouBWlvsqM82iPtAxJZsyc4H3kFiplRPVgLk39Drh+c6DF+Cy/wgbQAUH7DAzLtCIkGxkvFABTmkGV5t51YNC+8GYSZH92zn8H5diK1TmqCRygcIMQvjhBlp0TIeicrWpyTKN2JI/uz3eUu8bhWZsLNcWu86LEsQEFFA82mxP0Obp4BTLi7CD+kh/Ve5Zpkz7ji0f4uxixuTRt0xi0e0qoQig6vk8pZLpeu6OFr8ZU7eBbBwLgG5LjzZ+NvaDeemgH+4o1+BSla30LBPA4wGUDMEXQ6+yi6Oc/CBU4A7yaASynnRGmcTdjNZd8GD8nPp6uQomReafBwv+VyYq0YaXtaNaMx4RCs74R0f0xWzsRwrcsorYK4DuFx5ha9jAhjuGYSqTIH/ifZiTssvHj3/qrugQOUuHIpH33nHgM4VhiETw2HlTPolSwdJF/dfcoOqRwL6RsuublP8wrhw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LHHaNBmW1PtHgwDDGqI9RANRqdw2NGGJgIJ/WRNXhIa7SpuQVfKW6TMnXmWN3iXQn//bx6g/CenS7ERhsutC9Kh2KR/Huep7upHfBUHyq7GcXZxCi0832hpbuUe1zbq4bYoKr/dRrNq4zrrO65EeGT97kA/ozhbyoI8Ia5YrBMZ16pM7DUd/kH0dYOENtsEwNsDu0KAYwsvxlX04QGNdAe+0nBHhXIo7cvLte3wlKtSkt9XhtXo80fscnYIU8Pt13NyCgDjm+5aJDKrC/V75MBxq+4EVWXwn2/0olV5qZXP/lRSJwSfOiDgSHlrXc3kZde52uQesAMaFnypQSPo1TviY/KJVDvlIj18uFc9UFygbukRgPbA/crrCcEv5T34FxM8QOxb2ATHmyzVkykr6VYsNQfUgf18UFk6OwXsEO5NM9Ytv302ntkEZ4sE7gNzf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:52:11.1368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a471b790-9950-475d-590d-08de75251838
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9812
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

Add support for selecting and initializing a CMDQV backend based on
the cmdqv OnOffAuto property.

If set to OFF, CMDQV is not used and the default IOMMUFD-backed
allocation path is taken.

If set to AUTO, QEMU attempts to probe a CMDQV backend during
device setup. If probing succeeds, the selected ops are stored
in the accelerated SMMUv3 state and used. If probing fails,
QEMU silently falls back to the default path.

If set to ON, QEMU requires CMDQV support. Probing is performed
during setup and failure results in an error.

When a CMDQV backend is active, its callbacks are used for vIOMMU
allocation, free, and reset handling. Otherwise, the base
implementation is used.

The current implementation wires up the Tegra241 CMDQV backend
through the generic ops interface. Functional CMDQV behaviour is
added in subsequent patches.

No functional change.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/hw/arm/smmuv3.h |  2 +
 hw/arm/smmuv3-accel.c   | 93 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 26b2fc42fd..648412cafc 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -73,6 +73,8 @@ struct SMMUv3State {
     bool ats;
     uint8_t oas;
     uint8_t ssidsize;
+    /* SMMU CMDQV extension */
+    OnOffAuto cmdqv;
 };
 
 typedef enum {
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index ab1b0a3669..4373bbd97b 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -18,6 +18,7 @@
 
 #include "smmuv3-internal.h"
 #include "smmuv3-accel.h"
+#include "tegra241-cmdqv.h"
 
 /*
  * The root region aliases the global system memory, and shared_as_sysmem
@@ -522,6 +523,7 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                           Error **errp)
 {
     SMMUv3AccelState *accel = s->s_accel;
+    const SMMUv3AccelCmdqvOps *cmdqv_ops = accel->cmdqv_ops;
     struct iommu_hwpt_arm_smmuv3 bypass_data = {
         .ste = { SMMU_STE_CFG_BYPASS | SMMU_STE_VALID, 0x0ULL },
     };
@@ -532,10 +534,17 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     uint32_t viommu_id, hwpt_id;
     IOMMUFDViommu *viommu;
 
-    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
-                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3, s2_hwpt_id,
-                                      NULL, 0, &viommu_id, errp)) {
-        return false;
+    if (cmdqv_ops) {
+        if (!cmdqv_ops->alloc_viommu(s, idev, &viommu_id, errp)) {
+            return false;
+        }
+    } else {
+        if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
+                                          IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
+                                          s2_hwpt_id, NULL, 0, &viommu_id,
+                                          errp)) {
+            return false;
+        }
     }
 
     viommu = g_new0(IOMMUFDViommu, 1);
@@ -581,12 +590,69 @@ free_bypass_hwpt:
 free_abort_hwpt:
     iommufd_backend_free_id(idev->iommufd, accel->abort_hwpt_id);
 free_viommu:
-    iommufd_backend_free_id(idev->iommufd, viommu->viommu_id);
+    if (cmdqv_ops && cmdqv_ops->free_viommu) {
+        cmdqv_ops->free_viommu(s);
+    } else {
+        iommufd_backend_free_id(idev->iommufd, viommu->viommu_id);
+    }
     g_free(viommu);
     accel->viommu = NULL;
     return false;
 }
 
+static const SMMUv3AccelCmdqvOps *
+smmuv3_accel_probe_cmdqv(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
+                          Error **errp)
+{
+    const SMMUv3AccelCmdqvOps *ops = tegra241_cmdqv_get_ops();
+
+    if (!ops || !ops->probe) {
+        error_setg(errp, "No CMDQV ops found");
+        return NULL;
+    }
+
+    if (!ops->probe(s, idev, errp)) {
+        return NULL;
+    }
+    return ops;
+}
+
+static bool
+smmuv3_accel_select_cmdqv(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
+                          Error **errp)
+{
+    const SMMUv3AccelCmdqvOps *ops = NULL;
+
+    if (s->s_accel->cmdqv_ops) {
+        return true;
+    }
+
+    switch (s->cmdqv) {
+    case ON_OFF_AUTO_OFF:
+        s->s_accel->cmdqv_ops = NULL;
+        return true;
+    case ON_OFF_AUTO_AUTO:
+        ops = smmuv3_accel_probe_cmdqv(s, idev, NULL);
+        break;
+    case ON_OFF_AUTO_ON:
+        ops = smmuv3_accel_probe_cmdqv(s, idev, errp);
+        if (!ops) {
+            error_append_hint(errp, "CMDQV requested but not supported");
+            return false;
+        }
+        s->s_accel->cmdqv_ops = ops;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (ops && ops->init && !ops->init(s, errp)) {
+        return false;
+    }
+    s->s_accel->cmdqv_ops = ops;
+    return true;
+}
+
 static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
                                           HostIOMMUDevice *hiod, Error **errp)
 {
@@ -621,6 +687,10 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         goto done;
     }
 
+    if (!smmuv3_accel_select_cmdqv(s, idev, errp)) {
+        return false;
+    }
+
     if (!smmuv3_accel_alloc_viommu(s, idev, errp)) {
         error_append_hint(errp, "Unable to alloc vIOMMU: idev devid 0x%x: ",
                           idev->devid);
@@ -867,8 +937,17 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
 
 void smmuv3_accel_reset(SMMUv3State *s)
 {
-     /* Attach a HWPT based on GBPA reset value */
-     smmuv3_accel_attach_gbpa_hwpt(s, NULL);
+    SMMUv3AccelState *accel = s->s_accel;
+
+    if (!accel) {
+        return;
+    }
+    /* Attach a HWPT based on GBPA reset value */
+    smmuv3_accel_attach_gbpa_hwpt(s, NULL);
+
+    if (accel->cmdqv_ops && accel->cmdqv_ops->reset) {
+        accel->cmdqv_ops->reset(s);
+    }
 }
 
 static void smmuv3_accel_as_init(SMMUv3State *s)
-- 
2.43.0


