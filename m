Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD51BD2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 20:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1Zd-0001xp-EP; Sun, 11 Jan 2026 14:58:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1ZQ-0001aY-Qc; Sun, 11 Jan 2026 14:57:54 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1ZP-000465-4n; Sun, 11 Jan 2026 14:57:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQfTZnos9nYSWIm+y9C3HPB4sKvNcIYNoYEhZTCguJeux0SVkcYZZ59nQh9DHrPcTVDB/Df7Z6zUfcI8q7orTxG9FjmIZJp9sTVDm2KMG4DOmTSUS7ppx4TfPQxmjq/GygQXYoKh3XeUOVeZ3kU8HB0TI+lvz5wH/pS3aeoSdHONuY0q7coC+oqn7Ll53DEIaYVtWSk9zmZTLk1ngeDFuOJK+UvCp4fr+NgCUDaTwSwWLHXnv8RsHZDJ+7bgjteyKkZ49uquDCDG6Ogkoc4kc2wRzgJoiuKCq66iFh/pwnVRr8tqhL+Wu9gCyliP1dCntIMrRHqDSQSCRp7UScGafQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQUosplpbaLUXCnzRuORKkrwFfJS1NEIffdJREPVAOY=;
 b=BiI3cMxWEySOvfF4pihENNQ8Fh+WqYubPPuWmm0DJvIH6NBU260g+O7Kong01C2KHpNA8Tug4D5835kWwIfty+BvP2Y4ij4haxcLrjtBwjDTZQR30rV3MoCPTVfXcR91fvoSrI1UybtkLf7PbSU7QEBMRdARsmfZ6AYqtUAzdtRP0X7Htlspmf0Elnh32mQunAxrUtZ8QTYgFMrqW9a9OcOyBsgF12BYb0Cq7LnsOwMeV9ihGr6opz8UjCZALZA5Io2RjZ9dI3BoWuVcJoWAVqWjg7kqv0lPeLDcKw4DZ/fjl7L9NXRQwdb7RovVhryEserWsBZh0fRyEvn2tT0bUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQUosplpbaLUXCnzRuORKkrwFfJS1NEIffdJREPVAOY=;
 b=VxF65Ln2G3asxrH4x13Hn8FjW2UnotrHi6FI7KOIKqX2/2kEaUmynzpEdqcnrdAlajb2YvbYq+ALoDUxLLT761t3V3bywERaP6Kx1xUJRLEnZb3uLoW1gj/hf69Z3CGp75aa2P7T/W8ETcRV/K45dL4c82sL/kuzFlVv64939GEKIg8B+JqeqM4C7812LU2h1iwMk8qP8g4uTtLZ5tR6BwMG414Szyzwy2txzGKHzrUghxEHgFetg6mVSquA6u6rx+9lJlFKKyBWB+/05WEeQF3n2XBsqa0X8/fKmi3XUa14jQOmDtpJ371fgLT2VRr+9gZj5WVIaA5PM1aN2XRPWw==
Received: from SA0PR11CA0016.namprd11.prod.outlook.com (2603:10b6:806:d3::21)
 by PH7PR12MB6636.namprd12.prod.outlook.com (2603:10b6:510:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Sun, 11 Jan
 2026 19:57:45 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:d3:cafe::e6) by SA0PR11CA0016.outlook.office365.com
 (2603:10b6:806:d3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:57:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:42 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:37 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 22/36] hw/arm/virt: Set PCI preserve_config for accel SMMUv3
Date: Sun, 11 Jan 2026 19:53:08 +0000
Message-ID: <20260111195508.106943-23-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|PH7PR12MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: d2edb57c-6bd2-44de-e910-08de514baff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|30052699003|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1McuWAZYIaOIxqDz4L1AHK5Ni32JTjGEuleMJxrGfxjUndIOtPde3jv1bGei?=
 =?us-ascii?Q?RVMOrYI4d8M0YXH88hNDI5KwfE2xEgIj2GN46RPUOv9UpWkui9czjYBXi7+G?=
 =?us-ascii?Q?GEnEmXyKIrL2ZsF22JYOqz1JDXRZX/ekEQNH45+4f1hMK/s/rgZ/L/W2Wx9i?=
 =?us-ascii?Q?VMQWTRvF1HBVTVAZe5kUC/0uSy/YcmPsk/RCtRkGODQVAgeYeZMt0V48hD9N?=
 =?us-ascii?Q?1R2g3tcL9svn+lUktTPFIUfEeSIRbzdo4mU86T/9J7gxG29KWJ2tmWvOiEvQ?=
 =?us-ascii?Q?YL3a820aN4Z7kik5EHkjqrTNmsdRv9Yrb5XDdKwHZim+YVTz8tUffMKIpaGk?=
 =?us-ascii?Q?4zwavFM5f4B6C2iUBnjSE+iv/QHmJ3WuLRMTbTPYDpcuhRZPdgBvUMOcNu3s?=
 =?us-ascii?Q?2FAbB6qiDz7B05MVXdSpEzPBLvKwncBMThE6HYbYPF8arKMjSeWbunPtgocX?=
 =?us-ascii?Q?Zbu+rGJpfPvf6OY9pTxWcbO+OxjDxLrotS3gruTFm7z5qPvjxlgjROL+VbXO?=
 =?us-ascii?Q?BF5vZ5Gx/vPdcXWEmQBK5NDKAZeDUcsqT18MWvy7tBs1OKYrSBNVM4wALngh?=
 =?us-ascii?Q?Q4i4gHnF0J1bagJZmhP1PJNxUMmOv0A2XeykO56yLclRr+GYQvwC2dY3LNbr?=
 =?us-ascii?Q?6XAY47HHOoGVYkjtev8D9qCyJ209fdjfPWtdFvFwECtMDm8x5tMEttmSchBm?=
 =?us-ascii?Q?66Lh5h+5HfQ2n4R34mpno+9vpnkwecWQLfQxVPg7RxsB+KTCfwL2YAR5Q2je?=
 =?us-ascii?Q?5H8deAH+L44upzXGqTTU8/N3lnz7bv+k+5CgQYj2SfLT/FrL2iyVyFspLG7L?=
 =?us-ascii?Q?iOoB57T8fqyQHRerFpTavMgWJpBdvFtiLrh7c3FLGfcbcZ8699gmiT3nlYdA?=
 =?us-ascii?Q?C1KCQE0+dnZy0yhxDp4HB076exHKJN9h/3KVQ1XHpsR+4vzU4ssto03kE+j8?=
 =?us-ascii?Q?su7jtBT1mvfMBou0btslSKRy7vEEaXu74Rhhi/d9zduSdm1Kvt/DzeMrsXvb?=
 =?us-ascii?Q?yXZicFPit+zYf6hRORhQuGo2EczpA4p5Q97FI5Dw0iEN6zFsEBz9039LsY38?=
 =?us-ascii?Q?4Ysf5wCFs8VMOD9heJntXgDtFrigrqOaTsfuj+aNKwFsCF/qkzUNJ+eVRT22?=
 =?us-ascii?Q?Oq7Mm+8Hc1SH/5YB+L/DRk1AsEC2uY6/D03iuka101oP1FXzhTLUVMESRrkG?=
 =?us-ascii?Q?KvWqg4boHAYJxPXp0pEGaPB8DAlLS5MX90gKX9mebTbncWXZ66vokjmZr6ri?=
 =?us-ascii?Q?7CGGAFFEPrnrioe2zXifQTgAG37SY+2eBvWQpsbw8CIE2KEAu1t60+zhUGOW?=
 =?us-ascii?Q?q0mhWzQmODgelRwa8lDHjvfJ26Gxo72YYc269PXhnzeq61fX4gCADR9hkwlE?=
 =?us-ascii?Q?sYGhMZqz01Rlr7zVhigMGeQrhcKAH3BK9ZKwxMonrfM5fBidJjVcbCaYGSDF?=
 =?us-ascii?Q?16OhwRMuoUWb0Rp8ueshSn1bWnI1RTxkFkZTS9fpnqiDKCddYa4eDMvNXuA1?=
 =?us-ascii?Q?qE1X0ZPKqOzJQtTljLucG+4HU5kjSaIu4vxAWn4x5c+RoFoMpNgok8AH6mN0?=
 =?us-ascii?Q?WM2LHPRrErQIlisxW2o=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(30052699003)(7416014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:57:44.7917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2edb57c-6bd2-44de-e910-08de514baff2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6636
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
index 08feadf0a8..d0321cea2d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3071,6 +3071,7 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             }
             object_property_set_uint(OBJECT(dev), "msi-gpa", db_start,
                                      &error_abort);
+            vms->pci_preserve_config = true;
         }
     }
 }
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 8694aaa4e2..2147c6beb4 100644
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


