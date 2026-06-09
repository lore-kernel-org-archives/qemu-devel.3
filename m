Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDAECD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudb-0001Bx-TU; Tue, 09 Jun 2026 07:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudH-0007qG-02; Tue, 09 Jun 2026 07:28:35 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudF-0003AM-2W; Tue, 09 Jun 2026 07:28:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AU6xGVoEZaXgLSiHi+5Tb5lt5hxq+mprZ9JL7nD01FgYgxSEOxSlxq3lIA8YPWOCxPfc7+tndYHXHy5Zqk8Vt1S8vhDZlDLWbGwK+3m0c+MpaL9h61fAVquCvg4PAL72F0ynIWAT1+52us4GG+UhAwId/Rc8YxnNd50m7ByOVV39e7BO3/rs499UK7G2+VqzFzsT8g4nX+cXBfhifMLnTiTCoGyy75HnUL2mGTp3IrOPFi6PXeloy/NlcGQgBNEqNfTekSM99fSYe4m1xRSSVLeUPxH1q2OvHyUlTKM/QYJrYvMcv2K15z7vkdVA0Ye8f5oTT2Wq2ZIAsh+FyJebww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFfzrXmFLrA5zY1lputO5Qf5dE1947TUGbkRzT0tHss=;
 b=nz6wRuCsHZr2NX3VhUHdVzq8hkO0UX8rssPAtG5m3CuRmBRk3F1tMGizm8srBtAyNVXiBrjY6lxrL+17YLAFPl2BEgGCLdllJ6fS1Q9ai+E+X42dRs5dZJS43jWohHGDPq/HWpzvj8zeShNiqJrQyhsuD71BeIWOCOsNKVc7Rsl0tfTYzm2aF5Eu9MtoHNy1pElCRGz0GcqCTWR2kecDW5RIfm/E3Q6djO2lLbW4TpZYHlSlezTK+RPaYVYoMvkNJv5K8cy0okex6zonA7nApjXN/i+/N3aGQe4KpA4uRvs67JUPRvNLlwNpMYICKhv9CT0349+HYchCaOowdnBFAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFfzrXmFLrA5zY1lputO5Qf5dE1947TUGbkRzT0tHss=;
 b=rkugKyY2Mo53dRaQBWc4MYOU/NoKDbKrvHEO1sqYawf+mUl+UZ+KenbSXbXYz8SqLFEmcqoKSThhav99N1DtHScMXHYQZW0UgCwsBUA/WOV+trAuG+GAOcH1Ts+FsqtcqBYj8B5igM7/DFbdiqtawUdteMX/yaikTZDg9gVk/ug02ghoICRWEn8F95XLjcF4zrNjCs4xr+NiykukjQyO9xsmfL5CFETi++sQb4Y8z7Q5XGXQnbAQHKzC2iQhLfD5PFhwFWXd0pjEyY/mkC9uOljhDHXJPhBURxJ3AQkpu2sCCfCaZ0NP1xpssHF1iNZiSc9uuawRkvBlDtE3eKgO8A==
Received: from BY1P220CA0039.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::7)
 by SJ2PR12MB8134.namprd12.prod.outlook.com (2603:10b6:a03:4fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 11:28:26 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:59e:cafe::3a) by BY1P220CA0039.outlook.office365.com
 (2603:10b6:a03:59e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:28:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:28:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:08 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:04 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 21/31] hw/arm/tegra241-cmdqv: Use mmap'd host VINTF page0
 for virtual VINTF page0
Date: Tue, 9 Jun 2026 12:25:42 +0100
Message-ID: <20260609112552.378999-22-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|SJ2PR12MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ceaa76-49cb-44fe-b121-08dec61a38c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: bjCV9ISvOc/36YYKiBJpJV+xMrTQivN4nphqM7rMWGf+SXGC0GB9Q5KVknOlIck40HZlCmclJoeaRgPJmlxKivEIayv4Vc5H7/yZ2Q+LD1xttfNX63ZEHUQ4Ys6cmbvWM90MvyE6zPMer0JgkqDefV/koEKmE9qUUCol9avGO6MeWq5uui223fwSjrGD/isq6p6NiFN3DeV5/5H3NMAKfEwAHAehmYfA1I9TR9mt953ISto9FCakQ7VWeiImvT2Lks6AFlu9tcdz3t8S2dIdP4AQEGMN3ogqiNDB0hcSo4tTXJqahWaEBYCRRCz2ryqcyNlJBl/rPNqmT7+JVGlpZwhBX7YyVmYjdrXjubA4aiW6GmsRiSt8YqWVIJLg7iwjDgfhNtqaitbDsGK8QcuukVx3qJJMtxbbs931kdoIrOy2ii7Ua5s9aZ+pjT/OTEzVNhtz8jx9DVYCvLARzDFwhr1KskilpPerB/lpcKOSIM9bkCRHzeNQsGwW8oSpKxJh3840EZBqTRPHO8trmx4E/gyq/aQAR+OGK0gDtEhTqFMd+BQX5w1EkXFb5sQrm+SPDwQLc/W7rwHgSsjq1Uorxz7hUQqEVFO9mQWcKKS1yzqGdoRFXewgskmiJx7W8DZ3Cmwd9a0gWKxSIi13porx4LAb6SBFHCDJmeYbyhiM0d8vOT6Z/V0CyvmLonILW5mr2T7SIJnwE1Cku+UGZThybjjd0BtTAObWp5LxtE60br8=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HePLB46xIyyQ42VXoIVc6m9sp1j+WBsOuLqjtP3AjOxkr9MFsbqp/w0zMDhASnEcysu3f7BorTz8F1DkpFDLMVhSLoJDcupQcPzobCY/wT+xyDQZwowwsGlCjr6MZSM74dAtyoq4uaICwwGYI5tkcWoLGshwfDSjgwkDYGQQErKHzwTfsBJOSTXpLeEGUQmqY06sX89ep6Tz1au14Hnw7J3zFbc1OU/+eUYe2v9quMrqdRalB9qIaLNGikKtGBMrcCaFd249D5KQQkWSg8/xyj7766yI8JeMAZT2xq4kt/lZP8SJNbTGSffhERgMjBFxWK2qNMAkG9AN03Fzj7K5mMjpdC/jFV2fuUn2O3RDwawT7KPdqd1MJQgIygX4Ssvf5J9nvw1j8i9rcGQsRbWzBFd5OYvJ22lg8e+3wnFnzr5jpgwE7pEc+KeDUY2/Itd+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:28:25.6002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ceaa76-49cb-44fe-b121-08dec61a38c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8134
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

From: Nicolin Chen <nicolinc@nvidia.com>

Install the mmap'd host VINTF page0 as a RAM-device MemoryRegion
backing the guest's virtual VINTF Page 0 aperture (guest MMIO offset
0x30000) when VINTF is enabled, and remove it on VINTF disable or
reset. This eliminates QEMU trapping for hot-path CONS/PROD index
updates via that aperture.

After this patch, the two VCMDQ Page 0 apertures use different
access paths: the direct aperture (0x10000) remains QEMU-trapped,
while the VINTF aperture (0x30000) is a guest-direct RAM mapping.

The direct aperture is intentionally kept trapped (not aliased to
the host VINTF mmap) so that writes to an unallocated VCMDQ remain
well-defined. The CMDQV architecture allows software to program a
VCMDQ through the direct aperture without first allocating it to a
VINTF; aliasing would route those writes to unallocated logical
slots in the VINTF page, where the hardware silently drops them.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  1 +
 hw/arm/tegra241-cmdqv.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

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
index 63fe0ac681..7264b4bfa9 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -26,6 +26,40 @@ static void tegra241_cmdqv_reset_vcmdq_cache(Tegra241CMDQV *cmdqv, int index)
     cmdqv->vcmdq_gerrorn[index] = 0;
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
@@ -430,7 +464,9 @@ static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
              * enabled need their hw_queue allocated now.
              */
             tegra241_cmdqv_setup_all_vcmdq(cmdqv, errp);
+            tegra241_cmdqv_guest_map_vintf_page0(cmdqv);
         } else {
+            tegra241_cmdqv_guest_unmap_vintf_page0(cmdqv);
             tegra241_cmdqv_free_all_vcmdq(cmdqv);
             cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
         }
@@ -772,6 +808,7 @@ static void tegra241_cmdqv_reset(SMMUv3State *s)
         return;
     }
 
+    tegra241_cmdqv_guest_unmap_vintf_page0(cmdqv);
     tegra241_cmdqv_free_all_vcmdq(cmdqv);
 }
 
-- 
2.43.0


