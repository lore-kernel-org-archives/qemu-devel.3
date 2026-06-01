Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80D9CD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU191-0005G1-AU; Mon, 01 Jun 2026 07:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18y-00059Z-5f; Mon, 01 Jun 2026 07:49:20 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18w-00052T-Kr; Mon, 01 Jun 2026 07:49:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeaOtYDAiaDli3cJX+3u+G4j5m47MtjGo9Yn+cB4X6NY+zdY01ynyY+vwHbajDypmdCAKWzPPsLhsX64vhdsCFVEIIc6G5DGtcPPrrnucmny3PrjmUooxuaqzb/zW/v2E08LWqe40qAi9X/IYbGJDQcFRB74WO1JmrRqPxDJ4AkZbce496fA3+FK/cPHV+hiEGVIRsl+13eUwTJTLeawHbrpRDrk8ITHIqxd2tJcbctmd8I2Qq6yIlrF4j77/3hB05XS9K9K2UQ9pLlN2pYHe3vRSuTguuOg4+sdTYzZ/NGpyw0RS94EQp9Us1cdeiZK1LQDwbxwJQRkNfcoQulsFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KxWJdalEDGmuzUoOOwBqAP1TSzkp1U8DUb6aknlhvM=;
 b=VZLnKR0TRNqAiQbewJWXcf4bVMZ86uAUORxfKj/cwydTva4EIrrVSx9hocOIUwpyaW4A0z12CCteZgiU2SmetZBoOIyz4RTIcS3X+gSRrhzDzgQyLnxP/yJckAWp9oMbsWbhURnDcDYrjTyk/9UvUCoq9VNadbihg14rVu7qCfuhcoDZyZskeA5aKIxag0+jqsv3+LcCqQ+NpDhkQfcolfqaXjBsXIfsDsL7AUJI8mMDhUSOUX2OexsSNy8RVCFAAEoXsPvcu3FFgMPBXpaBRxgqj2tIqT3+XIOSTfo8QYsKvWNzGZ+Ex3InxUE7yeZEVWPqKVVVi4uZ7wDzOpg22w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KxWJdalEDGmuzUoOOwBqAP1TSzkp1U8DUb6aknlhvM=;
 b=VNZBq02DNsgnHw4BsieqVPEBV4qEOE8R76ccv3RzUx5fkqvQVEtSRhZvTxw2EO6himj86vxPg/ojB6Yez2oOojGAy5cxg2TnoMguEv0TipZJtO4JJFi52ztOd0hyv6U4FZe1ST9zDqmN7IrqTGPwxAHqbF2D5Bup7ddf12UcfLoF9uqNfgwD2+JEoRdoj2BaFkOKYywXaiosiNMWWdNs9uGXOsm6hD8rCce5NcJSQDJwc+/D2gWp/QB/AOt9Oet3ehR9aYd6x3RwoY51I4NJYTR7XBuEa0LLUAmxUrcuomdaTeXvVF7dpZiOHlOPBb63ayvtehUkeK0Oy3pO6duXwg==
Received: from MN0P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::23)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 11:49:08 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:208:52b:cafe::2c) by MN0P223CA0022.outlook.office365.com
 (2603:10b6:208:52b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 11:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 11:49:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:54 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:51 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 13/31] hw/arm/tegra241-cmdqv: Implement CMDQV vIOMMU
 alloc/free
Date: Mon, 1 Jun 2026 12:42:03 +0100
Message-ID: <20260601114221.457995-14-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d7078b-623c-422e-04fc-08debfd3c93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uPpsYCif3bCHZe3wlZSgn9r/faPH5WyqFxUqQElK4bti4D8sbJCo73MCUTPx8vaLAIkLDH9NmiGocmS6PiiOpDa5eKSig29xXHxmvhF8kDEUNPyL0mrbCIFHMJK22IF8v0ElChNVE8vXdnG1o5csAda0jO/RVttoofT/+3rYjLyyMW8J61b3muBcynaXE9aGS/Bg4JTEeo1nHsw3Fcj8YVIVXIC8IGURRny4DrNtr2AIBJUwU646FYFy50RpXY3K2DQ9/1nZSjBDgTErCAOx7s7RT7ktsn6jhCnaiSLjNGt6lzE6kxqDDJfglOZHw3pBbpX9gZGMvFUF8ol7XooXCk+akQIVmGH0t8vqh3lhzc2nJbfIZK9tssWsZX7z8fL5o7hIKnkFiEcZDGM9BEuXuKAhQJRRS561+wmo5bXlD2F2kr0V7eZp0NR6tS4H7L4FZA4YjDvXad988jLpZ6A978E/X0SpEZe8w1qlGCJEff54p7yxDyONwD4EKXt+mUurWxmi+zEH1LaGY5PGEdx9ORncQ85SYIB5O1IQpt2jRAZikoNdsmXB4pEjB2RMsKLCXJhbYX9pLieA86U6Ghh9XaLVFOq0z2lgYS8y7MDAG+F9KSCr18iFWOTzvBkYntuVZuPp/ao4a3pgH8VJw6LLE7nGNgMSpA0OMSAR+Df1hOe9LmVOTP4hMA/MltqDRkTSOPXDGtDtTXZgQ8QMwNWm20Cgveij07K1KhE/uCNaTkc=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6LUW0GeGJ2h39UgRXKigALlvE5wjGULZmp2ylmMF2jIH3+tFIuvxfzfX9MncD9SUCelmLfaEaa47CGftG4O0GRZx4ngE3cThpd8k3JV/4PK2gPClS9nGE8sXpspOI4GklH6Cu1BdXOMGuRD5AGfTPEB+3QYSmgo6XpuEAOd6I9dyGgL7HV1niyiYe2qFciml0w1F29lV+keracvaIi5W4I5azsD29zxLecBcc1jsoAK+y0z6cLyDg8u9PVK0dy+74QlKfTy6FNLWadCzdPrDvblSyqhZqrvorDrkKOPb19xIXSG90MWyKlZtFO0pa8tNv1bdnMRKx56uh4LhYhsa6lzbTr5F2G+n5pPvSDWkoX240OUq8d3i++AGyKfzTUTzIt2u9sa5cbR4XYxclP8VEQ+md2xdkbPDSs+Lel5h4BopgQzfbEaL2IwVmAyVB99x
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:49:06.6377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d7078b-623c-422e-04fc-08debfd3c93a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Nicolin Chen <nicolinc@nvidia.com>

Replace the stub implementation with real vIOMMU allocation for
Tegra241 CMDQV.

Allocate a matching vEVENTQ together with the vIOMMU, since it is
specific to the Tegra241 CMDQV vIOMMU and used to receive CMDQV
events.

Free both objects on teardown.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  1 +
 hw/arm/tegra241-cmdqv.c | 48 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index a5f65a8991..9fc720e96c 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -32,6 +32,7 @@ typedef struct Tegra241CMDQV {
     SMMUv3AccelState *s_accel;
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
+    IOMMUFDVeventq *veventq;
 } Tegra241CMDQV;
 
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 2875affc8d..c1351c8519 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/arm/smmuv3.h"
+#include "hw/arm/smmuv3-common.h"
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
 
@@ -26,13 +27,58 @@ static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
 
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
 {
+    SMMUv3AccelState *accel = s->s_accel;
+    IOMMUFDViommu *viommu = accel->viommu;
+    Tegra241CMDQV *cmdqv = accel->cmdqv;
+    IOMMUFDVeventq *veventq = cmdqv->veventq;
+
+    if (!viommu) {
+        return;
+    }
+    if (veventq) {
+        close(veventq->veventq_fd);
+        iommufd_backend_free_id(viommu->iommufd, veventq->veventq_id);
+        g_free(veventq);
+        cmdqv->veventq = NULL;
+    }
+    iommufd_backend_free_id(viommu->iommufd, viommu->viommu_id);
 }
 
 static bool
 tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                             uint32_t *out_viommu_id, Error **errp)
 {
-    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
+    Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
+    uint32_t viommu_id, veventq_id, veventq_fd;
+    IOMMUFDVeventq *veventq;
+
+    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
+                                      IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
+                                      idev->hwpt_id, cmdqv->cmdqv_data,
+                                      sizeof(*cmdqv->cmdqv_data), &viommu_id,
+                                      errp)) {
+        return false;
+    }
+
+    if (!iommufd_backend_alloc_veventq(idev->iommufd, viommu_id,
+                                       IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
+                                       1 << SMMU_EVENTQS, &veventq_id,
+                                       &veventq_fd,
+                                       errp)) {
+        error_append_hint(errp, "Tegra241 CMDQV: failed to alloc veventq");
+        goto free_viommu;
+    }
+
+    veventq = g_new(IOMMUFDVeventq, 1);
+    veventq->veventq_id = veventq_id;
+    veventq->veventq_fd = veventq_fd;
+    cmdqv->veventq = veventq;
+
+    *out_viommu_id = viommu_id;
+    return true;
+
+free_viommu:
+    iommufd_backend_free_id(idev->iommufd, viommu_id);
     return false;
 }
 
-- 
2.43.0


