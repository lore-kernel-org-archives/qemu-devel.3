Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40722CD4F57
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHsp-0005ka-Mb; Tue, 19 May 2026 06:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHsk-0005C5-Su; Tue, 19 May 2026 06:41:03 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHse-0007Qu-GQ; Tue, 19 May 2026 06:41:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2Krd3/3oYfJffN8C13hnn+WvadK03RlntybwGfzZDdfKBwqLNeew79kgDVIspdkKrgD8xxCg+py7Y5a2a6hqIhz8C603vOxK8J55KmSpXxgT2DlvuoaecPzqqX4zHAcsDLKDBdRL7JzMBW3wAVrKj3lZiUehv6ws+ijuj2lLxklTt3XWs4V2Vif6IxM5ZVlHS7E5ITiJdxhd3ASA74Kmcykr+3QMA7bi0KvUuG5m1cE5YhpfvChMSmGH18S8iZBJcy9bXtrFHqPbmN0LP4G+7+1LgUuQsJQ+kPvWDREqlwjGeIJMANIevQx8Y4QvUd9ND7PD2agQMBSpNgshkFUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeZ+bu+V6j1ip99x3YYyHAtjX7prKsiGal4S/AoTflI=;
 b=f8XNwthcRDIgBP8mOx8eSIBB1waJzHcgTSZxPOlaHaQJeP4WhzStRCpnn2MVbGY4bpdtqguZKuaSjkA6h242tf118RL5j9i9/7AgcNySQTFdYRah45WjBbZUBRz+UBDg0gDojzaLXsK9k/6rpFqAgcCViies2FXrmzxtAagT6vqqRUc/y5WWOgKRq3uJkJ/IRt1/9s1CI5UUx5La6jJs/RMzu/htQ0P6iGbkLgbIz4fCJ5cTfmrQWuZtM4sDikJhvgGvhXOqahcDM8AqcC7aQC0yWDlgfRYye5slIkil4kPVUykOHAtvoFldHt2TtAicTz9DEi0MMiF45Un9FKKo5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeZ+bu+V6j1ip99x3YYyHAtjX7prKsiGal4S/AoTflI=;
 b=IFYsPaPOl0vDtzzBi8bG0wIvYPa3OLgHJMhss8Spo2+sgNEDB2iHiqXNKbxfsL0/920ZllNbX8JJjM36CbFELhq8PH24vPwnJgXNTzGAKRuMmzypW5buIAAm+/AUtKO1lB62oXm1+ToThfbnPmPc9f9RK7T/kpR/ozeBLILR2adt5yziuUSqhMH40D5txhlniQNzpufs4L6c8q0ALcLYcK+Gp0jIT4fFhlFa775zw+w98AwEW7eeaUjoe58MqWD6yoXryeAzmk4YuF0on71axUxxw4rxiCe4Kk7fUruN35hzAd6NmfQ9bL9C0GLQ9OxFCC9QwcsMW/J7GxNc67TLSg==
Received: from PH7PR02CA0013.namprd02.prod.outlook.com (2603:10b6:510:33d::21)
 by MW6PR12MB8662.namprd12.prod.outlook.com (2603:10b6:303:243::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 10:40:47 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::6b) by PH7PR02CA0013.outlook.office365.com
 (2603:10b6:510:33d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:40:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:40:26 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:40:22 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 30/32] hw/arm/virt-acpi: Advertise Tegra241 CMDQV nodes in
 DSDT
Date: Tue, 19 May 2026 11:37:08 +0100
Message-ID: <20260519103727.899332-31-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519103727.899332-1-skolothumtho@nvidia.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|MW6PR12MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea6190a-b184-4a8e-f2a0-08deb59315f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jFg8w+kIt2QOng/qG4Cm0rzO664gnn9CF/HD8Jre9SeIkx2gaBu2JOgBxweyi2PFwSKD/CuwuQUutIBX99f1acV96ctXy61KJ8IZukhQp6+1jwB1LhGE57bAhlAr3t4fjaD73EiqQczDPcs6+Cy7msneHR8ozyrdYQ0bjZCnygXqh0Mw9aZcdsTvXa2vCaWaVzuiPEGfXYCegf+nZVrsVcj3nomZAzuh5YlOpYOnZTTHfhicA47JnB+Q4neCq9vjdkKcz8IvlZ0XsfQfZeZQofL3qvwbKzQEmgYSXSjs6U4BqDsXP3yE0q4K47qEgXepNr6a1uySdKzzG/VPm7rT3y1HbygteSFXDfC172u2WbxOfDHDlQ5C5GXGcT1cJv3DfSNNtrZ6XsMQ8K8R+IYuNLeCl8pFMfzDOKKdLfe92SLrLFUTour/9c5whw4VyO4MhXnEV1dE1/q2jhlxmoV2fizvtn4iByXBcdu6jREKl8mfjZjNDUjihg2NLH3P0LwvDogd7qbpTc2ePm5eD1nSyG5esAPvYrMJboM+Q0rP0E0iME5ev78jg5azGjFUGuTmy+vUZW+YtMofyiIsXfPRGBddNlyld1tmIGgGjs1Css6QvRlPvp02z4iNFnjqjOxDpPnJ6WA6Z4YQYlUegpTdxIYaaDSU3PBiTYPge132FltWk4aJq+TPo3AolgDXfEh6c6Otbc0zp2pxr+uAr++0CWHj4u3kXVWK9KvV5xky6gU=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(11063799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uAAk9S59J95IOACtyDLEAVg9K1iY47OF6s7K/96Co3D2xDe0SdBYNePhm+hWdkBszy+wEYECPSqS7pzJ8ZRCcoKCvZGo2ktEoP3sPMb88PE73B6XhmEHY835tilKj5tin3eAzxLLiDyO8mgvAE5LSF66r3rlo32knex4gyMvlNGPWMwf60Wbt80g0wSRXCRhtV4VcKNmhwj3vdckKN/0dBqxGG/knslD/vJsJRbpms4b/TM5rJOYUG0qRGIMCvTNZUydP+10TPR1qx+7F64dGQQy3nLmkrzCHnHER2DNPHgRK5TGlifUbfvYIejCbX2yJCfbWrglbLIltj4s/Lh868RRUSmoRfRZTbaQ/Fuz/zDRCg5j/4aGg4CJDkkNOLroc8HtU3VPJIu2l3Q5K2xSOTIpJ9liljOktTrkigFJA+pjP35AvQ9WBewOVN+ETApF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:40:46.4805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea6190a-b184-4a8e-f2a0-08deb59315f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8662
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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
index 5ebb3dc9ea..e49a2b324d 100644
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


