Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825B0EE20A6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNCX-0004Wq-V7; Fri, 06 Feb 2026 09:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAr-0001LN-D4; Fri, 06 Feb 2026 09:51:12 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAn-0007XB-TK; Fri, 06 Feb 2026 09:51:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wnn8K53GOV+0WvT/ed2/nxnah/BsHlODzv1m9lc/M/+lynafEIDOxb9LTGJfYEJ2zRh6EsScGD0SNIpviCPOiB96oG6p6JCw0sdoTR7s86g8ZIU/nQ5ixj+F45F0+y1FmtTF7LNBOhQYbwbIxqMDe2gsdHpub4ogCTQq7qvy3MU1jaAACJUBenVmXjk7BO97EcT2eCjZdXt6sFU0JhDsyDrmYkUvBYxFYL1FxBl0FE5CZ4ZC+kpVjBXeneGicMj8YO6PEXrTrXdkit6FQuPDp76UVwVUL+BAqiFMV8CNKDFR/m5Q7VCnIrm7P8eH/KjCtVBTC3uGQ9PwXHixsUL5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxEvi2yIM5TRWsx7QAo0u+6KQiTsfOsc1NQg/VQKAQw=;
 b=pzzRnlfVD0eC+yEQNtQarctW5s65h3HPu5FHizpBiCsEKBIxf+67e4IuXC4iC84XNB0PZm8A3LazeIJ7XUMOru9j/S+604TiqPCZ9++StGoiINXq8lSpuwMsybwKN3irrBtWOO11nLbxkpm3AcBLiaNR5FF6j6K//NQmp+VwDJcqHzqx+y0Qh+5LjLhWEooHMSYmoSFW1Oc/rXZT1Z1ZCkrSJ4TX8hZ++kN/fJaBnpWG5jcxj8GkH+XjLqyh/FbAJMiNKq2tM8spMnEPV8m6T88OUfExomyqEdZRYbxQQEi0hvziapq2tQrSsiWbSDkx7e185hGTk4swidhjJs+oGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxEvi2yIM5TRWsx7QAo0u+6KQiTsfOsc1NQg/VQKAQw=;
 b=ErkSx2La5sMfcUqlU8p3tx8PlyniXr4Pb0lSqa02ikl5LM63yjFqLoX+mg/YMNbdhrC0aWAeD28Nuur19yzuehRjeTQjKrGpelklq19R2nY/QSKhgzrwxG0zZ2Ljxd0F/LEsXh5Ep10OelQlePl/cSYdNtQ3vHneDGhZtE6ZTV3iSTmD3cXouJCDPRvW22iU2IZolbAhZmJviVNSKJ2ru+Q6x1OTV0tJmqL8QppxBFBDbZqTfUsuYGQOGEGF4Nb5FMww2hLnPImc0K34I6THKx0st9uBD74A2QadBpq5IilToHmRJnlD46DwFnPNOtN96cj/7DkxbaLiXAJB5vPQ1g==
Received: from CYZPR12CA0009.namprd12.prod.outlook.com (2603:10b6:930:8b::24)
 by BY5PR12MB4323.namprd12.prod.outlook.com (2603:10b6:a03:211::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 14:50:59 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:8b:cafe::3d) by CYZPR12CA0009.outlook.office365.com
 (2603:10b6:930:8b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 14:50:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:50:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:50:34 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:50:30 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 22/24] hw/arm/smmuv3: Add per-device identifier poroperty
Date: Fri, 6 Feb 2026 14:48:21 +0000
Message-ID: <20260206144823.80655-23-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206144823.80655-1-skolothumtho@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|BY5PR12MB4323:EE_
X-MS-Office365-Filtering-Correlation-Id: b6539242-c052-4f55-875c-08de658f2450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VtRLgUMqcDd6q8eHU42/4gOXBenvNT118KB8doIog36UygzwBjg4HfXnIWUN?=
 =?us-ascii?Q?g1ZqAikKIc5QMLlpx9fYTGBZTyk7xqqGEnV/JqDkkHt3AEaKY1KlI+DfvuCI?=
 =?us-ascii?Q?49qUhqaGCrqtQtxhYZQnxuOsbxDyAcsT2CsCokXr3rpUtOZji22P7Paf2HOm?=
 =?us-ascii?Q?TkqDYdhqPy5eg/xGFBmgjnTSOCt6P4ANTLKW2EvqvXGPV2nOFVmqZbaxDeM8?=
 =?us-ascii?Q?ivbP7jL3+A2kVJmcB0vDm95Ie/7m1ZaOjTSw8kPMhN/MLWI6rCrWGx6HebeB?=
 =?us-ascii?Q?QZffDol+nkMO90frhqusCBlpipcSyRh3zA7byZnA7Gbon320hnqXUAprWfc/?=
 =?us-ascii?Q?gy7F43sWxmnhpfEuMlQNc54+lezh+oAeBcCXvUhqbxujvpMmUXEWk+K2RB9O?=
 =?us-ascii?Q?LmCodsnwJUWU5gMTCgo/5xeYPM5cNXp1MlixvRd+JLvQEaWmvjcFG7i1yQEN?=
 =?us-ascii?Q?wyPLcKopB+XxUrdzXo+Us7oDF+BUBIbtB8qWIKO2gr9bmRr89vRIH9dWgFlA?=
 =?us-ascii?Q?T5DJvh0zvAOtFWxaNLcy2h4CfBoNtihwsXVVjCN4n4TSxYFDR5SRU52JS2AF?=
 =?us-ascii?Q?zHkFocxdenSQ++GgcFk+PID/tN4em40TvJLMTtU0g5aXH4npHnXAIUaJtgOh?=
 =?us-ascii?Q?PQGvG8yS8GHdw/AWJZBIQk/+Zc+ErjlXsK3FdsH5EsB1rPzZk9MBHXN9Um4f?=
 =?us-ascii?Q?eYNVzpVqLNnRw9FzNPbkZ2nskMJ4cf9e1j1EWZXGlMWC2f3wm8vH8yACqW5i?=
 =?us-ascii?Q?bYxMtlWU+6bQCIF55Z4KTvw/vyUYYruiheUNz8BZxuiRBWGVV74U41Rc0NH5?=
 =?us-ascii?Q?0nPg6h7SAFLT4ouC0eRScDlw07MC0oQ8PXjSgC0ecqWSGcqC5L6TfR4nbFn3?=
 =?us-ascii?Q?Z1G8SrnMU+S9RTPb/0MFenM2v9mmkJ6fJCVAPHFFJfuGzTUV+CKJ/20lvrJU?=
 =?us-ascii?Q?l7/HwBJyo4Q5NARDw8cGy0WnOQKkJZN+Qpvs31w05uIE/KQ/RRYSQAAlslJp?=
 =?us-ascii?Q?znUnXCy7H+/XVavXxCkHVEuepIepVIhMmfTGgph1SEgIYPrdJMCFpbweIQkZ?=
 =?us-ascii?Q?rOhHpElk+fBeX0fkCE4j780ZIU6mwlpqYqD/Q7Bbi0uzHj8+pnp0rO8jkAwN?=
 =?us-ascii?Q?hqMzUWDy0xu+akUPmyIaK4AoD2fU9AmBPXpepZbAeTGyY8HXdTby7D9gWr9g?=
 =?us-ascii?Q?svn+6D7IYoKSaYGLaJu5FrL697r5gFlP3W0txhpLOpNrnpz4JML24keQhpJ6?=
 =?us-ascii?Q?oZN8VkkAtva20URxCLqmLNMz/PbXI8rvZD24Gb2P6dAN/rpJ5o4U2D5qazSG?=
 =?us-ascii?Q?qi3uiBzD8ulZkUZWKsDtZwfdP2WhKf3SUfA75ooQ64El4elpFVilRuo8CYmI?=
 =?us-ascii?Q?txVDuAWZ4RkbQXLZq+LscyQhr/xdGfacRhuiSStFful0MRMrnHlAQhHZkit+?=
 =?us-ascii?Q?UnRMSjFHup5hvzfcczqeYkeKI2xU+dC+y4xF+sVuRwPH5U7SXwNGvkQAloNa?=
 =?us-ascii?Q?3PidLI/sdwO+Lz3+aq4eMBo4PU2/Z7MtRIIsZjOkXuV41XAD6jkB6/FvLZET?=
 =?us-ascii?Q?z3PjjUuqSDYgaBfTOfOy8QKMCtrg/83H5KBKXWLP8w1ecdirvzDi28zZgsTH?=
 =?us-ascii?Q?BgTpyRol/3x2Ljoz4COYLwXPc+XNhZ0rRHdnr3Ez8AMO3E6H9EC0ZOFDF3AQ?=
 =?us-ascii?Q?SPpJTg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WJVdgIiIjC1Whez8qUSiOhcY7xw1OM11Z7ri92yxbcnx7xorrOcVuY7cK7kMjjNVTw232nrJNZ2s+h7CKH7nEsZxG5jpFsDrp0fg6ucLR7OZIvlQPKQLCR7obwg8neIzdlgmK6LvWQK29CJOUzZb5dk9oknei0zEWrjbvRavwPIY8/EV8TD7bAXCpVURaTZmY4/jV0vBIVZ14KOzdNzWweR9zKEvB+tIGBHq54YzmUHkeCBIuSZq3svCVHl0Gc7Nw+Q+yu0uhVRWglt7flYj+uTm/wHXeygrTkYAulXie2UbnSUnPLegei5iAXanc77FpePNfKJ6jbHEV8HwC8jy0EdZOjzPlNDYcuOcCosUo/9pVeOWpFZuivtukZKqdzdrrFdRNaRhh0PtlN30Clf9Gd8v/dfnkz1w80WNCI+mcNsFJrcHsTqgQYYVPNfd60cL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:50:59.6100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6539242-c052-4f55-875c-08de658f2450
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4323
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add an "identifier" property to the SMMUv3 device and use it when
building the ACPI IORT SMMUv3 node Identifier field.

This avoids relying on enumeration order and provides a stable
per-device identifier. This is useful when we add support for
Tegra241 CMDQV DSDT in subsequent patch.

No functional change intended.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c          | 1 +
 hw/arm/virt-acpi-build.c | 4 +++-
 hw/arm/virt.c            | 3 +++
 include/hw/arm/smmuv3.h  | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 7858bf2c33..7f84c87a46 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2114,6 +2114,7 @@ static const Property smmuv3_properties[] = {
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
+    DEFINE_PROP_UINT8("identifier", SMMUv3State, identifier, 0),
     DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index ae3b4aac52..046e930ca5 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -342,6 +342,7 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
 typedef struct AcpiSMMUv3Dev {
     int irq;
     hwaddr base;
+    uint8_t id;
 
     /*
      * IORT-only fields.
@@ -407,6 +408,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
     bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
     sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
     sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
+    sdev.id = object_property_get_uint(obj, "identifier", &error_abort);
     pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
     sbdev = SYS_BUS_DEVICE(obj);
     sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
@@ -642,7 +644,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                      (ID_MAPPING_ENTRY_SIZE * smmu_mapping_count);
         build_append_int_noprefix(table_data, node_size, 2); /* Length */
         build_append_int_noprefix(table_data, 4, 1); /* Revision */
-        build_append_int_noprefix(table_data, id++, 4); /* Identifier */
+        build_append_int_noprefix(table_data, sdev->id, 4); /* Identifier */
         /* Number of ID mappings */
         build_append_int_noprefix(table_data, smmu_mapping_count, 4);
         /* Reference to ID Array */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 390845c503..22ee5c4a41 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3059,12 +3059,15 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                        (vms->legacy_smmuv3_present) ?
                        "iommu=smmuv3" : "virtio-iommu");
         } else if (vms->iommu == VIRT_IOMMU_NONE) {
+            static uint8_t id;
+
             /* The new SMMUv3 device is specific to the PCI bus */
             object_property_set_bool(OBJECT(dev), "smmu_per_bus", true, NULL);
             object_property_set_link(OBJECT(dev), "memory",
                                      OBJECT(vms->sysmem), NULL);
             object_property_set_link(OBJECT(dev), "secure-memory",
                                      OBJECT(vms->secure_sysmem), NULL);
+            object_property_set_uint(OBJECT(dev), "identifier", id++, NULL);
         }
         if (object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
             hwaddr db_start = 0;
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 87926f8cb3..39cb43506e 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -63,6 +63,7 @@ struct SMMUv3State {
     qemu_irq     irq[4];
     QemuMutex mutex;
     char *stage;
+    uint8_t identifier;
 
     /* SMMU has HW accelerator support for nested S1 + s2 */
     bool accel;
-- 
2.43.0


