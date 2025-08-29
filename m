Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116AECA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN9e-0004et-Qg; Sat, 30 Aug 2025 11:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruTs-0002gY-C9; Fri, 29 Aug 2025 04:29:09 -0400
Received: from mail-bn8nam12on20619.outbound.protection.outlook.com
 ([2a01:111:f403:2418::619]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruTk-0006Jz-RN; Fri, 29 Aug 2025 04:29:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F61t5T1JA5P3R+mQQRnkJbooLc6OcV8Vz7hIcHqbsadKhXnEe2UyK/YkeIGcptlWZfRFYdJyMHmIUwlp0SSfG/1ZhWpqoxCcK/HQtifpEcd0msrXp6JXudulAvWGwjZIfnmXzMrFrdoNBKj04skCl2TejriS8r5UwoOZMPG2B+aMPMGcNDMXjjib5D6Bx9B0PwOf8kjTIyqbbPTOJ6c6WJBCtGuoHfotwFIaihriaCTcWNjsUw7/XfAoBsf4hdnDQUHdr+VOcDEPxUgKDuFm5axV3UmN2PFFazekn9ZGIKToh33KJW7r6DQyvV7zW5v/M83rF7sD78oTQIKP/HYuSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FX3c4ovDJyk0ZYEzLNG0uGDTxPcJxxvbLiNFyA4iA5s=;
 b=ZWGQ2Y7kKwNKl+NjFZiWlCjKFreDNNwMF044pk0iKHIojmF6STWC5ixeksxy59t3HXBxhcifDRWiXGbRp8DSsQ0Ro0MbMJnRTpteXB3uajzJ8y1Sn2zwdcWxsciXI672EI/RcXZUSHrntmCeQNnytssemqwszDkj5kZKuLTixGM87ktQNpkoRDuOJTGrxcxPagfvGG2hOkiADOjdCPFrtXVJZ2otws7EVGIEpS9/1pFe5wT5dBm6uh4eMZmZAJ6uqUdBKe5ekvxIhc1JxABhg79FoChV0ousL8eMP2R2fYkAbFuDzz9YNfJAW03Ir88Z25gEwepCZAKHQEqF3KbvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FX3c4ovDJyk0ZYEzLNG0uGDTxPcJxxvbLiNFyA4iA5s=;
 b=jMrAN0qtmBj65TI181p98X7d4C9+Q6dud+gFMciIsEabupbAa1+l3OPY6tIbpftj4CkHmb4f3ApCNDto7AmL+N+2n+7T1XOH4EkBl6cgXN51COmBYGljdAFt2G1M8K9x1jseVClIAeltbx8QQd6IyvUhiNq1IQx/B0RCRq2bxyBGTNaKfDHFrP6ZE1QvwpK7qaiUDz2B9sUO1Un878qQzKC7HgWOEIOMNHtx9hcDYA0jGsnMVcQHULDzGMV3XcrhHnNA8U99SQnGAvqe0HSC0L/I9QTBtBkMCjckJjQsJaCbx9kMAM1gc/57IMexwvVTy/lKSGTOsK5nV8WiCCEVFw==
Received: from SJ0PR13CA0046.namprd13.prod.outlook.com (2603:10b6:a03:2c2::21)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.18; Fri, 29 Aug
 2025 08:28:53 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::4e) by SJ0PR13CA0046.outlook.office365.com
 (2603:10b6:a03:2c2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.12 via Frontend Transport; Fri,
 29 Aug 2025 08:28:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 08:28:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:28:40 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:28:34 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <imammedo@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v9 01/11] hw/arm/smmu-common: Check SMMU has PCIe Root Complex
 association
Date: Fri, 29 Aug 2025 09:25:23 +0100
Message-ID: <20250829082543.7680-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829082543.7680-1-skolothumtho@nvidia.com>
References: <20250829082543.7680-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: 2308e3a9-584b-4775-fcda-08dde6d61600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vzoXy3QINWwmWTrdme96mKJbh8K8Uav6yVjDrHAQhdrUl2iHRxrWumLj9FnI?=
 =?us-ascii?Q?056Xch+bMFa0NQGiZP4Lrf2HVkI/+qlN7RC+PbuP+V4qLSj/XsfmJ2ukMzJE?=
 =?us-ascii?Q?qhdCZQhtlKnGYJWmGuiaf5hBh4qhfuqGmGW+DSe0tOpa94f+NdC7YkwwkD7r?=
 =?us-ascii?Q?tM2dcBgO0AXpBDaYebG3x8xRPAGnH1Y8fYhEiMwVuWqsoy24Jwz4BolzxQvl?=
 =?us-ascii?Q?dN+RxjvWwOz1BNk7Oc0dGRPzhhCMOyHQnZ3RRIWDxRsZR08yT6NK/8QmdSnC?=
 =?us-ascii?Q?BqlhGLu37rk+uZIB8zJ92gGqjF9U1KjCWKEg1qMelFJQ6B0nHD5VgtZtYANn?=
 =?us-ascii?Q?dUORnl8XBP70BCXcCNFy6fKNAj/hLN3jl4y0pSZPvXQpacxaPxz/JuEHd8NN?=
 =?us-ascii?Q?ogDRUIur8B371DYKj6Uv6wcT1s38FZn2zpm6v8rBmWbf7tViEyGYfRNBAFz3?=
 =?us-ascii?Q?FMpuSY4eQQfav0Qpnkh/SPmjl/P8/RzVuNFFjt0YzXg0t7Q98IJX/MAwNVIk?=
 =?us-ascii?Q?qYuxhc7e5CsdqKL6NgDJ9GkqrjsdHnOYH+VEivfp00DfnR33xBZIosbL40Xi?=
 =?us-ascii?Q?yB4jmmMJss8gv/X6WMBPK2P68v7V97QDMNWPaP9jwYOrk8D+Q7azsc9881+w?=
 =?us-ascii?Q?v6Pt/GtX9QN1dQ9d1ExHUFPfFJ0KO8nvG9rJ3CoR+bao2vqlYMQRceR9HVo7?=
 =?us-ascii?Q?wThOa8gqXYIcsEB65G3daUvyiwq5cYmbgo5USh+eQsbBozcH1Cu9B79/VBFE?=
 =?us-ascii?Q?zD1kC9ccak0FvNptFvBNduYOKknPiRYLexVpm3Fi7tJa3emjTI0U7IbFWLO5?=
 =?us-ascii?Q?TQhlvp4nn3tLFRRvD/+fsg9V/84c+80ywqfyp5b2lyBTMf6ZCNJ4G0Pv87KM?=
 =?us-ascii?Q?VD+6vbKYX91wi69iLjoemsQSAGxUm6M+Z37xTKNhsOyv66Mk+86bnKwvPi8F?=
 =?us-ascii?Q?/47oGMOtHlzwQbUqxr1loe/2uc3LD0R3hKGQjan9E4ngxaVadpi8qA1z/YOA?=
 =?us-ascii?Q?cc+zQBH+uE7xWHzZzY7hFXO8Kz3Uwn/ZwBkT7B2kJeBvf8+1KAoSWlFRfzuq?=
 =?us-ascii?Q?yz2d5XrUtqRWcWJq5CSk+er6AjcfEg3yHKtBt/8k19053nY6lrC2aawFPOWt?=
 =?us-ascii?Q?HiHQ4Trsiq0IXkaBrVlSlKt+Ihn3y0TeE/vDih6fJrmjW9BHcbldLWJqWaxD?=
 =?us-ascii?Q?2amiViKR/hET/Pkd4/dvrPZTRwrGjsNb7/rmsUgRXrNeot/KUPldOl5uord9?=
 =?us-ascii?Q?tFqLwsi3Gq8zn5kk0PowixDa6qkDTWMCCKov5XBokSvDObjtSh5OD9rrGvWf?=
 =?us-ascii?Q?xzNHKT2J41D8V7AJz/NMhrKYCccx5vLFo/8MsrUwUnQCxtwR+BWtCIbzY1/f?=
 =?us-ascii?Q?uplQEhUtTcnsW7dJAtB7htoiHZD1IzmTkSNKI5lW3ra36sKLjMaU3pz3Qz/P?=
 =?us-ascii?Q?wcskLIkDUtsFG2v9Z/02yHlIjaWp+vzS5b2NkC5Cm+JBY60XG1ezmjgdrmOc?=
 =?us-ascii?Q?8AIzC+4OtAFrJHNRJPs2OrVUzTMvkvWF1MJ7?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 08:28:52.2679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2308e3a9-584b-4775-fcda-08dde6d61600
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245
Received-SPF: permerror client-ip=2a01:111:f403:2418::619;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 29 Aug 2025 09:59:54 -0400
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

We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
root complexes to be associated with SMMU.

Although this change does not affect functionality at present, it is
required when we add support for user-creatable SMMUv3 devices in
future patches.

Note: Added a specific check to identify pxb-pcie to avoid matching
pxb-cxl host bridges, which are also of type PCI_HOST_BRIDGE. This
restriction can be relaxed once support for CXL devices on arm/virt
is added and validated with SMMUv3.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nathan Chen <nathanc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmu-common.c                | 31 ++++++++++++++++++++++++++---
 hw/pci-bridge/pci_expander_bridge.c |  1 -
 include/hw/pci/pci_bridge.h         |  1 +
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 0dcaf2f589..7f64ea48d0 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -20,6 +20,7 @@
 #include "trace.h"
 #include "exec/target_page.h"
 #include "hw/core/cpu.h"
+#include "hw/pci/pci_bridge.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/jhash.h"
@@ -925,6 +926,7 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
 {
     SMMUState *s = ARM_SMMU(dev);
     SMMUBaseClass *sbc = ARM_SMMU_GET_CLASS(dev);
+    PCIBus *pci_bus = s->primary_bus;
     Error *local_err = NULL;
 
     sbc->parent_realize(dev, &local_err);
@@ -937,11 +939,34 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
                                      g_free, g_free);
     s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
 
-    if (s->primary_bus) {
-        pci_setup_iommu(s->primary_bus, &smmu_ops, s);
-    } else {
+    if (!pci_bus) {
         error_setg(errp, "SMMU is not attached to any PCI bus!");
+        return;
+    }
+
+    /*
+     * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
+     * root complexes to be associated with SMMU.
+     */
+    if (pci_bus_is_express(pci_bus) && pci_bus_is_root(pci_bus) &&
+        object_dynamic_cast(OBJECT(pci_bus)->parent, TYPE_PCI_HOST_BRIDGE)) {
+        /*
+         * This condition matches either the default pcie.0, pxb-pcie, or
+         * pxb-cxl. For both pxb-pcie and pxb-cxl, parent_dev will be set.
+         * Currently, we don't allow pxb-cxl as it requires further
+         * verification. Therefore, make sure this is indeed pxb-pcie.
+         */
+        if (pci_bus->parent_dev) {
+            if (!object_dynamic_cast(OBJECT(pci_bus), TYPE_PXB_PCIE_BUS)) {
+                goto out_err;
+            }
+        }
+        pci_setup_iommu(pci_bus, &smmu_ops, s);
+        return;
     }
+out_err:
+    error_setg(errp, "SMMU should be attached to a default PCIe root complex"
+               "(pcie.0) or a pxb-pcie based root complex");
 }
 
 /*
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 3a29dfefc2..1bcceddbc4 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -34,7 +34,6 @@ typedef struct PXBBus PXBBus;
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_BUS,
                          TYPE_PXB_BUS)
 
-#define TYPE_PXB_PCIE_BUS "pxb-pcie-bus"
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_PCIE_BUS,
                          TYPE_PXB_PCIE_BUS)
 
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 8cdacbc4e1..a055fd8d32 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -104,6 +104,7 @@ typedef struct PXBPCIEDev {
     PXBDev parent_obj;
 } PXBPCIEDev;
 
+#define TYPE_PXB_PCIE_BUS "pxb-pcie-bus"
 #define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
 #define TYPE_PXB_DEV "pxb"
 OBJECT_DECLARE_SIMPLE_TYPE(PXBDev, PXB_DEV)
-- 
2.43.0


