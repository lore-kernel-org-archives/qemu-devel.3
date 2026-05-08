Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25879CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 18:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLQ5e-0006lZ-9g; Fri, 08 May 2026 14:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wLQ5Y-0006jj-Nt; Fri, 08 May 2026 14:38:16 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wLQ5T-0002b2-Kj; Fri, 08 May 2026 14:38:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqZq4FdQOzqMOFoVmld+5x5yfQmATNoFIcvPuIxQDb0RXN6mL1oZnnuc5YSZ829B6CxqzQ14xVCPMmk4Eu5lZTQfXhsZ4uduVQwrnzACZIxCsEt+uKBz+nXZjkKYOI2TBHXGYgfDPVa6wBSlIXaMdSmX+XQOEpX7v0wiQ1f4hGBWvMzBij6lWqPyAjDFVLb8YSTO2i6c4Ie9/0uwOxRB0sxMeey5G/E5v5Bunqyd+41CyVGsUnRgMYR/8vhgahRqW/60w+QUCHAKQEPjFDSanK02l2h+mS+i/a8zSvmu1oXYRve3BXipYDoGVW+WNuNbUTAzncSka43FpbgJgpAbjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BmZzqD5g0RjTtepjL+pk+Y22ANUW4q9Gg58vJr4ggA=;
 b=qF8FC3Y6navVIjEIw4rtZwYWnV1znESVZtk9hjzlreE9IBW1LT3QuhWw9SYoMarxXa+Frm8jUOUNkc0GEETKuPVa6GViBMeqpLzK7kAifrieFV7E6qba8sFnKMZ6YIS8hV9d22lRRMKaHSBYjUXhaKsNN1R1xiTiFvVbFYbo4coAdUyFomDz5CHzJfwopZLDgGdPXRxPjHRRKlmRinHvDCyu9wyw9vcq5t9LYXvh0ifruq6/UscZU0jEfKzVui1g+cncdBRRAxgNvYvjrNSSkRV8swNgL5y0a6XNUHMRE+XZQiy0WNvzpcwRC/9GI4gxCxGnyeZV1sS4lzoLepKUOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BmZzqD5g0RjTtepjL+pk+Y22ANUW4q9Gg58vJr4ggA=;
 b=mQtH6eN9/dvf3QPdvkbqREk9lxTSD1Cv6Jk8HssoyOkiNNV7Cvxq3n+BFCz91lmEVkoSiKayLRlUQY0VDexDaDicFybNFxF5XsM83Gkvn8y0IqW8WFHfEU0dMHYOnF1NBwI23BIeNK6jyGDwBvrirGZngOQeIHmlTwESVPeejC39sVnWJr1PQNLv9Hvuy2ioWTerrKN/EeQjmLIc5tVm1rKvZIiRBe+weAbzo74y41gyX0ypgrhXkjv3pLEp921I3YFRot1BLDggjyeGs6xNIuw1H+eGx7OZBYiQ2G3cLIgu80LzKhBRabeT4TN+MgwTwrdtC0wuaj2hDeDvwDJgzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by DM4PR12MB6205.namprd12.prod.outlook.com (2603:10b6:8:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 18:37:59 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%4]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 18:37:58 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, devel@edk2.groups.io
Subject: [RFC PATCH 8/8] hw/arm/virt: add pci-pre-enum machine property
Date: Fri,  8 May 2026 13:37:17 -0500
Message-Id: <20260508183717.193630-9-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508183717.193630-1-tdave@nvidia.com>
References: <20260508183717.193630-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:208:52d::14) To BY5PR12MB4179.namprd12.prod.outlook.com
 (2603:10b6:a03:211::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4179:EE_|DM4PR12MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 10276576-64e8-4e5f-0acc-08dead30ed16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: 1mbtS108Ad2Im9h41cs0MDVzTO84ku6mE+4M6jA03+Mzsl6vlSx5kDHb4QRMltoKeMCLDQcsf7pjtL/YUfSgcJ+x7hK9dcJSf6zmvQXsAq8nqUmeQ9nQPAEA1KFtG4wwKOPUwwz7P//biab/4qPGowJHmoc/19Oc06AqyyH5udUZiUvBs9G4/XVplddY8YxWPYrc3PnUUi9rtpvCtvDX+pSyDkD59g0T8ZdYV33LSk1/gmITQj2Z9bhLku1ww4qCbdmAEsAiLO7KZBKYfp1XhPZ+jnwUstB17yOJ21VCBGsZ7xlN31GtMIS9zlSQVvpTeywCYiq9HL/PfiHskl22/Sy0FfxVPYOA8RtdMV+6YuR45x37ldUzMUpKcjlXymTVyIl7YlO6aI93As9XtM9Miq1sKk4fay5ZkvCbLF018g6aKTAk9n3diYAsLkXQKqgxDipMcKE+C9o5WraIKr3jeVo8E6pzzJpOqZ5O/7FpnrNmvIAqYlpMTa8m6jweS+WjI19Q0vEpblOOk6N0OxUa5/PalxdJ17jdUp5jbXa3SBvx5GO4ieei6bRge71RjrIwowzYV+li0P66IFwFhKWdrq5ea2peWB1nY75hRpoQfmMnjGr55MTmT2ZN/WxJNiWb0iWpPopfcZjF8v90pgkip3T9LO4XAp97NjhiclS18+xq2M7A2QzydKXRVfOmmiZI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wUdyKEgwyAvbMyuX2X1tp+MnZi0ajBKONOrzBRgrRSBgOSmWdn0LBaYHwYsx?=
 =?us-ascii?Q?9MGteLvsqk0iOAf5skDadkfDtEXWF55FPKT3CtDsW5QRQaqZdUpT581ox+Zw?=
 =?us-ascii?Q?xgLGdYK79rdafv/sLdnZUclV0GoHdfSGvdR1rMoEJpAtJ1C4qUPa52mqqvV1?=
 =?us-ascii?Q?jofMQxUoQa0+JGdq24y5CPOSDk+RaY4EDXwt6Ipq482p5zgvELckA2dzou6N?=
 =?us-ascii?Q?QAPLH73KzrUCh3mNdUYh3dRVps9O0fPRZcjLQ4Jr597jefzRg++iMVqvHXwM?=
 =?us-ascii?Q?BAlvyLLY1l/JxqlGfn33qPpkcgr9bMcs0c3KAjArMjOtNDpAsU6+b/tdm2cM?=
 =?us-ascii?Q?TXXGNsIUyYC8TMSYIa3WHJYjoKBG4FFNNWjnxcFU3GuNxVYycLjeExSbARAT?=
 =?us-ascii?Q?BYAF089Z7k40sKk4E3Le4z7QjVYFYXjyuOhdslbXr85K7qLBy+ftbTS2BIGK?=
 =?us-ascii?Q?9bq1vn5T8qQHA3zyaPbKSiGEHEwah/y/GYHaE+KXpYZYesrrvlbCUBPHP6i5?=
 =?us-ascii?Q?jimzLrlisVqnwysXR/PZOr+E/R+wvN4Kt4cAYn6+I247pK1I2717krXv4oQG?=
 =?us-ascii?Q?YCNfG4ttdoFMRXdMNwsDPPVyaMlWkwDfGUpUAmXhOjPoHWCscreQ48FmOSEU?=
 =?us-ascii?Q?rNGKMTc1zwQalvUF41FVp+tSIGPwn7MYuATVS3uG7xNZTtlYorzyeV6dC5oa?=
 =?us-ascii?Q?xTLJDyshBqzNZekkQ/5oPSB5SIPLDOTzC+38mKKLh/x/iVZHvyLslrfqSt3U?=
 =?us-ascii?Q?JuMJxeW4veQxxAhxzcKGiUza3WrGcmtD6SPsqPpitM71oLsB5BU4mwgkhCyY?=
 =?us-ascii?Q?o1ERBhv87i/b1+YhNfjQ5WwFVER46pc2008Dbv+UfpAWWD2+zqc0FmzckMK+?=
 =?us-ascii?Q?MnFjeUTNj0icSVM2ijZtrKYaH7zTNy+1MPCdkcchNs0BPSMslR1oUmtmfsUc?=
 =?us-ascii?Q?nkr0lxNlFDARoflnHASyhq/3hioqMwwtn4amOlMuiuQmvZ8BSXsxbjYc386f?=
 =?us-ascii?Q?Mk+l4YuaOr8u/ixvgphDKvpiloLl2nfFBvLsfxD4bzB8tigkpxOYslUNvTj+?=
 =?us-ascii?Q?sCWwCFME1nAnnr3FxNOGLyqV6XTATHpkQwK85bIFB4mpec0xdadhcEl3iySK?=
 =?us-ascii?Q?8IETGbOlOce8Ph5IqYTjGGaVdoap3JTuQnWVmNLZ3Yr1HZxlmytrB98Gjo+w?=
 =?us-ascii?Q?r7Va3x33mE2Sr+j7kqVOWVP0FkimzHIWLehVWfG4sqvAuNFWiyzHElOWaeOI?=
 =?us-ascii?Q?/53TtFsO4zKTMrUDx2VVQULJhkwzOK9jtCQiq1bGuznMc7m8sUoGTvAIJz0O?=
 =?us-ascii?Q?H2th12m9JhL8bXAQnJgebhNspWAVX5fmZc1hzlu/5E9sUU7LqObmSOXWO7+9?=
 =?us-ascii?Q?6z3UZ5wb4MxY7m3HdSh+WVQ193oYpviQ/JaYzeB5jLnK0uNUR0ULYXdiYtG3?=
 =?us-ascii?Q?sf0thVwSAVkEnqqbF2RQRZx+mxYS+2me+nc+Hze90uQvrndHkdwKqZ2IAOms?=
 =?us-ascii?Q?nNEQCoZOtGo4stX6ZAlAxCSfXa46rsWHnoazATDyH4kejo/LGn49/fPsSqwA?=
 =?us-ascii?Q?wODxJQSMDzUd1YHKjz4SK1Bew6RdKYjOjuxrimJUIbETxpicWIR1t8uZalFk?=
 =?us-ascii?Q?PlHbnH1Vi31DwiXrF6j+LXuu6w/71Q0ZFlkaQwSigJHG5E1mb/n+2GYkCRlS?=
 =?us-ascii?Q?sUB+DpyOAiUBSq8yeY/F6oF8M1xFgeyxqLMuR6FlGEb7IfZVpdmi+L68B2Mu?=
 =?us-ascii?Q?CPMWKeJTJA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10276576-64e8-4e5f-0acc-08dead30ed16
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 18:37:58.2351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x79vPuThMU3c+/VYYEvq+Z3Xa++cVmi9yOjltDZ+Sj5Puyr/MlKfi7bpr6su/fn1YfN0dpxZTnrqLMTzztYuxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6205
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=tdave@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

Add a "pci-pre-enum" option for the virt machine. When enabled, QEMU
performs PCI enumeration and programs BARs before handing control to
firmware.

This is intended for use with the "fixed-bars" property, where the
user assigns fixed BAR addresses and expects firmware to preserve the
configuration.

pci-pre-enum is exposed as a separate machine property rather than
being implied by the presence of fixed-bars. This allows QEMU's PCI
enumeration path to be exercised independently (for example, to
verify that QEMU produces the same device enumeration as EDK2)
without requiring any device to specify fixed BARs.

When enabled, a "pci-enum-done" property is added to the PCI node in
the device tree to indicate to firmware (e.g. EDK2) that PCI
enumeration has already been performed.

When disabled (default), behavior is unchanged.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/arm/virt.c         | 70 +++++++++++++++++++++++++++++++++++++++++--
 include/hw/arm/virt.h |  1 +
 2 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 55f41c7e46..7d41bfc457 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -52,6 +52,7 @@
 #include "system/whpx.h"
 #include "system/qtest.h"
 #include "system/system.h"
+#include "system/reset.h"
 #include "hw/core/loader.h"
 #include "qapi/error.h"
 #include "qemu/bitops.h"
@@ -94,6 +95,8 @@
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
+#include "hw/pci/pci-resource.h"
+#include "hw/pci/pci-enumerate.h"
 
 static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
@@ -1697,6 +1700,10 @@ static void create_pcie(VirtMachineState *vms)
     qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 1);
     create_pcie_irq_map(ms, vms->gic_phandle, irq, nodename);
 
+    if (vms->pci_pre_enum) {
+        qemu_fdt_setprop_cell(ms->fdt, nodename, "pci-enum-done", 1);
+    }
+
     if (vms->iommu) {
         vms->iommu_phandle = qemu_fdt_alloc_phandle(ms->fdt);
 
@@ -1832,6 +1839,20 @@ static void virt_build_smbios(VirtMachineState *vms)
     }
 }
 
+static void virt_pci_apply_fix_bar_after_reset(void *opaque)
+{
+    VirtMachineState *vms = opaque;
+    PciFixedBarMmioParams mmio = {
+      .mmio32_base = vms->memmap[VIRT_PCIE_MMIO].base,
+      .mmio32_size = vms->memmap[VIRT_PCIE_MMIO].size,
+      .mmio64_base = vms->memmap[VIRT_HIGH_PCIE_MMIO].base,
+      .mmio64_size = vms->memmap[VIRT_HIGH_PCIE_MMIO].size,
+    };
+
+    pci_enumerate_bus(vms->bus);
+    pci_fixed_bar_allocator(vms->bus, &mmio);
+}
+
 static
 void virt_machine_done(Notifier *notifier, void *data)
 {
@@ -1864,11 +1885,30 @@ void virt_machine_done(Notifier *notifier, void *data)
     if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, ms, cpu) < 0) {
         exit(1);
     }
-
-    pci_bus_add_fw_cfg_extra_pci_roots(vms->fw_cfg, vms->bus,
-                                       &error_abort);
+    /*
+     * In pci-pre-enum mode, EDK2 does not perform PCI enumeration or
+     * resource assignment (PcdPciDisableBusEnumeration = TRUE). All root
+     * bridges are marked ResourceAssigned, meaning the topology and
+     * MMIO/MMIO64 apertures provided by QEMU are treated as final.
+     *
+     * In this mode, each root bridge is consumed as an independent resource
+     * domain. Exposing additional root bridges (e.g. PXB extra roots) that
+     * share identical MMIO/MMIO64 apertures creates duplicate resource domains
+     * with overlapping address spaces, which is invalid in this mode.
+     *
+     * Therefore, extra root bridges are not exposed in pre-enumeration mode.
+     */
+    if (!vms->pci_pre_enum) {
+        pci_bus_add_fw_cfg_extra_pci_roots(vms->fw_cfg, vms->bus,
+                                           &error_abort);
+    }
 
     virt_acpi_setup(vms);
+
+    if (vms->pci_pre_enum) {
+        qemu_register_reset(virt_pci_apply_fix_bar_after_reset, vms);
+    }
+
     virt_build_smbios(vms);
 }
 
@@ -2988,6 +3028,20 @@ static void virt_set_mte(Object *obj, bool value, Error **errp)
     vms->mte = value;
 }
 
+static bool virt_get_pci_pre_enum(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return vms->pci_pre_enum;
+}
+
+static void virt_set_pci_pre_enum(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    vms->pci_pre_enum = value;
+}
+
 static char *virt_get_gic_version(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -3726,6 +3780,13 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "in ACPI table header."
                                           "The string may be up to 8 bytes in size");
 
+    object_class_property_add_bool(oc, "pci-pre-enum",
+                                   virt_get_pci_pre_enum,
+                                   virt_set_pci_pre_enum);
+    object_class_property_set_description(oc, "pci-pre-enum",
+                                          "Set on/off to enable/disable PCI enumeration and resource assignment"
+                                          " in QEMU. When enabled, QEMU programs BARs (including fixed-bars"
+                                          " addresses) before handing control to firmware.");
 }
 
 static void virt_instance_init(Object *obj)
@@ -3768,6 +3829,9 @@ static void virt_instance_init(Object *obj)
     /* MTE is disabled by default.  */
     vms->mte = false;
 
+    /* PCI pre-enumeration disabled by default */
+    vms->pci_pre_enum = false;
+
     /* Supply kaslr-seed and rng-seed by default */
     vms->dtb_randomness = true;
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 410df857c7..0786f4a4fc 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -187,6 +187,7 @@ struct VirtMachineState {
     MemoryRegion *sysmem;
     MemoryRegion *secure_sysmem;
     bool pci_preserve_config;
+    bool pci_pre_enum;
     hwaddr override_pcie_mmio_base;
     hwaddr override_pcie_mmio_size;
 };
-- 
2.34.1


