Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1377FD3C907
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKPI-0007OO-7a; Wed, 10 Dec 2025 08:39:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPF-0007LY-An; Wed, 10 Dec 2025 08:39:01 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPD-0001LB-RN; Wed, 10 Dec 2025 08:39:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCRntCI50UpLRQt4EAFDMhKrnF+TMBbSu3xw1SQv0GRl43hCg4obXu2mUjj47fKjVwaC1jqUKfSkzSpq70wHGEdAmG3gydxkWvPpOSorwgn5CbbWFeGGuzJm3ti7TbmCFJJOcI3F2W5Pj8sNcYHtXCRgrUBgrHVpW+WqHOSXFSoiMdt14lLLxsBs+nZkAhxJNTZtQc1OeRf2pneS/Etq46XS22jSxZ+EJ0HDkuAjTntx9tyOuuxj8bnV7KrZWCJOsU4TR7hkzyF92gS8zTJJRtAgZB2S112sBbTG+x/MthrRTfFQAHbXqMFpPCwotmVVUqd2uy0CK8dn1pJNAa9e7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GiwW0LpgU506wgMYkhrGtomFcAqr5ErZ8h9iEmgWVs=;
 b=FuZGtB0TmA6D0Sqn4h2nFtBp8m2YRMYoMiPPFDwurjgJcNanSOo5ghQ9R8M/WAtDwZcZCEKbfsFCyHYlifJQsALvx5T3eMBhu0Wdo+GdNSSZr0bPeaJ/J5spfj4B3gHYeqi+Pr4kUr5TX444/yTQm59+D8ScMqOn/K2n+tpar2HTfn9OBz5F7sL6abR3LaBkuy4StNhgN8y0PNlaSly76Omv+aQbeBPby5quFzzfogq9GE/YDtdGKw+YQS8oTqtex8ZsVbBV0SmIwmprW/iIBp0Kwte1a3cV8CEiQMEwEkoNGh/qxbBvcEVtJSFmlQ+naf/Jy17qMQ++vAFi3V4pMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GiwW0LpgU506wgMYkhrGtomFcAqr5ErZ8h9iEmgWVs=;
 b=Uw5UneG4z+ilN4Dre2oIXWR7SPUpgwVMuvZh8WXFtJBBnGp5Yf/CEDRYk8MGBeH8l1+Vpj1A1AqxfEWgOLNZo2AquFz1fOB0Hm/BXVXdDMn2c1gQMY88SMSu66c3cQ7uTN0cyIwwUw9Y3POdMYY/bL58mX04TfjUwOuWfU39X8mdekDXMkq99G5qPvCTUnlhE/CYdDDd5ZmDPpjI6yBdvR7runD4l83z87x4k0myfXdqYhTvsqVhzt//lyWrGyyGFP9Z1rq90CVvsNzd/Xtw9XvBCzvDLYaJ8z3kx31zxPUggc8PBkOMD/0Lw3ApldybZGiH2CXDekmp5L03J/nhvQ==
Received: from BYAPR01CA0069.prod.exchangelabs.com (2603:10b6:a03:94::46) by
 IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.9; Wed, 10 Dec 2025 13:38:53 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::95) by BYAPR01CA0069.outlook.office365.com
 (2603:10b6:a03:94::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.7 via Frontend Transport; Wed,
 10 Dec 2025 13:39:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 10 Dec 2025 13:38:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:39 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:36 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 06/16] hw/arm/tegra241-cmdqv: Map VINTF Page0 into guest
Date: Wed, 10 Dec 2025 13:37:27 +0000
Message-ID: <20251210133737.78257-7-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210133737.78257-1-skolothumtho@nvidia.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b7e91a-b28f-4dfc-3dcb-08de37f17596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+CbNV2x5ksbsAQWAyPvwfKuw/CVfbHWO2+q/mWlwlNb0GELOVO8V6FcSHDad?=
 =?us-ascii?Q?l+my73sz3yzO/PaCX2OqTpnCsZZLHgxhvoWKVvOgBL7VBil5uq/Le6MHMqCQ?=
 =?us-ascii?Q?01WAmhgO6dScMbp4ucMxKcTmX/c42zQ6Dfqbnwz3mdlU83VM2nfuAzKX/fId?=
 =?us-ascii?Q?e6VLyIq9FZyKw3+GCUkIUoYTicFnBGa76HYhR9j7MtMOySq1ltwz6I4qkdPQ?=
 =?us-ascii?Q?s/YpysAF7wgf8vKsthxZNV8U3w2tHnNaG30T+aL0OvJeEIfc0/mRtmK4eBwK?=
 =?us-ascii?Q?GWnfC+qvbyLE1/1WbQGE98RGPfIUxXYFPIT3jdkZqxs1U3fDzgTOrnFH33/C?=
 =?us-ascii?Q?Q5tfMO2xufjDJRe+uOs/gFI1NA1Glv04nitqorTRnNdfqwNm3Bv4bz/sDmrG?=
 =?us-ascii?Q?3NPMjjBM8HHE5+bhcItE1ffOUdOG+vam1gzrSlNhi9CUAz4+L/ERffMWb2P4?=
 =?us-ascii?Q?GFYkl+a5OxCefPHB3zzWa6xYm0s3SBoWU2s4g4241RM9Sk86vYKDxC7BTkLy?=
 =?us-ascii?Q?7IUwvoNuXggdqQ+D4kxDwArXWhZeNNVpd9lCH5xzbeV3keA7ILuLBM+pa5Bt?=
 =?us-ascii?Q?LAg5ASukfTBnseHoiz7Jm8J6LB8YH4QpZvbZcBSdGEWdMRTKR9eh1bb6X7bV?=
 =?us-ascii?Q?d6RJEILNc1w69mTdCfz8BlAqF8++9X1Z0Wr/jvr6JeiX9gk8PiGd2aaXOxRX?=
 =?us-ascii?Q?QumUt6jC/cUjwMC2mXagqAG3pjme3zwqGPGFqbgW3NlV0nur78rv8hb+sQXu?=
 =?us-ascii?Q?BS3Ob1XkFR6sDnWX+ILKmnqZMwINC9F1glEZFfNVxqCVbOVS7a5EV5/E2Jan?=
 =?us-ascii?Q?cazT9z9k2F1awqGFwMbjYKbOqP9owVmLL9j3tCcO0T37YDjuET28o1OCK71b?=
 =?us-ascii?Q?RKqaCnWg/18Nr6POctAaVTC00Pz8Pgk4MAt4pyDhkd3lCRinTTBw9CsAmpJG?=
 =?us-ascii?Q?SG8OjUMYjAlSxcv8PVS1NXqYW7+jtVFtcou+HtIBx/FX1bRy7jci4jinHOFg?=
 =?us-ascii?Q?p2tvJi7dvrM612kkou0oe+J0igxAQV57e48fP7ZLDL5/B3eE66EUJhB87agu?=
 =?us-ascii?Q?Nrmq+jYh4fOVtfuF8L8Q3lzLh1YONtxoRL3paCDP8+5lnDiL+TSeVpBtIr6o?=
 =?us-ascii?Q?EiWTZvF+H9NAgwHJiHbPTMt9nA5UtVpfjY/4PCBXbbEWkFW0vd8ZK2QXRnqy?=
 =?us-ascii?Q?oKyD5Wi8ngAeTUjsapIhiHdzQY8Ift4MKHTCKIro768b41frwWbWiFcU4//Q?=
 =?us-ascii?Q?G0lO3IDuRfnrHLjajjm/APMJDfQlKw4fAVq4vspDDILFo4dxM8K3FvYlKc6b?=
 =?us-ascii?Q?z4oaYokR/+BFwHoFqWBQoafk945rewpwM7lEneKviJ1lLPN/uyA16XCoO5y0?=
 =?us-ascii?Q?/AY5/5ze6u6eULwjdxrORjabu9ynCS95iMbaxJIWyukfRWpvTMH1t+bm3QXc?=
 =?us-ascii?Q?CAgiVwPf7IvqKickLGoIUfMqqRstHNuJo0ewLFc9cFdOzzhpDTAVm3F9Tv3y?=
 =?us-ascii?Q?B+eWBPLuSSHnJ8RUaV05ZMH3B4zoeSGwOnrGDpOsoAob/9Kqiir1+6sxm3Ty?=
 =?us-ascii?Q?1fip6iIsbZorMeZCgyg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 13:38:53.1629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b7e91a-b28f-4dfc-3dcb-08de37f17596
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288
Received-SPF: softfail client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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

From: Nicolin Chen <nicolinc@nvidia.com>

Tegra241 CMDQV assigns each VINTF a 128KB MMIO region split into two
64 KB pages:
 - Page0: guest accessible control/status registers for all VCMDQs
 - Page1: configuration registers (queue GPA/size) that must be trapped
          by the VMM and translated before programming the HW queue.

This patch implements the Page0 handling in QEMU. Using the vintf offset
returned by IOMMUFD during VIOMMU allocation, QEMU maps Page0 into
guest physical address space and exposes it via two guest MMIO windows:
 - 0x10000 :VCMDQ register
 - 0x30000 :VINTF register

The mapping is lazily initialized on first read/write.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 60 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.h |  5 ++++
 2 files changed, 65 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 899325877e..d8858322dc 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -13,14 +13,74 @@
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
 
+static bool tegra241_cmdqv_init_vcmdq_page0(Tegra241CMDQV *cmdqv, Error **errp)
+{
+    SMMUv3State *smmu = cmdqv->smmu;
+    SMMUv3AccelState *s_accel = smmu->s_accel;
+    IOMMUFDViommu *viommu;
+    char *name;
+
+    if (!s_accel) {
+        return true;
+    }
+
+    viommu = &s_accel->viommu;
+    if (!iommufd_backend_viommu_mmap(viommu->iommufd, viommu->viommu_id,
+                                     VCMDQ_REG_PAGE_SIZE,
+                                     cmdqv->cmdqv_data.out_vintf_mmap_offset,
+                                     &cmdqv->vcmdq_page0, errp)) {
+        cmdqv->vcmdq_page0 = NULL;
+        return false;
+    }
+
+    name = g_strdup_printf("%s vcmdq", memory_region_name(&cmdqv->mmio_cmdqv));
+    memory_region_init_ram_device_ptr(&cmdqv->mmio_vcmdq_page,
+                                      memory_region_owner(&cmdqv->mmio_cmdqv),
+                                      name, 0x10000, cmdqv->vcmdq_page0);
+    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv, 0x10000,
+                                        &cmdqv->mmio_vcmdq_page, 1);
+    g_free(name);
+
+    name = g_strdup_printf("%s vintf", memory_region_name(&cmdqv->mmio_cmdqv));
+    memory_region_init_ram_device_ptr(&cmdqv->mmio_vintf_page,
+                                      memory_region_owner(&cmdqv->mmio_cmdqv),
+                                      name, 0x10000, cmdqv->vcmdq_page0);
+    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv, 0x30000,
+                                        &cmdqv->mmio_vintf_page, 1);
+    g_free(name);
+
+    return true;
+}
+
 static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
 {
+    Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
+    Error *local_err = NULL;
+
+    if (!cmdqv->vcmdq_page0) {
+        tegra241_cmdqv_init_vcmdq_page0(cmdqv, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            local_err = NULL;
+        }
+    }
+
     return 0;
 }
 
 static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
                                  unsigned size)
 {
+    Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
+    Error *local_err = NULL;
+
+    if (!cmdqv->vcmdq_page0) {
+        tegra241_cmdqv_init_vcmdq_page0(cmdqv, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            local_err = NULL;
+        }
+    }
 }
 
 static const MemoryRegionOps mmio_cmdqv_ops = {
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 9bc72b24d9..ccdf0651be 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -19,8 +19,13 @@ typedef struct Tegra241CMDQV {
     SMMUv3State *smmu;
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
+    MemoryRegion mmio_vcmdq_page;
+    MemoryRegion mmio_vintf_page;
+    void *vcmdq_page0;
 } Tegra241CMDQV;
 
+#define VCMDQ_REG_PAGE_SIZE 0x10000
+
 #ifdef CONFIG_TEGRA241_CMDQV
 bool tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                                  uint32_t *out_viommu_id, Error **errp);
-- 
2.43.0


