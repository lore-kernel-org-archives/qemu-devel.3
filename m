Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389E2CD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU18i-0004cv-6d; Mon, 01 Jun 2026 07:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18Y-0004bH-9N; Mon, 01 Jun 2026 07:48:54 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18V-0004wk-9X; Mon, 01 Jun 2026 07:48:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DoBPjb6F6eoQe4pOFh5SOasLqV9dbnL8RRbybi5AX5LCJQTx/qwWhQy+SNi7nFplpE+EwO1XpTczZei/zcTgbiZkVr2PEUrXCtlqI8CAa5giBdo81B9aZ0KXh8eBvvMisnmIASMxj0sUqwBCkKngzxJpotkMsJuQo17Ve5ioVSu5IRPQdZEduyy2mDHemgBIL9+Z2MCidvZuzte7pujvvZ2Y1TVxkZCBlWacC0jZMRh2YdTAFTY4qJAFFX4MX3asdNAAzakUvbYOCn9p8pz3fxVbPvgoIUA6RuPzXFK6cseracHuPnsoO48hGQt4OBG4PzCjuCieHtAGGSBaGy+w7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiTn56NYrNDvffNMZL1b0jkWKfudy2pOBsnR+SA4cYY=;
 b=RcDcY02+jZCBss1DatNinwfXWefikRt9y78Lzzt5jXilEkPRKcZ1GTNfTQe+5AIPC+sAeDaDGYrYIVBBGVqy1lJ9G74Rr7DgZfTR082S1FcFrbl0QqbSKc/VfgrHw9dx+VXcd+Vi4DKJOpnIsXYejcDA0tQLb2XlQzvmsHTuu51Mlc9pCE6pzmbVMb9QEAui/qAYhD8l3wAut0o2v1SVwf2ujAgXQXr2JjqTrOS5LQGemRv2QjDrYOnJuObb/Q/ktq9eAWOx0wrwvmrQP0R/If+jMll5CjRdL+GX5BhoUDzWYVn0in9zNu/CInmMGUCHoFLDHwgnhH2RTF4UiNdwuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiTn56NYrNDvffNMZL1b0jkWKfudy2pOBsnR+SA4cYY=;
 b=EGC1UsnluLMjdyAP2KQekqDN2IRsAMPIa6nVGhHoZ3u8pVd2/l2fMlzEOiVI9/R5ywVcyhkg5Bn26O11pdJrI1wgs0DP3jcajN7dJMTZuRgxkBMpitJCur/EzffXBbo/28MaMe5DqKG4Zf/Un2OdHAIHFYu+ZhZIM/tv+b0x/4Jx+G0wAdmoV3LWwuuw7S6f72krO5RS6zHsYV4ZOiDqARnQr1gEGLYzWvvvGmM8W3sGG5vU5IQeFKNOWKX988TOB+NjLaagw6pZ0AcHg6J5G9VCXpNYPI69o14hmMGsAmu6Qez7+G2GLh04gLpODM3tS0Fi4elo5NvKLCslcmgieg==
Received: from BLAPR05CA0023.namprd05.prod.outlook.com (2603:10b6:208:36e::25)
 by MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 11:48:43 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::89) by BLAPR05CA0023.outlook.office365.com
 (2603:10b6:208:36e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Mon, 1
 Jun 2026 11:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 11:48:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:33 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:29 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 08/31] hw/arm/smmuv3-accel: Wire CMDQV ops into accel
 lifecycle
Date: Mon, 1 Jun 2026 12:41:58 +0100
Message-ID: <20260601114221.457995-9-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601114221.457995-1-skolothumtho@nvidia.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: c9062080-7ef3-4729-5de1-08debfd3bb74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: tnb0l7ClJgf6GDmkL6Y6aMh+hxiEth5VzcCI1JujSlvAZgw1vdUKyiIoCDQWkK7PJVRd87EKjVrp+O7++LZ+UJ/kFdo5v0JPxVQ6n+bpISQQvJ5cORUWAuSBX8Pyeb0D5ZcosIdKXzLBDOBJDlqut29I7Fj9FLFAoW9+vb44pbhoCvVgrbguRHgOhm9pJRB6DJamjiBTS1TABx4ZXjvdbehZ86v4PBcSvl6GwckU2H2SjIxXZRiVBgz9WrxvvMp8+susZA2+uqHDa3jbe3oGISCkRLQWVd3IzTMCqrpMJuchzBXtsavJxvOjjW6+Pd/jnaX9BvTtzlR3ALLrDWUMpXFgct/y6L+PMIodK07D0OuPwYhJf7KCZ+Q6J2Q8G5eGh1PMypDEB/hCawh652YFz+IXNEkM8ov5Shj93mWqqVmgFYnwWfqoICGvTL0nGNJYTsJwWez/TSYAYM42MueD1uaUB4hO0m+BD7nG/8Brx1Mf7VHvwt24iyOqQVIJxYLUhLfQ5FNF7VODFm4THpgylSbHPfIkx965/lV9mRvqPrC5EUcbipireJ6fgOUNnEydIfGJD9LFNski1lKECrgtBKGYTWdRzCVgF9KLeW3lJD2TlA/MeJ+/xZOW+gx7lhXgMGUtPKPBTIofDD90O8UW0mLULh3X1JfH8Y2SLNl6RPIawtJkGWCLI2DlSW7pFGaq+GxgtUqUdfD6FAiyf6qgaKOMpUFSAH3LAwuBUAFUH0g=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 46UiE5nTIRtw8ld1n8XFG6Q+NZXh92Lg+LxUYOe1jqRWcVg2+fM3vfFd4J6sv1LtlMjgD9AIyGwISvoll6dnFRofIC+RZUkIkI80rvRI/Gk51RmKaz+PiA2qvveSq5EhDddbuqUXqpvjCLGc/xengjOCStkg2L5hzbBU5/AtWY9QBv56PAzvndasC/oEBe9aRaUQb+GAR+dxEn15D/YTE5YnZ8YpEA+i2j2lKA6b1XwH3n7gi2u8ksFTdOahQGplwlYPAmpCzGXZpJ1tt4pKrWcNubQEiVjAXQh+Cs7OPBrqKEEsotMwxWgYo0sKDyjdAghtdfw+Eb6cCDe8fz56UARIrGBkUzJUt3FiPD1g4mCec7MU5pMSSGhUHpXTQd2AvJ2u9O+HafyxtpicjE2QUzA/+MS4HeK/KYddAdmJhvqjJwQJg4AEF+LGEFxlD8ul
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:48:43.5255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9062080-7ef3-4729-5de1-08debfd3bb74
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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


