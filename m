Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16ABCD5BA3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHsD-00025q-LD; Tue, 19 May 2026 06:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHs5-0001Xy-61; Tue, 19 May 2026 06:40:24 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHs3-0006os-2i; Tue, 19 May 2026 06:40:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDy2p/5oriD0Z6kOIcVTnSPJfww9Jqhlbtgu5T+DD0+WGaehwkf+PF8ysIi17WtUDxBBvuWgb99T5TyEFTK9r24TgRAZEcL+Kg9HTdtwSvrz1VdjnFsEQlOhTgVA88WVC46k5sZSK1weymi+dbSnwoDHhHGE1YFsnGPIhERd20qjJ9FvVcwcOAl5Fahw38rbcbmdYJ9bS9NoHCzSwqLpURCohyIm18KEHsmPfwLgOjLvmUjKxsem1cofmNz7/1TGOPhb0BbuZPpzMfu6f4NZZWwByJeunSObSU2RV9Y3g74qjK82BmwfS3OmhYIaqAc5HGiHDV/FsvlQhWdFC9/OOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDAPFbAwQn10+HRzAiO1cVUV7k+stA7dzwN9jGpVpew=;
 b=UyGVWIcSMmqckxMn0y1GgG4uAdwTdhuB6M8TRDEAwU6HCFiCTvwoDRusLAw2Sg8Pae9JnRkfbtQy4POa8FoCJ6veU3l5PkpHq5mMCoPOBvMYTPdjPz6CravNp9J7iYb+qlkGUp1GewynxpCAg+LBake/ctgvwNQiNL47EAzINmjtJJEsJUfCUQzVo4TnPq8+9owJrQveNsHvXAirJAYhbRH0dhSWcgb1RePGD46hLUU3JcKPh1IhMjNlFSd919zobsf7ZtXvCU0rs22ZLTlMWo45hUPIBz0oqNgbkYT2lPHkMw5umk/slZkGcCYUOqv8rjWG15Nsxe+sIcePYQupuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDAPFbAwQn10+HRzAiO1cVUV7k+stA7dzwN9jGpVpew=;
 b=aNB7wmwUXVj/Y2P/INxRbEuxPWlQEYd+3HItwF107Esfo/fwLK5m3kHVy+L7mZs9Dw5m99Pf3NR1Ey/p3H9Fs11WmiJZAiqU/9uZ7lsiORwqGI14x5txaUx4pHWXtZlsOWNgl42AGJEPDF3GtQN747aLGEXdWDkIrcpu863mxUugmxlJLrdC5FP/OfpWPaj3eKZ24/VPlQT+yTwUCAC1viPepDNsMRLGOZ1xoZOVjSi+W6z9QNlqQ+tIGYIwO1DMmWcPD0eKTASbXb80/2e4GhKzNkLBv6uAwCpptKArhgm3ejXllZ3vBTENRvZXO+0VDrcu46RwpIhAwPJomzZwdQ==
Received: from PH8P221CA0065.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::13)
 by SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 10:40:10 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:349:cafe::4f) by PH8P221CA0065.outlook.office365.com
 (2603:10b6:510:349::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:40:10 +0000
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
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:40:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:54 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:50 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 24/32] hw/arm/tegra241-cmdqv: Read and propagate Tegra241
 CMDQV errors
Date: Tue, 19 May 2026 11:37:02 +0100
Message-ID: <20260519103727.899332-25-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|SA1PR12MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 39403801-4ab0-46fe-15e5-08deb593005a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|11063799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ImNjWAgwT7tBV7DKGg2/+QtxbH/sgF0RFrWPnRHVcm0uQDWvcENQjWV4EtJC7y0ZMVxDlSqn1uLaCqaBKhkiarxFL3ikQ8gbglY9+tfUKv60rG+8yPvptyuRSBgUiF2CkHY3UXsFzEOmOIJV78mEdmAONtPV2/jDEGhXCQKSrkE3PSqN0Z34Hk1BejRuSpmy/ZpRlv/dGa/6bAMmD6Hm/7wktW0PWTOkfeztdm2I1Ci4Lmew3aeWFtF4sXmL6R6Pqn/uM9uJdqzjYZMtbKuKtnmohGziisKprWXCSy2loyRTr2UyfqQqHeKVMs25IunU2u/DeDQK3NE4sd0jOQRXvY1pRe5vZSUNH87A2ir//3Kei12w9pXgaku0rrpmTUey88W9wRZ79rzIpDHsKNDQZE8MP23nQPjatE81RozCxpckuk68Tv7x5gZVKny8/DWlJVNff8OOpqofSa4RkM8FZ/ySMRz70jTneWBeji2JshJyalZqevQ6oIELcJgFBZQYn8Pfb9Lb/0LJnRfmOq7UGOojdOJ/n03cWiI16pIteeB14N8x+gvHz3qTtYPEHznI4louro3zQUEG3NRAkI+myQB3Vp07N400RJbhnZeC/q1PvQNvqJcPhq1hM8WHz0/dGVLXTsXSvlj7Gwj5lqVC+1To3idn6x2jxBDL20IFjiyi1uTvzVv5mu2S9JAavjfzjUHvxqXexqzAedhZUACCvhoAUbMNzg06BX03tDLabJ4=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(11063799006)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kQUmXAjuJeDZ8H22GKgD/X94K9Wyqh9LNaT0XlWyWLkRUQQKvBfnRw6W7nsL6V+JTt014kfMcDL2M1HH4jD+J8UY32Ffu7cFokcKlqG5cOzMuEYJGTmEVZi1PBG9hfBoZGmAw1l7Qik1ceRRd1Su2aVDraudqAUGE4WQRJPTkK1qiFskOc2X10KJASi63n9WntXBEZRKnsIIKMa2KLqtYZfLFE4quPJ+nXpg4oz8zT0PMlQ/Pdo0P5ezid14LEwES4yesFiJYX/4BX8nb5LEkiGRYHWzfRMTOXAYuSLRUT2VwKUgUgcFX2Jinvz4QXt8CPkt2aWx7sJIfZh6kC3nDUgdIynTo5DcVFCvSdkD09Tev/fbqtIXf4bfFGpkg6piPYhCL2Zk+slksRZmPWDUZHZy+78AYDooXVCll23nvZuo7yXLzuQmvZbTsOEXYwnk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:40:10.2503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39403801-4ab0-46fe-15e5-08deb593005a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641
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

Install an event handler on the CMDQV vEVENTQ fd to read and propagate
host received CMDQV errors to the guest.

The handler runs in QEMU's main loop, using a non-blocking fd registered
via qemu_set_fd_handler().

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 60 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events     |  1 +
 2 files changed, 61 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 853c548e58..0bba2c1801 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -14,6 +14,7 @@
 
 #include "hw/arm/smmuv3.h"
 #include "hw/arm/smmuv3-common.h"
+#include "hw/core/irq.h"
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
 #include "trace.h"
@@ -736,6 +737,48 @@ out:
     trace_tegra241_cmdqv_write_mmio(offset, value, size);
 }
 
+static void tegra241_cmdqv_event_read(void *opaque)
+{
+    Tegra241CMDQV *cmdqv = opaque;
+    IOMMUFDVeventq *veventq = cmdqv->veventq;
+    struct {
+        struct iommufd_vevent_header hdr;
+        struct iommu_vevent_tegra241_cmdqv vevent;
+    } buf;
+    Error *local_err = NULL;
+
+    if (!smmuv3_accel_event_read_validate(veventq,
+                                          IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
+                                          &buf, sizeof(buf), &local_err)) {
+        warn_report_err_once(local_err);
+        return;
+    }
+
+    if (buf.vevent.lvcmdq_err_map[0] || buf.vevent.lvcmdq_err_map[1]) {
+        cmdqv->vintf_cmdq_err_map[0] =
+            extract64(buf.vevent.lvcmdq_err_map[0], 0, 32);
+        cmdqv->vintf_cmdq_err_map[1] =
+            extract64(buf.vevent.lvcmdq_err_map[0], 32, 32);
+        cmdqv->vintf_cmdq_err_map[2] =
+            extract64(buf.vevent.lvcmdq_err_map[1], 0, 32);
+        cmdqv->vintf_cmdq_err_map[3] =
+            extract64(buf.vevent.lvcmdq_err_map[1], 32, 32);
+        /*
+         * CMDQV_CMDQ_ERR_MAP and VINTF0_LVCMDQ_ERR_MAP are distinct
+         * registers (different MMIO offsets). With only VINTF0 exposed
+         * they carry the same data, so mirror.
+         */
+        for (int i = 0; i < 4; i++) {
+            cmdqv->cmdq_err_map[i] = cmdqv->vintf_cmdq_err_map[i];
+        }
+        cmdqv->vi_err_map[0] |= 0x1;
+        qemu_irq_pulse(cmdqv->irq);
+        trace_tegra241_cmdqv_err_map(
+            cmdqv->vintf_cmdq_err_map[3], cmdqv->vintf_cmdq_err_map[2],
+            cmdqv->vintf_cmdq_err_map[1], cmdqv->vintf_cmdq_err_map[0]);
+    }
+}
+
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
 {
     SMMUv3AccelState *accel = s->s_accel;
@@ -747,6 +790,7 @@ static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
         return;
     }
     if (veventq) {
+        qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
         close(veventq->veventq_fd);
         iommufd_backend_free_id(viommu->iommufd, veventq->veventq_id);
         g_free(veventq);
@@ -762,6 +806,7 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
     uint32_t viommu_id, veventq_id, veventq_fd;
     IOMMUFDVeventq *veventq;
+    int flags;
 
     if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
                                       IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
@@ -780,14 +825,29 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
         goto free_viommu;
     }
 
+    flags = fcntl(veventq_fd, F_GETFL);
+    if (flags < 0) {
+        error_setg(errp, "Failed to get flags for vEVENTQ fd");
+        goto free_veventq;
+    }
+    if (fcntl(veventq_fd, F_SETFL, O_NONBLOCK | flags) < 0) {
+        error_setg(errp, "Failed to set O_NONBLOCK on vEVENTQ fd");
+        goto free_veventq;
+    }
+
     veventq = g_new(IOMMUFDVeventq, 1);
     veventq->veventq_id = veventq_id;
     veventq->veventq_fd = veventq_fd;
     cmdqv->veventq = veventq;
 
+    /* Set up event handler for veventq fd */
+    qemu_set_fd_handler(veventq_fd, tegra241_cmdqv_event_read, NULL, cmdqv);
     *out_viommu_id = viommu_id;
     return true;
 
+free_veventq:
+    close(veventq_fd);
+    iommufd_backend_free_id(idev->iommufd, veventq_id);
 free_viommu:
     iommufd_backend_free_id(idev->iommufd, viommu_id);
     return false;
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index c4262bb2be..5afbceee83 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -75,6 +75,7 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
 # tegra241-cmdqv
 tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
+tegra241_cmdqv_err_map(uint32_t map3, uint32_t map2, uint32_t map1, uint32_t map0) "hw irq received. error (hex) maps: %04X:%04X:%04X:%04X"
 tegra241_cmdqv_read_vcmdq_page0(int index, uint64_t offset0, uint64_t val) "vcmdq[%d] page0 offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_read_vcmdq_page1(int index, uint64_t offset0, uint64_t val) "vcmdq[%d] page1 offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_write_vcmdq_page0(int index, uint64_t offset0, uint64_t val) "vcmdq[%d] page0 offset0: 0x%"PRIx64" val: 0x%"PRIx64
-- 
2.43.0


