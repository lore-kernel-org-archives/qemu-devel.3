Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1615CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudo-0002Uo-9R; Tue, 09 Jun 2026 07:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudh-0001jN-41; Tue, 09 Jun 2026 07:29:01 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWude-0003zC-S9; Tue, 09 Jun 2026 07:29:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKcit1OuyZtjg88f22fG9Zk6TUwnwZCCUPDuojTlosVfmB5DzieJmUxFbgsCj51hO3Niie5ueQ40f0bHN/bb+52w6cWMlMm5IBKJIM8aPVJ7O1TV0wNSjyRoRl1hObB/gEXKuJVF/RIv1tebMi7SI/h/d2XBuomBCE9dZXEmQpj2xnUIQgWzwpJed6liXaTPQuhOKtrlwpZi9BnB3Avr7iLrYv2VCgc1Xj7TCmFtWF53DjQsGxyGrg3LLwBdxMuiBHXchWzAIivCejY3g8Tb+LSXn44gg9x2w8ASzufKzGL2H0jMYq9b8RhR/PHm6NT2Wd5GQI5PN+P8ywLmWLpinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEZljZCrRvxEYCBoTUjlZqJJ5VcgScpBkOMLPydnedI=;
 b=Lewwhc+gxIFgZJZMxD63YNPmqD75lRfvP6KaOnjm1+yumBB5uI/IMZNECRjP6aMhNwKmcokElGX+sOHNnjQ/dE78ppQ99vqZy9Rm8Vu2+0DN582OAXlAiXkIfAzlZq1XfmJWBv2fl7+1p05FbQycgrGVjcbIec4SouzBEBmSOm68AXjNqt/AdYDoH2Z4eIygaOYXPOFRYHf/sveOAYhIwNf4zGw8X4ZwHht29pk7bNM6stMAVuy2G9auAgytBkBGDG7DL8YL4qpCfKa7+mNtO/URlv4zxZaeVuHpHUkde63EGmblQY4a3TsHul4saSZGiEf+N5dsCVphU3ncP4GJXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEZljZCrRvxEYCBoTUjlZqJJ5VcgScpBkOMLPydnedI=;
 b=ZZ+LEl+nr7ma4vB8mvRCzpM6GeDXQdOHFebyrbBXxwcDN0tUx+0dtEyHXmDhffiknbWlsJ42Xc2m+zqHb0hof6DOeciMb3XZ7Jbgmpl2p3np81bNWn3Nlt5pGMDBrHPZ7CZ+JE6QCvph+w2Mol/KuWzR+o8dLOtJwrd10yB2hYfxtygxYgjwysm6WTkzjcDZkP4UJhCHo3UhNzoPr2wGDQqr6wZtzqd8G7JznUj4El9mtLgTeT+773hWqjl4fnKCyWRmgPoSpn8P/dTCjou9N7O/guAwximn1LHnhfKYU8Dlx13sNy0XgHC7ZXT/fi6w3rtJ6ezup/Y5rS37feyQFA==
Received: from SJ0PR03CA0280.namprd03.prod.outlook.com (2603:10b6:a03:39e::15)
 by CH1PR12MB9575.namprd12.prod.outlook.com (2603:10b6:610:2ad::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 11:28:50 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:39e:cafe::5b) by SJ0PR03CA0280.outlook.office365.com
 (2603:10b6:a03:39e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:28:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:28:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:37 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:33 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 28/31] hw/arm/virt-acpi: Advertise Tegra241 CMDQV nodes in
 DSDT
Date: Tue, 9 Jun 2026 12:25:49 +0100
Message-ID: <20260609112552.378999-29-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|CH1PR12MB9575:EE_
X-MS-Office365-Filtering-Correlation-Id: c45550a3-2ba3-49cd-4490-08dec61a4776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 2hp3uWEnp7iIGyZOFfkSPyZpU43ztsLx62YVK1gHxgIvYpNC//FzYfVCW54krs7iICjNLSG9ulfOCmxHMtdtYQTGJASsoAvlCEQfRzEl+T8o67BOpkHLVG+eGAIj1TsEooO85Qev2Q7JHA0TKMoHIKeHXtpfUms525ST1nPPQ2qn5Ii8cWPnuHbE8nUXoJ5sKpU8TbaKFNVPpbHVcKBiEugAlelzsFWhKMwgY8lHvFEUlAz0dyihGTv18YF1cjNo0z4eXV+XiEyALfbThgZricDA1P9rWU98gL+je/LLcOfmKVRXMfXnzrmARcEv5b2c/6No7muqWWaDYo1PrLQzbFDaQ4znZhAYuKUSq77foZ0aaTtjsCI/W4iKdPOz3EE4H9X/6YVLFiHGm8lbz9OIfHmkpGUKu0xKMWkieMKXDfi+y8RKK5FbVg/E7/FJQAK/fe8DydkTbwGeTaeYFAvUPRdnhZBQiYY8IhO2zt6uCpjnx8EF9NT37I41qq/M+J/zlWcX7pGHajX0feSP8foRKpsNhffCbcSuVW/qprLTpIYD+8r5yJvNlsOGSmiR0Wp9G8f3PbzRvcnRfvlYtnvJERnSMezIgecnQcC11Z9zOVtQjr3i93siZ4PJ9rd6NtyWiSeJiwcMuj+ZeuDP1jGr0hqq1P0nt6U4wHK5I4Z69qtrUPQ7/V6bC8TGnaAFsxdhF/COmGAywsjY3AdMo+GjZtmj6edjPoe1VdkJeBHvbss=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hwdS06LjoyMMcD0K/cqkx6txOikp6Am8x8Gj4eMNjL7kBvFguevrL1LQsYqlzVUUeJhTutM8NEvtiXNHB219NMZdY8SlRMB0SLkIB6vuZExk2zc7UxE578AQvGwM0rcQy7CGRUrFiHKfA5TJ9AGn0gZlcl2B4FBYgDCVqE1PuGj/6Qouf+5gWtDDyagXbzLSC6n6CDyEWnVDTCN80gG09V6ejLm4db/i/nmyNmaGU+j3bEwU1yex9zEUjOdGXv2ooe4TSw6RB5s+uwtADjWuXA9nFVvF761gRd/lXAM3EDDDGfqH5BM6G83L7Wx+zcoeJx0b4xo/1pWcj8cGBeHskGpfvk9Lz7zhCGfcH/uWqOIvqbXctq1ZJnd1NXwrFSZGPGSS43zeQAEtRVhbcAsE50qe8A0Nyk90TCclwznah/HJkOlHh1aBmnU9IbbWs65e
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:28:50.2807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c45550a3-2ba3-49cd-4490-08dec61a4776
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9575
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

Add ACPI DSDT support for Tegra241 CMDQV when the SMMUv3 instance is
created with tegra241-cmdqv.

For each accelerated SMMUv3 instance, add a Tegra241 CMDQV device
object under the DSDT \_SB namespace, with HID "NVDA200C" and a UID
that matches the Identifier of the corresponding SMMUv3 IORT node, so
the guest OS can associate the DSDT device with the right SMMU. The
_CRS covers the CMDQV MMIO aperture plus its interrupt, and _CCA
declares I/O cache coherency.

See ACPI Specification 6.5, Section 6 (Device Configuration) for
_HID/_UID/_CCA/_CRS.

Generated DSDT entry for a CMDQV instance paired with SMMUv3 Identifier=1:
  ...
  Device (CV01)
  {
      Name (_HID, "NVDA200C")  // _HID: Hardware ID
      Name (_UID, One)  // _UID: Unique ID
      Name (_CCA, One)  // _CCA: Cache Coherency Attribute
      Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
      {
          QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
              0x0000000000000000, // Granularity
              0x000000000C080000, // Range Minimum
              0x000000000C0CFFFF, // Range Maximum
              0x0000000000000000, // Translation Offset
              0x0000000000050000, // Length
              ,, , AddressRangeMemory, TypeStatic)
          Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
          {
              0x00000094,
          }
      })
  }
  ...
Generated IORT SMMUv3 node (Identifier = 1):

  ...
  [048h 0072 001h]                        Type : 04
  [049h 0073 002h]                      Length : 0058
  [04Bh 0075 001h]                    Revision : 04
  [04Ch 0076 004h]                  Identifier : 00000001
  [050h 0080 004h]               Mapping Count : 00000001
  [054h 0084 004h]              Mapping Offset : 00000044
  ...

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 52 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events      |  1 +
 2 files changed, 53 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9d05982137..99490aa7b1 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -65,6 +65,9 @@
 #include "target/arm/cpu.h"
 #include "target/arm/multiprocessing.h"
 
+#include "smmuv3-accel.h"
+#include "tegra241-cmdqv.h"
+
 #define ARM_SPI_BASE 32
 
 #define ACPI_BUILD_TABLE_SIZE             0x20000
@@ -1121,6 +1124,51 @@ static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
     build_fadt(table_data, linker, &fadt, vms->oem_id, vms->oem_table_id);
 }
 
+static void acpi_dsdt_add_tegra241_cmdqv(Aml *scope, VirtMachineState *vms)
+{
+    for (int i = 0; i < vms->smmuv3_devices->len; i++) {
+        Object *obj = OBJECT(g_ptr_array_index(vms->smmuv3_devices, i));
+        PlatformBusDevice *pbus;
+        Aml *dev, *crs, *addr;
+        SysBusDevice *sbdev;
+        hwaddr base;
+        uint32_t id;
+        int irq;
+
+        if (smmuv3_accel_cmdqv_type(obj) != SMMUV3_CMDQV_TEGRA241) {
+            continue;
+        }
+        id = object_property_get_uint(obj, "identifier", &error_abort);
+        pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
+        sbdev = SYS_BUS_DEVICE(obj);
+        base = platform_bus_get_mmio_addr(pbus, sbdev, 1);
+        base += vms->memmap[VIRT_PLATFORM_BUS].base;
+        irq = platform_bus_get_irqn(pbus, sbdev, NUM_SMMU_IRQS);
+        irq += vms->irqmap[VIRT_PLATFORM_BUS];
+        irq += ARM_SPI_BASE;
+
+        dev = aml_device("CV%.02u", id);
+        aml_append(dev, aml_name_decl("_HID", aml_string("NVDA200C")));
+        aml_append(dev, aml_name_decl("_UID", aml_int(id)));
+        aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
+
+        crs = aml_resource_template();
+        addr = aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
+                                AML_CACHEABLE, AML_READ_WRITE, 0x0, base,
+                                base + TEGRA241_CMDQV_IO_LEN - 0x1, 0x0,
+                                TEGRA241_CMDQV_IO_LEN);
+        aml_append(crs, addr);
+        aml_append(crs, aml_interrupt(AML_CONSUMER, AML_EDGE,
+                                      AML_ACTIVE_HIGH, AML_EXCLUSIVE,
+                                      (uint32_t *)&irq, 1));
+        aml_append(dev, aml_name_decl("_CRS", crs));
+
+        aml_append(scope, dev);
+
+        trace_virt_acpi_dsdt_tegra241_cmdqv(id, base, irq);
+    }
+}
+
 /* DSDT */
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
@@ -1185,6 +1233,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_dsdt_add_tpm(scope, vms);
 #endif
 
+    if (!vms->legacy_smmuv3_present) {
+        acpi_dsdt_add_tegra241_cmdqv(scope, vms);
+    }
+
     aml_append(dsdt, scope);
 
     pci0_scope = aml_scope("\\_SB.PCI0");
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 0bd718b1ab..1b16f710fe 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -9,6 +9,7 @@ omap1_lpg_led(const char *onoff) "omap1 LPG: LED is %s"
 
 # virt-acpi-build.c
 virt_acpi_setup(void) "No fw cfg or ACPI disabled. Bailing out."
+virt_acpi_dsdt_tegra241_cmdqv(int smmu_id, uint64_t base, uint32_t irq) "DSDT: add cmdqv node for (id=%d), base=0x%" PRIx64 ", irq=%d"
 
 # smmu-common.c
 smmu_add_mr(const char *name) "%s"
-- 
2.43.0


