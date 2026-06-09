Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C898CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudL-00089o-QR; Tue, 09 Jun 2026 07:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWuci-0006eG-TV; Tue, 09 Jun 2026 07:28:02 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWucd-00032C-HE; Tue, 09 Jun 2026 07:27:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzCioRQMbZVYdsnHNd4UBfk9yuuGJgMFac+FC9rVymq4pKOAG6TjmspTHQhH/qAlG6Eb6QMwCeSs1rW4D73yzgFBHDjjiPTwqfVCOXCyfuPrvBnEk2i809prNgMSNtgOsea13xlMQrVxwppx/Cp0m3cGtktXpDTXXFgshndUqkjI+pcVwf9fomCFNx2qQXGK5qPPzAQu0O2CJMnnGqWa9BNdsOaLakQFwiz66Hj8MRqblbLxvRG95hOUYh37CLc8gcNka4xU5QDcsIc+vVu8G4c0nWsvvAIDkPvLzXB1SIgMmLRTeKBDjm8ounoGxOUSgvz/6S1ymDowhEnhvgqqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNQdRYGPpkZKOFXFWOdwiXEnJJfBttvvAc3aVAO00qc=;
 b=ozpaL4ORm28zc+XyYe3TWCKbtorVpboN0H0ZXzhxlwFo/xSMESJ/tgjSRz/kwiS860RyUWJVZppenATb+G0rwkIkzTfrkNzAZoncCD9JhyvffiPqTPAVRkKHjERstce4QpCHnfdL4xaZZvvy4G6IT+k3185004xjscQkxLhr/msjJ7h8LobeZAxwifP/pCydts3bb2dlgWvcfWBd++AhOZps2zAMr+crJPaUrrBdLS0ofQoetrdSPyUXRqnl+eE4THLYZXRcm8waGVcYNaB+IPDMNbAudMQSgwc3YpjzGYbnmLM7OKi8t9i1XGkJtj2YOkv/Jv3Sd8LW37yssmSwsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNQdRYGPpkZKOFXFWOdwiXEnJJfBttvvAc3aVAO00qc=;
 b=r683BRY1sJW3QroRCYKqpPjXempsI9OLLaCC6oGzdsp5EV/9FSl+SLGXoMDmLdWJcziPNpV53ss9f5/7NgdmdLUZKl+ZL/1ndx/AOmTDLA/41kPkl2IjhwHnMpi07dJ5PIxo2dLadotlJLPp7zDqop2PD+D+L2HvFECBYpCEXY+SiSGrTErfEVLeRgVhpUuKt8czECshTdWgPFL1d3GFJQEBnYf+QUaHZ0tJQV1sRe3M5bmrkIjPIbumi8rrENuFjRKmtXRP895QVLBjNFJwtagfAwVH0iXmTFs6XLu+Ov5UE77a203xkTx24T3bk24HbSwNrbdckg7NgVvgPuTIhg==
Received: from SJ0PR03CA0262.namprd03.prod.outlook.com (2603:10b6:a03:3a0::27)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 11:27:49 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::4a) by SJ0PR03CA0262.outlook.office365.com
 (2603:10b6:a03:3a0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:27:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:32 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:29 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 13/31] hw/arm/tegra241-cmdqv: Implement CMDQV vIOMMU
 alloc/free
Date: Tue, 9 Jun 2026 12:25:34 +0100
Message-ID: <20260609112552.378999-14-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b384e6a-06d3-463a-07f8-08dec61a22aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: zzn/WGQohhyhVhgxPlXOzXaQhCT7hrP7prG9b+Cd+Mvku2UiGIxEV5/e5IVGBAYqZ2X2M7jXutdU8eBbaIdvg++zU/AxR0iLxSGDyhU1PpuU3IYpTfkOA0a9L+TMj4VpDGdcckLb/NS3oZrFLQdJdyuJZ5k9CAy4VySpIH/SK0H64yfHnE7+NADmKjs4LT6uGpc9x3DPkAKutbHGtQQ2+EIt47maL9mODwDFIFx7w+we/KR+JsfFfRISvHBvXmHoo6+kyEIW3IXnRyKMdHXHgwc4E5/DvPly/LwiXCEftLK+w388R2fRJYYu3lNcObjoFVqFhCkKmA5yWSkNybSa5kHilOk9WCBgH4IJh6oiGJSFLdvUKjWRkdozxs9n+8/tEc7ct3pblr3T8nHOYKYaznqZ9VPkQ68EFR+V3EZiWum0lpnCBWSrXUI2feJEZzxt+fD00hDTFMo4R0lgyQiG+GT4ZakxdtvYAs3Bme5n58FGP07wwnXhPo9a2Bl4Fm7hQiQqkUw3IRufhYHAja9sEYULCKq+fH/yrUjPNnW1MkcxEBIdSf4Q07NBWdq1jFATVmO7lCcGzeeF6TT0i5HSYVB2YoslBXa7pqEBzWWdorXVwIBXmPqmDnaGwjfet6w9u0cPNQrgwfjoRNcvMlU3spfBkdKMYIu3JDXRhBYR8EnJqwxEsi8FSo1GMuXYctDE0V4umbSW3wdhCGHN5ZX/SpX/zwOD5jWNjIfwIq2VeDI=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K1+uPMH3g2GeKBfL6BoUGDXRnHzIug4vcPodGzuoQHwW0lue0d7tP7LG9t8j325M/c5hsZFOa1hMD4yNhbrJIEerRoEP+NBTlLdAtSadK2HS7tna8EhpDtsffrQiT+0KBKGXpMsRXF4Hpdt6WTK/K1o80K40fOwEQVXHNVAyETPI+QAteL1yHtxIJuwAoFj8xbq7M/YnlcZdJJxaGZ4FZwm/1f0dCMw4C/OYuTAaymVEdqkxheEDB8Wnfh/nXtVyiCGKnCR1r9jlGQkXbaeFkfNRg2Rm1KUjdiXggWsnVLuDeYhpMMNQpaNSYs+xhruDQHz93ApzcpUp+3eGkq1+ezXm8C0g9juheIVfQ2O8GNB7Ss4YDGe/74uBZLYwHjJ+bV7Ilg2nTU1I1nKDD3yaKYT1Ns7ErWdOgWTaQIFvT3DEx5p43Trmsvq2jmcwyo5Y
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:27:48.4615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b384e6a-06d3-463a-07f8-08dec61a22aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
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


