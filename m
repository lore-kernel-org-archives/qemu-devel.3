Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF79CFC592E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYzl-0006oG-6d; Thu, 26 Feb 2026 05:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzk-0006np-00; Thu, 26 Feb 2026 05:53:24 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzi-0000y8-Gd; Thu, 26 Feb 2026 05:53:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyosYdo3u1OeSgImdFZCFw8uxedjc3esZUc+f6DmumFUSIyfw3FBi90toTfdI/gJ2Uy2FpYBTzwSdDO2flhX19K8VoBwLtqTXjeYPF6DQJEEPznN0zlZf3S+RhqEPLOc4CVl4fLLH1WUQmyCTBVVZumtbsaS3+kZCywOpzabSNwJdMWZMV0MuFGrl40UY7WddNBacQTgwDbTNKfhkwMFG0fwS8RrETF9eSHKEKjjciu8Huc8B66bOgV/RfgZ/uy/6bTyXY1j3vED0kWKzybqBGJZiLR/KSEOWILEdPhPq09i89yEjuT800OmmWgLD8QRnsNsUILtSDC4z3qZzODnsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnHD6DePx9K2xfmOF+WUFcjlE4yDF+Zs0AZtOxp0q4w=;
 b=njTX/eEdZLeYmQuy+z0yWTyY25Dsfaq+7p6ZPAnseu+D8A+bV+OqeAEMFEd5+Aud62DojV5uWlVBmzKidG1UY1WfGI3rwYmauW4V+O21IfyqYJsj/AlWzoIO4KDb55IFj5ujh0Ao961y+ZqSOFwJPdLdUHZF3ck9B4XCSzzUYR6P8Y8NyXI1zcWheNzTbdZdEzsQxGpn39cn+7vxO7MtHCDTFD1vIH2u20K82DAypEKu3re/tseNWakhMw66sdzI/Xg4uWHmuxxCQGBX6cbtiwyxm2K1QSCl63RGpVZGdBNAsBaP5EsCW6y5SrHmFjHM42NB1MnztGGIec48W4WEFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnHD6DePx9K2xfmOF+WUFcjlE4yDF+Zs0AZtOxp0q4w=;
 b=kcX9Tj6qKo6GtkarblQjmM8HdRLhc6sHa2f//SbZkPcBowXluih9QCEpSRS20VNgUP20qPH6jenmdmLFuaJXVpwAque8Nr1wDz6exab0+WzuPNfnZjQp24HII+MUZfGUYGdKDfQOwaROUyex+rei/t8LSYrjLtZ3PC+WOKkUAYzVMotPRMw5KBdH7GK5zRWQPpd0yCljzYea94aPkx6cRiMxvf65AFcsyd2IMPr8iSVvWHxBNAN1TyxKlbMt4j6EZ/nLmu1INnqNG+NpcsbFS3vf5lXJZc5CNSYlbfngmXYl56s8h4+2JGNEOV1Diy0dy/p/wPjBnAkSSiYpGMGh9g==
Received: from SA9P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::28)
 by SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 10:53:17 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::3e) by SA9P223CA0023.outlook.office365.com
 (2603:10b6:806:26::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 10:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:53:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:52 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:49 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 22/32] hw/arm/tegra241-cmdqv: Add vEVENTQ allocation and
 free
Date: Thu, 26 Feb 2026 10:50:46 +0000
Message-ID: <20260226105056.897-23-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226105056.897-1-skolothumtho@nvidia.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SJ1PR12MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: d23282cd-5184-497d-1b81-08de75253ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: UysgAP8ysrxodLH4elUpIip3pxleDhbSZWly50wNl3fib1jp3VN4MAjhNUVrtz1IIV9LDF+6pvcnrpC4Hu3G2d4z6jjLhsijS/wl5or5oG9MeUOzKFUMfr8ZuOm9eqhQwlV6YurGia6tgDoOmwr/Eyiv2p5exGOmwyeeHpIpfN5KZaQUcCFo7XDP6xf2BkSmYVHjticvoYhtRKDVu1pvWD3TomUuyQu45g8wDn06cCbOkUjRMTr5/Wc34OR9KA6jAIDXS7cRoQNcAhZXvTJ2E+i/qgD2H5folfacbHPaWpWEMrGZq30bPckfDZWSaz4e392zoLf9IIsHanYReyvVmZpkYn01vHeUth7vdoC0oYbEOez7nCVAG/4G+RZxPgwMQFwfVWNdOGkze7+RZeo2pYKdn7HH8OF45QPB996je0Xw+Y3x9FgOgCAAhmiFqrkymen5A+WqgAE6G76hrZRgQjjIi48bM4yG6nZVLdZWiSAciiLOtW2xyzwhoiP83qwgTidRfVZFErTJ0JqjZISa2cG+0KOjaVmbE+exFZ5Y7mMRqbW35LslkwK2i6bbLi5q7360d+Gr4DxPpmJaYfV9Klc3KI6g6LF5OTc9F3wCpVt4B45XMdWVVuoFaqJsXOfDVr+d1i1lmRRrub+wB1OtOYSCxhyMxcdkaNUjnyQBSjtRZ3CLRntvjP5EkxMNclx54jY+Jzfu1KjAIxAKDmjMIxV25g8pycnn3skueRcj3+mny5rYXrHEk73HE9WrxY055RbipWplqajoOpyuVodP2SXPgdRDQMIGMzC8Tg+Lljc5gcxfuDv4tTp8VljoBdR6Seo6VbdAdcX9NNjMYvDtQg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TP8u2JJsUc7PPQEankZZNaCdnixe0YHbBxGUymM/VGIHbVELAfUr2G959EoegTp7HI9sCf0rfpSs3S6atIAcwIGWHv47zafTartAYWB8didK4PlQ8uVFV0g6inguuz/XCmHS7ook+DjwRGzJRAm5b9skJgkON+0gyKXen01KWoxIiqJgZknGO0KRZ4/vz5kxYddPGJPOJVsYfYFHiLQ0/bGo/ATBVEkh70xiKViTuJ4h+J30CvtC0/1sxfeWElQ53vY6Emn37lsPmjYPdLF5npcTep76oM5x0g/yRRhHk9KatAM36pqK9kDVjZJOzJD9dA9DUn3Y1YXIJIQto13MD/kdkZt59KeFgGJOrrbDvhvwsQq8UhyRdhJZC0FsTI26n7f9eJL56OXXBMmGuSZ9h+alYdxsr37kbRD5R+7q+gPxEAMnl38weZXe1JqffwMU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:53:15.8966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d23282cd-5184-497d-1b81-08de75253ed8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6124
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

Allocate a CMDQV specific vEVENTQ via IOMMUFD, and add the
corresponding teardown path to free the vEVENTQ during cleanup.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h   |  2 ++
 hw/arm/tegra241-cmdqv.h |  1 +
 hw/arm/smmuv3-accel.c   | 10 ++++++++-
 hw/arm/tegra241-cmdqv.c | 47 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 7d6e4c6b76..4bff90e2c1 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -28,6 +28,8 @@ typedef struct SMMUv3AccelCmdqvOps {
                          uint32_t *out_viommu_id,
                          Error **errp);
     void (*free_viommu)(SMMUv3State *s);
+    bool (*alloc_veventq)(SMMUv3State *s,  Error **errp);
+    void (*free_veventq)(SMMUv3State *s);
     void (*reset)(SMMUv3State *s);
 } SMMUv3AccelCmdqvOps;
 
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 914977c2ef..01d446474a 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -37,6 +37,7 @@ typedef struct Tegra241CMDQV {
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
     IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
+    IOMMUFDVeventq *veventq;
     void *vintf_page0;
     MemoryRegion *mr_vintf_page0;
 
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 4373bbd97b..f6602f51aa 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -576,13 +576,21 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
         goto free_bypass_hwpt;
     }
 
+    if (cmdqv_ops && !cmdqv_ops->alloc_veventq(s, errp)) {
+        goto free_veventq;
+    }
+
     /* Attach a HWPT based on SMMUv3 GBPA.ABORT value */
     hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
     if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
-        goto free_veventq;
+        goto free_cmdqv_veventq;
     }
     return true;
 
+free_cmdqv_veventq:
+    if (cmdqv_ops && cmdqv_ops->free_veventq) {
+        cmdqv_ops->free_veventq(s);
+    }
 free_veventq:
     smmuv3_accel_free_veventq(accel);
 free_bypass_hwpt:
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index ce144add54..8cde459b4f 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -487,6 +487,51 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
     }
 }
 
+static void tegra241_cmdqv_free_veventq(SMMUv3State *s)
+{
+    SMMUv3AccelState *accel = s->s_accel;
+    Tegra241CMDQV *cmdqv = accel->cmdqv;
+    IOMMUFDVeventq *veventq = cmdqv->veventq;
+
+    if (!veventq) {
+        return;
+    }
+    close(veventq->veventq_fd);
+    iommufd_backend_free_id(veventq->viommu->iommufd, veventq->veventq_id);
+    g_free(veventq);
+    cmdqv->veventq = NULL;
+}
+
+static bool tegra241_cmdqv_alloc_veventq(SMMUv3State *s, Error **errp)
+{
+    SMMUv3AccelState *accel = s->s_accel;
+    IOMMUFDViommu *viommu = accel->viommu;
+    Tegra241CMDQV *cmdqv = accel->cmdqv;
+    IOMMUFDVeventq *veventq;
+    uint32_t veventq_id;
+    uint32_t veventq_fd;
+
+    if (cmdqv->veventq) {
+        return true;
+    }
+
+    if (!iommufd_backend_alloc_veventq(viommu->iommufd, viommu->viommu_id,
+                                       IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
+                                       1 << 16, &veventq_id, &veventq_fd,
+                                       errp)) {
+        error_append_hint(errp, "Tegra241 CMDQV: failed to alloc veventq");
+        return false;
+    }
+
+    veventq = g_new(IOMMUFDVeventq, 1);
+    veventq->veventq_id = veventq_id;
+    veventq->veventq_fd = veventq_fd;
+    veventq->viommu = accel->viommu;
+    cmdqv->veventq = veventq;
+
+    return true;
+}
+
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
 {
     SMMUv3AccelState *accel = s->s_accel;
@@ -580,6 +625,8 @@ static const SMMUv3AccelCmdqvOps tegra241_cmdqv_ops = {
     .init = tegra241_cmdqv_init,
     .alloc_viommu = tegra241_cmdqv_alloc_viommu,
     .free_viommu = tegra241_cmdqv_free_viommu,
+    .alloc_veventq = tegra241_cmdqv_alloc_veventq,
+    .free_veventq = tegra241_cmdqv_free_veventq,
     .reset = tegra241_cmdqv_reset,
 };
 
-- 
2.43.0


