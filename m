Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0F8CD5BA6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHr3-00080n-6m; Tue, 19 May 2026 06:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHr1-0007xi-5X; Tue, 19 May 2026 06:39:15 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHqz-0006RX-At; Tue, 19 May 2026 06:39:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKnEfBPXPVN6z3e+on0NUyP3r6fM6mIpyfAqsQ2+Hel+Pw+jEAByhV47GEr3X8KKLemhxdxb25kpnvKxpqkHu5gTkUwDNZKo4EuMCcKCquJU5hh8dJO9hzlQKD8OH4pxYowck1YOZ3v+M0ZTJCjNjNR8vkCi4h7GiB0c1G4MKuPiBzwz1q7bM2PleNJTmEjAbhR0/tCP10zgDCMevdtrf5OKLEzvlcjjhfdzuTBAbpqGwfAW5h/j7CTzMDEMbNJVmTFmL9vQQ4+4z7BePju/57bIvdhqKwJDoAK7vCQ+nbLY0WmnJwyqEQilaGAKUFdsN3P9AjmFa+OQqVTa5xoGsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rU8LZ9SZsyYKNXO7x8R25TWPj49t75jyOAFAIAd+FrQ=;
 b=TXxm6M/aia5VgsTnCVAtHqbSXkLY9aU5x8NG8cs9y74K/JWLjOuGCGZEiPB2AcOIAyiYKG5Mb7IaYtb8gxFcaQYsQ12l9NRlNejqAcNAHM+7SRUob4S6vZbAUwk1MO+t09yYqhueiNHmKETa9sCPfFgOQeaeYjsTwolJ9rMY9SF3FUzxnsfoR/n8e9/J3YEmpt4Mor+5qjw2k8woteRM36ACX0xsoQ+p0i9k9uU+xwe2apfQSSGMc6xtYtn4lMKsao9VeF7JKdoTs2/BQm5QCPIrsVLZNq6PqhCy8YB413bdBizn9pMpEd3MEm8lcZMFucPcw9WM+gCgzqISD+8CVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU8LZ9SZsyYKNXO7x8R25TWPj49t75jyOAFAIAd+FrQ=;
 b=L4Ay6jkddxjwv05SXMchktXjz7WTPHjHlEZ7/hd1KXgfPdqKf3wakQLHpZnV4PhOcivwA9OaqQ8A11v2ZBRqqfLunVpzIh6Q5SRuIyUw/2Z6cSpJfoO1HYfkikctpaivZNcSeq1oknQSUg6fxaxBHMZja69n58LFXIyAv7l+Os4OCs0csmt9Kpa821OefPMphFWWF7/FywO4rH7kOvjrHonT5Q61zMbVEy4roM4cow/KbHPeu6/kxTLAiw0Q9lsOo5o40ghrwTvD4gBPm1he9uW5N4FIlsA7PtReCs+9h4WYUKyJihksoaLZATqUwWxU9XBOKlObFJ515E/wL7HXug==
Received: from PH8P221CA0059.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::10)
 by EAYPR12MB999179.namprd12.prod.outlook.com (2603:10b6:303:2bf::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 19 May
 2026 10:39:05 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:349:cafe::c) by PH8P221CA0059.outlook.office365.com
 (2603:10b6:510:349::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:39:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:39:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:46 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:43 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 08/32] hw/arm/smmuv3-accel: Wire CMDQV ops into accel
 lifecycle
Date: Tue, 19 May 2026 11:36:46 +0100
Message-ID: <20260519103727.899332-9-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|EAYPR12MB999179:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e802deb-4ca2-40cf-bee1-08deb592d96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: Q3mGneSpjGU0B4hHMY+9PVkPa6j5fkMzSUw2e9LPu3HR8TsKFKuDbq83tmb5LTZw1pL7L4rJdNKL8lW+jNP2jebFdPHTD8re7XgjJt9RGquRAxHwkULGzyo2SmZ+/W8S80ch6hMGdZua45dWg1R3d5uSI8zxQUe/ZpGg40Er7chb/ZiRUlAnAmKxvBnqqksaxEFuvE/MYOzIqs0vGoyVqY5x+O+95vNvzfEB4vFKVm9Ey+w7LJ1mFyDBp7+shDFkMsd9njudUsQj+qDMQi9E005yr8DB9gwflv977g5pv7HpcwQ8CG5YrAx/o4Qg7XqCAPjKzjodYcGbCYb1b0PPuqrmePGJNU6DyeJOTM86OexuulDn1obToU2EdRXDSHw45Dhd3jo6sOZTmsVw4ifj7KNtFk/5qSf9V75wsQ4lcBsN+M7UyPUP2G0HJraaReqo+bomskc3FtdYNQKwORLlOySqLPQy/V7ITb2stE11uobTjRfTj307/7wLfe0/r5GitxbWubCcWNW/5fEfzb1wTfL5znqgESW1zqDCHTgInTjvp05y8oDwqujKjH/r3Y2qO28YbiQWvlyLfpKp5Tr1f793rcWqfZdlu0TfsmkuP1OHpEdVN1AovsEMfJ7QnjYvJE8d/OM3HLwf1w6WzgmzDQky6wfenNQbE0bfqry2H8pGDXHWhroVFjJZPDjcdGojjM+BF+jMtZ34LVr5t874hZEpGKNNmLPHasLSPWQIcjw=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Gn4h9PnHi2AIxMot756TK+FOHwYJInjJOJAOLmdud/KM8bfcgvvAm5d7xtm/6YqLOOndoabTLclK/bKCH6xTnaR4GS3iV+Idjo1JAzXY5aIPxp8StyPRalJfTxjg7h6ftoCuGDoygBu3LbiRTIII+xgbS0Uxhh+IQDxQU2NmxAW3YYAkrDIpeMInBHHNSpegoXsBDPTB2z53PGxfwnM9NRC3S3xP0lKlRL5Lt9Nbd+0AvfHsXto4ZMuhYxTMXE7jdTXJsncB8mmh7KWW6E/6ok0raRCCtdBEecE/kgdZ7BHsmx5vzlSfHNlmhXURyuLZISm2RwjZifFMJazf839g//IjLquNmQMccR2ARz/oUSPCPJ30t71FIB/RSUPOxODA9gZfXE+FFLIFBH4UAxx1Ku36n4V0zqvvyu3bCh4aq6+1CvbBtU+sWTYwDeTGv8r4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:39:04.9379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e802deb-4ca2-40cf-bee1-08deb592d96a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999179
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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

Add support for selecting and initializing a CMDQV backend based on the
cmdqv OnOffAuto property.

If set to OFF, CMDQV is not used and the default IOMMUFD-backed allocation
path is taken.

If set to AUTO, QEMU attempts to probe a CMDQV backend during device setup.
If probing succeeds, the selected ops are stored in the accelerated SMMUv3
state and used. If probing fails, QEMU silently falls back to the default
path.

If set to ON, QEMU requires CMDQV support. Probing is performed during
setup and failure results in an error.

When a CMDQV backend is active, its callbacks are used for vIOMMU
allocation, free, and reset handling. Otherwise, the base implementation
is used.

The current implementation wires up the Tegra241 CMDQV backend through the
generic ops interface. Functional CMDQV behaviour is added in subsequent
patches.

No functional change.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/hw/arm/smmuv3.h |  2 +
 hw/arm/smmuv3-accel.c   | 96 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 91 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index fe0493c1aa..aa6a79237a 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -74,6 +74,8 @@ struct SMMUv3State {
     OnOffAuto ats;
     OasMode oas;
     SsidSizeMode ssidsize;
+    /* SMMU CMDQV extension */
+    OnOffAuto cmdqv;
 
     Notifier machine_done;
 };
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 30c498ffcf..202b1aedd9 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -19,6 +19,7 @@
 #include "smmuv3-internal.h"
 #include "smmuv3-accel.h"
 #include "system/system.h"
+#include "tegra241-cmdqv.h"
 
 /*
  * The root region aliases the global system memory, and shared_as_sysmem
@@ -570,6 +571,7 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *hiodi,
                           Error **errp)
 {
     SMMUv3AccelState *accel = s->s_accel;
+    const SMMUv3AccelCmdqvOps *cmdqv_ops = accel->cmdqv_ops;
     struct iommu_hwpt_arm_smmuv3 bypass_data = {
         .ste = { SMMU_STE_CFG_BYPASS | SMMU_STE_VALID, 0x0ULL },
     };
@@ -580,10 +582,17 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *hiodi,
     uint32_t viommu_id, hwpt_id;
     IOMMUFDViommu *viommu;
 
-    if (!iommufd_backend_alloc_viommu(hiodi->iommufd, hiodi->devid,
-                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3, s2_hwpt_id,
-                                      NULL, 0, &viommu_id, errp)) {
-        return false;
+    if (cmdqv_ops) {
+        if (!cmdqv_ops->alloc_viommu(s, hiodi, &viommu_id, errp)) {
+            return false;
+        }
+    } else {
+        if (!iommufd_backend_alloc_viommu(hiodi->iommufd, hiodi->devid,
+                                          IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
+                                          s2_hwpt_id, NULL, 0, &viommu_id,
+                                          errp)) {
+            return false;
+        }
     }
 
     viommu = g_new0(IOMMUFDViommu, 1);
@@ -629,12 +638,72 @@ free_bypass_hwpt:
 free_abort_hwpt:
     iommufd_backend_free_id(hiodi->iommufd, accel->abort_hwpt_id);
 free_viommu:
-    iommufd_backend_free_id(hiodi->iommufd, viommu->viommu_id);
+    if (cmdqv_ops && cmdqv_ops->free_viommu) {
+        cmdqv_ops->free_viommu(s);
+    } else {
+        iommufd_backend_free_id(hiodi->iommufd, viommu->viommu_id);
+    }
     g_free(viommu);
     accel->viommu = NULL;
     return false;
 }
 
+static const SMMUv3AccelCmdqvOps *
+smmuv3_accel_probe_cmdqv(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
+                         Error **errp)
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
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (ops) {
+        g_assert(ops->alloc_viommu);
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
@@ -669,6 +738,10 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         goto done;
     }
 
+    if (!smmuv3_accel_select_cmdqv(s, hiodi, errp)) {
+        return false;
+    }
+
     if (!smmuv3_accel_alloc_viommu(s, hiodi, errp)) {
         error_append_hint(errp, "Unable to alloc vIOMMU: hiodi devid 0x%x: ",
                           hiodi->devid);
@@ -946,8 +1019,17 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
 
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


