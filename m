Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FB5CF65D6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK7d-00015S-3t; Mon, 26 Jan 2026 05:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK7H-0000pV-EO; Mon, 26 Jan 2026 05:46:45 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK7F-0005hJ-4z; Mon, 26 Jan 2026 05:46:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gS1wxaKJdTXlbPhfs87AOBL20dmwQcwfJjfGioPiJMcs7zMR13js6XbS2gbb0jIZMGoxEAPB9G9nrW9mvvdYUeEp7n+glVLbyJjnOhhiGjgJGC2HQq0h5Ue2g4Ug56s0aGtQ+VtXVpB7H8Wx1sVKTlguOpPd1KeoA3Pd+4WR8OhNIxrYIk/jDPVV4QMmP2NIVy6ybE/Rv+GfxI7vleV8SDHWWBQ2andXjfdczZ27/FHMTMuFNxwowgNBieI1i6HvkueIAvw1wmP68rAMasy3Pw6VXQR5E/DiYTil1b1yvdKsGjUqbYJ4Is1Ramho8Ttji1tCx+K6PVlshn//2FOEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zA1yAJkIlJK3Xd9aLsr8potIy9Mqjz7zJmJjjulNe3I=;
 b=wvgjsjLVy+xgbSCyBFHGdIm83th+g5yPRyrEnh60rC914zAQKcF7t6TerBX+GdIKZp3jZV1WQ1j2g0zO8rv84jQiiuDEYBXorQGl9T3P2JbcPKKPyIzILvKGoqWog5xRS2KLcMIAIlOqpzqggrl7mijf3q74Bm4832rPRWE1llefWOIwbkcHSBdRm2FhEjDIjXd1v0HyV/j+IuM/KxVwNfcABdVoa/tf+GjLS29HplXmslo/dtcI02VdHsP63GptyJtiJiCv0RwD6J5YaZcJwcl1ZCePm+GWSGeANSyUMXZ4PXC3xldocEoVBoDlCjC9Hmqak/rxXVY1VSQPvoVtSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zA1yAJkIlJK3Xd9aLsr8potIy9Mqjz7zJmJjjulNe3I=;
 b=Z8P2z2TtQDksxlUlSowAqLaAmVGEG3bNoQRkxEo9qNB+jtiPNB5ZVHQqdPXZ9NoIe3rKesOz4nhyDNsUC4QbypaxdKtvEMAeWi8uwqBxi7RmBS11LBo4+GTCEzcYrTKvkgy6w26jIqPk66GliqMuV0eIfofTHXyXVLAoEI3upsl4m0Ky+uEOo25HIuO7P40gJg8LGz6+8PAfPw0LcxSS9FNqrpPY0a6+9DI0XyGGoK7oP+slBTTjrY/vZ81NDTIiBMv1TwNr6u9NeRnQlRS1Yc/DaN01HYwrf5xjl4Qy4WKDkzsgUVUvNipaDSkFR9uGFaYB6EYK/PoFMGRtqF/pXA==
Received: from MN0P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::21)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:46:36 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::67) by MN0P220CA0028.outlook.office365.com
 (2603:10b6:208:52e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 10:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:46:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:25 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:20 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 23/37] hw/arm/virt: Set PCI preserve_config for accel SMMUv3
Date: Mon, 26 Jan 2026 10:43:20 +0000
Message-ID: <20260126104342.253965-24-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|DM4PR12MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: 9093d9b3-321b-4a9b-4f47-08de5cc82da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|1800799024|82310400026|376014|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3kUXkHwaA047oW6qLvuV8Pyckqwy53Q00XBHqAHmuwdKWsiY1rKeBYS7t4Px?=
 =?us-ascii?Q?yBZyqKqIeK6UQU+nO8SghdyGSfqOHlU0Y6qbwnHi862BrCDt9A/gzyu74yD7?=
 =?us-ascii?Q?V6oLWJfdEfLv3zQkO4ZC4vEYMG+d/iVacDJN1xJpcXqsXJByZ9X7gEhzDzsl?=
 =?us-ascii?Q?9BgTCYq4jq8rYPp7MxlvlmRjkJ5HpC/HQrqzPnK3tnrSEKizJ0O9ol+1TIVo?=
 =?us-ascii?Q?JIbJIxT7P5ImIlhbVK3MOsPGDDzLLOyqiJ+qQjH7daDwV7tL3TXD1JzD94vb?=
 =?us-ascii?Q?j45vye6FsJzNOF/oI8UWlHW11CM63YCyUxV7bciWyLUjMNw9J/K1UTBiaAoX?=
 =?us-ascii?Q?FCnGniDB3p/4hoX7X34RmxNVaF/fkAZg3DlOXW3ir+TgJF64TDw1i/4C6gfg?=
 =?us-ascii?Q?7WDLLDYEQ/UYYGs0DIk0+J4/OI6t7hGyiJY9iLEwluwdrEjVsOGDWsu3lR/S?=
 =?us-ascii?Q?OY1FKRulLb/fRmJVW3lXgAa9kwQq+bIL6CmfA2sYOpxQ1mApNV+z0V2dt4DR?=
 =?us-ascii?Q?16YkXopxYh8CKvjLMmm6XdOibW33eRp/sze4UhoTeOjz5wSkc0psxbVan5Uh?=
 =?us-ascii?Q?YfmAk5KtNjYMgSU6z6nEJdMbFx9enW6HKZINlpgIGEyvR75fHUNl3e8nlUzJ?=
 =?us-ascii?Q?gbT1TdefIJH26R1QA72Nz8vtftj1SKotnLLSWsDSP4pLRXvqtO7t2WzmmQbv?=
 =?us-ascii?Q?IuzDchiLY0CqEAgrOmcTuv1ra78AMTtPVmKivKmgJ0KUxwwwDMZcaocrgs6F?=
 =?us-ascii?Q?yJCV1otZVcTSwFfD/OJ8Kx6tpeNJ72r/jJUyhbrrNXfmSijX1H+Lx2Jf03VY?=
 =?us-ascii?Q?So/pAtyFmM8LTcNANG+G4O10PJXW+ZFWIiR7VOWuVJFEATlIQitazODCoc1l?=
 =?us-ascii?Q?LDl1ipLdP95XEu2Cj4Tz8zntRCDxod/WmtEEe+AXmp5lP59A0qsg5EP7FeD9?=
 =?us-ascii?Q?fF2byGl8dm7kAZR6vijBOoASFoRnnG3q8BP6l7vPSeNvyTVABDi69OxP7xMv?=
 =?us-ascii?Q?dk7AGiUwhDNGU3Jqablax5WyPV2TC2W3+TIandHKVUvqq7YQ7IPUl7ES4kee?=
 =?us-ascii?Q?HPtueqWpg/gkRnB/IoTsqv/dKqInxjkNuoRfPDBTA8Z+eDExBIFxHzXQFElE?=
 =?us-ascii?Q?QWjVcNvWazpU98H0ESLhYmKIG4lbc6c/Ech1cZrHoVRhxgsCVFSxxrsBisze?=
 =?us-ascii?Q?QU6gB4OZMC7v4Mgnp/Ob/rvy0PbYUu4r+uOaPGs8GiQFeZxqW23yIX9ckvV8?=
 =?us-ascii?Q?pXlvFA0e8J1uum8yQJZmEM8BXoaG+mAIHs7kKSrGe5Z++KU/ZuBpJpPHt9w1?=
 =?us-ascii?Q?STh7Kjsn94OZ71wvpqoYUztIEEzMKqHroVHp2Aiq+yEE7mi9xql3hGKbah4y?=
 =?us-ascii?Q?vzcIP8ibg4/lXJznr6Pa9slzWcJzweHq5ktAgeenjMvFoEMDDvPRHKW5oaC+?=
 =?us-ascii?Q?/L4NeJkIVIjbAGGaIT9DIv/8I+owlX8xZhMQlCaA+Vhpfh++r/zA45dCtzHn?=
 =?us-ascii?Q?I8i+yro1+RxASygCMXx+bYahgn05WZEw16nljbmRfgNKkGk3Xr6sSutfa/uR?=
 =?us-ascii?Q?/u6Y4QctZS4UeiNqNluoKrX6OaM4Scm99FwitR99na7SilUAsfPmQ55q2WcT?=
 =?us-ascii?Q?tlWqzkANhPTZRuMaHUaVuUOPHXC4gRPIN6WJwcWiupzQUhxvWSD2nTQy0a5t?=
 =?us-ascii?Q?gbnixg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(30052699003)(1800799024)(82310400026)(376014)(7416014)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:46:35.9984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9093d9b3-321b-4a9b-4f47-08de5cc82da0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Introduce a new pci_preserve_config field in virt machine state which
allows the generation of DSM #5. This field is only set if accel SMMU
is instantiated.

In a subsequent patch, SMMUv3 accel mode will make use of IORT RMR nodes
to enable nested translation of MSI doorbell addresses. IORT RMR requires
_DSM #5 to be set for the PCI host bridge so that the Guest kernel
preserves the PCI boot configuration.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 8 ++++++++
 hw/arm/virt.c            | 1 +
 include/hw/arm/virt.h    | 1 +
 3 files changed, 10 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 03b4342574..9032a5df1c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -164,6 +164,14 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
         .pci_native_hotplug = !acpi_pcihp,
     };
 
+    /*
+     * Accel SMMU requires RMRs for MSI 1-1 mapping, which require _DSM
+     * function 5 (_DSM for Preserving PCI Boot Configurations).
+     */
+    if (vms->pci_preserve_config) {
+        cfg.preserve_config = true;
+    }
+
     if (vms->highmem_mmio) {
         cfg.mmio64 = memmap[VIRT_HIGH_PCIE_MMIO];
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 91fec582ed..899b02e1f7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3080,6 +3080,7 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             }
             object_property_set_uint(OBJECT(dev), "msi-gpa", db_start,
                                      &error_abort);
+            vms->pci_preserve_config = true;
         }
     }
 }
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 5907d41dbb..3b382bdf49 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -182,6 +182,7 @@ struct VirtMachineState {
     bool legacy_smmuv3_present;
     MemoryRegion *sysmem;
     MemoryRegion *secure_sysmem;
+    bool pci_preserve_config;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
-- 
2.43.0


