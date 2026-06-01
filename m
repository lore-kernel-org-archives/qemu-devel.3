Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1953CD6E5D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU19r-0007If-6f; Mon, 01 Jun 2026 07:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19a-0006wy-0W; Mon, 01 Jun 2026 07:49:59 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19O-00058k-U1; Mon, 01 Jun 2026 07:49:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSBjXlO+jSejkmh8OvsYy8MZsMyn+6pMUXP3ebfFcqnOmZvcRQA05zPj6n7/pLQhFLMT8boQfP1UKJrWKqrV6s+ZlugTmCgfsTJrvtcA26Q/3kh0vj5Si6tpFJonU1BCFtm6dOcqd9qrxUnAJ7VwyUPihyDtZ+HRmt5tMcbzPQT2e9wpohh+//V0UIBXZSO16+QUDvbpFw3xkL2R3WAID8mDYDzZ5kIjfIJQtNmyJnuy+CYkn1ZJtPg72hp50lI1otWSsKeW/oW3PD5NRsJxNlX4nujel1aBCJAD6S7Zt/MJybmdjJxyb7J5JkcUzhw+cEn+zjdEIKoDzMGmVkbHyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfR/8GDjJxYnahrw27b92EbaGLfhS6QjTynPuGDC4bQ=;
 b=R95e2TWo8edRm2K6yfXnxVzS/DyvSxOgJwvXIYumWPOKLCE9ruN7nDkiUDk9Mp78Gj7q9cBdxyjz+nVQGWobTIXZrr055mT13vBF7+3hoEp/KxIV06qMWjgr3Jpa9m/6qAS705VRgbc8+jPHlGQ0a/Jnf6i+275YYGv450riq8P+IISEwxCOfXljX4v8OulWvnwZeGc/TM8ADFqr+ZwvFwl7ddAhWXIb0/XUzT1YKZPuDmLV7aj2oNOAFTX55Zt6BIw6DoyokODjs0EEALn9sozog5P2nP+M3e6Cy9laW0cZN7wY0d9tOv3kJ3Teuidc9fhRXT3PKKgd6wKslNLPWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfR/8GDjJxYnahrw27b92EbaGLfhS6QjTynPuGDC4bQ=;
 b=EbAh1LjVh90l71js3oSdC4fas1H2IZkvKzYq3EXdq43ck8cTs9fVcWhfhobnaqrqTXvvRGnhcW8KyQSl63OwIcxaywTfBU7dpJPDgl5rH5uBo8UOLld8ifBV8k6l9sjHvFVv117g5/a9a1DkBrahcgDJrzDLsKC8/zugIjnpO84vWTcnLC55dBs2jWUBwSMvrwtsMs9Wr8H/Q9hCtQ0QWxEROluVtikWmIcq+M1lyqDwg9XUM73SLk/4Z83Ae470PgRyZFIy9yklfZIMsynQk3uISvCgZTKsu/gEjAsHigKBPAbXMaKkNCCFwRYA1QbaqT/afBKEqsc7tkbgfq+v8g==
Received: from BLAPR03CA0110.namprd03.prod.outlook.com (2603:10b6:208:32a::25)
 by LVXPR12MB999195.namprd12.prod.outlook.com (2603:10b6:408:3dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 1 Jun
 2026 11:49:39 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::97) by BLAPR03CA0110.outlook.office365.com
 (2603:10b6:208:32a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Mon, 1
 Jun 2026 11:49:39 +0000
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
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 11:49:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:28 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:24 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 21/31] hw/arm/tegra241-cmdqv: Map VINTF page0 into guest
 MMIO space
Date: Mon, 1 Jun 2026 12:42:11 +0100
Message-ID: <20260601114221.457995-22-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|LVXPR12MB999195:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bedc59f-83cf-4029-001d-08debfd3dcd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: BKxHnDKdtLQPFwwnUAn1IfBup1x8zKrlJxF+CDSzZac3/HyFbIKa1gwqz97sUqCD7qnwolM7EIHwMI9MSsxEF/6QX7P4uPEMVbDHLEfh7j8prUV2jBpQ0ZCvTAzjZogLeOcT0+xvd214rxF9RXEfz/Fi0C1zNi9R9xixR1aKqvBLzO/D/I63uXOFKl69mh4kys1yD7/D6UPkVjSLBEr13A9G45N5jvk63ZYZgtrkbCHAcoAl6iZ0TnsUm8yB9jWH+Cpp2p9e17/nqoCyaRz6uRFVCTEMqCVq5bput8X1IF/nAH0gBTSMNaxq+UllNox1ujSIQBIAhiF1tzsLLX83PJ5djAWam/QbdHWTydI25A/FeoFFAsvQ82GMDMH55sTi+WIaeZ+gIUEwQEp439okDoxVxuec3E8xtqt7/OVAQOu+TClWrJIutS+LVNkNaNb3N4pxWPNNXZLs97TvF2oZ070pFiKxkTOlS7lbzn2o+NaQe2C+6/NaAqYj2Zaz/kQtSjR40hBBsbg+DMmxBxQ0znyERckmd/hTKO/iI1NjoD2MeB1139/xF7y7waMmqjucYGdty6IuKDnHYYm78nn1VAHUH5jNLq+l1FJRWYy+Nw/+8Cv3iCXz5TDzQOH3ivB9ZIsn0EZ7Px23D2Bn+ZM2EtYMS1QFWd+Xd4dpKTbzCjwJWpg19a4hKks/0VQA8tV52aT7I9jSwej1Xo/AevIrK/8Bll/pFw+TTNCyQQI4BlY=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mmPXr7WCbd1DZrOa6ScZeW+R1hDdlToQHvi6uMaNJirF4Hv2yMpkgbZGMmXG/swQuOePE7a34nDrQvI+Y4Ft6XfqB320/y0FI8Gi41ePkR/Os5Z0nw8sDYpKYbZtaeYtZHkoZIh5KAVkx8iKS6knPq+LGhlUWrOL8aa62LJSedHv0YtQ+5yirNtz3cv1isdDjqtxQz3HBM5xpiI3RGsR6eQFXaNY5IW4pdHlgAYaAVlOH5Ncsy3DAlUZYaZtNzKXbd5RpE/I1YxAjFa8DHgDgXEgc2xTvex7NXw29g4VYQtwpa2I904qtGDPYfh7bC0K10nAxgLfPaMj6QF/c9cgfM529fk2CEhfeIQ8xORMVajNlsvfhSGr9avZ1fp7tQlHyp3RsdltfgQTwap2yE2dlk2xVOnMJQWGvyUi7zTVa9EN1eEcfxd0M6CnVKWv5KBF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:49:39.5336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bedc59f-83cf-4029-001d-08debfd3dcd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999195
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

From: Nicolin Chen <nicolinc@nvidia.com>

Install the mmap'd vintf_page0 region as a RAM-device MemoryRegion at
guest MMIO offset 0x30000 (the VINTF Page 0 aperture) when VINTF is
enabled, and remove it on VINTF disable. This eliminates QEMU
trapping for hot-path CONS/PROD index updates via the VINTF aperture.

After this patch, the two VCMDQ Page 0 apertures use different
access paths: the direct aperture (0x10000) remains QEMU-trapped,
while the VINTF aperture (0x30000) is a guest-direct RAM mapping.

The direct aperture is intentionally kept trapped (not aliased to
the VINTF mmap) so that writes to an unallocated VCMDQ remain
well-defined. The CMDQV architecture allows software to program a
VCMDQ through the direct aperture without first allocating it to a
VINTF; aliasing would route those writes to unallocated logical
slots in the VINTF page, where the hardware silently drops them.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  1 +
 hw/arm/tegra241-cmdqv.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 84499b840d..01cd6af97d 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -49,6 +49,7 @@ typedef struct Tegra241CMDQV {
     IOMMUFDVeventq *veventq;
     IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
     void *vintf_page0;
+    MemoryRegion *mr_vintf_page0;
 
     /* CMDQ-V Config page register cache */
     uint32_t config;
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index dce7089697..cdd4fa4f1a 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -18,6 +18,40 @@
 #include "tegra241-cmdqv.h"
 #include "trace.h"
 
+static void tegra241_cmdqv_guest_unmap_vintf_page0(Tegra241CMDQV *cmdqv)
+{
+    if (!cmdqv->mr_vintf_page0) {
+        return;
+    }
+
+    memory_region_del_subregion(&cmdqv->mmio_cmdqv, cmdqv->mr_vintf_page0);
+    object_unparent(OBJECT(cmdqv->mr_vintf_page0));
+    g_free(cmdqv->mr_vintf_page0);
+    cmdqv->mr_vintf_page0 = NULL;
+}
+
+static void tegra241_cmdqv_guest_map_vintf_page0(Tegra241CMDQV *cmdqv)
+{
+    char *name;
+
+    if (cmdqv->mr_vintf_page0) {
+        return;
+    }
+
+    name = g_strdup_printf("%s vintf-page0",
+                           memory_region_name(&cmdqv->mmio_cmdqv));
+    cmdqv->mr_vintf_page0 = g_malloc0(sizeof(*cmdqv->mr_vintf_page0));
+    memory_region_init_ram_device_ptr(cmdqv->mr_vintf_page0,
+                                      memory_region_owner(&cmdqv->mmio_cmdqv),
+                                      name, VINTF_PAGE_SIZE,
+                                      cmdqv->vintf_page0);
+    memory_region_set_skip_iommu_map(cmdqv->mr_vintf_page0, true);
+    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv,
+                                        CMDQV_VINTF_PAGE0_BASE,
+                                        cmdqv->mr_vintf_page0, 1);
+    g_free(name);
+}
+
 static void tegra241_cmdqv_free_vcmdq(Tegra241CMDQV *cmdqv, int index)
 {
     IOMMUFDViommu *viommu = cmdqv->s_accel->viommu;
@@ -445,6 +479,7 @@ static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
         if (value & R_VINTF0_CONFIG_ENABLE_MASK) {
             if (tegra241_cmdqv_mmap_vintf_page0(cmdqv, errp)) {
                 cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
+                tegra241_cmdqv_guest_map_vintf_page0(cmdqv);
                 /*
                  * VCMDQs whose BASE was programmed before VINTF was
                  * enabled need their hw_queue allocated now.
@@ -452,6 +487,7 @@ static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
                 tegra241_cmdqv_setup_all_vcmdq(cmdqv, errp);
             }
         } else {
+            tegra241_cmdqv_guest_unmap_vintf_page0(cmdqv);
             tegra241_cmdqv_free_all_vcmdq(cmdqv);
             tegra241_cmdqv_munmap_vintf_page0(cmdqv, errp);
             cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
-- 
2.43.0


