Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A2ACD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudO-0008Ot-UY; Tue, 09 Jun 2026 07:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWucU-0006TP-5W; Tue, 09 Jun 2026 07:27:51 -0400
Received: from mail-westusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c001::5] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWucR-0002zy-M1; Tue, 09 Jun 2026 07:27:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=la32AZnpehNIx0TWrRFjYyWY4iAktL/sMQMBJuYVKlkeKF6IcFQaCgxMeu9A1nzWwXnuha/p2hKbAuHa4p0HtusygcBPXE+RnFaOjfcXcP7Ym/xl7PxDl1aWP+9h3xkc/G6DM1BLlACcyQ43r1frXmVzoc+bHbyRa20Jw3z2TL5pKDAi6GrT08d2AqUrF9FoAFP2jGlz8RWPIpuzukfwMYJ8klI7/sVghaLiXCu+RcUPIzerDmCRu0mmE2aOahsXdg2TOQN0aLzHtsw0QU1yxoNM0yMSDh8+pcR1OBY7XDiclbsxFU2A1ei3Lsm2mXxkQAo2ghnkOqU3sVnf2AreLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTckrNPGOaT+Wq1owmIMnh+q3lWVFd7hbKmkLJq8RxM=;
 b=hldDIFpfe3stGodFVgtu+XXZFzGB0AdUZkxlD0xXELEXgy9mOAkg7xh0RIfAgaoUz9U/ooDWWEfwJLFguSPkSAh+kKiViIj40OXIWNoev1xrU2Njd3OGyFGfhlVJvDgYchKnc0e+tf+G5nKwn5tedgmlYGW5pOJ46EUjzUhRwL5uhra4A8nDUMHuUZoPkUc4nT0MmxjHncyWh94C5JUYdZYQEd3i/16Ug3DX+Ra4WE3nN3HPIWVuZNSZ0K0igU+GBi9uoVTs6h2vYyZ3PQxj2gVCL3D6onKAimQrxmJzRwW4NB21AScuzTfUR/WP94Ed4GpjbQGIa6zQ003bBJsvSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTckrNPGOaT+Wq1owmIMnh+q3lWVFd7hbKmkLJq8RxM=;
 b=FfyOLQIwybWA5sIRLP+k/abW56UO1TWUTwDaITWu73CEGXoWnGqvc4wiXp9Dl/ls9CTe4PL1VXv9wJAKgRO+2Y0cIO08RU30rwKiyX1hvqqczCQ8RmEhKEy/GuWIk3igS0DHP9LYghMA2fWZgmbJGqH3UoPnXPknq7Ym74RPnbGIozYmcxCz+eKpKB5r36S3XIZahxpEKxL0IUR2XPXyNBU0nkTHrkg3Gp/Xms1KYnmYZojfZ2oIxN+ye3bfITY4CyYxKVMZcYZOdYlWGLrvW8XVA5Dr4jI4Z9yydFL/GlSjLMsTZsyr0fsF8ZAa6eu2p1rF24UFQlDGalNPzFOqxg==
Received: from BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::6)
 by CH3PR12MB8546.namprd12.prod.outlook.com (2603:10b6:610:15f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 11:27:32 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::6d) by BY1P220CA0017.outlook.office365.com
 (2603:10b6:a03:5c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:27:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:27:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:10 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:07 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 08/31] hw/arm/smmuv3-accel: Wire CMDQV ops into accel
 lifecycle
Date: Tue, 9 Jun 2026 12:25:29 +0100
Message-ID: <20260609112552.378999-9-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609112552.378999-1-skolothumtho@nvidia.com>
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|CH3PR12MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: c63c1e07-0337-4bd5-e39f-08dec61a188c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: wv5+nQmDbY9HJK+KlyP6/jNoYQqK1U7Tk3mE1s4bJFlVokH4OV3vhcsD3MInQ/Ia4TkVKvP5yhiWW5BaTAw0CQAmxQXcEHWzuFJQlPlXkq0Hy5Cuyk8ysDTXupLkPlJE4y3tihOsycEMl7ysXlNCaMwYOTRpjMiJ7cauIeaRatXe6aR7M6lh+X6V8rAr0nAmz1Kslhagc8rjyWZnoBcnBbENEV02iKCxBkyO9xwhBSNuUEu0Egfg5u4lcOPbIlRj5C6KqQ0qT4O709DnVe0DPoQVZ0kwBjQHN4yJ0My3lmQIdugjab8G0y0O/1H76zWCOaPcjVBsYc3xH/bBFQGBzHlvh4D+JC2I/aUGY5jAap4pE1U9i5q4ff+IzdW1K059lVnE696BKnV6jRWGuB57LjdEbPLx86p9Z/knCe7bErKPVZJrRgsr8UY0LFHyRmkl+tFodWHKSseH70mx5IvWN1ybR+qmc1HYw+ly3jyNJd+jPyqSz4DLYDXhxAtn8D2TKBa6igtvucr+P8QQkKxsVA20HFbVlG1+KuDa5VgrosG/8/OntMnS6Ei3YEGnLTwIPAr0XRVuoGLWtgz1JVTiSg7TC6hnOuPW3GfopJaMCquuDp7ETpdApMnMIOjI19TRPLT0Fvwx9E/s7DQj+AuON3IpmG1rBprYStBYcx9VKtFF1avPvJptynJO4JjMYO0MSruaPLavCB5xyvCu/8edYUZXFHquOagkmqsbPOz1SpY=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XMaom5POoalULzdXvnREDZKU0vG/jjHnwG9mQo5nG1/XLkGJA+zV6yPXHudA4s68kMGpMb1PpNd6zLgDBPjohSVDMWcM5DPmiz7KsPs86zeYeBrrLqcGvy6GpuEPekRi4qVigr9TikGoS1jJhA12wUFR0do078tme7CqJ1K6HLMeuiLSIG1VlviLpdRBoucJqresNkmEX10o8jXbpIJaTUR+iMQVCNmcODfDx/RwnZqIcpOG3Evt7EtRt9wy0+wpHTcjYBwmB5B2lmGOSzLU0OFcSBQMYKzciL8BQ46IjnLgvazYktGKWRdb/ZjK7xHma35BErjH9WdzCA0GB49zJXKTstLcf5HZza28NVuQ0s0nZp/pGV8eez1r9sB06lfPhekBHic7tzgjkdTVpVaakBq8at8HH9YejDbCX+CiOxIgKgcD6u6zfWx+yDp8lX3O
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:27:31.5133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c63c1e07-0337-4bd5-e39f-08dec61a188c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546
Received-SPF: permerror client-ip=2a01:111:f403:c001::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/hw/arm/smmuv3.h |  2 +
 hw/arm/smmuv3-accel.c   | 94 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 85be3d7467..34d0f65eaa 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -75,6 +75,8 @@ struct SMMUv3State {
     OnOffAuto ats;
     OasMode oas;
     SsidSizeMode ssidsize;
+    /* SMMU CMDQV extension */
+    OnOffAuto cmdqv;
 
     Notifier machine_done;
 };
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 70b2581c17..3ceca56a67 100644
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
@@ -629,12 +638,70 @@ free_bypass_hwpt:
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
+    if (!ops) {
+        error_setg(errp, "No CMDQV ops found");
+        return NULL;
+    }
+    g_assert(ops->probe);
+    g_assert(ops->alloc_viommu);
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
@@ -669,6 +736,10 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         goto done;
     }
 
+    if (!smmuv3_accel_select_cmdqv(s, hiodi, errp)) {
+        return false;
+    }
+
     if (!smmuv3_accel_alloc_viommu(s, hiodi, errp)) {
         error_append_hint(errp, "Unable to alloc vIOMMU: hiodi devid 0x%x: ",
                           hiodi->devid);
@@ -946,8 +1017,17 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
 
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


