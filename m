Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EADCCAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E8Y-0003a2-Hl; Mon, 29 Sep 2025 09:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E7v-000301-Hx; Mon, 29 Sep 2025 09:41:18 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E7c-0003mH-Sd; Mon, 29 Sep 2025 09:41:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2oEel3rVYC4cYvJ3bLbKKDtfH1kHCrpceHjuFGeRL22CxxwTTTsmRcEQhjArZuzW+r1aPGEFB1wFuXPbanb2xXu+XCWFnT6tTdEdQmzcmb4vRJBvy/8IJlyi6nhUD/Vy0ZR35DSATLgBa4DoudB2ZqILrPJOt9ZwpZ18ukaQz4z1wpP4xAsiUuj7HpsM143s3ZJOJ/ItyQBJEJLsj9bgsx/0c75NP82JirKM6Ydw1m01jYG418rqAI4ZrVBDBQVm9CfgnpFYjsjhbRIutNgxS4AL9Jh4hztS0c+EJ3zC1sFw0ur8x6/SMAJrMKVpsIA/sbxnOjPk6xOZD+7zukDbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jY1hacvnDglO0sqnwK5ODJBG59DscJPUmvF5gULS9E4=;
 b=b8IdtTKuuNm2HttmQgt2Nx0tBuLv/sSPhM9pienZwXENiXV3CMt41jN48Hi8IBDImYaRl+ff4wTZIAvTvQrEE/Mz88Z1cxeUnrs8DuyUR+wDSKt65OlyIzogAogdamyLwHmGZNmAVWJviVrcW/cZp7tnmyje+Yihp+KNd1pFYOUXNvoIGyWLglGEaNMHS0whRGYbNwesh76xYLd6JwmjcI2f+0YKQSaXSEoiMboIYoQf4KJRkThCVKVAHw5EO4lQu8RC9McCl59iOD0y0QLcBNnA061UiqOJ5pB8vpShSXb9HVZvt0COFGFDYeowKPRixsOIG585zk+IIbqlIlPYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jY1hacvnDglO0sqnwK5ODJBG59DscJPUmvF5gULS9E4=;
 b=E3QXgm4o6B2itrHS+J+p6ASAAE8r2w+oP8NCrXMPW+kM75zrW7aPyBQ78AaV1RdtbrUSJRsUmlhBpePwUbP8NXW5Y13t81rG128WqLOX7Xre74E+pjoilXrNaoCHFbzmLhXHd4kT7VHOS/5trazvqMJlaDHLmsf5//1YHuCR+QGFhqC7zgdrj1k3FX2TmVEbQMVCdXbarHaV9pB80pnrA46Jz5ntmC42VFZSfIYj23Qd6zds25behC3T/9zL4xNBDsndnPA5YQtrz0Hairx58TCHMavSWQa3iNGTozVW3YQW9p5jtFTRtrKAwOHBWJKvx8qLmRGbxMftsM6LxDI1EA==
Received: from CH2PR14CA0050.namprd14.prod.outlook.com (2603:10b6:610:56::30)
 by IA0PPFD4454CAA9.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Mon, 29 Sep
 2025 13:40:34 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::36) by CH2PR14CA0050.outlook.office365.com
 (2603:10b6:610:56::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 13:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:40:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 29 Sep
 2025 06:40:15 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:40:12 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 17/27] hw/arm/virt: Set PCI preserve_config for accel SMMUv3
Date: Mon, 29 Sep 2025 14:36:33 +0100
Message-ID: <20250929133643.38961-18-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|IA0PPFD4454CAA9:EE_
X-MS-Office365-Filtering-Correlation-Id: 27659d61-cfbf-4169-97ed-08ddff5dc3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hLPqcqFdqtQzjIJv1WN08VZkaGiRUhiBYZ19rcAPAh+wnFO7RE8onxTwugKL?=
 =?us-ascii?Q?dhmjG6p5IhcqnqmsFxfVn4N1YpwtkTQHXrOdYq7n8eMh8OcCtC9K2xRX3i+w?=
 =?us-ascii?Q?BItMdZEE+nX3uEa+ax9ksGQ7TYQ9wacgT1FcF1X/yy0nWnmMT9ExF4GTJaOa?=
 =?us-ascii?Q?H1jShwniBF+Md6by9gA7PU/IuP0goDhpM/f5XMXzdrwRE8yxvSYBTzGSKU2u?=
 =?us-ascii?Q?uABVJA2klXlI78sfRIILNCcVmvS3j8A9vmTc9zIkv436RJUokaZBDy13V6iZ?=
 =?us-ascii?Q?Mmc8+GesiCjHhRU2scqN1lPwk5q3AHZwHfs2NjemsBSEPROz/g2iEYO1d6h5?=
 =?us-ascii?Q?q7ACWd6bIyv8VfCgOtpA+7nDfmzWLqZ4laSDn4jOOTGJXHeT3eWeMwV/iHUa?=
 =?us-ascii?Q?Ja/s+r/Xhf7WIWtpk0aTmtR2gifSmQyNSOml4TihwbTdh6eZwzwYyFeF6tpw?=
 =?us-ascii?Q?EpKI6HQ3qm8lblMycK5jL0oN6xPAJV5v3Y1xN04jQZUiN0A7VM/dGSQwl5Ff?=
 =?us-ascii?Q?IsvxudMOZVu+Yumeb5G8g/0rfwZTEmabgbK9s/MEAyHyEGHmvqVuyNUFrny1?=
 =?us-ascii?Q?jlfIokMkVBbykaPXV1HMTk4a7ejnuQzVR7YXaMAwHWkcRVEcZ9qUB1Q7VcRQ?=
 =?us-ascii?Q?d4QZ0VwG86+uWayIVRm8NBXEOOy7Phvm21/pl0eZfaqPkDV+DWjdE2CpKqmH?=
 =?us-ascii?Q?NEqN1HNnfdAvmqllqGefbUR82qyLHT8CDUvso0xmTD13DAm2hBttCH1thcUn?=
 =?us-ascii?Q?Sa432SznIWeBBkVmNzPJH3LF93kAIurHBzzGQ4502hI1DDb35dOqGBGdxfg1?=
 =?us-ascii?Q?kdjp1cFIDbb1cMy1EweDkHsHn0ZzblX05SH8DdrmonZNVB2BAEtJfW746mAr?=
 =?us-ascii?Q?8orlrTvPq1+O+tT4qYgV3KZKU55cUIJiOkBD/2O/vEixQTyAlib4Fo0x2DEa?=
 =?us-ascii?Q?ROqN125Lo95fnZ/yObKI3NoXrGCbf5VeMRNvdY6mXZmr1xOlS8rImFTJZqoU?=
 =?us-ascii?Q?cQ2LijhTqEx9ZwYc6i8DLqNGFS+RzCp8w/PUza4XZptjvj8w3PoeLTlSUSEY?=
 =?us-ascii?Q?M27PpLdGI4DdKZquzpHNcBGueM6wQB0+MDwxL/tnCQb3KdDTGX3L829ahzsi?=
 =?us-ascii?Q?Aory0R6NcHRfPG3g1wuGYFdeoFRx3ClqmCJZV8ftv8h3Rj8x3IMKR84XtPOr?=
 =?us-ascii?Q?HI79H+DW8j1kJa0Pg7uXKwcJ2v59/ihi/pF2luoYPAF+qsUbbyPPOmVrgO0J?=
 =?us-ascii?Q?j62sxk81zVygGn81lOHUMmg1ptlMJ8d3MRx8humTotHqd3EruA80egqbFlyu?=
 =?us-ascii?Q?WaNJqHdmZybsCMvHqeKaVLVMpujXix2KR+oFNMnTYgIVtMBoOplNOJvHm/Yl?=
 =?us-ascii?Q?UO20Dy+gzalrJ7wJAQrQnX4DM1Y2PKPtiVT+54qUc9pew7zJ861+2E7GeQPr?=
 =?us-ascii?Q?zzrlv+yRq+NodXNnHgxZuNZGCKJUAB22g79RrmotzHBLwR9eyWcAEKBSt2mL?=
 =?us-ascii?Q?orA6o0UZR3GeXE4xzPDpdGFZdJagAWd78ncTzhtFCVw1j7s3Hpq9hoYXqB3J?=
 =?us-ascii?Q?27ho1tkj86QG7Iwh2+4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:40:33.5140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27659d61-cfbf-4169-97ed-08ddff5dc3ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD4454CAA9
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_NONE=0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In a subsequent patch, SMMUv3 accel mode will make use of IORT RMR nodes
to enable nested translation of MSI doorbell addresses. IORT RMR requires
_DSM #5 to be set for the PCI host bridge so that the Guest kernel preserves
the PCI boot configuration.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 8 ++++++++
 hw/arm/virt.c            | 4 ++++
 include/hw/arm/virt.h    | 1 +
 3 files changed, 13 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 96830f7c4e..fd03b7f6a9 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -163,6 +163,14 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
         .pci_native_hotplug = !acpi_pcihp,
     };
 
+    /*
+     * Accel SMMU requires RMRs for MSI 1-1 mapping, which
+     * require _DSM for preserving PCI Boot Configurations
+     */
+    if (vms->pci_preserve_config) {
+        cfg.preserve_config = true;
+    }
+
     if (vms->highmem_mmio) {
         cfg.mmio64 = memmap[VIRT_HIGH_PCIE_MMIO];
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b533b0556e..6467d7cfc8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3087,6 +3087,10 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
             }
 
             create_smmuv3_dev_dtb(vms, dev, bus);
+            if (object_property_get_bool(OBJECT(dev), "accel", &error_abort) &&
+                                         !vms->pci_preserve_config) {
+                vms->pci_preserve_config = true;
+            }
         }
     }
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index ea2cff05b0..00287941a9 100644
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


