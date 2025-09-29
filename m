Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84598CCA468
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E8r-0003xb-BC; Mon, 29 Sep 2025 09:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E7v-000308-L9; Mon, 29 Sep 2025 09:41:18 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E7c-0003mI-RS; Mon, 29 Sep 2025 09:41:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sxz3WHn8YzSnQqZ/j2F4iC7Amw5aIVO33nb5BcbwQ/QJfYsp1rZ5qxm2D246zHZhg6jDGMUukizw/rgGUfvjn5/+/ezZnzp8QcpDW5zWzfF/c3xCHejJg+L+h0CsZ8Zr26hTuQx3QCuxXdm6MK8i9RK/NzKZfZ2qd4L56VAeBpv5W7xt/pFI3eAdktGIbe3z15GB3XujE++0FBXlkZ5a0W110LptP9IZ4y7uB+T5Rlgjhc0rAINnSyMUQejOqtE1M2vVGIadzmgeXBnnvbj4WtYBB2qv1FC42DpIIFyY/8Bm/oMGRyL68RkKwYyPuUi+FoRhNGoJIvjeEvi/pVqD4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VBrzX6EFwUVADZtTQKhxfA4NxnQpIXRi43ymbRVQbk=;
 b=KO4OnX4iGmY4TOL/HRpOfaPL5/LVixsLN1F4GKns5ymFWdQtHwrTn4lqHy596POLo6E3H1gCm8hWD7e44D0+G4zd0wA2A15BeXXlPS+w/wxVlYD8atsRAgtMlpOHTZFqIOyRlTZGkVJMLw94v/8tmob1SZ9U3OiILJ8q/9cKm4EAFEMvByo5TQilOgq9gN0Cjxz/7Z/7U5Wqd4/flWVoSvEy/vU5CS6cDnC7fMVhC03pQeeQwbo1oe8guyvNeho2KylzCq9gsu3A+BnrKDPERbWVYx09RPuVnO7NNMwptsaKg/lp5aM8PeyGMWs30TJlZvf2j2rEMZF3YM/PO4eGXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VBrzX6EFwUVADZtTQKhxfA4NxnQpIXRi43ymbRVQbk=;
 b=ghGeOn2izkb29H2WscGxGYRYA/oRyEeJlHAj+D3D1xXFzWrQYo9rXyigFUtmeFo1Atr8uu8oLCkevuWXxJklhiWsO+j/k/B7TXUfq6A06h8d/OASgW5J8yLXrrXOup074Fifk2sMpa3ZrdZYnWUmbKUaPr88uQBxcwYzUCot6wJrv43CT7w9033Rij7vv5WY72vrY9dw4r4EXwSA6AVlFqZb1lXghN9yCzAdcL9k26At1u5sUoY3RUiKc5KqTSs/lpBA3rDDgzvtfv9Ss06keGy9jUYC2iDijmczd6I4GZVOZU3l+3yUCnBuovIcabJN1NLCwfbuIeHq/RfYmT1KxA==
Received: from CH2PR08CA0008.namprd08.prod.outlook.com (2603:10b6:610:5a::18)
 by PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 13:40:34 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::a8) by CH2PR08CA0008.outlook.office365.com
 (2603:10b6:610:5a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Mon,
 29 Sep 2025 13:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:40:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 29 Sep
 2025 06:40:11 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:40:07 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 16/27] hw/pci-host/gpex: Allow to generate preserve boot
 config DSM #5
Date: Mon, 29 Sep 2025 14:36:32 +0100
Message-ID: <20250929133643.38961-17-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|PH8PR12MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: c8431de5-7dd2-4ac3-783e-08ddff5dc337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LzCNgpTGlCqGDHZ+7r0JffboV+wletCve8P7GGkmNv5FVmbYyjwxhjEepMu3?=
 =?us-ascii?Q?lbTibQ490RgyXCBA8jCS0H6/jA8ua0pF8ae+IJWJwosud/A2/lGGy65hDcuU?=
 =?us-ascii?Q?2KBpNSygLBLCH/A6C7atOBzjEdf9wO/mPXRM0eaYr7uCwZOIjrsWLkOEFeyq?=
 =?us-ascii?Q?GlbdqoVwFMSLG/vQkrQpQF2HcawexehydGUnGNcC65GlWqMkeeyUSVOsYgjQ?=
 =?us-ascii?Q?EkKKaHAyUQ7TPYfssXm4agqvu/D08M7dz8/4oXVxZly01Yb+wHm3NLwKLTXx?=
 =?us-ascii?Q?np9tNUgw4pSy4KFKVgIaDtjSbT3+iYrAnfSuhhfZQIqp1m/KClng4pVbp6qp?=
 =?us-ascii?Q?L19pNMA2Yj1KedALPSjwRi2K7Y2kWiOTgucW6+J2bVCDeA4CO9yQDg5/Mehj?=
 =?us-ascii?Q?wexC7q/hEYsLYfg1o5baqJFKdOXH8iRdnojU2rl2hcAwm8qB7mu8lv1+LxQX?=
 =?us-ascii?Q?M2rhI2gV8awF9h+5gieygnMlzHrXkr94Ilpe+7O91A1K/0mcG9pyv3oo3+jr?=
 =?us-ascii?Q?hqio1WWEWi4yvUmqPOSPzcIGUQLTMoIG/KyDKIX/GumgbW6i0NaZaiNlC4la?=
 =?us-ascii?Q?xJeokaP1aiFtY10vtqNA98EG3n3mfZBdQgfWipkV4DjGgjbFMVPiZoRom1Ux?=
 =?us-ascii?Q?TcR4K4eWNdz/jl2RUVjRaUivR3CFFdvaHTAu6rcXTZ6Z9aLHwjuu683dGc8Y?=
 =?us-ascii?Q?I3dGk+SVSGhDIQrXUDNULDdBmlJuRnBNDsefFF4AdpO98xtGTvo/nZ04dlIQ?=
 =?us-ascii?Q?Jl3JwhU2dc6ggxpFQbfEFZbGd++pXGoiIv1tkgtylcKNT0MXGK6g/Qooj2Ex?=
 =?us-ascii?Q?ELq2TzDXIYHGAP2X2HaOPK8285ds39pKHBSpCjv/EwRiuGFBsNSKOzoidohN?=
 =?us-ascii?Q?nvbsPpCR7pItE21Cr3+dd8g/Sr/fA7uuuw7XuMM28K7Kpc/OrDbqD9HzJo3f?=
 =?us-ascii?Q?Y0TlTPVSqX0Ujs9Ds6cM9UNra3/TNnDlC6FD//+igIbypL/BgOByoS4hkB1W?=
 =?us-ascii?Q?n91utMwhAZmeT8nItxGsR8vVDjT4bFN7I5ytF7Ju3jl7wZzZDDyC5xToZWIk?=
 =?us-ascii?Q?2uITizpsNuZwvdBHrxpEghB9RpPuZSo1zdTip/ApipKkd72mauA+UJ6xTvA8?=
 =?us-ascii?Q?s3mQUkhMolx/IFQm081zHkTHpHh79imYSxmYEsDfVyrsaU6/qmqXr55N0isx?=
 =?us-ascii?Q?vIGir8K3ZlYhZ0cZ5iJ7fA2XqQkUQ97gWbgpcYLP49FFKh+h7EgRmrLz0AJt?=
 =?us-ascii?Q?/Cp6DYE7/3zKs9mHW80/dsFKQX8tBolPgkP04SlMANh5cyw/v7fCltLv7SrT?=
 =?us-ascii?Q?EQuw7Uz+Er7t9zv4l3rioOWG+Rqt6sp/Zy1QYgEVXsW5wnWagACk4UxiD01k?=
 =?us-ascii?Q?w2SBjWclAy13UbXUxFWYFX10pVHmXOEaLmbtdKtloVOU+02TPAn4AJO1liM1?=
 =?us-ascii?Q?YD0ghNdfjet1Qj2tMvFP/FmqU90NK0G7BM3xANk9jCYncWcC0vQ6nSIo6U/B?=
 =?us-ascii?Q?1dM2R3mni5Te54JFOscjRH06Wt3sUjcTulbbBAiwbQmrpVs0bK2WgBSNIt1d?=
 =?us-ascii?Q?oZYsKqB3vB4z4XUxWs0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:40:32.7158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8431de5-7dd2-4ac3-783e-08ddff5dc337
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

Add a 'preserve_config' field in struct GPEXConfig and if set, generate the
DSM #5 for preserving PCI boot configurations. For SMMUV3 accel=on support,
we are making use of IORT RMRs in a subsequent patch and that requires the
DSM #5.

At the moment the DSM generation is not yet enabled.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
[Shameer: Removed possible duplicate _DSM creations]
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
Previously, QEMU reverted an attempt to enable DSM #5 because it caused a
regression,
https://lore.kernel.org/all/20210724185234.GA2265457@roeck-us.net/.

However, in this series, we enable it selectively, only when SMMUv3 is in
accelerator mode. The devices involved in the earlier regression are not
expected in accelerated SMMUv3 use cases.
---
 hw/pci-host/gpex-acpi.c    | 29 +++++++++++++++++++++++------
 include/hw/pci-host/gpex.h |  1 +
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index 4587baeb78..e3825ed0b1 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -51,10 +51,11 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
     }
 }
 
-static Aml *build_pci_host_bridge_dsm_method(void)
+static Aml *build_pci_host_bridge_dsm_method(bool preserve_config)
 {
     Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
     Aml *UUID, *ifctx, *ifctx1, *buf;
+    uint8_t byte_list[1] = {0};
 
     /* PCI Firmware Specification 3.0
      * 4.6.1. _DSM for PCI Express Slot Information
@@ -64,10 +65,23 @@ static Aml *build_pci_host_bridge_dsm_method(void)
     UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
     ifctx = aml_if(aml_equal(aml_arg(0), UUID));
     ifctx1 = aml_if(aml_equal(aml_arg(2), aml_int(0)));
-    uint8_t byte_list[1] = {0};
+    if (preserve_config) {
+        /* support for function 0 and function 5 */
+        byte_list[0] = 0x21;
+    }
     buf = aml_buffer(1, byte_list);
     aml_append(ifctx1, aml_return(buf));
     aml_append(ifctx, ifctx1);
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
     aml_append(method, ifctx);
 
     byte_list[0] = 0;
@@ -77,12 +91,13 @@ static Aml *build_pci_host_bridge_dsm_method(void)
 }
 
 static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
-                                              bool enable_native_pcie_hotplug)
+                                              bool enable_native_pcie_hotplug,
+                                              bool preserve_config)
 {
     /* Declare an _OSC (OS Control Handoff) method */
     aml_append(dev,
                build_pci_host_bridge_osc_method(enable_native_pcie_hotplug));
-    aml_append(dev, build_pci_host_bridge_dsm_method());
+    aml_append(dev, build_pci_host_bridge_dsm_method(preserve_config));
 }
 
 void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
@@ -152,7 +167,8 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
                 build_cxl_osc_method(dev);
             } else {
                 /* pxb bridges do not have ACPI PCI Hot-plug enabled */
-                acpi_dsdt_add_host_bridge_methods(dev, true);
+                acpi_dsdt_add_host_bridge_methods(dev, true,
+                                                  cfg->preserve_config);
             }
 
             aml_append(scope, dev);
@@ -227,7 +243,8 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
     }
     aml_append(dev, aml_name_decl("_CRS", rbuf));
 
-    acpi_dsdt_add_host_bridge_methods(dev, cfg->pci_native_hotplug);
+    acpi_dsdt_add_host_bridge_methods(dev, cfg->pci_native_hotplug,
+                                      cfg->preserve_config);
 
     Aml *dev_res0 = aml_device("%s", "RES0");
     aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
index feaf827474..7eea16e728 100644
--- a/include/hw/pci-host/gpex.h
+++ b/include/hw/pci-host/gpex.h
@@ -46,6 +46,7 @@ struct GPEXConfig {
     int         irq;
     PCIBus      *bus;
     bool        pci_native_hotplug;
+    bool        preserve_config;
 };
 
 typedef struct GPEXIrq GPEXIrq;
-- 
2.43.0


