Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991CDC5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuVA2-0006OE-S5; Thu, 13 Aug 2026 09:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wuV9u-0006Ks-F4; Thu, 13 Aug 2026 09:07:47 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wuV9s-0005Hc-RX; Thu, 13 Aug 2026 09:07:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vg6UK8fUO3BGj3c5q5jslObeMAgFWntfQkKZhnX11gsDajsB7ZIZiZWZDZiW6o7Gy11+as7uxxJqpLFHlqFtFpk5AH29/debLLQL1IcqLmr4M0s9Nj0FWsB6+ufqabixtk9fLHi9k/B4MSuc1AI+LLgThl+WtPGvVP9yroMzsYqsrwaaUzZ35WgJUGYlr7jNgtoDCdkVJ6S+sOz1RZu/x7l9ExvCzDcuRmvGcEFQ2BwPtvH64CwMlsqLnXoERQZ39mHsD7uOlZIjZSALeepT47gmeb8d6NRP+rfeVQycmpWbmLVdCYGzx3Juz5rhoRBG/vOaVJ/ayqgDHHPJ2prWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4I/ClDKmMU8jHsRzY5L/WmC6q5lyry5DadmczCJuW+Y=;
 b=K2pXbAkQssCcuiXmWti2jn6q6LC3xNb20cZg2uLwZR5Nkbju1LnrIW4cf7oxz6akxrXoXV9PgUL7vOZlBReHC9HCUslu9H5AJvxFuprg8wL5Hi6PQ9G3FHQZru/PI9f0JAEAL/YglOtmib8cSSov1CJBxRxiDXUZVa3j/KFbh7AEDmhGwwF/CDl37kCwVY5ThHpS1o6KBweC4leVMn41f7czAGDZqp5zSqq12d1H0JA3LmpJY3GI3j6zgIMoATvugETGzNV7r/k9ubQvVb9Cw+TaOBbOw0o7KCvV1Z+/c9lzY69P8NZZPFD11Lwuoy9tTESu3mzLalNuuI7HIMwIlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I/ClDKmMU8jHsRzY5L/WmC6q5lyry5DadmczCJuW+Y=;
 b=lKJhKQo0gTGw/NKOoz0DPZs/zaq9iruN3pMVzF9WMwsII8E+v0Ckf7rU5v+GlFfPNH9omWl2r21HjaSAAIiOUP7IhnZbuPLQFYh4GP86vHQm1ZyUL5T4xKfk/HO/aVweTplCpgM94/xd5bfD7eNPxjRdcE/cDg4hQBAHYihJf75COCp10UF3n7jNNdsLLGgz5s2/xHP0cIoyPRXuWRwCY3ADVBKztyNtpEoLd92ger2fiozMMrk7WhProTsWnICbrhAigsJP4EqP8Jq95UKacSuNSArsIeuhmY3qMAtgqEykb7wWo5axVb3ExBvwes/eZ7XsbGYHfv5X4pDIMFy6iQ==
Received: from MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14)
 by PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 13:07:34 +0000
Received: from BN9PR03CA0621.namprd03.prod.outlook.com (2603:10b6:408:106::26)
 by MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 13:07:33 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::39) by BN9PR03CA0621.outlook.office365.com
 (2603:10b6:408:106::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 13:07:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 13:07:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 06:07:08 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 06:07:02 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <pierrick.bouvier@oss.qualcomm.com>,
 <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <pbonzini@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <clg@redhat.com>, <cohuck@redhat.com>
CC: <kjaju@nvidia.com>, <vsethi@nvidia.com>, <zhiw@nvidia.com>,
 <mhonap@nvidia.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH 04/10] hw/vfio/pci: Enforce the passthrough topology for a CXL
 device
Date: Thu, 13 Aug 2026 18:36:17 +0530
Message-ID: <20260813130623.2499506-5-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|MW6PR12MB7087:EE_|PH7PR12MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: caf7d344-5450-4848-bc7c-08def93bd672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|82310400026|23010399003|36860700016|18002099003|22082099003|56012099006|11063799006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: T7Sihn1kDBzg4gSEdiL5T3mMTpB4UojJ4cnA6alZr+6b4lti7nGjs1o98bAdjASGZ/RttMBcrikyzj/1qfC4aMhGsg61nnDyozA6CT3PSPPMUXaTrp7Z9Po1HJuthZZh1q9FOhPiITv2IECfoWGcSEY4RkgD3kF57zUtZEZUGFknI/8qtETFejUUUm6UFXjcRT54tOkd7NbNHTl0HMNNeonHj+MVgDX2wKdCiug8ioi09i6M8U6KqW03Wb1y9UjCjL+6z3fUIE+zuB58wdbrCpxjsFZDGdyYlPH/XcKeYPX4jPAKKjfNT0XVQ5jOgcvff3QD2XPXisHv6L8MLsOML7ltjhGfY23fr/v0YUzqhzEbKewQyoO7TKj4AXdTN1gwBcdAqLQKHYtK7K9LCRzRY0SHSJp6LMxkGaWbsUHHFz/Q05hypVNxdJPLah72Mz4A0YvgP2L3Qy5n3MrHQbHe787zEWuQQitEScEe0SN6AtxnnEUjaoG99w+Jg7U7QuCfX6ARQhI4hFRqz+hM2wFU7pNLV//+CjNzxb2EHm5F3gV3rKp/jcGq1ERwycqn4bPPXVJhCBzqv3aKg6bGpi8OS15RQjOFgouk5YbxjS81pdbNKEy8lcL53Lt8PIVkYAOvPTlRkD+4Ht3uCMzo66iiBJMRn1d/YGwJIxWW8POFc/KpA4zUAhFZCkNNCYa8fhCRqH+MwU4o0Zns9JaQkmb3MCkrND2rmZiE4Rx4Z/A1/LzEW6UN/wy619w4taxFX/SK
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E4izKhoUi8WCpJfvENeTOUUAaGoGpFrMBPC8P+oFITwOmWr0+5gOXue8jPO//MtQBxzVKNv6RtCRNnj3G0Fa0/bRbuoMJdZe/SdDYQo8jD0YMI6rD0/MAknDY/yDpBA7FcuOIJITvnLRlAvQOlLlu36f/IcmTSJCL74hKrMwMvtpAucI2hGLuYCkJYK6dSnEwk0zu0+Q0/EbDs2pYJ08P4YIl+XM9/ydN368VwBoP7zCQfDmZRdWZZztYTbHlM+gSf9Y/7i9XgC+woOr+iO6MpFv07PGE/2iWYrp8mkGbsoGGqvY06SmydVbsQ0aqXZj2ceDPhaZMKLkhFHnxDt411z4xHSmptbrl0nuzwH2aEUeVh8/9uEg5N/3iun+Nn2RrF//4BlsbI62aP3tko7eWaxtmqECPbRr3sU7ROyYWObqmpoBOXJqwt/YTXec5VW8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:07:32.7516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caf7d344-5450-4848-bc7c-08def93bd672
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9175
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=mhonap@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
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

From: Manish Honap <mhonap@nvidia.com>

Only the guest's endpoint HDM decoder is programmed by the guest; the
decoders above it are covered only while the pxb-cxl host bridge stays in
passthrough mode. Reject a switch in the path, or a host bridge taken out
of passthrough, at realize before any mapping exists. The topology walk
lives in one helper so switch support later relaxes it in one place.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/vfio/pci.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 157786df72..1f21da9513 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -27,6 +27,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bridge.h"
+#include "hw/cxl/cxl.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "hw/vfio/vfio-cpr.h"
@@ -3570,6 +3571,84 @@ bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
+/*
+ * Walk the endpoint's ancestor bridges up to its pxb-cxl host bridge. A CXL
+ * switch in the path is rejected: the guest would then have to program switch
+ * decoders, which the passthrough model does not cover. This is the single
+ * place the supported-topology assumption lives, so switch support later
+ * relaxes it here.
+ */
+static PXBCXLDev *vfio_cxl_find_pxb(VFIOPCIDevice *vdev, Error **errp)
+{
+    PCIBus *bus = pci_get_bus(&vdev->parent_obj);
+
+    /*
+     * The endpoint must sit directly on a CXL root port's downstream bus. A
+     * cxl-rp carries QEMU_PCIE_CAP_CXL, so it builds a TYPE_CXL_BUS downstream
+     * bus; a generic pcie-root-port builds a TYPE_PCIE_BUS yet still counts as
+     * the single downstream port checked at bind, so without this the guest
+     * could realize a Type-2 device with no CXL root port above it: bound in
+     * appearance but unusable. The bus type is the right test here, not
+     * pci_bus_is_cxl(): the PCI_BUS_CXL flag is set only on the pxb-cxl root
+     * bus (where the root ports sit), not on the root port's downstream bus.
+     */
+    if (!object_dynamic_cast(OBJECT(bus), TYPE_CXL_BUS)) {
+        error_setg(errp,
+                   "vfio-cxl: %s: endpoint is not on a CXL root port (cxl-rp)",
+                   vdev->vbasedev.name);
+        return NULL;
+    }
+
+    for (; bus; ) {
+        PCIDevice *bridge = bus->parent_dev;
+
+        if (!bridge) {
+            break;
+        }
+        if (object_dynamic_cast(OBJECT(bridge), TYPE_CXL_USP) ||
+            object_dynamic_cast(OBJECT(bridge), TYPE_CXL_DSP)) {
+            error_setg(errp,
+                       "vfio-cxl: %s: switch-attached topology not supported",
+                       vdev->vbasedev.name);
+            return NULL;
+        }
+        if (object_dynamic_cast(OBJECT(bridge), TYPE_PXB_CXL_DEV)) {
+            return PXB_CXL_DEV(bridge);
+        }
+        if (pci_bus_is_root(bus)) {
+            break;
+        }
+        bus = pci_get_bus(bridge);
+    }
+
+    error_setg(errp, "vfio-cxl: %s: not attached below a pxb-cxl host bridge",
+               vdev->vbasedev.name);
+    return NULL;
+}
+
+/*
+ * Option I enforcement: only the guest's endpoint decoder is programmed, so
+ * the host bridge must stay in HDM passthrough mode (decoders above the
+ * endpoint are then trivially correct). Reject anything else at realize, before
+ * a mapping is built. cxl_get_hb_passthrough() reflects reset state and is not
+ * settled yet here, so gate on the static hdm_for_passthrough property.
+ */
+static bool vfio_cxl_check_topology(VFIOPCIDevice *vdev, Error **errp)
+{
+    PXBCXLDev *pxb = vfio_cxl_find_pxb(vdev, errp);
+
+    if (!pxb) {
+        return false;
+    }
+    if (pxb->hdm_for_passthrough) {
+        error_setg(errp,
+                   "vfio-cxl: %s: the pxb-cxl must be in HDM passthrough mode "
+                   "(do not set hdm_for_passthrough)", vdev->vbasedev.name);
+        return false;
+    }
+    return true;
+}
+
 /*
  * Learn the CXL geometry the kernel reports: the HPA-backed HDM memory region
  * and the trapped HDM decoder block (which BAR carries it and at what offset).
@@ -3619,6 +3698,11 @@ static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
     cxl->dpa_size = mem_info->size;
     cxl->comp_bar = cap->bar;
     cxl->hdm_offset = cap->offset;
+
+    if (!vfio_cxl_check_topology(vdev, errp)) {
+        return false;
+    }
+
     cxl->enabled = true;
 
     return true;
-- 
2.25.1


