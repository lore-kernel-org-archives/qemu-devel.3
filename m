Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7D0F4198E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxwn-0001Te-Ut; Wed, 15 Apr 2026 06:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwY-0001MK-S7; Wed, 15 Apr 2026 06:58:03 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwW-00046k-PQ; Wed, 15 Apr 2026 06:58:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfCjtSu5vxSRVP0QaT92/K2BnxNxHWGyUPI033cNGiVeRjR2rjHKTF9BqyPZRBgKNyGJigd+ck71SSkTI5decJIRgr4Reoh3ne02e5QhdtnyNYLlSY2ofIwITLTjKOc5QCkRq93hWWPGl7eYjbvLvzF1yUSBBYd/yw0oMDtO3x7dednAICA/vbefEFm7ABSQl0+V+KKAEQBkb1TZhwxDp9YJxRgJfEXfR4B+Ds/KlERnzoHu7shu8VdfyaUuRwQ9H7Uvn9pXyQO7SbuDt0pjjoKlMRs9JlHl/awFDVsCae0rv86zWiUEtLfeSYU6uphC/ezLt8ZAXAboUarvw7VPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TExLZSHMNmheMrM2kS4fTDmGzsEZixGZDbuIna5msA=;
 b=atQYzqWaTBVm0M4u6HSeOhyhMasah1zuQQuUxoBxK6EJ1M7EJs9Fktz0BdnxL4XGZ2qsRV+1oR8m71xJezRH5zaqJTVGBuk+dmjkKBxDeJguUAwamihpF907OZtk7IY4iWc1kLUIPy9vx+uFueX84PrGynyruZArpvjFnouVggs3hMaitOlD753D35AEmjVMEZIEaXfzmItEPVDUDGASWzzOToDIv8Yop2Qd5pbmAo4JkQAB9jAK2Lo5GjPQCVMtQfymU7r1+AwVRxRC/IOr2ayfTYDfwhL0oIofKPMif0qpXPuEPbhG39hYo4AvtOA94QrJrC5zRADiULeCx9iV5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TExLZSHMNmheMrM2kS4fTDmGzsEZixGZDbuIna5msA=;
 b=bYE9fVwFOLd+pc6EayxA8C8dtayUhVLiwYV19QLxO9ZP1wRBMoHs7LFOGBgZMKp3ezo8pGKc3PuTo4pUHXNT3ZnztPiEO3Aak5zTOCSmQd3+e21nTA3yXollnqkUjfhDtNYTYpZRqbd0UM6NkNB+fnTG8yvePHOrgyd5hfO90Akj/14diVK7SVFUaMHowPQRryt5JSlyY7hFbEfgAYlYPcq8fEJrWDa/KmPS1B5bre9Mwj1EiCroB5GqWSeceubadtsLUoVP+4fGe4BurZZx+OnSZtRf8dbnAh+h9jffJ5FSIoct/tCoNm6IS/wNPkGGF1r64nwaKfITvbmOWBJOPA==
Received: from MN0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:52f::30)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 10:57:54 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::da) by MN0PR03CA0014.outlook.office365.com
 (2603:10b6:208:52f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 10:57:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:57:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:37 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:33 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 17/31] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
Date: Wed, 15 Apr 2026 11:55:38 +0100
Message-ID: <20260415105552.622421-18-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: f71560e3-b2d4-44e7-527f-08de9addd866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nLjso9eo5CY86I39Mylgpsbz9O0+tvqYu6H1NbW+0+Co6ITsGdPGvWD7qh4u5hF7E1dcnsxOwTyg4e6UTl5xru+1vME80ghuAf36FuUa/xfErV4upfk4c9TlN83HGFPE/Wta6KNhJvUFujajqOD5Qivt4LXqbU2WMc316dqPl/prZ2jxV0lbXxsLt9hlKk4hPkh9U8b+11TNAj15jOLWfSoJ91x7C+F7kM1zsyJ7Mrf276g7l6dmdhIecQQSMloUt4KU641IVdNHL1JmynMZlEkdMxLNRHKqMhuRoL8Ot9lkBiB/lFCUslojYqMNkbJSZjuyJa9rhVpyz3NFcjkm/Aur5LO/EUM8JmJuZikGFZtS6mngSLIciCwAWFIXbm/4xt/UhhozrJDq7g3aYq0Y3he6tc7I4rVST5f04ZwMsgkviFgZ5230TTH8jQ+ZwazU9xLYbZO90QY0wgdvDXC9p6Vu58VehuM7JLC/U9rSNCWzMKE9arlPhdW6ke+H7qtH/olwBqXwcsguoS3KFt+ZhQU5Tc2u9rQWPs3tkhvsEMuJeKy67NwBmggjkQ5x/2C6MbPUMbzAbVEEJA6tScqVhUKd4qdZvgrJZjYHI1p63nMAwyeDMNChZzZJoZYCZbY/JSTCcJsJMasArjM92l9UzhnU0ZAWVf9yn5w/Q+PJM90acquqI91tV8/jy87Y2Zqmshs85oh8jL9tt1jrsHWiVuifo3cNNLNIZbxONOt6bBsd1KoCVzsN68hTR0shuXac1c2ijM0sjEv9kMj3eCzp4A==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wb2CZWxPZoIycR72lwp4aPWZz+KeMOPA0kdL5ftyPmy/Nhqgfg0epzG9Mwi+CFDKG0R4i701v3k3NcmabwQu46r+tQVHZ7XkUDIcXAnjWOy4UhjIy445xtOKB/nNFT7zk8TcCRY3OUKAH/kE+RLe9UUvke7cF8YgCckFWmsckcrbNFfzE7wgn0sXvSwmwwwtaxG+42BQnll8bK/h+HuRXID/WWKeLjV5ibzITQS8pmT/FAdwgwwHdTYC5AgbIwS83KjbuJ1xXSCdW4QYXC35cXWHtUG3SxCbDrJKgIy8VdY7FQbQMKeafM0o/IfiFaR7BCDvhGDbLqKFVhHZg6Ye5TKL5NnUmMSahCE6kdPW1PUvlxQNp6zoewVwU4TYYG1fwm9Q42oqLdaoXuWugnC8mA/m8nGz0gz3El0itSvwHpUJoT2IdUBlrBejeIxExUz5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:57:54.0413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f71560e3-b2d4-44e7-527f-08de9addd866
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The CMDQ-V CMDQ pages provide a VM wide view of all VCMDQs, while the
VINTF pages expose a logical view local to a given VINTF. Although real
hardware may support multiple VINTFs, the kernel currently exposes a
single VINTF per VM.

The kernel provides an mmap offset for the VINTF Page0 region during
vIOMMU allocation. However, the logical-to-physical association between
VCMDQs and a VINTF is only established after HW_QUEUE allocation. Prior
to that, the mapped Page0 does not back any real VCMDQ state.

When VINTF is enabled, mmap the kernel provided Page0 region and set
ENABLE_OK only if the mmap succeeds. Unmap it when VINTF is disabled.
This prepares the VINTF mapping in advance of subsequent patches that
add VCMDQ allocation support.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  3 +++
 hw/arm/tegra241-cmdqv.c | 47 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index b8bd8cd8ff..88572ad939 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -18,6 +18,8 @@
 
 #define TEGRA241_CMDQV_MAX_CMDQ   (1U << CMDQV_NUM_CMDQ_LOG2)
 
+#define VINTF_PAGE_SIZE 0x10000
+
 /*
  * Tegra241 CMDQV MMIO layout (64KB pages)
  *
@@ -42,6 +44,7 @@ typedef struct Tegra241CMDQV {
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
     IOMMUFDVeventq *veventq;
+    void *vintf_page0;
 
     /* Register Cache */
     uint32_t config;
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index d4ba2ada92..cdd941cec9 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -119,6 +119,39 @@ static void tegra241_cmdqv_write_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0,
     }
 }
 
+static bool
+tegra241_cmdqv_munmap_vintf_page0(Tegra241CMDQV *cmdqv, Error **errp)
+{
+    if (!cmdqv->vintf_page0) {
+        return true;
+    }
+
+    if (munmap(cmdqv->vintf_page0, VINTF_PAGE_SIZE) < 0) {
+        error_setg_errno(errp, errno, "Failed to unmap VINTF page0");
+        return false;
+    }
+    cmdqv->vintf_page0 = NULL;
+    return true;
+}
+
+static bool tegra241_cmdqv_mmap_vintf_page0(Tegra241CMDQV *cmdqv, Error **errp)
+{
+    IOMMUFDViommu *viommu = cmdqv->s_accel->viommu;
+
+    if (cmdqv->vintf_page0) {
+        return true;
+    }
+
+    if (!iommufd_backend_viommu_mmap(viommu->iommufd, viommu->viommu_id,
+                                     VINTF_PAGE_SIZE,
+                                     cmdqv->cmdqv_data.out_vintf_mmap_offset,
+                                     &cmdqv->vintf_page0, errp)) {
+        return false;
+    }
+
+    return true;
+}
+
 static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
                                                  hwaddr offset)
 {
@@ -151,7 +184,8 @@ static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
 }
 
 static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
-                                              hwaddr offset, uint64_t value)
+                                              hwaddr offset, uint64_t value,
+                                              Error **errp)
 {
     int i;
 
@@ -166,8 +200,11 @@ static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
 
         cmdqv->vintf_config = value;
         if (value & R_VINTF0_CONFIG_ENABLE_MASK) {
-            cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
+            if (tegra241_cmdqv_mmap_vintf_page0(cmdqv, errp)) {
+                cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
+            }
         } else {
+            tegra241_cmdqv_munmap_vintf_page0(cmdqv, errp);
             cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
         }
         break;
@@ -276,6 +313,7 @@ static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
                                       uint64_t value, unsigned size)
 {
     Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
+    Error *local_err = NULL;
     int index;
 
     if (offset >= TEGRA241_CMDQV_IO_LEN) {
@@ -301,7 +339,7 @@ static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
         cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4] = value;
         break;
     case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
-        tegra241_cmdqv_config_vintf_write(cmdqv, offset, value);
+        tegra241_cmdqv_config_vintf_write(cmdqv, offset, value, &local_err);
         break;
     case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ1_GERRORN:
         /*
@@ -343,6 +381,9 @@ static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
     }
 
 out:
+    if (local_err) {
+        error_report_err(local_err);
+    }
     trace_tegra241_cmdqv_write_mmio(offset, value, size);
 }
 
-- 
2.43.0


