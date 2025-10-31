Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEF1CCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmn8-0007WI-5o; Fri, 31 Oct 2025 06:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmmK-0005CL-N7; Fri, 31 Oct 2025 06:54:44 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmmA-00031V-Nz; Fri, 31 Oct 2025 06:54:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3zvOuzRvTaVJN7kCCc369AAbWJfHWHffsN56Sp7fkK1u3Xpl+Z/KM/gjeMUZyR5H7+COh3dxtPuODQO7PtV1FwhKXxmQGPZ2u6O09kob7AYCDH4iPe/KetE8+yyfWamnGjkwjGuNwvg2m4DMZwFxuAaf/jRGhnH5znSxrt7r7SB0IzXAxDdBIcYaDC3fX0XJiDARMZi/l4JivgmfavtuvezlLl+tnW5HXDcdvg/42/2j00uS2KD1Rb7xSfBqfiwnOzvrDxxDKeG2ZGkkEQsx6JXXxS0KDQ1BMwPgTOtvwZ7FioavhbsqgawPSkpxczaXCvuzsfk8k6rYgqLL07C1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=487XgYj2qbrQLpJ5W9zs+2RVdbhhKynI8krASd2Drio=;
 b=U8Fa38qJZKW80KXwC5soM8P0oBgIQMQHTzokbxzWdhhGyBJUj9XfuLFqWn8fk7hx5BHAdZv7c8K9f5tYVuuT+SxZlPr4mccfzHIGC1wYbuZ3GJ3Y/1aO/e0Jh4A1Sl0opJPHCrnnTUxgGUtGMTaYxgFDmyXTbios8qjSmHOB9fXEXrMFEvw26mmrQUgoWIuV9VevkoAtFPVhacr+2riFhRfKzw2C3E+s+sL9oOjZN+yCN3z3kk/8vkZScfCl4G9H08M23uIur8ViOvPjkODuzSS/CDdy8TEYd0RTpsNNWYjrd8YDZfiGxTywuQYInBu35zXIgR318s2/02xTkKpNIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=487XgYj2qbrQLpJ5W9zs+2RVdbhhKynI8krASd2Drio=;
 b=nunmBiAaKnRtfx8qX3oOwUhdoNk11IqKLrTxxw6fzvEUkh4yiGNBF1ZJ366Kc9Eots2u1f8LNYHSc+hYcg6EHHAgvMGnNnpxMDFy6nrKOlGwd8m27LfoIib0GqS6fV+vYKHB7cfGfRAc0ORmvI7UURDE00kTpFyc6yFKL9mO+UFfk6OV7xos7+miO1HgjERSw3IHTozCKY9Pi+Qj1Hw+854A61+SF/kuvtYzQcJMW6v/esAtZTDouRfRe5GuqslpWAjxRj0GqZlALadd44O9OOY0IRu9LdeuW0wrWLZ+0leX2o1vHJuokB4Hw8pBcCoH+7R1ishD0W5stGY7rOivgw==
Received: from BLAPR03CA0075.namprd03.prod.outlook.com (2603:10b6:208:329::20)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 10:54:21 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:329:cafe::b6) by BLAPR03CA0075.outlook.office365.com
 (2603:10b6:208:329::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Fri,
 31 Oct 2025 10:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:54:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 03:54:11 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:54:07 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 21/32] hw/arm/virt: Set PCI preserve_config for accel SMMUv3
Date: Fri, 31 Oct 2025 10:49:54 +0000
Message-ID: <20251031105005.24618-22-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|BY5PR12MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d09d9b-0b3b-4124-8501-08de186bd916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|7416014|376014|30052699003|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fzwz5Ta5PKEbJFjTWK0byY/d50n15IGOXX/eUWJQnKbg7s6dKO1kwkeX95Zr?=
 =?us-ascii?Q?DsdM6yF3fG/MZzPzLZc+jElOOg6cga58IDo2tjpVlLTm7O/TKiJR2CNxwWPO?=
 =?us-ascii?Q?a18uHZCXxZobePUX/wxbYD65A9/yf5bwxYxuJ/L5RehV+qPtee2x5kr6rfb3?=
 =?us-ascii?Q?XMPTwq5A+YoTm/64KMWqiidzlfhIOWlKtvcouz9N/N9azeHGm55rtiI4MKai?=
 =?us-ascii?Q?SkNv0rFlxXCjnRZDUSKylrQvJzBKUXksVDGpdWyM4qs0FspfFD+5Thj6+mPE?=
 =?us-ascii?Q?Z8fsHzP2Q4S6wRSjqqRpt7FkatFaMMrtPJxaJX1CVjkKZizKkkCGbmmBfBNK?=
 =?us-ascii?Q?e/q+PD0XMfwtxug3ae6sncTxGiwzQdeXAPgxXUxu6pjDbxm3xpG37L4o+rFw?=
 =?us-ascii?Q?efgVgrzrM8NtFQpFnkGAPnBSA28xXAWPbEiHIMczsG+Z+MDsbuQI3xDQY7kt?=
 =?us-ascii?Q?U7ODKtRJU3hZIO/xj/TVI3YEfU656wOOm/TFBK9DGrECKW3zJZ9/Zpfi2EcD?=
 =?us-ascii?Q?s8ISXhG6q110k1Vs1umRvsux/NLr2SpKV1pFrHFTxkB5SNqV/eJqw0UheDpe?=
 =?us-ascii?Q?Ut9zhHcsywue/U2oD/DkacZKofAPdLXy2G8o3BEPXI0/ccShwtnTJT5p/O+2?=
 =?us-ascii?Q?q0/OLFvH+EM8r8ObnqEjcB0fCwnV8UYzWvAMKb1d9ueO2cEErn3z52MLP/iO?=
 =?us-ascii?Q?+pSwP/cSAYjD+iwllN0I3kzR/Ub44C9Y5/C/6gQsd9Qze4RuSE0kJstv5jA8?=
 =?us-ascii?Q?zFl9X/hBa4io37KeOjf/ZlIh60fR8AIPVGJB+jQdEw9KmAYy2IttIa/9D7wI?=
 =?us-ascii?Q?z0wzorlBwLPiN3CsxlTfDp9g4STyguldoTL+wGCyaYPIH5nU+4qJAktBte52?=
 =?us-ascii?Q?FrSBR/Qt2pWolZdN7ybkxkfwqBG2jCzfOfCcGHKN46IUWJYqWETjKSXN6ueD?=
 =?us-ascii?Q?pkTIT5xdzKGbzKxUmaimjPaOaOzhZE1aj45trUgW1oi2vKUzQU6HDj4uFo3t?=
 =?us-ascii?Q?rYgCbcL2Vm6r+Itn8CMei1o6a2pXy/Ynhu3SThVV/YddKRw9r5oq0Wd7+QxC?=
 =?us-ascii?Q?KDCvwRyih048C2qm7ggFV/nrhXlNPfpfFUmzLp9AVMaT2unb6LLqaJN8seIc?=
 =?us-ascii?Q?VeDR9Psp7aeEErgSYLS2vdls5N0xzSOL2Y8JmYGOgYzIBy7ryp8Bj6yVO22q?=
 =?us-ascii?Q?OZndt7gZMb90aMj9XIFkGpb2F79jbtrPMzPjIS28P3oCqCD4kfD2X5TVEVFT?=
 =?us-ascii?Q?Oq8dsV5vPndqjwyVFtCZpq8Oyw26pSTGhC+pp3xWvmba0c4ATFyoGnjI4BrG?=
 =?us-ascii?Q?E0zW75sLKXXAv4UMnHCSoPklZXpNPY89BfaTtGuOLQj1f4DPOHFASuIZZDLh?=
 =?us-ascii?Q?wg67n8IE0YyeiYV58e33TLEcgL8Hv1JCTheSxvVANRuSa7aWDiM9dNg+KNIt?=
 =?us-ascii?Q?m2WMj9zKqXqi52IVizzaDpWdrB1V1BKssHhl5qBgebD3nqjyt3k7qFEQOXee?=
 =?us-ascii?Q?3+Ssi68j8S6Da2cgRMwzGttizZ4fS6uEFtSgEYnepmJyGXGcd6tlPlpYFtrU?=
 =?us-ascii?Q?gJpBk5l9aO3UJospQB8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(30052699003)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:54:21.4115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d09d9b-0b3b-4124-8501-08de186bd916
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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

Introduce a new pci_preserve_config field in virt machine state which
allows  the generation of DSM #5. This field is only set if accel SMMU
is instantiated.

In a subsequent patch, SMMUv3 accel mode will make use of IORT RMR nodes
to enable nested translation of MSI doorbell addresses. IORT RMR requires
_DSM #5 to be set for the PCI host bridge so that the Guest kernel
preserves the PCI boot configuration.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 8 ++++++++
 hw/arm/virt.c            | 4 ++++
 include/hw/arm/virt.h    | 1 +
 3 files changed, 13 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 8bb6b60515..d51da6e27d 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -163,6 +163,14 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
         .pci_native_hotplug = !acpi_pcihp,
     };
 
+    /*
+     * Accel SMMU requires RMRs for MSI 1-1 mapping, which require _DSM for
+     * preserving PCI Boot Configurations
+     */
+    if (vms->pci_preserve_config) {
+        cfg.preserve_config = true;
+    }
+
     if (vms->highmem_mmio) {
         cfg.mmio64 = memmap[VIRT_HIGH_PCIE_MMIO];
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 175023897a..8a347a6e39 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3091,6 +3091,10 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
             }
 
             create_smmuv3_dev_dtb(vms, dev, bus);
+            if (object_property_find(OBJECT(dev), "accel") &&
+                object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
+                vms->pci_preserve_config = true;
+            }
         }
     }
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 04a09af354..60db5d40b2 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -182,6 +182,7 @@ struct VirtMachineState {
     bool ns_el2_virt_timer_irq;
     CXLState cxl_devices_state;
     bool legacy_smmuv3_present;
+    bool pci_preserve_config;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
-- 
2.43.0


