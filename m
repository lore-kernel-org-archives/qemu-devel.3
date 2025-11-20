Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0513ACF8859
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4fI-0000tN-NF; Thu, 20 Nov 2025 08:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4f4-00008k-OS; Thu, 20 Nov 2025 08:25:22 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4ez-0002bF-Gj; Thu, 20 Nov 2025 08:25:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jo7ac2nW9rwZDwJF7hhCzZvMi2aNhxEtQJbJ6VO6oQOVCbbN+6QAY7YaAD7YmzMXhVcXyHV2cAtdoR8aYZFS+siW00YX/VKDIwWGl0yrg9Yak14BnAYoX+tFMoeIGgig1tY9GASulmE8IYhuWf0FL51d0uzJ4RQMXPgFf4e88/85oghQNnML5M2/LrZYypAOPY61RLjxlOVTVBkuiQoTz3vYUP2LdY3C5tzm9T2Ym1NVJg+10yFtsXIRlCen6bM6aIYkiLHtEcocypwmENLBeN+OgA0PvujTWvonM4idDQIylaJEG3A588jt85aVtBT+aVQXu0NeoOlksuSpiVEGCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIYpKpBDZ/wPMV5H22ZyZD02qLRimM4fWixvA6bRLxc=;
 b=pP8+/LjbMBGzV/tGZd5d3qtfsgj1bPQpjFq8twwBOuA6dDvvZK1DqJqkSV1cjghnOurK6tMXV4jIngQnQmWKOQ21t7T6p2tfCespkO+YxyTR52QPmORZuV0M1VeFoQpgIUPLwOP2uqaf31/oPlWe+ceptC8Fk+q3ZBxAzviBq2hAw6Oj90rS2zpNQ/3XJsKQjHuNuTtb3wUT+jsBl3NKMem4Ggxn0ccQPNUSDky3O+Bg+cF+jtMwaRNEl6dT/NsbM9PwxpKFLPYKiX7XaPu2G+nhRVEg6ZZMZGfC3XE3CxkIT5guTTLs3kgVcyxS5PM2rBrTJ5J1ukT/SalfKB4uQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIYpKpBDZ/wPMV5H22ZyZD02qLRimM4fWixvA6bRLxc=;
 b=lUkAhE6wJ0rWgAndoX6hL+rdMiPPTB1jF7FxRC8P0mCzsDqJfK+5rDmwAj5r1DQjcfuZh+iAzbBk0PayNt5EaucjPArDNGekfecVM4jZShkK52H2/AiVQNQSaP/8fv8jmmE+r1od9F27xgvgyeN88IEAMAFb7I0ww8OAo2e06tt2oLu9/gcn1r20T3XdZVYK6VJmtxQpFj5MqaLMRjisLUOTJ/+6fLXEDOfrFUy5JW0m1fhjWeZo/6v/aFdy5yu2F9muCnWsgh62MAGCZlhADwJb9m39/M5btnDzdyWeRRLwCy6+CfZB5walXWztyj3SDoJiIauLdBA0bhaae9Gu9g==
Received: from CH0P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::18)
 by PH8PR12MB7231.namprd12.prod.outlook.com (2603:10b6:510:225::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:25:09 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::45) by CH0P221CA0016.outlook.office365.com
 (2603:10b6:610:11c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:25:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:25:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:53 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:50 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 22/33] hw/arm/virt: Set PCI preserve_config for accel SMMUv3
Date: Thu, 20 Nov 2025 13:22:02 +0000
Message-ID: <20251120132213.56581-23-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|PH8PR12MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 154d30d7-7d9e-43b2-c001-08de28383a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vE0fwL52s+2gGAnUsZlM/ksQFW+LwbrcHedR7jrF8M3wgbvp2KbaA8C5yyey?=
 =?us-ascii?Q?pxxhhUuIY820+JoB1bk2Hz736SmA9FBPfx4IxCUJzDch0jXwi3b/GYlITmia?=
 =?us-ascii?Q?9vqPO7uVJj5athK4opTjsjfW1PHUQh+Mn4k5CytqIxOBeBaX2XBubuSwvfeI?=
 =?us-ascii?Q?g6TBCUPEIVMKaSlpzN9JmDJ8pD5uRG8D3TNc9I7JHqbD0Zrztn2JVxz7KEbb?=
 =?us-ascii?Q?4LFC5X0PVFMm84iSItzJ1lWQsij8i6boaxv2XepGtaJybJ94KE2qdwQfyjD4?=
 =?us-ascii?Q?8JQA7gmYnRFvhaBX+G1tEhVOXB1TBzPpJELV8dhbAOygQetMkjbL6jMJek46?=
 =?us-ascii?Q?aHEz5BlCbeMsycdDDxVVHZLxA+hgMsquwz9n/LBG//1ZpFLULsc4L/NHhHZV?=
 =?us-ascii?Q?wCKVVEzAarz+IVtTheXh0memJL+bzjYAT3Wit1V/yEpGR6vYyGGzYqQ++rTI?=
 =?us-ascii?Q?yd0gFA21z39S5x/od3kjhYsUMrzveK43EdTPh+BmVTo4TpZ3t2KPmMjx5ij/?=
 =?us-ascii?Q?uc8sKI7QROXlKy7XatfXUHXUNodDTcQiBcRTfRA3ZdE+3rCYErJjAWV8jwbs?=
 =?us-ascii?Q?aACrlj5LZrpeszhJNr4oAmpdj2OxpBt9VG3AKTYgAFYbevSFAGM1QTEezS6g?=
 =?us-ascii?Q?EwLdaxq1pk/2OF0wdNdnp1PfViOG0hmGJdJm3dkfBoEVKx0h+3Q8CNgetnGX?=
 =?us-ascii?Q?ezdvnZawFgnZzEpDkAyqN0k3ryxAdLlghVYfe1xo4SCyl3Rv0jxzZSr0fzlG?=
 =?us-ascii?Q?mjJyENVIQR9X7nhcY4iD2GeJIU1qt0oFbXLyb2bRoIhKqnnZGo2KrbVwYIdW?=
 =?us-ascii?Q?Ki3ZwW4vRAi+phsbhNb2XSLZLXoY6VqzVrXPaqpeFoVHLb0Q/K1j3SbY7Vq6?=
 =?us-ascii?Q?G1G2L+eM1pz+tROmHmRj3rb9vOfRgdMVKUyps8IXnkyaqzf8JhR8GJDYVsrE?=
 =?us-ascii?Q?ONg7KQGIA6ES5ueFDBsDVTRgO6e8HtjHP8Naemz/WBfAuzNORE/jk+B0ELtq?=
 =?us-ascii?Q?fLDJgLrrkB5tLn/LctZ5MFo6S0L0Q2hubqODL2YmBRqpwbF3LC0cQsj60lM6?=
 =?us-ascii?Q?DU65Jq1MR3ips4Ne33y9MLaGb3P+diYFLSyhk6vfhmBM2efuOjsZNf7v5p9W?=
 =?us-ascii?Q?2Y1mqthfUnP0PC8AtdRiGp+vyA12KF2rthPi9ug1wI4/SWhhT+SbRBNS/RDu?=
 =?us-ascii?Q?BiR+GyHGJrl5nOw8kM0cYk9HXuhJA9vvFpiIiaegVD7NmJ5fykS/9+HurSgI?=
 =?us-ascii?Q?VGekbblD76WTMYj5zgU/7vRFHg7Xw2fBPnn5PbabMxSfMciOKtHs1OAqbpQn?=
 =?us-ascii?Q?rKQHv9pUfPmFLr/EjKkjerSSYpBhkjKz9ik46fR0AENeApjzIULzWaAvMZxv?=
 =?us-ascii?Q?fN8+9owN779R6Z5+iGyx/MVOFLSr/MeCP7s/86xSlk3B7B2lfrnpUeG8e4Sy?=
 =?us-ascii?Q?nkfOFQ/Sz9xtBsj8gL4h/e2GhuyfNIitBvDYAlIaJ+eYfbSuQ4ilGW1m7rqm?=
 =?us-ascii?Q?SzvrFMlr9EeSXuq7s5ki+bsJsHX1/1fIEw0aLVxvDgiSR2hW1/KYNwILnOwr?=
 =?us-ascii?Q?ysnlHy+BwrYWaW2ekeo=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:25:09.5940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 154d30d7-7d9e-43b2-c001-08de28383a7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7231
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 8 ++++++++
 hw/arm/virt.c            | 1 +
 include/hw/arm/virt.h    | 1 +
 3 files changed, 10 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 200e2a1da7..f7264fe8d8 100644
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
index ea3231543a..8503879c3d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3109,6 +3109,7 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                 }
                 object_property_set_uint(OBJECT(dev), "msi-gpa", db_start,
                                          &error_abort);
+                vms->pci_preserve_config = true;
             }
         }
     }
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index c77a33f6df..efbc1758c5 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -180,6 +180,7 @@ struct VirtMachineState {
     bool ns_el2_virt_timer_irq;
     CXLState cxl_devices_state;
     bool legacy_smmuv3_present;
+    bool pci_preserve_config;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
-- 
2.43.0


