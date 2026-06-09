Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE42CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudL-0008Aj-Sv; Tue, 09 Jun 2026 07:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWucm-0006nG-7l; Tue, 09 Jun 2026 07:28:04 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWucj-00032k-07; Tue, 09 Jun 2026 07:28:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1Bmfhd/Z/tiAkUYEIPk3ye0WRvB0MjZ0lJV96DcQmZmyjHHHdv1zsaPGS/C25b9tW+05RzJV31wLkNP32ddBVffdNGw+bv+WV4j9s1YeIL3pLV7/KmuBrqDyCuL/g36gjWnmbxm6kc6E9WLwi3Wvbr610EDvo7R/46NRquXRzoTp1O7aVGp8S7ahMQj3TBk25zoc8QU/HCyXE5JZ/0bYc1AGTiJKKGXz1mtmuF1fH4NC83MQCo42hzNorra+2n7hvse5DYMT5Mlh5BZCc/L8GXGfjFVkP/yPWyoQ0Kx+Lg6dRHsAKEjjG5zmqSfsJyUwwhPm6oHuxxoAV4SMlcJig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1IGPLir0EEU+TKaOvGI8u6udx/FZiJVCXJ0ID1xFNA=;
 b=mfhWWd6sDWQfXr5aLGW08P9YduMdlIvQTC1Hd3D2vOiOWHT0E8s2RFpMYpiWfbVW5ra2Vw6cD07kv06L+9Xw13ChITqbTYdogOBAJ4UbKs0aFApFV/3n0A93va8wYhAatJyzdN+r2QIGVduRzsXgjD9gSMISlEFoGZM8wPg5PjaLHTW/eMcE0BFl6ARFxjpGYGwsewFVCHYucBDWyA4b5gliLtdQ0iZILW3c0r+93/HHGKhuiRFisbNThK0D9/bpPQY09WEmscjW558c1UxPlTkAwf71z68th9/WI/MoQWimwJjRfoAyL+EMfnjyGtYj+KfWFqWuAEmboJcy9E5M/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1IGPLir0EEU+TKaOvGI8u6udx/FZiJVCXJ0ID1xFNA=;
 b=bDE1T+cch5LeT3vkXvn062ThPhWLGOzofrAhebOSVPzFLswf873ffk3ZaZTznQrX7HYKAbFxW715iql88YJFXF6BopbceN8E81GVPphYFJmUY7u2Qij/OhKw53Wq/h4a0lWesww8sJQSimcAG7ZULee5x0GX3Tk0VIOGfeKUQfAIswNCcA6f7GV3wGjwcEaik6+MrDK6gKlxXWCAJ7e5INPUmmZnnNDVuCjZoPcIhskvMqHuLE4iggyhDTxwBZ5tijnOlNAyfCNZ0tNyVYG4jYG7fPxBbVMvbwTLNekMDbOGf1OhzMTzj2bUMI1QQewmLYxQ56ykINtQlhP8fc1Rsw==
Received: from BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::17)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 11:27:53 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::8a) by BY1P220CA0026.outlook.office365.com
 (2603:10b6:a03:5c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Tue, 9
 Jun 2026 11:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:27:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:37 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:33 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 14/31] hw/arm/tegra241-cmdqv: mmap host VINTF Page0 for
 CMDQV
Date: Tue, 9 Jun 2026 12:25:35 +0100
Message-ID: <20260609112552.378999-15-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609112552.378999-1-skolothumtho@nvidia.com>
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f7e975-95fe-4b18-d347-08dec61a2589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lOrJeDop+J3Km43Vw3OCPDwVYVZvZs6LPcgKNrySZfH/iaPyzl0NlV8jPXlWEMWgH4LRmcSdLh7nPC7RqdfkOqCwME/lpmjPjg9t/w5hxzS3KF9E1DlMqoO/zhxxKS3ivy/ASA2dhL4HpkAjvtrlJQ/vfVT/DuFjaGhxXwztFh/6m1piiQjNVlLmDxie6F7HgfaHRITEdVf+cDSVqkJ5g374wX2qbJxyFc2F6zMGTL1Ecn7TnBGhoD3us7wbAUt4mZdSYeZh5mpehwl/fX3nGiO1d+HO8ke9G9JOkRFiCRlf5EnbQ1WTjHtCc6q6Q8lOOOeOdqZfzO1E1VcuyfSwhhB/OjqWUrbNb1B0Yd1ynvUw3nJExiFD3Hl7RLVLhxk/nJeEZK1duco09HNw4+74pNdLNQzlijNTnK2fy6mKFDu8+HZNEIAc5Rsid+zy6xcNC3bBN2nz/DdbNQtNVIU/LosZf3hysDqj9y1CooWyci4JpUYPghYe+KRwdRkbFsU56lAsC95QI7AOTB/nMuZpegcO7VWo9oexdOti8o//oqq0k2OdDqjvSSa1nIWbnjr+IiVPaWRD3UuKr0xtx0+P8WonJ6sPyWn0vf0FZS1UCTE/olA2dL7lAWqVETYmXjGKoS0i+BlQuV6CDHRKx5aq2c8pvQVZ2HgBoUdFwxnzS6KeXBYtOzrlXlKirlykEm5H9IDyw6wLqQHBxGjFrnHMlmNxLbFT9M5B54r1xW8tAuw=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jt8H893IKtThLdZmQOWiPt4SgaSk6ajkRGuYOBKlhapOHcxU8i8Jduvq0rq1PhvX7R6rURs5A3WnomYNH5KR1IaKG3LIiuZ6ShcBf43JheJMJlEISmZ/nesjMz9prJ2s0K2MILpjELUgHAS7EB3s+kbJBqCCao3jo1P27vNfCV1rgD0wYIcnvBEKhwvTQm4Kz9vA/fGxeGCnnWYOXgdZVCx+asdGrNZjxj8A1weEiNEVDtNRFfFqORcWQ/Rnwt5W4omZlWCn4mhtuizc5WretHVMAWN7vAMQDBggHh3JnbXSJXnUO4QkYO0rByrFea0F3TudeIle3Ub+pZOwpopsIAtCXdoL3gp4F+HA9Gdcq7qcrTqU1m7ce0dsUJvAalGpI3TtixiUZevYVYghBAnFpFijGvvtLgMUnRY6I+1bPxc1uZY2GHZahgQsx+wgn11I
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:27:53.3020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f7e975-95fe-4b18-d347-08dec61a2589
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Nicolin Chen <nicolinc@nvidia.com>

The kernel currently exposes a single VINTF per emulated SMMUv3
instance. IOMMU_VIOMMU_ALLOC returns an mmap offset for the host
VINTF Page0 allocated for this SMMU. However, VCMDQs only become
bound to that VINTF after IOMMU_HW_QUEUE_ALLOC, so until then the
mapped Page0 does not back any real VCMDQ state.

mmap the host VINTF Page0 right after IOMMU_VIOMMU_ALLOC, as the host
VINTF is already enabled at that point, and unmap it when the vIOMMU is
freed. The mapping shares the vIOMMU's lifetime. This prepares the VINTF
mapping in advance of subsequent patches that add VCMDQ allocation.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  3 +++
 hw/arm/tegra241-cmdqv.c | 16 +++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 9fc720e96c..00c83b6186 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -25,6 +25,8 @@
  */
 #define TEGRA241_CMDQV_IO_LEN 0x50000
 
+#define VINTF_PAGE_SIZE 0x10000
+
 struct iommu_viommu_tegra241_cmdqv;
 
 typedef struct Tegra241CMDQV {
@@ -33,6 +35,7 @@ typedef struct Tegra241CMDQV {
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
     IOMMUFDVeventq *veventq;
+    void *vintf_page0;
 } Tegra241CMDQV;
 
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index c1351c8519..3eec6073a4 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -41,6 +41,10 @@ static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
         g_free(veventq);
         cmdqv->veventq = NULL;
     }
+    if (cmdqv->vintf_page0) {
+        munmap(cmdqv->vintf_page0, VINTF_PAGE_SIZE);
+        cmdqv->vintf_page0 = NULL;
+    }
     iommufd_backend_free_id(viommu->iommufd, viommu->viommu_id);
 }
 
@@ -60,13 +64,20 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
         return false;
     }
 
+    if (!iommufd_backend_viommu_mmap(idev->iommufd, viommu_id, VINTF_PAGE_SIZE,
+                                     cmdqv->cmdqv_data->out_vintf_mmap_offset,
+                                     &cmdqv->vintf_page0, errp)) {
+        error_append_hint(errp, "Tegra241 CMDQV: failed to mmap VINTF page0");
+        goto free_viommu;
+    }
+
     if (!iommufd_backend_alloc_veventq(idev->iommufd, viommu_id,
                                        IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
                                        1 << SMMU_EVENTQS, &veventq_id,
                                        &veventq_fd,
                                        errp)) {
         error_append_hint(errp, "Tegra241 CMDQV: failed to alloc veventq");
-        goto free_viommu;
+        goto munmap_page0;
     }
 
     veventq = g_new(IOMMUFDVeventq, 1);
@@ -77,6 +88,9 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     *out_viommu_id = viommu_id;
     return true;
 
+munmap_page0:
+    munmap(cmdqv->vintf_page0, VINTF_PAGE_SIZE);
+    cmdqv->vintf_page0 = NULL;
 free_viommu:
     iommufd_backend_free_id(idev->iommufd, viommu_id);
     return false;
-- 
2.43.0


