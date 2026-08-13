Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E07BC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuVAd-0006b3-Kn; Thu, 13 Aug 2026 09:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wuVAY-0006St-4d; Thu, 13 Aug 2026 09:08:26 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wuVAU-0005RF-8f; Thu, 13 Aug 2026 09:08:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLjLiQuEkEoHpEzH8FfOslekZg3cWRmhxxaZxN2Q3WMFRYEyNzNoW1eMZYwj0zcw0BIOoL0C4WwEmpnOyfYSXVRvWre5eh2+R6VDg5EK2SMd4Xfgr5ywUvp0xbpCiOxGGsxMdUjLzaQHZenmPn7WWDczRfqDD8DTXlwIQMwusZfcwpLkBL5a/qxp5V4DULdAUAuT9oq8RPbWmaMcNVlzP+0/crEiROsCJBYBqhaLLgTvw/eYaX8vQt7kxmLp/ym6WE3dmZ+QEMNHDREFOJAnCxXHlLllZPGKrhr83rCYTp5txlmbwou0yIH4Ejc0UYudee3cp77SbgbOo1eVlDWKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2z+jBRT+Mb/Xc1Xaxj7RiosNs44MfVTACU9UAfKXYY=;
 b=aB3nepKRTC3K7hyeyEkEm/uf2ySr4PGzVrMrMmEzsBU4KHpIAUNEdtep3fWwkv+PXB0hfwi2zpEHGV1RKogjQeQF+Rbnp4agC/bUyoqO6m4SAQVMv+4xS85aqCYTWG+218teOqqA4/6W0Krx1FF2szW+NIC+OC/tVVzQ2j29H0XykB8ULK/FqBA4XRqbuVHNPKTRz/0nhXhI4QYkufmmco1qm5avgzUypbZFErT/Rmgbrt82vRWBqnmWaH5t/JKCCqeo/C375RQmTHZMugw8RZYc8njipVaDSMJLTzQWX0HDm49sYmL8Y2i8h6KNDVow4KfDZ/R+q0ajlgXRtMhFOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2z+jBRT+Mb/Xc1Xaxj7RiosNs44MfVTACU9UAfKXYY=;
 b=o/O/kYMv98xWBZxcgCoPUxweLNmJJahPs00+k2lZDtz74mn74nlHThmmzduoIbKrRu5DzC/RhoVVYi9ElQkFf36SrkV9TfK9zpmfL2iVgGEQrN5z+A8w8oVIRYVpWtVj7aSaF5w0L6L0XV25dSGX/3Wp8jhhxw2WuFW4YhvoEPwKdWCKzqDk4sJlbS3MTUYLS6a0T9WKiAc6Nd7MG5bFBv1589QOBfmUi2B/c3/12vVsYwoGWO2Hmt2vSMSpyESfMCnigIB37jjCTEgbi8bSI5XxyZJYqqp2EhZIBAx7KpQX07oi/eI/wC6DAsvQuq10EVfUXBbejQ7eaesEipAs6A==
Received: from IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17)
 by BN5PR12MB9510.namprd12.prod.outlook.com (2603:10b6:408:2ac::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 13:08:11 +0000
Received: from SJ0PR13CA0095.namprd13.prod.outlook.com (2603:10b6:a03:2c5::10)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 13:08:08 +0000
Received: from CO1PEPF00012E7F.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::7d) by SJ0PR13CA0095.outlook.office365.com
 (2603:10b6:a03:2c5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3 via Frontend Transport; Thu, 13
 Aug 2026 13:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E7F.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 13:08:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 06:07:40 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 06:07:34 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <pierrick.bouvier@oss.qualcomm.com>,
 <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <pbonzini@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <clg@redhat.com>, <cohuck@redhat.com>
CC: <kjaju@nvidia.com>, <vsethi@nvidia.com>, <zhiw@nvidia.com>,
 <mhonap@nvidia.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH 09/10] hw/arm/smmu-common: Allow pxb-cxl as an SMMUv3 primary
 bus
Date: Thu, 13 Aug 2026 18:36:22 +0530
Message-ID: <20260813130623.2499506-10-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813130623.2499506-1-mhonap@nvidia.com>
References: <20260813130623.2499506-1-mhonap@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7F:EE_|IA0PR12MB8349:EE_|BN5PR12MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: b1fd7ff3-8bd2-4257-38e9-08def93beb8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|1800799024|23010399003|36860700016|11063799006|56012099006|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: W4a3NJp3s1F9y4+hvwu8LLJGl3EhuXkCouDh5OiCiDtdcRnQyf+BA4X9ypKmrIzPEA8XyWN2KExuAV1fDCygM8cjbW8mdx2m+HDE9BT8Y2DHYztJUSTUFS22vXKLIxkrj+vm+S3om1TsirHtmn/ZumfNZBKwwI8uba37cBPuyZOUaeBCnA8xx70la1oIHeyM/FJErF4h0cRyUUBVoMzhsu87PpDcUdONtRcz5zgxKwxbXokuNUN+5MPFE6KyyDYvnpw2/BNcnzFA8vdB8JugObWkerv8Sv8OLT5Py1zw6NOaE/4PeKPg0AF1eAeH6dXdBu5FctpSvEQWRzqcvlvDus6I9YsLI0rJIGDj5oDw2+VH5cX+6LawHPaMxTIStkFKSqHwS3fsIydk3OHLvFVPmN2B+bhMkIxybBqFzHVq/4sdCklT2uGe8MjixF8JZeZevyH4j/2ge95NHO3kLZtqZcyhx72hrsjZPhdgwWRHiheD41bLx+e+fjHGMTt4gqdayzHC6wgOiJhywAAIBNb8vl8mtWlBRqI8fC5+x/YmqJHxS06/aEG/w3Gy+KHkhn3SKfZIt2XDwjz9l3ll8tiBgYN2BhjAOvI+G5/V1BORVnI+Ypdc0+q74yQfyiqwFfq6Sza362XfPfuhFKBCyLNpl4TBQ+dyhIuU+aGmnp3Jb0p9WxYE54JYnZCgkn485W3RAARdTo1CrddG3V+AW6Zl/DHqXjO5TJe9bqaMLTqglI19556XiWcYX/crxGUyOAT2
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(23010399003)(36860700016)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1zRN9/4qeKDKOYEV3+zN4TwuaGitjBc6XDQpvXH60KVdAsjZV92hrt6HO40i9eFYzonizYPaUoQu6ZYP37vFMoHn+Xcbgii7v5Tf30EaqdPJ6r0RVcMX4SxvoFQR8kNMmmZKCYNWas6N+D1OmbgPpMwZGOvzsuoi3Y2U/4XsHu8y3J5uH3Tgi10Ws1INDJqSRJvELx2nSR42lB1m548ydCXDFr9b1ZzonsL51qtnKECKGA3k0HOPx9z8kBB+9MppvdQh5hW1b5MhGUq67oqMYvmkIv/VJfMxuced4G2xsD/ZpsawvGBfDYS+omwgtGzs2nM/rG0WTBiFoDFNDlUyW9UzYW6ylOTpeVfojicHTt3UBNsRBriz8SC6bBcNLmKiOX9AEy79djt5+A3A0kujCs+dpU8ioIt7aLx4NthoLTtOh8Vww3CeowNJcwGNOnum
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:08:08.1916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fd7ff3-8bd2-4257-38e9-08def93beb8d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9510
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=mhonap@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

From: Manish Honap <mhonap@nvidia.com>

The SMMUv3 primary-bus check only accepted pxb-pcie as a valid extra
root complex, so a CXL device behind a pxb-cxl could not reach the
IOMMU: attaching an arm-smmuv3 to a pxb-cxl bus failed at realize with
"SMMU should be attached to a default PCIe root complex (pcie.0) or a
pxb-pcie based root complex".

A pxb-cxl uses the same PCIe-compatible bus as a pxb-pcie, so accept it
too. A CXL Type-2 device passed through with vfio-pci sits behind a
pxb-cxl and needs SMMU translation for its DMA and ATS just like a
pxb-pcie device.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/arm/smmu-common.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 8e40ba603d..42fb098ab2 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -963,19 +963,20 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         s->iommu_ops = &smmu_ops;
     }
     /*
-     * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
-     * root complexes to be associated with SMMU.
+     * We only allow the default PCIe root complex (pcie.0) or pxb-pcie /
+     * pxb-cxl based extra root complexes to be associated with SMMU.
      */
     if (pci_bus_is_express(pci_bus) && pci_bus_is_root(pci_bus) &&
         object_dynamic_cast(OBJECT(pci_bus)->parent, TYPE_PCI_HOST_BRIDGE)) {
         /*
-         * This condition matches either the default pcie.0, pxb-pcie, or
-         * pxb-cxl. For both pxb-pcie and pxb-cxl, parent_dev will be set.
-         * Currently, we don't allow pxb-cxl as it requires further
-         * verification. Therefore, make sure this is indeed pxb-pcie.
+         * pcie.0 has no parent_dev; pxb-pcie and pxb-cxl do. Accept both bus
+         * types explicitly so other root complexes are still rejected. A
+         * pxb-cxl uses the same PCIe-compatible bus, so a CXL device behind it
+         * needs the SMMU just like a pxb-pcie one.
          */
         if (pci_bus->parent_dev) {
-            if (!object_dynamic_cast(OBJECT(pci_bus), TYPE_PXB_PCIE_BUS)) {
+            if (!object_dynamic_cast(OBJECT(pci_bus), TYPE_PXB_PCIE_BUS) &&
+                !object_dynamic_cast(OBJECT(pci_bus), TYPE_PXB_CXL_BUS)) {
                 goto out_err;
             }
         }
@@ -990,8 +991,8 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         return;
     }
 out_err:
-    error_setg(errp, "SMMU should be attached to a default PCIe root complex"
-               "(pcie.0) or a pxb-pcie based root complex");
+    error_setg(errp, "SMMU should be attached to a default PCIe root complex "
+               "(pcie.0), a pxb-pcie, or a pxb-cxl based root complex");
 }
 
 /*
-- 
2.25.1


