Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64546FC592B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYzj-0006mP-0p; Thu, 26 Feb 2026 05:53:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzh-0006cV-Em; Thu, 26 Feb 2026 05:53:21 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzf-0000xV-Jp; Thu, 26 Feb 2026 05:53:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOnP8Ack/fvvA4ShG+IFxbwa7Lh56CitD+L8fNwXkizaX9Au6cTTUu+zfAdYd35Hj9rx5ZOXaSNzUSw2npD955teUxMilLi+Nntd11gadRUl7o8UwPmTDJsiGQgNnqL8Duwkm+1DSCY6qxa6hhhdSOh0bfKIJZy6vFPRk6ly6bH2xZZzI6puly3nNrOY066DvO0wH794I/u2NNtnXJptFxLuQiKamGIsRboSgcAkW9mX6bgDwXBzdvd8EijyI6sP2Bx5xVRtTqPrQOspwGvLGt/7l9mz9joMno+tlycnOkVrWgA6w7jIQh9eOQzaKWR2cBU/O0fX9PyrGzJ8TUAZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxDGX7oD9NhKPcS4NTStGsYZCJknJrP3JSaOIlxsgEU=;
 b=vm6ZLE1k4bAY60O5SwJtM+0AWGH5eUqJ4x970ylClLF9kx/UFP6SYXYkjZfpapZoBqn2cug6WUKXOA0T8PHDR1chv8ZnLqC8+u85K+SMowLP7Fi4S3BR7e6rNc2wwbEZKfQyLs/QO6WNQYnT6OdmnKd9YBMXnq/feR2hDhW4HAfDITPebeKpWvcu59kdPwNLZ9DNOkW/lihkdFwinGlIphy2DSYhJHMSpFwFdebAD4JDOg7ge7sZkAP6tUTDDyxGckZktUonEfNMoUzXapYS2gxWodXiMqwe7ZrXdSJJXsEOiYP0n+buqVRVENcvuyiCwL7l6uWnSZ56N3WAskulUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxDGX7oD9NhKPcS4NTStGsYZCJknJrP3JSaOIlxsgEU=;
 b=O+hASxDTZipyOC6aXk86c2WlOWkRf0nM2Gg5VHAuiILfhYHpw86Ba06Nlild7HlUjmlHG7Dmn1XfoDnR1mRgOyoQjYx/7Z1Il377lMpxsSaM5sMFzahSyHqJSD50HWzAOA3Bo2bcFTAatB6/71gvFGFEJdT+Gp5husa30OdDsd/VCmbZuxNQT3TLmFfxyE8J9xIgvxJfviDH/YKu9+MwfUWhXdv8WZ5tTcBbQoQvCur59peHty3srBMep6cUjmXSSkLIXEcZTIw8UujilHcFC39olqV6zHLO4CWOkGv4MLahkbL/6x+/w9/m7TC02NCCHZrq25jf12XSnZWQJSaG5w==
Received: from PH0PR07CA0061.namprd07.prod.outlook.com (2603:10b6:510:f::6) by
 BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 10:53:12 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::1b) by PH0PR07CA0061.outlook.office365.com
 (2603:10b6:510:f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 10:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:53:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:48 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:45 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 21/32] hw/arm/tegra241-cmdqv: Map VINTF page0 into guest
 MMIO space
Date: Thu, 26 Feb 2026 10:50:45 +0000
Message-ID: <20260226105056.897-22-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226105056.897-1-skolothumtho@nvidia.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|BY5PR12MB4114:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f59f6f-8275-42e3-e92e-08de75253c0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: GUnvlCuIUh73m6gXUzHwJ7hkaILOWOxZaVQjFAlbcxkVYbeyFfYQU+2zSp6SwdynqjcBhiWYYweL6B2tG2/HIgnKlnEmBliFGLIdg0+JoXzzYbhgXBUSwrMUohwgsqEAJxUquX8WxfN5ekqR4IrNMVn58FxjJUIlCBmFpB7UH9XcLrDGFT0S0Kr8d0Qp7CA9rZy9T8sxgT/T0EWCeDG/DyIVn5LJ9nhgr7lznQFvBMZ9Jtbk9jyRXJEbvoA4kGLjWkgqQX8+L66XfDoUMqSbRDZBr50db1rfKMJlPJF93ggVoF0DiKc207RMNzTfpMk2wg+KEY217/MfAAHUKBA3ZwQzFZOf9HhZ81IAlVXwMqsNBuST243Ba5Pc+qthVaVDvAHKibPMwUGD+i2SegUbmPndxCYzCS8kZdW70qEEUXv/TiKEZNLXzZlBIWxKiMGyp694Xx5VMDp5ZwdvyE1+f0cRT+RLbFa46YklG6D61TXM83rFUN3juFAa03I3cv6TWVGb6pmLk+ySGLVzDx+PHi5WKw0Ea2WeorqsWDkH3wjnKKg9RwskwentjNLNUmiiAE9pu9onEl/0Cn7SWuOe1sAprnFeJye3tWBqzQrm6J7kPZ/0j9BEwp0/KfRsm7Jql/ldvfP635B8bRYJk4O2sLVANRI6XRFcmut83M69VYph41vpVR3xO8sQoOkMDD50drOwAf0XOJDTSdLDHLVIFIocQoMjzh1K2bLChs2JSZtaXmajrXqCe9xHyXlOEr070/AGN+Y8E6p/qLsK+hqdgL9aST4RlmOTT9rPXhWyqAUrcVMKqtqCf+PapM5OUC6zXIlODA/EXcqKn0vq+4I59Q==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BWh/60/Je+6XYvLBmmoxPsRCV4/2U6iHRYwCUPhlfq5iS929Ny9OD9MA4dBX77tYcQ7hf2DnPAHpYVCf2nolq9yiWidpZB+IhGwfAXIuEpWeFVw7O+o3P1xOBkBd4hLQ3pTOvqKJX8BYCHguKyjCFmPzwlbAdzqJlg3RQWDaliEcN3N5f/jQBko9U4lVYqBOwRFSMecNwvcAFjBDeiwzuT85pLM/CBhW8R7Uj4eTI4nV17o8UIMdqNnaTtqv3sXLg/kxC2jEK/G2Nm9pLM17rFXjJefXbKs+PzAGV6s89pyv8Nza+yXPCVnFIvVjkinsEBt3JanqMNe1DQ6NlHz1/jGxrncRUEEcNiFSb+mGBZZWyvz2TZ0LWwGQJYHB4Vad6FjMtzwjt/W6l6UbMbgekohro8BA3UcAFLT776qgazAAnpvcD2qHBpQ76jjZpMir
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:53:11.1979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f59f6f-8275-42e3-e92e-08de75253c0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

VINTF page0 is backed by host memory returned by the kernel via mmap.
Instead of trapping and emulating accesses to this region, map it
directly into the guest-visible MMIO space.

The VINTF page0 MMIO region is created lazily when the first VCMDQ
hardware queue is allocated. When CMDQV or VINTF is disabled, the
region is removed.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  1 +
 hw/arm/tegra241-cmdqv.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 139e14b61b..914977c2ef 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -38,6 +38,7 @@ typedef struct Tegra241CMDQV {
     qemu_irq irq;
     IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
     void *vintf_page0;
+    MemoryRegion *mr_vintf_page0;
 
     /* Register Cache */
     uint32_t config;
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 17b9552906..ce144add54 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -178,6 +178,38 @@ static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
     }
 }
 
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
+    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv, 0x30000,
+                                        cmdqv->mr_vintf_page0, 1);
+    g_free(name);
+}
+
 static void tegra241_cmdqv_free_vcmdq(Tegra241CMDQV *cmdqv, int index)
 {
     SMMUv3AccelState *accel = cmdqv->s_accel;
@@ -236,6 +268,7 @@ static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
     hw_queue->viommu = viommu;
     cmdqv->vcmdq[index] = hw_queue;
 
+    tegra241_cmdqv_guest_map_vintf_page0(cmdqv);
     return true;
 }
 
@@ -371,6 +404,7 @@ static void tegra241_cmdqv_write_vintf(Tegra241CMDQV *cmdqv, hwaddr offset,
             tegra241_cmdqv_mmap_vintf_page0(cmdqv, errp);
             cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
         } else {
+            tegra241_cmdqv_guest_unmap_vintf_page0(cmdqv);
             tegra241_cmdqv_free_all_vcmdq(cmdqv);
             tegra241_cmdqv_munmap_vintf_page0(cmdqv, errp);
             cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
@@ -411,6 +445,7 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
         if (value & R_CONFIG_CMDQV_EN_MASK) {
             cmdqv->status |= R_STATUS_CMDQV_ENABLED_MASK;
         } else {
+            tegra241_cmdqv_guest_unmap_vintf_page0(cmdqv);
             tegra241_cmdqv_free_all_vcmdq(cmdqv);
             cmdqv->status &= ~R_STATUS_CMDQV_ENABLED_MASK;
         }
-- 
2.43.0


