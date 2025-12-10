Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B930D3C90A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKQI-000834-1E; Wed, 10 Dec 2025 08:40:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPq-0007cY-3r; Wed, 10 Dec 2025 08:39:38 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPn-0001SG-Kv; Wed, 10 Dec 2025 08:39:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmK0FlGLEy4Yj+EQd1MslrA7Bz93eU8/2ZOqi/DF4k/z6zPxlaAO2+PBAn3sF2ygMDAVURB+0pJbXfRbt7wz0biIwy2j/UMcXITImHET+Q7oOvAH6bEuT0lHx8Irhliyak/+i2Nr76NKbPHuRHcsjml6vjuB9Fq0Rnr95FzxL5+JDUf0oXWLVZ55/MNWlO3eiz+2L7SXYRyn4bJxS0kRIkL22F/WgFmxETa+7GBmT6YA80j2Itp6BQwZbNUgMqel2l6riDTxXj0lJWtvN6tus3Y2WfgOq4Z8StWqDV03U8NfPaUHaATbRUKCZVzw+BC97ZIkVUF5TiiULymy0NVmQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uny+WV+qVKmWtHgnUlgx7gOya3GUysz2P/C8LtBCYc=;
 b=l5EiuuEvJ1RWGvkqCB2KkzzXPpWJNUGhZ096fwDeIQNrx/mHsUG4ytDCdge96D0FL2fPDbmQxQWJVYQ1lk7alt3F62nR1tf177EMrUdYFqx8JaWbIoAc5P4k89XoqXlBSNFC1THcyHzsKVxKwiEsz2auNpiB5wzhP/5CEZSow+ipGw/3SSl/RH5AMc+D/YTtsdkFrrOgwlJlJaz7oGKOModSjewxMXiaCuzQ/iKiMUqc3ouvnmhleM7glJ+7Ch5Ed9a4Q5Gu9+K2vv+p1zMqH/JQmG5LTCHVsFvtpOfM2YcN+pnXVHE43k0bdloapZVNvmjfwjgYF3egqxYFjM2g4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uny+WV+qVKmWtHgnUlgx7gOya3GUysz2P/C8LtBCYc=;
 b=c/jjFN9SVXXwilAhsQKMtYjmFllPlJaZcLjxHjSmiT83Ii1GWU0yRPA6zy8KKFeQXbdG//CyVQzs6GAq9RrTEYdYGW/zLVAQ1CQTiXCKrPfhk0V+UU1b8fovK+wrPI3+P7ULhYZKQ+u/Xljdf2sE5KfvMPPmF9L7050sj7LS98Vz1mcaWYyLxt+COTkqQhWbtAHvZ0k7pHv7UP8FyWwoyH6umNptGgaUhTn76LFyk3WisWMzLlmrIuqTa0aRd4oE1Kzk8QDevCOmLPtUU2A2cdQVpB885fgZ8CU7E53sGlr68oGlQazkTEvHhvIEa88qH5jF49anbwNZOJRFf4YRLg==
Received: from SJ2PR07CA0016.namprd07.prod.outlook.com (2603:10b6:a03:505::16)
 by DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.7; Wed, 10 Dec 2025 13:39:28 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::c6) by SJ2PR07CA0016.outlook.office365.com
 (2603:10b6:a03:505::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 13:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 10 Dec 2025 13:39:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:39:13 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:39:10 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 15/16] hw/arm/virt-acpi: Advertise Tegra241 CMDQV nodes in
 DSDT
Date: Wed, 10 Dec 2025 13:37:36 +0000
Message-ID: <20251210133737.78257-16-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210133737.78257-1-skolothumtho@nvidia.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|DS7PR12MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: b164e070-91dd-4ed5-3eb4-08de37f18aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xw5c49GS98i61/ot1VUNngj5BOxMFO5ppYmNn16mS7Opr2G0JiE9VYU5KTiv?=
 =?us-ascii?Q?0Pi+dTCsSNdMw8yNly8EQWwsvRFfleti6OYliYzjvsU0Rf0bGbhr2E3gRpy/?=
 =?us-ascii?Q?gOI/PkPAM5XVyNbPvIvcQNAwUU/022A005IgXEIkivM4V3QHr3710RpEq+ge?=
 =?us-ascii?Q?4qyZdhQUH96SMUPDyZcVxzNbhjjO5n51x7I6qWSIDgzpDHOPW8jXPQP8GjMl?=
 =?us-ascii?Q?OYnfpBJahNTT+5QULxNlbT2Tj5T5u3qDVaSuz59ay4XT43zmMfSNTup5puzf?=
 =?us-ascii?Q?uufhOMMgMfaqrHo0VoEGfE95bS4n5TXymt0uYwl3TBjjkoH8xaRW4ieU9R4O?=
 =?us-ascii?Q?XbgF/r6g9TQmxw8so7TwyCt4om5Qi5XA0eb7PHcJhHIVn49u9Vqe7ygtL+ET?=
 =?us-ascii?Q?N97jtv8rKFPkRAZ22s0ZdkCFYiXz/k6wE4mqMhZxjIj+n8FLreuiGspZfM2e?=
 =?us-ascii?Q?frT+VK0znY6QmJmcjE8lXXQo3Aq4PnzD8U4rqB9xbF/3qLgCEEPWOAautjVi?=
 =?us-ascii?Q?l7PCQfk3PBI0r0EBXApt3UJEzSr1PNz5xODbqxQ330DlNmTXmg3dVtqjljoA?=
 =?us-ascii?Q?CeR+x2lMHjLFDSHugva8g0VYGpZk5RdarMYfCDz3Le9Qqsx9oKUeJGtvh1AG?=
 =?us-ascii?Q?NkfbIkL/363NQCiDDN+k7g4xLHbA3LBobipLpQp2j/p/1dTVFma06Wj6Kgql?=
 =?us-ascii?Q?C8tsshhqA3uY2ZtehDdH3iKI5oCg6TR9DmS9KgzSACFOLVoF0yQ5o7A7WqcF?=
 =?us-ascii?Q?9Oqe7N4LGwN15d0YffRE5Se3TQZEorLaGKnb7mnG0Pn+FPIdDzjttiVDu2t9?=
 =?us-ascii?Q?qR/7HKSkKm73dtA+aK1uJ12ZymShD+M/KN4an5bAxToDmGDy3oBZdcd3N/F9?=
 =?us-ascii?Q?5TJNwTYaNcb9Zorr8ojNSbxTQnFCK5jVG6hokTuANwZ4FA685M9upTSx6ZiH?=
 =?us-ascii?Q?ziJXFTcBKRiFRiJVgJFAFrcQDdFNU0Q7cSj+K9mAKrrW2yW57Ceon9vQV9bb?=
 =?us-ascii?Q?CEniWr8kJ9unZdfW1gaW6nZ54Hr+eXLtiDyzLVympbg764jF6rWXFfFJReRo?=
 =?us-ascii?Q?0MPoTxKR++5L26/6XFVeXCeGP0UfhpAyZZy8uL5N2DBjUzl/kCI9uaqWirTC?=
 =?us-ascii?Q?RQqaXcfLGYyCk7RFlfInD+oiaWmf6ZKeXrD67MUV5h+pcMJv70MxITnMOZO1?=
 =?us-ascii?Q?wCFQw4F33tF6ykH8a8jvi/+Rcg4njEVX/cOXVLRyAo0bck0pOOS3/T0tnAL1?=
 =?us-ascii?Q?JP/OFhKtKJ7oCbAd65qIOQkJYLK6SKhplKuLFe7dxolJgGIBbHC89uFSjjKS?=
 =?us-ascii?Q?SzUu3RBK+qCHLKkl8pnyqWAYtCB0O0iO0nclOlP53TCK5eH2UsgUBIIdoEIv?=
 =?us-ascii?Q?cotDlpbQ1c20lybVTjKb7eBfucH8Awjktzu7xiDPT9EzVsiyYggSN8jS0rQJ?=
 =?us-ascii?Q?H/nCXM6sYrAxGUVE1yvhMPmTcvOMKoPNsUQBA9NIn2lfzTwl++3HOdpSQelC?=
 =?us-ascii?Q?OldTntGNU23vNaXcal4sY7HSQan5e76MtPFyo6PATxEyGdRkMMEWvd13MvCF?=
 =?us-ascii?Q?7VCCNV96dsz8VfbmnDc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 13:39:28.6299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b164e070-91dd-4ed5-3eb4-08de37f18aba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324
Received-SPF: softfail client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
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
created with tegra241-cmdqv=on.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/trace-events      |  1 +
 hw/arm/virt-acpi-build.c | 74 ++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h    |  2 ++
 3 files changed, 77 insertions(+)

diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index ef495c040c..e7e3ccfe9f 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -9,6 +9,7 @@ omap1_lpg_led(const char *onoff) "omap1 LPG: LED is %s"
 
 # virt-acpi-build.c
 virt_acpi_setup(void) "No fw cfg or ACPI disabled. Bailing out."
+virt_acpi_dsdt_tegra241_cmdqv(int smmu_id, uint64_t base, uint32_t irq) "DSDT: add cmdqv node for (id=%d), base=0x%" PRIx64 ", irq=%d"
 
 # smmu-common.c
 smmu_add_mr(const char *name) "%s"
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 4f8d36dae0..11494b29ad 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1115,6 +1115,78 @@ static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
     build_fadt(table_data, linker, &fadt, vms->oem_id, vms->oem_table_id);
 }
 
+static int smmuv3_cmdqv_devices(Object *obj, void *opaque)
+{
+    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
+    GArray *sdev_blob = opaque;
+    PlatformBusDevice *pbus;
+    AcpiSMMUv3Dev sdev;
+    SysBusDevice *sbdev;
+
+    if (!object_dynamic_cast(obj, TYPE_ARM_SMMUV3)) {
+        return 0;
+    }
+
+    if (!object_property_get_bool(obj, "tegra241-cmdqv", NULL)) {
+        return 0;
+    }
+
+    pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
+    sbdev = SYS_BUS_DEVICE(obj);
+    sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 1);
+    sdev.base += vms->memmap[VIRT_PLATFORM_BUS].base;
+    sdev.irq = platform_bus_get_irqn(pbus, sbdev, NUM_SMMU_IRQS);
+    sdev.irq += vms->irqmap[VIRT_PLATFORM_BUS];
+    sdev.irq += ARM_SPI_BASE;
+    g_array_append_val(sdev_blob, sdev);
+    return 0;
+}
+
+static void acpi_dsdt_add_tegra241_cmdqv(Aml *scope, VirtMachineState *vms)
+{
+    GArray *smmuv3_devs = g_array_new(false, true, sizeof(AcpiSMMUv3Dev));
+    int i;
+
+    if (vms->legacy_smmuv3_present) {
+        return;
+    }
+
+    object_child_foreach_recursive(object_get_root(), smmuv3_cmdqv_devices,
+                                   smmuv3_devs);
+
+    for (i = 0; i < smmuv3_devs->len; i++) {
+        uint32_t identifier = i;
+        AcpiSMMUv3Dev *sdev;
+        Aml *dev, *crs, *addr;
+
+        sdev = &g_array_index(smmuv3_devs, AcpiSMMUv3Dev, i);
+
+        dev = aml_device("CV%.02u", identifier);
+        aml_append(dev, aml_name_decl("_HID", aml_string("NVDA200C")));
+        if (vms->its) {
+            identifier++;
+        }
+        aml_append(dev, aml_name_decl("_UID", aml_int(identifier)));
+        aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
+
+        crs = aml_resource_template();
+        addr = aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
+                                AML_CACHEABLE, AML_READ_WRITE, 0x0, sdev->base,
+                                sdev->base + TEGRA241_CMDQV_IO_LEN - 0x1, 0x0,
+                                TEGRA241_CMDQV_IO_LEN);
+        aml_append(crs, addr);
+        aml_append(crs, aml_interrupt(AML_CONSUMER, AML_EDGE,
+                                      AML_ACTIVE_HIGH, AML_EXCLUSIVE,
+                                      (uint32_t *)&sdev->irq, 1));
+        aml_append(dev, aml_name_decl("_CRS", crs));
+
+        aml_append(scope, dev);
+
+        trace_virt_acpi_dsdt_tegra241_cmdqv(identifier, sdev->base, sdev->irq);
+    }
+    g_array_free(smmuv3_devs, true);
+}
+
 /* DSDT */
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
@@ -1179,6 +1251,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_dsdt_add_tpm(scope, vms);
 #endif
 
+    acpi_dsdt_add_tegra241_cmdqv(scope, vms);
+
     aml_append(dsdt, scope);
 
     pci0_scope = aml_scope("\\_SB.PCI0");
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index efbc1758c5..842143cc85 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -46,6 +46,8 @@
 #define NUM_VIRTIO_TRANSPORTS 32
 #define NUM_SMMU_IRQS          4
 
+#define TEGRA241_CMDQV_IO_LEN 0x50000
+
 /* See Linux kernel arch/arm64/include/asm/pvclock-abi.h */
 #define PVTIME_SIZE_PER_CPU 64
 
-- 
2.43.0


