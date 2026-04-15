Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A94F41990
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxw8-0000gp-3d; Wed, 15 Apr 2026 06:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxw0-0000bj-GK; Wed, 15 Apr 2026 06:57:28 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxvy-0003z9-QC; Wed, 15 Apr 2026 06:57:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9ntsKYlhUYBkMMPYwIrq2C2s2xrrZcrWe9VLcaX7xysYFPbPrJ0a9XQLrtEKvs91AGrgJ1bbnNuwBRr+OYHepSkl1vXa3TgUVApB7FOm/z+Zx/3MYizMh/x/YmAPjc0+gMiAuJ9ObzwI4890kL6PsYk3vC1ATpUb2K4VCktz1xPJPNR9UQsP9k9o6qBfCEU/LnJvp2BWqb4WuNNWHTsQ/Uxjynjt7CP69rb14bufTahSF9A1dT2uX7kN6qixFqUSQtxWTWfIZLGALX5ku4M/yl2OyChEPdX9nF9ZyiFckGKud3/FkMTNrD/H2HRR9T+CUqACO0NW9B1ZLW1q/dRDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHOkDLGTXydx3WN6ObFKfFV7jlpxBB2SRm53Mp89xvQ=;
 b=JIGLLy2eSSWidHO+zh0yaPoby2h0vOKN9Q5BDi1FWC2SaODXwvL82bkH9FYHeYCOskbWIvWs7yMr1bY1V49rVbQIK26LhoaJtsiSqYlIh2cYCqxu1NIznDl5AlfSRKV0fKws9f7/11hA15EexFAJNo7Rz0a0kh5o0Eu/METH43UcoRZMVLfSSqPNTRL1EMUnQrN4BoNH7iWR7UphJJ2HgvDkaDVTEP57WhzCt8zu69N7oeR0JgKJ3nYq2IMptbRrjG7YaaFy7oqk+ZHClFFmzTyx0ivEzEnoXytYJb0VQ79INnLYz3jBcpkFkiFP+nn6hYMDeWdNz5f0QK9RK1RbpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHOkDLGTXydx3WN6ObFKfFV7jlpxBB2SRm53Mp89xvQ=;
 b=UtxBRwQjL55i0Hxrrj5CFQO+lSnYls7VXIr0JbiNnF2w13RtzJMWdXUDz7/zIcMUnECpEoAsPQfAUFLUoBVdJ1MiLOzreLdFjKVyjqJFs3IH/6w2TpzC8Z0L1FQGrJJMww+uvkW9WFjl65bLTWYZknL9Xz6AYYUHi6xeVGnf+dHZYhFVBG3w913l1n4tvC//NSgflQMFzv/IvXXEfMgOojlU/jv1Woy6SWWy7y4GaF5CjPsDt7R5BM6Mba5VCvI6LdoUwWsKOppMsedtcnYtaBFB5LBOMUwAfBpvZ99yprEsD1iSk/5vjaRSKhPOA39zL56aq9xpKceucTEi0eilAA==
Received: from BL1P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::8)
 by CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 10:57:19 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::2a) by BL1P222CA0003.outlook.office365.com
 (2603:10b6:208:2c7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 10:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:57:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:02 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:56:59 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 08/31] hw/arm/smmuv3-accel: Wire CMDQV ops into accel
 lifecycle
Date: Wed, 15 Apr 2026 11:55:29 +0100
Message-ID: <20260415105552.622421-9-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415105552.622421-1-skolothumtho@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|CH3PR12MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c9976a-2679-414b-18e2-08de9addc394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: fFxiT9YSqy3g4M90AUkPnqsBiPmHh3HusrKwpTgjFUN/kGM+fox1TJcuxL7f8OyRZuwXBTnGLMF305b925tFXy/92D4s9KjHBqKpTryts2eGJzM9VMNp16L/7YS7SQqocrY79X/9MgsIs5Vr3cyrHuYxC0PUp47BiKcPdT/cORwuVNMuQ/dC3+E1wpuQzeqLesC0M7WlgiwG8vixBukrH8NV0ldNHiC704eJY68GaBs4v2yDwXZ1nVbBUm4+WGKTuaeE47zrtnnPC9eSmI0L8bX5Q+7EIUSWdgO3MVuKCf87fBoM0d/KXcFaS9AK0PRM2s/vSRWx1MKsCq5pdc/Tz2iLeCIORhJC/9t4r1sG4/p2CyDYDpuWoNWbicLTplAiEFToJGkP7OZxutZ1lVx7AlfLoyL9AD8BQuhW+uO2qFUJ/dvztJft38Dynzfqf77LpSb8c6Q8GHVgjDChKYRENM0ZJpgV6jUWoVIMfe39dl3isIx+B3nRPipDUN+ZLiSYjW5gsp4Syze9pnweBAUEs8jsUQvVaMPkeSturta7FGEmm+pfEJAi0fseW25xdsUGqkNgte5vZscxuvsigDnBtMsIJkzjUrUo008+uTys/oNpF9u9/0ltZUp2u2A0Q2TsbWAEOGlg5Cxz4w/nFbuGo/VfrkeqbxSNtZt9GsqIPoijrHNAcdIPVDbZEt3rUITBBGddL6O/BRtzjEhefnn3RZJKslujIIPAI64p3LG8JQiLRUL3ssKDjkb3sQHDJpdaSaLYZ2XUHe/pZmky0jdmSQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rqtqIRj3FEnDJTEzsd73qY+q7pCrp3se+fTcLcoW86/LmaGszx46mxXpbNYUVnr5R7VnR2TIMU1nN0mlmzXxChcFj8ljr+12uhxI2nHTANmuaEyzE7HAjRm2k9uWdy9cDm7lim3g7EXy6s+J38XQ3G34scNbLXupCyRnhHYko0IeWcAx2ELM51u7Y6JK8VmMJD/35JN7weMJqsbcOZRBDVZEEJxqypjBS+p10JWlGn+8t5zUC5csnY1YLneYMjTlE0GpwSpWzNuKWWEzYw6doAGQxbzE6f5OGWGXsYvtQllINp3FK++PIy84o0EMgFzVeSN9BRup/x9jUMX7F54HInbcalnZl0WZ/rBzks6VJnnkpvw7mdM8pgC2CjOcKtevenAplfpPcVuvZY6ew+QHGoPGknOoIM500vGsmmZOewk3n8l2AFQVXMsEPSmgXphX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:57:19.1026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c9976a-2679-414b-18e2-08de9addc394
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9730
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/hw/arm/smmuv3.h |  2 +
 hw/arm/smmuv3-accel.c   | 93 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 88 insertions(+), 7 deletions(-)

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
index f65e654adf..9068e65e2b 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -18,6 +18,7 @@
 
 #include "smmuv3-internal.h"
 #include "smmuv3-accel.h"
+#include "tegra241-cmdqv.h"
 
 /*
  * The root region aliases the global system memory, and shared_as_sysmem
@@ -566,6 +567,7 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                           Error **errp)
 {
     SMMUv3AccelState *accel = s->s_accel;
+    const SMMUv3AccelCmdqvOps *cmdqv_ops = accel->cmdqv_ops;
     struct iommu_hwpt_arm_smmuv3 bypass_data = {
         .ste = { SMMU_STE_CFG_BYPASS | SMMU_STE_VALID, 0x0ULL },
     };
@@ -576,10 +578,17 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
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
@@ -625,12 +634,69 @@ free_bypass_hwpt:
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
@@ -665,6 +731,10 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         goto done;
     }
 
+    if (!smmuv3_accel_select_cmdqv(s, idev, errp)) {
+        return false;
+    }
+
     if (!smmuv3_accel_alloc_viommu(s, idev, errp)) {
         error_append_hint(errp, "Unable to alloc vIOMMU: idev devid 0x%x: ",
                           idev->devid);
@@ -936,8 +1006,17 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
 
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


