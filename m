Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEF6C5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuVA9-0006Pd-BJ; Thu, 13 Aug 2026 09:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wuVA1-0006Nh-Ah; Thu, 13 Aug 2026 09:07:54 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wuV9y-0005Jy-HZ; Thu, 13 Aug 2026 09:07:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/cdNEUlsjr9703haJOLB0nLScHzcc5UysOpHcRo1Zbvt2rIfTS2XPCFjASzzn9hokyKfFIfia8H2Vhl3j76FnE7MznqVATRoVQ9E2ORXr8OQoeflPyTjdpInguN2KoTHLTPo2i5ADREeUXH12+mmvWYLTrFhOExGCbnIwUr7VFjlxHl4eFJRvfgdzNxvYihYRhUwTQbHMUsntThsPc+kklCdLr7AONbz5N+KaEOcoK3z9PPVZ80CqgpTVzX+KjnZ7wAVq23Sl2YJx/dc0TbcFkUfxCBxp6u78ykpe+ZUzAMALqJJwbkUizXTIVf+23AAjV3IFeP7Hl1qOOKwr6p2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4kHlaLSgY+ovoGxXkIJhhxHLfLtaf44DCI70YLh/NQ=;
 b=Xg38FFR9u2cqHGkCuk51kWFy8IX8JkRQrKyzwA2PokmmDZWWN4nfIxSKZ5CH/3r9y+KweqGMESkeBNpfLq1/8/NYDTbptk5E4uFUfcPcNMmFloMAz80WfWFdb/KGaQxA/KG/7mrjd5XNsZfeCnpruVpwfwyw+PhdUKqDiYr2xOw2nndY7BosXPN9PNL0N7A+JMULTZnVO+YOu8sfL5Vc/irV4acUIgYZHhsXan16uVXJ22XUzjuav8R8eUjFK1JioDGVChg4hTerutmR/tOF9tIL5XEtiuk1XSBgib0kWZKYTasWKpNJlM47+ELpHTBheaobJSy8XKl3X055IceoIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4kHlaLSgY+ovoGxXkIJhhxHLfLtaf44DCI70YLh/NQ=;
 b=YYoHKuhj8s7iCZN+Noa+gtN8EL6X3ymsRYQw1LA1PKqSROvZYKpQYnMzVtFueS5/RWQ85YXb1lLdQw4LcBRmlTM9pnfOre8fgwuNaMeDVyPoacZazjdYvIUOAgHFWiXcJ1zz6GKwTpHZ5TUmdhF+AhACAhjRnpD4TaoLruiscUNF26g0wajlxs5S5wbrzNbkc35M0yGkd1yItrn6Sn6zVXgQrzvTannLURY4sLI+lP34+cam4d3kKOPeMoux4GSxN2YCu5aHK99czqm/50yuyHkgIfgM+3Z2b1jO1pKQeIA6qBlzFByJVNvB2gotXr0W/8g4vhoaBZZhy7leZG5Rmw==
Received: from MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23)
 by DS7PR12MB8369.namprd12.prod.outlook.com (2603:10b6:8:eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 13:07:37 +0000
Received: from BN1PR14CA0028.namprd14.prod.outlook.com (2603:10b6:408:e3::33)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 13:07:36 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::66) by BN1PR14CA0028.outlook.office365.com
 (2603:10b6:408:e3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 13:07:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 13:07:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 06:07:15 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 06:07:08 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <pierrick.bouvier@oss.qualcomm.com>,
 <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <pbonzini@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <clg@redhat.com>, <cohuck@redhat.com>
CC: <kjaju@nvidia.com>, <vsethi@nvidia.com>, <zhiw@nvidia.com>,
 <mhonap@nvidia.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH 05/10] hw/vfio/pci: Back the CXL memory with a RAM-device
 region
Date: Thu, 13 Aug 2026 18:36:18 +0530
Message-ID: <20260813130623.2499506-6-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813130623.2499506-1-mhonap@nvidia.com>
References: <20260813130623.2499506-1-mhonap@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|MN2PR12MB4486:EE_|DS7PR12MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: 4049fde2-80c7-4d0e-63a1-08def93bd85f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700016|1800799024|23010399003|82310400026|11063799006|10067099003|56012099006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: kYqOgeyRvZwU/g5zbzc02l6zIeBEdLpUSqL/0ZI+sWGBOkpWuMTASLQhYimNma8HTa91xKi+DnaviOnA8WQ0h48rChyx/tWH1kMmbDtJpjofoTaFdV4J5KgYp/ok8XymqbFLuYSS2M1Rl6FMS1B/D30Nj0rE8aucvDWX8i0aA/SmOH3JK9vdn455K8BK/NU/OHOo10DoDyKn60s6xqWgvxCBgWGZRYyaP35MIHex3QcBDvczH2BHN9RHwlym60PTjMQKQ4OD60CP6yxDF+HbXAop2gmPUd3npJWMyEcynTfpsDy7Va4DanxEAc/s9YjY7XoxzSd8NkRLHj7MVAMsgMBF5R3mAoXaTFD8P9UUoPmo0o3fQxW/4OjNPFHjN3CGMk7+LR2umSb8DMB3y8IB/Fda4idZhvdCTprjhFSVNFWbgtOkA2NTaXHSQ/9VyhhzEDDY0csQBBB1C/+AWaQL3CqsU4dNrHMKPffj0pFNc5Ox7F6Qv2C6DCOZ0LT30tLvUdnZKHMpDflrKrIkEdhSTTWECSppZ4cxssXjwlXpHfQFqz7nc56S9mng4ONOMB3t9MVTboa0U96xpuTHaRSbEMBFBfJfVrn/5p9+eWk26xs9w2izfYMfoovdTyQe/EgW36ugyNIQT8knrp70o//zJPcIRclelajhwzqGXxzS2Rk8ECnNGInfthH9Pjmoqe/TLcNP1lt2nYLGxb1XK+JdwZgzF/8cJ4tKW561+iCMT9CrIPP+Gws4wCGV6hi4yDz5
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(23010399003)(82310400026)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GQOAPJu75V0wWqrDJDMvg1StsDgrOSpds4e5b0y23/NFCRdw9/B+aeOqWZWjLWYnpJ+qwY1q9O5yFNxgLJozgvNRgqC/ZxjlMTinN5cGRo0ZUIO35u9Nq6mOkP2FEgCGFFuuOGCpdBGvv53M0gpTXIjdHC6XAvca46fYPfe1HKwpnira9cAH30ZFFERSO99unTm5D6hm4HkxSPto36wpj++7BqqV0+EFZ3nTY1DlenDvPxfwdx5XemdAKhgGGGum/naw7wBNRQ0EAEn6QYnni1InoUpcmoCZqpl46dV6qQyra9zw5t/INesTDHiT2bk4mE9df9pXl4tKhVOuhvedaKa+9ixagmdljjgAhCKMtiWe1iRoPR5IYgyYJVkXnHdfXQRXOuCAT+achAVS/jPkPVmV6ZSEZXHOIv0Vhp6VSwL+4C74ZnL7M07EZusOFWJg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:07:35.9867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4049fde2-80c7-4d0e-63a1-08def93bd85f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8369
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=mhonap@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Manish Honap <mhonap@nvidia.com>

mmap the kernel's HDM memory region so its host physical pages back a
RAM-device MemoryRegion. It stays out of the guest address space until
the guest commits its decoder and QEMU learns the GPA to place it at.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/vfio/pci.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h |  1 +
 2 files changed, 46 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1f21da9513..066333d52d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3221,8 +3221,11 @@ bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
+static void vfio_cxl_teardown(VFIOPCIDevice *vdev);
+
 void vfio_pci_put_device(VFIOPCIDevice *vdev)
 {
+    vfio_cxl_teardown(vdev);
     vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
     vfio_cpr_pci_unregister_device(vdev);
@@ -3666,6 +3669,19 @@ static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
         return true;
     }
 
+    /*
+     * The HDM memory is exposed only as an mmap-backed RAM-device region; the
+     * kernel rejects fd read/write on it. With x-no-mmap the region would fall
+     * back to that always-failing fd path, so every guest access to the HDM
+     * range would fault. Reject it here rather than start an unusable VM.
+     */
+    if (vbasedev->no_mmap) {
+        error_setg(errp, "vfio-cxl: %s: x-no-mmap is not supported for a CXL "
+                   "device; its HDM memory has no fd read/write fallback",
+                   vbasedev->name);
+        return false;
+    }
+
     if (vfio_device_get_region_info_type(vbasedev, VFIO_REGION_TYPE_CXL,
                                          VFIO_REGION_SUBTYPE_CXL_MEM,
                                          &mem_info)) {
@@ -3703,11 +3719,40 @@ static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
         return false;
     }
 
+    /*
+     * The HDM memory is host physical. mmap it now; it is added to the guest
+     * address space only once the guest commits its endpoint decoder.
+     */
+    if (vfio_region_setup(OBJECT(vdev), vbasedev, &cxl->mem_region,
+                          cxl->mem_region_index, "cxl-mem", errp)) {
+        return false;
+    }
+    if (vfio_region_mmap(&cxl->mem_region)) {
+        error_setg(errp, "vfio-cxl: %s: failed to mmap the HDM memory region",
+                   vbasedev->name);
+        vfio_region_exit(&cxl->mem_region);
+        vfio_region_finalize(&cxl->mem_region);
+        return false;
+    }
+
     cxl->enabled = true;
 
     return true;
 }
 
+static void vfio_cxl_teardown(VFIOPCIDevice *vdev)
+{
+    VFIOCXL *cxl = &vdev->cxl;
+
+    if (!cxl->enabled) {
+        return;
+    }
+    if (cxl->mem_region.mem) {
+        vfio_region_exit(&cxl->mem_region);
+        vfio_region_finalize(&cxl->mem_region);
+    }
+}
+
 static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
 {
     ERRP_GUARD();
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 7fdd695704..06d15e807d 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -134,6 +134,7 @@ typedef struct VFIOCXL {
     uint32_t comp_bar;               /* component BAR carrying that block */
     uint64_t hdm_offset;             /* block offset within the component BAR */
     uint64_t dpa_size;               /* size of the HDM memory region */
+    VFIORegion mem_region;           /* HDM memory, mapped at committed GPA */
 } VFIOCXL;
 
 struct VFIOPCIDevice {
-- 
2.25.1


