Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EE3FF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHS5Q-00036N-Fk; Mon, 27 Apr 2026 15:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wHQTC-000315-9a; Mon, 27 Apr 2026 14:14:10 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wHQTA-0008PG-6v; Mon, 27 Apr 2026 14:14:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIssOOCU9HzRnhpZuSJyTg7FSdSLmjruduAVCE9YGqjyecyAXqxO1sHCupeJxYoqunp98c+ikIGKIQdehllg9K47qjJphoYdCVtxZ5J9rks6w4EQpHVpy43G3OQFtWDxefbuq4nogFblHk/tPvw09C+1gFPiZDY4F+5m+C8C4R57ThUkOpj09LG4Ld9oxya24f5D8Duj7/NN2cH2SjNSXkTr9nXnVbdJGkYUsFgMqRQ+V5JS1kK3jLQUrkbbgZhHPw+Z8cImItHKQCDeymrzwayQMa/802Oo3gU2wm4/z0k7jHD3ctptUIop/EKRKx/hAdVj2xecZiTe5lSq20+YUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bidn193Oht8bhQ0vdKcMskvY3KUFqDkTfYzkndt+Xng=;
 b=nRUaGxI7jLv65wquJcQvZcT3bMSaY7gCjUqdke1EX9vUNXt2lEPESEb2COw45cLjSsnUiEWW4I+WzeBMCau5fD5LCAt9ytG11d3yIqlVeeTnJrascDVqx6DmsnVwhEyR1HLEByaGOppzuCQcVejwLRMrwxHP2dU3UUt2MHlYReTpMq5y6OLdfzzWbl/TyzBznOpin0oX8ntbbDaONEU7lXNpMs8adasZSp2ehuTc72LGPViVvkjTU8nzD17mw+jDoSFjbNNcRuIXeIt25DPceOB2arWlTF0oNeEyyx+RWy13Tp+y4S+/F5aFfNEHWivEZMa2VY9RGP6k66Q3DgSiUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bidn193Oht8bhQ0vdKcMskvY3KUFqDkTfYzkndt+Xng=;
 b=hTprHfwTeYSO2CB9i9iCGjSo92ku8xKEgdeZgqajae9IBM26TkqaePvioMV5fbH1FjmDmAxMkWBqrX5yMsnJbRvLPx6oRWxgZB4jSqeIwqoU52Iq/qIuqJ2BuANO/JDpAHRDbougFOUgzN4ZnSN1Zd52WbiJdDhMAuUKH5O1sti2o8Y3EsGLol9l83fA1WcjBsczUA7ub/JEkbkJZNIWrL+CbFXGzco/Ll57q448nsrs1BzOvGlRSoIJu5AE7XQdLjTzZlC2PpCqDx7XZpEcjznMaQMEt8qZZ08dIbAaMvakcoC7cEZanH+J6NEaRopvxrzCd9ugZzIx9lV5d0rscA==
Received: from BN9PR03CA0553.namprd03.prod.outlook.com (2603:10b6:408:138::18)
 by DM4PR12MB6229.namprd12.prod.outlook.com (2603:10b6:8:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Mon, 27 Apr
 2026 18:13:50 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:138:cafe::f0) by BN9PR03CA0553.outlook.office365.com
 (2603:10b6:408:138::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 18:13:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 18:13:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 11:13:27 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Apr 2026 11:13:19 -0700
From: <mhonap@nvidia.com>
To: <alwilliamson@nvidia.com>, <skolothumtho@nvidia.com>, <ankita@nvidia.com>, 
 <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <shannon.zhaosl@gmail.com>, <jonathan.cameron@huawei.com>,
 <fan.ni@samsung.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <marcel.apfelbaum@gmail.com>, <clg@redhat.com>, <cohuck@redhat.com>,
 <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
 <alejandro.lucero-palau@amd.com>
CC: <vsethi@nvidia.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
 <zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-cxl@vger.kernel.org>,
 <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 "Manish Honap" <mhonap@nvidia.com>
Subject: [RFC 1/9] hw/arm/virt: Add CXL FMWS PA window for device memory
Date: Mon, 27 Apr 2026 23:42:27 +0530
Message-ID: <20260427181235.3003865-2-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260427181235.3003865-1-mhonap@nvidia.com>
References: <20260427181235.3003865-1-mhonap@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DM4PR12MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1ee2ec-6984-44ca-19ba-08dea488bb7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: SVknWT/3uAAlsmkynRoGUNwMyxgs55b9FT7lezcfEAQG8cIeUsoSoB8rC1ZlrgXghqUvl8lS3FDxa1ArXx2iS01oaaHJ15v9oNfadqb22D20MeAYbDSZTlwxKGO2/IS+0/hw/mjho/IFI1lQtGlY3q9GuVtikXCxkWqMlgMEYBOjWX2d5Ws/2Eqq7EemR0vA40qQD/3z6zlV1EyK6k+XrHiuYNWyceOx3E2yMY89cBP8Ig3bZ65sYzv9LpolZfPPw9tZQrIrFi5fXqAsU5LbTMP9uThqC5dD1ZNYtUJI4EnTVxM8hBE+yg6ToHfANoYP3sOkR1VERgY2lhe2uws/c5jFCmpKV5zLhkxMQt/Jh2OTdDpzM3vlBO+AOoUoUI1t1mFHW5EAPSl6KNuP+iPGW2V0xI7i0q3cySsRnY8em31IDIE+kX+6rYzzTG3GR8ezQa8g0s9lbNJaZnEcWS9XQKMf+FjNbt7cPaopH6ctiItwmT+Ynz5JJWDua/IATh7Sl1oNNqqNLRk/sy+gAk6NYL9wwyrEOA5HxEXdjJnCzHa5Xoy++Gah861ifFBrsg/yzjIpNjChWZSxLPglkwXl2+fGfmQZOkJXJRuy4a2fBOBNmed3uCNeurOcQXAnXS/e7XXPOY3xVj9J+o0NXbBIaCWlUYrSlhB2hzDvBe/fc2KPUWA8f+s1FPta4ATO8YbF//YuyC4QA2mvCbbtLNAU6qVz5LxI3qqOogVDm0z+HwRPJEtmD9/ChU0X1XyivOsX2NBpnsz7PPLuWhhjy4TpWEAXttM3O0o0qxI+62CUv3zGnJUVG27L8Z/JckfZc7oq
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dGOv429AZwZ4tkxxxKTsZynBZqmVSO5CdSKp4pYEnu9JLm8GwMrLifTbAEXsgRVPWLe2/1jxIGKFQ+banTfa4OhVpeMCOOZ+UvahXa/8hxTmlm/foxK11IZLQ4EjO9OCpDzlySQER4luMYPqzGcMWr3fPbdFNSJ2qwH2kWKYAfyShBu42XepeKKB0bvT1Zosqg+VLLYiWSG1kO0ySCieZt56LFzsvRsui0dub2RXKJl+R9cMj6cTHP9UMVPxBH7qHeNpYqqkZcToimrVdWN1GN7xr37Cs/eDj46lwk3xJu1gE1/1Fv42m3RXcQ+wYcVwi3d2TyORV51ijrfHMsE0e23f/7mm3QPyQCshNIQPD/w4Elcf3EnVH2B0MqdopcIRCwqFtbLi1/rElAojoNGZSl9bdqOo9f9O4GddDZiTja1HP11Y+GNCofW9GuwTG1Hi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 18:13:49.9247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1ee2ec-6984-44ca-19ba-08dea488bb7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6229
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=mhonap@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 27 Apr 2026 15:57:41 -0400
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

CXL VFIO passthrough needs a stable guest physical address range for
device memory (DPA) that falls inside a CFMWS entry the guest discovers
from ACPI CEDT. Without a dedicated range in the address map, the HDM
decoder has nowhere to point.

Add VIRT_HIGH_CXL_MMIO immediately after the second PCIe MMIO window.
It gets its own highmem_cxl_mmio flag in VirtMachineState rather than
sharing highmem_cxl, so the two slots are independently controllable
even though both are currently tied to CXL bridge presence.

The base and size flow through GPEXConfig.cxl_mmio to
acpi_dsdt_add_gpex(), which carves out a QWord memory descriptor in the
first CXL root bridge's _CRS. The CFMWS window is system-wide, so only
the first CXL bridge gets the descriptor - subsequent ones would
produce duplicate resource claims for the same range.

build_crs() already emits the bridge's own 64-bit ranges into crs.
The CFMWS window is a separate system-wide range, so only that window
is appended as a new QWord descriptor; the bridge ranges are not
re-emitted. A warn_report() fires if the CFMWS window overlaps any
existing bridge 64-bit range, since that would indicate an address
layout conflict.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/arm/virt-acpi-build.c   |  5 +++++
 hw/arm/virt.c              |  9 +++++++++
 hw/pci-host/gpex-acpi.c    | 40 ++++++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h      |  2 ++
 include/hw/pci-host/gpex.h |  1 +
 5 files changed, 57 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 591cfc993c..863e0680fb 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -176,6 +176,11 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
         cfg.mmio64 = memmap[VIRT_HIGH_PCIE_MMIO];
     }
 
+    if (vms->highmem_cxl) {
+        cfg.cxl_mmio.base = memmap[VIRT_HIGH_CXL_MMIO].base;
+        cfg.cxl_mmio.size = memmap[VIRT_HIGH_CXL_MMIO].size;
+    }
+
     acpi_dsdt_add_gpex(scope, &cfg);
     QLIST_FOREACH(bus, &vms->bus->child, sibling) {
         if (pci_bus_is_cxl(bus)) {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ec0d8475ca..fa07819401 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -211,6 +211,8 @@ static const MemMapEntry base_memmap[] = {
 #define DEFAULT_HIGH_PCIE_MMIO_SIZE_GB 512
 #define DEFAULT_HIGH_PCIE_MMIO_SIZE (DEFAULT_HIGH_PCIE_MMIO_SIZE_GB * GiB)
 
+#define DEFAULT_HIGH_CXL_MMIO_SIZE  DEFAULT_HIGH_PCIE_MMIO_SIZE
+
 /*
  * Highmem IO Regions: This memory map is floating, located after the RAM.
  * Each MemMapEntry base (GPA) will be dynamically computed, depending on the
@@ -237,6 +239,11 @@ static MemMapEntry extended_memmap[] = {
     [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
     /* Second PCIe window */
     [VIRT_HIGH_PCIE_MMIO] =     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE },
+    /*
+     * CXL FMWS guest PA window - separate from PCIe MMIO so the two are
+     * independently sizeable. Same default size for now.
+     */
+    [VIRT_HIGH_CXL_MMIO] =      { 0x0, DEFAULT_HIGH_CXL_MMIO_SIZE },
     /* Any CXL Fixed memory windows come here */
 };
 
@@ -1724,6 +1731,7 @@ static void create_cxl_host_reg_region(VirtMachineState *vms)
                        vms->memmap[VIRT_CXL_HOST].size);
     memory_region_add_subregion(sysmem, vms->memmap[VIRT_CXL_HOST].base, mr);
     vms->highmem_cxl = true;
+    vms->highmem_cxl_mmio = true;
 }
 
 static void create_platform_bus(VirtMachineState *vms)
@@ -1897,6 +1905,7 @@ static inline bool *virt_get_high_memmap_enabled(VirtMachineState *vms,
         &vms->highmem_cxl,
         &vms->highmem_ecam,
         &vms->highmem_mmio,
+        &vms->highmem_cxl_mmio,
     };
 
     assert(ARRAY_SIZE(extended_memmap) - VIRT_LOWMEMMAP_LAST ==
diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index d9820f9b41..7de57bbc46 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -7,6 +7,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/acpi/cxl.h"
+#include "qemu/error-report.h"
 
 static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
                                           Aml *scope, uint8_t bus_num)
@@ -108,6 +109,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
     CrsRangeSet crs_range_set;
     CrsRangeEntry *entry;
     int i;
+    bool first_cxl = true;
 
     /* start to construct the tables for pxb */
     crs_range_set_init(&crs_range_set);
@@ -161,6 +163,44 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
              */
             crs = build_crs(PCI_HOST_BRIDGE(BUS(bus)->parent), &crs_range_set,
                             cfg->pio.base, 0, 0, 0);
+            if (is_cxl && first_cxl && cfg->cxl_mmio.size) {
+                uint64_t cfmws_end = cfg->cxl_mmio.base +
+                                     cfg->cxl_mmio.size - 1;
+
+                /*
+                 * The CXL Fixed Memory Window (CFMWS) is a system-wide GPA
+                 * range.  Only the first CXL root bridge emits the QWord
+                 * descriptor; adding it to every bridge would give the OS
+                 * duplicate resource claims for the same range.
+                 *
+                 * build_crs() has already appended the bridge's own 64-bit
+                 * ranges into crs.  Do not copy them again here; only append
+                 * the CFMWS window itself as a new QWord descriptor.
+                 *
+                 * Warn if the CFMWS window overlaps any range already claimed
+                 * by the bridge; in the current address layout they should be
+                 * disjoint, but catch it early if the layout ever changes.
+                 */
+                for (i = 0; i < crs_range_set.mem_64bit_ranges->len; i++) {
+                    entry = g_ptr_array_index(crs_range_set.mem_64bit_ranges,
+                                              i);
+                    if (entry->base <= cfmws_end &&
+                        entry->limit >= cfg->cxl_mmio.base) {
+                        warn_report("CXL CFMWS [0x%"PRIx64"-0x%"PRIx64"] "
+                                    "overlaps CXL root bridge 64-bit range "
+                                    "[0x%"PRIx64"-0x%"PRIx64"]",
+                                    cfg->cxl_mmio.base, cfmws_end,
+                                    entry->base, entry->limit);
+                    }
+                }
+                aml_append(crs,
+                    aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED,
+                        AML_MAX_FIXED, AML_NON_CACHEABLE, AML_READ_WRITE,
+                        0x0000, cfg->cxl_mmio.base, cfmws_end, 0x0000,
+                        cfg->cxl_mmio.size));
+                first_cxl = false;
+            }
+
             aml_append(dev, aml_name_decl("_CRS", crs));
 
             if (is_cxl) {
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 5fcbd1c76f..88bb3c0bdf 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -91,6 +91,7 @@ enum {
     VIRT_CXL_HOST,
     VIRT_HIGH_PCIE_ECAM,
     VIRT_HIGH_PCIE_MMIO,
+    VIRT_HIGH_CXL_MMIO,
 };
 
 typedef enum VirtIOMMUType {
@@ -147,6 +148,7 @@ struct VirtMachineState {
     bool highmem;
     bool highmem_compact;
     bool highmem_cxl;
+    bool highmem_cxl_mmio;  /* VIRT_HIGH_CXL_MMIO window; follows highmem_cxl */
     bool highmem_ecam;
     bool highmem_mmio;
     bool highmem_redists;
diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
index 1da9c85bce..a7c2e2edf3 100644
--- a/include/hw/pci-host/gpex.h
+++ b/include/hw/pci-host/gpex.h
@@ -43,6 +43,7 @@ struct GPEXConfig {
     MemMapEntry mmio32;
     MemMapEntry mmio64;
     MemMapEntry pio;
+    MemMapEntry cxl_mmio;
     int         irq;
     PCIBus      *bus;
     bool        pci_native_hotplug;
-- 
2.25.1


