Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD87C44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicSi-0006z0-4w; Wed, 21 Jan 2026 12:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicSS-0005vK-4H; Wed, 21 Jan 2026 12:57:32 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicSP-00023i-HR; Wed, 21 Jan 2026 12:57:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wr5rvSYUuSaosk206BaIrCArCInImTaxImCPowzg9LSGRuEkMfBbCrQgLVF+Buj5FXIx6fLh7kLP7qupjqcP5yBg6yuwTd05x+HPqzvALUHklE9I0YxcMMIZOzI0XvrFlc/XaIoCG7SIRLCkEeygVV1GdJ8rCDp/WxfOtD2q+WbWr29Ys02KROJI7CK74UQS4M/t1kIM78bwUz5OQwFuEIBTzr+nKNYD9zkAtLoQdJ+w6Jmo+TTlyscr7qdB7xERMp4xPF6Q/W8JgTwOI5wSuZlz5rQmBq1+qjCNcLkNXEk5ea9zPfJtIcu9pra4+aLn11K8je8eEVzgF2Z5pqIlqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97mv5Uu7AHhwdRIrHfv8N1DP89xL2fnL9fOK6dErw+E=;
 b=lTFglWojPaIASoT7A6KcQpRFAln4s1k77OOlwMfeSpMg0+HYDScV2RQoVhuuZr3wIKu6PxdTV5BiusD5aHRf2B83z1T/cANYTbDikVMMqCAYVHiNsXrDlqWJFgY9ikGfZCgKp3/AiutBsL8pmdrT3aBt49ppgkpEAsMhXGrgcot8qyNFawbyajDftT/aujyKoswLobPAtUEgCeaAGrKpgaRuskWOYcvK3MbI2CtaCzZsXwDTFBqo2MSWhsDGGnxZKYD8I+wtCy6UDtKwsFDrVvqwhiRsur76Te1/AixyvW/Ee2AV8wiXLqYzwWxpdKJd7nORnstaWU6LbeW48RXVZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97mv5Uu7AHhwdRIrHfv8N1DP89xL2fnL9fOK6dErw+E=;
 b=bEDR7HHtDz7KEDLf7k30ShgeBfLlG/S7Amx1z6xmWC8fXDrksC6W1GnS1bNEq/8w9Wu7sRZb8aG1LeEy0wJMawlJTLk2hp0EB/DR86/izAjykV3zm1lvGjMw6HR0I0KFX0Cd72QsMY8T/2GE9UDyPCab+4hrMs5IfuqE7lCADR286jOqRZUH6YW5vT7b75DHgoAmrbDW777Sw1TKpVNUE+nZKcdOz0IheOluS9xRoT6wy3csFr/n4dvm3UWc0+5M4m4Dp5Ba/djelQr99jFqPHH1EBHJBaDzqCGVeWmyFYf6sqLUF8k2AD99C2liEz3iTd9rpmCFrYk0KkN41SUZLA==
Received: from SJ0PR05CA0082.namprd05.prod.outlook.com (2603:10b6:a03:332::27)
 by LV9PR12MB9784.namprd12.prod.outlook.com (2603:10b6:408:2ed::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:57:23 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::31) by SJ0PR05CA0082.outlook.office365.com
 (2603:10b6:a03:332::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 17:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:57:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:57:03 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:58 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 23/37] hw/arm/virt: Set PCI preserve_config for accel SMMUv3
Date: Wed, 21 Jan 2026 17:52:28 +0000
Message-ID: <20260121175248.87649-24-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|LV9PR12MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e4e8f3-cf54-4276-9076-08de59168710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|30052699003|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zd4+ADzsmQjxHGpgodn/+DHDh4uxcuTqyABnjNqNCTGdakqKWXgzwG7Mn79w?=
 =?us-ascii?Q?nEAGwNdbM184xn2WBn7ocFkrKkSZWToC0jO1CFPI1bvC0Rq8wM2Y4TLO02v7?=
 =?us-ascii?Q?yKrDrbFdPO0A/2jEP2yut4aiYsCK2AkWcgeG00cPQV3OTHagdYRx/d6obtmH?=
 =?us-ascii?Q?HMcESpc44HNS4Fxd4l89qBXa/TDSmM9pxymyxhxCnQX0vsYBiENJveEWPq4u?=
 =?us-ascii?Q?nCnG7VbtyYRMD44asN4NcDOqq8Xsre4X22yE7uROxKOdVQdLkQD0cZZizsrN?=
 =?us-ascii?Q?bQrFCDERXaMAR5XjgJjk5VUnKOu1HA5F22nEEhRiBkFa3mnfa4NqtOVOI8r2?=
 =?us-ascii?Q?qjUZQeNGTkFguP38fD09gFXJ0srVWClaAJLF+0GI/jsDdmQObJDC2kCTo5bg?=
 =?us-ascii?Q?cm3o8Is7NO8TM66gWLM0bQ+shxyH41ozEXmx3xOc7QyMGxDCokgsEyV1mYmZ?=
 =?us-ascii?Q?Zkjx/rEJbHto3QgcgJ8lv3UJguPtYx9m8e6Q612MiexYoxoRBD1vrwhBjAqY?=
 =?us-ascii?Q?IXVkzBVxBdMgphPnl+47Ik9gqxAtBeFlKDSPTIjKJANgd55cpMx1B2u25tHr?=
 =?us-ascii?Q?QHaS011zcanlJeWGaRhzPahXyfEGwXI9S2CzVT6qKwkc9xAS/HJSv1rVOwGl?=
 =?us-ascii?Q?SmnDrzd7pYapzzhFcYEvMEpY3ViRXrA+ihNHTxIOYfh83F5GSCbz7R58aQh7?=
 =?us-ascii?Q?7EEREJ0cPNIuBhlGmZJp37gxZhl9JxNRUvgJVzTFOgjmnxXQsrzCUKjUBFb8?=
 =?us-ascii?Q?CP1JOCp1TTKv1VRWTI+Z6LOjO8wb9/gmsDvs6uyc8WdrVd6rkP2LMneYVNpx?=
 =?us-ascii?Q?D8gBK5LACDs+Cx1sSv/NEr0m2E3YIuHkxFLHNdQQIXVNPj6glUPZRpXzV7H+?=
 =?us-ascii?Q?LWKOJ+XPdcBejaK4eBzh1k7tM57HQd3LiXdxf6KbZJd2EEyrkJR4Njgdhda5?=
 =?us-ascii?Q?x64uDVpg5kA9DidBcXzxJgEk8emoYLchtZs4lw5n0CjcVPscjlsBKuBUiDgT?=
 =?us-ascii?Q?ivwROEKih5O4utWKNqb58AEqtCUkdjJXBBvbJjIjU8vEjUXq0LMhOHgNss6I?=
 =?us-ascii?Q?vs2Tj3RwSVBUvtrC+G/xOvULxl1Eqk8XcNm6mmPTzTjkFHVbOX/gQuiGNpY8?=
 =?us-ascii?Q?o/F+MLrdnD8gShxSaiQIr0uSDPpFyC2iNWBGZdOw3z5lFfKyIba2tjLoNpP/?=
 =?us-ascii?Q?nCZXv+JVtpD1o7CZF6MUDOkaamlsfHLRu+bZBGz5FMO5iIyuKmP5DxcbPQAb?=
 =?us-ascii?Q?u5dX3T5+B2ix4x9xk8BQzq+YexJ2hIYKeKTEZu1JT5RstAT34p07JDEEz5bn?=
 =?us-ascii?Q?EtGpvJrcZ80LgmKIBgVbBYVnmUTXjVfTyTtAs0bA8e4NSwkwwM6YZzej5Kkl?=
 =?us-ascii?Q?uNzbhftTjihDKwkeCagVlOWStwZx2j3ly1iTe8LMx0talogQR4Y16iDRMBgC?=
 =?us-ascii?Q?VVM5Pm/8GsNckQu2C8XLMd42V3vsmvNb9gLia0G8wE7PJqT1mxy4y5JfQnEm?=
 =?us-ascii?Q?4CBsxBX0uyZwqGt49pzicQut+ZBdenzHmQ5VMhG8CHXmaiaLBjc8ubtjQFW7?=
 =?us-ascii?Q?+8twqe2U8WyvxWp5y7YjVixpf0bZZ6nvT79+rIGt17jjFgwxofR9AfPy1PdU?=
 =?us-ascii?Q?Yeoi6H5GBGyQRWuIC6xv9lhNbqtcIRANAGVr4nikFUMXT90jknrJojdo72Mx?=
 =?us-ascii?Q?XAE1Bw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(30052699003)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:57:22.3081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e4e8f3-cf54-4276-9076-08de59168710
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9784
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
index 1bbc5d94db..987bfba7d7 100644
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


