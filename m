Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05BCCD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU1AW-0000ei-Qw; Mon, 01 Jun 2026 07:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19c-00072A-Ql; Mon, 01 Jun 2026 07:50:04 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19a-0005Ag-KU; Mon, 01 Jun 2026 07:50:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plxtfFue7uDCqoID7Lt1LXHorC/0Bj37Q3BkPW6RASaBpM9W25f2T30aHqrt/cBTZKz541FVTLlMQ29Ojy0tSgW0YrLMU6yhe0fgcre/MGxHlUIZXMAKXtVK4a5GcvulLrqRtRXydaHsFrkQ9+Q2zDSL/BwT2VuvOe6omPt+mOEoRMKHMDK4nrueyPD69focWZ3fVUURO/DACz+xeZlx4m2wCz5Mktv5umiL/OZpsQ8+GWTvltaMg2JWpMXbE4mJty4WtjW/undGy95RKbJU2nG8lsbqbtPcYqpEuVs4RFMSfUeDpBxhOVhEX2JJfe377ZXP0DwlndJwb3XNozNfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jNGRBZXu49AyBfCABrFiBZT4naWBMLSHwu8o+NQjn0=;
 b=pd329fol2GiQKczqCvCXV2hUjaRuPf+o/EdMfVHOnMxls1pUfu9SL/2fctjUE6gt320DEzmw+I4JHIgFp/iViqHuHowAZ/r/pSUpZ2PTpt/UiQOhl96VCaVnKvov0xeMMI0qlkz5t+7pLz589AKEvu8QS+SZad5Jl+mZT6/cD5N2FVJwSbVlmEsLx+LGjBJZHHvSAIAV690ndkNEoMLKtCjY70nLA/ao4fm+oLt5N0bypbUhY77AJ+BZ/GK76xHfwuDxaQL7y8HcNbe4xUx99DxGxOv0ZvpzYxq0EwJg9tAcD8ysb8zk6GQ79Y0oskKykbjBccfuYHA7ApbXw/lVJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jNGRBZXu49AyBfCABrFiBZT4naWBMLSHwu8o+NQjn0=;
 b=Oz1ZhRU4JOn7eeTe8/Kz8+/pB/+nNuC6ssrrL28zt9ux6kMptExLLPh2+wsjIcHiZvuE2u2fXCn2U7VJY25ucX1E9nOzSMJZRKTj40z2Ol8xnDH7yOBHcQio/9LclJb0lA/rEx4GKPrp1zfysKEWKZa2jBBKo+kNjOQloP8WjJSf/t5/WkvqgCgOmp2p9tE5eh1v3intSS8H+AICJg8e28XqiA/JWiHWyUGQj1TTwoTDmrPXk5FG1gnQB8S/nW9MdiKUmFWxmZ3fIbDNWusvNiTyOh+pYs/7BY3sJPmkoM4GOGkVofCi8ixvDRLe7KV5wDlaGBZihYy5wM3E5rHT1Q==
Received: from BLAPR03CA0095.namprd03.prod.outlook.com (2603:10b6:208:32a::10)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 11:49:46 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::1) by BLAPR03CA0095.outlook.office365.com
 (2603:10b6:208:32a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 11:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 11:49:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:37 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:34 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 23/31] hw/arm/tegra241-cmdqv: Read and propagate Tegra241
 CMDQV errors
Date: Mon, 1 Jun 2026 12:42:13 +0100
Message-ID: <20260601114221.457995-24-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b42a94-cf7a-4899-2f95-08debfd3e0d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 4CLbUYhtkGVAQvJkvJ1ukTd8oT84o+5UQDyWuERG4fgE/VL4oVbM+gCe6DeK67e+zICW4slPevF/3xj4yBppAi7BZ1NiuzE6F7L9xPgXbNlQ3zwPtcgfPEcQxrzVOyLfLreIJpchh2SQgiThqTwtLQhoJgTUQ5aAZ2uWbJ4HceKVVtuRQ5l/L2rDjcT8rL0Gpryl5aZ8sW4NgkLifGsVZVDxJUWwTeDLFN/Hk0sutreuipwA7J/Ewar16KIp/c6oJGsUh8ZDRXGHkV3qzQrc7XSbgJkqzx9Fw/5ovadlbk4Arver03mrgIDSS1Beqq6+PaCg8impcLyHrf8/09s8uiEspRXNFsYTELdj3k3hCzl7d9Io04atDgmj+GBwPQVSr+ZLUCG2ww0twmaiu8KASYhtTD3xYCMFqm/xbXD/FTBlUy3l+2Yul41X35c4stE/Jrze/jsYYliakNvHJBYt8deCKqCN6XNRjx23yguI6GVwZr/4nrCslM3QxZQzwhr/HeWPJAkMiT++e5y1RRNk6WVbAul6DhklggdF8CF6A1pHGzLSlNlXKeXbsWWaNzjwqYXbuZ/bbMvI2p59fKr91DvEBCoZEwOfpuQs6nKQSMiJSM3qbSlZ9XGfxtwpDT8jWQ+UBkWLgghFxAQJHUQwJbQFCuHpmZZx3+fKPoTgPd/nBpRkBIGUD+72CsVVHr8XmPJc0J6JtC3aW/0HscvReuqbmBQdjI6Her5YAEJPdNY=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m52KAFtK8FT4Z/mC9OTbUbhg0gAT1uWP/Ua+IrcDu0OU+4JJqjIYEekpdFgWTarkF1l+insX4EAkM55d+GI/KLDP/ANwgwT0Jq+O6fpY0XTzwsPXYHhRUI9FjMLNzFexUPN3fEZ7EdJepTDRzTFiHvXm4fF2qj7mMlaxEqAM7hBHPmchMADD3cQ5qGxDfiNxYcFAAofdjFYGlLCZR4dSmoLWI9cXcLIySkZFEmrF1zhWbigNXQ0FXrTeEprf7v+/KgjR3nZFBz5QR6aJqZiUPnQBgcAFjbs5r03sKGZbfPgwuLaeFkx4H/2KMHCbM0vz6tEw7zK4MD4fTGwdCLWW1Nw2c15SjerfxzPxekXJGvk1/AeStsFRKP9VvpI3vCnq2M+6v3k93R0e5iHSpAN0EA6i6Q84V5TLcMlY9vQR7RfgHMqAJ4/43xZEw6fewVvP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:49:46.2176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b42a94-cf7a-4899-2f95-08debfd3e0d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123
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

Install an event handler on the CMDQV vEVENTQ fd to read and propagate
host received CMDQV errors to the guest.

The handler runs in QEMU's main loop, using a non-blocking fd registered
via qemu_set_fd_handler().

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 63 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events     |  1 +
 2 files changed, 64 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index cdd4fa4f1a..d8b36164a1 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -14,6 +14,7 @@
 
 #include "hw/arm/smmuv3.h"
 #include "hw/arm/smmuv3-common.h"
+#include "hw/core/irq.h"
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
 #include "trace.h"
@@ -751,6 +752,51 @@ out:
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
+        /* Set the VINTF0 bit in VI_ERR_MAP_0 (only VINTF0 is exposed). */
+        cmdqv->vi_err_map[0] |= BIT(0);
+        if (!(cmdqv->vi_int_mask[0] & BIT(0))) {
+            qemu_irq_pulse(cmdqv->irq);
+        }
+        trace_tegra241_cmdqv_err_map(
+            cmdqv->vintf_cmdq_err_map[3], cmdqv->vintf_cmdq_err_map[2],
+            cmdqv->vintf_cmdq_err_map[1], cmdqv->vintf_cmdq_err_map[0]);
+    }
+}
+
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
 {
     SMMUv3AccelState *accel = s->s_accel;
@@ -762,6 +808,7 @@ static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
         return;
     }
     if (veventq) {
+        qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
         close(veventq->veventq_fd);
         iommufd_backend_free_id(viommu->iommufd, veventq->veventq_id);
         g_free(veventq);
@@ -777,6 +824,7 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
     uint32_t viommu_id, veventq_id, veventq_fd;
     IOMMUFDVeventq *veventq;
+    int flags;
 
     if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
                                       IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
@@ -795,14 +843,29 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
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
index d76f408d8a..115f1add9d 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -75,6 +75,7 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
 # tegra241-cmdqv
 tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
+tegra241_cmdqv_err_map(uint32_t map3, uint32_t map2, uint32_t map1, uint32_t map0) "hw irq received. error (hex) maps: %04X:%04X:%04X:%04X"
 tegra241_cmdqv_read_vcmdq_page0(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s page0 offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_read_vcmdq_page1(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s page1 offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_write_vcmdq_page0(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s page0 offset0: 0x%"PRIx64" val: 0x%"PRIx64
-- 
2.43.0


