Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EE1FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHS5V-000392-K5; Mon, 27 Apr 2026 15:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wHQU8-0003Aw-UZ; Mon, 27 Apr 2026 14:15:18 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wHQU6-0000Ji-6m; Mon, 27 Apr 2026 14:15:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haV+/KDRjSy3IcUYrbMeSdZMFbUJJ6bS5fJaWte56miZpHBBXqN3Dr/60LDKlWwVoAXp1kvo80MRL1iW6Jc4EaAkln02gwz4QPDKcK0RZo26Uz1eGOdJUsZI8OT3SDwQwyuZNWIm4dD6v+cK3rXZU6ZVqK3aFQH6tA9lbLmgXSTFp+Iklhrn1K0mueAgvKz7ZkyddEzYierTtbxAL6TksEayLoN0REfoWz13e8nKcLRkLh9y/Od6foIIUEHN9I+5LM3LcJGaVsf/wX6fRZblNbwpWn04Al0j/ZCxFSZKY1iR+XBNtqyl2uNFL/fbDFzeU9pPflBAOL6Rugpk7FAcyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Anam5tdNgehzH5xKma/xc3k4D0B0r/APBocD6aQy0rg=;
 b=JsDz3UQi6RwC88LsEe4lB9HLE7Z0c7g0w81DbvCgCB3Mm84VuiwWOJsa68Ddg2gEnEQcgtnadqT9N1cuFSI2QIB6FrmOymfozHD2VJN5NglJYqpwYbB1s1TZjUUz0LIfaIgQyVXa6qGkJlZilFVTE6fvEq4Ue6cqpkVP/bWIgLKMWm/j9r/MevbSGjapVC0GbXkidwRt1Lh5e4TQC2I8BxzU1FYJ/vXHe9S61DnswkQecDufnZZD/fudO7QjHApshGPp2pHusJ/EzDn83AeZqcltL/tuwvrXc1Rk60QDbfN8X249WDVT3N5UHFYSWfp+9OISbQfDS4jvQXlNri5uFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Anam5tdNgehzH5xKma/xc3k4D0B0r/APBocD6aQy0rg=;
 b=Cd/XjHzZXOZuYHCWJ2TVtl/92DrORSJixpYXck2v+QlGW/5pNFIplYyG9dmXEJx+kUNdO5qKJBVTGynMQWeORTZeAJizcuZ759yfwjzQ5Z67R4sUH9Xeg34voPDJsRpuN9Yj4nuxyhU2IIq5fBYoShJ8cM8VUx4GaX8l0Z3UGTKkteotIm73jsSgGngaihgyj3XVjHfRx+1iikFq4qXrzxc4oTiMZdgCa/0I5hcG4WG9Afiu5YyfBvr8hoWcEg3DjVnR9UjqxNORRTkJVdSETplo5mzd3QvOB4PdHn5llWJXD4V/xM8FVY6g2MVjwpE8oH/tXOEl8Bthxt/SSI82cw==
Received: from BL1PR13CA0014.namprd13.prod.outlook.com (2603:10b6:208:256::19)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 18:14:50 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:256:cafe::e9) by BL1PR13CA0014.outlook.office365.com
 (2603:10b6:208:256::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 18:14:49 +0000
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
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 18:14:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 11:14:25 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Apr 2026 11:14:17 -0700
From: <mhonap@nvidia.com>
To: <alwilliamson@nvidia.com>, <skolothumtho@nvidia.com>, <ankita@nvidia.com>, 
 <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <shannon.zhaosl@gmail.com>, <jonathan.cameron@huawei.com>,
 <fan.ni@samsung.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <marcel.apfelbaum@gmail.com>, <clg@redhat.com>, <cohuck@redhat.com>,
 <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
 <alejandro.lucero-palau@amd.com>
CC: <vsethi@nvidia.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
 <zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-cxl@vger.kernel.org>,
 <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 "Manish Honap" <mhonap@nvidia.com>
Subject: [RFC 8/9] hw/arm/smmu-common: Allow pxb-cxl as SMMUv3 primary bus
Date: Mon, 27 Apr 2026 23:42:34 +0530
Message-ID: <20260427181235.3003865-9-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260427181235.3003865-1-mhonap@nvidia.com>
References: <20260427181235.3003865-1-mhonap@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|DM6PR12MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: c8aa36e9-57e5-4663-6885-08dea488df16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: A+PgMTlVfr0JqiZxRdAcyq2HQsNV2E+Av7sBmviJamNDoC4vIQhu2Qe2yNnrohAXYrUOokCM5/v24PUHvgsQs/z5NYvQqIKcn+Nswc9yUKmjnvNzgECRCsj+kx2K4vobQZAA/oDWzlEoQ9WYf+mLLfMgpfo/nhzRPw5cs3Q4ZwFJouKYSCd7AkFkZNR3iA7urFl1L2RRYuzQ6f0fj+daObiiQTomdMD685iuHil+HwFKNNu4RQQVBLyPo9fhb9tyBsBVJ+X+G3DkYRKc09CHcB2VzRgGSutLuQeYu1jCQ1yUhwddpa9eVZIU1mdQYzXaeoIWuWrdHFwT0kQzc5HnwcgJf3zOy5rgn8Y5xnqfjVsUai2mKUI92PvwzlRZz/EHisFsI1LduqP/2dnfnBaHL9LUcjrv3ozksalo9N33zFQK+yLB4T6e9F3naUzCKNOdHOLOdBpGcCjAeQHAXPHd7+J13uhpJkAlo7+Hb5O0h/fLMHc3/vXJo89CfW6elqRCUfCM5u+UcLjt2csX/7b090XJQoZTgLnfx42M99btxBl7clxHhBzXwehD7Zb4liOQ2+52CWjPRAgmTIr7mdM3genqKkFP5vNtwJH/6587+WdiFXZ51VeSkCGIR8BbRQdJPe+D7OB8lKLis7KmIUibeDoClyPLxEdl0TSttHdCMGus+LoLWA5+SF/T+mXffdQ90z+YIMqjdwouMaTPNEOB3sKQpKjoUXVIPa+dg9njxrGU/UyR5RmUguIp2DcJZ82/C8O31nicDGEyfquY0mjnZ/ZF7/E8T9CKeJyBETFb5ekKtE1xAeAIbndrT+Cc7VSg
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /ZjmGiA/lXKWndNkD2yNgYekGH1Yfctloq3Jrm/QyWSWBGe9KjJsbDDULFvAf+9cG0jG9W4qpdhwLL/GG7iw+foQbvLpOHvps4tP0Sfz6Q2vEIyQ86Egr6Pu/SIVeckBfA09iYrtqBLaOLfsqLqJWli/hn8OQE++N6JOK6e378VoHIo/fiCrzNHy8m2PYmZP3LxxH68mxCIIYlhMHev8ksrO6MIL+ccjpYWj853Pl3GjOStCRc/sfFvdR7aHF0/9jrV+iS0dEASxfkCi6a3HrlCcTvuLWF8VW/6+za8/qFqBOu/g9uKy7prNsGfGCtjjUBC15vmSg4kkBDNJE5OrcNApfmt4cvjBMPP7TBsU/epVLXpBss+YKlanYVBBii3S0NE0bf+yx3eSMxml8or7Ur14+2NkVxjlrIzD1BCPkaOzkOLsF3VKSSBXX8bYGKEt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 18:14:49.6680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8aa36e9-57e5-4663-6885-08dea488df16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=mhonap@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 27 Apr 2026 15:57:41 -0400
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

The SMMUv3 primary bus check only accepted pxb-pcie as a valid root.
pxb-cxl uses the same PCIe-compatible bus implementation; reject it
and CXL devices behind it cannot reach the IOMMU.

Extend the check to also accept CXL buses so SMMUv3 translation applies
to passthrough CXL devices. Update the comment above the check to
mention pxb-cxl alongside pxb-pcie.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/arm/smmu-common.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 58c4452b1f..eb52ea1976 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -963,19 +963,18 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
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
+         * pcie.0 has no parent_dev; pxb-pcie and pxb-cxl do.  Accept both
+         * bus types explicitly so other root complexes are still rejected.
          */
         if (pci_bus->parent_dev) {
-            if (!object_dynamic_cast(OBJECT(pci_bus), TYPE_PXB_PCIE_BUS)) {
+            if (!object_dynamic_cast(OBJECT(pci_bus), TYPE_PXB_PCIE_BUS) &&
+                !object_dynamic_cast(OBJECT(pci_bus), TYPE_PXB_CXL_BUS)) {
                 goto out_err;
             }
         }
@@ -988,8 +987,8 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
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


