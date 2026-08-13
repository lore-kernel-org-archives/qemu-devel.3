Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4B3C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuVAb-0006Y4-Nx; Thu, 13 Aug 2026 09:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wuVAY-0006Ss-4W; Thu, 13 Aug 2026 09:08:26 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wuVAT-0005Rl-VN; Thu, 13 Aug 2026 09:08:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVFw0+HaeQYPOVoccC70f7kK3SAcKfm2Bf3BChVb9X9oZEDgjAyW1hKcu30k4gM7YftZTBzZuKj6y0qbyQgh9O7DfdofBCX0+LDxR0UKjW+F0LDmNIV1nU5fQhZZwyaH9NUDUezR8MNo5Na7IVLwlG4q2jhiybILgYssdOTl3rf6j4ZVA3CtON424YdTpdfoNDwSMDEzgEU6LU3O7Zm+gImYpqGj9z/yUXwNUfxG7eYzB6w1SgNrkP+/v9IsfaAh0veFNf1RnRSuNXsTB2HbXoEemSTGqXGhi73787RyUKRDykiiKhzz/gs/KcQ2bqeR2pPFWeS5SEYxpCwUnDvmQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FvIKcb+MYAelhMutav1XB/AV9ekizN7pGUNHpWVnXg=;
 b=Q18UN8GB5Wh/UmRlVivxHYGDUIoSehL9uOqM/M3A6vogAVV6GaWO/oYNLBBZyywyhBU0ePi/OW25Deu0CBHfZEUu2ihH7yosUsipRCOtzwXjEPupDxZKYOYl1SGsFWHW+XsGbYZCt25AM/dUtf3BOE0LwUENJPDL7upp8YN0ZOhOvCmnCptt6ChMNPeoA6o8YvK1NNFK+E2aXRGTDsepNCMMwwjEkCy/nYFeDP4wpU0RloJQm9CBAUtSAfFFehr5jxLfdcTOAPkffCTCVx3bas4hlYYANGmc99zTe5iPB9UUlXQ9NTwr3de6vCsy7AwPTF/LwDXe9SO0Wz596QEl2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FvIKcb+MYAelhMutav1XB/AV9ekizN7pGUNHpWVnXg=;
 b=BM3x4B3kMkwqZfTP3RJpYW7NT7KoJfvvsmjgVoEmhBPvpF7tCulPFFVUJPP30Ar6bi8wDauDN+uTJCU5fV844ZU5RWZhO4GbNv2M5xZk5AVKTvTDL1o/XQCNPhBWnQoNoa55wEr8gRKbFQbypXj4FgCCefzp4fQ1QOSJLlX1xLGnVvhwpfNvXD6QD8mhykfexk9rwAdriyLPDtah4Q4EIdKTFVzIfYArb9e1R5xV7Gp/daas0+j16M6Feff0QB/nl4g7ScajIvFZSTQwvZa/aFJ4cwSx382QzFxP8PVVX2kAkUBoyoFeXt27qKfb9m60qt75Lr03eDZlBrdU9WtShw==
Received: from SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17)
 by IA1PR12MB9467.namprd12.prod.outlook.com (2603:10b6:208:594::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Thu, 13 Aug
 2026 13:08:13 +0000
Received: from BN1PR14CA0016.namprd14.prod.outlook.com (2603:10b6:408:e3::21)
 by SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 13:08:12 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::5d) by BN1PR14CA0016.outlook.office365.com
 (2603:10b6:408:e3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 13:08:12 +0000
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
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 13:08:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 06:07:46 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 06:07:40 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <pierrick.bouvier@oss.qualcomm.com>,
 <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <pbonzini@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <clg@redhat.com>, <cohuck@redhat.com>
CC: <kjaju@nvidia.com>, <vsethi@nvidia.com>, <zhiw@nvidia.com>,
 <mhonap@nvidia.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH 10/10] hw/pci-host: Emit a _DSM on pxb-cxl to preserve
 firmware PCI config
Date: Thu, 13 Aug 2026 18:36:23 +0530
Message-ID: <20260813130623.2499506-11-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SA3PR12MB7858:EE_|IA1PR12MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2f990e-0828-41e0-5642-08def93bedc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|7416014|56012099006|10067099003|11063799006|6133799003|18002099003|3023799007|921020|22082099003;
X-Microsoft-Antispam-Message-Info: yxuz5JTjVoYWVOyrs0CiNxiifJafZHpujpyj5rzR8+mfH3nQ8U3upZoLJ3zhr+XP7Zdo493pM4RN8XmJMuCDT5/Yr2uxfaJ7pvc+UqD9MXlt95mAAr50OM/ESAfIDdadHYXmOhd/FrLs0rX94CAl3emvPcMIb1wpGJC133Jao9fj2b9wx0vbhS3su6BgvaOu+Rt1+0mgbvm7TLraZEwm2Lwu8IXgGf7tg8SN2nY8IHiBT6XkPJnkhz+uMdgj5rmVx40VyW9Hl4DAHL1EoPt+tDuZ0H5I2Wa+ssziI9JCs9MQHxDF/q0Nucwk0FymggKWqjx1ZAvf9MZJUvj9khD+9m0wjopbsxeCAr/LsMQXbnMvzzOLKp9AJzIXlvTVTMwrRY6YaLodiR5Gu80AvYx//7fJkG+FWsBoj8K3ETqXfi8AHrLyK6C6OB5wmjwXIADi2km3OsVJGdKaEP+OqibvHtW7CfVGxTSiHXfm5ZXj0VdzTJUDeOkXrljwZqnY1g9WvL7ZKtLdit/8uoqgQSh9a9UFRWXnnQLBLsT0N7LGbK1jWVNR+KLT407KnJ9qjOmy/jlp2/GRTaZcB6pGBf6wFFkqFPW5eWK8Vzju0dHzMFSAxHa1SQfvkKXUt7BMy3phQ4m9+i4v3vzQDa70qeR/it7nCrEK56XLrP5ZOlxUHmOQ3NPdut0cTTc79EsriTjSfJNaEky0JkJYkcgRqTuZ60yWBvgrTRpmoISyg2nf3n0P8zAKB/xa0MHF36YV/Lq9
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(7416014)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(3023799007)(921020)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oCkDStG2NSwdCAn4bQ6lviYB5M4qlj/M9eD+++Depuh5jvF95NFYVnduVySFhq2qaZ1Tr2FcbdQy0Rq458Gh8ni0QKmnu1thbIZd6NC+TB8u3QPopskpF6OKn/9hEPrDfW6NFTwsbEb005jqXnnz+xhlinl6cFBLr5VqDy5G99RKTE18ReSsoUoCg0JH41GU0zsHK+qE9ajpDYaOO9+YPpVpLwq8dI/46o//EfIGcDu/5xRZKseqnW1WPUImIcubBS0IMGkpF/etPSAb/scMgfMnQ2tfft4lRf12cs8oRzT1LP0bTTAFR9vN06cgfopR1XW1j2mNc/fFrtbSpG+Yte0Ktv/aVcU5pv8cp6jI2gVf4vtxp2w8Vw2P9xx25ENXyXHr+3GCpm1zSg/j+AufWZJtXrjT/Qrqgwq2DNmN9AbijkQaCpVurv+xpZjiVh2O
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:08:11.9557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2f990e-0828-41e0-5642-08def93bedc8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9467
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=mhonap@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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

A pxb-cxl host bridge had no PCI host-bridge _DSM method, so it could not
emit function 5 (preserve firmware PCI configuration) even when the
machine asks OSPM to keep the firmware resource assignments.

That preservation is required by the accelerated SMMUv3 (accel=on), which
describes MSI 1:1 mappings through IORT RMR nodes. An RMR reserves a fixed
IOVA range, so OSPM must not re-enumerate and reassign the PCI resources
underneath it. virt sets pci_preserve_config for that case and expects
every host bridge to emit the _DSM; the pxb-cxl bridge was the one that
did not, so a CXL topology under an accelerated SMMU lost the guarantee.

This is not about the component register BAR moving. vfio-pci marks every
BAR dword ALL_VIRT, so a guest BAR write updates the virtual config only
and cannot move the host resource, and QEMU's trapped comp-regs region is
a subregion of the BAR MemoryRegion, so it follows any guest-visible
relocation while the kernel's physical decoder mapping stays fixed. The
CXL.mem window is delivered through CEDT/CFMWS and is likewise unaffected
by PCI resource assignment.

Wire preserve_config through GPEXConfig into the CXL host bridge OSC path
so pxb-cxl bridges emit the _DSM function 5. Rename build_cxl_osc_method()
to acpi_dsdt_add_cxl_host_bridge_methods() to match the pxb-pcie analogue
acpi_dsdt_add_host_bridge_methods(), since it now appends both the _OSC
and the _DSM. x86 passes false as it does not use the accelerated SMMU.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/acpi/Kconfig         |  1 +
 hw/acpi/cxl-stub.c      |  2 +-
 hw/acpi/cxl.c           |  4 +++-
 hw/acpi/pci.c           | 40 +++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c    |  2 +-
 hw/pci-host/gpex-acpi.c | 42 ++---------------------------------------
 include/hw/acpi/cxl.h   |  2 +-
 include/hw/acpi/pci.h   |  1 +
 8 files changed, 50 insertions(+), 44 deletions(-)

diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index daabbe6cd1..9490b75c94 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -88,3 +88,4 @@ config ACPI_ERST
 config ACPI_CXL
     bool
     depends on ACPI
+    select ACPI_PCI
diff --git a/hw/acpi/cxl-stub.c b/hw/acpi/cxl-stub.c
index 15bc21076b..d7c6731975 100644
--- a/hw/acpi/cxl-stub.c
+++ b/hw/acpi/cxl-stub.c
@@ -6,7 +6,7 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/cxl.h"
 
-void build_cxl_osc_method(Aml *dev)
+void acpi_dsdt_add_cxl_host_bridge_methods(Aml *dev, bool preserve_config)
 {
     g_assert_not_reached();
 }
diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index f92f7fa3d5..7607ba500f 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -23,6 +23,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
+#include "hw/acpi/pci.h"
 #include "hw/mem/memory-device.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
@@ -320,11 +321,12 @@ static Aml *__build_cxl_osc_method(void)
     return method;
 }
 
-void build_cxl_osc_method(Aml *dev)
+void acpi_dsdt_add_cxl_host_bridge_methods(Aml *dev, bool preserve_config)
 {
     aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
     aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
     aml_append(dev, aml_name_decl("SUPC", aml_int(0)));
     aml_append(dev, aml_name_decl("CTRC", aml_int(0)));
     aml_append(dev, __build_cxl_osc_method());
+    aml_append(dev, build_pci_host_bridge_dsm_method(preserve_config));
 }
diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index 8c7ed10479..1a20f8469b 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -351,3 +351,43 @@ Aml *build_pci_host_bridge_osc_method(bool enable_native_pcie_hotplug)
     aml_append(method, aml_return(aml_arg(3)));
     return method;
 }
+
+Aml *build_pci_host_bridge_dsm_method(bool preserve_config)
+{
+    Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
+    Aml *UUID, *ifctx, *ifctx1, *buf;
+    uint8_t byte_list[1] = {0};
+
+    /*
+     * PCI Firmware Specification 3.0
+     * 4.6.1. _DSM for PCI Express Slot Information
+     * The UUID in _DSM in this context is
+     * {E5C937D0-3553-4D7A-9117-EA4D19C3434D}
+     */
+    UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
+    ifctx = aml_if(aml_equal(aml_arg(0), UUID));
+    ifctx1 = aml_if(aml_equal(aml_arg(2), aml_int(0)));
+    if (preserve_config) {
+        /* support functions other than 0, specifically function 5 */
+        byte_list[0] = 0x21;
+    }
+    buf = aml_buffer(1, byte_list);
+    aml_append(ifctx1, aml_return(buf));
+    aml_append(ifctx, ifctx1);
+    if (preserve_config) {
+        Aml *ifctx2 = aml_if(aml_equal(aml_arg(2), aml_int(5)));
+        /*
+         * 0 - The operating system must not ignore the PCI configuration that
+         *     firmware has done at boot time.
+         */
+        aml_append(ifctx2, aml_return(aml_int(0)));
+        aml_append(ifctx, ifctx2);
+    }
+
+    aml_append(method, ifctx);
+
+    byte_list[0] = 0;
+    buf = aml_buffer(1, byte_list);
+    aml_append(method, aml_return(buf));
+    return method;
+}
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 8837b69687..a24bff8c88 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1019,7 +1019,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                 aml_append(aml_pkg, aml_eisaid("PNP0A08"));
                 aml_append(aml_pkg, aml_eisaid("PNP0A03"));
                 aml_append(dev, aml_name_decl("_CID", aml_pkg));
-                build_cxl_osc_method(dev);
+                acpi_dsdt_add_cxl_host_bridge_methods(dev, false);
             } else if (pci_bus_is_express(bus)) {
                 aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
                 aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index d9820f9b41..014f647c7f 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -51,45 +51,6 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
     }
 }
 
-static Aml *build_pci_host_bridge_dsm_method(bool preserve_config)
-{
-    Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
-    Aml *UUID, *ifctx, *ifctx1, *buf;
-    uint8_t byte_list[1] = {0};
-
-    /* PCI Firmware Specification 3.0
-     * 4.6.1. _DSM for PCI Express Slot Information
-     * The UUID in _DSM in this context is
-     * {E5C937D0-3553-4D7A-9117-EA4D19C3434D}
-     */
-    UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
-    ifctx = aml_if(aml_equal(aml_arg(0), UUID));
-    ifctx1 = aml_if(aml_equal(aml_arg(2), aml_int(0)));
-    if (preserve_config) {
-        /* support functions other than 0, specifically function 5 */
-        byte_list[0] = 0x21;
-    }
-    buf = aml_buffer(1, byte_list);
-    aml_append(ifctx1, aml_return(buf));
-    aml_append(ifctx, ifctx1);
-    if (preserve_config) {
-        Aml *ifctx2 = aml_if(aml_equal(aml_arg(2), aml_int(5)));
-        /*
-         * 0 - The operating system must not ignore the PCI configuration that
-         *     firmware has done at boot time.
-         */
-        aml_append(ifctx2, aml_return(aml_int(0)));
-        aml_append(ifctx, ifctx2);
-    }
-
-    aml_append(method, ifctx);
-
-    byte_list[0] = 0;
-    buf = aml_buffer(1, byte_list);
-    aml_append(method, aml_return(buf));
-    return method;
-}
-
 static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
                                               bool enable_native_pcie_hotplug,
                                               bool preserve_config)
@@ -164,7 +125,8 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
             aml_append(dev, aml_name_decl("_CRS", crs));
 
             if (is_cxl) {
-                build_cxl_osc_method(dev);
+                acpi_dsdt_add_cxl_host_bridge_methods(dev,
+                                                      cfg->preserve_config);
             } else {
                 /* pxb bridges do not have ACPI PCI Hot-plug enabled */
                 acpi_dsdt_add_host_bridge_methods(dev, true,
diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
index 8f22c71530..6fe6c9c58d 100644
--- a/include/hw/acpi/cxl.h
+++ b/include/hw/acpi/cxl.h
@@ -24,7 +24,7 @@
 void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
                     BIOSLinker *linker, const char *oem_id,
                     const char *oem_table_id, CXLState *cxl_state);
-void build_cxl_osc_method(Aml *dev);
+void acpi_dsdt_add_cxl_host_bridge_methods(Aml *dev, bool preserve_config);
 void build_cxl_dsm_method(Aml *dev);
 
 #endif
diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
index 20b672575f..c7de33f8cf 100644
--- a/include/hw/acpi/pci.h
+++ b/include/hw/acpi/pci.h
@@ -42,6 +42,7 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
 void build_srat_generic_affinity_structures(GArray *table_data);
 
 Aml *build_pci_host_bridge_osc_method(bool enable_native_pcie_hotplug);
+Aml *build_pci_host_bridge_dsm_method(bool preserve_config);
 Aml *build_pci_bridge_edsm(void);
 
 #endif
-- 
2.25.1


