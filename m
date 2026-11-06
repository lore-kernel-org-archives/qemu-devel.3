Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B6C606A31B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 04:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GwdLZdf2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPBAT-0004SY-Tn; Thu, 05 Nov 2026 23:03:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>) id 1xPB8c-0002z9-Pt
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 23:01:28 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>) id 1xPB8a-0004OQ-5C
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 23:01:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHqMlYBM6/9XOf/dCgu05Py035TzecwzLAfZo8L4XmHBpYC/y9CP10prvwHvXb+5AcOZKKALdWr88dcRYR+vlM6Gugk5iLuoTvk+rH6wJoVySkYSqA2mH5X+1gn38ADDJJJemX2pZ9sh3BC3OmGGVTN8PVvIZ+Oa/B2b+djePldkb9UxvAB0mw//4EzKqYIq7I6EduU0B50COgEdlusYgb3mppWNXGG1qSlCoefC2MYpGEMM9/JTXdUan/rd978uXpAc+F13Jzqew7qPI/7bi9LCxgmFpfFg/734yn4BObZ8I1UcGDBouK6WX7nldlifpE7N5LUwnHjiula8bOlg5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAJzx/anvgjDK7IL1RT3yr8XKnDi3TUBcFKJ4HgAbLg=;
 b=T01RxaLwjJWYL8AZOGQMPDdNcBTJCMzdm3RVVHTYoIhyMHqlQsEVbRGf901S8ZLiSuMxvvwzNCqVpG7Z9aUOn2Wfx26NhTMkW3QDSlMgipmR1ikSVXBwvEsQP68U8DhpuphbshqH2eYfxYJf0302M37PPb02YtcSHCbcrFzx7gAqeNAghNBdhBdTcIziQFI0/0eaoBRYJhGcXFl0Nf7sYZRky4mYiJsF+22C6/acuqWVsACa2K6zujmK6zgUNp/b4K3fzR+6TLSUuAuiDWbX72dxC/ctDY1vbnzNX8qE4uOIGb2nWTf1wbECFUvzcGK4JACN51pcA3rpvhI6ua8fBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAJzx/anvgjDK7IL1RT3yr8XKnDi3TUBcFKJ4HgAbLg=;
 b=GwdLZdf2rHo7XUPVguOI21Z2FpJfqZTzuV7Zx8xFYaQFpV8UilrpSHDxnenCtFLLDrvJFeYs2RHJz9FZgyXZ1s9urEKZgeyBTft+/eA1wqbft2Aah8vDGuoEESqi+UMBc8WFUYAuhQHXspyf1qR8+X7CfiMb4c+SlYejCNQRpO4+4PVPUfz3dj9dJy2Io9t7VD+a1AHqo4KTMNcs/liASmVLfdGuXzwviESPnzVe3wCWj8m0eo4VlgXRgwUOOlDUhrNjVuFWDMd7V0U7Qit3T6VLTY4RuMyI2atSFGZvNo5XrxkXg+xcn2KSmKG33hgaZnk25u7462QbbuD7x+TM7w==
Received: from SJ0PR03CA0184.namprd03.prod.outlook.com (2603:10b6:a03:2ef::9)
 by LV9PR12MB9808.namprd12.prod.outlook.com (2603:10b6:408:2e7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:01:05 +0000
Received: from MWH0EPF000C6187.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::49) by SJ0PR03CA0184.outlook.office365.com
 (2603:10b6:a03:2ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Fri, 6
 Nov 2026 04:01:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6187.mail.protection.outlook.com (10.167.249.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:01:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:44 -0800
Received: from cxlgalaxy.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:39 -0800
From: <mhonap@nvidia.com>
To: <jic23@kernel.org>, <alwilliamson@nvidia.com>, <clg@redhat.com>,
 <xueshuai@linux.alibaba.com>, <ira.weiny@intel.com>, <zhiw@nvidia.com>,
 <mst@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
 <junjie.cao@linux.dev>, <anisa.su@samsung.com>, <pbonzini@redhat.com>,
 <ankita@nvidia.com>, <vsethi@nvidia.com>, <skolothumtho@nvidia.com>,
 <mochs@nvidia.com>
CC: <cjia@nvidia.com>, <mhonap@nvidia.com>, <kjaju@nvidia.com>,
 <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: [RFC 13/18] hw/mem: Bind cxl-type2 to a fixed memory window
Date: Fri, 6 Nov 2026 09:29:06 +0530
Message-ID: <20261106035911.1280066-14-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106035911.1280066-1-mhonap@nvidia.com>
References: <20261106035911.1280066-1-mhonap@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6187:EE_|LV9PR12MB9808:EE_
X-MS-Office365-Filtering-Correlation-Id: ac44d3ce-5d73-4061-9a15-08df3bba9457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|7416014|376014|10067099003|18002099003|22082099003|3023799007|921020|56012099006|11063799006|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261009223027099003|261021135927099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: RRDwB8tpkCIqKCQIABwgjvHPpqy4hCZohW3mjf/U4psdWcawxjDdGdSkQ6a+CZUmhb48n6m1YIq1lygJYuWakk2aMeTaXPbDyv9APZtKMbFuphFV+fWEqJLhT008T7Cr2SBbyC+38kFtlkXLZWf9lOZUm3OCQnDLUvEj8rv92znqsNa0Rn7ase6lVjuwlUnfwtDtOzIJFO3NuMHZNPYER+Kjzdbf6tiBKCwSiQmtBG9HjLTkqE5UMU5murlJFxNwbDYAwb74L/eF5bM3tjwA82PIZNNTm4PYfy66Dxl7mKEcTgPUl3npGWGkxNS2SZlMrnRLwWGiWexPVYPHdxVLSgiUpqfifAvlodfKl+yzrUlJp1aVEPtrKd1oz4cniQOdx3zIjWCl2xnJbJv0F/5PVTeCoOSLm8bep96CfmfutBSU/R9P40/7zrRTPuqF8KQwFxEAVTxausDtOGRd4K2Y3AyQcobFWUX8udWzaEye9QZJAY4UGwvuB5tvj2yL/2mee6KrvdnmwCAs8ixmd7lVy1tldiYeMqyYKt3IqrbxEREkFvAWJmSBdoKYV4gHjF/WZOfv3c2z9Yx7Ku9pp150l6TpkEeF6+J2psx1sqAZu5cP34SG50fcbWL9MKHr9FKZ6QNBke5+V5HCK+IJohm/n+NxtFB+Xt37fD4LaX1jkcIunhnJA/QwpAQwSQjfFx5NrhIV9uAJZMUu8gIf4ErxwSKDM1hF2rpjZ9tY5VB8gnDEMQIqH8j524YYW7yhDdPT
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(18002099003)(22082099003)(3023799007)(921020)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261021135927099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rQ0UOjQmEw+NIO0jyTws//co1t9aUg9my5G96wRpaoY1Dhv15lEsUNdWRIaMt0x0cFt9LXHmRZECzThdWalWvVuawrx7gEClAxGjLD85gb8JH/BTQGuUbq2EBwor93lBf3JH3xf0qii7ch+NsIkWguk3zYM/CPvaEqccfb4zYF5nPhYh0H5mWuO8XPrPn+RrJ0h5b/dpHnP8lJrPYUtV+A2JuNYkKwwWXrhG6BoNYYPhvN2InVAwfJZEYIW0OpTw7EKdNxBdZvSJZzajQ05mQgiQpU8Tql60rL8PrjPbka6PGEzeG/1Gff76F+ob2f306xEoA52VBCNSiGRj6RqT8/PLUFM7jY7EruOPBzoLy0Fl76MhE02ZnknDb6yTgnB0n459867gQRksugnxYKYdXz6bS02CRx1uWL/Xg3HU7YajHdvkkDD6QX0QGGvENxeI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:01:04.7696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac44d3ce-5d73-4061-9a15-08df3bba9457
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6187.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9808
Received-SPF: pass client-ip=2a01:111:f403:c10d::3;
 envelope-from=mhonap@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Manish Honap <mhonap@nvidia.com>

fmw-index, 0 by default, selects the fixed memory window that maps the
device memory. The window must hold the whole volatile backend, allow
device-coherent memory, and have the device's pxb-cxl as its only
target. The backend size must be a nonzero multiple of 256 MiB.

The range is registered with the pxb-cxl at realize, one cxl-type2 per
pxb-cxl. The pxb-cxl commits its decoder for the range only at reset,
so a hotplugged device would find it uncommitted, and an unplugged one
could not be plugged back. The device is therefore not hotpluggable.

AI-used-for: code (prototype)
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/mem/cxl_type2.c                      | 78 +++++++++++++++++++++++++
 hw/pci-bridge/pci_expander_bridge_cxl.c |  5 ++
 include/hw/cxl/cxl_device.h             |  4 ++
 include/hw/pci/pci_bridge.h             |  1 +
 4 files changed, 88 insertions(+)

diff --git a/hw/mem/cxl_type2.c b/hw/mem/cxl_type2.c
index ab89d332dc..86fcc1a94a 100644
--- a/hw/mem/cxl_type2.c
+++ b/hw/mem/cxl_type2.c
@@ -7,9 +7,11 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_host.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pcie_port.h"
@@ -30,6 +32,7 @@ static void clean_memory(PCIDevice *pci_dev)
  */
 static bool cxl_type2_check_topology(PCIDevice *pci_dev, Error **errp)
 {
+    CXLType2Dev *ct2d = CXL_TYPE2(pci_dev);
     PCIDevice *rp = pci_get_bus(pci_dev)->parent_dev;
     PCIDevice *host = rp ? pci_get_bus(rp)->parent_dev : NULL;
 
@@ -44,9 +47,59 @@ static bool cxl_type2_check_topology(PCIDevice *pci_dev, Error **errp)
         error_setg(errp, "cxl-type2 must be at slot 0, function 0");
         return false;
     }
+
+    ct2d->pxb = PXB_CXL_DEV(host);
+    ct2d->root_port = PCIE_PORT(rp)->port;
+    return true;
+}
+
+/* fw->target_hbs is set only once machine creation is done */
+static bool cxl_type2_resolve_fmw(CXLType2Dev *ct2d, Error **errp)
+{
+    MemoryRegion *mr = host_memory_backend_get_memory(ct2d->hostvmem);
+    GSList *list = cxl_fmws_get_all_sorted();
+    CXLFixedWindow *fw = NULL;
+    unsigned int matches = 0;
+    bool ambiguous = false;
+    Object *target;
+
+    for (GSList *iter = list; iter; iter = iter->next) {
+        if (CXL_FMW(iter->data)->index == ct2d->fmw_index) {
+            fw = CXL_FMW(iter->data);
+            matches++;
+        }
+    }
+    g_slist_free(list);
+
+    if (matches != 1) {
+        error_setg(errp, "cxl-type2 fmw-index %u matched %u CFMWS windows",
+                   ct2d->fmw_index, matches);
+        return false;
+    }
+    if (fw->num_targets != 1) {
+        error_setg(errp, "cxl-type2 requires a single-target CFMWS");
+        return false;
+    }
+    if (!(fw->restrictions & CXL_FMW_DEVICE_COHERENT)) {
+        error_setg(errp, "cxl-type2 CFMWS must allow device-coherent memory");
+        return false;
+    }
+    if (memory_region_size(mr) > fw->size) {
+        error_setg(errp, "cxl-type2 volatile-memdev does not fit in its CFMWS");
+        return false;
+    }
+    target = object_resolve_path_type(fw->targets[0], TYPE_PXB_CXL_DEV,
+                                      &ambiguous);
+    if (!target || ambiguous || target != OBJECT(ct2d->pxb)) {
+        error_setg(errp, "cxl-type2 CFMWS does not target its pxb-cxl");
+        return false;
+    }
+
+    ct2d->fmw = fw;
     return true;
 }
 
+
 static bool setup_memory(PCIDevice *pci_dev, Error **errp)
 {
     CXLType2Dev *ct2d = CXL_TYPE2(pci_dev);
@@ -66,6 +119,12 @@ static bool setup_memory(PCIDevice *pci_dev, Error **errp)
                    object_get_canonical_path_component(OBJECT(ct2d->hostvmem)));
         return false;
     }
+    if (!memory_region_size(vmr) ||
+        !QEMU_IS_ALIGNED(memory_region_size(vmr), 256 * MiB)) {
+        error_setg(errp, "volatile-memdev size must be a nonzero multiple of "
+                   "256 MiB");
+        return false;
+    }
     memory_region_set_nonvolatile(vmr, false);
     memory_region_set_enabled(vmr, true);
     host_memory_backend_set_mapped(ct2d->hostvmem, true);
@@ -215,18 +274,34 @@ static void setup_cxl_regs(PCIDevice *pci_dev)
 
 static void cxl_type2_realize(PCIDevice *pci_dev, Error **errp)
 {
+    CXLType2Dev *ct2d = CXL_TYPE2(pci_dev);
+    uint64_t size;
+
     if (!cxl_type2_check_topology(pci_dev, errp) ||
         !setup_memory(pci_dev, errp)) {
         return;
     }
+    if (!cxl_type2_resolve_fmw(ct2d, errp)) {
+        clean_memory(pci_dev);
+        return;
+    }
+    size = memory_region_size(host_memory_backend_get_memory(ct2d->hostvmem));
 
     pcie_endpoint_cap_init(pci_dev, 0x80);
 
     setup_cxl_regs(pci_dev);
+
+    if (!pxb_cxl_register_firmware_hdm(ct2d->pxb, ct2d->fmw->base, size,
+                                       ct2d->root_port, errp)) {
+        clean_memory(pci_dev);
+    }
 }
 
 static void cxl_type2_exit(PCIDevice *pci_dev)
 {
+    CXLType2Dev *ct2d = CXL_TYPE2(pci_dev);
+
+    pxb_cxl_unregister_firmware_hdm(ct2d->pxb);
     cxl_fmws_direct_passthrough_remove_all(pci_dev);
     clean_memory(pci_dev);
 }
@@ -249,6 +324,7 @@ static void cxl_type2_reset(DeviceState *dev)
 static const Property cxl_type2_props[] = {
     DEFINE_PROP_LINK("volatile-memdev", CXLType2Dev, hostvmem,
                      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
+    DEFINE_PROP_UINT32("fmw-index", CXLType2Dev, fmw_index, 0),
 };
 
 static const VMStateDescription cxl_type2_vmsd = {
@@ -271,6 +347,8 @@ static void cxl_type2_class_init(ObjectClass *oc, const void *data)
     pc->revision = 1;
 
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    /* pxb-cxl commits its decoder for the device only at reset */
+    dc->hotpluggable = false;
     dc->desc = "CXL Type-2 device";
     dc->vmsd = &cxl_type2_vmsd;
     device_class_set_legacy_reset(dc, cxl_type2_reset);
diff --git a/hw/pci-bridge/pci_expander_bridge_cxl.c b/hw/pci-bridge/pci_expander_bridge_cxl.c
index 01fd479a9e..9b0444ce53 100644
--- a/hw/pci-bridge/pci_expander_bridge_cxl.c
+++ b/hw/pci-bridge/pci_expander_bridge_cxl.c
@@ -119,6 +119,11 @@ bool pxb_cxl_register_firmware_hdm(PXBCXLDev *pxb, uint64_t base,
                                 target, errp);
 }
 
+void pxb_cxl_unregister_firmware_hdm(PXBCXLDev *pxb)
+{
+    pxb->firmware_hdm = (CXLFirmwareHDM) { 0 };
+}
+
 static void pxb_cxl_dev_reset(DeviceState *dev)
 {
     PXBCXLDev *pxb = PXB_CXL_DEV(dev);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 22ca2f5978..b4a33de6e1 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -836,8 +836,12 @@ struct CXLType2Dev {
 
     /* Properties */
     HostMemoryBackend *hostvmem;
+    uint32_t fmw_index;
 
     /* State */
+    struct PXBCXLDev *pxb;
+    uint8_t root_port;
+    CXLFixedWindow *fmw;
     MemoryRegion direct_mr[CXL_HDM_DECODER_COUNT];
     CXLFixedWindow *direct_mr_fw[CXL_HDM_DECODER_COUNT];
     AddressSpace hostvmem_as;
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index d0227a4c38..106a3109c8 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -126,6 +126,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PXBCXLDev, PXB_CXL_DEV)
 bool pxb_cxl_register_firmware_hdm(PXBCXLDev *pxb, uint64_t base,
                                    uint64_t size, uint8_t target,
                                    Error **errp);
+void pxb_cxl_unregister_firmware_hdm(PXBCXLDev *pxb);
 
 int pci_bridge_ssvid_init(PCIDevice *dev, uint8_t offset,
                           uint16_t svid, uint16_t ssid,
-- 
2.53.0


